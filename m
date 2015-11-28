From: xinliang.liu@linaro.org (Xinliang Liu)
Date: Sat, 28 Nov 2015 18:39:02 +0800
Subject: [PATCH v2 07/10] drm/hisilicon: Add cma fbdev and hotplug
In-Reply-To: <1448707145-69348-1-git-send-email-xinliang.liu@linaro.org>
References: <1448707145-69348-1-git-send-email-xinliang.liu@linaro.org>
Message-ID: <1448707145-69348-8-git-send-email-xinliang.liu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add cma Fbdev, Fbdev is legency and optional, you can enable/disable it by
configuring DRM_FBDEV_EMULATION.
Add hotplug.

Signed-off-by: Xinliang Liu <xinliang.liu@linaro.org>
Signed-off-by: Xinwei Kong <kong.kongxinwei@hisilicon.com>
Signed-off-by: Andy Green <andy.green@linaro.org>
---
 drivers/gpu/drm/hisilicon/hisi_drm_drv.c | 34 ++++++++++++++++++++++++++++++++
 drivers/gpu/drm/hisilicon/hisi_drm_drv.h |  3 +++
 2 files changed, 37 insertions(+)

diff --git a/drivers/gpu/drm/hisilicon/hisi_drm_drv.c b/drivers/gpu/drm/hisilicon/hisi_drm_drv.c
index 13f59aa..76eb711 100644
--- a/drivers/gpu/drm/hisilicon/hisi_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/hisi_drm_drv.c
@@ -20,6 +20,7 @@
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_fb_cma_helper.h>
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_crtc_helper.h>
 
 #include "hisi_drm_ade.h"
 #include "hisi_drm_drv.h"
@@ -30,6 +31,13 @@ static int hisi_drm_unload(struct drm_device *dev)
 {
 	struct hisi_drm_private *priv = dev->dev_private;
 
+#ifdef CONFIG_DRM_FBDEV_EMULATION
+	if (priv->fbdev) {
+		drm_fbdev_cma_fini(priv->fbdev);
+		priv->fbdev = NULL;
+	}
+#endif
+	drm_kms_helper_poll_fini(dev);
 	drm_vblank_cleanup(dev);
 	drm_mode_config_cleanup(dev);
 	devm_kfree(dev->dev, priv);
@@ -38,8 +46,28 @@ static int hisi_drm_unload(struct drm_device *dev)
 	return 0;
 }
 
+#ifdef CONFIG_DRM_FBDEV_EMULATION
+static void hisi_fbdev_output_poll_changed(struct drm_device *dev)
+{
+	struct hisi_drm_private *priv = dev->dev_private;
+
+	if (priv->fbdev) {
+		drm_fbdev_cma_hotplug_event(priv->fbdev);
+	} else {
+		priv->fbdev = drm_fbdev_cma_init(dev, 32,
+				dev->mode_config.num_crtc,
+				dev->mode_config.num_connector);
+		if (IS_ERR(priv->fbdev))
+			priv->fbdev = NULL;
+	}
+}
+#endif
+
 static const struct drm_mode_config_funcs hisi_drm_mode_config_funcs = {
 	.fb_create = drm_fb_cma_create,
+#ifdef CONFIG_DRM_FBDEV_EMULATION
+	.output_poll_changed = hisi_fbdev_output_poll_changed,
+#endif
 	.atomic_check = drm_atomic_helper_check,
 	.atomic_commit = drm_atomic_helper_commit,
 };
@@ -90,6 +118,12 @@ static int hisi_drm_load(struct drm_device *dev, unsigned long flags)
 	/* reset all the states of crtc/plane/encoder/connector */
 	drm_mode_config_reset(dev);
 
+	/* init kms poll for handling hpd */
+	drm_kms_helper_poll_init(dev);
+
+	/* force detection after connectors init */
+	(void)drm_helper_hpd_irq_event(dev);
+
 	return 0;
 
 err_unbind_all:
diff --git a/drivers/gpu/drm/hisilicon/hisi_drm_drv.h b/drivers/gpu/drm/hisilicon/hisi_drm_drv.h
index a10229e..984121f 100644
--- a/drivers/gpu/drm/hisilicon/hisi_drm_drv.h
+++ b/drivers/gpu/drm/hisilicon/hisi_drm_drv.h
@@ -11,6 +11,9 @@
 #define __HISI_DRM_DRV_H__
 
 struct hisi_drm_private {
+#ifdef CONFIG_DRM_FBDEV_EMULATION
+	struct drm_fbdev_cma *fbdev;
+#endif
 };
 
 #endif /* __HISI_DRM_DRV_H__ */
-- 
1.9.1
