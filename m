From: peter.chen@freescale.com (Peter Chen)
Date: Wed, 30 Sep 2015 10:25:25 +0800
Subject: [RESEND PATCH v3 5/5] usb: chipidea: imx: refine clock operations to
 adapt for all platforms
In-Reply-To: <1443579925-1330-1-git-send-email-peter.chen@freescale.com>
References: <1443579925-1330-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1443579925-1330-6-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some i.mx platforms need three clocks to let controller work, but
others only need one, refine clock operation to adapt for all
platforms, it fixes a regression found at i.mx27.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
Tested-by: Fabio Estevam <fabio.estevam@freescale.com>
Cc: <stable@vger.kernel.org> #v4.1+
---
 drivers/usb/chipidea/ci_hdrc_imx.c | 156 ++++++++++++++++++++++++++++++++-----
 1 file changed, 138 insertions(+), 18 deletions(-)

diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci_hdrc_imx.c
index 6ccbf60..6ec0fbc 100644
--- a/drivers/usb/chipidea/ci_hdrc_imx.c
+++ b/drivers/usb/chipidea/ci_hdrc_imx.c
@@ -32,6 +32,10 @@ static const struct ci_hdrc_imx_platform_flag imx27_usb_data = {
 		CI_HDRC_DISABLE_STREAMING,
 };
 
+static const struct ci_hdrc_imx_platform_flag imx31_usb_data = {
+		CI_HDRC_DISABLE_STREAMING,
+};
+
 static const struct ci_hdrc_imx_platform_flag imx28_usb_data = {
 	.flags = CI_HDRC_IMX28_WRITE_FIX |
 		CI_HDRC_TURN_VBUS_EARLY_ON |
@@ -68,6 +72,13 @@ static const struct ci_hdrc_imx_platform_flag imx7d_usb_data = {
 static const struct of_device_id ci_hdrc_imx_dt_ids[] = {
 	{ .compatible = "fsl,imx28-usb", .data = &imx28_usb_data},
 	{ .compatible = "fsl,imx27-usb", .data = &imx27_usb_data},
+	{ .compatible = "fsl,imx25-usb", .data = &imx27_usb_data},
+	{ .compatible = "fsl,imx35-usb", .data = &imx27_usb_data},
+	{ .compatible = "fsl,imx23-usb", .data = &imx31_usb_data},
+	{ .compatible = "fsl,imx31-usb", .data = &imx31_usb_data},
+	{ .compatible = "fsl,imx50-usb", .data = &imx31_usb_data},
+	{ .compatible = "fsl,imx51-usb", .data = &imx31_usb_data},
+	{ .compatible = "fsl,imx53-usb", .data = &imx31_usb_data},
 	{ .compatible = "fsl,imx6q-usb", .data = &imx6q_usb_data},
 	{ .compatible = "fsl,imx6sl-usb", .data = &imx6sl_usb_data},
 	{ .compatible = "fsl,imx6sx-usb", .data = &imx6sx_usb_data},
@@ -77,6 +88,15 @@ static const struct of_device_id ci_hdrc_imx_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, ci_hdrc_imx_dt_ids);
 
+static inline bool imx_needs_three_clocks
+	(const struct ci_hdrc_imx_platform_flag *imx_platform_flag)
+{
+	if (imx_platform_flag == &imx27_usb_data)
+		return true;
+
+	return false;
+}
+
 struct ci_hdrc_imx_data {
 	struct usb_phy *phy;
 	struct platform_device *ci_pdev;
@@ -84,6 +104,12 @@ struct ci_hdrc_imx_data {
 	struct imx_usbmisc_data *usbmisc_data;
 	bool supports_runtime_pm;
 	bool in_lpm;
+	/* SoC before i.mx6 (except imx23/imx28) needs three clks */
+	bool need_three_clks;
+	struct clk *clk_ipg;
+	struct clk *clk_ahb;
+	struct clk *clk_per;
+	/* --------------------------------- */
 };
 
 /* Common functions shared by usbmisc drivers */
@@ -135,6 +161,105 @@ static struct imx_usbmisc_data *usbmisc_get_init_data(struct device *dev)
 }
 
 /* End of common functions shared by usbmisc drivers*/
+static int imx_get_clks(struct device *dev)
+{
+	struct ci_hdrc_imx_data *data = dev_get_drvdata(dev);
+	int ret = 0;
+
+	if (data->need_three_clks) {
+		data->clk_ipg = devm_clk_get(dev, "ipg");
+		if (IS_ERR(data->clk_ipg)) {
+			ret = PTR_ERR(data->clk_ipg);
+			dev_err(dev,
+				"Failed to get ipg clock, err=%d\n", ret);
+			return ret;
+		}
+
+		data->clk_ahb = devm_clk_get(dev, "ahb");
+		if (IS_ERR(data->clk_ahb)) {
+			ret = PTR_ERR(data->clk_ahb);
+			dev_err(dev,
+				"Failed to get ahb clock, err=%d\n", ret);
+			return ret;
+		}
+
+		data->clk_per = devm_clk_get(dev, "per");
+		if (IS_ERR(data->clk_per)) {
+			ret = PTR_ERR(data->clk_per);
+			dev_err(dev,
+				"Failed to get per clock, err=%d\n", ret);
+			return ret;
+		}
+	} else {
+		data->clk = devm_clk_get(dev, NULL);
+		if (IS_ERR(data->clk)) {
+			ret = PTR_ERR(data->clk);
+			dev_err(dev,
+				"Failed to get clock, err=%d\n", ret);
+			return ret;
+		}
+	}
+
+	return ret;
+}
+
+static int imx_prepare_enable_clks(struct device *dev)
+{
+	struct ci_hdrc_imx_data *data = dev_get_drvdata(dev);
+	int ret = 0;
+
+	if (data->need_three_clks) {
+		ret = clk_prepare_enable(data->clk_ipg);
+		if (ret) {
+			dev_err(dev,
+				"Failed to prepare/enable ipg clk, err=%d\n",
+				ret);
+			return ret;
+		}
+
+		ret = clk_prepare_enable(data->clk_ahb);
+		if (ret) {
+			dev_err(dev,
+				"Failed to prepare/enable ahb clk, err=%d\n",
+				ret);
+			clk_disable_unprepare(data->clk_ipg);
+			return ret;
+		}
+
+		ret = clk_prepare_enable(data->clk_per);
+		if (ret) {
+			dev_err(dev,
+				"Failed to prepare/enable per clk, err=%d\n",
+				ret);
+			clk_disable_unprepare(data->clk_ahb);
+			clk_disable_unprepare(data->clk_ipg);
+			return ret;
+		}
+	} else {
+		ret = clk_prepare_enable(data->clk);
+		if (ret) {
+			dev_err(dev,
+				"Failed to prepare/enable clk, err=%d\n",
+				ret);
+			return ret;
+		}
+	}
+
+	return ret;
+}
+
+static void imx_disable_unprepare_clks(struct device *dev)
+{
+	struct ci_hdrc_imx_data *data = dev_get_drvdata(dev);
+
+	if (data->need_three_clks) {
+		clk_disable_unprepare(data->clk_per);
+		clk_disable_unprepare(data->clk_ipg);
+		clk_disable_unprepare(data->clk_ahb);
+	} else {
+		clk_disable_unprepare(data->clk);
+	}
+}
 
 static int ci_hdrc_imx_probe(struct platform_device *pdev)
 {
@@ -153,23 +278,20 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
 	if (!data)
 		return -ENOMEM;
 
+	platform_set_drvdata(pdev, data);
 	data->usbmisc_data = usbmisc_get_init_data(&pdev->dev);
 	if (IS_ERR(data->usbmisc_data))
 		return PTR_ERR(data->usbmisc_data);
 
-	data->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(data->clk)) {
-		dev_err(&pdev->dev,
-			"Failed to get clock, err=%ld\n", PTR_ERR(data->clk));
-		return PTR_ERR(data->clk);
-	}
+	data->need_three_clks = imx_needs_three_clocks(imx_platform_flag);
 
-	ret = clk_prepare_enable(data->clk);
-	if (ret) {
-		dev_err(&pdev->dev,
-			"Failed to prepare or enable clock, err=%d\n", ret);
+	ret = imx_get_clks(&pdev->dev);
+	if (ret)
+		return ret;
+
+	ret = imx_prepare_enable_clks(&pdev->dev);
+	if (ret)
 		return ret;
-	}
 
 	data->phy = devm_usb_get_phy_by_phandle(&pdev->dev, "fsl,usbphy", 0);
 	if (IS_ERR(data->phy)) {
@@ -212,8 +334,6 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
 		goto disable_device;
 	}
 
-	platform_set_drvdata(pdev, data);
-
 	if (data->supports_runtime_pm) {
 		pm_runtime_set_active(&pdev->dev);
 		pm_runtime_enable(&pdev->dev);
@@ -226,7 +346,7 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
 disable_device:
 	ci_hdrc_remove_device(data->ci_pdev);
 err_clk:
-	clk_disable_unprepare(data->clk);
+	imx_disable_unprepare_clks(&pdev->dev);
 	return ret;
 }
 
@@ -240,7 +360,7 @@ static int ci_hdrc_imx_remove(struct platform_device *pdev)
 		pm_runtime_put_noidle(&pdev->dev);
 	}
 	ci_hdrc_remove_device(data->ci_pdev);
-	clk_disable_unprepare(data->clk);
+	imx_disable_unprepare_clks(&pdev->dev);
 
 	return 0;
 }
@@ -252,7 +372,7 @@ static int imx_controller_suspend(struct device *dev)
 
 	dev_dbg(dev, "at %s\n", __func__);
 
-	clk_disable_unprepare(data->clk);
+	imx_disable_unprepare_clks(dev);
 	data->in_lpm = true;
 
 	return 0;
@@ -270,7 +390,7 @@ static int imx_controller_resume(struct device *dev)
 		return 0;
 	}
 
-	ret = clk_prepare_enable(data->clk);
+	ret = imx_prepare_enable_clks(dev);
 	if (ret)
 		return ret;
 
@@ -285,7 +405,7 @@ static int imx_controller_resume(struct device *dev)
 	return 0;
 
 clk_disable:
-	clk_disable_unprepare(data->clk);
+	imx_disable_unprepare_clks(dev);
 	return ret;
 }
 
-- 
1.9.1
