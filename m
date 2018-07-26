From: alexandru-cosmin.gheorghe@arm.com (Alexandru Gheorghe)
Date: Thu, 26 Jul 2018 17:17:48 +0100
Subject: [PATCH v2 02/10] drm/amd/display: Use __drm_atomic_helper_plane_reset
 instead of copying the logic
In-Reply-To: <20180726161756.1794-1-alexandru-cosmin.gheorghe@arm.com>
References: <20180726161756.1794-1-alexandru-cosmin.gheorghe@arm.com>
Message-ID: <20180726161756.1794-3-alexandru-cosmin.gheorghe@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A new helper function(__drm_atomic_helper_plane_reset) has been added
for linking a plane with its state and resetting the core
properties(alpha, rotation, etc) to their default values.
Use that instead of duplicating the logic.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alexandru Gheorghe <alexandru-cosmin.gheorghe@arm.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index ae09331eed00..8e4978d5b83f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2965,11 +2965,8 @@ static void dm_drm_plane_reset(struct drm_plane *plane)
 	amdgpu_state = kzalloc(sizeof(*amdgpu_state), GFP_KERNEL);
 	WARN_ON(amdgpu_state == NULL);
 	
-	if (amdgpu_state) {
-		plane->state = &amdgpu_state->base;
-		plane->state->plane = plane;
-		plane->state->rotation = DRM_MODE_ROTATE_0;
-	}
+	if (amdgpu_state)
+		__drm_atomic_helper_plane_reset(plane, &amdgpu_state->base);
 }
 
 static struct drm_plane_state *
-- 
2.18.0
