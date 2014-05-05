From: festevam@gmail.com (Fabio Estevam)
Date: Mon,  5 May 2014 19:00:48 -0300
Subject: [PATCH 2/2] ARM: dts: mx51: Remove mach-cpuimx51sd board file
In-Reply-To: <1399327248-17887-1-git-send-email-festevam@gmail.com>
References: <1399327248-17887-1-git-send-email-festevam@gmail.com>
Message-ID: <1399327248-17887-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

eukrea_mbimxsd51-baseboard.c and mach-cpuimx51sd.c can be replaced with their
devicetree equivalents: imx51-eukrea-mbimxsd51-baseboard.dts and 
imx51-eukrea-cpuimx51.dtsi respectively, so remove the board files.

This allows the conversion of mx51 to a devicetree-only platform.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/configs/imx_v6_v7_defconfig           |   1 -
 arch/arm/mach-imx/Kconfig                      |  46 +---
 arch/arm/mach-imx/Makefile                     |   4 -
 arch/arm/mach-imx/eukrea_mbimxsd51-baseboard.c | 231 ----------------
 arch/arm/mach-imx/mach-cpuimx51sd.c            | 364 -------------------------
 5 files changed, 6 insertions(+), 640 deletions(-)
 delete mode 100644 arch/arm/mach-imx/eukrea_mbimxsd51-baseboard.c
 delete mode 100644 arch/arm/mach-imx/mach-cpuimx51sd.c

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 9fc3024..eced58e 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -32,7 +32,6 @@ CONFIG_MACH_PCM043=y
 CONFIG_MACH_MX35_3DS=y
 CONFIG_MACH_VPR200=y
 CONFIG_MACH_IMX51_DT=y
-CONFIG_MACH_EUKREA_CPUIMX51SD=y
 CONFIG_SOC_IMX50=y
 CONFIG_SOC_IMX53=y
 CONFIG_SOC_IMX6Q=y
diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index d56eb1a..839ef51 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -702,46 +702,6 @@ endif
 
 if ARCH_MULTI_V7
 
-comment "i.MX51 machines:"
-
-config MACH_IMX51_DT
-	bool "Support i.MX51 platforms from device tree"
-	select SOC_IMX51
-	help
-	  Include support for Freescale i.MX51 based platforms
-	  using the device tree for discovery
-
-config MACH_EUKREA_CPUIMX51SD
-	bool "Support Eukrea CPUIMX51SD module"
-	select IMX_HAVE_PLATFORM_FSL_USB2_UDC
-	select IMX_HAVE_PLATFORM_IMX2_WDT
-	select IMX_HAVE_PLATFORM_IMX_I2C
-	select IMX_HAVE_PLATFORM_IMX_UART
-	select IMX_HAVE_PLATFORM_MXC_EHCI
-	select IMX_HAVE_PLATFORM_MXC_NAND
-	select IMX_HAVE_PLATFORM_SPI_IMX
-	select SOC_IMX51
-	help
-	  Include support for Eukrea CPUIMX51SD platform. This includes
-	  specific configurations for the module and its peripherals.
-
-choice
-	prompt "Baseboard"
-	depends on MACH_EUKREA_CPUIMX51SD
-	default MACH_EUKREA_MBIMXSD51_BASEBOARD
-
-config MACH_EUKREA_MBIMXSD51_BASEBOARD
-	prompt "Eukrea MBIMXSD development board"
-	bool
-	select IMX_HAVE_PLATFORM_IMX_SSI
-	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
-	select LEDS_GPIO_REGISTER
-	help
-	  This adds board specific devices that can be found on Eukrea's
-	  MBIMXSD evaluation board.
-
-endchoice
-
 comment "Device tree only"
 
 config	SOC_IMX50
@@ -753,6 +713,12 @@ config	SOC_IMX50
 	help
 	  This enables support for Freescale i.MX50 processor.
 
+config MACH_IMX51_DT
+	bool "i.MX51 support"
+	select SOC_IMX51
+	help
+	  This enables support for Freescale i.MX51 processor
+
 config	SOC_IMX53
 	bool "i.MX53 support"
 	select HAVE_IMX_SRC
diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index 8dd377b..572e1ab 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -108,10 +108,6 @@ obj-$(CONFIG_SOC_IMX6) += suspend-imx6.o
 endif
 obj-$(CONFIG_SOC_IMX6) += pm-imx6.o
 
-# i.MX5 based machines
-obj-$(CONFIG_MACH_EUKREA_CPUIMX51SD) += mach-cpuimx51sd.o
-obj-$(CONFIG_MACH_EUKREA_MBIMXSD51_BASEBOARD) += eukrea_mbimxsd51-baseboard.o
-
 obj-$(CONFIG_MACH_IMX51_DT) += imx51-dt.o
 obj-$(CONFIG_SOC_IMX50) += mach-imx50.o
 obj-$(CONFIG_SOC_IMX53) += mach-imx53.o
diff --git a/arch/arm/mach-imx/eukrea_mbimxsd51-baseboard.c b/arch/arm/mach-imx/eukrea_mbimxsd51-baseboard.c
deleted file mode 100644
index 9be6c1e..0000000
--- a/arch/arm/mach-imx/eukrea_mbimxsd51-baseboard.c
+++ /dev/null
@@ -1,231 +0,0 @@
-/*
- * Copyright (C) 2010 Eric Benard - eric at eukrea.com
- *
- * Based on pcm970-baseboard.c which is :
- * Copyright (C) 2008 Juergen Beisert (kernel at pengutronix.de)
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version 2
- * of the License, or (at your option) any later version.
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
- * MA 02110-1301, USA.
- */
-
-#include <linux/types.h>
-#include <linux/init.h>
-
-#include <linux/gpio.h>
-#include <linux/interrupt.h>
-#include <linux/leds.h>
-#include <linux/platform_device.h>
-#include <linux/input.h>
-#include <linux/i2c.h>
-#include <video/platform_lcd.h>
-#include <linux/backlight.h>
-
-#include <asm/mach-types.h>
-#include <asm/mach/arch.h>
-#include <asm/mach/time.h>
-#include <asm/mach/map.h>
-
-#include "common.h"
-#include "devices-imx51.h"
-#include "hardware.h"
-#include "iomux-mx51.h"
-
-static iomux_v3_cfg_t eukrea_mbimxsd51_pads[] = {
-	/* LED */
-	MX51_PAD_NANDF_D10__GPIO3_30,
-	/* SWITCH */
-	NEW_PAD_CTRL(MX51_PAD_NANDF_D9__GPIO3_31, PAD_CTL_PUS_22K_UP |
-			PAD_CTL_PKE | PAD_CTL_SRE_FAST |
-			PAD_CTL_DSE_HIGH | PAD_CTL_PUE | PAD_CTL_HYS),
-	/* UART2 */
-	MX51_PAD_UART2_RXD__UART2_RXD,
-	MX51_PAD_UART2_TXD__UART2_TXD,
-	/* UART 3 */
-	MX51_PAD_UART3_RXD__UART3_RXD,
-	MX51_PAD_UART3_TXD__UART3_TXD,
-	MX51_PAD_KEY_COL4__UART3_RTS,
-	MX51_PAD_KEY_COL5__UART3_CTS,
-	/* SD */
-	MX51_PAD_SD1_CMD__SD1_CMD,
-	MX51_PAD_SD1_CLK__SD1_CLK,
-	MX51_PAD_SD1_DATA0__SD1_DATA0,
-	MX51_PAD_SD1_DATA1__SD1_DATA1,
-	MX51_PAD_SD1_DATA2__SD1_DATA2,
-	MX51_PAD_SD1_DATA3__SD1_DATA3,
-	/* SD1 CD */
-	NEW_PAD_CTRL(MX51_PAD_GPIO1_0__SD1_CD, PAD_CTL_PUS_22K_UP |
-			PAD_CTL_PKE | PAD_CTL_SRE_FAST |
-			PAD_CTL_DSE_HIGH | PAD_CTL_PUE | PAD_CTL_HYS),
-	/* SSI */
-	MX51_PAD_AUD3_BB_TXD__AUD3_TXD,
-	MX51_PAD_AUD3_BB_RXD__AUD3_RXD,
-	MX51_PAD_AUD3_BB_CK__AUD3_TXC,
-	MX51_PAD_AUD3_BB_FS__AUD3_TXFS,
-	/* LCD Backlight */
-	MX51_PAD_DI1_D1_CS__GPIO3_4,
-	/* LCD RST */
-	MX51_PAD_CSI1_D9__GPIO3_13,
-};
-
-#define GPIO_LED1	IMX_GPIO_NR(3, 30)
-#define GPIO_SWITCH1	IMX_GPIO_NR(3, 31)
-#define GPIO_LCDRST	IMX_GPIO_NR(3, 13)
-#define GPIO_LCDBL	IMX_GPIO_NR(3, 4)
-
-static void eukrea_mbimxsd51_lcd_power_set(struct plat_lcd_data *pd,
-				   unsigned int power)
-{
-	if (power)
-		gpio_direction_output(GPIO_LCDRST, 1);
-	else
-		gpio_direction_output(GPIO_LCDRST, 0);
-}
-
-static struct plat_lcd_data eukrea_mbimxsd51_lcd_power_data = {
-	.set_power		= eukrea_mbimxsd51_lcd_power_set,
-};
-
-static struct platform_device eukrea_mbimxsd51_lcd_powerdev = {
-	.name			= "platform-lcd",
-	.dev.platform_data	= &eukrea_mbimxsd51_lcd_power_data,
-};
-
-static void eukrea_mbimxsd51_bl_set_intensity(int intensity)
-{
-	if (intensity)
-		gpio_direction_output(GPIO_LCDBL, 1);
-	else
-		gpio_direction_output(GPIO_LCDBL, 0);
-}
-
-static struct generic_bl_info eukrea_mbimxsd51_bl_info = {
-	.name			= "eukrea_mbimxsd51-bl",
-	.max_intensity		= 0xff,
-	.default_intensity	= 0xff,
-	.set_bl_intensity	= eukrea_mbimxsd51_bl_set_intensity,
-};
-
-static struct platform_device eukrea_mbimxsd51_bl_dev = {
-	.name			= "generic-bl",
-	.id			= 1,
-	.dev = {
-		.platform_data	= &eukrea_mbimxsd51_bl_info,
-	},
-};
-
-static const struct gpio_led eukrea_mbimxsd51_leds[] __initconst = {
-	{
-		.name			= "led1",
-		.default_trigger	= "heartbeat",
-		.active_low		= 1,
-		.gpio			= GPIO_LED1,
-	},
-};
-
-static const struct gpio_led_platform_data
-		eukrea_mbimxsd51_led_info __initconst = {
-	.leds		= eukrea_mbimxsd51_leds,
-	.num_leds	= ARRAY_SIZE(eukrea_mbimxsd51_leds),
-};
-
-static struct gpio_keys_button eukrea_mbimxsd51_gpio_buttons[] = {
-	{
-		.gpio		= GPIO_SWITCH1,
-		.code		= BTN_0,
-		.desc		= "BP1",
-		.active_low	= 1,
-		.wakeup		= 1,
-	},
-};
-
-static const struct gpio_keys_platform_data
-		eukrea_mbimxsd51_button_data __initconst = {
-	.buttons	= eukrea_mbimxsd51_gpio_buttons,
-	.nbuttons	= ARRAY_SIZE(eukrea_mbimxsd51_gpio_buttons),
-};
-
-static const struct imxuart_platform_data uart_pdata __initconst = {
-	.flags = IMXUART_HAVE_RTSCTS,
-};
-
-static struct i2c_board_info eukrea_mbimxsd51_i2c_devices[] = {
-	{
-		I2C_BOARD_INFO("tlv320aic23", 0x1a),
-	},
-};
-
-static const
-struct imx_ssi_platform_data eukrea_mbimxsd51_ssi_pdata __initconst = {
-	.flags = IMX_SSI_SYN | IMX_SSI_NET | IMX_SSI_USE_I2S_SLAVE,
-};
-
-static int screen_type;
-
-static int __init eukrea_mbimxsd51_screen_type(char *options)
-{
-	if (!strcmp(options, "dvi"))
-		screen_type = 1;
-	else if (!strcmp(options, "tft"))
-		screen_type = 0;
-
-	return 0;
-}
-__setup("screen_type=", eukrea_mbimxsd51_screen_type);
-
-/*
- * system init for baseboard usage. Will be called by cpuimx51sd init.
- *
- * Add platform devices present on this baseboard and init
- * them from CPU side as far as required to use them later on
- */
-void __init eukrea_mbimxsd51_baseboard_init(void)
-{
-	if (mxc_iomux_v3_setup_multiple_pads(eukrea_mbimxsd51_pads,
-			ARRAY_SIZE(eukrea_mbimxsd51_pads)))
-		printk(KERN_ERR "error setting mbimxsd pads !\n");
-
-	imx51_add_imx_uart(1, NULL);
-	imx51_add_imx_uart(2, &uart_pdata);
-
-	imx51_add_sdhci_esdhc_imx(0, NULL);
-
-	imx51_add_imx_ssi(0, &eukrea_mbimxsd51_ssi_pdata);
-
-	gpio_request(GPIO_LED1, "LED1");
-	gpio_direction_output(GPIO_LED1, 1);
-	gpio_free(GPIO_LED1);
-
-	gpio_request(GPIO_SWITCH1, "SWITCH1");
-	gpio_direction_input(GPIO_SWITCH1);
-	gpio_free(GPIO_SWITCH1);
-
-	gpio_request(GPIO_LCDRST, "LCDRST");
-	gpio_direction_output(GPIO_LCDRST, 0);
-	gpio_request(GPIO_LCDBL, "LCDBL");
-	gpio_direction_output(GPIO_LCDBL, 0);
-	if (!screen_type) {
-		platform_device_register(&eukrea_mbimxsd51_bl_dev);
-		platform_device_register(&eukrea_mbimxsd51_lcd_powerdev);
-	} else {
-		gpio_free(GPIO_LCDRST);
-		gpio_free(GPIO_LCDBL);
-	}
-
-	i2c_register_board_info(0, eukrea_mbimxsd51_i2c_devices,
-				ARRAY_SIZE(eukrea_mbimxsd51_i2c_devices));
-
-	gpio_led_register_device(-1, &eukrea_mbimxsd51_led_info);
-	imx_add_gpio_keys(&eukrea_mbimxsd51_button_data);
-	imx_add_platform_device("eukrea_tlv320", 0, NULL, 0, NULL, 0);
-}
diff --git a/arch/arm/mach-imx/mach-cpuimx51sd.c b/arch/arm/mach-imx/mach-cpuimx51sd.c
deleted file mode 100644
index 1fba2b8..0000000
--- a/arch/arm/mach-imx/mach-cpuimx51sd.c
+++ /dev/null
@@ -1,364 +0,0 @@
-/*
- *
- * Copyright (C) 2010 Eric B?nard <eric@eukrea.com>
- *
- * based on board-mx51_babbage.c which is
- * Copyright 2009 Freescale Semiconductor, Inc. All Rights Reserved.
- * Copyright (C) 2009-2010 Amit Kucheria <amit.kucheria@canonical.com>
- *
- * The code contained herein is licensed under the GNU General Public
- * License. You may obtain a copy of the GNU General Public License
- * Version 2 or later at the following locations:
- *
- * http://www.opensource.org/licenses/gpl-license.html
- * http://www.gnu.org/copyleft/gpl.html
- */
-
-#include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/i2c.h>
-#include <linux/i2c/tsc2007.h>
-#include <linux/gpio.h>
-#include <linux/delay.h>
-#include <linux/io.h>
-#include <linux/interrupt.h>
-#include <linux/i2c-gpio.h>
-#include <linux/spi/spi.h>
-#include <linux/can/platform/mcp251x.h>
-
-#include <asm/setup.h>
-#include <asm/mach-types.h>
-#include <asm/mach/arch.h>
-#include <asm/mach/time.h>
-
-#include "common.h"
-#include "devices-imx51.h"
-#include "eukrea-baseboards.h"
-#include "hardware.h"
-#include "iomux-mx51.h"
-
-#define USBH1_RST		IMX_GPIO_NR(2, 28)
-#define ETH_RST			IMX_GPIO_NR(2, 31)
-#define TSC2007_IRQGPIO_REV2	IMX_GPIO_NR(3, 12)
-#define TSC2007_IRQGPIO_REV3	IMX_GPIO_NR(4, 0)
-#define CAN_IRQGPIO		IMX_GPIO_NR(1, 1)
-#define CAN_RST			IMX_GPIO_NR(4, 15)
-#define CAN_NCS			IMX_GPIO_NR(4, 24)
-#define CAN_RXOBF_REV2		IMX_GPIO_NR(1, 4)
-#define CAN_RXOBF_REV3		IMX_GPIO_NR(3, 12)
-#define CAN_RX1BF		IMX_GPIO_NR(1, 6)
-#define CAN_TXORTS		IMX_GPIO_NR(1, 7)
-#define CAN_TX1RTS		IMX_GPIO_NR(1, 8)
-#define CAN_TX2RTS		IMX_GPIO_NR(1, 9)
-#define I2C_SCL			IMX_GPIO_NR(4, 16)
-#define I2C_SDA			IMX_GPIO_NR(4, 17)
-
-/* USB_CTRL_1 */
-#define MX51_USB_CTRL_1_OFFSET		0x10
-#define MX51_USB_CTRL_UH1_EXT_CLK_EN	(1 << 25)
-
-#define	MX51_USB_PLLDIV_12_MHZ		0x00
-#define	MX51_USB_PLL_DIV_19_2_MHZ	0x01
-#define	MX51_USB_PLL_DIV_24_MHZ		0x02
-
-static iomux_v3_cfg_t eukrea_cpuimx51sd_pads[] = {
-	/* UART1 */
-	MX51_PAD_UART1_RXD__UART1_RXD,
-	MX51_PAD_UART1_TXD__UART1_TXD,
-	MX51_PAD_UART1_RTS__UART1_RTS,
-	MX51_PAD_UART1_CTS__UART1_CTS,
-
-	/* USB HOST1 */
-	MX51_PAD_USBH1_CLK__USBH1_CLK,
-	MX51_PAD_USBH1_DIR__USBH1_DIR,
-	MX51_PAD_USBH1_NXT__USBH1_NXT,
-	MX51_PAD_USBH1_DATA0__USBH1_DATA0,
-	MX51_PAD_USBH1_DATA1__USBH1_DATA1,
-	MX51_PAD_USBH1_DATA2__USBH1_DATA2,
-	MX51_PAD_USBH1_DATA3__USBH1_DATA3,
-	MX51_PAD_USBH1_DATA4__USBH1_DATA4,
-	MX51_PAD_USBH1_DATA5__USBH1_DATA5,
-	MX51_PAD_USBH1_DATA6__USBH1_DATA6,
-	MX51_PAD_USBH1_DATA7__USBH1_DATA7,
-	MX51_PAD_USBH1_STP__USBH1_STP,
-	MX51_PAD_EIM_CS3__GPIO2_28,		/* PHY nRESET */
-
-	/* FEC */
-	MX51_PAD_EIM_DTACK__GPIO2_31,		/* PHY nRESET */
-
-	/* HSI2C */
-	MX51_PAD_I2C1_CLK__GPIO4_16,
-	MX51_PAD_I2C1_DAT__GPIO4_17,
-
-	/* I2C1 */
-	MX51_PAD_SD2_CMD__I2C1_SCL,
-	MX51_PAD_SD2_CLK__I2C1_SDA,
-
-	/* CAN */
-	MX51_PAD_CSPI1_MOSI__ECSPI1_MOSI,
-	MX51_PAD_CSPI1_MISO__ECSPI1_MISO,
-	MX51_PAD_CSPI1_SCLK__ECSPI1_SCLK,
-	MX51_PAD_CSPI1_SS0__GPIO4_24,		/* nCS */
-	MX51_PAD_CSI2_PIXCLK__GPIO4_15,		/* nReset */
-	MX51_PAD_GPIO1_1__GPIO1_1,		/* IRQ */
-	MX51_PAD_GPIO1_4__GPIO1_4,		/* Control signals */
-	MX51_PAD_GPIO1_6__GPIO1_6,
-	MX51_PAD_GPIO1_7__GPIO1_7,
-	MX51_PAD_GPIO1_8__GPIO1_8,
-	MX51_PAD_GPIO1_9__GPIO1_9,
-
-	/* Touchscreen */
-	/* IRQ */
-	NEW_PAD_CTRL(MX51_PAD_GPIO_NAND__GPIO_NAND, PAD_CTL_PUS_22K_UP |
-			PAD_CTL_PKE | PAD_CTL_SRE_FAST |
-			PAD_CTL_DSE_HIGH | PAD_CTL_PUE | PAD_CTL_HYS),
-	NEW_PAD_CTRL(MX51_PAD_NANDF_D8__GPIO4_0, PAD_CTL_PUS_22K_UP |
-			PAD_CTL_PKE | PAD_CTL_SRE_FAST |
-			PAD_CTL_DSE_HIGH | PAD_CTL_PUE | PAD_CTL_HYS),
-};
-
-static const struct imxuart_platform_data uart_pdata __initconst = {
-	.flags = IMXUART_HAVE_RTSCTS,
-};
-
-static int tsc2007_get_pendown_state(struct device *dev)
-{
-	if (mx51_revision() < IMX_CHIP_REVISION_3_0)
-		return !gpio_get_value(TSC2007_IRQGPIO_REV2);
-	else
-		return !gpio_get_value(TSC2007_IRQGPIO_REV3);
-}
-
-static struct tsc2007_platform_data tsc2007_info = {
-	.model			= 2007,
-	.x_plate_ohms		= 180,
-	.get_pendown_state	= tsc2007_get_pendown_state,
-};
-
-static struct i2c_board_info eukrea_cpuimx51sd_i2c_devices[] = {
-	{
-		I2C_BOARD_INFO("pcf8563", 0x51),
-	}, {
-		I2C_BOARD_INFO("tsc2007", 0x49),
-		.platform_data	= &tsc2007_info,
-	},
-};
-
-static const struct mxc_nand_platform_data
-		eukrea_cpuimx51sd_nand_board_info __initconst = {
-	.width		= 1,
-	.hw_ecc		= 1,
-	.flash_bbt	= 1,
-};
-
-/* This function is board specific as the bit mask for the plldiv will also
-be different for other Freescale SoCs, thus a common bitmask is not
-possible and cannot get place in /plat-mxc/ehci.c.*/
-static int initialize_otg_port(struct platform_device *pdev)
-{
-	u32 v;
-	void __iomem *usb_base;
-	void __iomem *usbother_base;
-
-	usb_base = ioremap(MX51_USB_OTG_BASE_ADDR, SZ_4K);
-	if (!usb_base)
-		return -ENOMEM;
-	usbother_base = usb_base + MX5_USBOTHER_REGS_OFFSET;
-
-	/* Set the PHY clock to 19.2MHz */
-	v = __raw_readl(usbother_base + MXC_USB_PHY_CTR_FUNC2_OFFSET);
-	v &= ~MX5_USB_UTMI_PHYCTRL1_PLLDIV_MASK;
-	v |= MX51_USB_PLL_DIV_19_2_MHZ;
-	__raw_writel(v, usbother_base + MXC_USB_PHY_CTR_FUNC2_OFFSET);
-	iounmap(usb_base);
-
-	mdelay(10);
-
-	return mx51_initialize_usb_hw(0, MXC_EHCI_INTERNAL_PHY);
-}
-
-static int initialize_usbh1_port(struct platform_device *pdev)
-{
-	u32 v;
-	void __iomem *usb_base;
-	void __iomem *usbother_base;
-
-	usb_base = ioremap(MX51_USB_OTG_BASE_ADDR, SZ_4K);
-	if (!usb_base)
-		return -ENOMEM;
-	usbother_base = usb_base + MX5_USBOTHER_REGS_OFFSET;
-
-	/* The clock for the USBH1 ULPI port will come from the PHY. */
-	v = __raw_readl(usbother_base + MX51_USB_CTRL_1_OFFSET);
-	__raw_writel(v | MX51_USB_CTRL_UH1_EXT_CLK_EN,
-			usbother_base + MX51_USB_CTRL_1_OFFSET);
-	iounmap(usb_base);
-
-	mdelay(10);
-
-	return mx51_initialize_usb_hw(1, MXC_EHCI_POWER_PINS_ENABLED |
-			MXC_EHCI_ITC_NO_THRESHOLD);
-}
-
-static const struct mxc_usbh_platform_data dr_utmi_config __initconst = {
-	.init		= initialize_otg_port,
-	.portsc	= MXC_EHCI_UTMI_16BIT,
-};
-
-static const struct fsl_usb2_platform_data usb_pdata __initconst = {
-	.operating_mode	= FSL_USB2_DR_DEVICE,
-	.phy_mode	= FSL_USB2_PHY_UTMI_WIDE,
-};
-
-static const struct mxc_usbh_platform_data usbh1_config __initconst = {
-	.init		= initialize_usbh1_port,
-	.portsc	= MXC_EHCI_MODE_ULPI,
-};
-
-static bool otg_mode_host __initdata;
-
-static int __init eukrea_cpuimx51sd_otg_mode(char *options)
-{
-	if (!strcmp(options, "host"))
-		otg_mode_host = true;
-	else if (!strcmp(options, "device"))
-		otg_mode_host = false;
-	else
-		pr_info("otg_mode neither \"host\" nor \"device\". "
-			"Defaulting to device\n");
-	return 1;
-}
-__setup("otg_mode=", eukrea_cpuimx51sd_otg_mode);
-
-static struct i2c_gpio_platform_data pdata = {
-	.sda_pin		= I2C_SDA,
-	.sda_is_open_drain	= 0,
-	.scl_pin		= I2C_SCL,
-	.scl_is_open_drain	= 0,
-	.udelay			= 2,
-};
-
-static struct platform_device hsi2c_gpio_device = {
-	.name			= "i2c-gpio",
-	.id			= 0,
-	.dev.platform_data	= &pdata,
-};
-
-static struct mcp251x_platform_data mcp251x_info = {
-	.oscillator_frequency = 24E6,
-};
-
-static struct spi_board_info cpuimx51sd_spi_device[] = {
-	{
-		.modalias        = "mcp2515",
-		.max_speed_hz    = 10000000,
-		.bus_num         = 0,
-		.mode		= SPI_MODE_0,
-		.chip_select     = 0,
-		.platform_data   = &mcp251x_info,
-		/* irq number is run-time assigned */
-	},
-};
-
-static int cpuimx51sd_spi1_cs[] = {
-	CAN_NCS,
-};
-
-static const struct spi_imx_master cpuimx51sd_ecspi1_pdata __initconst = {
-	.chipselect	= cpuimx51sd_spi1_cs,
-	.num_chipselect	= ARRAY_SIZE(cpuimx51sd_spi1_cs),
-};
-
-static struct platform_device *rev2_platform_devices[] __initdata = {
-	&hsi2c_gpio_device,
-};
-
-static const struct imxi2c_platform_data cpuimx51sd_i2c_data __initconst = {
-	.bitrate = 100000,
-};
-
-static void __init eukrea_cpuimx51sd_init(void)
-{
-	imx51_soc_init();
-
-	mxc_iomux_v3_setup_multiple_pads(eukrea_cpuimx51sd_pads,
-					ARRAY_SIZE(eukrea_cpuimx51sd_pads));
-
-	imx51_add_imx_uart(0, &uart_pdata);
-	imx51_add_mxc_nand(&eukrea_cpuimx51sd_nand_board_info);
-	imx51_add_imx2_wdt(0);
-
-	gpio_request(ETH_RST, "eth_rst");
-	gpio_set_value(ETH_RST, 1);
-	imx51_add_fec(NULL);
-
-	gpio_request(CAN_IRQGPIO, "can_irq");
-	gpio_direction_input(CAN_IRQGPIO);
-	gpio_free(CAN_IRQGPIO);
-	gpio_request(CAN_NCS, "can_ncs");
-	gpio_direction_output(CAN_NCS, 1);
-	gpio_free(CAN_NCS);
-	gpio_request(CAN_RST, "can_rst");
-	gpio_direction_output(CAN_RST, 0);
-	msleep(20);
-	gpio_set_value(CAN_RST, 1);
-	imx51_add_ecspi(0, &cpuimx51sd_ecspi1_pdata);
-	cpuimx51sd_spi_device[0].irq = gpio_to_irq(CAN_IRQGPIO);
-	spi_register_board_info(cpuimx51sd_spi_device,
-				ARRAY_SIZE(cpuimx51sd_spi_device));
-
-	if (mx51_revision() < IMX_CHIP_REVISION_3_0) {
-		eukrea_cpuimx51sd_i2c_devices[1].irq =
-			gpio_to_irq(TSC2007_IRQGPIO_REV2),
-		platform_add_devices(rev2_platform_devices,
-			ARRAY_SIZE(rev2_platform_devices));
-		gpio_request(TSC2007_IRQGPIO_REV2, "tsc2007_irq");
-		gpio_direction_input(TSC2007_IRQGPIO_REV2);
-		gpio_free(TSC2007_IRQGPIO_REV2);
-	} else {
-		eukrea_cpuimx51sd_i2c_devices[1].irq =
-			gpio_to_irq(TSC2007_IRQGPIO_REV3),
-		imx51_add_imx_i2c(0, &cpuimx51sd_i2c_data);
-		gpio_request(TSC2007_IRQGPIO_REV3, "tsc2007_irq");
-		gpio_direction_input(TSC2007_IRQGPIO_REV3);
-		gpio_free(TSC2007_IRQGPIO_REV3);
-	}
-
-	i2c_register_board_info(0, eukrea_cpuimx51sd_i2c_devices,
-			ARRAY_SIZE(eukrea_cpuimx51sd_i2c_devices));
-
-	if (otg_mode_host)
-		imx51_add_mxc_ehci_otg(&dr_utmi_config);
-	else {
-		initialize_otg_port(NULL);
-		imx51_add_fsl_usb2_udc(&usb_pdata);
-	}
-
-	gpio_request(USBH1_RST, "usb_rst");
-	gpio_direction_output(USBH1_RST, 0);
-	msleep(20);
-	gpio_set_value(USBH1_RST, 1);
-	imx51_add_mxc_ehci_hs(1, &usbh1_config);
-
-#ifdef CONFIG_MACH_EUKREA_MBIMXSD51_BASEBOARD
-	eukrea_mbimxsd51_baseboard_init();
-#endif
-}
-
-static void __init eukrea_cpuimx51sd_timer_init(void)
-{
-	mx51_clocks_init(32768, 24000000, 22579200, 0);
-}
-
-MACHINE_START(EUKREA_CPUIMX51SD, "Eukrea CPUIMX51SD")
-	/* Maintainer: Eric B?nard <eric@eukrea.com> */
-	.atag_offset = 0x100,
-	.map_io = mx51_map_io,
-	.init_early = imx51_init_early,
-	.init_irq = mx51_init_irq,
-	.handle_irq = imx51_handle_irq,
-	.init_time	= eukrea_cpuimx51sd_timer_init,
-	.init_machine = eukrea_cpuimx51sd_init,
-	.init_late	= imx51_init_late,
-	.restart	= mxc_restart,
-MACHINE_END
-- 
1.8.3.2
