From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Wed, 19 Jan 2011 13:32:44 -0200
Subject: [PATCH] usb: gadget/fsl_mxc_udc: Detect the CPU type in run-time
Message-ID: <1295451164-3363-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of checking the CPU type in build-time, do it in run-time.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/usb/gadget/fsl_mxc_udc.c |   23 ++++++++++++-----------
 1 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/gadget/fsl_mxc_udc.c b/drivers/usb/gadget/fsl_mxc_udc.c
index 77b1eb5..167abe0 100644
--- a/drivers/usb/gadget/fsl_mxc_udc.c
+++ b/drivers/usb/gadget/fsl_mxc_udc.c
@@ -88,17 +88,18 @@ eenahb:
 void fsl_udc_clk_finalize(struct platform_device *pdev)
 {
 	struct fsl_usb2_platform_data *pdata = pdev->dev.platform_data;
-#if defined(CONFIG_ARCH_MX35)
-	unsigned int v;
-
-	/* workaround ENGcm09152 for i.MX35 */
-	if (pdata->workaround & FLS_USB2_WORKAROUND_ENGCM09152) {
-		v = readl(MX35_IO_ADDRESS(MX35_USB_BASE_ADDR +
-				USBPHYCTRL_OTGBASE_OFFSET));
-		writel(v | USBPHYCTRL_EVDO, MX35_IO_ADDRESS(MX35_USB_BASE_ADDR +
-				USBPHYCTRL_OTGBASE_OFFSET));
-	}
-#endif
+	if (cpu_is_mx35()) {
+		unsigned int v;
+
+		/* workaround ENGcm09152 for i.MX35 */
+		if (pdata->workaround & FLS_USB2_WORKAROUND_ENGCM09152) {
+			v = readl(MX35_IO_ADDRESS(MX35_USB_BASE_ADDR +
+					USBPHYCTRL_OTGBASE_OFFSET));
+			writel(v | USBPHYCTRL_EVDO,
+				MX35_IO_ADDRESS(MX35_USB_BASE_ADDR +
+					USBPHYCTRL_OTGBASE_OFFSET));
+		}
+	}
 
 	/* ULPI transceivers don't need usbpll */
 	if (pdata->phy_mode == FSL_USB2_PHY_ULPI) {
-- 
1.6.0.4
