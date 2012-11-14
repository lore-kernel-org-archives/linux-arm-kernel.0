From: m.grzeschik@pengutronix.de (Michael Grzeschik)
Date: Wed, 14 Nov 2012 12:55:34 +0100
Subject: [PATCH 3/6] usb: chipidea: usbmisc: prepare driver to handle more
 than one soc
In-Reply-To: <1352894137-2050-1-git-send-email-m.grzeschik@pengutronix.de>
References: <1352894137-2050-1-git-send-email-m.grzeschik@pengutronix.de>
Message-ID: <1352894137-2050-4-git-send-email-m.grzeschik@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Kleine-Budde <mkl@pengutronix.de>

This attaches the usbmisc_ops to the of_device_id data and
makes it possible to define special functions per soc.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
 drivers/usb/chipidea/usbmisc_imx.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/chipidea/usbmisc_imx.c b/drivers/usb/chipidea/usbmisc_imx.c
index 9145e04..72445f7 100644
--- a/drivers/usb/chipidea/usbmisc_imx.c
+++ b/drivers/usb/chipidea/usbmisc_imx.c
@@ -26,6 +26,7 @@ struct imx_usbmisc {
 	spinlock_t lock;
 	struct clk *clk;
 	struct usbmisc_usb_device usbdev[USB_DEV_MAX];
+	const struct usbmisc_ops *ops;
 };
 
 static struct imx_usbmisc *usbmisc;
@@ -78,7 +79,7 @@ static const struct usbmisc_ops imx6q_usbmisc_ops = {
 };
 
 static const struct of_device_id usbmisc_imx_dt_ids[] = {
-	{ .compatible = "fsl,imx6q-usbmisc"},
+	{ .compatible = "fsl,imx6q-usbmisc", .data = (void *)&imx6q_usbmisc_ops },
 	{ /* sentinel */ }
 };
 
@@ -87,6 +88,7 @@ static int __devinit usbmisc_imx_probe(struct platform_device *pdev)
 	struct resource	*res;
 	struct imx_usbmisc *data;
 	int ret;
+	struct of_device_id *tmp_dev;
 
 	if (usbmisc)
 		return -EBUSY;
@@ -116,8 +118,11 @@ static int __devinit usbmisc_imx_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	tmp_dev = (struct of_device_id *)
+		of_match_device(usbmisc_imx6q_dt_ids, &pdev->dev);
+	data->ops = (const struct usbmisc_ops *)tmp_dev->data;
 	usbmisc = data;
-	ret = usbmisc_set_ops(&imx6q_usbmisc_ops);
+	ret = usbmisc_set_ops(data->ops);
 	if (ret) {
 		usbmisc = NULL;
 		clk_disable_unprepare(data->clk);
@@ -129,7 +134,7 @@ static int __devinit usbmisc_imx_probe(struct platform_device *pdev)
 
 static int __devexit usbmisc_imx_remove(struct platform_device *pdev)
 {
-	usbmisc_unset_ops(&imx6q_usbmisc_ops);
+	usbmisc_unset_ops(usbmisc->ops);
 	clk_disable_unprepare(usbmisc->clk);
 	usbmisc = NULL;
 	return 0;
-- 
1.7.10.4
