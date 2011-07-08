From: juergen.lambrecht@gmail.com (=?UTF-8?q?J=C3=BCrgen=20Lambrecht?=)
Date: Fri,  8 Jul 2011 14:28:33 +0200
Subject: [PATCH] mach-imx: imx27pdk (3ds): add nand flash support
Message-ID: <1310128113-32406-1-git-send-email-J.Lambrecht@televic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds NAND flash support and enables the usage of the BBT.
Tested with Barebox and a JFFS2 rootfs.

Signed-off-by: J?rgen Lambrecht <J.Lambrecht@televic.com>
---
 arch/arm/mach-imx/Kconfig         |    5 +++--
 arch/arm/mach-imx/mach-mx27_3ds.c |   12 ++++++++++++
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 0519dd7..0a3512b 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -274,7 +274,7 @@ config MACH_EUKREA_MBIMX27_BASEBOARD
 endchoice
 
 config MACH_MX27_3DS
-	bool "MX27PDK platform"
+	bool "MX27PDK (3DS) platform"
 	select SOC_IMX27
 	select IMX_HAVE_PLATFORM_FSL_USB2_UDC
 	select IMX_HAVE_PLATFORM_IMX2_WDT
@@ -284,11 +284,12 @@ config MACH_MX27_3DS
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_MXC_EHCI
 	select IMX_HAVE_PLATFORM_MXC_MMC
+	select IMX_HAVE_PLATFORM_MXC_NAND
 	select IMX_HAVE_PLATFORM_SPI_IMX
 	select MXC_DEBUG_BOARD
 	select MXC_ULPI if USB_ULPI
 	help
-	  Include support for MX27PDK platform. This includes specific
+	  Include support for MX27PDK (3DS) platform. This includes specific
 	  configurations for the board and its peripherals.
 
 config MACH_IMX27_VISSTRIM_M10
diff --git a/arch/arm/mach-imx/mach-mx27_3ds.c b/arch/arm/mach-imx/mach-mx27_3ds.c
index 526cbe1..d6780ac 100644
--- a/arch/arm/mach-imx/mach-mx27_3ds.c
+++ b/arch/arm/mach-imx/mach-mx27_3ds.c
@@ -40,6 +40,7 @@
 #include <mach/ulpi.h>
 #include <mach/irqs.h>
 #include <mach/3ds_debugboard.h>
+#include <mach/mxc_nand.h>
 
 #include "devices-imx27.h"
 
@@ -369,6 +370,16 @@ static struct spi_board_info mx27_3ds_spi_devs[] __initdata = {
 	},
 };
 
+/*
+ * NAND Flash
+ */
+static const struct mxc_nand_platform_data
+mx27_3ds_nand_board_info __initconst = {
+	.width		= 1,
+	.hw_ecc		= 1,
+	.flash_bbt	= 1,
+};
+
 static const struct imxi2c_platform_data mx27_3ds_i2c0_data __initconst = {
 	.bitrate = 100000,
 };
@@ -380,6 +391,7 @@ static void __init mx27pdk_init(void)
 	mxc_gpio_setup_multiple_pins(mx27pdk_pins, ARRAY_SIZE(mx27pdk_pins),
 		"mx27pdk");
 	mx27_3ds_sdhc1_enable_level_translator();
+	imx27_add_mxc_nand(&mx27_3ds_nand_board_info);
 	imx27_add_imx_uart0(&uart_pdata);
 	imx27_add_fec(NULL);
 	imx27_add_imx_keypad(&mx27_3ds_keymap_data);
-- 
1.7.1
