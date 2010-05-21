From: marek.vasut@gmail.com (Marek Vasut)
Date: Sat, 22 May 2010 00:29:39 +0200
Subject: [PATCH 7/8] pxa/income: Add Income SBC support
In-Reply-To: <1274480980-10109-1-git-send-email-marek.vasut@gmail.com>
References: <1274480980-10109-1-git-send-email-marek.vasut@gmail.com>
Message-ID: <1274480980-10109-8-git-send-email-marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is support for custom design based on Toradex Colibri PXA270 CPU card.
Initial patch was by Pavel Revak.

[daniel - rebased the code to follow the module/board split]

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
---
 MAINTAINERS                               |    7 +
 arch/arm/mach-pxa/Kconfig                 |    7 +
 arch/arm/mach-pxa/Makefile                |    1 +
 arch/arm/mach-pxa/colibri-pxa270-income.c |  272 +++++++++++++++++++++++++++++
 arch/arm/mach-pxa/colibri-pxa270.c        |   29 +++-
 arch/arm/mach-pxa/include/mach/colibri.h  |    7 +
 6 files changed, 320 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/mach-pxa/colibri-pxa270-income.c

diff --git a/MAINTAINERS b/MAINTAINERS
index aa02bf2..38e760c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -696,6 +696,13 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kristoffer/linux-hpc.git
 F:	arch/arm/mach-sa1100/jornada720.c
 F:	arch/arm/mach-sa1100/include/mach/jornada720.h
 
+ARM/INCOME PXA270 SUPPORT
+M:	Marek Vasut <marek.vasut@gmail.com>
+L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	arch/arm/mach-pxa/income.c
+F:	arch/arm/mach-pxa/include/mach-pxa/income.h
+
 ARM/INTEL IOP32X ARM ARCHITECTURE
 M:	Lennert Buytenhek <kernel@wantstofly.org>
 M:	Dan Williams <dan.j.williams@intel.com>
diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
index 819b44f..2ff0b32 100644
--- a/arch/arm/mach-pxa/Kconfig
+++ b/arch/arm/mach-pxa/Kconfig
@@ -242,6 +242,13 @@ config MACH_COLIBRI_PXA270_EVALBOARD
 	bool "Toradex Colibri Evaluation Carrier Board support (PXA270)"
 	depends on MACH_COLIBRI
 
+config MACH_COLIBRI_PXA270_INCOME
+	bool "Income s.r.o. PXA270 SBC"
+	depends on MACH_COLIBRI
+	select PXA27x
+	select HAVE_PWM
+	select PXA_HAVE_BOARD_IRQS
+
 config MACH_COLIBRI300
 	bool "Toradex Colibri PXA300/310"
 	select PXA3xx
diff --git a/arch/arm/mach-pxa/Makefile b/arch/arm/mach-pxa/Makefile
index 4751c9d..66e8989 100644
--- a/arch/arm/mach-pxa/Makefile
+++ b/arch/arm/mach-pxa/Makefile
@@ -60,6 +60,7 @@ obj-$(CONFIG_MACH_PCM027)		+= pcm027.o
 obj-$(CONFIG_MACH_PCM990_BASEBOARD)	+= pcm990-baseboard.o
 obj-$(CONFIG_MACH_COLIBRI)			+= colibri-pxa270.o
 obj-$(CONFIG_MACH_COLIBRI_PXA270_EVALBOARD)	+= colibri-pxa270-evalboard.o
+obj-$(CONFIG_MACH_COLIBRI_PXA270_INCOME)	+= colibri-pxa270-income.o
 obj-$(CONFIG_MACH_COLIBRI300)	+= colibri-pxa3xx.o colibri-pxa300.o
 obj-$(CONFIG_MACH_COLIBRI320)	+= colibri-pxa3xx.o colibri-pxa320.o
 obj-$(CONFIG_MACH_VPAC270)	+= vpac270.o
diff --git a/arch/arm/mach-pxa/colibri-pxa270-income.c b/arch/arm/mach-pxa/colibri-pxa270-income.c
new file mode 100644
index 0000000..37f0f3e
--- /dev/null
+++ b/arch/arm/mach-pxa/colibri-pxa270-income.c
@@ -0,0 +1,272 @@
+/*
+ * linux/arch/arm/mach-pxa/income.c
+ *
+ * Support for Income s.r.o. SH-Dmaster PXA270 SBC
+ *
+ * Copyright (C) 2010
+ * Marek Vasut <marek.vasut@gmail.com>
+ * Pavel Revak <palo@bielyvlk.sk>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/bitops.h>
+#include <linux/delay.h>
+#include <linux/gpio.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/ioport.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/pwm_backlight.h>
+#include <linux/sysdev.h>
+
+#include <asm/irq.h>
+#include <asm/mach-types.h>
+
+#include <mach/hardware.h>
+#include <mach/mmc.h>
+#include <mach/ohci.h>
+#include <mach/pxa27x.h>
+#include <mach/pxa27x-udc.h>
+#include <mach/pxafb.h>
+
+#include <plat/i2c.h>
+
+#include "devices.h"
+#include "generic.h"
+
+#define GPIO114_INCOME_ETH_IRQ  (114)
+#define GPIO0_INCOME_SD_DETECT  (0)
+#define GPIO0_INCOME_SD_RO      (1)
+#define GPIO54_INCOME_LED_A     (54)
+#define GPIO55_INCOME_LED_B     (55)
+#define GPIO113_INCOME_TS_IRQ   (113)
+
+/******************************************************************************
+ * Pin configuration
+ ******************************************************************************/
+static mfp_cfg_t income_pin_config[] __initdata = {
+	/* MMC */
+	GPIO32_MMC_CLK,
+	GPIO92_MMC_DAT_0,
+	GPIO109_MMC_DAT_1,
+	GPIO110_MMC_DAT_2,
+	GPIO111_MMC_DAT_3,
+	GPIO112_MMC_CMD,
+	GPIO0_GPIO,	/* SD detect */
+	GPIO1_GPIO,	/* SD read-only */
+
+	/* FFUART */
+	GPIO39_FFUART_TXD,
+	GPIO34_FFUART_RXD,
+
+	/* BFUART */
+	GPIO42_BTUART_RXD,
+	GPIO43_BTUART_TXD,
+	GPIO45_BTUART_RTS,
+
+	/* STUART */
+	GPIO46_STUART_RXD,
+	GPIO47_STUART_TXD,
+
+	/* UHC */
+	GPIO88_USBH1_PWR,
+	GPIO89_USBH1_PEN,
+
+	/* LCD */
+	GPIOxx_LCD_TFT_16BPP,
+
+	/* PWM */
+	GPIO16_PWM0_OUT,
+
+	/* I2C */
+	GPIO117_I2C_SCL,
+	GPIO118_I2C_SDA,
+
+	/* LED */
+	GPIO54_GPIO,	/* LED A */
+	GPIO55_GPIO,	/* LED B */
+};
+
+/******************************************************************************
+ * SD/MMC card controller
+ ******************************************************************************/
+#if defined(CONFIG_MMC_PXA) || defined(CONFIG_MMC_PXA_MODULE)
+static struct pxamci_platform_data income_mci_platform_data = {
+	.ocr_mask		= MMC_VDD_32_33 | MMC_VDD_33_34,
+	.gpio_power		= -1,
+	.gpio_card_detect	= GPIO0_INCOME_SD_DETECT,
+	.gpio_card_ro		= GPIO0_INCOME_SD_RO,
+	.detect_delay_ms	= 200,
+};
+
+static void __init income_mmc_init(void)
+{
+	pxa_set_mci_info(&income_mci_platform_data);
+}
+#else
+static inline void income_mmc_init(void) {}
+#endif
+
+/******************************************************************************
+ * USB Host
+ ******************************************************************************/
+#if defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE)
+static struct pxaohci_platform_data income_ohci_info = {
+	.port_mode	= PMM_PERPORT_MODE,
+	.flags		= ENABLE_PORT1 | POWER_CONTROL_LOW | POWER_SENSE_LOW,
+};
+
+static void __init income_uhc_init(void)
+{
+	pxa_set_ohci_info(&income_ohci_info);
+}
+#else
+static inline void income_uhc_init(void) {}
+#endif
+
+/******************************************************************************
+ * LED
+ ******************************************************************************/
+#if defined(CONFIG_LEDS_GPIO) || defined(CONFIG_LEDS_GPIO_MODULE)
+struct gpio_led income_gpio_leds[] = {
+	{
+		.name			= "income:green:leda",
+		.default_trigger	= "none",
+		.gpio			= GPIO54_INCOME_LED_A,
+		.active_low		= 1,
+	},
+	{
+		.name			= "income:green:ledb",
+		.default_trigger	= "none",
+		.gpio			= GPIO55_INCOME_LED_B,
+		.active_low		= 1,
+	}
+};
+
+static struct gpio_led_platform_data income_gpio_led_info = {
+	.leds		= income_gpio_leds,
+	.num_leds	= ARRAY_SIZE(income_gpio_leds),
+};
+
+static struct platform_device income_leds = {
+	.name	= "leds-gpio",
+	.id	= -1,
+	.dev	= {
+		.platform_data	= &income_gpio_led_info,
+	}
+};
+
+static void __init income_led_init(void)
+{
+	platform_device_register(&income_leds);
+}
+#else
+static inline void income_led_init(void) {}
+#endif
+
+/******************************************************************************
+ * I2C
+ ******************************************************************************/
+#if defined(CONFIG_I2C_PXA) || defined(CONFIG_I2C_PXA_MODULE)
+static struct i2c_board_info __initdata income_i2c_devs[] = {
+	{
+		I2C_BOARD_INFO("ds1340", 0x68),
+	}, {
+		I2C_BOARD_INFO("lm75", 0x4f),
+	},
+};
+
+static void __init income_i2c_init(void)
+{
+	pxa_set_i2c_info(NULL);
+	pxa27x_set_i2c_power_info(NULL);
+	i2c_register_board_info(0, ARRAY_AND_SIZE(income_i2c_devs));
+}
+#else
+static inline void income_i2c_init(void) {}
+#endif
+
+/******************************************************************************
+ * Framebuffer
+ ******************************************************************************/
+#if defined(CONFIG_FB_PXA) || defined(CONFIG_FB_PXA_MODULE)
+static struct pxafb_mode_info income_lcd_modes[] = {
+{
+	.pixclock	= 144700,
+	.xres		= 320,
+	.yres		= 240,
+	.bpp		= 32,
+	.depth		= 18,
+
+	.left_margin	= 10,
+	.right_margin	= 10,
+	.upper_margin	= 7,
+	.lower_margin	= 8,
+
+	.hsync_len	= 20,
+	.vsync_len	= 2,
+
+	.sync		= FB_SYNC_VERT_HIGH_ACT,
+},
+};
+
+static struct pxafb_mach_info income_lcd_screen = {
+	.modes		= income_lcd_modes,
+	.num_modes	= ARRAY_SIZE(income_lcd_modes),
+	.lcd_conn	= LCD_COLOR_TFT_18BPP | LCD_PCLK_EDGE_FALL,
+};
+
+static void __init income_lcd_init(void)
+{
+	set_pxa_fb_info(&income_lcd_screen);
+}
+#else
+static inline void income_lcd_init(void) {}
+#endif
+
+/******************************************************************************
+ * Backlight
+ ******************************************************************************/
+#if defined(CONFIG_BACKLIGHT_PWM) || defined(CONFIG_BACKLIGHT_PWM__MODULE)
+static struct platform_pwm_backlight_data income_backlight_data = {
+	.pwm_id		= 0,
+	.max_brightness	= 0x3ff,
+	.dft_brightness	= 0x1ff,
+	.pwm_period_ns	= 1000000,
+};
+
+static struct platform_device income_backlight = {
+	.name	= "pwm-backlight",
+	.dev	= {
+		.parent		= &pxa27x_device_pwm0.dev,
+		.platform_data	= &income_backlight_data,
+	},
+};
+
+static void __init income_pwm_init(void)
+{
+	platform_device_register(&income_backlight);
+}
+#else
+static inline void income_pwm_init(void) {}
+#endif
+
+void __init colibri_pxa270_income_boardinit(void)
+{
+	pxa2xx_mfp_config(ARRAY_AND_SIZE(income_pin_config));
+	pxa_set_ffuart_info(NULL);
+	pxa_set_btuart_info(NULL);
+	pxa_set_stuart_info(NULL);
+
+	income_mmc_init();
+	income_uhc_init();
+	income_led_init();
+	income_i2c_init();
+	income_lcd_init();
+	income_pwm_init();
+}
+
diff --git a/arch/arm/mach-pxa/colibri-pxa270.c b/arch/arm/mach-pxa/colibri-pxa270.c
index c1b8880..96ce4ae 100644
--- a/arch/arm/mach-pxa/colibri-pxa270.c
+++ b/arch/arm/mach-pxa/colibri-pxa270.c
@@ -110,17 +110,17 @@ static inline void colibri_pxa270_nor_init(void) {}
  ******************************************************************************/
 #if defined(CONFIG_DM9000) || defined(CONFIG_DM9000_MODULE)
 static struct resource colibri_pxa270_dm9000_resources[] = {
-	[0] = {
+	{
 		.start	= PXA_CS2_PHYS,
 		.end	= PXA_CS2_PHYS + 3,
 		.flags	= IORESOURCE_MEM,
 	},
-	[1] = {
+	{
 		.start	= PXA_CS2_PHYS + 4,
 		.end	= PXA_CS2_PHYS + 4 + 500,
 		.flags	= IORESOURCE_MEM,
 	},
-	[2] = {
+	{
 		.start	= gpio_to_irq(GPIO114_COLIBRI_PXA270_ETH_IRQ),
 		.end	= gpio_to_irq(GPIO114_COLIBRI_PXA270_ETH_IRQ),
 		.flags	= IORESOURCE_IRQ | IRQF_TRIGGER_RISING,
@@ -187,12 +187,25 @@ static void __init colibri_pxa270_init(void)
 	case COLIBRI_PXA270_EVALBOARD:
 		colibri_pxa270_evalboard_init();
 		break;
+	case COLIBRI_PXA270_INCOME:
+		colibri_pxa270_income_boardinit();
+		break;
 	default:
 		printk(KERN_ERR "Illegal colibri_pxa270_baseboard type %d\n",
 				colibri_pxa270_baseboard);
 	}
 }
 
+/* The "Income s.r.o. SH-Dmaster PXA270 SBC" board can be booted either
+ * with the INCOME mach type or with COLIBRI and the kernel parameter
+ * "colibri_pxa270_baseboard=1"
+ */
+static void __init colibri_pxa270_income_init(void)
+{
+	colibri_pxa270_baseboard = COLIBRI_PXA270_INCOME;
+	colibri_pxa270_init();
+}
+
 MACHINE_START(COLIBRI, "Toradex Colibri PXA270")
 	.phys_io	= 0x40000000,
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
@@ -203,3 +216,13 @@ MACHINE_START(COLIBRI, "Toradex Colibri PXA270")
 	.timer		= &pxa_timer,
 MACHINE_END
 
+MACHINE_START(INCOME, "Income s.r.o. SH-Dmaster PXA270 SBC")
+	.phys_io	= 0x40000000,
+	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
+	.boot_params	= 0xa0000100,
+	.init_machine	= colibri_pxa270_income_init,
+	.map_io		= pxa_map_io,
+	.init_irq	= pxa27x_init_irq,
+	.timer		= &pxa_timer,
+MACHINE_END
+
diff --git a/arch/arm/mach-pxa/include/mach/colibri.h b/arch/arm/mach-pxa/include/mach/colibri.h
index 6434f66..58dada1 100644
--- a/arch/arm/mach-pxa/include/mach/colibri.h
+++ b/arch/arm/mach-pxa/include/mach/colibri.h
@@ -10,6 +10,7 @@
 
 enum {
 	COLIBRI_PXA270_EVALBOARD = 0,
+	COLIBRI_PXA270_INCOME,
 };
 
 #if defined(CONFIG_MACH_COLIBRI_PXA270_EVALBOARD)
@@ -18,6 +19,12 @@ extern void colibri_pxa270_evalboard_init(void);
 static inline void colibri_pxa270_evalboard_init(void) {}
 #endif
 
+#if defined(CONFIG_MACH_COLIBRI_PXA270_INCOME)
+extern void colibri_pxa270_income_boardinit(void);
+#else
+static inline void colibri_pxa270_income_boardinit(void) {}
+#endif
+
 /*
  * common settings for all modules
  */
-- 
1.7.0
