From: denis@eukrea.com (Denis Carikli)
Date: Mon,  7 Apr 2014 18:03:59 +0200
Subject: [PATCH v2][ 1/3] chipidea: usbmisc_imx: Allow USB OTG to work on mx51
Message-ID: <1396886641-26985-1-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

The field PLLDIVVALUE of register PHY_CTRL_1 selects the reference clock source
for the PHY:
00 = sysclock uses 19.2 MHz
01 = sysclock uses 24 MHz
10 = sysclock uses 26 MHz
11 = sysclock uses 27 MHz

The reset value for this field is 10 according to the reference manual, and
even though this reset value works for mx53, it does not work for mx51.

So instead of relying on the reset value for the PLLDIVVALUE field, explicitly
set it to 01 so that a 24MHz clock can be selected for the PHY and allowing both
mx51 and mx53 to have USB OTG port functional.

Succesfully tested 'g_ether' on a imx51-babbage and on a imx53-qsb boards.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/usb/chipidea/usbmisc_imx.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/usb/chipidea/usbmisc_imx.c b/drivers/usb/chipidea/usbmisc_imx.c
index cd061ab..f6c4f3c 100644
--- a/drivers/usb/chipidea/usbmisc_imx.c
+++ b/drivers/usb/chipidea/usbmisc_imx.c
@@ -26,11 +26,14 @@
 #define MX27_OTG_PM_BIT			BIT(24)
 
 #define MX53_USB_OTG_PHY_CTRL_0_OFFSET	0x08
+#define MX53_USB_OTG_PHY_CTRL_1_OFFSET	0x0c
 #define MX53_USB_UH2_CTRL_OFFSET	0x14
 #define MX53_USB_UH3_CTRL_OFFSET	0x18
 #define MX53_BM_OVER_CUR_DIS_H1		BIT(5)
 #define MX53_BM_OVER_CUR_DIS_OTG	BIT(8)
 #define MX53_BM_OVER_CUR_DIS_UHx	BIT(30)
+#define MX53_USB_PHYCTRL1_PLLDIV_MASK	0x3
+#define MX53_USB_PLL_DIV_24_MHZ		0x01
 
 #define MX6_BM_OVER_CUR_DIS		BIT(7)
 
@@ -111,6 +114,13 @@ static int usbmisc_imx53_init(struct imx_usbmisc_data *data)
 	if (data->index > 3)
 		return -EINVAL;
 
+	/* Select a 24 MHz reference clock for the PHY  */
+	reg = usbmisc->base + MX53_USB_OTG_PHY_CTRL_1_OFFSET;
+	val = readl(reg);
+	val &= ~MX53_USB_PHYCTRL1_PLLDIV_MASK;
+	val |= MX53_USB_PLL_DIV_24_MHZ;
+	writel(val, usbmisc->base + MX53_USB_OTG_PHY_CTRL_1_OFFSET);
+
 	if (data->disable_oc) {
 		spin_lock_irqsave(&usbmisc->lock, flags);
 		switch (data->index) {
-- 
1.7.9.5
