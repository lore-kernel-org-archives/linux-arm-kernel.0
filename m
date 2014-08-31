From: shc_work@mail.ru (Alexander Shiyan)
Date: Sun, 31 Aug 2014 15:54:14 +0400
Subject: [PATCH 1/2] ARM: i.MX: Remove i.MX1 ADS board support
Message-ID: <1409486055-21541-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mx1ads.c can be replaced with devicetree equivalent: imx1-ads.dts,
so remove the board file.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/configs/imx_v4_v5_defconfig |   1 -
 arch/arm/mach-imx/Kconfig            |  11 ---
 arch/arm/mach-imx/Makefile           |   1 -
 arch/arm/mach-imx/mach-mx1ads.c      | 154 -----------------------------------
 4 files changed, 167 deletions(-)
 delete mode 100644 arch/arm/mach-imx/mach-mx1ads.c

diff --git a/arch/arm/configs/imx_v4_v5_defconfig b/arch/arm/configs/imx_v4_v5_defconfig
index 9d73e69..a3fb866 100644
--- a/arch/arm/configs/imx_v4_v5_defconfig
+++ b/arch/arm/configs/imx_v4_v5_defconfig
@@ -22,7 +22,6 @@ CONFIG_ARCH_MULTI_V5=y
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_MXC=y
 CONFIG_MXC_IRQ_PRIOR=y
-CONFIG_ARCH_MX1ADS=y
 CONFIG_MACH_SCB9328=y
 CONFIG_MACH_APF9328=y
 CONFIG_MACH_MX21ADS=y
diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 64161aa..3da9f71 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -109,17 +109,6 @@ config SOC_IMX35
 if ARCH_MULTI_V4T
 
 comment "MX1 platforms:"
-config MACH_MXLADS
-	bool
-
-config ARCH_MX1ADS
-	bool "MX1ADS platform"
-	select IMX_HAVE_PLATFORM_IMX_I2C
-	select IMX_HAVE_PLATFORM_IMX_UART
-	select MACH_MXLADS
-	select SOC_IMX1
-	help
-	  Say Y here if you are using Motorola MX1ADS/MXLADS boards
 
 config MACH_SCB9328
 	bool "Synertronixx scb9328"
diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index 9f1c359..88e5289 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -41,7 +41,6 @@ obj-y += ssi-fiq-ksym.o
 endif
 
 # i.MX1 based machines
-obj-$(CONFIG_ARCH_MX1ADS) += mach-mx1ads.o
 obj-$(CONFIG_MACH_SCB9328) += mach-scb9328.o
 obj-$(CONFIG_MACH_APF9328) += mach-apf9328.o
 obj-$(CONFIG_MACH_IMX1_DT) += imx1-dt.o
diff --git a/arch/arm/mach-imx/mach-mx1ads.c b/arch/arm/mach-imx/mach-mx1ads.c
deleted file mode 100644
index 77fda3d..0000000
--- a/arch/arm/mach-imx/mach-mx1ads.c
+++ /dev/null
@@ -1,154 +0,0 @@
-/*
- * arch/arm/mach-imx/mach-mx1ads.c
- *
- * Initially based on:
- *	linux-2.6.7-imx/arch/arm/mach-imx/scb9328.c
- *	Copyright (c) 2004 Sascha Hauer <sascha@saschahauer.de>
- *
- * 2004 (c) MontaVista Software, Inc.
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#include <linux/i2c.h>
-#include <linux/i2c/pcf857x.h>
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/platform_device.h>
-#include <linux/mtd/physmap.h>
-
-#include <asm/mach-types.h>
-#include <asm/mach/arch.h>
-#include <asm/mach/time.h>
-
-#include "common.h"
-#include "devices-imx1.h"
-#include "hardware.h"
-#include "iomux-mx1.h"
-
-static const int mx1ads_pins[] __initconst = {
-	/* UART1 */
-	PC9_PF_UART1_CTS,
-	PC10_PF_UART1_RTS,
-	PC11_PF_UART1_TXD,
-	PC12_PF_UART1_RXD,
-	/* UART2 */
-	PB28_PF_UART2_CTS,
-	PB29_PF_UART2_RTS,
-	PB30_PF_UART2_TXD,
-	PB31_PF_UART2_RXD,
-	/* I2C */
-	PA15_PF_I2C_SDA,
-	PA16_PF_I2C_SCL,
-	/* SPI */
-	PC13_PF_SPI1_SPI_RDY,
-	PC14_PF_SPI1_SCLK,
-	PC15_PF_SPI1_SS,
-	PC16_PF_SPI1_MISO,
-	PC17_PF_SPI1_MOSI,
-};
-
-/*
- * UARTs platform data
- */
-
-static const struct imxuart_platform_data uart0_pdata __initconst = {
-	.flags = IMXUART_HAVE_RTSCTS,
-};
-       
-static const struct imxuart_platform_data uart1_pdata __initconst = {
-	.flags = IMXUART_HAVE_RTSCTS,
-};
-
-/*
- * Physmap flash
- */
-
-static const struct physmap_flash_data mx1ads_flash_data __initconst = {
-	.width		= 4,		/* bankwidth in bytes */
-};
-
-static const struct resource flash_resource __initconst = {
-	.start	= MX1_CS0_PHYS,
-	.end	= MX1_CS0_PHYS + SZ_32M - 1,
-	.flags	= IORESOURCE_MEM,
-};
-
-/*
- * I2C
- */
-static struct pcf857x_platform_data pcf857x_data[] = {
-	{
-		.gpio_base = 4 * 32,
-	}, {
-		.gpio_base = 4 * 32 + 16,
-	}
-};
-
-static const struct imxi2c_platform_data mx1ads_i2c_data __initconst = {
-	.bitrate = 100000,
-};
-
-static struct i2c_board_info mx1ads_i2c_devices[] = {
-	{
-		I2C_BOARD_INFO("pcf8575", 0x22),
-		.platform_data = &pcf857x_data[0],
-	}, {
-		I2C_BOARD_INFO("pcf8575", 0x24),
-		.platform_data = &pcf857x_data[1],
-	},
-};
-
-/*
- * Board init
- */
-static void __init mx1ads_init(void)
-{
-	imx1_soc_init();
-
-	mxc_gpio_setup_multiple_pins(mx1ads_pins,
-		ARRAY_SIZE(mx1ads_pins), "mx1ads");
-
-	/* UART */
-	imx1_add_imx_uart0(&uart0_pdata);
-	imx1_add_imx_uart1(&uart1_pdata);
-
-	/* Physmap flash */
-	platform_device_register_resndata(NULL, "physmap-flash", 0,
-			&flash_resource, 1,
-			&mx1ads_flash_data, sizeof(mx1ads_flash_data));
-
-	/* I2C */
-	i2c_register_board_info(0, mx1ads_i2c_devices,
-				ARRAY_SIZE(mx1ads_i2c_devices));
-
-	imx1_add_imx_i2c(&mx1ads_i2c_data);
-}
-
-static void __init mx1ads_timer_init(void)
-{
-	mx1_clocks_init(32000);
-}
-
-MACHINE_START(MX1ADS, "Freescale MX1ADS")
-	/* Maintainer: Sascha Hauer, Pengutronix */
-	.atag_offset = 0x100,
-	.map_io = mx1_map_io,
-	.init_early = imx1_init_early,
-	.init_irq = mx1_init_irq,
-	.init_time	= mx1ads_timer_init,
-	.init_machine = mx1ads_init,
-	.restart	= mxc_restart,
-MACHINE_END
-
-MACHINE_START(MXLADS, "Freescale MXLADS")
-	.atag_offset = 0x100,
-	.map_io = mx1_map_io,
-	.init_early = imx1_init_early,
-	.init_irq = mx1_init_irq,
-	.init_time	= mx1ads_timer_init,
-	.init_machine = mx1ads_init,
-	.restart	= mxc_restart,
-MACHINE_END
-- 
1.8.5.5
