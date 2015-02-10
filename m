From: sylvain.rochet@finsecur.com (Sylvain Rochet)
Date: Tue, 10 Feb 2015 14:40:45 +0100
Subject: [PATCH 1/2] drm: atmel-hlcdc: Add PM suspend/resume support
In-Reply-To: <1423575646-3273-1-git-send-email-sylvain.rochet@finsecur.com>
References: <1423575646-3273-1-git-send-email-sylvain.rochet@finsecur.com>
Message-ID: <1423575646-3273-2-git-send-email-sylvain.rochet@finsecur.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On suspend: switch off CRTC if not already suspended with runtime PM

On resume: switch on CRTC if we were not already suspended from runtime
PM while suspending.

Signed-off-by: Sylvain Rochet <sylvain.rochet@finsecur.com>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c | 60 ++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
index 22c3cca..4c89bd2 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
@@ -427,6 +427,36 @@ static void atmel_hlcdc_dc_lastclose(struct drm_device *dev)
 	drm_fbdev_cma_restore_mode(dc->fbdev);
 }
 
+static int atmel_hlcdc_dc_suspend(struct drm_device *dev, pm_message_t state)
+{
+	struct drm_crtc *crtc;
+
+	drm_modeset_lock_all(dev);
+
+	list_for_each_entry(crtc, &dev->mode_config.crtc_list, head) {
+		struct drm_crtc_helper_funcs *crtc_funcs = crtc->helper_private;
+		(*crtc_funcs->disable)(crtc);
+	}
+
+	drm_modeset_unlock_all(dev);
+	return 0;
+}
+
+static int atmel_hlcdc_dc_resume(struct drm_device *dev)
+{
+	struct drm_crtc *crtc;
+
+	drm_modeset_lock_all(dev);
+
+	list_for_each_entry(crtc, &dev->mode_config.crtc_list, head) {
+		struct drm_crtc_helper_funcs *crtc_funcs = crtc->helper_private;
+		(*crtc_funcs->enable)(crtc);
+	}
+
+	drm_modeset_unlock_all(dev);
+	return 0;
+}
+
 static int atmel_hlcdc_dc_irq_postinstall(struct drm_device *dev)
 {
 	struct atmel_hlcdc_dc *dc = dev->dev_private;
@@ -488,6 +518,8 @@ static struct drm_driver atmel_hlcdc_dc_driver = {
 	.driver_features = DRIVER_HAVE_IRQ | DRIVER_GEM | DRIVER_MODESET,
 	.preclose = atmel_hlcdc_dc_preclose,
 	.lastclose = atmel_hlcdc_dc_lastclose,
+	.suspend = atmel_hlcdc_dc_suspend,
+	.resume = atmel_hlcdc_dc_resume,
 	.irq_handler = atmel_hlcdc_dc_irq_handler,
 	.irq_preinstall = atmel_hlcdc_dc_irq_uninstall,
 	.irq_postinstall = atmel_hlcdc_dc_irq_postinstall,
@@ -559,6 +591,33 @@ static int atmel_hlcdc_dc_drm_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM
+static int atmel_hlcdc_dc_drm_suspend(struct device *dev)
+{
+	struct drm_device *drm_dev = dev_get_drvdata(dev);
+	pm_message_t message;
+
+	if (pm_runtime_suspended(dev) || !drm_dev)
+		return 0;
+
+	message.event = PM_EVENT_SUSPEND;
+	return atmel_hlcdc_dc_suspend(drm_dev, message);
+}
+
+static int atmel_hlcdc_dc_drm_resume(struct device *dev)
+{
+	struct drm_device *drm_dev = dev_get_drvdata(dev);
+
+	if (pm_runtime_suspended(dev) || !drm_dev)
+		return 0;
+
+	return atmel_hlcdc_dc_resume(drm_dev);
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(atmel_hlcdc_dc_drm_pm_ops,
+		atmel_hlcdc_dc_drm_suspend, atmel_hlcdc_dc_drm_resume);
+
 static const struct of_device_id atmel_hlcdc_dc_of_match[] = {
 	{ .compatible = "atmel,hlcdc-display-controller" },
 	{ },
@@ -569,6 +628,7 @@ static struct platform_driver atmel_hlcdc_dc_platform_driver = {
 	.remove	= atmel_hlcdc_dc_drm_remove,
 	.driver	= {
 		.name	= "atmel-hlcdc-display-controller",
+		.pm	= &atmel_hlcdc_dc_drm_pm_ops,
 		.of_match_table = atmel_hlcdc_dc_of_match,
 	},
 };
-- 
2.1.4
