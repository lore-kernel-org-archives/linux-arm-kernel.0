From: m.grzeschik@pengutronix.de (Michael Grzeschik)
Date: Wed, 14 Nov 2012 12:55:35 +0100
Subject: [PATCH 4/6] usb: chipidea: usbmisc: add support for ahb,
 ipg and per clock
In-Reply-To: <1352894137-2050-1-git-send-email-m.grzeschik@pengutronix.de>
References: <1352894137-2050-1-git-send-email-m.grzeschik@pengutronix.de>
Message-ID: <1352894137-2050-5-git-send-email-m.grzeschik@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Kleine-Budde <mkl@pengutronix.de>

This patch adds support for ahb, ipg and per clock, which is needed to support
imx53.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
 drivers/usb/chipidea/usbmisc_imx.c |   60 +++++++++++++++++++++++++++---------
 1 file changed, 45 insertions(+), 15 deletions(-)

diff --git a/drivers/usb/chipidea/usbmisc_imx.c b/drivers/usb/chipidea/usbmisc_imx.c
index 72445f7..239b752 100644
--- a/drivers/usb/chipidea/usbmisc_imx.c
+++ b/drivers/usb/chipidea/usbmisc_imx.c
@@ -24,7 +24,9 @@
 struct imx_usbmisc {
 	void __iomem *base;
 	spinlock_t lock;
-	struct clk *clk;
+	struct clk *clk_ahb;
+	struct clk *clk_ipg;
+	struct clk *clk_per;
 	struct usbmisc_usb_device usbdev[USB_DEV_MAX];
 	const struct usbmisc_ops *ops;
 };
@@ -104,38 +106,66 @@ static int __devinit usbmisc_imx_probe(struct platform_device *pdev)
 	if (!data->base)
 		return -EADDRNOTAVAIL;
 
-	data->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(data->clk)) {
+	data->clk_ahb = devm_clk_get(&pdev->dev, "ahb");
+	if (IS_ERR(data->clk_ahb)) {
 		dev_err(&pdev->dev,
-			"failed to get clock, err=%ld\n", PTR_ERR(data->clk));
-		return PTR_ERR(data->clk);
+			"failed to get ahb clock, err=%ld\n", PTR_ERR(data->clk_ahb));
+		return PTR_ERR(data->clk_ahb);
 	}
 
-	ret = clk_prepare_enable(data->clk);
-	if (ret) {
+	data->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
+	if (IS_ERR(data->clk_ipg)) {
 		dev_err(&pdev->dev,
-			"clk_prepare_enable failed, err=%d\n", ret);
-		return ret;
+			"failed to get ipg clock, err=%ld\n", PTR_ERR(data->clk_ipg));
+		return PTR_ERR(data->clk_ipg);
 	}
 
+	data->clk_per = devm_clk_get(&pdev->dev, "per");
+	if (IS_ERR(data->clk_per)) {
+		dev_err(&pdev->dev,
+			"failed to get per clock, err=%ld\n", PTR_ERR(data->clk_per));
+		return PTR_ERR(data->clk_per);
+	}
+
+	ret = clk_prepare_enable(data->clk_ahb);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(data->clk_ipg);
+	if (ret)
+		goto err_ipg_failed;
+
+	ret = clk_prepare_enable(data->clk_per);
+	if (ret)
+		goto err_per_failed;
+
 	tmp_dev = (struct of_device_id *)
 		of_match_device(usbmisc_imx6q_dt_ids, &pdev->dev);
 	data->ops = (const struct usbmisc_ops *)tmp_dev->data;
 	usbmisc = data;
 	ret = usbmisc_set_ops(data->ops);
-	if (ret) {
-		usbmisc = NULL;
-		clk_disable_unprepare(data->clk);
-		return ret;
-	}
+	if (ret)
+		goto err_set_ops_failed;
 
 	return 0;
+
+ err_set_ops_failed:
+	usbmisc = NULL;
+	clk_disable_unprepare(data->clk_per);
+ err_per_failed:
+	clk_disable_unprepare(data->clk_ipg);
+ err_ipg_failed:
+	clk_disable_unprepare(data->clk_ahb);
+
+	return ret;
 }
 
 static int __devexit usbmisc_imx_remove(struct platform_device *pdev)
 {
 	usbmisc_unset_ops(usbmisc->ops);
-	clk_disable_unprepare(usbmisc->clk);
+	clk_disable_unprepare(usbmisc->clk_per);
+	clk_disable_unprepare(usbmisc->clk_ipg);
+	clk_disable_unprepare(usbmisc->clk_ahb);
 	usbmisc = NULL;
 	return 0;
 }
-- 
1.7.10.4
