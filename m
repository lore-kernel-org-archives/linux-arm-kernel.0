From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu,  4 Feb 2010 16:03:45 +0100
Subject: [PATCH 8/8] i.MX27 pca100: Add USB support
In-Reply-To: <1265295825-8705-8-git-send-email-s.hauer@pengutronix.de>
References: <1265295825-8705-1-git-send-email-s.hauer@pengutronix.de>
	<1265295825-8705-2-git-send-email-s.hauer@pengutronix.de>
	<1265295825-8705-3-git-send-email-s.hauer@pengutronix.de>
	<1265295825-8705-4-git-send-email-s.hauer@pengutronix.de>
	<1265295825-8705-5-git-send-email-s.hauer@pengutronix.de>
	<1265295825-8705-6-git-send-email-s.hauer@pengutronix.de>
	<1265295825-8705-7-git-send-email-s.hauer@pengutronix.de>
	<1265295825-8705-8-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1265295825-8705-9-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-mx3/Kconfig       |    1 +
 arch/arm/mach-mx3/mach-pcm043.c |   53 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx3/Kconfig b/arch/arm/mach-mx3/Kconfig
index 2232b7b..3872af1 100644
--- a/arch/arm/mach-mx3/Kconfig
+++ b/arch/arm/mach-mx3/Kconfig
@@ -87,6 +87,7 @@ config MACH_QONG
 config MACH_PCM043
 	bool "Support Phytec pcm043 (i.MX35) platforms"
 	select ARCH_MX35
+	select MXC_ULPI if USB_ULPI
 	help
 	  Include support for Phytec pcm043 platform. This includes
 	  specific configurations for the board and its peripherals.
diff --git a/arch/arm/mach-mx3/mach-pcm043.c b/arch/arm/mach-mx3/mach-pcm043.c
index 25942b8..a9741c2 100644
--- a/arch/arm/mach-mx3/mach-pcm043.c
+++ b/arch/arm/mach-mx3/mach-pcm043.c
@@ -28,6 +28,9 @@
 #include <linux/interrupt.h>
 #include <linux/i2c.h>
 #include <linux/i2c/at24.h>
+#include <linux/usb/otg.h>
+#include <linux/usb/ulpi.h>
+#include <linux/fsl_devices.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -44,6 +47,8 @@
 #include <mach/ipu.h>
 #include <mach/mx3fb.h>
 #include <mach/mxc_nand.h>
+#include <mach/mxc_ehci.h>
+#include <mach/ulpi.h>
 
 #include "devices.h"
 
@@ -205,6 +210,9 @@ static struct pad_desc pcm043_pads[] = {
 	MX35_PAD_D3_CLS__IPU_DISPB_D3_CLS,
 	/* gpio */
 	MX35_PAD_ATA_CS0__GPIO2_6,
+	/* USB host */
+	MX35_PAD_I2C2_CLK__USB_TOP_USBH2_PWR,
+	MX35_PAD_I2C2_DAT__USB_TOP_USBH2_OC,
 };
 
 static struct mxc_nand_platform_data pcm037_nand_board_info = {
@@ -212,6 +220,37 @@ static struct mxc_nand_platform_data pcm037_nand_board_info = {
 	.hw_ecc = 1,
 };
 
+static struct mxc_usbh_platform_data otg_pdata = {
+	.portsc	= MXC_EHCI_MODE_UTMI,
+	.flags	= MXC_EHCI_INTERFACE_DIFF_UNI,
+};
+
+static struct mxc_usbh_platform_data usbh1_pdata = {
+	.portsc	= MXC_EHCI_MODE_SERIAL,
+	.flags	= MXC_EHCI_INTERFACE_SINGLE_UNI | MXC_EHCI_INTERNAL_PHY |
+		  MXC_EHCI_IPPUE_DOWN,
+};
+
+static struct fsl_usb2_platform_data otg_device_pdata = {
+	.operating_mode = FSL_USB2_DR_DEVICE,
+	.phy_mode       = FSL_USB2_PHY_UTMI,
+};
+
+static int otg_mode_host;
+
+static int __init pcm043_otg_mode(char *options)
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
+__setup("otg_mode=", pcm043_otg_mode);
+
 /*
  * Board specific initialization.
  */
@@ -235,6 +274,20 @@ static void __init mxc_board_init(void)
 
 	mxc_register_device(&mx3_ipu, &mx3_ipu_data);
 	mxc_register_device(&mx3_fb, &mx3fb_pdata);
+
+#if defined(CONFIG_USB_ULPI)
+	if (otg_mode_host) {
+		otg_pdata.otg = otg_ulpi_create(&mxc_ulpi_access_ops,
+				USB_OTG_DRV_VBUS | USB_OTG_DRV_VBUS_EXT);
+
+		mxc_register_device(&mxc_otg_host, &otg_pdata);
+	}
+
+	mxc_register_device(&mxc_usbh1, &usbh1_pdata);
+#endif
+	if (!otg_mode_host)
+		mxc_register_device(&mxc_otg_udc_device, &otg_device_pdata);
+
 }
 
 static void __init pcm043_timer_init(void)
-- 
1.6.6
