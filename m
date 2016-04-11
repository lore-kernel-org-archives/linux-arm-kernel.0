From: xinliang.liu@linaro.org (Xinliang Liu)
Date: Mon, 11 Apr 2016 16:55:39 +0800
Subject: [PATCH v8 06/10] drm/hisilicon: Add cma fbdev and hotplug
In-Reply-To: <1460364943-76135-1-git-send-email-xinliang.liu@linaro.org>
References: <1460364943-76135-1-git-send-email-xinliang.liu@linaro.org>
Message-ID: <1460364943-76135-7-git-send-email-xinliang.liu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add cma Fbdev, Fbdev is legency and optional, you can enable/disable it by
configuring DRM_FBDEV_EMULATION.
Add hotplug.

v8: None.
v7: None.
v6: None.
v5: None.
v4: None.
v3: None.
v2:
- Use CONFIG_DRM_FBDEV_EMULATION instead of CONFIG_DRM_HISI_FBDEV.

Signed-off-by: Xinliang Liu <xinliang.liu@linaro.org>
Signed-off-by: Xinwei Kong <kong.kongxinwei@hisilicon.com>
---
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c | 34 +++++++++++++++++++++++++
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h |  3 +++
 2 files changed, 37 insertions(+)

diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
index 2a899c5bb14e..e102c9e1e7b2 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
@@ -23,6 +23,7 @@
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_fb_cma_helper.h>
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_crtc_helper.h>
 
 #include "kirin_drm_drv.h"
 
@@ -32,6 +33,13 @@ static int kirin_drm_kms_cleanup(struct drm_device *dev)
 {
 	struct kirin_drm_private *priv = dev->dev_private;
 
+#ifdef CONFIG_DRM_FBDEV_EMULATION
+	if (priv->fbdev) {
+		drm_fbdev_cma_fini(priv->fbdev);
+		priv->fbdev = NULL;
+	}
+#endif
+	drm_kms_helper_poll_fini(dev);
 	drm_vblank_cleanup(dev);
 	dc_ops->cleanup(dev);
 	drm_mode_config_cleanup(dev);
@@ -41,8 +49,28 @@ static int kirin_drm_kms_cleanup(struct drm_device *dev)
 	return 0;
 }
 
+#ifdef CONFIG_DRM_FBDEV_EMULATION
+static void kirin_fbdev_output_poll_changed(struct drm_device *dev)
+{
+	struct kirin_drm_private *priv = dev->dev_private;
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
 static const struct drm_mode_config_funcs kirin_drm_mode_config_funcs = {
 	.fb_create = drm_fb_cma_create,
+#ifdef CONFIG_DRM_FBDEV_EMULATION
+	.output_poll_changed = kirin_fbdev_output_poll_changed,
+#endif
 	.atomic_check = drm_atomic_helper_check,
 	.atomic_commit = drm_atomic_helper_commit,
 };
@@ -98,6 +126,12 @@ static int kirin_drm_kms_init(struct drm_device *dev)
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
diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h
index 5a05ad6a81db..1a07caf8e7f4 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h
@@ -21,6 +21,9 @@ struct kirin_dc_ops {
 
 struct kirin_drm_private {
 	struct drm_crtc *crtc[MAX_CRTC];
+#ifdef CONFIG_DRM_FBDEV_EMULATION
+	struct drm_fbdev_cma *fbdev;
+#endif
 };
 
 extern const struct kirin_dc_ops ade_dc_ops;
-- 
2.8.0
