From: eric@eukrea.com (=?utf-8?q?Eric=20B=C3=A9nard?=)
Date: Fri, 25 Jun 2010 09:06:55 +0200
Subject: [PATCH] eukrea_mbimxsd: factorize motherboard support
Message-ID: <1277449615-3971-1-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This motherboard is used for both an i.MX25 and an i.MX35 machines
so we can have only one file to support it in plat-mxc.

Signed-off-by: Eric B?nard <eric@eukrea.com>
---
 arch/arm/mach-mx25/Kconfig                         |   14 -
 arch/arm/mach-mx25/Makefile                        |    1 -
 arch/arm/mach-mx25/eukrea_mbimxsd-baseboard.c      |  260 --------------------
 arch/arm/mach-mx25/mach-cpuimx25.c                 |    2 +-
 arch/arm/mach-mx3/Kconfig                          |   14 -
 arch/arm/mach-mx3/Makefile                         |    1 -
 arch/arm/mach-mx3/mach-cpuimx35.c                  |    2 +-
 arch/arm/plat-mxc/Kconfig                          |    8 +
 arch/arm/plat-mxc/Makefile                         |    1 +
 .../eukrea_mbimxsd-baseboard.c                     |  176 +++++++++++---
 .../plat-mxc/include/mach/board-eukrea_cpuimx35.h  |   40 ---
 ...d-eukrea_cpuimx25.h => board-eukrea_cpuimxsd.h} |   10 +-
 12 files changed, 158 insertions(+), 371 deletions(-)
 delete mode 100644 arch/arm/mach-mx25/eukrea_mbimxsd-baseboard.c
 rename arch/arm/{mach-mx3 => plat-mxc}/eukrea_mbimxsd-baseboard.c (70%)
 delete mode 100644 arch/arm/plat-mxc/include/mach/board-eukrea_cpuimx35.h
 rename arch/arm/plat-mxc/include/mach/{board-eukrea_cpuimx25.h => board-eukrea_cpuimxsd.h} (83%)

diff --git a/arch/arm/mach-mx25/Kconfig b/arch/arm/mach-mx25/Kconfig
index 3a6668e..af982cd 100644
--- a/arch/arm/mach-mx25/Kconfig
+++ b/arch/arm/mach-mx25/Kconfig
@@ -9,18 +9,4 @@ config MACH_EUKREA_CPUIMX25
 	bool "Support Eukrea CPUIMX25 Platform"
 	select MXC_ULPI if USB_ULPI
 
-choice
-	prompt "Baseboard"
-	depends on MACH_EUKREA_CPUIMX25
-	default MACH_EUKREA_MBIMXSD_BASEBOARD
-
-config MACH_EUKREA_MBIMXSD_BASEBOARD
-	prompt "Eukrea MBIMXSD development board"
-	bool
-	help
-	  This adds board specific devices that can be found on Eukrea's
-	  MBIMXSD evaluation board.
-
-endchoice
-
 endif
diff --git a/arch/arm/mach-mx25/Makefile b/arch/arm/mach-mx25/Makefile
index 83ab5d8..71302d4 100644
--- a/arch/arm/mach-mx25/Makefile
+++ b/arch/arm/mach-mx25/Makefile
@@ -2,4 +2,3 @@ obj-y				:= mm.o devices.o
 obj-$(CONFIG_ARCH_MX25)		+= clock.o
 obj-$(CONFIG_MACH_MX25_3DS)	+= mach-mx25pdk.o
 obj-$(CONFIG_MACH_EUKREA_CPUIMX25)		+= mach-cpuimx25.o
-obj-$(CONFIG_MACH_EUKREA_MBIMXSD_BASEBOARD)	+= eukrea_mbimxsd-baseboard.o
diff --git a/arch/arm/mach-mx25/eukrea_mbimxsd-baseboard.c b/arch/arm/mach-mx25/eukrea_mbimxsd-baseboard.c
deleted file mode 100644
index e0f0dfd..0000000
--- a/arch/arm/mach-mx25/eukrea_mbimxsd-baseboard.c
+++ /dev/null
@@ -1,260 +0,0 @@
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
-#include <linux/gpio.h>
-#include <linux/leds.h>
-#include <linux/platform_device.h>
-#include <linux/gpio_keys.h>
-#include <linux/input.h>
-#include <video/platform_lcd.h>
-
-#include <mach/board-eukrea_cpuimx25.h>
-#include <mach/hardware.h>
-#include <mach/iomux-mx25.h>
-#include <mach/common.h>
-#include <asm/mach-types.h>
-#include <asm/mach/arch.h>
-#include <mach/mx25.h>
-#include <mach/imx-uart.h>
-#include <mach/imxfb.h>
-#include <mach/ssi.h>
-#include <mach/audmux.h>
-
-#include "devices.h"
-
-static struct pad_desc eukrea_mbimxsd_pads[] = {
-	/* LCD */
-	MX25_PAD_LD0__LD0,
-	MX25_PAD_LD1__LD1,
-	MX25_PAD_LD2__LD2,
-	MX25_PAD_LD3__LD3,
-	MX25_PAD_LD4__LD4,
-	MX25_PAD_LD5__LD5,
-	MX25_PAD_LD6__LD6,
-	MX25_PAD_LD7__LD7,
-	MX25_PAD_LD8__LD8,
-	MX25_PAD_LD9__LD9,
-	MX25_PAD_LD10__LD10,
-	MX25_PAD_LD11__LD11,
-	MX25_PAD_LD12__LD12,
-	MX25_PAD_LD13__LD13,
-	MX25_PAD_LD14__LD14,
-	MX25_PAD_LD15__LD15,
-	MX25_PAD_GPIO_E__LD16,
-	MX25_PAD_GPIO_F__LD17,
-	MX25_PAD_HSYNC__HSYNC,
-	MX25_PAD_VSYNC__VSYNC,
-	MX25_PAD_LSCLK__LSCLK,
-	MX25_PAD_OE_ACD__OE_ACD,
-	MX25_PAD_CONTRAST__CONTRAST,
-	/* LCD_PWR */
-	MX25_PAD_PWM__GPIO_1_26,
-	/* LED */
-	MX25_PAD_POWER_FAIL__GPIO_3_19,
-	/* SWITCH */
-	MX25_PAD_VSTBY_ACK__GPIO_3_18,
-	/* UART2 */
-	MX25_PAD_UART2_RTS__UART2_RTS,
-	MX25_PAD_UART2_CTS__UART2_CTS,
-	MX25_PAD_UART2_TXD__UART2_TXD,
-	MX25_PAD_UART2_RXD__UART2_RXD,
-	/* SD1 */
-	MX25_PAD_SD1_CMD__SD1_CMD,
-	MX25_PAD_SD1_CLK__SD1_CLK,
-	MX25_PAD_SD1_DATA0__SD1_DATA0,
-	MX25_PAD_SD1_DATA1__SD1_DATA1,
-	MX25_PAD_SD1_DATA2__SD1_DATA2,
-	MX25_PAD_SD1_DATA3__SD1_DATA3,
-	/* SD1 CD */
-	MX25_PAD_DE_B__GPIO_2_20,
-	/* I2S */
-	MX25_PAD_KPP_COL3__AUD5_TXFS,
-	MX25_PAD_KPP_COL2__AUD5_TXC,
-	MX25_PAD_KPP_COL1__AUD5_RXD,
-	MX25_PAD_KPP_COL0__AUD5_TXD,
-};
-
-#define GPIO_LED1	83
-#define GPIO_SWITCH1	82
-#define GPIO_SD1CD	52
-#define GPIO_LCDPWR	26
-
-static struct imx_fb_videomode eukrea_mximxsd_modes[] = {
-	{
-		.mode	= {
-			.name		= "CMO-QVGA",
-			.refresh	= 60,
-			.xres		= 320,
-			.yres		= 240,
-			.pixclock	= KHZ2PICOS(6500),
-			.left_margin	= 30,
-			.right_margin	= 38,
-			.upper_margin	= 20,
-			.lower_margin	= 3,
-			.hsync_len	= 15,
-			.vsync_len	= 4,
-		},
-		.bpp	= 16,
-		.pcr	= 0xCAD08B80,
-	},
-};
-
-static struct imx_fb_platform_data eukrea_mximxsd_fb_pdata = {
-	.mode		= eukrea_mximxsd_modes,
-	.num_modes	= ARRAY_SIZE(eukrea_mximxsd_modes),
-	.pwmr		= 0x00A903FF,
-	.lscr1		= 0x00120300,
-	.dmacr		= 0x00040060,
-};
-
-static void eukrea_mbimxsd_lcd_power_set(struct plat_lcd_data *pd,
-				   unsigned int power)
-{
-	if (power)
-		gpio_direction_output(GPIO_LCDPWR, 1);
-	else
-		gpio_direction_output(GPIO_LCDPWR, 0);
-}
-
-static struct plat_lcd_data eukrea_mbimxsd_lcd_power_data = {
-	.set_power		= eukrea_mbimxsd_lcd_power_set,
-};
-
-static struct platform_device eukrea_mbimxsd_lcd_powerdev = {
-	.name			= "platform-lcd",
-	.dev.platform_data	= &eukrea_mbimxsd_lcd_power_data,
-};
-
-static struct gpio_led eukrea_mbimxsd_leds[] = {
-	{
-		.name			= "led1",
-		.default_trigger	= "heartbeat",
-		.active_low		= 1,
-		.gpio			= GPIO_LED1,
-	},
-};
-
-static struct gpio_led_platform_data eukrea_mbimxsd_led_info = {
-	.leds		= eukrea_mbimxsd_leds,
-	.num_leds	= ARRAY_SIZE(eukrea_mbimxsd_leds),
-};
-
-static struct platform_device eukrea_mbimxsd_leds_gpio = {
-	.name	= "leds-gpio",
-	.id	= -1,
-	.dev	= {
-		.platform_data	= &eukrea_mbimxsd_led_info,
-	},
-};
-
-static struct gpio_keys_button eukrea_mbimxsd_gpio_buttons[] = {
-	{
-		.gpio		= GPIO_SWITCH1,
-		.code		= BTN_0,
-		.desc		= "BP1",
-		.active_low	= 1,
-		.wakeup		= 1,
-	},
-};
-
-static struct gpio_keys_platform_data eukrea_mbimxsd_button_data = {
-	.buttons	= eukrea_mbimxsd_gpio_buttons,
-	.nbuttons	= ARRAY_SIZE(eukrea_mbimxsd_gpio_buttons),
-};
-
-static struct platform_device eukrea_mbimxsd_button_device = {
-	.name		= "gpio-keys",
-	.id		= -1,
-	.num_resources	= 0,
-	.dev		= {
-		.platform_data	= &eukrea_mbimxsd_button_data,
-	}
-};
-
-static struct platform_device *platform_devices[] __initdata = {
-	&eukrea_mbimxsd_leds_gpio,
-	&eukrea_mbimxsd_button_device,
-	&eukrea_mbimxsd_lcd_powerdev,
-};
-
-static struct imxuart_platform_data uart_pdata = {
-	.flags = IMXUART_HAVE_RTSCTS,
-};
-
-static struct i2c_board_info eukrea_mbimxsd_i2c_devices[] = {
-	{
-		I2C_BOARD_INFO("tlv320aic23", 0x1a),
-	},
-};
-
-struct imx_ssi_platform_data eukrea_mbimxsd_ssi_pdata = {
-	.flags = IMX_SSI_SYN | IMX_SSI_NET | IMX_SSI_USE_I2S_SLAVE,
-};
-
-/*
- * system init for baseboard usage. Will be called by cpuimx25 init.
- *
- * Add platform devices present on this baseboard and init
- * them from CPU side as far as required to use them later on
- */
-void __init eukrea_mbimxsd_baseboard_init(void)
-{
-	if (mxc_iomux_v3_setup_multiple_pads(eukrea_mbimxsd_pads,
-			ARRAY_SIZE(eukrea_mbimxsd_pads)))
-		printk(KERN_ERR "error setting mbimxsd pads !\n");
-
-#if defined(CONFIG_SND_SOC_EUKREA_TLV320)
-	/* SSI unit master I2S codec connected to SSI_AUD5*/
-	mxc_audmux_v2_configure_port(0,
-			MXC_AUDMUX_V2_PTCR_SYN |
-			MXC_AUDMUX_V2_PTCR_TFSDIR |
-			MXC_AUDMUX_V2_PTCR_TFSEL(4) |
-			MXC_AUDMUX_V2_PTCR_TCLKDIR |
-			MXC_AUDMUX_V2_PTCR_TCSEL(4),
-			MXC_AUDMUX_V2_PDCR_RXDSEL(4)
-	);
-	mxc_audmux_v2_configure_port(4,
-			MXC_AUDMUX_V2_PTCR_SYN,
-			MXC_AUDMUX_V2_PDCR_RXDSEL(0)
-	);
-#endif
-
-	mxc_register_device(&mxc_uart_device1, &uart_pdata);
-	mxc_register_device(&mx25_fb_device, &eukrea_mximxsd_fb_pdata);
-	mxc_register_device(&imx_ssi_device0, &eukrea_mbimxsd_ssi_pdata);
-
-	gpio_request(GPIO_LED1, "LED1");
-	gpio_direction_output(GPIO_LED1, 1);
-	gpio_free(GPIO_LED1);
-
-	gpio_request(GPIO_SWITCH1, "SWITCH1");
-	gpio_direction_input(GPIO_SWITCH1);
-	gpio_free(GPIO_SWITCH1);
-
-	gpio_request(GPIO_LCDPWR, "LCDPWR");
-	gpio_direction_output(GPIO_LCDPWR, 1);
-	gpio_free(GPIO_SWITCH1);
-
-	i2c_register_board_info(0, eukrea_mbimxsd_i2c_devices,
-				ARRAY_SIZE(eukrea_mbimxsd_i2c_devices));
-
-	platform_add_devices(platform_devices, ARRAY_SIZE(platform_devices));
-}
diff --git a/arch/arm/mach-mx25/mach-cpuimx25.c b/arch/arm/mach-mx25/mach-cpuimx25.c
index 4796484..2e85d59 100644
--- a/arch/arm/mach-mx25/mach-cpuimx25.c
+++ b/arch/arm/mach-mx25/mach-cpuimx25.c
@@ -29,7 +29,7 @@
 #include <linux/usb/ulpi.h>
 #include <linux/fsl_devices.h>
 
-#include <mach/board-eukrea_cpuimx25.h>
+#include <mach/board-eukrea_cpuimxsd.h>
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
diff --git a/arch/arm/mach-mx3/Kconfig b/arch/arm/mach-mx3/Kconfig
index b09e9a9..5bb9f6e 100644
--- a/arch/arm/mach-mx3/Kconfig
+++ b/arch/arm/mach-mx3/Kconfig
@@ -133,18 +133,4 @@ config MACH_EUKREA_CPUIMX35
 	  Include support for Eukrea CPUIMX35 platform. This includes
 	  specific configurations for the board and its peripherals.
 
-choice
-	prompt "Baseboard"
-	depends on MACH_EUKREA_CPUIMX35
-	default MACH_EUKREA_MBIMXSD_BASEBOARD
-
-config MACH_EUKREA_MBIMXSD_BASEBOARD
-	prompt "Eukrea MBIMXSD development board"
-	bool
-	help
-	  This adds board specific devices that can be found on Eukrea's
-	  MBIMXSD evaluation board.
-
-endchoice
-
 endif
diff --git a/arch/arm/mach-mx3/Makefile b/arch/arm/mach-mx3/Makefile
index ef68ff5..5a2525d 100644
--- a/arch/arm/mach-mx3/Makefile
+++ b/arch/arm/mach-mx3/Makefile
@@ -25,4 +25,3 @@ obj-$(CONFIG_MACH_ARMADILLO5X0) += mach-armadillo5x0.o
 obj-$(CONFIG_MACH_MX35_3DS)	+= mach-mx35pdk.o
 obj-$(CONFIG_MACH_KZM_ARM11_01)	+= mach-kzm_arm11_01.o
 obj-$(CONFIG_MACH_EUKREA_CPUIMX35)	+= mach-cpuimx35.o
-obj-$(CONFIG_MACH_EUKREA_MBIMXSD_BASEBOARD)	+= eukrea_mbimxsd-baseboard.o
diff --git a/arch/arm/mach-mx3/mach-cpuimx35.c b/arch/arm/mach-mx3/mach-cpuimx35.c
index 55caa5c..56e5bf0 100644
--- a/arch/arm/mach-mx3/mach-cpuimx35.c
+++ b/arch/arm/mach-mx3/mach-cpuimx35.c
@@ -37,7 +37,7 @@
 #include <asm/mach/time.h>
 #include <asm/mach/map.h>
 
-#include <mach/board-eukrea_cpuimx35.h>
+#include <mach/board-eukrea_cpuimxsd.h>
 #include <mach/hardware.h>
 #include <mach/common.h>
 #include <mach/imx-uart.h>
diff --git a/arch/arm/plat-mxc/Kconfig b/arch/arm/plat-mxc/Kconfig
index 902ba9e..9df2706 100644
--- a/arch/arm/plat-mxc/Kconfig
+++ b/arch/arm/plat-mxc/Kconfig
@@ -82,6 +82,14 @@ config MXC_PWM
 	help
 	  Enable support for the i.MX PWM controller(s).
 
+config MACH_EUKREA_MBIMXSD_BASEBOARD
+	prompt "Eukrea MBIMXSD development board"
+	depends on MACH_EUKREA_CPUIMX25 || MACH_EUKREA_CPUIMX35
+	bool
+	help
+	  This adds board specific devices that can be found on Eukrea's
+	  MBIMXSD evaluation board.
+
 config MXC_ULPI
 	bool
 
diff --git a/arch/arm/plat-mxc/Makefile b/arch/arm/plat-mxc/Makefile
index 895bc3c..2cc2d5c 100644
--- a/arch/arm/plat-mxc/Makefile
+++ b/arch/arm/plat-mxc/Makefile
@@ -21,3 +21,4 @@ ifdef CONFIG_SND_IMX_SOC
 obj-y += ssi-fiq.o
 obj-y += ssi-fiq-ksym.o
 endif
+obj-$(CONFIG_MACH_EUKREA_MBIMXSD_BASEBOARD)	+= eukrea_mbimxsd-baseboard.o
diff --git a/arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c b/arch/arm/plat-mxc/eukrea_mbimxsd-baseboard.c
similarity index 70%
rename from arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c
rename to arch/arm/plat-mxc/eukrea_mbimxsd-baseboard.c
index 6785978..0c15843 100644
--- a/arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c
+++ b/arch/arm/plat-mxc/eukrea_mbimxsd-baseboard.c
@@ -36,48 +36,117 @@
 #include <asm/mach/time.h>
 #include <asm/mach/map.h>
 
-#include <mach/board-eukrea_cpuimx35.h>
 #include <mach/hardware.h>
 #include <mach/common.h>
-#include <mach/imx-uart.h>
+#include <mach/board-eukrea_cpuimxsd.h>
+
+#if defined(CONFIG_MACH_EUKREA_CPUIMX25)
+#include <mach/iomux-mx25.h>
+#include <mach/mx25.h>
+#include <mach/imxfb.h>
+#include "../mach-mx25/devices.h"
+#endif
+
+#if defined(CONFIG_MACH_EUKREA_CPUIMX35)
 #include <mach/iomux-mx35.h>
 #include <mach/ipu.h>
 #include <mach/mx3fb.h>
-#include <mach/audmux.h>
+#include "../mach-mx3/devices.h"
+#endif
+
+#include <mach/imx-uart.h>
 #include <mach/ssi.h>
+#include <mach/audmux.h>
+
+#if defined(CONFIG_MACH_EUKREA_CPUIMX25)
+static struct pad_desc eukrea_mbimxsd_pads[] = {
+	/* LCD */
+	MX25_PAD_LD0__LD0,
+	MX25_PAD_LD1__LD1,
+	MX25_PAD_LD2__LD2,
+	MX25_PAD_LD3__LD3,
+	MX25_PAD_LD4__LD4,
+	MX25_PAD_LD5__LD5,
+	MX25_PAD_LD6__LD6,
+	MX25_PAD_LD7__LD7,
+	MX25_PAD_LD8__LD8,
+	MX25_PAD_LD9__LD9,
+	MX25_PAD_LD10__LD10,
+	MX25_PAD_LD11__LD11,
+	MX25_PAD_LD12__LD12,
+	MX25_PAD_LD13__LD13,
+	MX25_PAD_LD14__LD14,
+	MX25_PAD_LD15__LD15,
+	MX25_PAD_GPIO_E__LD16,
+	MX25_PAD_GPIO_F__LD17,
+	MX25_PAD_HSYNC__HSYNC,
+	MX25_PAD_VSYNC__VSYNC,
+	MX25_PAD_LSCLK__LSCLK,
+	MX25_PAD_OE_ACD__OE_ACD,
+	MX25_PAD_CONTRAST__CONTRAST,
+	/* LCD_PWR */
+	MX25_PAD_PWM__GPIO_1_26,
+	/* LED */
+	MX25_PAD_POWER_FAIL__GPIO_3_19,
+	/* SWITCH */
+	MX25_PAD_VSTBY_ACK__GPIO_3_18,
+	/* UART2 */
+	MX25_PAD_UART2_RTS__UART2_RTS,
+	MX25_PAD_UART2_CTS__UART2_CTS,
+	MX25_PAD_UART2_TXD__UART2_TXD,
+	MX25_PAD_UART2_RXD__UART2_RXD,
+	/* SD1 */
+	MX25_PAD_SD1_CMD__SD1_CMD,
+	MX25_PAD_SD1_CLK__SD1_CLK,
+	MX25_PAD_SD1_DATA0__SD1_DATA0,
+	MX25_PAD_SD1_DATA1__SD1_DATA1,
+	MX25_PAD_SD1_DATA2__SD1_DATA2,
+	MX25_PAD_SD1_DATA3__SD1_DATA3,
+	/* SD1 CD */
+	MX25_PAD_DE_B__GPIO_2_20,
+	/* I2S */
+	MX25_PAD_KPP_COL3__AUD5_TXFS,
+	MX25_PAD_KPP_COL2__AUD5_TXC,
+	MX25_PAD_KPP_COL1__AUD5_RXD,
+	MX25_PAD_KPP_COL0__AUD5_TXD,
+};
 
-#include "devices.h"
+#define GPIO_LED1	83
+#define GPIO_SWITCH1	82
+#define GPIO_SD1CD	52
+#define GPIO_LCDPWR	26
+#define SSI_PORT	4
 
-static const struct fb_videomode fb_modedb[] = {
+static struct imx_fb_videomode eukrea_mximxsd_modes[] = {
 	{
-		.name		= "CMO_QVGA",
-		.refresh	= 60,
-		.xres		= 320,
-		.yres		= 240,
-		.pixclock	= KHZ2PICOS(6500),
-		.left_margin	= 68,
-		.right_margin	= 20,
-		.upper_margin	= 15,
-		.lower_margin	= 4,
-		.hsync_len	= 30,
-		.vsync_len	= 3,
-		.sync		= 0,
-		.vmode		= FB_VMODE_NONINTERLACED,
-		.flag		= 0,
+		.mode	= {
+			.name		= "CMO-QVGA",
+			.refresh	= 60,
+			.xres		= 320,
+			.yres		= 240,
+			.pixclock	= KHZ2PICOS(6500),
+			.left_margin	= 30,
+			.right_margin	= 38,
+			.upper_margin	= 20,
+			.lower_margin	= 3,
+			.hsync_len	= 15,
+			.vsync_len	= 4,
+		},
+		.bpp	= 16,
+		.pcr	= 0xCAD08B80,
 	},
 };
 
-static struct ipu_platform_data mx3_ipu_data = {
-	.irq_base = MXC_IPU_IRQ_START,
-};
-
-static struct mx3fb_platform_data mx3fb_pdata = {
-	.dma_dev	= &mx3_ipu.dev,
-	.name		= "CMO_QVGA",
-	.mode		= fb_modedb,
-	.num_modes	= ARRAY_SIZE(fb_modedb),
+static struct imx_fb_platform_data eukrea_mximxsd_fb_pdata = {
+	.mode		= eukrea_mximxsd_modes,
+	.num_modes	= ARRAY_SIZE(eukrea_mximxsd_modes),
+	.pwmr		= 0x00A903FF,
+	.lscr1		= 0x00120300,
+	.dmacr		= 0x00040060,
 };
+#endif
 
+#if defined(CONFIG_MACH_EUKREA_CPUIMX35)
 static struct pad_desc eukrea_mbimxsd_pads[] = {
 	/* LCD */
 	MX35_PAD_LD0__IPU_DISPB_DAT_0,
@@ -125,6 +194,38 @@ static struct pad_desc eukrea_mbimxsd_pads[] = {
 #define GPIO_LED1	(2 * 32 + 29)
 #define GPIO_SWITCH1	(2 * 32 + 25)
 #define GPIO_LCDPWR	(4)
+#define SSI_PORT	(3)
+
+static const struct fb_videomode fb_modedb[] = {
+	{
+		.name		= "CMO_QVGA",
+		.refresh	= 60,
+		.xres		= 320,
+		.yres		= 240,
+		.pixclock	= KHZ2PICOS(6500),
+		.left_margin	= 68,
+		.right_margin	= 20,
+		.upper_margin	= 15,
+		.lower_margin	= 4,
+		.hsync_len	= 30,
+		.vsync_len	= 3,
+		.sync		= 0,
+		.vmode		= FB_VMODE_NONINTERLACED,
+		.flag		= 0,
+	},
+};
+
+static struct ipu_platform_data mx3_ipu_data = {
+	.irq_base = MXC_IPU_IRQ_START,
+};
+
+static struct mx3fb_platform_data mx3fb_pdata = {
+	.dma_dev	= &mx3_ipu.dev,
+	.name		= "CMO_QVGA",
+	.mode		= fb_modedb,
+	.num_modes	= ARRAY_SIZE(fb_modedb),
+};
+#endif
 
 static void eukrea_mbimxsd_lcd_power_set(struct plat_lcd_data *pd,
 				   unsigned int power)
@@ -211,7 +312,7 @@ struct imx_ssi_platform_data eukrea_mbimxsd_ssi_pdata = {
 };
 
 /*
- * system init for baseboard usage. Will be called by cpuimx35 init.
+ * system init for baseboard usage. Will be called by cpuimxX5 init.
  *
  * Add platform devices present on this baseboard and init
  * them from CPU side as far as required to use them later on
@@ -223,24 +324,31 @@ void __init eukrea_mbimxsd_baseboard_init(void)
 		printk(KERN_ERR "error setting mbimxsd pads !\n");
 
 #if defined(CONFIG_SND_SOC_EUKREA_TLV320)
-	/* SSI unit master I2S codec connected to SSI_AUD4 */
+	/* SSI unit master I2S codec connected to SSI_AUD */
 	mxc_audmux_v2_configure_port(0,
 			MXC_AUDMUX_V2_PTCR_SYN |
 			MXC_AUDMUX_V2_PTCR_TFSDIR |
-			MXC_AUDMUX_V2_PTCR_TFSEL(3) |
+			MXC_AUDMUX_V2_PTCR_TFSEL(SSI_PORT) |
 			MXC_AUDMUX_V2_PTCR_TCLKDIR |
-			MXC_AUDMUX_V2_PTCR_TCSEL(3),
-			MXC_AUDMUX_V2_PDCR_RXDSEL(3)
+			MXC_AUDMUX_V2_PTCR_TCSEL(SSI_PORT),
+			MXC_AUDMUX_V2_PDCR_RXDSEL(SSI_PORT)
 	);
-	mxc_audmux_v2_configure_port(3,
+	mxc_audmux_v2_configure_port(SSI_PORT,
 			MXC_AUDMUX_V2_PTCR_SYN,
 			MXC_AUDMUX_V2_PDCR_RXDSEL(0)
 	);
 #endif
 
 	mxc_register_device(&mxc_uart_device1, &uart_pdata);
+
+#if defined(CONFIG_MACH_EUKREA_CPUIMX25)
+	mxc_register_device(&mx25_fb_device, &eukrea_mximxsd_fb_pdata);
+#endif
+
+#if defined(CONFIG_MACH_EUKREA_CPUIMX35)
 	mxc_register_device(&mx3_ipu, &mx3_ipu_data);
 	mxc_register_device(&mx3_fb, &mx3fb_pdata);
+#endif
 
 	mxc_register_device(&imx_ssi_device0, &eukrea_mbimxsd_ssi_pdata);
 
diff --git a/arch/arm/plat-mxc/include/mach/board-eukrea_cpuimx35.h b/arch/arm/plat-mxc/include/mach/board-eukrea_cpuimx35.h
deleted file mode 100644
index 116eee7..0000000
--- a/arch/arm/plat-mxc/include/mach/board-eukrea_cpuimx35.h
+++ /dev/null
@@ -1,40 +0,0 @@
-/*
- * Copyright (C) 2010 Eric Benard - eric at eukrea.com
- *
- * Based on board-pcm038.h which is :
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
-#ifndef __ASM_ARCH_MXC_BOARD_EUKREA_CPUIMX35_H__
-#define __ASM_ARCH_MXC_BOARD_EUKREA_CPUIMX35_H__
-
-#ifndef __ASSEMBLY__
-/*
- * This CPU module needs a baseboard to work. After basic initializing
- * its own devices, it calls baseboard's init function.
- * TODO: Add your own baseboard init function and call it from
- * inside eukrea_cpuimx25_init().
- *
- * This example here is for the development board. Refer
- * eukrea_mbimx25-baseboard.c
- */
-
-extern void eukrea_mbimxsd_baseboard_init(void);
-
-#endif
-
-#endif /* __ASM_ARCH_MXC_BOARD_EUKREA_CPUIMX35_H__ */
diff --git a/arch/arm/plat-mxc/include/mach/board-eukrea_cpuimx25.h b/arch/arm/plat-mxc/include/mach/board-eukrea_cpuimxsd.h
similarity index 83%
rename from arch/arm/plat-mxc/include/mach/board-eukrea_cpuimx25.h
rename to arch/arm/plat-mxc/include/mach/board-eukrea_cpuimxsd.h
index 5c9901e..96789b1 100644
--- a/arch/arm/plat-mxc/include/mach/board-eukrea_cpuimx25.h
+++ b/arch/arm/plat-mxc/include/mach/board-eukrea_cpuimxsd.h
@@ -19,22 +19,22 @@
  * MA 02110-1301, USA.
  */
 
-#ifndef __ASM_ARCH_MXC_BOARD_EUKREA_CPUIMX25_H__
-#define __ASM_ARCH_MXC_BOARD_EUKREA_CPUIMX25_H__
+#ifndef __ASM_ARCH_MXC_BOARD_EUKREA_CPUIMXSD_H__
+#define __ASM_ARCH_MXC_BOARD_EUKREA_CPUIMXSD_H__
 
 #ifndef __ASSEMBLY__
 /*
  * This CPU module needs a baseboard to work. After basic initializing
  * its own devices, it calls baseboard's init function.
  * TODO: Add your own baseboard init function and call it from
- * inside eukrea_cpuimx25_init().
+ * inside eukrea_cpuimx25_init() or eukrea_cpuimx35_init().
  *
  * This example here is for the development board. Refer
- * eukrea_mbimx25-baseboard.c
+ * eukrea_mbimxsd-baseboard.c
  */
 
 extern void eukrea_mbimxsd_baseboard_init(void);
 
 #endif
 
-#endif /* __ASM_ARCH_MXC_BOARD_EUKREA_CPUIMX25_H__ */
+#endif /* __ASM_ARCH_MXC_BOARD_EUKREA_CPUIMXSD_H__ */
-- 
1.6.3.3
