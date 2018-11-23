From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Fri, 23 Nov 2018 10:24:46 +0100
Subject: [PATCH v2 14/43] drm/sun4i: backend: Avoid counting YUV planes that
 use the frontend
In-Reply-To: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
References: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
Message-ID: <20181123092515.2511-15-paul.kocialkowski@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Our hardware has a limited number of YUV planes (usually 1) that can be
supported using the backend only. However, YUV planes can also be
supported by the frontend and must then not be counted when checking for
that limitation.

Only count the YUV plane when the frontend is not used.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun4i_backend.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
index 30d7bc76c0af..a39d8b75d76a 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
@@ -543,6 +543,11 @@ static int sun4i_backend_atomic_check(struct sunxi_engine *engine,
 			DRM_DEBUG_DRIVER("Using the frontend for plane %d\n",
 					 plane->index);
 			num_frontend_planes++;
+		} else {
+			if (fb->format->is_yuv) {
+				DRM_DEBUG_DRIVER("Plane FB format is YUV\n");
+				num_yuv_planes++;
+			}
 		}
 
 		DRM_DEBUG_DRIVER("Plane FB format is %s\n",
@@ -551,11 +556,6 @@ static int sun4i_backend_atomic_check(struct sunxi_engine *engine,
 		if (fb->format->has_alpha || (plane_state->alpha != DRM_BLEND_ALPHA_OPAQUE))
 			num_alpha_planes++;
 
-		if (fb->format->is_yuv) {
-			DRM_DEBUG_DRIVER("Plane FB format is YUV\n");
-			num_yuv_planes++;
-		}
-
 		DRM_DEBUG_DRIVER("Plane zpos is %d\n",
 				 plane_state->normalized_zpos);
 
-- 
2.19.1
