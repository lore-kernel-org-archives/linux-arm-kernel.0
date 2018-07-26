From: alexandru-cosmin.gheorghe@arm.com (Alexandru Gheorghe)
Date: Thu, 26 Jul 2018 17:17:52 +0100
Subject: [PATCH v2 06/10] drm/imx: Use __drm_atomic_helper_plane_reset instead
 of copying the logic
In-Reply-To: <20180726161756.1794-1-alexandru-cosmin.gheorghe@arm.com>
References: <20180726161756.1794-1-alexandru-cosmin.gheorghe@arm.com>
Message-ID: <20180726161756.1794-7-alexandru-cosmin.gheorghe@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A new helper function(__drm_atomic_helper_plane_reset) has been added
for linking a plane with its state and resetting the core
properties(alpha, rotation, etc.) to their default values.
Use that instead of duplicating the logic.

Signed-off-by: Alexandru Gheorghe <alexandru-cosmin.gheorghe@arm.com>
---
 drivers/gpu/drm/imx/ipuv3-plane.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/imx/ipuv3-plane.c b/drivers/gpu/drm/imx/ipuv3-plane.c
index 203f247d4854..1bd4de03ce9e 100644
--- a/drivers/gpu/drm/imx/ipuv3-plane.c
+++ b/drivers/gpu/drm/imx/ipuv3-plane.c
@@ -281,16 +281,14 @@ static void ipu_plane_state_reset(struct drm_plane *plane)
 		ipu_state = to_ipu_plane_state(plane->state);
 		__drm_atomic_helper_plane_destroy_state(plane->state);
 		kfree(ipu_state);
+		plane->state = NULL;
 	}
 
 	ipu_state = kzalloc(sizeof(*ipu_state), GFP_KERNEL);
 
-	if (ipu_state) {
-		ipu_state->base.plane = plane;
-		ipu_state->base.rotation = DRM_MODE_ROTATE_0;
-	}
+	if (ipu_state)
+		__drm_atomic_helper_plane_reset(plane, &ipu_state->base);
 
-	plane->state = &ipu_state->base;
 }
 
 static struct drm_plane_state *
-- 
2.18.0
