From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 02 Jan 2014 21:29:20 +0000
Subject: [PATCH RFC 42/46] imx-drm: imx-drm-core: add core hotplug connector
 support
In-Reply-To: <20140102212528.GD7383@n2100.arm.linux.org.uk>
References: <20140102212528.GD7383@n2100.arm.linux.org.uk>
Message-ID: <E1VyppQ-0007GK-Gb@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add core imx-drm support for hotplug connector support.  We need to
setup the poll helper after we've setup the connectors; the helper
scans the connectors to determine their capabilities.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/staging/imx-drm/imx-drm-core.c |   20 ++++++++++++++++----
 1 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/imx-drm/imx-drm-core.c b/drivers/staging/imx-drm/imx-drm-core.c
index 33c020867ed0..6b86bfeb091f 100644
--- a/drivers/staging/imx-drm/imx-drm-core.c
+++ b/drivers/staging/imx-drm/imx-drm-core.c
@@ -69,6 +69,8 @@ static int imx_drm_driver_unload(struct drm_device *drm)
 {
 	struct imx_drm_device *imxdrm = drm->dev_private;
 
+	drm_kms_helper_poll_fini(drm);
+
 #if IS_ENABLED(CONFIG_DRM_IMX_FB_HELPER)
 	if (imxdrm->fbhelper)
 		drm_fbdev_cma_fini(imxdrm->fbhelper);
@@ -77,7 +79,6 @@ static int imx_drm_driver_unload(struct drm_device *drm)
 	component_unbind_all(drm->dev, drm);
 
 	drm_vblank_cleanup(drm);
-	drm_kms_helper_poll_fini(drm);
 	drm_mode_config_cleanup(drm);
 
 	return 0;
@@ -213,8 +214,19 @@ void imx_drm_encoder_destroy(struct drm_encoder *encoder)
 }
 EXPORT_SYMBOL_GPL(imx_drm_encoder_destroy);
 
+static void imx_drm_output_poll_changed(struct drm_device *drm)
+{
+	struct imx_drm_device *imxdrm = drm->dev_private;
+
+#if IS_ENABLED(CONFIG_DRM_IMX_FB_HELPER)
+	if (imxdrm->fbhelper)
+		drm_fbdev_cma_hotplug_event(imxdrm->fbhelper);
+#endif
+}
+
 static struct drm_mode_config_funcs imx_drm_mode_config_funcs = {
 	.fb_create = drm_fb_cma_create,
+	.output_poll_changed = imx_drm_output_poll_changed,
 };
 
 /*
@@ -259,8 +271,6 @@ static int imx_drm_driver_load(struct drm_device *drm, unsigned long flags)
 
 	drm_mode_config_init(drm);
 
-	drm_kms_helper_poll_init(drm);
-
 	ret = drm_vblank_init(drm, MAX_CRTC);
 	if (ret)
 		goto err_kms;
@@ -311,6 +321,9 @@ static int imx_drm_driver_load(struct drm_device *drm, unsigned long flags)
 		goto err_unbind;
 	}
 #endif
+
+	drm_kms_helper_poll_init(drm);
+
 	return 0;
 
 err_unbind:
@@ -318,7 +331,6 @@ static int imx_drm_driver_load(struct drm_device *drm, unsigned long flags)
 err_vblank:
 	drm_vblank_cleanup(drm);
 err_kms:
-	drm_kms_helper_poll_fini(drm);
 	drm_mode_config_cleanup(drm);
 
 	return ret;
-- 
1.7.4.4
