From: alexandru-cosmin.gheorghe@arm.com (Alexandru Gheorghe)
Date: Thu, 26 Jul 2018 17:17:50 +0100
Subject: [PATCH v2 04/10] drm: atmel-hlcdc: Use
 __drm_atomic_helper_plane_reset instead of copying the logic
In-Reply-To: <20180726161756.1794-1-alexandru-cosmin.gheorghe@arm.com>
References: <20180726161756.1794-1-alexandru-cosmin.gheorghe@arm.com>
Message-ID: <20180726161756.1794-5-alexandru-cosmin.gheorghe@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A new helper function(__drm_atomic_helper_plane_reset) has been added
for linking a plane with its state and resetting the core
properties(alpha, rotation, etc.) to their default values.
Use that instead of duplicating the logic.

__drm_atomic_helper_plane_reset initializes the alpha property to its
max value, which is defined by the drm core as DRM_BLEND_ALPHA_OPAQUE,
so nothing changes regarding the alpha value.

Acked-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Alexandru Gheorghe <alexandru-cosmin.gheorghe@arm.com>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
index 04440064b9b7..9330a076e15a 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
@@ -942,10 +942,7 @@ static void atmel_hlcdc_plane_reset(struct drm_plane *p)
 				"Failed to allocate initial plane state\n");
 			return;
 		}
-
-		p->state = &state->base;
-		p->state->alpha = DRM_BLEND_ALPHA_OPAQUE;
-		p->state->plane = p;
+		__drm_atomic_helper_plane_reset(p, &state->base);
 	}
 }
 
-- 
2.18.0
