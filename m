From: m.grzeschik@pengutronix.de (Michael Grzeschik)
Date: Wed, 14 Nov 2012 12:55:37 +0100
Subject: [PATCH 6/6] usb: chipidea: usbmisc: add post handling and errata fix
 for mx25
In-Reply-To: <1352894137-2050-1-git-send-email-m.grzeschik@pengutronix.de>
References: <1352894137-2050-1-git-send-email-m.grzeschik@pengutronix.de>
Message-ID: <1352894137-2050-7-git-send-email-m.grzeschik@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a post handling routine which is called after
ci13xxx_add_device was called. The first user is the mx25, which has to
disable the external-vbus-divider after the ude has started.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 .../devicetree/bindings/usb/ci13xxx-imx.txt        |    2 ++
 drivers/usb/chipidea/ci13xxx_imx.c                 |   12 ++++++++
 drivers/usb/chipidea/ci13xxx_imx.h                 |    3 ++
 drivers/usb/chipidea/usbmisc_imx.c                 |   30 ++++++++++++++++++++
 4 files changed, 47 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/ci13xxx-imx.txt b/Documentation/devicetree/bindings/usb/ci13xxx-imx.txt
index 5778b9c..1c04a4c 100644
--- a/Documentation/devicetree/bindings/usb/ci13xxx-imx.txt
+++ b/Documentation/devicetree/bindings/usb/ci13xxx-imx.txt
@@ -11,6 +11,7 @@ Optional properties:
   that indicate usb controller index
 - vbus-supply: regulator for vbus
 - disable-over-current: disable over current detect
+- external-vbus-divider: enables off-chip resistor divider for Vbus
 
 Examples:
 usb at 02184000 { /* USB OTG */
@@ -20,4 +21,5 @@ usb at 02184000 { /* USB OTG */
 	fsl,usbphy = <&usbphy1>;
 	fsl,usbmisc = <&usbmisc 0>;
 	disable-over-current;
+	external-vbus-divider;
 };
diff --git a/drivers/usb/chipidea/ci13xxx_imx.c b/drivers/usb/chipidea/ci13xxx_imx.c
index 935de97..095fee5 100644
--- a/drivers/usb/chipidea/ci13xxx_imx.c
+++ b/drivers/usb/chipidea/ci13xxx_imx.c
@@ -79,6 +79,9 @@ int usbmisc_get_init_data(struct device *dev, struct usbmisc_usb_device *usbdev)
 	if (of_find_property(np, "disable-over-current", NULL))
 		usbdev->disable_oc = 1;
 
+	if (of_find_property(np, "external-vbus-divider", NULL))
+		usbdev->evdo = 1;
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(usbmisc_get_init_data);
@@ -213,6 +216,15 @@ static int __devinit ci13xxx_imx_probe(struct platform_device *pdev)
 		goto put_np;
 	}
 
+	if (usbmisc_ops && usbmisc_ops->post) {
+		ret = usbmisc_ops->post(&pdev->dev);
+		if (ret) {
+			dev_err(&pdev->dev,
+				"usbmisc post failed, ret=%d\n", ret);
+			goto err;
+		}
+	}
+
 	data->ci_pdev = plat_ci;
 	platform_set_drvdata(pdev, data);
 
diff --git a/drivers/usb/chipidea/ci13xxx_imx.h b/drivers/usb/chipidea/ci13xxx_imx.h
index 2e88acc..d065273 100644
--- a/drivers/usb/chipidea/ci13xxx_imx.h
+++ b/drivers/usb/chipidea/ci13xxx_imx.h
@@ -13,6 +13,8 @@
 struct usbmisc_ops {
 	/* It's called once when probe a usb device */
 	int (*init)(struct device *dev);
+	/* It's called once after adding a usb device */
+	int (*post)(struct device *dev);
 };
 
 struct usbmisc_usb_device {
@@ -20,6 +22,7 @@ struct usbmisc_usb_device {
 	int index;
 
 	int disable_oc:1; /* over current detect disabled */
+	int evdo:1; /* set external vbus divider option */
 };
 
 int usbmisc_set_ops(const struct usbmisc_ops *ops);
diff --git a/drivers/usb/chipidea/usbmisc_imx.c b/drivers/usb/chipidea/usbmisc_imx.c
index 4ddc872..1b15a20 100644
--- a/drivers/usb/chipidea/usbmisc_imx.c
+++ b/drivers/usb/chipidea/usbmisc_imx.c
@@ -14,6 +14,7 @@
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/io.h>
+#include <linux/delay.h>
 
 #include "ci13xxx_imx.h"
 
@@ -54,6 +55,30 @@ static struct usbmisc_usb_device *get_usbdev(struct device *dev)
 	return &usbmisc->usbdev[i];
 }
 
+static int usbmisc_imx25_post(struct device *dev)
+{
+	struct usbmisc_usb_device *usbdev;
+	void __iomem *reg;
+	unsigned long flags;
+	u32 val;
+
+	usbdev = get_usbdev(dev);
+	if (IS_ERR(usbdev))
+		return PTR_ERR(usbdev);
+
+	reg = usbmisc->base + 0x08;
+
+	if (usbdev->evdo) {
+		spin_lock_irqsave(&usbmisc->lock, flags);
+		val = readl(reg);
+		writel(val | (1 << 23), reg);
+		spin_unlock_irqrestore(&usbmisc->lock, flags);
+		mdelay(5); /* needed to stabilize voltage */
+	}
+
+	return 0;
+}
+
 static int usbmisc_imx53_init(struct device *dev)
 {
 	struct usbmisc_usb_device *usbdev;
@@ -99,6 +124,10 @@ static int usbmisc_imx6q_init(struct device *dev)
 	return 0;
 }
 
+static const struct usbmisc_ops imx25_usbmisc_ops = {
+	.post = usbmisc_imx25_post,
+};
+
 static const struct usbmisc_ops imx53_usbmisc_ops = {
 	.init = usbmisc_imx53_init,
 };
@@ -108,6 +137,7 @@ static const struct usbmisc_ops imx6q_usbmisc_ops = {
 };
 
 static const struct of_device_id usbmisc_imx_dt_ids[] = {
+	{ .compatible = "fsl,imx25-usbmisc", .data = (void *)&imx25_usbmisc_ops },
 	{ .compatible = "fsl,imx53-usbmisc", .data = (void *)&imx53_usbmisc_ops },
 	{ .compatible = "fsl,imx6q-usbmisc", .data = (void *)&imx6q_usbmisc_ops },
 	{ /* sentinel */ }
-- 
1.7.10.4
