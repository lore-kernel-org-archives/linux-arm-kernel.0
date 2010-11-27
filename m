From: eric@eukrea.com (=?UTF-8?q?Eric=20B=C3=A9nard?=)
Date: Sat, 27 Nov 2010 09:15:38 +0100
Subject: [PATCH] plat-mxc/ehci.c: fix compile breakage
Message-ID: <1290845738-21586-1-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commits 2eb42d5c287f5e883a4b3ebe668ba880caa351e5 and
9e1dde33876ba83ad586c336647fff133d0f5472 renamed some defines
but didn't fix all the places where these defines are used
leading to a compile failure for USB on i.MX31, 35 and 27.

Signed-off-by: Eric B?nard <eric@eukrea.com>
---
 arch/arm/plat-mxc/ehci.c         |   12 ++++++------
 drivers/usb/gadget/fsl_mxc_udc.c |    4 ++--
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/plat-mxc/ehci.c b/arch/arm/plat-mxc/ehci.c
index 4bac3d5..b79c809 100644
--- a/arch/arm/plat-mxc/ehci.c
+++ b/arch/arm/plat-mxc/ehci.c
@@ -115,7 +115,7 @@ int mxc_initialize_usb_hw(int port, unsigned int flags)
 #endif /* if defined(CONFIG_SOC_IMX25) */
 #if defined(CONFIG_ARCH_MX3)
 	if (cpu_is_mx31()) {
-		v = readl(MX31_IO_ADDRESS(MX31_OTG_BASE_ADDR +
+		v = readl(MX31_IO_ADDRESS(MX31_USB_BASE_ADDR +
 				     USBCTRL_OTGBASE_OFFSET));
 
 		switch (port) {
@@ -153,13 +153,13 @@ int mxc_initialize_usb_hw(int port, unsigned int flags)
 			return -EINVAL;
 		}
 
-		writel(v, MX31_IO_ADDRESS(MX31_OTG_BASE_ADDR +
+		writel(v, MX31_IO_ADDRESS(MX31_USB_BASE_ADDR +
 				     USBCTRL_OTGBASE_OFFSET));
 		return 0;
 	}
 
 	if (cpu_is_mx35()) {
-		v = readl(MX35_IO_ADDRESS(MX35_OTG_BASE_ADDR +
+		v = readl(MX35_IO_ADDRESS(MX35_USB_BASE_ADDR +
 				     USBCTRL_OTGBASE_OFFSET));
 
 		switch (port) {
@@ -196,7 +196,7 @@ int mxc_initialize_usb_hw(int port, unsigned int flags)
 			return -EINVAL;
 		}
 
-		writel(v, MX35_IO_ADDRESS(MX35_OTG_BASE_ADDR +
+		writel(v, MX35_IO_ADDRESS(MX35_USB_BASE_ADDR +
 				     USBCTRL_OTGBASE_OFFSET));
 		return 0;
 	}
@@ -206,7 +206,7 @@ int mxc_initialize_usb_hw(int port, unsigned int flags)
 		/* On i.MX27 we can use the i.MX31 USBCTRL bits, they
 		 * are identical
 		 */
-		v = readl(MX27_IO_ADDRESS(MX27_OTG_BASE_ADDR +
+		v = readl(MX27_IO_ADDRESS(MX27_USB_BASE_ADDR +
 				     USBCTRL_OTGBASE_OFFSET));
 		switch (port) {
 		case 0:	/* OTG port */
@@ -241,7 +241,7 @@ int mxc_initialize_usb_hw(int port, unsigned int flags)
 		default:
 			return -EINVAL;
 		}
-		writel(v, MX27_IO_ADDRESS(MX27_OTG_BASE_ADDR +
+		writel(v, MX27_IO_ADDRESS(MX27_USB_BASE_ADDR +
 				     USBCTRL_OTGBASE_OFFSET));
 		return 0;
 	}
diff --git a/drivers/usb/gadget/fsl_mxc_udc.c b/drivers/usb/gadget/fsl_mxc_udc.c
index 5bdbfe6..77b1eb5 100644
--- a/drivers/usb/gadget/fsl_mxc_udc.c
+++ b/drivers/usb/gadget/fsl_mxc_udc.c
@@ -93,9 +93,9 @@ void fsl_udc_clk_finalize(struct platform_device *pdev)
 
 	/* workaround ENGcm09152 for i.MX35 */
 	if (pdata->workaround & FLS_USB2_WORKAROUND_ENGCM09152) {
-		v = readl(MX35_IO_ADDRESS(MX35_OTG_BASE_ADDR +
+		v = readl(MX35_IO_ADDRESS(MX35_USB_BASE_ADDR +
 				USBPHYCTRL_OTGBASE_OFFSET));
-		writel(v | USBPHYCTRL_EVDO, MX35_IO_ADDRESS(MX35_OTG_BASE_ADDR +
+		writel(v | USBPHYCTRL_EVDO, MX35_IO_ADDRESS(MX35_USB_BASE_ADDR +
 				USBPHYCTRL_OTGBASE_OFFSET));
 	}
 #endif
-- 
1.7.3.2
