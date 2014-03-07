From: denis@eukrea.com (Denis Carikli)
Date: Fri,  7 Mar 2014 18:04:15 +0100
Subject: [PATCH 1/9] usb: chipidea: usbmisc: Add USB Host support for
 i.MX25/i.MX35 CPUs
Message-ID: <1394211863-7569-1-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Denis Carikli <denis@eukrea.com>
---
 drivers/usb/chipidea/usbmisc_imx.c |   59 ++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/drivers/usb/chipidea/usbmisc_imx.c b/drivers/usb/chipidea/usbmisc_imx.c
index cd061ab..d956ad0 100644
--- a/drivers/usb/chipidea/usbmisc_imx.c
+++ b/drivers/usb/chipidea/usbmisc_imx.c
@@ -21,6 +21,26 @@
 #define MX25_USB_PHY_CTRL_OFFSET	0x08
 #define MX25_BM_EXTERNAL_VBUS_DIVIDER	BIT(23)
 
+#define MXC_EHCI_INTERFACE_SINGLE_UNI	(2 << 0)
+#define MXC_EHCI_INTERFACE_DIFF_UNI	(0 << 0)
+#define MXC_EHCI_INTERFACE_MASK		(0xf)
+
+#define MX25_OTG_SIC_SHIFT		29
+#define MX25_OTG_SIC_MASK		(0x3 << MX25_OTG_SIC_SHIFT)
+#define MX25_OTG_PM_BIT			BIT(24)
+#define MX25_OTG_PP_BIT			BIT(11)
+#define MX25_OTG_OCPOL_BIT		(1 << 3)
+
+#define MX25_H1_SIC_SHIFT		21
+#define MX25_H1_SIC_MASK		(0x3 << MX25_H1_SIC_SHIFT)
+#define MX25_H1_PP_BIT			BIT(18)
+#define MX25_H1_PM_BIT			BIT(16)
+#define MX25_H1_IPPUE_UP_BIT		BIT(7)
+#define MX25_H1_IPPUE_DOWN_BIT		BIT(6)
+#define MX25_H1_TLL_BIT			BIT(5)
+#define MX25_H1_USBTE_BIT		BIT(4)
+#define MX25_H1_OCPOL_BIT		(1 << 2)
+
 #define MX27_H1_PM_BIT			BIT(8)
 #define MX27_H2_PM_BIT			BIT(16)
 #define MX27_OTG_PM_BIT			BIT(24)
@@ -50,6 +70,40 @@ struct imx_usbmisc {
 
 static struct imx_usbmisc *usbmisc;
 
+static int usbmisc_imx25_init(struct imx_usbmisc_data *data)
+{
+	void __iomem *reg = NULL;
+	unsigned long flags;
+	u32 val = 0;
+
+	if (data->index > 1)
+		return -EINVAL;
+
+	spin_lock_irqsave(&usbmisc->lock, flags);
+	switch (data->index) {
+	case 0:
+		val = readl(usbmisc->base);
+		val &= ~(MX25_OTG_SIC_MASK | MX25_OTG_PP_BIT);
+		val |= (MXC_EHCI_INTERFACE_DIFF_UNI & MXC_EHCI_INTERFACE_MASK) << MX25_OTG_SIC_SHIFT;
+		val |= (MX25_OTG_PM_BIT | MX25_OTG_OCPOL_BIT);
+		writel(val, usbmisc->base);
+		break;
+	case 1:
+		val = readl(usbmisc->base);
+		val &= ~(MX25_H1_SIC_MASK | MX25_H1_PP_BIT |  MX25_H1_IPPUE_UP_BIT);
+		val |= (MXC_EHCI_INTERFACE_SINGLE_UNI & MXC_EHCI_INTERFACE_MASK) << MX25_H1_SIC_SHIFT;
+		val |= (MX25_H1_PM_BIT | MX25_H1_OCPOL_BIT | MX25_H1_TLL_BIT |
+			MX25_H1_USBTE_BIT | MX25_H1_IPPUE_DOWN_BIT);
+
+		writel(val, usbmisc->base);
+
+		break;
+	}
+	spin_unlock_irqrestore(&usbmisc->lock, flags);
+
+	return 0;
+}
+
 static int usbmisc_imx25_post(struct imx_usbmisc_data *data)
 {
 	void __iomem *reg;
@@ -159,6 +213,7 @@ static int usbmisc_imx6q_init(struct imx_usbmisc_data *data)
 }
 
 static const struct usbmisc_ops imx25_usbmisc_ops = {
+	.init = usbmisc_imx25_init,
 	.post = usbmisc_imx25_post,
 };
 
@@ -200,6 +255,10 @@ static const struct of_device_id usbmisc_imx_dt_ids[] = {
 		.data = &imx25_usbmisc_ops,
 	},
 	{
+		.compatible = "fsl,imx35-usbmisc",
+		.data = &imx25_usbmisc_ops,
+	},
+	{
 		.compatible = "fsl,imx27-usbmisc",
 		.data = &imx27_usbmisc_ops,
 	},
-- 
1.7.9.5
