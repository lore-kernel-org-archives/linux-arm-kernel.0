From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 10 Sep 2014 22:43:51 +0800
Subject: [PATCH RESEND] imx-drm: imx-drm-core: add basic suspend/resume support
Message-ID: <1410360231-14837-1-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HDMI currently stops working after a system suspend/resume cycle.  The
cause is that the mode setting states in hardware gets lost and isn't
restored across the suspend/resume cycle.

The patch adds a very basic suspend/resume support to imx-drm driver,
and calls drm_helper_resume_force_mode() in .resume hook to restore the
mode setting states, so that HDMI can continue working after a system
suspend/resume cycle.

Since the suspend/resume hook can be called with drm_device pointer
being NULL from driver data, we need a check on the pointer in the
hooks.  And to avoid using a stale pointer from driver data, it also
clears driver data in .unload hook.

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
Greg,

This is a resend of '[PATCH v3] imx-drm: imx-drm-core: add suspend/resume
support' [1], with a tiny change on the subject only.

Shawn

[1] http://thread.gmane.org/gmane.linux.ports.arm.kernel/349360

 drivers/staging/imx-drm/imx-drm-core.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/staging/imx-drm/imx-drm-core.c b/drivers/staging/imx-drm/imx-drm-core.c
index 6b22106534d8..41ff896d2ca9 100644
--- a/drivers/staging/imx-drm/imx-drm-core.c
+++ b/drivers/staging/imx-drm/imx-drm-core.c
@@ -87,6 +87,8 @@ static int imx_drm_driver_unload(struct drm_device *drm)
 	drm_vblank_cleanup(drm);
 	drm_mode_config_cleanup(drm);
 
+	platform_set_drvdata(drm->platformdev, NULL);
+
 	return 0;
 }
 
@@ -647,6 +649,36 @@ static int imx_drm_platform_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int imx_drm_suspend(struct device *dev)
+{
+	struct drm_device *drm_dev = dev_get_drvdata(dev);
+
+	/* The drm_dev is NULL before .load hook is called */
+	if (drm_dev == NULL)
+		return 0;
+
+	drm_kms_helper_poll_disable(drm_dev);
+
+	return 0;
+}
+
+static int imx_drm_resume(struct device *dev)
+{
+	struct drm_device *drm_dev = dev_get_drvdata(dev);
+
+	if (drm_dev == NULL)
+		return 0;
+
+	drm_helper_resume_force_mode(drm_dev);
+	drm_kms_helper_poll_enable(drm_dev);
+
+	return 0;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(imx_drm_pm_ops, imx_drm_suspend, imx_drm_resume);
+
 static const struct of_device_id imx_drm_dt_ids[] = {
 	{ .compatible = "fsl,imx-display-subsystem", },
 	{ /* sentinel */ },
@@ -659,6 +691,7 @@ static struct platform_driver imx_drm_pdrv = {
 	.driver		= {
 		.owner	= THIS_MODULE,
 		.name	= "imx-drm",
+		.pm	= &imx_drm_pm_ops,
 		.of_match_table = imx_drm_dt_ids,
 	},
 };
-- 
1.9.1
