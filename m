From: eric@anholt.net (Eric Anholt)
Date: Tue, 18 Aug 2015 14:54:05 -0700
Subject: [PATCH v2 4/7] drm/vc4: Use the fbdev_cma helpers
In-Reply-To: <1439934848-7196-1-git-send-email-eric@anholt.net>
References: <1439934848-7196-1-git-send-email-eric@anholt.net>
Message-ID: <1439934848-7196-5-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Derek Foreman <derekf@osg.samsung.com>

Keep the fbdev_cma pointer around so we can use it on hotplog and close
to ensure the frame buffer console is in a useful state.

Signed-off-by: Derek Foreman <derekf@osg.samsung.com>
Signed-off-by: Eric Anholt <eric@anholt.net>
---
 drivers/gpu/drm/vc4/vc4_drv.c | 14 ++++++++++++++
 drivers/gpu/drm/vc4/vc4_drv.h |  2 ++
 drivers/gpu/drm/vc4/vc4_kms.c | 18 +++++++++++++++---
 3 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_drv.c b/drivers/gpu/drm/vc4/vc4_drv.c
index d30aefa..8ebd238 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.c
+++ b/drivers/gpu/drm/vc4/vc4_drv.c
@@ -14,6 +14,7 @@
 #include <linux/module.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include "drm_fb_cma_helper.h"
 
 #include "vc4_drv.h"
 #include "vc4_regs.h"
@@ -49,6 +50,14 @@ static void vc4_drm_preclose(struct drm_device *dev, struct drm_file *file)
 		vc4_cancel_page_flip(crtc, file);
 }
 
+static void vc4_lastclose(struct drm_device *dev)
+{
+	struct vc4_dev *vc4 = to_vc4_dev(dev);
+
+	if (vc4->fbdev)
+		drm_fbdev_cma_restore_mode(vc4->fbdev);
+}
+
 static const struct file_operations vc4_drm_fops = {
 	.owner = THIS_MODULE,
 	.open = drm_open,
@@ -71,6 +80,7 @@ static struct drm_driver vc4_drm_driver = {
 			    DRIVER_ATOMIC |
 			    DRIVER_GEM |
 			    DRIVER_PRIME),
+	.lastclose = vc4_lastclose,
 	.preclose = vc4_drm_preclose,
 
 	.enable_vblank = vc4_enable_vblank,
@@ -161,6 +171,10 @@ static void vc4_drm_unbind(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct drm_device *drm = platform_get_drvdata(pdev);
+	struct vc4_dev *vc4 = to_vc4_dev(drm);
+
+	if (vc4->fbdev)
+		drm_fbdev_cma_fini(vc4->fbdev);
 
 	drm_mode_config_cleanup(drm);
 
diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
index 282ce0b..24a1cb5 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.h
+++ b/drivers/gpu/drm/vc4/vc4_drv.h
@@ -15,6 +15,8 @@ struct vc4_dev {
 	struct vc4_hdmi *hdmi;
 	struct vc4_hvs *hvs;
 	struct vc4_crtc *crtc[3];
+
+	struct drm_fbdev_cma *fbdev;
 };
 
 static inline struct vc4_dev *
diff --git a/drivers/gpu/drm/vc4/vc4_kms.c b/drivers/gpu/drm/vc4/vc4_kms.c
index e5e96bc..a34439f 100644
--- a/drivers/gpu/drm/vc4/vc4_kms.c
+++ b/drivers/gpu/drm/vc4/vc4_kms.c
@@ -21,7 +21,16 @@
 #include "drm_fb_cma_helper.h"
 #include "vc4_drv.h"
 
+static void vc4_output_poll_changed(struct drm_device *dev)
+{
+	struct vc4_dev *vc4 = to_vc4_dev(dev);
+
+	if (vc4->fbdev)
+		drm_fbdev_cma_hotplug_event(vc4->fbdev);
+}
+
 static const struct drm_mode_config_funcs vc4_mode_funcs = {
+	.output_poll_changed = vc4_output_poll_changed,
 	.atomic_check = drm_atomic_helper_check,
 	.atomic_commit = drm_atomic_helper_commit,
 	.fb_create = drm_fb_cma_create,
@@ -54,6 +63,7 @@ fail:
 
 int vc4_kms_load(struct drm_device *dev)
 {
+	struct vc4_dev *vc4 = to_vc4_dev(dev);
 	int ret;
 
 	ret = drm_vblank_init(dev, dev->mode_config.num_crtc);
@@ -73,9 +83,11 @@ int vc4_kms_load(struct drm_device *dev)
 
 	drm_mode_config_reset(dev);
 
-	drm_fbdev_cma_init(dev, 32,
-			   dev->mode_config.num_crtc,
-			   dev->mode_config.num_connector);
+	vc4->fbdev = drm_fbdev_cma_init(dev, 32,
+					dev->mode_config.num_crtc,
+					dev->mode_config.num_connector);
+	if (IS_ERR(vc4->fbdev))
+		vc4->fbdev = NULL;
 
 	drm_kms_helper_poll_init(dev);
 
-- 
2.1.4
