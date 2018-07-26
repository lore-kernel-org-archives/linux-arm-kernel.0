From: alexandru-cosmin.gheorghe@arm.com (Alexandru Gheorghe)
Date: Thu, 26 Jul 2018 17:17:55 +0100
Subject: [PATCH v2 09/10] drm/vc4: Use __drm_atomic_helper_plane_reset instead
 of copying the logic
In-Reply-To: <20180726161756.1794-1-alexandru-cosmin.gheorghe@arm.com>
References: <20180726161756.1794-1-alexandru-cosmin.gheorghe@arm.com>
Message-ID: <20180726161756.1794-10-alexandru-cosmin.gheorghe@arm.com>
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
 drivers/gpu/drm/vc4/vc4_plane.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_plane.c b/drivers/gpu/drm/vc4/vc4_plane.c
index 9d7a36f148cf..688ad9bb0f08 100644
--- a/drivers/gpu/drm/vc4/vc4_plane.c
+++ b/drivers/gpu/drm/vc4/vc4_plane.c
@@ -200,9 +200,7 @@ static void vc4_plane_reset(struct drm_plane *plane)
 	if (!vc4_state)
 		return;
 
-	plane->state = &vc4_state->base;
-	plane->state->alpha = DRM_BLEND_ALPHA_OPAQUE;
-	vc4_state->base.plane = plane;
+	__drm_atomic_helper_plane_reset(plane, &vc4_state->base);
 }
 
 static void vc4_dlist_write(struct vc4_plane_state *vc4_state, u32 val)
-- 
2.18.0
