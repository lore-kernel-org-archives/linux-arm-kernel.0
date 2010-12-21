From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Tue, 21 Dec 2010 17:58:39 -0200
Subject: [PATCH 1/3] ARM: mx3/mx35_3ds: Add USB OTG Host mode
Message-ID: <1292961521-31539-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-mx3/Kconfig         |    1 +
 arch/arm/mach-mx3/mach-mx35_3ds.c |   34 ++++++++++++++++++++++++++++++++--
 2 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mx3/Kconfig b/arch/arm/mach-mx3/Kconfig
index 9037c4e..f474e2e 100644
--- a/arch/arm/mach-mx3/Kconfig
+++ b/arch/arm/mach-mx3/Kconfig
@@ -185,6 +185,7 @@ config MACH_MX35_3DS
 	select IMX_HAVE_PLATFORM_MXC_EHCI
 	select IMX_HAVE_PLATFORM_MXC_NAND
 	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
+	select MXC_ULPI if USB_ULPI
 	help
 	  Include support for MX35PDK platform. This includes specific
 	  configurations for the board and its peripherals.
diff --git a/arch/arm/mach-mx3/mach-mx35_3ds.c b/arch/arm/mach-mx3/mach-mx35_3ds.c
index 8bd8992..3cb4f5c 100644
--- a/arch/arm/mach-mx3/mach-mx35_3ds.c
+++ b/arch/arm/mach-mx3/mach-mx35_3ds.c
@@ -26,6 +26,8 @@
 #include <linux/platform_device.h>
 #include <linux/memory.h>
 #include <linux/gpio.h>
+#include <linux/usb/otg.h>
+#include <linux/usb/ulpi.h>
 
 #include <linux/mtd/physmap.h>
 
@@ -39,6 +41,7 @@
 #include <mach/iomux-mx35.h>
 #include <mach/irqs.h>
 #include <mach/3ds_debugboard.h>
+#include <mach/ulpi.h>
 
 #include "devices-imx35.h"
 #include "devices.h"
@@ -125,12 +128,34 @@ static const struct fsl_usb2_platform_data usb_otg_pdata __initconst = {
 	.phy_mode	= FSL_USB2_PHY_UTMI_WIDE,
 };
 
+#if defined(CONFIG_USB_ULPI)
+static struct mxc_usbh_platform_data otg_pdata __initdata = {
+	.portsc	= MXC_EHCI_MODE_UTMI,
+	.flags	= MXC_EHCI_INTERNAL_PHY,
+};
+
 /* USB HOST config */
 static const struct mxc_usbh_platform_data usb_host_pdata __initconst = {
 	.portsc		= MXC_EHCI_MODE_SERIAL,
 	.flags		= MXC_EHCI_INTERFACE_SINGLE_UNI |
 			  MXC_EHCI_INTERNAL_PHY,
 };
+#endif
+
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
 
 /*
  * Board specific initialization.
@@ -144,10 +169,15 @@ static void __init mxc_board_init(void)
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 
 	imx35_add_imx_uart0(&uart_pdata);
-
-	imx35_add_fsl_usb2_udc(&usb_otg_pdata);
+
+#if defined(CONFIG_USB_ULPI)
+	if (otg_mode_host)
+		imx35_add_mxc_ehci_otg(&otg_pdata);
 
 	imx35_add_mxc_ehci_hs(&usb_host_pdata);
+#endif
+	if (!otg_mode_host)
+		imx35_add_fsl_usb2_udc(&usb_otg_pdata);
 
 	imx35_add_mxc_nand(&mx35pdk_nand_board_info);
 	imx35_add_sdhci_esdhc_imx(0, NULL);
-- 
1.6.0.4
