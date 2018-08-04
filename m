From: alexandru-cosmin.gheorghe@arm.com (Alexandru Gheorghe)
Date: Sat,  4 Aug 2018 17:15:30 +0100
Subject: [PATCH v3 10/10] drm/vmwgfx: Use __drm_atomic_helper_plane_reset
 instead of copying the logic
In-Reply-To: <20180804161530.12275-1-alexandru-cosmin.gheorghe@arm.com>
References: <20180804161530.12275-1-alexandru-cosmin.gheorghe@arm.com>
Message-ID: <20180804161530.12275-11-alexandru-cosmin.gheorghe@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A new helper function(__drm_atomic_helper_plane_reset) has been added
for linking a plane with its state and resetting the core
properties(alpha, rotation, etc.) to their default values.
Use that instead of duplicating the logic.

Reviewed-by: Sinclair Yeh <syeh@vmware.com>
Reviewed-by: Deepak Rawat <drawat@vmware.com>
Signed-off-by: Alexandru Gheorghe <alexandru-cosmin.gheorghe@arm.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
index 4a0f0f41afa1..61824e360619 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
@@ -720,9 +720,7 @@ void vmw_du_plane_reset(struct drm_plane *plane)
 		return;
 	}
 
-	plane->state = &vps->base;
-	plane->state->plane = plane;
-	plane->state->rotation = DRM_MODE_ROTATE_0;
+	__drm_atomic_helper_plane_reset(plane, &vps->base);
 }
 
 
-- 
2.18.0
