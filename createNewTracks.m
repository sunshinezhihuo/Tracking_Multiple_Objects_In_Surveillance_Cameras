function createNewTracks(centroids, unassignedDetections, bboxes,nextId)
        centroids = centroids(unassignedDetections, :);
        bboxes = bboxes(unassignedDetections, :);
    global obj;
    global tracks;
        for i = 1:size(centroids, 1)

            centroid = centroids(i,:);
            bbox = bboxes(i, :);

            % Create a Kalman filter object.
%             kalmanFilter = configureKalmanFilter('ConstantVelocity', ...
%                 centroid, [200, 50], [100, 25], 100);
           particleFilter= robotics.ParticleFilter;
           initialize(particleFilter,1000,centroids,eye(2));
           particleFilter.StateEstimationMethod = 'mean';
            particleFilter.ResamplingMethod = 'systematic';
            % Create a new track.
%             newTrack = struct(...
%                 'id', nextId, ...
%                 'bbox', bbox, ...
%                 'kalmanFilter', kalmanFilter, ...
%                 'age', 1, ...
%                 'totalVisibleCount', 1, ...
%                 'consecutiveInvisibleCount', 0);
            newTrack = struct(...
                'id', nextId, ...
                'bbox', bbox, ...
                'particleFilter', particleFilter, ...
                'age', 1, ...
                'totalVisibleCount', 1, ...
                'consecutiveInvisibleCount', 0);
            % Add it to the array of tracks.
            tracks(end + 1) = newTrack;

            % Increment the next id.
            nextId = nextId + 1;
        end
    end