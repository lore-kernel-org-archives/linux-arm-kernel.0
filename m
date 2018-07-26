From: alexandru-cosmin.gheorghe@arm.com (Alexandru Gheorghe)
Date: Thu, 26 Jul 2018 17:17:54 +0100
Subject: [PATCH v2 08/10] drm/sun4i: Use __drm_atomic_helper_plane_reset
 instead of copying the logic
In-Reply-To: <20180726161756.1794-1-alexandru-cosmin.gheorghe@arm.com>
References: <20180726161756.1794-1-alexandru-cosmin.gheorghe@arm.com>
Message-ID: <20180726161756.1794-9-alexandru-cosmin.gheorghe@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A new helper function(__drm_atomic_helper_plane_reset) has been added
for linking a plane with its state and resetting the core
properties(alpha, rotation, etc.) to their default values.
Use that instead of duplicating the logic.

__drm_atomic_helper_plane_reset initializes the alpha property to its
max value, which is defined by the drm core as DRM_BLEND_ALPHA_OPAQUE,
so nothing changes regarding the alpha value.

Signed-off-by: Alexandru Gheorghe <alexandru-cosmin.gheorghe@arm.com>
---
 drivers/gpu/drm/sun4i/sun4i_layer.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_layer.c b/drivers/gpu/drm/sun4i/sun4i_layer.c
index 750ad24de1d7..78f77af8805a 100644
--- a/drivers/gpu/drm/sun4i/sun4i_layer.c
+++ b/drivers/gpu/drm/sun4i/sun4i_layer.c
@@ -35,9 +35,7 @@ static void sun4i_backend_layer_reset(struct drm_plane *plane)
 
 	state = kzalloc(sizeof(*state), GFP_KERNEL);
 	if (state) {
-		plane->state = &state->state;
-		plane->state->plane = plane;
-		plane->state->alpha = DRM_BLEND_ALPHA_OPAQUE;
+		__drm_atomic_helper_plane_reset(plane, &state->state);
 		plane->state->zpos = layer->id;
 	}
 }
-- 
2.18.0
