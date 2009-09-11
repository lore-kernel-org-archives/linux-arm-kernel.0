From: sleep_walker@suse.cz (=?UTF-8?q?Tom=C3=A1=C5=A1=20=C4=8Cech?=)
Date: Fri, 11 Sep 2009 13:57:01 +0200
Subject: [PATCH 1/2] PalmTreo: generalisation of Treo680 code
In-Reply-To: <1252670222-25233-1-git-send-email-sleep_walker@suse.cz>
References: <1252670222-25233-1-git-send-email-sleep_walker@suse.cz>
Message-ID: <1252670222-25233-2-git-send-email-sleep_walker@suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tom?? ?ech <sleep walker@suse.cz>

Signed-off-by: Tom?? ?ech <sleep_walker@suse.cz>
---
 arch/arm/mach-pxa/Kconfig                   |    5 +
 arch/arm/mach-pxa/Makefile                  |    2 +-
 arch/arm/mach-pxa/include/mach/palmtreo.h   |   60 ++++++++
 arch/arm/mach-pxa/include/mach/treo680.h    |   49 -------
 arch/arm/mach-pxa/{treo680.c => palmtreo.c} |  202 ++++++++++++++++-----------
 5 files changed, 183 insertions(+), 135 deletions(-)
 create mode 100644 arch/arm/mach-pxa/include/mach/palmtreo.h
 delete mode 100644 arch/arm/mach-pxa/include/mach/treo680.h
 rename arch/arm/mach-pxa/{treo680.c => palmtreo.c} (69%)

diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
index a6f8eab..ce6519c 100644
--- a/arch/arm/mach-pxa/Kconfig
+++ b/arch/arm/mach-pxa/Kconfig
@@ -421,12 +421,17 @@ config MACH_PALMZ72
 	  Say Y here if you intend to run this kernel on Palm Zire 72
 	  handheld computer.
 
+config PALM_TREO
+	bool
+	depends on ARCH_PXA_PALM
+
 config MACH_TREO680
 	bool "Palm Treo 680"
 	default y
 	depends on ARCH_PXA_PALM
 	select PXA27x
 	select IWMMXT
+	select PALM_TREO
 	help
 	  Say Y here if you intend to run this kernel on Palm Treo 680
 	  smartphone.
diff --git a/arch/arm/mach-pxa/Makefile b/arch/arm/mach-pxa/Makefile
index f10e152..e5d450c 100644
--- a/arch/arm/mach-pxa/Makefile
+++ b/arch/arm/mach-pxa/Makefile
@@ -64,7 +64,7 @@ obj-$(CONFIG_MACH_PALMT5)	+= palmt5.o
 obj-$(CONFIG_MACH_PALMTX)	+= palmtx.o
 obj-$(CONFIG_MACH_PALMLD)	+= palmld.o
 obj-$(CONFIG_MACH_PALMZ72)	+= palmz72.o
-obj-$(CONFIG_MACH_TREO680)	+= treo680.o
+obj-$(CONFIG_PALM_TREO)		+= palmtreo.o
 obj-$(CONFIG_ARCH_VIPER)	+= viper.o
 
 ifeq ($(CONFIG_MACH_ZYLONITE),y)
diff --git a/arch/arm/mach-pxa/include/mach/palmtreo.h b/arch/arm/mach-pxa/include/mach/palmtreo.h
new file mode 100644
index 0000000..8cb0bca
--- /dev/null
+++ b/arch/arm/mach-pxa/include/mach/palmtreo.h
@@ -0,0 +1,60 @@
+/*
+ * GPIOs and interrupts for Palm Treo smartphones
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
+#ifndef _INCLUDE_TREO_H_
+#define _INCLUDE_TREO_H_
+
+/* GPIOs */
+#define GPIO_NR_TREO_POWER_DETECT	0
+#define GPIO_NR_TREO_AMP_EN		27
+#define GPIO_NR_TREO_GREEN_LED	20
+#define GPIO_NR_TREO_RED_LED		79
+#define GPIO_NR_TREO_SD_DETECT_N	113
+#define GPIO_NR_TREO_EP_DETECT_N	116
+#define GPIO_NR_TREO_USB_DETECT	1
+#define GPIO_NR_TREO_USB_PULLUP	114
+#define GPIO_NR_TREO_GSM_POWER	40
+#define GPIO_NR_TREO_GSM_RESET	87
+#define GPIO_NR_TREO_GSM_WAKE	57
+#define GPIO_NR_TREO_GSM_HOST_WAKE	14
+#define GPIO_NR_TREO_GSM_TRIGGER	10
+#define GPIO_NR_TREO_IR_EN		115
+#define GPIO_NR_TREO_IR_TXD		47
+#define GPIO_NR_TREO_BL_POWER	38
+#define GPIO_NR_TREO_LCD_POWER	25
+
+/* Treo680 specific GPIOs */
+#ifdef CONFIG_MACH_TREO680
+#define GPIO_NR_TREO680_SD_READONLY	33
+#define GPIO_NR_TREO680_SD_POWER	42
+#define GPIO_NR_TREO680_VIBRATE_EN	44
+#define GPIO_NR_TREO680_KEYB_BL		24
+#define GPIO_NR_TREO680_BT_EN		43
+#endif /* CONFIG_MACH_TREO680 */
+
+/* Various addresses  */
+#define TREO_PHYS_RAM_START	0xa0000000
+#define TREO_PHYS_IO_START	0x40000000
+#define TREO_STR_BASE	0xa2000000
+
+/* BACKLIGHT */
+#define TREO_MAX_INTENSITY		254
+#define TREO_DEFAULT_INTENSITY	160
+#define TREO_LIMIT_MASK		0x7F
+#define TREO_PRESCALER		63
+#define TREO_PERIOD_NS		3500
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
diff --git a/arch/arm/mach-pxa/treo680.c b/arch/arm/mach-pxa/palmtreo.c
similarity index 69%
rename from arch/arm/mach-pxa/treo680.c
rename to arch/arm/mach-pxa/palmtreo.c
index fe08507..5e66028 100644
--- a/arch/arm/mach-pxa/treo680.c
+++ b/arch/arm/mach-pxa/palmtreo.c
@@ -1,5 +1,8 @@
 /*
- * Hardware definitions for Palm Treo 680
+ * Hardware definitions for Palm Treo smartphones
+ *
+ * currently supported:
+ *     Palm Treo 680 (GSM)
  *
  * Author:     Tomas Cech <sleep_walker@suse.cz>
  *
@@ -31,7 +34,7 @@
 #include <mach/pxa27x.h>
 #include <mach/pxa27x-udc.h>
 #include <mach/audio.h>
-#include <mach/treo680.h>
+#include <mach/palmtreo.h>
 #include <mach/mmc.h>
 #include <mach/pxafb.h>
 #include <mach/irda.h>
@@ -50,7 +53,7 @@
 /******************************************************************************
  * Pin configuration
  ******************************************************************************/
-static unsigned long treo680_pin_config[] __initdata = {
+static unsigned long treo_pin_config[] __initdata = {
 	/* MMC */
 	GPIO32_MMC_CLK,
 	GPIO92_MMC_DAT_0,
@@ -58,7 +61,6 @@ static unsigned long treo680_pin_config[] __initdata = {
 	GPIO110_MMC_DAT_2,
 	GPIO111_MMC_DAT_3,
 	GPIO112_MMC_CMD,
-	GPIO33_GPIO,				/* SD read only */
 	GPIO113_GPIO,				/* SD detect */
 
 	/* AC97 */
@@ -80,12 +82,10 @@ static unsigned long treo680_pin_config[] __initdata = {
 	GPIO1_GPIO | WAKEUP_ON_EDGE_BOTH,	/* usb detect */
 
 	/* MATRIX KEYPAD */
-	GPIO100_KP_MKIN_0 | WAKEUP_ON_LEVEL_HIGH,
 	GPIO101_KP_MKIN_1,
 	GPIO102_KP_MKIN_2,
 	GPIO97_KP_MKIN_3,
 	GPIO98_KP_MKIN_4,
-	GPIO99_KP_MKIN_5,
 	GPIO91_KP_MKIN_6,
 	GPIO13_KP_MKIN_7,
 	GPIO103_KP_MKOUT_0 | MFP_LPM_DRIVE_HIGH,
@@ -150,19 +150,32 @@ static unsigned long treo680_pin_config[] __initdata = {
 	GPIO11_GPIO | WAKEUP_ON_EDGE_BOTH,	/* bluetooth host wake up */
 };
 
+#ifdef CONFIG_MACH_TREO680
+static unsigned long treo680_pin_config[] __initdata = {
+	GPIO33_GPIO,    /* SD read only */
+
+	/* MATRIX KEYPAD - different wake up source */
+	GPIO100_KP_MKIN_0 | WAKEUP_ON_LEVEL_HIGH,
+	GPIO99_KP_MKIN_5,
+};
+#endif /* CONFIG_MACH_TREO680 */
+
 /******************************************************************************
  * SD/MMC card controller
  ******************************************************************************/
+#ifdef CONFIG_MACH_TREO680
 static struct pxamci_platform_data treo680_mci_platform_data = {
 	.ocr_mask		= MMC_VDD_32_33 | MMC_VDD_33_34,
-	.gpio_card_detect	= GPIO_NR_TREO680_SD_DETECT_N,
+	.gpio_card_detect	= GPIO_NR_TREO_SD_DETECT_N,
 	.gpio_card_ro		= GPIO_NR_TREO680_SD_READONLY,
 	.gpio_power		= GPIO_NR_TREO680_SD_POWER,
 };
+#endif /* CONFIG_MACH_TREO680 */
 
 /******************************************************************************
  * GPIO keyboard
  ******************************************************************************/
+#ifdef CONFIG_MACH_TREO680
 static unsigned int treo680_matrix_keys[] = {
 	KEY(0, 0, KEY_F8),		/* Red/Off/Power */
 	KEY(0, 1, KEY_LEFT),
@@ -232,92 +245,95 @@ static struct pxa27x_keypad_platform_data treo680_keypad_platform_data = {
 
 	.debounce_interval	= 30,
 };
+#endif /* CONFIG_MACH_TREO680 */
 
 /******************************************************************************
  * aSoC audio
  ******************************************************************************/
 
-static pxa2xx_audio_ops_t treo680_ac97_pdata = {
+static pxa2xx_audio_ops_t treo_ac97_pdata = {
 	.reset_gpio	= 95,
 };
 
 /******************************************************************************
  * Backlight
  ******************************************************************************/
-static int treo680_backlight_init(struct device *dev)
+static int treo_backlight_init(struct device *dev)
 {
 	int ret;
 
-	ret = gpio_request(GPIO_NR_TREO680_BL_POWER, "BL POWER");
+	ret = gpio_request(GPIO_NR_TREO_BL_POWER, "BL POWER");
 	if (ret)
 		goto err;
-	ret = gpio_direction_output(GPIO_NR_TREO680_BL_POWER, 0);
+	ret = gpio_direction_output(GPIO_NR_TREO_BL_POWER, 0);
 	if (ret)
 		goto err2;
 
 	return 0;
 
 err2:
-	gpio_free(GPIO_NR_TREO680_BL_POWER);
+	gpio_free(GPIO_NR_TREO_BL_POWER);
 err:
 	return ret;
 }
 
-static int treo680_backlight_notify(int brightness)
+static int treo_backlight_notify(int brightness)
 {
-	gpio_set_value(GPIO_NR_TREO680_BL_POWER, brightness);
-	return TREO680_MAX_INTENSITY - brightness;
+	gpio_set_value(GPIO_NR_TREO_BL_POWER, brightness);
+	return TREO_MAX_INTENSITY - brightness;
 };
 
-static void treo680_backlight_exit(struct device *dev)
+static void treo_backlight_exit(struct device *dev)
 {
-	gpio_free(GPIO_NR_TREO680_BL_POWER);
+	gpio_free(GPIO_NR_TREO_BL_POWER);
 }
 
-static struct platform_pwm_backlight_data treo680_backlight_data = {
+static struct platform_pwm_backlight_data treo_backlight_data = {
 	.pwm_id		= 0,
-	.max_brightness	= TREO680_MAX_INTENSITY,
-	.dft_brightness	= TREO680_DEFAULT_INTENSITY,
-	.pwm_period_ns	= TREO680_PERIOD_NS,
-	.init		= treo680_backlight_init,
-	.notify		= treo680_backlight_notify,
-	.exit		= treo680_backlight_exit,
+	.max_brightness	= TREO_MAX_INTENSITY,
+	.dft_brightness	= TREO_DEFAULT_INTENSITY,
+	.pwm_period_ns	= TREO_PERIOD_NS,
+	.init		= treo_backlight_init,
+	.notify		= treo_backlight_notify,
+	.exit		= treo_backlight_exit,
 };
 
-static struct platform_device treo680_backlight = {
+static struct platform_device treo_backlight = {
 	.name	= "pwm-backlight",
 	.dev	= {
 		.parent		= &pxa27x_device_pwm0.dev,
-		.platform_data	= &treo680_backlight_data,
+		.platform_data	= &treo_backlight_data,
 	},
 };
 
 /******************************************************************************
  * IrDA
  ******************************************************************************/
-static struct pxaficp_platform_data treo680_ficp_info = {
-	.gpio_pwdown		= GPIO_NR_TREO680_IR_EN,
+static struct pxaficp_platform_data treo_ficp_info = {
+	.gpio_pwdown		= GPIO_NR_TREO_IR_EN,
 	.transceiver_cap	= IR_SIRMODE | IR_OFF,
 };
 
 /******************************************************************************
  * UDC
  ******************************************************************************/
-static struct pxa2xx_udc_mach_info treo680_udc_info __initdata = {
-	.gpio_vbus		= GPIO_NR_TREO680_USB_DETECT,
+static struct pxa2xx_udc_mach_info treo_udc_info __initdata = {
+	.gpio_vbus		= GPIO_NR_TREO_USB_DETECT,
 	.gpio_vbus_inverted	= 1,
-	.gpio_pullup		= GPIO_NR_TREO680_USB_PULLUP,
+	.gpio_pullup		= GPIO_NR_TREO_USB_PULLUP,
 };
 
 
 /******************************************************************************
  * USB host
  ******************************************************************************/
+#ifdef CONFIG_MACH_TREO680
 static struct pxaohci_platform_data treo680_ohci_info = {
 	.port_mode    = PMM_PERPORT_MODE,
 	.flags        = ENABLE_PORT1 | ENABLE_PORT3,
 	.power_budget = 0,
 };
+#endif /* CONFIG_MACH_TREO680 */
 
 /******************************************************************************
  * Power supply
@@ -326,41 +342,41 @@ static int power_supply_init(struct device *dev)
 {
 	int ret;
 
-	ret = gpio_request(GPIO_NR_TREO680_POWER_DETECT, "CABLE_STATE_AC");
+	ret = gpio_request(GPIO_NR_TREO_POWER_DETECT, "CABLE_STATE_AC");
 	if (ret)
 		goto err1;
-	ret = gpio_direction_input(GPIO_NR_TREO680_POWER_DETECT);
+	ret = gpio_direction_input(GPIO_NR_TREO_POWER_DETECT);
 	if (ret)
 		goto err2;
 
 	return 0;
 
 err2:
-	gpio_free(GPIO_NR_TREO680_POWER_DETECT);
+	gpio_free(GPIO_NR_TREO_POWER_DETECT);
 err1:
 	return ret;
 }
 
-static int treo680_is_ac_online(void)
+static int treo_is_ac_online(void)
 {
-	return gpio_get_value(GPIO_NR_TREO680_POWER_DETECT);
+	return gpio_get_value(GPIO_NR_TREO_POWER_DETECT);
 }
 
 static void power_supply_exit(struct device *dev)
 {
-	gpio_free(GPIO_NR_TREO680_POWER_DETECT);
+	gpio_free(GPIO_NR_TREO_POWER_DETECT);
 }
 
-static char *treo680_supplicants[] = {
+static char *treo_supplicants[] = {
 	"main-battery",
 };
 
 static struct pda_power_pdata power_supply_info = {
 	.init		 = power_supply_init,
-	.is_ac_online    = treo680_is_ac_online,
+	.is_ac_online    = treo_is_ac_online,
 	.exit		 = power_supply_exit,
-	.supplied_to     = treo680_supplicants,
-	.num_supplicants = ARRAY_SIZE(treo680_supplicants),
+	.supplied_to     = treo_supplicants,
+	.num_supplicants = ARRAY_SIZE(treo_supplicants),
 };
 
 static struct platform_device power_supply = {
@@ -374,7 +390,8 @@ static struct platform_device power_supply = {
 /******************************************************************************
  * Vibra and LEDs
  ******************************************************************************/
-static struct gpio_led gpio_leds[] = {
+#ifdef CONFIG_MACH_TREO680
+static struct gpio_led treo680_gpio_leds[] = {
 	{
 		.name			= "treo680:vibra:vibra",
 		.default_trigger	= "none",
@@ -383,34 +400,34 @@ static struct gpio_led gpio_leds[] = {
 	{
 		.name			= "treo680:green:led",
 		.default_trigger	= "mmc0",
-		.gpio			= GPIO_NR_TREO680_GREEN_LED,
+		.gpio			= GPIO_NR_TREO_GREEN_LED,
 	},
 	{
-		.name			= "treo680:keybbl:keybbl",
+		.name			= "treo680:white:keybbl",
 		.default_trigger	= "none",
 		.gpio			= GPIO_NR_TREO680_KEYB_BL,
 	},
 };
 
-static struct gpio_led_platform_data gpio_led_info = {
-	.leds		= gpio_leds,
-	.num_leds	= ARRAY_SIZE(gpio_leds),
+static struct gpio_led_platform_data treo680_gpio_led_info = {
+	.leds		= treo680_gpio_leds,
+	.num_leds	= ARRAY_SIZE(treo680_gpio_leds),
 };
 
 static struct platform_device treo680_leds = {
 	.name   = "leds-gpio",
 	.id     = -1,
 	.dev    = {
-		.platform_data  = &gpio_led_info,
+		.platform_data  = &treo680_gpio_led_info,
 	}
 };
-
+#endif /* CONFIG_MACH_TREO680 */
 
 /******************************************************************************
  * Framebuffer
  ******************************************************************************/
 /* TODO: add support for 324x324 */
-static struct pxafb_mode_info treo680_lcd_modes[] = {
+static struct pxafb_mode_info treo_lcd_modes[] = {
 {
 	.pixclock		= 86538,
 	.xres			= 320,
@@ -427,21 +444,21 @@ static struct pxafb_mode_info treo680_lcd_modes[] = {
 },
 };
 
-static void treo680_lcd_power(int on, struct fb_var_screeninfo *info)
+static void treo_lcd_power(int on, struct fb_var_screeninfo *info)
 {
-	gpio_set_value(GPIO_NR_TREO680_BL_POWER, on);
+	gpio_set_value(GPIO_NR_TREO_BL_POWER, on);
 }
 
-static struct pxafb_mach_info treo680_lcd_screen = {
-	.modes		= treo680_lcd_modes,
-	.num_modes	= ARRAY_SIZE(treo680_lcd_modes),
+static struct pxafb_mach_info treo_lcd_screen = {
+	.modes		= treo_lcd_modes,
+	.num_modes	= ARRAY_SIZE(treo_lcd_modes),
 	.lcd_conn	= LCD_COLOR_TFT_16BPP | LCD_PCLK_EDGE_FALL,
 };
 
 /******************************************************************************
  * Power management - standby
  ******************************************************************************/
-static void __init treo680_pm_init(void)
+static void __init treo_pm_init(void)
 {
 	static u32 resume[] = {
 		0xe3a00101,	/* mov	r0,	#0x40000000 */
@@ -450,70 +467,85 @@ static void __init treo680_pm_init(void)
 	};
 
 	/* this is where the bootloader jumps */
-	memcpy(phys_to_virt(TREO680_STR_BASE), resume, sizeof(resume));
+	memcpy(phys_to_virt(TREO_STR_BASE), resume, sizeof(resume));
 }
 
 /******************************************************************************
  * Machine init
  ******************************************************************************/
-static struct platform_device *devices[] __initdata = {
-	&treo680_backlight,
-	&treo680_leds,
+static struct platform_device *treo_devices[] __initdata = {
+	&treo_backlight,
 	&power_supply,
 };
 
+#ifdef CONFIG_MACH_TREO680
+static struct platform_device *treo680_devices[] __initdata = {
+	&treo680_leds,
+};
+#endif /* CONFIG_MACH_TREO680 */
+
 /* setup udc GPIOs initial state */
-static void __init treo680_udc_init(void)
+static void __init treo_udc_init(void)
 {
-	if (!gpio_request(GPIO_NR_TREO680_USB_PULLUP, "UDC Vbus")) {
-		gpio_direction_output(GPIO_NR_TREO680_USB_PULLUP, 1);
-		gpio_free(GPIO_NR_TREO680_USB_PULLUP);
+	if (!gpio_request(GPIO_NR_TREO_USB_PULLUP, "UDC Vbus")) {
+		gpio_direction_output(GPIO_NR_TREO_USB_PULLUP, 1);
+		gpio_free(GPIO_NR_TREO_USB_PULLUP);
 	}
 }
 
-static void __init treo680_lcd_power_init(void)
+static void __init treo_lcd_power_init(void)
 {
 	int ret;
 
-	ret = gpio_request(GPIO_NR_TREO680_LCD_POWER, "LCD POWER");
+	ret = gpio_request(GPIO_NR_TREO_LCD_POWER, "LCD POWER");
 	if (ret) {
 		pr_err("Treo680: LCD power GPIO request failed!\n");
 		return;
 	}
 
-	ret = gpio_direction_output(GPIO_NR_TREO680_LCD_POWER, 0);
+	ret = gpio_direction_output(GPIO_NR_TREO_LCD_POWER, 0);
 	if (ret) {
 		pr_err("Treo680: setting LCD power GPIO direction failed!\n");
-		gpio_free(GPIO_NR_TREO680_LCD_POWER);
+		gpio_free(GPIO_NR_TREO_LCD_POWER);
 		return;
 	}
 
-	treo680_lcd_screen.pxafb_lcd_power = treo680_lcd_power;
+	treo_lcd_screen.pxafb_lcd_power = treo_lcd_power;
 }
 
+static void __init treo_init(void)
+{
+	treo_pm_init();
+	pxa2xx_mfp_config(ARRAY_AND_SIZE(treo_pin_config));
+	treo_lcd_power_init();
+	set_pxa_fb_info(&treo_lcd_screen);
+	treo_udc_init();
+	pxa_set_udc_info(&treo_udc_info);
+	pxa_set_ac97_info(&treo_ac97_pdata);
+	pxa_set_ficp_info(&treo_ficp_info);
+
+	platform_add_devices(ARRAY_AND_SIZE(treo_devices));
+}
+
+#ifdef CONFIG_MACH_TREO680
 static void __init treo680_init(void)
 {
-	treo680_pm_init();
+	treo_init();
 	pxa2xx_mfp_config(ARRAY_AND_SIZE(treo680_pin_config));
-	pxa_set_keypad_info(&treo680_keypad_platform_data);
-	treo680_lcd_power_init();
-	set_pxa_fb_info(&treo680_lcd_screen);
 	pxa_set_mci_info(&treo680_mci_platform_data);
-	treo680_udc_init();
-	pxa_set_udc_info(&treo680_udc_info);
-	pxa_set_ac97_info(&treo680_ac97_pdata);
-	pxa_set_ficp_info(&treo680_ficp_info);
+	pxa_set_keypad_info(&treo680_keypad_platform_data);
 	pxa_set_ohci_info(&treo680_ohci_info);
 
-	platform_add_devices(devices, ARRAY_SIZE(devices));
+	platform_add_devices(ARRAY_AND_SIZE(treo680_devices));
 }
 
 MACHINE_START(TREO680, "Palm Treo 680")
-	.phys_io	= TREO680_PHYS_IO_START,
-	.io_pg_offst	= io_p2v(0x40000000),
-	.boot_params	= 0xa0000100,
-	.map_io		= pxa_map_io,
-	.init_irq	= pxa27x_init_irq,
-	.timer		= &pxa_timer,
-	.init_machine	= treo680_init,
+	.phys_io        = TREO_PHYS_IO_START,
+	.io_pg_offst    = io_p2v(0x40000000),
+	.boot_params    = 0xa0000100,
+	.map_io         = pxa_map_io,
+	.init_irq       = pxa27x_init_irq,
+	.timer          = &pxa_timer,
+	.init_machine   = treo680_init,
 MACHINE_END
+#endif /* CONFIG_MACH_TREO680 */
-- 
1.6.4.2
