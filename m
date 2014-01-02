From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 02 Jan 2014 21:28:19 +0000
Subject: [PATCH RFC 30/46] imx-drm: remove separate imx-fbdev
In-Reply-To: <20140102212528.GD7383@n2100.arm.linux.org.uk>
References: <20140102212528.GD7383@n2100.arm.linux.org.uk>
Message-ID: <E1VypoR-0007FW-4q@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we know when the components of the imx-drm subsystem will be
initialised, we can move the fbdev helper initialisation and teardown
into imx-drm-core.  This gives us the required ordering that DRM wants
in both driver load and unload methods.

We can also stop exporting the imx_drm_device_get() and
imx_drm_device_put() methods; nothing but the fbdev helper was making
use of these.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/staging/imx-drm/Makefile       |    1 -
 drivers/staging/imx-drm/imx-drm-core.c |   43 +++++++++++++-----
 drivers/staging/imx-drm/imx-drm.h      |    3 -
 drivers/staging/imx-drm/imx-fbdev.c    |   74 --------------------------------
 4 files changed, 31 insertions(+), 90 deletions(-)
 delete mode 100644 drivers/staging/imx-drm/imx-fbdev.c

diff --git a/drivers/staging/imx-drm/Makefile b/drivers/staging/imx-drm/Makefile
index 4677585b5ad5..5239f908ceec 100644
--- a/drivers/staging/imx-drm/Makefile
+++ b/drivers/staging/imx-drm/Makefile
@@ -6,7 +6,6 @@ obj-$(CONFIG_DRM_IMX) += imxdrm.o
 obj-$(CONFIG_DRM_IMX_PARALLEL_DISPLAY) += parallel-display.o
 obj-$(CONFIG_DRM_IMX_TVE) += imx-tve.o
 obj-$(CONFIG_DRM_IMX_LDB) += imx-ldb.o
-obj-$(CONFIG_DRM_IMX_FB_HELPER) += imx-fbdev.o
 obj-$(CONFIG_DRM_IMX_IPUV3_CORE) += ipu-v3/
 
 imx-ipuv3-crtc-objs  := ipuv3-crtc.o ipuv3-plane.o
diff --git a/drivers/staging/imx-drm/imx-drm-core.c b/drivers/staging/imx-drm/imx-drm-core.c
index d5bf4a4646a3..31bc8d9c49be 100644
--- a/drivers/staging/imx-drm/imx-drm-core.c
+++ b/drivers/staging/imx-drm/imx-drm-core.c
@@ -70,6 +70,10 @@ struct imx_drm_connector {
 	struct module				*owner;
 };
 
+static int legacyfb_depth = 16;
+module_param(legacyfb_depth, int, 0444);
+
+static void imx_drm_device_put(void);
 static struct imx_drm_device *__imx_drm_device(void);
 
 int imx_drm_crtc_id(struct imx_drm_crtc *crtc)
@@ -82,14 +86,21 @@ static void imx_drm_driver_lastclose(struct drm_device *drm)
 {
 	struct imx_drm_device *imxdrm = drm->dev_private;
 
+#if IS_ENABLED(CONFIG_DRM_IMX_FB_HELPER)
 	if (imxdrm->fbhelper)
 		drm_fbdev_cma_restore_mode(imxdrm->fbhelper);
+#endif
 }
 
 static int imx_drm_driver_unload(struct drm_device *drm)
 {
 	struct imx_drm_device *imxdrm = drm->dev_private;
 
+#if IS_ENABLED(CONFIG_DRM_IMX_FB_HELPER)
+	if (imxdrm->fbhelper)
+		drm_fbdev_cma_fini(imxdrm->fbhelper);
+#endif
+
 	component_unbind_all(drm->dev, drm);
 
 	imx_drm_device_put();
@@ -225,7 +236,7 @@ static struct imx_drm_device *__imx_drm_device(void)
 	return imx_drm_device;
 }
 
-struct drm_device *imx_drm_device_get(void)
+static struct drm_device *imx_drm_device_get(void)
 {
 	struct imx_drm_device *imxdrm = __imx_drm_device();
 	struct imx_drm_encoder *enc;
@@ -273,9 +284,8 @@ struct drm_device *imx_drm_device_get(void)
 	return NULL;
 
 }
-EXPORT_SYMBOL_GPL(imx_drm_device_get);
 
-void imx_drm_device_put(void)
+static void imx_drm_device_put(void)
 {
 	struct imx_drm_device *imxdrm = __imx_drm_device();
 	struct imx_drm_encoder *enc;
@@ -295,7 +305,6 @@ void imx_drm_device_put(void)
 
 	mutex_unlock(&imxdrm->mutex);
 }
-EXPORT_SYMBOL_GPL(imx_drm_device_put);
 
 static int drm_mode_group_reinit(struct drm_device *dev)
 {
@@ -449,6 +458,24 @@ static int imx_drm_driver_load(struct drm_device *drm, unsigned long flags)
 		}
 	}
 
+	/*
+	 * All components are now initialised, so setup the fb helper.
+	 * The fb helper takes copies of key hardware information, so the
+	 * crtcs/connectors/encoders must not change after this point.
+	 */
+#if IS_ENABLED(CONFIG_DRM_IMX_FB_HELPER)
+	if (legacyfb_depth != 16 && legacyfb_depth != 32) {
+		dev_warn(drm->dev, "Invalid legacyfb_depth.  Defaulting to 16bpp\n");
+		legacyfb_depth = 16;
+	}
+	imxdrm->fbhelper = drm_fbdev_cma_init(drm, legacyfb_depth,
+				drm->mode_config.num_crtc, 4);
+	if (IS_ERR(imxdrm->fbhelper)) {
+		ret = PTR_ERR(imxdrm->fbhelper);
+		imxdrm->fbhelper = NULL;
+		goto err_unbind;
+	}
+#endif
 	return 0;
 
 err_unbind:
@@ -766,14 +793,6 @@ int imx_drm_add_connector(struct drm_connector *connector,
 }
 EXPORT_SYMBOL_GPL(imx_drm_add_connector);
 
-void imx_drm_fb_helper_set(struct drm_fbdev_cma *fbdev_helper)
-{
-	struct imx_drm_device *imxdrm = __imx_drm_device();
-
-	imxdrm->fbhelper = fbdev_helper;
-}
-EXPORT_SYMBOL_GPL(imx_drm_fb_helper_set);
-
 /*
  * imx_drm_remove_connector - remove a connector
  */
diff --git a/drivers/staging/imx-drm/imx-drm.h b/drivers/staging/imx-drm/imx-drm.h
index e3ca0c6b6a39..d1fb1146240e 100644
--- a/drivers/staging/imx-drm/imx-drm.h
+++ b/drivers/staging/imx-drm/imx-drm.h
@@ -54,13 +54,10 @@ void imx_drm_mode_config_init(struct drm_device *drm);
 
 struct drm_gem_cma_object *imx_drm_fb_get_obj(struct drm_framebuffer *fb);
 
-struct drm_device *imx_drm_device_get(void);
-void imx_drm_device_put(void);
 int imx_drm_panel_format_pins(struct drm_encoder *encoder,
 		u32 interface_pix_fmt, int hsync_pin, int vsync_pin);
 int imx_drm_panel_format(struct drm_encoder *encoder,
 		u32 interface_pix_fmt);
-void imx_drm_fb_helper_set(struct drm_fbdev_cma *fbdev_helper);
 
 struct device_node;
 
diff --git a/drivers/staging/imx-drm/imx-fbdev.c b/drivers/staging/imx-drm/imx-fbdev.c
deleted file mode 100644
index 8331739c3d08..000000000000
--- a/drivers/staging/imx-drm/imx-fbdev.c
+++ /dev/null
@@ -1,74 +0,0 @@
-/*
- * i.MX drm driver
- *
- * Copyright (C) 2012 Sascha Hauer, Pengutronix
- *
- * Based on Samsung Exynos code
- *
- * Copyright (c) 2011 Samsung Electronics Co., Ltd.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version 2
- * of the License, or (at your option) any later version.
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- */
-#include <linux/module.h>
-#include <drm/drmP.h>
-#include <drm/drm_crtc.h>
-#include <drm/drm_crtc_helper.h>
-#include <drm/drm_fb_cma_helper.h>
-
-#include "imx-drm.h"
-
-#define MAX_CONNECTOR		4
-#define PREFERRED_BPP		16
-
-static struct drm_fbdev_cma *fbdev_cma;
-
-static int legacyfb_depth = 16;
-
-module_param(legacyfb_depth, int, 0444);
-
-static int __init imx_fb_helper_init(void)
-{
-	struct drm_device *drm = imx_drm_device_get();
-
-	if (!drm)
-		return -EINVAL;
-
-	if (legacyfb_depth != 16 && legacyfb_depth != 32) {
-		pr_warn("i.MX legacyfb: invalid legacyfb_depth setting. defaulting to 16bpp\n");
-		legacyfb_depth = 16;
-	}
-
-	fbdev_cma = drm_fbdev_cma_init(drm, legacyfb_depth,
-			drm->mode_config.num_crtc, MAX_CONNECTOR);
-
-	if (IS_ERR(fbdev_cma)) {
-		imx_drm_device_put();
-		return PTR_ERR(fbdev_cma);
-	}
-
-	imx_drm_fb_helper_set(fbdev_cma);
-
-	return 0;
-}
-
-static void __exit imx_fb_helper_exit(void)
-{
-	imx_drm_fb_helper_set(NULL);
-	drm_fbdev_cma_fini(fbdev_cma);
-	imx_drm_device_put();
-}
-
-late_initcall(imx_fb_helper_init);
-module_exit(imx_fb_helper_exit);
-
-MODULE_DESCRIPTION("Freescale i.MX legacy fb driver");
-MODULE_AUTHOR("Sascha Hauer, Pengutronix");
-MODULE_LICENSE("GPL");
-- 
1.7.4.4
