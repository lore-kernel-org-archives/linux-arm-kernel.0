From: m.grzeschik@pengutronix.de (Michael Grzeschik)
Date: Tue, 27 Nov 2012 17:17:01 +0100
Subject: [PATCH v4 6/6] usb: chipidea: usbmisc: add post handling and errata
 fix for mx25
In-Reply-To: <1354033021-10585-1-git-send-email-m.grzeschik@pengutronix.de>
References: <1354033021-10585-1-git-send-email-m.grzeschik@pengutronix.de>
Message-ID: <1354033021-10585-7-git-send-email-m.grzeschik@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a post handling routine which is called after
ci13xxx_add_device was called. The first user is the mx25, which has to
disable the external-vbus-divider after the udc has started.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Changes since v3:
* fixed patch description typos
* used usleep_range instead of mdelay

 .../devicetree/bindings/usb/ci13xxx-imx.txt        |    2 ++
 drivers/usb/chipidea/ci13xxx_imx.c                 |   12 +++++++
 drivers/usb/chipidea/ci13xxx_imx.h                 |    3 ++
 drivers/usb/chipidea/usbmisc_imx.c                 |   33 ++++++++++++++++++++
 4 files changed, 50 insertions(+)

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
index 935de97..d346c99 100644
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
+			goto put_np;
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
index 69a49e5..44b3a7d 100644
--- a/drivers/usb/chipidea/usbmisc_imx.c
+++ b/drivers/usb/chipidea/usbmisc_imx.c
@@ -14,11 +14,15 @@
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/io.h>
+#include <linux/delay.h>
 
 #include "ci13xxx_imx.h"
 
 #define USB_DEV_MAX 4
 
+#define MX25_USB_PHY_CTRL_OFFSET	0x08
+#define MX25_BM_EXTERNAL_VBUS_DIVIDER	BIT(23)
+
 #define MX53_USB_OTG_PHY_CTRL_0_OFFSET	0x08
 #define MX53_USB_UH2_CTRL_OFFSET	0x14
 #define MX53_USB_UH3_CTRL_OFFSET	0x18
@@ -59,6 +63,30 @@ static struct usbmisc_usb_device *get_usbdev(struct device *dev)
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
+	reg = usbmisc->base + MX25_USB_PHY_CTRL_OFFSET;
+
+	if (usbdev->evdo) {
+		spin_lock_irqsave(&usbmisc->lock, flags);
+		val = readl(reg);
+		writel(val | MX25_BM_EXTERNAL_VBUS_DIVIDER, reg);
+		spin_unlock_irqrestore(&usbmisc->lock, flags);
+		usleep_range(5000,10000); /* needed to stabilize voltage */
+	}
+
+	return 0;
+}
+
 static int usbmisc_imx53_init(struct device *dev)
 {
 	struct usbmisc_usb_device *usbdev;
@@ -120,6 +148,10 @@ static int usbmisc_imx6q_init(struct device *dev)
 	return 0;
 }
 
+static const struct usbmisc_ops imx25_usbmisc_ops = {
+	.post = usbmisc_imx25_post,
+};
+
 static const struct usbmisc_ops imx53_usbmisc_ops = {
 	.init = usbmisc_imx53_init,
 };
@@ -129,6 +161,7 @@ static const struct usbmisc_ops imx6q_usbmisc_ops = {
 };
 
 static const struct of_device_id usbmisc_imx_dt_ids[] = {
+	{ .compatible = "fsl,imx25-usbmisc", .data = (void *)&imx25_usbmisc_ops },
 	{ .compatible = "fsl,imx53-usbmisc", .data = (void *)&imx53_usbmisc_ops },
 	{ .compatible = "fsl,imx6q-usbmisc", .data = (void *)&imx6q_usbmisc_ops },
 	{ /* sentinel */ }
-- 
1.7.10.4
