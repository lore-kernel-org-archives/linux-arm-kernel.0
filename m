From: eric@eukrea.com (=?UTF-8?q?Eric=20B=C3=A9nard?=)
Date: Tue,  8 May 2012 09:18:29 +0200
Subject: [PATCH 1/2] usb: fsl_mxc_udc.c: add workaround for ENGcm09152 for
 i.MX25
Message-ID: <1336461510-30190-1-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

this patch gives the possibility to workaround bug ENGcm09152
on i.MX25 when the hardware workaround is also implemented on
the board.
It covers the workaround described on page 42 of the following Errata,
titled "USB: UTMI_USBPHY VBUS input impedance implementation error" :
http://cache.freescale.com/files/dsp/doc/errata/IMX25CE.pdf

Signed-off-by: Eric B?nard <eric@eukrea.com>
Cc: Sascha Hauer <kernel@pengutronix.de>
---
 drivers/usb/gadget/fsl_mxc_udc.c |   22 +++++++++++++---------
 1 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/gadget/fsl_mxc_udc.c b/drivers/usb/gadget/fsl_mxc_udc.c
index dcbc0a2..8bbf673 100644
--- a/drivers/usb/gadget/fsl_mxc_udc.c
+++ b/drivers/usb/gadget/fsl_mxc_udc.c
@@ -89,17 +89,21 @@ eenahb:
 void fsl_udc_clk_finalize(struct platform_device *pdev)
 {
 	struct fsl_usb2_platform_data *pdata = pdev->dev.platform_data;
-	if (cpu_is_mx35()) {
+
+	/* workaround ENGcm09152 for i.MX25 and i.MX35 */
+	if (pdata->workaround & FLS_USB2_WORKAROUND_ENGCM09152) {
 		unsigned int v;
+		void __iomem *otgbase;
 
-		/* workaround ENGcm09152 for i.MX35 */
-		if (pdata->workaround & FLS_USB2_WORKAROUND_ENGCM09152) {
-			v = readl(MX35_IO_ADDRESS(MX35_USB_BASE_ADDR +
-					USBPHYCTRL_OTGBASE_OFFSET));
-			writel(v | USBPHYCTRL_EVDO,
-				MX35_IO_ADDRESS(MX35_USB_BASE_ADDR +
-					USBPHYCTRL_OTGBASE_OFFSET));
-		}
+		if (cpu_is_mx25())
+			otgbase = MX25_IO_ADDRESS(MX25_USB_BASE_ADDR +
+					USBPHYCTRL_OTGBASE_OFFSET);
+		else if (cpu_is_mx35())
+			otgbase = MX35_IO_ADDRESS(MX35_USB_BASE_ADDR +
+					USBPHYCTRL_OTGBASE_OFFSET);
+
+		v = readl(otgbase);
+		writel(v | USBPHYCTRL_EVDO, otgbase);
 	}
 
 	/* ULPI transceivers don't need usbpll */
-- 
1.7.7.6
