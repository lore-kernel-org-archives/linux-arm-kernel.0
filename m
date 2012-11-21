From: m.grzeschik@pengutronix.de (Michael Grzeschik)
Date: Wed, 21 Nov 2012 15:06:30 +0100
Subject: [PATCH v3 4/7] usb: chipidea: usbmisc: prepare driver to handle more
 than one soc
In-Reply-To: <1353506793-8354-1-git-send-email-m.grzeschik@pengutronix.de>
References: <1353506793-8354-1-git-send-email-m.grzeschik@pengutronix.de>
Message-ID: <1353506793-8354-5-git-send-email-m.grzeschik@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Kleine-Budde <mkl@pengutronix.de>

This attaches the usbmisc_ops to the of_device_id data and
makes it possible to define special functions per soc.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
Changes since v2:
* renamed bitmask to reflect soctype mx6

 drivers/usb/chipidea/usbmisc_imx.c |   15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/chipidea/usbmisc_imx.c b/drivers/usb/chipidea/usbmisc_imx.c
index 9145e04..d0c7a03 100644
--- a/drivers/usb/chipidea/usbmisc_imx.c
+++ b/drivers/usb/chipidea/usbmisc_imx.c
@@ -19,13 +19,14 @@
 
 #define USB_DEV_MAX 4
 
-#define BM_OVER_CUR_DIS		BIT(7)
+#define MX6_BM_OVER_CUR_DIS		BIT(7)
 
 struct imx_usbmisc {
 	void __iomem *base;
 	spinlock_t lock;
 	struct clk *clk;
 	struct usbmisc_usb_device usbdev[USB_DEV_MAX];
+	const struct usbmisc_ops *ops;
 };
 
 static struct imx_usbmisc *usbmisc;
@@ -65,7 +66,7 @@ static int usbmisc_imx6q_init(struct device *dev)
 	if (usbdev->disable_oc) {
 		spin_lock_irqsave(&usbmisc->lock, flags);
 		reg = readl(usbmisc->base + usbdev->index * 4);
-		writel(reg | BM_OVER_CUR_DIS,
+		writel(reg | MX6_BM_OVER_CUR_DIS,
 			usbmisc->base + usbdev->index * 4);
 		spin_unlock_irqrestore(&usbmisc->lock, flags);
 	}
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
+		of_match_device(usbmisc_imx_dt_ids, &pdev->dev);
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
