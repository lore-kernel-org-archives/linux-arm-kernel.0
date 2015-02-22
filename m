From: sylvain.rochet@finsecur.com (Sylvain Rochet)
Date: Sun, 22 Feb 2015 18:51:03 +0100
Subject: [PATCHv3 1/2] drm: atmel-hlcdc: Add PM suspend/resume support
In-Reply-To: <1424627464-16869-1-git-send-email-sylvain.rochet@finsecur.com>
References: <1424627464-16869-1-git-send-email-sylvain.rochet@finsecur.com>
Message-ID: <1424627464-16869-2-git-send-email-sylvain.rochet@finsecur.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On suspend: switch off CRTC if not already suspended with runtime PM

On resume: switch on CRTC if we were not already suspended from runtime
PM while suspending.

Signed-off-by: Sylvain Rochet <sylvain.rochet@finsecur.com>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c | 47 ++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
index 22c3cca..c4bb1f9 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
@@ -559,6 +559,52 @@ static int atmel_hlcdc_dc_drm_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM
+static int atmel_hlcdc_dc_drm_suspend(struct device *dev)
+{
+	struct drm_device *drm_dev = dev_get_drvdata(dev);
+	struct drm_crtc *crtc;
+
+	if (pm_runtime_suspended(dev))
+		return 0;
+
+	drm_modeset_lock_all(drm_dev);
+	list_for_each_entry(crtc, &drm_dev->mode_config.crtc_list, head) {
+		struct drm_crtc_helper_funcs *crtc_funcs = crtc->helper_private;
+		if (crtc->enabled) {
+			crtc_funcs->disable(crtc);
+			/* save enable state for resume */
+			crtc->enabled = true;
+		}
+	}
+	drm_modeset_unlock_all(drm_dev);
+	return 0;
+}
+
+static int atmel_hlcdc_dc_drm_resume(struct device *dev)
+{
+	struct drm_device *drm_dev = dev_get_drvdata(dev);
+	struct drm_crtc *crtc;
+
+	if (pm_runtime_suspended(dev))
+		return 0;
+
+	drm_modeset_lock_all(drm_dev);
+	list_for_each_entry(crtc, &drm_dev->mode_config.crtc_list, head) {
+		struct drm_crtc_helper_funcs *crtc_funcs = crtc->helper_private;
+		if (crtc->enabled) {
+			crtc->enabled = false;
+			crtc_funcs->enable(crtc);
+		}
+	}
+	drm_modeset_unlock_all(drm_dev);
+	return 0;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(atmel_hlcdc_dc_drm_pm_ops,
+		atmel_hlcdc_dc_drm_suspend, atmel_hlcdc_dc_drm_resume);
+
 static const struct of_device_id atmel_hlcdc_dc_of_match[] = {
 	{ .compatible = "atmel,hlcdc-display-controller" },
 	{ },
@@ -569,6 +615,7 @@ static struct platform_driver atmel_hlcdc_dc_platform_driver = {
 	.remove	= atmel_hlcdc_dc_drm_remove,
 	.driver	= {
 		.name	= "atmel-hlcdc-display-controller",
+		.pm	= &atmel_hlcdc_dc_drm_pm_ops,
 		.of_match_table = atmel_hlcdc_dc_of_match,
 	},
 };
-- 
2.1.4
