From: shc_work@mail.ru (Alexander Shiyan)
Date: Sun, 10 Nov 2013 11:18:20 +0400
Subject: [PATCH 1/2] usb: chipidea: usbmisc: Add support for i.MX27/i.MX31 CPUs
Message-ID: <1384067901-9377-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds i.MX27 and i.MX31 as the next user of the usbmisc driver.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/usb/chipidea/usbmisc_imx.c | 42 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/usb/chipidea/usbmisc_imx.c b/drivers/usb/chipidea/usbmisc_imx.c
index 8a1094b..4381c5a6 100644
--- a/drivers/usb/chipidea/usbmisc_imx.c
+++ b/drivers/usb/chipidea/usbmisc_imx.c
@@ -21,6 +21,10 @@
 #define MX25_USB_PHY_CTRL_OFFSET	0x08
 #define MX25_BM_EXTERNAL_VBUS_DIVIDER	BIT(23)
 
+#define MX27_H1_PM_BIT			BIT(8)
+#define MX27_H2_PM_BIT			BIT(16)
+#define MX27_OTG_PM_BIT			BIT(24)
+
 #define MX53_USB_OTG_PHY_CTRL_0_OFFSET	0x08
 #define MX53_USB_UH2_CTRL_OFFSET	0x14
 #define MX53_USB_UH3_CTRL_OFFSET	0x18
@@ -68,6 +72,36 @@ static int usbmisc_imx25_post(struct imx_usbmisc_data *data)
 	return 0;
 }
 
+static int usbmisc_imx27_init(struct imx_usbmisc_data *data)
+{
+	unsigned long flags;
+	u32 val;
+
+	switch (data->index) {
+	case 0:
+		val = MX27_OTG_PM_BIT;
+		break;
+	case 1:
+		val = MX27_H1_PM_BIT;
+		break;
+	case 2:
+		val = MX27_H2_PM_BIT;
+		break;
+	default:
+		return -EINVAL;
+	};
+
+	spin_lock_irqsave(&usbmisc->lock, flags);
+	if (data->disable_oc)
+		val = readl(usbmisc->base) | val;
+	else
+		val = readl(usbmisc->base) & ~val;
+	writel(val, usbmisc->base);
+	spin_unlock_irqrestore(&usbmisc->lock, flags);
+
+	return 0;
+}
+
 static int usbmisc_imx53_init(struct imx_usbmisc_data *data)
 {
 	void __iomem *reg = NULL;
@@ -128,6 +162,10 @@ static const struct usbmisc_ops imx25_usbmisc_ops = {
 	.post = usbmisc_imx25_post,
 };
 
+static const struct usbmisc_ops imx27_usbmisc_ops = {
+	.init = usbmisc_imx27_init,
+};
+
 static const struct usbmisc_ops imx53_usbmisc_ops = {
 	.init = usbmisc_imx53_init,
 };
@@ -162,6 +200,10 @@ static const struct of_device_id usbmisc_imx_dt_ids[] = {
 		.data = &imx25_usbmisc_ops,
 	},
 	{
+		.compatible = "fsl,imx27-usbmisc",
+		.data = &imx27_usbmisc_ops,
+	},
+	{
 		.compatible = "fsl,imx53-usbmisc",
 		.data = &imx53_usbmisc_ops,
 	},
-- 
1.8.1.5
