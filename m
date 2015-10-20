From: peter.chen@freescale.com (Peter Chen)
Date: Tue, 20 Oct 2015 14:58:39 +0800
Subject: [PATCH v5 2/2] usb: chipidea: imx: refine clock operations to adapt
 for all platforms
In-Reply-To: <1445324319-19063-1-git-send-email-peter.chen@freescale.com>
References: <1445324319-19063-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1445324319-19063-3-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some i.mx platforms need three clocks to let controller work, but
others only need one, refine clock operation to adapt for all
platforms, it fixes a regression found at i.mx27.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
Tested-by: Fabio Estevam <fabio.estevam@freescale.com>
Cc: <stable@vger.kernel.org> #v4.1+
---
 drivers/usb/chipidea/ci_hdrc_imx.c | 131 ++++++++++++++++++++++++++++++++-----
 1 file changed, 113 insertions(+), 18 deletions(-)

diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci_hdrc_imx.c
index 6ccbf60..7c9b630 100644
--- a/drivers/usb/chipidea/ci_hdrc_imx.c
+++ b/drivers/usb/chipidea/ci_hdrc_imx.c
@@ -84,6 +84,12 @@ struct ci_hdrc_imx_data {
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
@@ -135,6 +141,102 @@ static struct imx_usbmisc_data *usbmisc_get_init_data(struct device *dev)
 }
 
 /* End of common functions shared by usbmisc drivers*/
+static int imx_get_clks(struct device *dev)
+{
+	struct ci_hdrc_imx_data *data = dev_get_drvdata(dev);
+	int ret = 0;
+
+	data->clk_ipg = devm_clk_get(dev, "ipg");
+	if (IS_ERR(data->clk_ipg)) {
+		/* If the platform only needs one clocks */
+		data->clk = devm_clk_get(dev, NULL);
+		if (IS_ERR(data->clk)) {
+			ret = PTR_ERR(data->clk);
+			dev_err(dev,
+				"Failed to get clks, err=%ld,%ld\n",
+				PTR_ERR(data->clk), PTR_ERR(data->clk_ipg));
+			return ret;
+		}
+		return ret;
+	}
+
+	data->clk_ahb = devm_clk_get(dev, "ahb");
+	if (IS_ERR(data->clk_ahb)) {
+		ret = PTR_ERR(data->clk_ahb);
+		dev_err(dev,
+			"Failed to get ahb clock, err=%d\n", ret);
+		return ret;
+	}
+
+	data->clk_per = devm_clk_get(dev, "per");
+	if (IS_ERR(data->clk_per)) {
+		ret = PTR_ERR(data->clk_per);
+		dev_err(dev,
+			"Failed to get per clock, err=%d\n", ret);
+		return ret;
+	}
+
+	data->need_three_clks = true;
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
+		clk_disable_unprepare(data->clk_ahb);
+		clk_disable_unprepare(data->clk_ipg);
+	} else {
+		clk_disable_unprepare(data->clk);
+	}
+}
 
 static int ci_hdrc_imx_probe(struct platform_device *pdev)
 {
@@ -153,23 +255,18 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
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
+	ret = imx_get_clks(&pdev->dev);
+	if (ret)
+		return ret;
 
-	ret = clk_prepare_enable(data->clk);
-	if (ret) {
-		dev_err(&pdev->dev,
-			"Failed to prepare or enable clock, err=%d\n", ret);
+	ret = imx_prepare_enable_clks(&pdev->dev);
+	if (ret)
 		return ret;
-	}
 
 	data->phy = devm_usb_get_phy_by_phandle(&pdev->dev, "fsl,usbphy", 0);
 	if (IS_ERR(data->phy)) {
@@ -212,8 +309,6 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
 		goto disable_device;
 	}
 
-	platform_set_drvdata(pdev, data);
-
 	if (data->supports_runtime_pm) {
 		pm_runtime_set_active(&pdev->dev);
 		pm_runtime_enable(&pdev->dev);
@@ -226,7 +321,7 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
 disable_device:
 	ci_hdrc_remove_device(data->ci_pdev);
 err_clk:
-	clk_disable_unprepare(data->clk);
+	imx_disable_unprepare_clks(&pdev->dev);
 	return ret;
 }
 
@@ -240,7 +335,7 @@ static int ci_hdrc_imx_remove(struct platform_device *pdev)
 		pm_runtime_put_noidle(&pdev->dev);
 	}
 	ci_hdrc_remove_device(data->ci_pdev);
-	clk_disable_unprepare(data->clk);
+	imx_disable_unprepare_clks(&pdev->dev);
 
 	return 0;
 }
@@ -252,7 +347,7 @@ static int imx_controller_suspend(struct device *dev)
 
 	dev_dbg(dev, "at %s\n", __func__);
 
-	clk_disable_unprepare(data->clk);
+	imx_disable_unprepare_clks(dev);
 	data->in_lpm = true;
 
 	return 0;
@@ -270,7 +365,7 @@ static int imx_controller_resume(struct device *dev)
 		return 0;
 	}
 
-	ret = clk_prepare_enable(data->clk);
+	ret = imx_prepare_enable_clks(dev);
 	if (ret)
 		return ret;
 
@@ -285,7 +380,7 @@ static int imx_controller_resume(struct device *dev)
 	return 0;
 
 clk_disable:
-	clk_disable_unprepare(data->clk);
+	imx_disable_unprepare_clks(dev);
 	return ret;
 }
 
-- 
1.9.1
