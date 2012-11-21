From: m.grzeschik@pengutronix.de (Michael Grzeschik)
Date: Wed, 21 Nov 2012 15:06:31 +0100
Subject: [PATCH v3 5/7] usb: chipidea: usbmisc: add support for ahb,
 ipg and per clock
In-Reply-To: <1353506793-8354-1-git-send-email-m.grzeschik@pengutronix.de>
References: <1353506793-8354-1-git-send-email-m.grzeschik@pengutronix.de>
Message-ID: <1353506793-8354-6-git-send-email-m.grzeschik@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Kleine-Budde <mkl@pengutronix.de>

This patch adds support for a second and third clock to the usbmisc driver. On
modern freescale ARM cores like the imx51, imx53 and imx6q three clocks ("ahb",
"ipg" and "per") must be enabled in order to access the USB core.

ahb - AMBA High-Performance Bus clock domain
ipg - IP-Bus Gate clock domain
per - Peripheral clock domain

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
Changes since v1:
* changed patch description

 drivers/usb/chipidea/usbmisc_imx.c |   60 +++++++++++++++++++++++++++---------
 1 file changed, 45 insertions(+), 15 deletions(-)

diff --git a/drivers/usb/chipidea/usbmisc_imx.c b/drivers/usb/chipidea/usbmisc_imx.c
index d0c7a03..e090e0f 100644
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
 		of_match_device(usbmisc_imx_dt_ids, &pdev->dev);
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
