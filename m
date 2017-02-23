From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 23 Feb 2017 16:05:36 +0800
Subject: [PATCH 04/11] drm/sun4i: Move layers from sun4i_drv to sun4i_crtc
In-Reply-To: <20170223080543.6659-1-wens@csie.org>
References: <20170223080543.6659-1-wens@csie.org>
Message-ID: <20170223080543.6659-5-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch moves the sun4i_layers_init call from sun4i_drv_bind to
sun4i_crtc_init, and the layers pointer from struct sun4i_drv to
struct sun4i_crtc.

The layers are bound to a specific crtc, and they are not directly
used once initiated. They are used through their included drm_plane
structures.

Moving the layers into the crtc facilitates binding them to the crtc
explicitly, by setting the corresponding bit in their .possible_crtcs
fields right after the crtc is initialized. This is done in a later
patch.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/gpu/drm/sun4i/sun4i_crtc.c | 8 ++++++++
 drivers/gpu/drm/sun4i/sun4i_crtc.h | 1 +
 drivers/gpu/drm/sun4i/sun4i_drv.c  | 9 ---------
 drivers/gpu/drm/sun4i/sun4i_drv.h  | 2 --
 4 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_crtc.c b/drivers/gpu/drm/sun4i/sun4i_crtc.c
index de6f7da69746..1d01667fa45d 100644
--- a/drivers/gpu/drm/sun4i/sun4i_crtc.c
+++ b/drivers/gpu/drm/sun4i/sun4i_crtc.c
@@ -28,6 +28,7 @@
 #include "sun4i_backend.h"
 #include "sun4i_crtc.h"
 #include "sun4i_drv.h"
+#include "sun4i_layer.h"
 #include "sun4i_tcon.h"
 
 static void sun4i_crtc_atomic_begin(struct drm_crtc *crtc,
@@ -125,6 +126,13 @@ struct sun4i_crtc *sun4i_crtc_init(struct drm_device *drm)
 		return ERR_PTR(-ENOMEM);
 	scrtc->drv = drv;
 
+	/* Create our layers */
+	scrtc->layers = sun4i_layers_init(drm);
+	if (IS_ERR(scrtc->layers)) {
+		dev_err(drm->dev, "Couldn't create the planes\n");
+		return ERR_CAST(scrtc->layers);
+	}
+
 	ret = drm_crtc_init_with_planes(drm, &scrtc->crtc,
 					drv->primary,
 					NULL,
diff --git a/drivers/gpu/drm/sun4i/sun4i_crtc.h b/drivers/gpu/drm/sun4i/sun4i_crtc.h
index dec8ce4d9b25..0a888f73c983 100644
--- a/drivers/gpu/drm/sun4i/sun4i_crtc.h
+++ b/drivers/gpu/drm/sun4i/sun4i_crtc.h
@@ -18,6 +18,7 @@ struct sun4i_crtc {
 	struct drm_pending_vblank_event	*event;
 
 	struct sun4i_drv		*drv;
+	struct sun4i_layer		**layers;
 };
 
 static inline struct sun4i_crtc *drm_crtc_to_sun4i_crtc(struct drm_crtc *crtc)
diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
index fc6ef4066c59..87bc0951eba8 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
@@ -23,7 +23,6 @@
 #include "sun4i_crtc.h"
 #include "sun4i_drv.h"
 #include "sun4i_framebuffer.h"
-#include "sun4i_layer.h"
 #include "sun4i_tcon.h"
 
 static int sun4i_drv_enable_vblank(struct drm_device *drm, unsigned int pipe)
@@ -143,14 +142,6 @@ static int sun4i_drv_bind(struct device *dev)
 		goto cleanup_mode_config;
 	}
 
-	/* Create our layers */
-	drv->layers = sun4i_layers_init(drm);
-	if (IS_ERR(drv->layers)) {
-		dev_err(drm->dev, "Couldn't create the planes\n");
-		ret = PTR_ERR(drv->layers);
-		goto cleanup_mode_config;
-	}
-
 	/* Create our CRTC */
 	drv->crtc = sun4i_crtc_init(drm);
 	if (IS_ERR(drv->crtc)) {
diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.h b/drivers/gpu/drm/sun4i/sun4i_drv.h
index 597353eab728..e22ee536677e 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.h
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.h
@@ -23,8 +23,6 @@ struct sun4i_drv {
 
 	struct drm_plane	*primary;
 	struct drm_fbdev_cma	*fbdev;
-
-	struct sun4i_layer	**layers;
 };
 
 #endif /* _SUN4I_DRV_H_ */
-- 
2.11.0
