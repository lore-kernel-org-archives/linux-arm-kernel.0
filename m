From: peter.chen@freescale.com (Peter Chen)
Date: Tue, 22 Oct 2013 14:23:31 +0800
Subject: [Patch v2 02/10] usb: chipidea: imx: add power management support
In-Reply-To: <1382423019-26184-1-git-send-email-peter.chen@freescale.com>
References: <1382423019-26184-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1382423019-26184-3-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add system and runtime power management support for imx gluy layer.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 drivers/usb/chipidea/ci_hdrc_imx.c |   94 ++++++++++++++++++++++++++++++++++-
 1 files changed, 91 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci_hdrc_imx.c
index 023d3cb..a1e5634 100644
--- a/drivers/usb/chipidea/ci_hdrc_imx.c
+++ b/drivers/usb/chipidea/ci_hdrc_imx.c
@@ -28,6 +28,8 @@ struct ci_hdrc_imx_data {
 	struct platform_device *ci_pdev;
 	struct clk *clk;
 	struct imx_usbmisc_data *usbmisc_data;
+	bool supports_runtime_pm;
+	bool in_lpm;
 };
 
 /* Common functions shared by usbmisc drivers */
@@ -82,6 +84,7 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
 				  CI_HDRC_DISABLE_STREAMING,
 	};
 	int ret;
+	struct device_node *np = pdev->dev.of_node;
 
 	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
 	if (!data) {
@@ -151,8 +154,12 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, data);
 
-	pm_runtime_no_callbacks(&pdev->dev);
-	pm_runtime_enable(&pdev->dev);
+	device_set_wakeup_capable(&pdev->dev, true);
+
+	if (data->supports_runtime_pm) {
+		pm_runtime_set_active(&pdev->dev);
+		pm_runtime_enable(&pdev->dev);
+	}
 
 	return 0;
 
@@ -167,13 +174,93 @@ static int ci_hdrc_imx_remove(struct platform_device *pdev)
 {
 	struct ci_hdrc_imx_data *data = platform_get_drvdata(pdev);
 
-	pm_runtime_disable(&pdev->dev);
 	ci_hdrc_remove_device(data->ci_pdev);
+	if (data->supports_runtime_pm) {
+		pm_runtime_get_sync(&pdev->dev);
+		pm_runtime_disable(&pdev->dev);
+		pm_runtime_put_noidle(&pdev->dev);
+	}
 	clk_disable_unprepare(data->clk);
 
 	return 0;
 }
 
+#ifdef CONFIG_PM
+static int imx_controller_suspend(struct device *dev)
+{
+	struct ci_hdrc_imx_data *data = dev_get_drvdata(dev);
+
+	dev_dbg(dev, "at %s\n", __func__);
+
+	if (data->in_lpm)
+		return 0;
+
+	clk_disable_unprepare(data->clk);
+
+	data->in_lpm = true;
+
+	return 0;
+}
+
+static int imx_controller_resume(struct device *dev)
+{
+	struct ci_hdrc_imx_data *data = dev_get_drvdata(dev);
+	int ret = 0;
+
+	dev_dbg(dev, "at %s\n", __func__);
+
+	if (!data->in_lpm)
+		return 0;
+
+	ret = clk_prepare_enable(data->clk);
+	if (ret)
+		return ret;
+
+	data->in_lpm = false;
+
+	return ret;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int ci_hdrc_imx_suspend(struct device *dev)
+{
+	return imx_controller_suspend(dev);
+}
+
+static int ci_hdrc_imx_resume(struct device *dev)
+{
+	struct ci_hdrc_imx_data *data = dev_get_drvdata(dev);
+	int ret;
+
+	ret = imx_controller_resume(dev);
+	if (!ret && data->supports_runtime_pm) {
+		pm_runtime_disable(dev);
+		pm_runtime_set_active(dev);
+		pm_runtime_enable(dev);
+	}
+
+	return ret;
+}
+#endif /* CONFIG_PM_SLEEP */
+
+#ifdef CONFIG_PM_RUNTIME
+static int ci_hdrc_imx_runtime_suspend(struct device *dev)
+{
+	return imx_controller_suspend(dev);
+}
+
+static int ci_hdrc_imx_runtime_resume(struct device *dev)
+{
+	return imx_controller_resume(dev);
+}
+#endif /* CONFIG_PM_RUNTIME */
+
+#endif /* CONFIG_PM */
+static const struct dev_pm_ops ci_hdrc_imx_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(ci_hdrc_imx_suspend, ci_hdrc_imx_resume)
+	SET_RUNTIME_PM_OPS(ci_hdrc_imx_runtime_suspend,
+			ci_hdrc_imx_runtime_resume, NULL)
+};
 static const struct of_device_id ci_hdrc_imx_dt_ids[] = {
 	{ .compatible = "fsl,imx27-usb", },
 	{ /* sentinel */ }
@@ -187,6 +274,7 @@ static struct platform_driver ci_hdrc_imx_driver = {
 		.name = "imx_usb",
 		.owner = THIS_MODULE,
 		.of_match_table = ci_hdrc_imx_dt_ids,
+		.pm = &ci_hdrc_imx_pm_ops,
 	 },
 };
 
-- 
1.7.1
