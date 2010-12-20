From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 20 Dec 2010 21:29:50 -0200
Subject: [PATCH 1/2] ARM: mx3/mx31_3ds: Add support for OTG host mode
Message-ID: <1292887791-29773-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-mx3/mach-mx31_3ds.c |   36 +++++++++++++++++++++++++++++++++++-
 1 files changed, 35 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mx3/mach-mx31_3ds.c b/arch/arm/mach-mx3/mach-mx31_3ds.c
index c488491..fd7b722 100644
--- a/arch/arm/mach-mx3/mach-mx31_3ds.c
+++ b/arch/arm/mach-mx3/mach-mx31_3ds.c
@@ -22,6 +22,8 @@
 #include <linux/mfd/mc13783.h>
 #include <linux/spi/spi.h>
 #include <linux/regulator/machine.h>
+#include <linux/usb/otg.h>
+#include <linux/usb/ulpi.h>
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
@@ -32,6 +34,7 @@
 #include <mach/common.h>
 #include <mach/iomux-mx3.h>
 #include <mach/3ds_debugboard.h>
+#include <mach/ulpi.h>
 
 #include "devices-imx31.h"
 #include "devices.h"
@@ -212,11 +215,33 @@ usbotg_free_reset:
 	return err;
 }
 
+#if defined(CONFIG_USB_ULPI)
+static struct mxc_usbh_platform_data otg_pdata __initdata = {
+	.portsc	= MXC_EHCI_MODE_ULPI,
+	.flags	= MXC_EHCI_POWER_PINS_ENABLED,
+};
+#endif
+
 static const struct fsl_usb2_platform_data usbotg_pdata __initconst = {
 	.operating_mode = FSL_USB2_DR_DEVICE,
 	.phy_mode	= FSL_USB2_PHY_ULPI,
 };
 
+static int otg_mode_host;
+
+static int __init mx31_3ds_otg_mode(char *options)
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
+__setup("otg_mode=", mx31_3ds_otg_mode);
+
 static const struct imxuart_platform_data uart_pdata __initconst = {
 	.flags = IMXUART_HAVE_RTSCTS,
 };
@@ -247,7 +272,16 @@ static void __init mxc_board_init(void)
 	imx31_add_imx_keypad(&mx31_3ds_keymap_data);
 
 	mx31_3ds_usbotg_init();
-	imx31_add_fsl_usb2_udc(&usbotg_pdata);
+#if defined(CONFIG_USB_ULPI)
+	if (otg_mode_host) {
+		otg_pdata.otg = otg_ulpi_create(&mxc_ulpi_access_ops,
+				ULPI_OTG_DRVVBUS | ULPI_OTG_DRVVBUS_EXT);
+
+		imx31_add_mxc_ehci_otg(&otg_pdata);
+	}
+#endif
+	if (!otg_mode_host)
+		imx31_add_fsl_usb2_udc(&usbotg_pdata);
 
 	if (mxc_expio_init(MX31_CS5_BASE_ADDR, EXPIO_PARENT_INT))
 		printk(KERN_WARNING "Init of the debug board failed, all "
-- 
1.6.0.4
