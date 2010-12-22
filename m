From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Wed, 22 Dec 2010 12:25:30 -0200
Subject: [PATCH v2 1/3] ARM: mx3/mx35_3ds: Add USB OTG Host mode
Message-ID: <1293027932-13201-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- removed ULPI dependencies

 arch/arm/mach-mx3/mach-mx35_3ds.c |   27 ++++++++++++++++++++++++++-
 1 files changed, 26 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mx3/mach-mx35_3ds.c b/arch/arm/mach-mx3/mach-mx35_3ds.c
index 8bd8992..b1963f2 100644
--- a/arch/arm/mach-mx3/mach-mx35_3ds.c
+++ b/arch/arm/mach-mx3/mach-mx35_3ds.c
@@ -26,6 +26,7 @@
 #include <linux/platform_device.h>
 #include <linux/memory.h>
 #include <linux/gpio.h>
+#include <linux/usb/otg.h>
 
 #include <linux/mtd/physmap.h>
 
@@ -125,6 +126,11 @@ static const struct fsl_usb2_platform_data usb_otg_pdata __initconst = {
 	.phy_mode	= FSL_USB2_PHY_UTMI_WIDE,
 };
 
+static struct mxc_usbh_platform_data otg_pdata __initdata = {
+	.portsc	= MXC_EHCI_MODE_UTMI,
+	.flags	= MXC_EHCI_INTERNAL_PHY,
+};
+
 /* USB HOST config */
 static const struct mxc_usbh_platform_data usb_host_pdata __initconst = {
 	.portsc		= MXC_EHCI_MODE_SERIAL,
@@ -132,6 +138,21 @@ static const struct mxc_usbh_platform_data usb_host_pdata __initconst = {
 			  MXC_EHCI_INTERNAL_PHY,
 };
 
+static int otg_mode_host;
+
+static int __init mx35_3ds_otg_mode(char *options)
+{
+	if (!strcmp(options, "host"))
+		otg_mode_host = 1;
+	else if (!strcmp(options, "device"))
+		otg_mode_host = 0;
+	else
+		pr_info("otg_mode neither \"host\" nor \"device\". "
+			"Defaulting to device\n");
+	return 0;
+}
+__setup("otg_mode=", mx35_3ds_otg_mode);
+
 /*
  * Board specific initialization.
  */
@@ -145,10 +166,14 @@ static void __init mxc_board_init(void)
 
 	imx35_add_imx_uart0(&uart_pdata);
 
-	imx35_add_fsl_usb2_udc(&usb_otg_pdata);
+	if (otg_mode_host)
+		imx35_add_mxc_ehci_otg(&otg_pdata);
 
 	imx35_add_mxc_ehci_hs(&usb_host_pdata);
 
+	if (!otg_mode_host)
+		imx35_add_fsl_usb2_udc(&usb_otg_pdata);
+
 	imx35_add_mxc_nand(&mx35pdk_nand_board_info);
 	imx35_add_sdhci_esdhc_imx(0, NULL);
 
-- 
1.6.0.4
