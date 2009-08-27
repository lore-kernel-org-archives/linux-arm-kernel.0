From: sleep_walker@suse.cz (=?utf-8?q?Tom=C3=A1=C5=A1=20=C4=8Cech?=)
Date: Thu, 27 Aug 2009 02:43:30 +0200
Subject: [PATCH 4/5] PalmGSM: generalisation of Treo680 code to PalmGSM
In-Reply-To: <1251333811-22360-4-git-send-email-sleep_walker@suse.cz>
References: <1251333811-22360-1-git-send-email-sleep_walker@suse.cz>
	<1251333811-22360-2-git-send-email-sleep_walker@suse.cz>
	<1251333811-22360-3-git-send-email-sleep_walker@suse.cz>
	<1251333811-22360-4-git-send-email-sleep_walker@suse.cz>
Message-ID: <1251333811-22360-5-git-send-email-sleep_walker@suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tom?? ?ech <sleep walker@suse.cz>

---
 arch/arm/mach-pxa/Kconfig                |    5 +
 arch/arm/mach-pxa/Makefile               |    2 +-
 arch/arm/mach-pxa/include/mach/palmgsm.h |   60 ++++
 arch/arm/mach-pxa/include/mach/treo680.h |   49 ---
 arch/arm/mach-pxa/palmgsm.c              |  559 ++++++++++++++++++++++++++++++
 arch/arm/mach-pxa/treo680.c              |  528 ----------------------------
 6 files changed, 625 insertions(+), 578 deletions(-)
 create mode 100644 arch/arm/mach-pxa/include/mach/palmgsm.h
 delete mode 100644 arch/arm/mach-pxa/include/mach/treo680.h
 create mode 100644 arch/arm/mach-pxa/palmgsm.c
 delete mode 100644 arch/arm/mach-pxa/treo680.c

diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
index 904f36a..441f1d6 100644
--- a/arch/arm/mach-pxa/Kconfig
+++ b/arch/arm/mach-pxa/Kconfig
@@ -401,12 +401,17 @@ config MACH_PALMZ72
 	  Say Y here if you intend to run this kernel on Palm Zire 72
 	  handheld computer.
 
+config PALMGSM
+	depends on ARCH_PXA_PALM
+	bool
+
 config MACH_TREO680
 	bool "Palm Treo 680"
 	default y
 	depends on ARCH_PXA_PALM
 	select PXA27x
 	select IWMMXT
+	select PALMGSM
 	help
 	  Say Y here if you intend to run this kernel on Palm Treo 680
 	  smartphone.
diff --git a/arch/arm/mach-pxa/Makefile b/arch/arm/mach-pxa/Makefile
index d4c6122..b811878 100644
--- a/arch/arm/mach-pxa/Makefile
+++ b/arch/arm/mach-pxa/Makefile
@@ -62,7 +62,7 @@ obj-$(CONFIG_MACH_PALMT5)	+= palmt5.o
 obj-$(CONFIG_MACH_PALMTX)	+= palmtx.o
 obj-$(CONFIG_MACH_PALMLD)	+= palmld.o
 obj-$(CONFIG_MACH_PALMZ72)	+= palmz72.o
-obj-$(CONFIG_MACH_TREO680)	+= treo680.o
+obj-$(CONFIG_PALMGSM)		+= palmgsm.o
 obj-$(CONFIG_ARCH_VIPER)	+= viper.o
 
 ifeq ($(CONFIG_MACH_ZYLONITE),y)
diff --git a/arch/arm/mach-pxa/include/mach/palmgsm.h b/arch/arm/mach-pxa/include/mach/palmgsm.h
new file mode 100644
index 0000000..8d1a3bc
--- /dev/null
+++ b/arch/arm/mach-pxa/include/mach/palmgsm.h
@@ -0,0 +1,60 @@
+/*
+ * GPIOs and interrupts for Palm smartphones
+ *
+ * currently supported:
+ *     Palm Treo 680 (GSM)
+ *
+ * Author:     Tomas Cech <sleep_walker@suse.cz>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * find more info at www.hackndev.com
+ *
+ */
+
+
+#ifndef _INCLUDE_PALMGSM_H_
+#define _INCLUDE_PALMGSM_H_
+
+/* Generic GPIOs */
+#define GPIO_NR_PALMGSM_POWER_DETECT	0
+#define GPIO_NR_PALMGSM_AMP_EN		27
+#define GPIO_NR_PALMGSM_GREEN_LED	20
+#define GPIO_NR_PALMGSM_RED_LED		79
+#define GPIO_NR_PALMGSM_SD_DETECT_N	113
+#define GPIO_NR_PALMGSM_EP_DETECT_N	116
+#define GPIO_NR_PALMGSM_USB_DETECT	1
+#define GPIO_NR_PALMGSM_USB_PULLUP	114
+#define GPIO_NR_PALMGSM_GSM_POWER	40
+#define GPIO_NR_PALMGSM_GSM_RESET	87
+#define GPIO_NR_PALMGSM_GSM_WAKE	57
+#define GPIO_NR_PALMGSM_GSM_HOST_WAKE	14
+#define GPIO_NR_PALMGSM_GSM_TRIGGER	10
+#define GPIO_NR_PALMGSM_IR_EN		115
+#define GPIO_NR_PALMGSM_IR_TXD		47
+#define GPIO_NR_PALMGSM_BL_POWER	38
+#define GPIO_NR_PALMGSM_LCD_POWER	25
+#define GPIO_NR_PALMGSM_CAM_EN		83
+
+/* Treo680 specific GPIOs */
+#define GPIO_NR_TREO680_SD_READONLY	33
+#define GPIO_NR_TREO680_SD_POWER	42
+#define GPIO_NR_TREO680_VIBRATE_EN	44
+#define GPIO_NR_TREO680_KEYB_BL		24
+#define GPIO_NR_TREO680_BT_EN		43
+
+/* Various addresses  */
+#define PALMGSM_PHYS_RAM_START	0xa0000000
+#define PALMGSM_PHYS_IO_START	0x40000000
+#define PALMGSM_STR_BASE	0xa2000000
+
+/* BACKLIGHT */
+#define PALMGSM_MAX_INTENSITY		254
+#define PALMGSM_DEFAULT_INTENSITY	160
+#define PALMGSM_LIMIT_MASK		0x7F
+#define PALMGSM_PRESCALER		63
+#define PALMGSM_PERIOD_NS		3500
+
+#endif
diff --git a/arch/arm/mach-pxa/include/mach/treo680.h b/arch/arm/mach-pxa/include/mach/treo680.h
deleted file mode 100644
index af443b2..0000000
--- a/arch/arm/mach-pxa/include/mach/treo680.h
+++ /dev/null
@@ -1,49 +0,0 @@
-/*
- * GPIOs and interrupts for Palm Treo 680 smartphone
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- */
-
-#ifndef _INCLUDE_TREO680_H_
-#define _INCLUDE_TREO680_H_
-
-/* GPIOs */
-#define GPIO_NR_TREO680_POWER_DETECT	0
-#define GPIO_NR_TREO680_AMP_EN		27
-#define GPIO_NR_TREO680_KEYB_BL		24
-#define GPIO_NR_TREO680_VIBRATE_EN	44
-#define GPIO_NR_TREO680_GREEN_LED	20
-#define GPIO_NR_TREO680_RED_LED		79
-#define GPIO_NR_TREO680_SD_DETECT_N	113
-#define GPIO_NR_TREO680_SD_READONLY	33
-#define GPIO_NR_TREO680_EP_DETECT_N	116
-#define GPIO_NR_TREO680_SD_POWER	42
-#define GPIO_NR_TREO680_USB_DETECT	1
-#define GPIO_NR_TREO680_USB_PULLUP	114
-#define GPIO_NR_TREO680_GSM_POWER	40
-#define GPIO_NR_TREO680_GSM_RESET	87
-#define GPIO_NR_TREO680_GSM_WAKE	57
-#define GPIO_NR_TREO680_GSM_HOST_WAKE	14
-#define GPIO_NR_TREO680_GSM_TRIGGER	10
-#define GPIO_NR_TREO680_BT_EN		43
-#define GPIO_NR_TREO680_IR_EN		115
-#define GPIO_NR_TREO680_IR_TXD		47
-#define GPIO_NR_TREO680_BL_POWER	38
-#define GPIO_NR_TREO680_LCD_POWER	25
-
-/* Various addresses  */
-#define TREO680_PHYS_RAM_START	0xa0000000
-#define TREO680_PHYS_IO_START	0x40000000
-#define TREO680_STR_BASE	0xa2000000
-
-/* BACKLIGHT */
-#define TREO680_MAX_INTENSITY		254
-#define TREO680_DEFAULT_INTENSITY	160
-#define TREO680_LIMIT_MASK		0x7F
-#define TREO680_PRESCALER		63
-#define TREO680_PERIOD_NS		3500
-
-#endif
diff --git a/arch/arm/mach-pxa/palmgsm.c b/arch/arm/mach-pxa/palmgsm.c
new file mode 100644
index 0000000..99eb468
--- /dev/null
+++ b/arch/arm/mach-pxa/palmgsm.c
@@ -0,0 +1,559 @@
+/*
+ * Hardware definitions for Palm smartphones
+ *
+ * currently supported:
+ *     Palm Treo 680 (GSM)
+ *
+ * Author:     Tomas Cech <sleep_walker@suse.cz>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * (find more info at www.hackndev.com)
+ *
+ */
+
+#include <linux/platform_device.h>
+#include <linux/delay.h>
+#include <linux/irq.h>
+#include <linux/gpio_keys.h>
+#include <linux/input.h>
+#include <linux/pda_power.h>
+#include <linux/pwm_backlight.h>
+#include <linux/gpio.h>
+#include <linux/wm97xx_batt.h>
+#include <linux/power_supply.h>
+#include <linux/sysdev.h>
+#include <linux/w1-gpio.h>
+
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+
+#include <mach/pxa27x.h>
+#include <mach/pxa27x-udc.h>
+#include <mach/audio.h>
+#include <mach/palmgsm.h>
+#include <mach/mmc.h>
+#include <mach/pxafb.h>
+#include <mach/irda.h>
+#include <mach/pxa27x_keypad.h>
+#include <mach/udc.h>
+#include <mach/ohci.h>
+#include <mach/pxa2xx-regs.h>
+#include <mach/palmasoc.h>
+#include <mach/camera.h>
+
+#include <sound/pxa2xx-lib.h>
+
+#include "generic.h"
+#include "devices.h"
+
+/******************************************************************************
+ * Pin configuration
+ ******************************************************************************/
+static unsigned long palmgsm_pin_config[] __initdata = {
+	/* MMC */
+	GPIO32_MMC_CLK,
+	GPIO92_MMC_DAT_0,
+	GPIO109_MMC_DAT_1,
+	GPIO110_MMC_DAT_2,
+	GPIO111_MMC_DAT_3,
+	GPIO112_MMC_CMD,
+	GPIO113_GPIO,				/* SD detect */
+
+	/* AC97 */
+	GPIO28_AC97_BITCLK,
+	GPIO29_AC97_SDATA_IN_0,
+	GPIO30_AC97_SDATA_OUT,
+	GPIO31_AC97_SYNC,
+	GPIO89_AC97_SYSCLK,
+	GPIO95_AC97_nRESET,
+
+	/* IrDA */
+	GPIO46_FICP_RXD,
+	GPIO47_FICP_TXD,
+
+	/* PWM */
+	GPIO16_PWM0_OUT,
+
+	/* USB */
+	GPIO1_GPIO | WAKEUP_ON_EDGE_BOTH,	/* usb detect */
+
+	/* MATRIX KEYPAD */
+	GPIO101_KP_MKIN_1,
+	GPIO102_KP_MKIN_2,
+	GPIO97_KP_MKIN_3,
+	GPIO98_KP_MKIN_4,
+	GPIO91_KP_MKIN_6,
+	GPIO13_KP_MKIN_7,
+	GPIO103_KP_MKOUT_0 | MFP_LPM_DRIVE_HIGH,
+	GPIO104_KP_MKOUT_1,
+	GPIO105_KP_MKOUT_2,
+	GPIO106_KP_MKOUT_3,
+	GPIO107_KP_MKOUT_4,
+	GPIO108_KP_MKOUT_5,
+	GPIO96_KP_MKOUT_6,
+	GPIO93_KP_DKIN_0 | WAKEUP_ON_LEVEL_HIGH,	/* Hotsync button */
+
+	/* LCD */
+	GPIO58_LCD_LDD_0,
+	GPIO59_LCD_LDD_1,
+	GPIO60_LCD_LDD_2,
+	GPIO61_LCD_LDD_3,
+	GPIO62_LCD_LDD_4,
+	GPIO63_LCD_LDD_5,
+	GPIO64_LCD_LDD_6,
+	GPIO65_LCD_LDD_7,
+	GPIO66_LCD_LDD_8,
+	GPIO67_LCD_LDD_9,
+	GPIO68_LCD_LDD_10,
+	GPIO69_LCD_LDD_11,
+	GPIO70_LCD_LDD_12,
+	GPIO71_LCD_LDD_13,
+	GPIO72_LCD_LDD_14,
+	GPIO73_LCD_LDD_15,
+	GPIO74_LCD_FCLK,
+	GPIO75_LCD_LCLK,
+	GPIO76_LCD_PCLK,
+
+	/* Quick Capture Interface */
+	GPIO84_CIF_FV,
+	GPIO85_CIF_LV,
+	GPIO53_CIF_MCLK,
+	GPIO54_CIF_PCLK,
+	GPIO81_CIF_DD_0,
+	GPIO55_CIF_DD_1,
+	GPIO51_CIF_DD_2,
+	GPIO50_CIF_DD_3,
+	GPIO52_CIF_DD_4,
+	GPIO48_CIF_DD_5,
+	GPIO17_CIF_DD_6,
+	GPIO12_CIF_DD_7,
+
+	/* I2C */
+	GPIO117_I2C_SCL,
+	GPIO118_I2C_SDA,
+
+	/* GSM */
+	GPIO14_GPIO | WAKEUP_ON_EDGE_BOTH,	/* GSM host wake up */
+	GPIO34_FFUART_RXD,
+	GPIO35_FFUART_CTS,
+	GPIO39_FFUART_TXD,
+	GPIO41_FFUART_RTS,
+
+	/* MISC. */
+	GPIO0_GPIO | WAKEUP_ON_EDGE_BOTH,	/* external power detect */
+	GPIO15_GPIO | WAKEUP_ON_EDGE_BOTH,	/* silent switch */
+	GPIO116_GPIO,				/* headphone detect */
+	GPIO11_GPIO | WAKEUP_ON_EDGE_BOTH,	/* bluetooth host wake up */
+};
+
+#ifdef CONFIG_MACH_TREO680
+static unsigned long treo680_pin_config[] __initdata = {
+	GPIO33_GPIO,    /* SD read only */
+
+	/* MATRIX KEYPAD - different wake up source */
+	GPIO100_KP_MKIN_0 | WAKEUP_ON_LEVEL_HIGH,
+	GPIO99_KP_MKIN_5,
+};
+#endif
+
+/******************************************************************************
+ * SD/MMC card controller
+ ******************************************************************************/
+#ifdef CONFIG_MACH_TREO680
+static struct pxamci_platform_data treo680_mci_platform_data = {
+	.ocr_mask		= MMC_VDD_32_33 | MMC_VDD_33_34,
+	.gpio_card_detect	= GPIO_NR_PALMGSM_SD_DETECT_N,
+	.gpio_card_ro		= GPIO_NR_TREO680_SD_READONLY,
+	.gpio_power		= GPIO_NR_TREO680_SD_POWER,
+};
+#endif
+
+/******************************************************************************
+ * GPIO keyboard
+ ******************************************************************************/
+#ifdef CONFIG_MACH_TREO680
+static unsigned int treo680_matrix_keys[] = {
+	KEY(0, 0, KEY_F8),		/* Red/Off/Power */
+	KEY(0, 1, KEY_LEFT),
+	KEY(0, 2, KEY_LEFTCTRL),	/* Alternate */
+	KEY(0, 3, KEY_L),
+	KEY(0, 4, KEY_A),
+	KEY(0, 5, KEY_Q),
+	KEY(0, 6, KEY_P),
+
+	KEY(1, 0, KEY_RIGHTCTRL),	/* Menu */
+	KEY(1, 1, KEY_RIGHT),
+	KEY(1, 2, KEY_LEFTSHIFT),	/* Left shift */
+	KEY(1, 3, KEY_Z),
+	KEY(1, 4, KEY_S),
+	KEY(1, 5, KEY_W),
+
+	KEY(2, 0, KEY_F1),		/* Phone */
+	KEY(2, 1, KEY_UP),
+	KEY(2, 2, KEY_0),
+	KEY(2, 3, KEY_X),
+	KEY(2, 4, KEY_D),
+	KEY(2, 5, KEY_E),
+
+	KEY(3, 0, KEY_F10),		/* Calendar */
+	KEY(3, 1, KEY_DOWN),
+	KEY(3, 2, KEY_SPACE),
+	KEY(3, 3, KEY_C),
+	KEY(3, 4, KEY_F),
+	KEY(3, 5, KEY_R),
+
+	KEY(4, 0, KEY_F12),		/* Mail */
+	KEY(4, 1, KEY_KPENTER),
+	KEY(4, 2, KEY_RIGHTALT),	/* Alt */
+	KEY(4, 3, KEY_V),
+	KEY(4, 4, KEY_G),
+	KEY(4, 5, KEY_T),
+
+	KEY(5, 0, KEY_F9),		/* Home */
+	KEY(5, 1, KEY_PAGEUP),		/* Side up */
+	KEY(5, 2, KEY_DOT),
+	KEY(5, 3, KEY_B),
+	KEY(5, 4, KEY_H),
+	KEY(5, 5, KEY_Y),
+
+	KEY(6, 0, KEY_TAB),		/* Side Activate */
+	KEY(6, 1, KEY_PAGEDOWN),	/* Side down */
+	KEY(6, 2, KEY_ENTER),
+	KEY(6, 3, KEY_N),
+	KEY(6, 4, KEY_J),
+	KEY(6, 5, KEY_U),
+
+	KEY(7, 0, KEY_F6),		/* Green/Call */
+	KEY(7, 1, KEY_O),
+	KEY(7, 2, KEY_BACKSPACE),
+	KEY(7, 3, KEY_M),
+	KEY(7, 4, KEY_K),
+	KEY(7, 5, KEY_I),
+};
+
+static struct pxa27x_keypad_platform_data treo680_keypad_platform_data = {
+	.matrix_key_rows	= 8,
+	.matrix_key_cols	= 7,
+	.matrix_key_map		= treo680_matrix_keys,
+	.matrix_key_map_size	= ARRAY_SIZE(treo680_matrix_keys),
+	.direct_key_map		= { KEY_CONNECT },
+	.direct_key_num		= 1,
+
+	.debounce_interval	= 30,
+};
+#endif
+
+/******************************************************************************
+ * aSoC audio
+ ******************************************************************************/
+
+static pxa2xx_audio_ops_t palmgsm_ac97_pdata = {
+	.reset_gpio	= 95,
+};
+
+/******************************************************************************
+ * Backlight
+ ******************************************************************************/
+static int palmgsm_backlight_init(struct device *dev)
+{
+	int ret;
+
+	ret = gpio_request(GPIO_NR_PALMGSM_BL_POWER, "BL POWER");
+	if (ret)
+		goto err;
+	ret = gpio_direction_output(GPIO_NR_PALMGSM_BL_POWER, 0);
+	if (ret)
+		goto err2;
+
+	return 0;
+
+err2:
+	gpio_free(GPIO_NR_PALMGSM_BL_POWER);
+err:
+	return ret;
+}
+
+static int palmgsm_backlight_notify(int brightness)
+{
+	gpio_set_value(GPIO_NR_PALMGSM_BL_POWER, brightness);
+	return PALMGSM_MAX_INTENSITY - brightness;
+};
+
+static void palmgsm_backlight_exit(struct device *dev)
+{
+	gpio_free(GPIO_NR_PALMGSM_BL_POWER);
+}
+
+static struct platform_pwm_backlight_data palmgsm_backlight_data = {
+	.pwm_id		= 0,
+	.max_brightness	= PALMGSM_MAX_INTENSITY,
+	.dft_brightness	= PALMGSM_DEFAULT_INTENSITY,
+	.pwm_period_ns	= PALMGSM_PERIOD_NS,
+	.init		= palmgsm_backlight_init,
+	.notify		= palmgsm_backlight_notify,
+	.exit		= palmgsm_backlight_exit,
+};
+
+static struct platform_device palmgsm_backlight = {
+	.name	= "pwm-backlight",
+	.dev	= {
+		.parent		= &pxa27x_device_pwm0.dev,
+		.platform_data	= &palmgsm_backlight_data,
+	},
+};
+
+/******************************************************************************
+ * IrDA
+ ******************************************************************************/
+static void palmgsm_transceiver_mode(struct device *dev, int mode)
+{
+	gpio_set_value(GPIO_NR_PALMGSM_IR_EN, mode & IR_OFF);
+	pxa2xx_transceiver_mode(dev, mode);
+}
+
+static int palmgsm_irda_startup(struct device *dev)
+{
+	int err;
+
+	err = gpio_request(GPIO_NR_PALMGSM_IR_EN, "Ir port disable");
+	if (err)
+		goto err1;
+
+	err = gpio_direction_output(GPIO_NR_PALMGSM_IR_EN, 1);
+	if (err)
+		goto err2;
+
+	return 0;
+
+err2:
+	dev_err(dev, "palmgsm_irda: cannot change IR gpio direction\n");
+	gpio_free(GPIO_NR_PALMGSM_IR_EN);
+err1:
+	dev_err(dev, "palmgsm_irda: cannot allocate IR gpio\n");
+	return err;
+}
+
+static void palmgsm_irda_shutdown(struct device *dev)
+{
+	gpio_free(GPIO_NR_PALMGSM_IR_EN);
+}
+
+static struct pxaficp_platform_data palmgsm_ficp_info = {
+	.transceiver_cap  = IR_FIRMODE | IR_SIRMODE | IR_OFF,
+	.startup          = palmgsm_irda_startup,
+	.shutdown         = palmgsm_irda_shutdown,
+	.transceiver_mode = palmgsm_transceiver_mode,
+};
+
+/******************************************************************************
+ * UDC
+ ******************************************************************************/
+static struct pxa2xx_udc_mach_info palmgsm_udc_info __initdata = {
+	.gpio_vbus		= GPIO_NR_PALMGSM_USB_DETECT,
+	.gpio_vbus_inverted	= 1,
+	.gpio_pullup		= GPIO_NR_PALMGSM_USB_PULLUP,
+};
+
+
+/******************************************************************************
+ * USB host
+ ******************************************************************************/
+#ifdef CONFIG_MACH_TREO680
+static struct pxaohci_platform_data treo680_ohci_info = {
+	.port_mode    = PMM_PERPORT_MODE,
+	.flags        = ENABLE_PORT1 | ENABLE_PORT3,
+	.power_budget = 0,
+};
+#endif
+
+/******************************************************************************
+ * Power supply
+ ******************************************************************************/
+static int power_supply_init(struct device *dev)
+{
+	int ret;
+
+	ret = gpio_request(GPIO_NR_PALMGSM_POWER_DETECT, "CABLE_STATE_AC");
+	if (ret)
+		goto err1;
+	ret = gpio_direction_input(GPIO_NR_PALMGSM_POWER_DETECT);
+	if (ret)
+		goto err2;
+
+	return 0;
+
+err2:
+	gpio_free(GPIO_NR_PALMGSM_POWER_DETECT);
+err1:
+	return ret;
+}
+
+static int palmgsm_is_ac_online(void)
+{
+	return gpio_get_value(GPIO_NR_PALMGSM_POWER_DETECT);
+}
+
+static void power_supply_exit(struct device *dev)
+{
+	gpio_free(GPIO_NR_PALMGSM_POWER_DETECT);
+}
+
+static char *palmgsm_supplicants[] = {
+	"main-battery",
+};
+
+static struct pda_power_pdata power_supply_info = {
+	.init		 = power_supply_init,
+	.is_ac_online    = palmgsm_is_ac_online,
+	.exit		 = power_supply_exit,
+	.supplied_to     = palmgsm_supplicants,
+	.num_supplicants = ARRAY_SIZE(palmgsm_supplicants),
+};
+
+static struct platform_device power_supply = {
+	.name = "pda-power",
+	.id   = -1,
+	.dev  = {
+		.platform_data = &power_supply_info,
+	},
+};
+
+/******************************************************************************
+ * Vibra and LEDs
+ ******************************************************************************/
+#ifdef CONFIG_MACH_TREO680
+static struct gpio_led treo680_gpio_leds[] = {
+	{
+		.name			= "treo680:vibra:vibra",
+		.default_trigger	= "none",
+		.gpio			= GPIO_NR_TREO680_VIBRATE_EN,
+	},
+	{
+		.name			= "treo680:green:led",
+		.default_trigger	= "mmc0",
+		.gpio			= GPIO_NR_PALMGSM_GREEN_LED,
+	},
+	{
+		.name			= "treo680:keybbl:keybbl",
+		.default_trigger	= "none",
+		.gpio			= GPIO_NR_TREO680_KEYB_BL,
+	},
+};
+
+static struct gpio_led_platform_data treo680_gpio_led_info = {
+	.leds		= treo680_gpio_leds,
+	.num_leds	= ARRAY_SIZE(treo680_gpio_leds),
+};
+
+static struct platform_device treo680_leds = {
+	.name   = "leds-gpio",
+	.id     = -1,
+	.dev    = {
+		.platform_data  = &treo680_gpio_led_info,
+	}
+};
+#endif
+
+/******************************************************************************
+ * Framebuffer
+ ******************************************************************************/
+/* TODO: add support for 324x324 */
+static struct pxafb_mode_info palmgsm_lcd_modes[] = {
+{
+	.pixclock		= 86538,
+	.xres			= 320,
+	.yres			= 320,
+	.bpp			= 16,
+
+	.left_margin		= 20,
+	.right_margin		= 8,
+	.upper_margin		= 8,
+	.lower_margin		= 5,
+
+	.hsync_len		= 4,
+	.vsync_len		= 1,
+},
+};
+
+static struct pxafb_mach_info palmgsm_lcd_screen = {
+	.modes		= palmgsm_lcd_modes,
+	.num_modes	= ARRAY_SIZE(palmgsm_lcd_modes),
+	.lcd_conn	= LCD_COLOR_TFT_16BPP | LCD_PCLK_EDGE_FALL,
+};
+
+/******************************************************************************
+ * Power management - standby
+ ******************************************************************************/
+static void __init palmgsm_pm_init(void)
+{
+	static u32 resume[] = {
+		0xe3a00101,	/* mov	r0,	#0x40000000 */
+		0xe380060f,	/* orr	r0, r0, #0x00f00000 */
+		0xe590f008,	/* ldr	pc, [r0, #0x08] */
+	};
+
+	/* this is where the bootloader jumps */
+	memcpy(phys_to_virt(PALMGSM_STR_BASE), resume, sizeof(resume));
+}
+
+/******************************************************************************
+ * Machine init
+ ******************************************************************************/
+static struct platform_device *palmgsm_devices[] __initdata = {
+	&palmgsm_backlight,
+	&power_supply,
+};
+
+#ifdef CONFIG_MACH_TREO680
+static struct platform_device *treo680_devices[] __initdata = {
+	&treo680_leds,
+};
+#endif
+
+/* setup udc GPIOs initial state */
+static void __init palmgsm_udc_init(void)
+{
+	if (!gpio_request(GPIO_NR_PALMGSM_USB_PULLUP, "UDC Vbus")) {
+		gpio_direction_output(GPIO_NR_PALMGSM_USB_PULLUP, 1);
+		gpio_free(GPIO_NR_PALMGSM_USB_PULLUP);
+	}
+}
+
+static void __init palmgsm_init(void)
+{
+	palmgsm_pm_init();
+	pxa2xx_mfp_config(ARRAY_AND_SIZE(palmgsm_pin_config));
+	set_pxa_fb_info(&palmgsm_lcd_screen);
+	palmgsm_udc_init();
+	pxa_set_udc_info(&palmgsm_udc_info);
+	pxa_set_ac97_info(&palmgsm_ac97_pdata);
+	pxa_set_ficp_info(&palmgsm_ficp_info);
+
+	platform_add_devices(ARRAY_AND_SIZE(palmgsm_devices));
+}
+
+#ifdef CONFIG_MACH_TREO680
+static void __init treo680_init(void)
+{
+ 	palmgsm_init();
+	pxa2xx_mfp_config(ARRAY_AND_SIZE(treo680_pin_config));
+	pxa_set_keypad_info(&treo680_keypad_platform_data);
+	pxa_set_mci_info(&treo680_mci_platform_data);
+	pxa_set_ohci_info(&treo680_ohci_info);
+	platform_add_devices(ARRAY_AND_SIZE(treo680_devices));
+}
+
+MACHINE_START(TREO680, "Palm Treo 680")
+	.phys_io	= PALMGSM_PHYS_IO_START,
+	.io_pg_offst	= io_p2v(0x40000000),
+	.boot_params	= 0xa0000100,
+	.map_io		= pxa_map_io,
+	.init_irq	= pxa27x_init_irq,
+	.timer		= &pxa_timer,
+	.init_machine	= treo680_init,
+MACHINE_END
+#endif
diff --git a/arch/arm/mach-pxa/treo680.c b/arch/arm/mach-pxa/treo680.c
deleted file mode 100644
index d88114c..0000000
--- a/arch/arm/mach-pxa/treo680.c
+++ /dev/null
@@ -1,528 +0,0 @@
-/*
- * Hardware definitions for Palm Treo 680
- *
- * Author:     Tomas Cech <sleep_walker@suse.cz>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * (find more info at www.hackndev.com)
- *
- */
-
-#include <linux/platform_device.h>
-#include <linux/delay.h>
-#include <linux/irq.h>
-#include <linux/gpio_keys.h>
-#include <linux/input.h>
-#include <linux/pda_power.h>
-#include <linux/pwm_backlight.h>
-#include <linux/gpio.h>
-#include <linux/wm97xx_batt.h>
-#include <linux/power_supply.h>
-#include <linux/sysdev.h>
-#include <linux/w1-gpio.h>
-
-#include <asm/mach-types.h>
-#include <asm/mach/arch.h>
-#include <asm/mach/map.h>
-
-#include <mach/pxa27x.h>
-#include <mach/pxa27x-udc.h>
-#include <mach/audio.h>
-#include <mach/treo680.h>
-#include <mach/mmc.h>
-#include <mach/pxafb.h>
-#include <mach/irda.h>
-#include <mach/pxa27x_keypad.h>
-#include <mach/udc.h>
-#include <mach/ohci.h>
-#include <mach/pxa2xx-regs.h>
-#include <mach/palmasoc.h>
-#include <mach/camera.h>
-
-#include <sound/pxa2xx-lib.h>
-
-#include "generic.h"
-#include "devices.h"
-
-/******************************************************************************
- * Pin configuration
- ******************************************************************************/
-static unsigned long treo680_pin_config[] __initdata = {
-	/* MMC */
-	GPIO32_MMC_CLK,
-	GPIO92_MMC_DAT_0,
-	GPIO109_MMC_DAT_1,
-	GPIO110_MMC_DAT_2,
-	GPIO111_MMC_DAT_3,
-	GPIO112_MMC_CMD,
-	GPIO33_GPIO,				/* SD read only */
-	GPIO113_GPIO,				/* SD detect */
-
-	/* AC97 */
-	GPIO28_AC97_BITCLK,
-	GPIO29_AC97_SDATA_IN_0,
-	GPIO30_AC97_SDATA_OUT,
-	GPIO31_AC97_SYNC,
-	GPIO89_AC97_SYSCLK,
-	GPIO95_AC97_nRESET,
-
-	/* IrDA */
-	GPIO46_FICP_RXD,
-	GPIO47_FICP_TXD,
-
-	/* PWM */
-	GPIO16_PWM0_OUT,
-
-	/* USB */
-	GPIO1_GPIO | WAKEUP_ON_EDGE_BOTH,	/* usb detect */
-
-	/* MATRIX KEYPAD */
-	GPIO100_KP_MKIN_0 | WAKEUP_ON_LEVEL_HIGH,
-	GPIO101_KP_MKIN_1,
-	GPIO102_KP_MKIN_2,
-	GPIO97_KP_MKIN_3,
-	GPIO98_KP_MKIN_4,
-	GPIO99_KP_MKIN_5,
-	GPIO91_KP_MKIN_6,
-	GPIO13_KP_MKIN_7,
-	GPIO103_KP_MKOUT_0 | MFP_LPM_DRIVE_HIGH,
-	GPIO104_KP_MKOUT_1,
-	GPIO105_KP_MKOUT_2,
-	GPIO106_KP_MKOUT_3,
-	GPIO107_KP_MKOUT_4,
-	GPIO108_KP_MKOUT_5,
-	GPIO96_KP_MKOUT_6,
-	GPIO93_KP_DKIN_0 | WAKEUP_ON_LEVEL_HIGH,	/* Hotsync button */
-
-	/* LCD */
-	GPIO58_LCD_LDD_0,
-	GPIO59_LCD_LDD_1,
-	GPIO60_LCD_LDD_2,
-	GPIO61_LCD_LDD_3,
-	GPIO62_LCD_LDD_4,
-	GPIO63_LCD_LDD_5,
-	GPIO64_LCD_LDD_6,
-	GPIO65_LCD_LDD_7,
-	GPIO66_LCD_LDD_8,
-	GPIO67_LCD_LDD_9,
-	GPIO68_LCD_LDD_10,
-	GPIO69_LCD_LDD_11,
-	GPIO70_LCD_LDD_12,
-	GPIO71_LCD_LDD_13,
-	GPIO72_LCD_LDD_14,
-	GPIO73_LCD_LDD_15,
-	GPIO74_LCD_FCLK,
-	GPIO75_LCD_LCLK,
-	GPIO76_LCD_PCLK,
-
-	/* Quick Capture Interface */
-	GPIO84_CIF_FV,
-	GPIO85_CIF_LV,
-	GPIO53_CIF_MCLK,
-	GPIO54_CIF_PCLK,
-	GPIO81_CIF_DD_0,
-	GPIO55_CIF_DD_1,
-	GPIO51_CIF_DD_2,
-	GPIO50_CIF_DD_3,
-	GPIO52_CIF_DD_4,
-	GPIO48_CIF_DD_5,
-	GPIO17_CIF_DD_6,
-	GPIO12_CIF_DD_7,
-
-	/* I2C */
-	GPIO117_I2C_SCL,
-	GPIO118_I2C_SDA,
-
-	/* GSM */
-	GPIO14_GPIO | WAKEUP_ON_EDGE_BOTH,	/* GSM host wake up */
-	GPIO34_FFUART_RXD,
-	GPIO35_FFUART_CTS,
-	GPIO39_FFUART_TXD,
-	GPIO41_FFUART_RTS,
-
-	/* MISC. */
-	GPIO0_GPIO | WAKEUP_ON_EDGE_BOTH,	/* external power detect */
-	GPIO15_GPIO | WAKEUP_ON_EDGE_BOTH,	/* silent switch */
-	GPIO116_GPIO,				/* headphone detect */
-	GPIO11_GPIO | WAKEUP_ON_EDGE_BOTH,	/* bluetooth host wake up */
-};
-
-/******************************************************************************
- * SD/MMC card controller
- ******************************************************************************/
-static struct pxamci_platform_data treo680_mci_platform_data = {
-	.ocr_mask		= MMC_VDD_32_33 | MMC_VDD_33_34,
-	.gpio_card_detect	= GPIO_NR_TREO680_SD_DETECT_N,
-	.gpio_card_ro		= GPIO_NR_TREO680_SD_READONLY,
-	.gpio_power		= GPIO_NR_TREO680_SD_POWER,
-};
-
-/******************************************************************************
- * GPIO keyboard
- ******************************************************************************/
-static unsigned int treo680_matrix_keys[] = {
-	KEY(0, 0, KEY_F8),		/* Red/Off/Power */
-	KEY(0, 1, KEY_LEFT),
-	KEY(0, 2, KEY_LEFTCTRL),	/* Alternate */
-	KEY(0, 3, KEY_L),
-	KEY(0, 4, KEY_A),
-	KEY(0, 5, KEY_Q),
-	KEY(0, 6, KEY_P),
-
-	KEY(1, 0, KEY_RIGHTCTRL),	/* Menu */
-	KEY(1, 1, KEY_RIGHT),
-	KEY(1, 2, KEY_LEFTSHIFT),	/* Left shift */
-	KEY(1, 3, KEY_Z),
-	KEY(1, 4, KEY_S),
-	KEY(1, 5, KEY_W),
-
-	KEY(2, 0, KEY_F1),		/* Phone */
-	KEY(2, 1, KEY_UP),
-	KEY(2, 2, KEY_0),
-	KEY(2, 3, KEY_X),
-	KEY(2, 4, KEY_D),
-	KEY(2, 5, KEY_E),
-
-	KEY(3, 0, KEY_F10),		/* Calendar */
-	KEY(3, 1, KEY_DOWN),
-	KEY(3, 2, KEY_SPACE),
-	KEY(3, 3, KEY_C),
-	KEY(3, 4, KEY_F),
-	KEY(3, 5, KEY_R),
-
-	KEY(4, 0, KEY_F12),		/* Mail */
-	KEY(4, 1, KEY_KPENTER),
-	KEY(4, 2, KEY_RIGHTALT),	/* Alt */
-	KEY(4, 3, KEY_V),
-	KEY(4, 4, KEY_G),
-	KEY(4, 5, KEY_T),
-
-	KEY(5, 0, KEY_F9),		/* Home */
-	KEY(5, 1, KEY_PAGEUP),		/* Side up */
-	KEY(5, 2, KEY_DOT),
-	KEY(5, 3, KEY_B),
-	KEY(5, 4, KEY_H),
-	KEY(5, 5, KEY_Y),
-
-	KEY(6, 0, KEY_TAB),		/* Side Activate */
-	KEY(6, 1, KEY_PAGEDOWN),	/* Side down */
-	KEY(6, 2, KEY_ENTER),
-	KEY(6, 3, KEY_N),
-	KEY(6, 4, KEY_J),
-	KEY(6, 5, KEY_U),
-
-	KEY(7, 0, KEY_F6),		/* Green/Call */
-	KEY(7, 1, KEY_O),
-	KEY(7, 2, KEY_BACKSPACE),
-	KEY(7, 3, KEY_M),
-	KEY(7, 4, KEY_K),
-	KEY(7, 5, KEY_I),
-};
-
-static struct pxa27x_keypad_platform_data treo680_keypad_platform_data = {
-	.matrix_key_rows	= 8,
-	.matrix_key_cols	= 7,
-	.matrix_key_map		= treo680_matrix_keys,
-	.matrix_key_map_size	= ARRAY_SIZE(treo680_matrix_keys),
-	.direct_key_map		= { KEY_CONNECT },
-	.direct_key_num		= 1,
-
-	.debounce_interval	= 30,
-};
-
-/******************************************************************************
- * aSoC audio
- ******************************************************************************/
-
-static pxa2xx_audio_ops_t treo680_ac97_pdata = {
-	.reset_gpio	= 95,
-};
-
-/******************************************************************************
- * Backlight
- ******************************************************************************/
-static int treo680_backlight_init(struct device *dev)
-{
-	int ret;
-
-	ret = gpio_request(GPIO_NR_TREO680_BL_POWER, "BL POWER");
-	if (ret)
-		goto err;
-	ret = gpio_direction_output(GPIO_NR_TREO680_BL_POWER, 0);
-	if (ret)
-		goto err2;
-
-	return 0;
-
-err2:
-	gpio_free(GPIO_NR_TREO680_BL_POWER);
-err:
-	return ret;
-}
-
-static int treo680_backlight_notify(int brightness)
-{
-	gpio_set_value(GPIO_NR_TREO680_BL_POWER, brightness);
-	return TREO680_MAX_INTENSITY - brightness;
-};
-
-static void treo680_backlight_exit(struct device *dev)
-{
-	gpio_free(GPIO_NR_TREO680_BL_POWER);
-}
-
-static struct platform_pwm_backlight_data treo680_backlight_data = {
-	.pwm_id		= 0,
-	.max_brightness	= TREO680_MAX_INTENSITY,
-	.dft_brightness	= TREO680_DEFAULT_INTENSITY,
-	.pwm_period_ns	= TREO680_PERIOD_NS,
-	.init		= treo680_backlight_init,
-	.notify		= treo680_backlight_notify,
-	.exit		= treo680_backlight_exit,
-};
-
-static struct platform_device treo680_backlight = {
-	.name	= "pwm-backlight",
-	.dev	= {
-		.parent		= &pxa27x_device_pwm0.dev,
-		.platform_data	= &treo680_backlight_data,
-	},
-};
-
-/******************************************************************************
- * IrDA
- ******************************************************************************/
-static void treo680_transceiver_mode(struct device *dev, int mode)
-{
-	gpio_set_value(GPIO_NR_TREO680_IR_EN, mode & IR_OFF);
-	pxa2xx_transceiver_mode(dev, mode);
-}
-
-static int treo680_irda_startup(struct device *dev)
-{
-	int err;
-
-	err = gpio_request(GPIO_NR_TREO680_IR_EN, "Ir port disable");
-	if (err)
-		goto err1;
-
-	err = gpio_direction_output(GPIO_NR_TREO680_IR_EN, 1);
-	if (err)
-		goto err2;
-
-	return 0;
-
-err2:
-	dev_err(dev, "treo680_irda: cannot change IR gpio direction\n");
-	gpio_free(GPIO_NR_TREO680_IR_EN);
-err1:
-	dev_err(dev, "treo680_irda: cannot allocate IR gpio\n");
-	return err;
-}
-
-static void treo680_irda_shutdown(struct device *dev)
-{
-	gpio_free(GPIO_NR_TREO680_IR_EN);
-}
-
-static struct pxaficp_platform_data treo680_ficp_info = {
-	.transceiver_cap  = IR_FIRMODE | IR_SIRMODE | IR_OFF,
-	.startup          = treo680_irda_startup,
-	.shutdown         = treo680_irda_shutdown,
-	.transceiver_mode = treo680_transceiver_mode,
-};
-
-/******************************************************************************
- * UDC
- ******************************************************************************/
-static struct pxa2xx_udc_mach_info treo680_udc_info __initdata = {
-	.gpio_vbus		= GPIO_NR_TREO680_USB_DETECT,
-	.gpio_vbus_inverted	= 1,
-	.gpio_pullup		= GPIO_NR_TREO680_USB_PULLUP,
-};
-
-
-/******************************************************************************
- * USB host
- ******************************************************************************/
-static struct pxaohci_platform_data treo680_ohci_info = {
-	.port_mode    = PMM_PERPORT_MODE,
-	.flags        = ENABLE_PORT1 | ENABLE_PORT3,
-	.power_budget = 0,
-};
-
-/******************************************************************************
- * Power supply
- ******************************************************************************/
-static int power_supply_init(struct device *dev)
-{
-	int ret;
-
-	ret = gpio_request(GPIO_NR_TREO680_POWER_DETECT, "CABLE_STATE_AC");
-	if (ret)
-		goto err1;
-	ret = gpio_direction_input(GPIO_NR_TREO680_POWER_DETECT);
-	if (ret)
-		goto err2;
-
-	return 0;
-
-err2:
-	gpio_free(GPIO_NR_TREO680_POWER_DETECT);
-err1:
-	return ret;
-}
-
-static int treo680_is_ac_online(void)
-{
-	return gpio_get_value(GPIO_NR_TREO680_POWER_DETECT);
-}
-
-static void power_supply_exit(struct device *dev)
-{
-	gpio_free(GPIO_NR_TREO680_POWER_DETECT);
-}
-
-static char *treo680_supplicants[] = {
-	"main-battery",
-};
-
-static struct pda_power_pdata power_supply_info = {
-	.init		 = power_supply_init,
-	.is_ac_online    = treo680_is_ac_online,
-	.exit		 = power_supply_exit,
-	.supplied_to     = treo680_supplicants,
-	.num_supplicants = ARRAY_SIZE(treo680_supplicants),
-};
-
-static struct platform_device power_supply = {
-	.name = "pda-power",
-	.id   = -1,
-	.dev  = {
-		.platform_data = &power_supply_info,
-	},
-};
-
-/******************************************************************************
- * Vibra and LEDs
- ******************************************************************************/
-static struct gpio_led gpio_leds[] = {
-	{
-		.name			= "treo680:vibra:vibra",
-		.default_trigger	= "none",
-		.gpio			= GPIO_NR_TREO680_VIBRATE_EN,
-	},
-	{
-		.name			= "treo680:green:led",
-		.default_trigger	= "mmc0",
-		.gpio			= GPIO_NR_TREO680_GREEN_LED,
-	},
-	{
-		.name			= "treo680:keybbl:keybbl",
-		.default_trigger	= "none",
-		.gpio			= GPIO_NR_TREO680_KEYB_BL,
-	},
-};
-
-static struct gpio_led_platform_data gpio_led_info = {
-	.leds		= gpio_leds,
-	.num_leds	= ARRAY_SIZE(gpio_leds),
-};
-
-static struct platform_device treo680_leds = {
-	.name   = "leds-gpio",
-	.id     = -1,
-	.dev    = {
-		.platform_data  = &gpio_led_info,
-	}
-};
-
-
-/******************************************************************************
- * Framebuffer
- ******************************************************************************/
-/* TODO: add support for 324x324 */
-static struct pxafb_mode_info treo680_lcd_modes[] = {
-{
-	.pixclock		= 86538,
-	.xres			= 320,
-	.yres			= 320,
-	.bpp			= 16,
-
-	.left_margin		= 20,
-	.right_margin		= 8,
-	.upper_margin		= 8,
-	.lower_margin		= 5,
-
-	.hsync_len		= 4,
-	.vsync_len		= 1,
-},
-};
-
-static struct pxafb_mach_info treo680_lcd_screen = {
-	.modes		= treo680_lcd_modes,
-	.num_modes	= ARRAY_SIZE(treo680_lcd_modes),
-	.lcd_conn	= LCD_COLOR_TFT_16BPP | LCD_PCLK_EDGE_FALL,
-};
-
-/******************************************************************************
- * Power management - standby
- ******************************************************************************/
-static void __init treo680_pm_init(void)
-{
-	static u32 resume[] = {
-		0xe3a00101,	/* mov	r0,	#0x40000000 */
-		0xe380060f,	/* orr	r0, r0, #0x00f00000 */
-		0xe590f008,	/* ldr	pc, [r0, #0x08] */
-	};
-
-	/* this is where the bootloader jumps */
-	memcpy(phys_to_virt(TREO680_STR_BASE), resume, sizeof(resume));
-}
-
-/******************************************************************************
- * Machine init
- ******************************************************************************/
-static struct platform_device *devices[] __initdata = {
-	&treo680_backlight,
-	&treo680_leds,
-	&power_supply,
-};
-
-/* setup udc GPIOs initial state */
-static void __init treo680_udc_init(void)
-{
-	if (!gpio_request(GPIO_NR_TREO680_USB_PULLUP, "UDC Vbus")) {
-		gpio_direction_output(GPIO_NR_TREO680_USB_PULLUP, 1);
-		gpio_free(GPIO_NR_TREO680_USB_PULLUP);
-	}
-}
-
-static void __init treo680_init(void)
-{
-	treo680_pm_init();
-	pxa2xx_mfp_config(ARRAY_AND_SIZE(treo680_pin_config));
-	pxa_set_keypad_info(&treo680_keypad_platform_data);
-	set_pxa_fb_info(&treo680_lcd_screen);
-	pxa_set_mci_info(&treo680_mci_platform_data);
-	treo680_udc_init();
-	pxa_set_udc_info(&treo680_udc_info);
-	pxa_set_ac97_info(&treo680_ac97_pdata);
-	pxa_set_ficp_info(&treo680_ficp_info);
-	pxa_set_ohci_info(&treo680_ohci_info);
-
-	platform_add_devices(devices, ARRAY_SIZE(devices));
-}
-
-MACHINE_START(TREO680, "Palm Treo 680")
-	.phys_io	= TREO680_PHYS_IO_START,
-	.io_pg_offst	= io_p2v(0x40000000),
-	.boot_params	= 0xa0000100,
-	.map_io		= pxa_map_io,
-	.init_irq	= pxa27x_init_irq,
-	.timer		= &pxa_timer,
-	.init_machine	= treo680_init,
-MACHINE_END
-- 
1.6.3.3
