From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu,  4 Feb 2010 16:03:43 +0100
Subject: [PATCH 6/8] i.MX27 pcm038: Add USB support
In-Reply-To: <1265295825-8705-6-git-send-email-s.hauer@pengutronix.de>
References: <1265295825-8705-1-git-send-email-s.hauer@pengutronix.de>
	<1265295825-8705-2-git-send-email-s.hauer@pengutronix.de>
	<1265295825-8705-3-git-send-email-s.hauer@pengutronix.de>
	<1265295825-8705-4-git-send-email-s.hauer@pengutronix.de>
	<1265295825-8705-5-git-send-email-s.hauer@pengutronix.de>
	<1265295825-8705-6-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1265295825-8705-7-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-mx2/Kconfig       |    1 +
 arch/arm/mach-mx2/mach-pcm038.c |   22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx2/Kconfig b/arch/arm/mach-mx2/Kconfig
index ca1278d..742fd4e 100644
--- a/arch/arm/mach-mx2/Kconfig
+++ b/arch/arm/mach-mx2/Kconfig
@@ -37,6 +37,7 @@ config MACH_MX27ADS
 config MACH_PCM038
 	bool "Phytec phyCORE-i.MX27 CPU module (pcm038)"
 	depends on MACH_MX27
+	select MXC_ULPI if USB_ULPI
 	help
 	  Include support for phyCORE-i.MX27 (aka pcm038) platform. This
 	  includes specific configurations for the module and its peripherals.
diff --git a/arch/arm/mach-mx2/mach-pcm038.c b/arch/arm/mach-mx2/mach-pcm038.c
index e055d9d..5a0169c 100644
--- a/arch/arm/mach-mx2/mach-pcm038.c
+++ b/arch/arm/mach-mx2/mach-pcm038.c
@@ -40,6 +40,8 @@
 #include <mach/imx-uart.h>
 #include <mach/mxc_nand.h>
 #include <mach/spi.h>
+#include <mach/mxc_ehci.h>
+#include <mach/ulpi.h>
 
 #include "devices.h"
 
@@ -96,6 +98,19 @@ static int pcm038_pins[] = {
 	PC17_PF_SSI4_RXD,
 	PC18_PF_SSI4_TXD,
 	PC19_PF_SSI4_CLK,
+	/* USB host */
+	PA0_PF_USBH2_CLK,
+	PA1_PF_USBH2_DIR,
+	PA2_PF_USBH2_DATA7,
+	PA3_PF_USBH2_NXT,
+	PA4_PF_USBH2_STP,
+	PD19_AF_USBH2_DATA4,
+	PD20_AF_USBH2_DATA3,
+	PD21_AF_USBH2_DATA6,
+	PD22_AF_USBH2_DATA0,
+	PD23_AF_USBH2_DATA2,
+	PD24_AF_USBH2_DATA1,
+	PD26_AF_USBH2_DATA5,
 };
 
 /*
@@ -277,6 +292,11 @@ static struct spi_board_info pcm038_spi_board_info[] __initdata = {
 	}
 };
 
+static struct mxc_usbh_platform_data usbh2_pdata = {
+	.portsc	= MXC_EHCI_MODE_ULPI,
+	.flags	= MXC_EHCI_POWER_PINS_ENABLED | MXC_EHCI_INTERFACE_DIFF_UNI,
+};
+
 static void __init pcm038_init(void)
 {
 	mxc_gpio_setup_multiple_pins(pcm038_pins, ARRAY_SIZE(pcm038_pins),
@@ -309,6 +329,8 @@ static void __init pcm038_init(void)
 	spi_register_board_info(pcm038_spi_board_info,
 				ARRAY_SIZE(pcm038_spi_board_info));
 
+	mxc_register_device(&mxc_usbh2, &usbh2_pdata);
+
 	platform_add_devices(platform_devices, ARRAY_SIZE(platform_devices));
 
 #ifdef CONFIG_MACH_PCM970_BASEBOARD
-- 
1.6.6
