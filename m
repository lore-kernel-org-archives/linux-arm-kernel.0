From: peter.chen@freescale.com (Peter Chen)
Date: Tue, 5 Nov 2013 09:55:19 +0800
Subject: [PATCH v3 04/10] usb: chipidea: usbmisc_imx: remove the controller's
 clock information
In-Reply-To: <1383616525-10769-1-git-send-email-peter.chen@freescale.com>
References: <1383616525-10769-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1383616525-10769-5-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, the usbmisc is just an API supplier for controller
driver, the controller calls related APIs to handle different
things among the SoCs, before calling it, the clock must
be on. So the clock operation is useless for usbmisc, it also
increases the difficulties to manage the clock, especially at
runtime power management situation.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 drivers/usb/chipidea/usbmisc_imx.c |   18 ------------------
 1 files changed, 0 insertions(+), 18 deletions(-)

diff --git a/drivers/usb/chipidea/usbmisc_imx.c b/drivers/usb/chipidea/usbmisc_imx.c
index 8a1094b..1fd9a12 100644
--- a/drivers/usb/chipidea/usbmisc_imx.c
+++ b/drivers/usb/chipidea/usbmisc_imx.c
@@ -11,7 +11,6 @@
 
 #include <linux/module.h>
 #include <linux/of_platform.h>
-#include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/delay.h>
@@ -40,7 +39,6 @@ struct usbmisc_ops {
 struct imx_usbmisc {
 	void __iomem *base;
 	spinlock_t lock;
-	struct clk *clk;
 	const struct usbmisc_ops *ops;
 };
 
@@ -177,7 +175,6 @@ static int usbmisc_imx_probe(struct platform_device *pdev)
 {
 	struct resource	*res;
 	struct imx_usbmisc *data;
-	int ret;
 	struct of_device_id *tmp_dev;
 
 	if (usbmisc)
@@ -194,20 +191,6 @@ static int usbmisc_imx_probe(struct platform_device *pdev)
 	if (IS_ERR(data->base))
 		return PTR_ERR(data->base);
 
-	data->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(data->clk)) {
-		dev_err(&pdev->dev,
-			"failed to get clock, err=%ld\n", PTR_ERR(data->clk));
-		return PTR_ERR(data->clk);
-	}
-
-	ret = clk_prepare_enable(data->clk);
-	if (ret) {
-		dev_err(&pdev->dev,
-			"clk_prepare_enable failed, err=%d\n", ret);
-		return ret;
-	}
-
 	tmp_dev = (struct of_device_id *)
 		of_match_device(usbmisc_imx_dt_ids, &pdev->dev);
 	data->ops = (const struct usbmisc_ops *)tmp_dev->data;
@@ -218,7 +201,6 @@ static int usbmisc_imx_probe(struct platform_device *pdev)
 
 static int usbmisc_imx_remove(struct platform_device *pdev)
 {
-	clk_disable_unprepare(usbmisc->clk);
 	usbmisc = NULL;
 	return 0;
 }
-- 
1.7.1
