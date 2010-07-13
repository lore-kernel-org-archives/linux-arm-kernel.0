From: marek.vasut@gmail.com (Marek Vasut)
Date: Tue, 13 Jul 2010 09:38:51 +0200
Subject: [PATCH 3/5] pxa: Flip Palm LD, TX, T5, Z72 to Palm27x
In-Reply-To: <1279006733-17731-1-git-send-email-marek.vasut@gmail.com>
References: <1279006733-17731-1-git-send-email-marek.vasut@gmail.com>
Message-ID: <1279006733-17731-3-git-send-email-marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
---
 arch/arm/mach-pxa/Kconfig    |    4 +
 arch/arm/mach-pxa/palmld.c   |  257 +++----------------------------------
 arch/arm/mach-pxa/palmt5.c   |  274 +++------------------------------------
 arch/arm/mach-pxa/palmtreo.c |  292 +++++-------------------------------------
 arch/arm/mach-pxa/palmtx.c   |  269 +++------------------------------------
 arch/arm/mach-pxa/palmz72.c  |  260 ++-----------------------------------
 6 files changed, 105 insertions(+), 1251 deletions(-)

diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
index f3eaade..cdefc45 100644
--- a/arch/arm/mach-pxa/Kconfig
+++ b/arch/arm/mach-pxa/Kconfig
@@ -374,6 +374,7 @@ config MACH_PALMT5
 	depends on ARCH_PXA_PALM
 	select PXA27x
 	select IWMMXT
+	select MACH_PALM27X
 	help
 	  Say Y here if you intend to run this kernel on a Palm Tungsten|T5
 	  handheld computer.
@@ -384,6 +385,7 @@ config MACH_PALMTX
 	depends on ARCH_PXA_PALM
 	select PXA27x
 	select IWMMXT
+	select MACH_PALM27X
 	help
 	  Say Y here if you intend to run this kernel on a Palm T|X
 	  handheld computer.
@@ -394,6 +396,7 @@ config MACH_PALMZ72
 	depends on ARCH_PXA_PALM
 	select PXA27x
 	select IWMMXT
+	select MACH_PALM27X
 	help
 	  Say Y here if you intend to run this kernel on Palm Zire 72
 	  handheld computer.
@@ -404,6 +407,7 @@ config MACH_PALMLD
 	depends on ARCH_PXA_PALM
 	select PXA27x
 	select IWMMXT
+	select MACH_PALM27X
 	help
 	  Say Y here if you intend to run this kernel on a Palm LifeDrive
 	  handheld computer.
diff --git a/arch/arm/mach-pxa/palmld.c b/arch/arm/mach-pxa/palmld.c
index bec35e2..166d735 100644
--- a/arch/arm/mach-pxa/palmld.c
+++ b/arch/arm/mach-pxa/palmld.c
@@ -41,6 +41,7 @@
 #include <mach/irda.h>
 #include <mach/pxa27x_keypad.h>
 #include <mach/palmasoc.h>
+#include <mach/palm27x.h>
 
 #include "generic.h"
 #include "devices.h"
@@ -161,17 +162,6 @@ static struct platform_device palmld_flash = {
 };
 
 /******************************************************************************
- * SD/MMC card controller
- ******************************************************************************/
-static struct pxamci_platform_data palmld_mci_platform_data = {
-	.ocr_mask		= MMC_VDD_32_33 | MMC_VDD_33_34,
-	.gpio_card_detect	= GPIO14_PALMLD_SD_DETECT_N,
-	.gpio_card_ro		= GPIO116_PALMLD_SD_READONLY,
-	.gpio_power		= GPIO114_PALMLD_SD_POWER,
-	.detect_delay_ms	= 200,
-};
-
-/******************************************************************************
  * GPIO keyboard
  ******************************************************************************/
 static unsigned int palmld_matrix_keys[] = {
@@ -223,74 +213,6 @@ static struct platform_device palmld_pxa_keys = {
 };
 
 /******************************************************************************
- * Backlight
- ******************************************************************************/
-static int palmld_backlight_init(struct device *dev)
-{
-	int ret;
-
-	ret = gpio_request(GPIO19_PALMLD_BL_POWER, "BL POWER");
-	if (ret)
-		goto err;
-	ret = gpio_direction_output(GPIO19_PALMLD_BL_POWER, 0);
-	if (ret)
-		goto err2;
-	ret = gpio_request(GPIO96_PALMLD_LCD_POWER, "LCD POWER");
-	if (ret)
-		goto err2;
-	ret = gpio_direction_output(GPIO96_PALMLD_LCD_POWER, 0);
-	if (ret)
-		goto err3;
-
-	return 0;
-err3:
-	gpio_free(GPIO96_PALMLD_LCD_POWER);
-err2:
-	gpio_free(GPIO19_PALMLD_BL_POWER);
-err:
-	return ret;
-}
-
-static int palmld_backlight_notify(struct device *dev, int brightness)
-{
-	gpio_set_value(GPIO19_PALMLD_BL_POWER, brightness);
-	gpio_set_value(GPIO96_PALMLD_LCD_POWER, brightness);
-	return brightness;
-}
-
-static void palmld_backlight_exit(struct device *dev)
-{
-	gpio_free(GPIO19_PALMLD_BL_POWER);
-	gpio_free(GPIO96_PALMLD_LCD_POWER);
-}
-
-static struct platform_pwm_backlight_data palmld_backlight_data = {
-	.pwm_id		= 0,
-	.max_brightness	= PALMLD_MAX_INTENSITY,
-	.dft_brightness	= PALMLD_MAX_INTENSITY,
-	.pwm_period_ns	= PALMLD_PERIOD_NS,
-	.init		= palmld_backlight_init,
-	.notify		= palmld_backlight_notify,
-	.exit		= palmld_backlight_exit,
-};
-
-static struct platform_device palmld_backlight = {
-	.name	= "pwm-backlight",
-	.dev	= {
-		.parent		= &pxa27x_device_pwm0.dev,
-		.platform_data	= &palmld_backlight_data,
-	},
-};
-
-/******************************************************************************
- * IrDA
- ******************************************************************************/
-static struct pxaficp_platform_data palmld_ficp_platform_data = {
-	.gpio_pwdown		= GPIO108_PALMLD_IR_DISABLE,
-	.transceiver_cap	= IR_SIRMODE | IR_OFF,
-};
-
-/******************************************************************************
  * LEDs
  ******************************************************************************/
 struct gpio_led gpio_leds[] = {
@@ -319,112 +241,6 @@ static struct platform_device palmld_leds = {
 };
 
 /******************************************************************************
- * Power supply
- ******************************************************************************/
-static int power_supply_init(struct device *dev)
-{
-	int ret;
-
-	ret = gpio_request(GPIO4_PALMLD_POWER_DETECT, "CABLE_STATE_AC");
-	if (ret)
-		goto err1;
-	ret = gpio_direction_input(GPIO4_PALMLD_POWER_DETECT);
-	if (ret)
-		goto err2;
-
-	ret = gpio_request(GPIO3_PALMLD_USB_DETECT_N, "CABLE_STATE_USB");
-	if (ret)
-		goto err2;
-	ret = gpio_direction_input(GPIO3_PALMLD_USB_DETECT_N);
-	if (ret)
-		goto err3;
-
-	return 0;
-
-err3:
-	gpio_free(GPIO3_PALMLD_USB_DETECT_N);
-err2:
-	gpio_free(GPIO4_PALMLD_POWER_DETECT);
-err1:
-	return ret;
-}
-
-static int palmld_is_ac_online(void)
-{
-	return gpio_get_value(GPIO4_PALMLD_POWER_DETECT);
-}
-
-static int palmld_is_usb_online(void)
-{
-	return !gpio_get_value(GPIO3_PALMLD_USB_DETECT_N);
-}
-
-static void power_supply_exit(struct device *dev)
-{
-	gpio_free(GPIO3_PALMLD_USB_DETECT_N);
-	gpio_free(GPIO4_PALMLD_POWER_DETECT);
-}
-
-static char *palmld_supplicants[] = {
-	"main-battery",
-};
-
-static struct pda_power_pdata power_supply_info = {
-	.init            = power_supply_init,
-	.is_ac_online    = palmld_is_ac_online,
-	.is_usb_online   = palmld_is_usb_online,
-	.exit            = power_supply_exit,
-	.supplied_to     = palmld_supplicants,
-	.num_supplicants = ARRAY_SIZE(palmld_supplicants),
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
- * WM97xx audio, battery
- ******************************************************************************/
-static struct wm97xx_batt_pdata palmld_batt_pdata = {
-	.batt_aux	= WM97XX_AUX_ID3,
-	.temp_aux	= WM97XX_AUX_ID2,
-	.charge_gpio	= -1,
-	.max_voltage	= PALMLD_BAT_MAX_VOLTAGE,
-	.min_voltage	= PALMLD_BAT_MIN_VOLTAGE,
-	.batt_mult	= 1000,
-	.batt_div	= 414,
-	.temp_mult	= 1,
-	.temp_div	= 1,
-	.batt_tech	= POWER_SUPPLY_TECHNOLOGY_LIPO,
-	.batt_name	= "main-batt",
-};
-
-static struct wm97xx_pdata palmld_wm97xx_pdata = {
-	.batt_pdata	= &palmld_batt_pdata,
-};
-
-static pxa2xx_audio_ops_t palmld_ac97_pdata = {
-	.reset_gpio	= 95,
-	.codec_pdata	= { &palmld_wm97xx_pdata, },
-};
-
-static struct palm27x_asoc_info palmld_asoc_pdata = {
-	.jack_gpio	= GPIO13_PALMLD_EARPHONE_DETECT,
-};
-
-static struct platform_device palmld_asoc = {
-	.name = "palm27x-asoc",
-	.id   = -1,
-	.dev  = {
-		.platform_data = &palmld_asoc_pdata,
-	},
-};
-
-/******************************************************************************
  * HDD
  ******************************************************************************/
 static struct platform_device palmld_hdd = {
@@ -433,57 +249,13 @@ static struct platform_device palmld_hdd = {
 };
 
 /******************************************************************************
- * Framebuffer
- ******************************************************************************/
-static struct pxafb_mode_info palmld_lcd_modes[] = {
-{
-	.pixclock	= 57692,
-	.xres		= 320,
-	.yres		= 480,
-	.bpp		= 16,
-
-	.left_margin	= 32,
-	.right_margin	= 1,
-	.upper_margin	= 7,
-	.lower_margin	= 1,
-
-	.hsync_len	= 4,
-	.vsync_len	= 1,
-},
-};
-
-static struct pxafb_mach_info palmld_lcd_screen = {
-	.modes		= palmld_lcd_modes,
-	.num_modes	= ARRAY_SIZE(palmld_lcd_modes),
-	.lcd_conn	= LCD_COLOR_TFT_16BPP | LCD_PCLK_EDGE_FALL,
-};
-
-/******************************************************************************
- * Power management - standby
- ******************************************************************************/
-static void __init palmld_pm_init(void)
-{
-	static u32 resume[] = {
-		0xe3a00101,	/* mov	r0,	#0x40000000 */
-		0xe380060f,	/* orr	r0, r0, #0x00f00000 */
-		0xe590f008,	/* ldr	pc, [r0, #0x08] */
-	};
-
-	/* copy the bootloader */
-	memcpy(phys_to_virt(PALMLD_STR_BASE), resume, sizeof(resume));
-}
-
-/******************************************************************************
  * Machine init
  ******************************************************************************/
 static struct platform_device *devices[] __initdata = {
 #if defined(CONFIG_KEYBOARD_GPIO) || defined(CONFIG_KEYBOARD_GPIO_MODULE)
 	&palmld_pxa_keys,
 #endif
-	&palmld_backlight,
 	&palmld_leds,
-	&power_supply,
-	&palmld_asoc,
 	&palmld_hdd,
 	&palmld_flash,
 };
@@ -509,21 +281,26 @@ static void __init palmld_map_io(void)
 	iotable_init(palmld_io_desc, ARRAY_SIZE(palmld_io_desc));
 }
 
+struct palm27x_handheld palmld = {
+	.mmc_detect	= GPIO14_PALMLD_SD_DETECT_N,
+	.mmc_ro		= GPIO116_PALMLD_SD_READONLY,
+	.mmc_power	= GPIO114_PALMLD_SD_POWER,
+	.pm_str_base	= PALMLD_STR_BASE,
+	.irda_pwdn	= GPIO108_PALMLD_IR_DISABLE,
+	.batt_minv	= PALMLD_BAT_MIN_VOLTAGE,
+	.batt_maxv	= PALMLD_BAT_MAX_VOLTAGE,
+	.jack_gpio	= GPIO13_PALMLD_EARPHONE_DETECT,
+	.bl_bl		= GPIO19_PALMLD_BL_POWER,
+	.bl_lcd		= GPIO96_PALMLD_LCD_POWER,
+	.power_ac	= GPIO4_PALMLD_POWER_DETECT,
+	.power_usb	= GPIO3_PALMLD_USB_DETECT_N,
+};
+
 static void __init palmld_init(void)
 {
 	pxa2xx_mfp_config(ARRAY_AND_SIZE(palmld_pin_config));
-
-	pxa_set_ffuart_info(NULL);
-	pxa_set_btuart_info(NULL);
-	pxa_set_stuart_info(NULL);
-
-	palmld_pm_init();
-	set_pxa_fb_info(&palmld_lcd_screen);
-	pxa_set_mci_info(&palmld_mci_platform_data);
-	pxa_set_ac97_info(&palmld_ac97_pdata);
-	pxa_set_ficp_info(&palmld_ficp_platform_data);
+	palm27x_common_init(&palmld);
 	pxa_set_keypad_info(&palmld_keypad_platform_data);
-
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 }
 
diff --git a/arch/arm/mach-pxa/palmt5.c b/arch/arm/mach-pxa/palmt5.c
index 8037cfc..26925fc 100644
--- a/arch/arm/mach-pxa/palmt5.c
+++ b/arch/arm/mach-pxa/palmt5.c
@@ -41,6 +41,7 @@
 #include <mach/pxa27x_keypad.h>
 #include <mach/udc.h>
 #include <mach/palmasoc.h>
+#include <mach/palm27x.h>
 
 #include "generic.h"
 #include "devices.h"
@@ -103,17 +104,6 @@ static unsigned long palmt5_pin_config[] __initdata = {
 };
 
 /******************************************************************************
- * SD/MMC card controller
- ******************************************************************************/
-static struct pxamci_platform_data palmt5_mci_platform_data = {
-	.ocr_mask		= MMC_VDD_32_33 | MMC_VDD_33_34,
-	.gpio_card_detect	= GPIO14_PALMT5_SD_DETECT_N,
-	.gpio_card_ro		= GPIO115_PALMT5_SD_READONLY,
-	.gpio_power		= GPIO114_PALMT5_SD_POWER,
-	.detect_delay_ms	= 200,
-};
-
-/******************************************************************************
  * GPIO keyboard
  ******************************************************************************/
 static unsigned int palmt5_matrix_keys[] = {
@@ -162,259 +152,31 @@ static struct platform_device palmt5_pxa_keys = {
 };
 
 /******************************************************************************
- * Backlight
- ******************************************************************************/
-static int palmt5_backlight_init(struct device *dev)
-{
-	int ret;
-
-	ret = gpio_request(GPIO84_PALMT5_BL_POWER, "BL POWER");
-	if (ret)
-		goto err;
-	ret = gpio_direction_output(GPIO84_PALMT5_BL_POWER, 0);
-	if (ret)
-		goto err2;
-	ret = gpio_request(GPIO96_PALMT5_LCD_POWER, "LCD POWER");
-	if (ret)
-		goto err2;
-	ret = gpio_direction_output(GPIO96_PALMT5_LCD_POWER, 0);
-	if (ret)
-		goto err3;
-
-	return 0;
-err3:
-	gpio_free(GPIO96_PALMT5_LCD_POWER);
-err2:
-	gpio_free(GPIO84_PALMT5_BL_POWER);
-err:
-	return ret;
-}
-
-static int palmt5_backlight_notify(struct device *dev, int brightness)
-{
-	gpio_set_value(GPIO84_PALMT5_BL_POWER, brightness);
-	gpio_set_value(GPIO96_PALMT5_LCD_POWER, brightness);
-	return brightness;
-}
-
-static void palmt5_backlight_exit(struct device *dev)
-{
-	gpio_free(GPIO84_PALMT5_BL_POWER);
-	gpio_free(GPIO96_PALMT5_LCD_POWER);
-}
-
-static struct platform_pwm_backlight_data palmt5_backlight_data = {
-	.pwm_id		= 0,
-	.max_brightness	= PALMT5_MAX_INTENSITY,
-	.dft_brightness	= PALMT5_MAX_INTENSITY,
-	.pwm_period_ns	= PALMT5_PERIOD_NS,
-	.init		= palmt5_backlight_init,
-	.notify		= palmt5_backlight_notify,
-	.exit		= palmt5_backlight_exit,
-};
-
-static struct platform_device palmt5_backlight = {
-	.name	= "pwm-backlight",
-	.dev	= {
-		.parent		= &pxa27x_device_pwm0.dev,
-		.platform_data	= &palmt5_backlight_data,
-	},
-};
-
-/******************************************************************************
- * IrDA
- ******************************************************************************/
-static struct pxaficp_platform_data palmt5_ficp_platform_data = {
-	.gpio_pwdown		= GPIO40_PALMT5_IR_DISABLE,
-	.transceiver_cap	= IR_SIRMODE | IR_OFF,
-};
-
-/******************************************************************************
- * UDC
- ******************************************************************************/
-static struct gpio_vbus_mach_info palmt5_udc_info = {
-	.gpio_vbus		= GPIO15_PALMT5_USB_DETECT_N,
-	.gpio_vbus_inverted	= 1,
-	.gpio_pullup		= GPIO93_PALMT5_USB_PULLUP,
-};
-
-static struct platform_device palmt5_gpio_vbus = {
-	.name	= "gpio-vbus",
-	.id	= -1,
-	.dev	= {
-		.platform_data	= &palmt5_udc_info,
-	},
-};
-
-/******************************************************************************
- * Power supply
- ******************************************************************************/
-static int power_supply_init(struct device *dev)
-{
-	int ret;
-
-	ret = gpio_request(GPIO90_PALMT5_POWER_DETECT, "CABLE_STATE_AC");
-	if (ret)
-		goto err1;
-	ret = gpio_direction_input(GPIO90_PALMT5_POWER_DETECT);
-	if (ret)
-		goto err2;
-
-	return 0;
-err2:
-	gpio_free(GPIO90_PALMT5_POWER_DETECT);
-err1:
-	return ret;
-}
-
-static int palmt5_is_ac_online(void)
-{
-	return gpio_get_value(GPIO90_PALMT5_POWER_DETECT);
-}
-
-static void power_supply_exit(struct device *dev)
-{
-	gpio_free(GPIO90_PALMT5_POWER_DETECT);
-}
-
-static char *palmt5_supplicants[] = {
-	"main-battery",
-};
-
-static struct pda_power_pdata power_supply_info = {
-	.init            = power_supply_init,
-	.is_ac_online    = palmt5_is_ac_online,
-	.exit            = power_supply_exit,
-	.supplied_to     = palmt5_supplicants,
-	.num_supplicants = ARRAY_SIZE(palmt5_supplicants),
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
- * WM97xx audio, battery
- ******************************************************************************/
-static struct wm97xx_batt_pdata palmt5_batt_pdata = {
-	.batt_aux	= WM97XX_AUX_ID3,
-	.temp_aux	= WM97XX_AUX_ID2,
-	.charge_gpio	= -1,
-	.max_voltage	= PALMT5_BAT_MAX_VOLTAGE,
-	.min_voltage	= PALMT5_BAT_MIN_VOLTAGE,
-	.batt_mult	= 1000,
-	.batt_div	= 414,
-	.temp_mult	= 1,
-	.temp_div	= 1,
-	.batt_tech	= POWER_SUPPLY_TECHNOLOGY_LIPO,
-	.batt_name	= "main-batt",
-};
-
-static struct wm97xx_pdata palmt5_wm97xx_pdata = {
-	.batt_pdata	= &palmt5_batt_pdata,
-};
-
-static pxa2xx_audio_ops_t palmt5_ac97_pdata = {
-	.reset_gpio	= 95,
-	.codec_pdata	= { &palmt5_wm97xx_pdata, },
-};
-
-static struct palm27x_asoc_info palmt5_asoc_pdata = {
-	.jack_gpio	= GPIO107_PALMT5_EARPHONE_DETECT,
-};
-
-static struct platform_device palmt5_asoc = {
-	.name = "palm27x-asoc",
-	.id   = -1,
-	.dev  = {
-		.platform_data = &palmt5_asoc_pdata,
-	},
-};
-
-/******************************************************************************
- * Framebuffer
- ******************************************************************************/
-static struct pxafb_mode_info palmt5_lcd_modes[] = {
-{
-	.pixclock	= 57692,
-	.xres		= 320,
-	.yres		= 480,
-	.bpp		= 16,
-
-	.left_margin	= 32,
-	.right_margin	= 1,
-	.upper_margin	= 7,
-	.lower_margin	= 1,
-
-	.hsync_len	= 4,
-	.vsync_len	= 1,
-},
-};
-
-static struct pxafb_mach_info palmt5_lcd_screen = {
-	.modes		= palmt5_lcd_modes,
-	.num_modes	= ARRAY_SIZE(palmt5_lcd_modes),
-	.lcd_conn	= LCD_COLOR_TFT_16BPP | LCD_PCLK_EDGE_FALL,
-};
-
-/******************************************************************************
- * Power management - standby
- ******************************************************************************/
-static void __init palmt5_pm_init(void)
-{
-	static u32 resume[] = {
-		0xe3a00101,	/* mov	r0,	#0x40000000 */
-		0xe380060f,	/* orr	r0, r0, #0x00f00000 */
-		0xe590f008,	/* ldr	pc, [r0, #0x08] */
-	};
-
-	/* copy the bootloader */
-	memcpy(phys_to_virt(PALMT5_STR_BASE), resume, sizeof(resume));
-}
-
-/******************************************************************************
  * Machine init
  ******************************************************************************/
-static struct platform_device *devices[] __initdata = {
-#if defined(CONFIG_KEYBOARD_GPIO) || defined(CONFIG_KEYBOARD_GPIO_MODULE)
-	&palmt5_pxa_keys,
-#endif
-	&palmt5_backlight,
-	&power_supply,
-	&palmt5_asoc,
-	&palmt5_gpio_vbus,
+struct palm27x_handheld palmt5 = {
+	.mmc_detect	= GPIO14_PALMT5_SD_DETECT_N,
+	.mmc_ro		= GPIO115_PALMT5_SD_READONLY,
+	.mmc_power	= GPIO114_PALMT5_SD_POWER,
+	.pm_str_base	= PALMT5_STR_BASE,
+	.udc_detect	= GPIO15_PALMT5_USB_DETECT_N,
+	.udc_pullup	= GPIO93_PALMT5_USB_PULLUP,
+	.irda_pwdn	= GPIO40_PALMT5_IR_DISABLE,
+	.batt_minv	= PALMT5_BAT_MIN_VOLTAGE,
+	.batt_maxv	= PALMT5_BAT_MAX_VOLTAGE,
+	.jack_gpio	= GPIO107_PALMT5_EARPHONE_DETECT,
+	.bl_bl		= GPIO84_PALMT5_BL_POWER,
+	.bl_lcd		= GPIO96_PALMT5_LCD_POWER,
+	.power_ac	= GPIO90_PALMT5_POWER_DETECT,
+	.power_usb	= -1,
 };
 
-/* setup udc GPIOs initial state */
-static void __init palmt5_udc_init(void)
-{
-	if (!gpio_request(GPIO93_PALMT5_USB_PULLUP, "UDC Vbus")) {
-		gpio_direction_output(GPIO93_PALMT5_USB_PULLUP, 1);
-		gpio_free(GPIO93_PALMT5_USB_PULLUP);
-	}
-}
-
 static void __init palmt5_init(void)
 {
 	pxa2xx_mfp_config(ARRAY_AND_SIZE(palmt5_pin_config));
-
-	pxa_set_ffuart_info(NULL);
-	pxa_set_btuart_info(NULL);
-	pxa_set_stuart_info(NULL);
-
-	palmt5_pm_init();
-	set_pxa_fb_info(&palmt5_lcd_screen);
-	pxa_set_mci_info(&palmt5_mci_platform_data);
-	palmt5_udc_init();
-	pxa_set_ac97_info(&palmt5_ac97_pdata);
-	pxa_set_ficp_info(&palmt5_ficp_platform_data);
+	palm27x_common_init(&palmt5);
 	pxa_set_keypad_info(&palmt5_keypad_platform_data);
-
-	platform_add_devices(devices, ARRAY_SIZE(devices));
+	platform_device_register(&palmt5_pxa_keys);
 }
 
 MACHINE_START(PALMT5, "Palm Tungsten|T5")
diff --git a/arch/arm/mach-pxa/palmtreo.c b/arch/arm/mach-pxa/palmtreo.c
index 4eb0258..dcb5f93 100644
--- a/arch/arm/mach-pxa/palmtreo.c
+++ b/arch/arm/mach-pxa/palmtreo.c
@@ -44,6 +44,7 @@
 #include <mach/pxa2xx-regs.h>
 #include <mach/palmasoc.h>
 #include <mach/camera.h>
+#include <mach/palm27x.h>
 
 #include <sound/pxa2xx-lib.h>
 
@@ -158,28 +159,6 @@ static unsigned long centro685_pin_config[] __initdata = {
 #endif /* CONFIG_MACH_CENTRO */
 
 /******************************************************************************
- * SD/MMC card controller
- ******************************************************************************/
-#ifdef CONFIG_MACH_TREO680
-static struct pxamci_platform_data treo680_mci_platform_data = {
-	.ocr_mask		= MMC_VDD_32_33 | MMC_VDD_33_34,
-	.gpio_card_detect	= GPIO_NR_TREO_SD_DETECT_N,
-	.gpio_card_ro		= GPIO_NR_TREO680_SD_READONLY,
-	.gpio_power		= GPIO_NR_TREO680_SD_POWER,
-};
-#endif /* CONFIG_MACH_TREO680 */
-
-#ifdef CONFIG_MACH_CENTRO
-static struct pxamci_platform_data centro_mci_platform_data = {
-	.ocr_mask		= MMC_VDD_32_33 | MMC_VDD_33_34,
-	.gpio_card_detect	= GPIO_NR_TREO_SD_DETECT_N,
-	.gpio_card_ro		= -1,
-	.gpio_power		= GPIO_NR_CENTRO_SD_POWER,
-	.gpio_power_invert	= 1,
-};
-#endif /* CONFIG_MACH_CENTRO */
-
-/******************************************************************************
  * GPIO keyboard
  ******************************************************************************/
 #ifdef CONFIG_MACH_TREO680
@@ -327,83 +306,6 @@ static struct pxa27x_keypad_platform_data centro_keypad_platform_data = {
 #endif /* CONFIG_MACH_CENTRO */
 
 /******************************************************************************
- * aSoC audio
- ******************************************************************************/
-
-static pxa2xx_audio_ops_t treo_ac97_pdata = {
-	.reset_gpio	= 95,
-};
-
-/******************************************************************************
- * Backlight
- ******************************************************************************/
-static int treo_backlight_init(struct device *dev)
-{
-	int ret;
-
-	ret = gpio_request(GPIO_NR_TREO_BL_POWER, "BL POWER");
-	if (ret)
-		goto err;
-	ret = gpio_direction_output(GPIO_NR_TREO_BL_POWER, 0);
-	if (ret)
-		goto err2;
-
-	return 0;
-
-err2:
-	gpio_free(GPIO_NR_TREO_BL_POWER);
-err:
-	return ret;
-}
-
-static int treo_backlight_notify(struct device *dev, int brightness)
-{
-	gpio_set_value(GPIO_NR_TREO_BL_POWER, brightness);
-	return TREO_MAX_INTENSITY - brightness;
-};
-
-static void treo_backlight_exit(struct device *dev)
-{
-	gpio_free(GPIO_NR_TREO_BL_POWER);
-}
-
-static struct platform_pwm_backlight_data treo_backlight_data = {
-	.pwm_id		= 0,
-	.max_brightness	= TREO_MAX_INTENSITY,
-	.dft_brightness	= TREO_DEFAULT_INTENSITY,
-	.pwm_period_ns	= TREO_PERIOD_NS,
-	.init		= treo_backlight_init,
-	.notify		= treo_backlight_notify,
-	.exit		= treo_backlight_exit,
-};
-
-static struct platform_device treo_backlight = {
-	.name	= "pwm-backlight",
-	.dev	= {
-		.parent		= &pxa27x_device_pwm0.dev,
-		.platform_data	= &treo_backlight_data,
-	},
-};
-
-/******************************************************************************
- * IrDA
- ******************************************************************************/
-static struct pxaficp_platform_data treo_ficp_info = {
-	.gpio_pwdown		= GPIO_NR_TREO_IR_EN,
-	.transceiver_cap	= IR_SIRMODE | IR_OFF,
-};
-
-/******************************************************************************
- * UDC
- ******************************************************************************/
-static struct pxa2xx_udc_mach_info treo_udc_info __initdata = {
-	.gpio_vbus		= GPIO_NR_TREO_USB_DETECT,
-	.gpio_vbus_inverted	= 1,
-	.gpio_pullup		= GPIO_NR_TREO_USB_PULLUP,
-};
-
-
-/******************************************************************************
  * USB host
  ******************************************************************************/
 #ifdef CONFIG_MACH_TREO680
@@ -415,58 +317,6 @@ static struct pxaohci_platform_data treo680_ohci_info = {
 #endif /* CONFIG_MACH_TREO680 */
 
 /******************************************************************************
- * Power supply
- ******************************************************************************/
-static int power_supply_init(struct device *dev)
-{
-	int ret;
-
-	ret = gpio_request(GPIO_NR_TREO_POWER_DETECT, "CABLE_STATE_AC");
-	if (ret)
-		goto err1;
-	ret = gpio_direction_input(GPIO_NR_TREO_POWER_DETECT);
-	if (ret)
-		goto err2;
-
-	return 0;
-
-err2:
-	gpio_free(GPIO_NR_TREO_POWER_DETECT);
-err1:
-	return ret;
-}
-
-static int treo_is_ac_online(void)
-{
-	return gpio_get_value(GPIO_NR_TREO_POWER_DETECT);
-}
-
-static void power_supply_exit(struct device *dev)
-{
-	gpio_free(GPIO_NR_TREO_POWER_DETECT);
-}
-
-static char *treo_supplicants[] = {
-	"main-battery",
-};
-
-static struct pda_power_pdata power_supply_info = {
-	.init		 = power_supply_init,
-	.is_ac_online    = treo_is_ac_online,
-	.exit		 = power_supply_exit,
-	.supplied_to     = treo_supplicants,
-	.num_supplicants = ARRAY_SIZE(treo_supplicants),
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
  * Vibra and LEDs
  ******************************************************************************/
 #ifdef CONFIG_MACH_TREO680
@@ -537,60 +387,8 @@ static struct platform_device centro_leds = {
 #endif /* CONFIG_MACH_CENTRO */
 
 /******************************************************************************
- * Framebuffer
- ******************************************************************************/
-/* TODO: add support for 324x324 */
-static struct pxafb_mode_info treo_lcd_modes[] = {
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
-static void treo_lcd_power(int on, struct fb_var_screeninfo *info)
-{
-	gpio_set_value(GPIO_NR_TREO_BL_POWER, on);
-}
-
-static struct pxafb_mach_info treo_lcd_screen = {
-	.modes		= treo_lcd_modes,
-	.num_modes	= ARRAY_SIZE(treo_lcd_modes),
-	.lcd_conn	= LCD_COLOR_TFT_16BPP | LCD_PCLK_EDGE_FALL,
-};
-
-/******************************************************************************
- * Power management - standby
- ******************************************************************************/
-static void __init treo_pm_init(void)
-{
-	static u32 resume[] = {
-		0xe3a00101,	/* mov	r0,	#0x40000000 */
-		0xe380060f,	/* orr	r0, r0, #0x00f00000 */
-		0xe590f008,	/* ldr	pc, [r0, #0x08] */
-	};
-
-	/* this is where the bootloader jumps */
-	memcpy(phys_to_virt(TREO_STR_BASE), resume, sizeof(resume));
-}
-
-/******************************************************************************
  * Machine init
  ******************************************************************************/
-static struct platform_device *treo_devices[] __initdata = {
-	&treo_backlight,
-	&power_supply,
-};
-
 #ifdef CONFIG_MACH_TREO680
 static struct platform_device *treo680_devices[] __initdata = {
 	&treo680_leds,
@@ -603,62 +401,29 @@ static struct platform_device *centro_devices[] __initdata = {
 };
 #endif /* CONFIG_MACH_CENTRO */
 
-/* setup udc GPIOs initial state */
-static void __init treo_udc_init(void)
-{
-	if (!gpio_request(GPIO_NR_TREO_USB_PULLUP, "UDC Vbus")) {
-		gpio_direction_output(GPIO_NR_TREO_USB_PULLUP, 1);
-		gpio_free(GPIO_NR_TREO_USB_PULLUP);
-	}
-}
-
-static void __init treo_lcd_power_init(void)
-{
-	int ret;
-
-	ret = gpio_request(GPIO_NR_TREO_LCD_POWER, "LCD POWER");
-	if (ret) {
-		pr_err("Treo680: LCD power GPIO request failed!\n");
-		return;
-	}
-
-	ret = gpio_direction_output(GPIO_NR_TREO_LCD_POWER, 0);
-	if (ret) {
-		pr_err("Treo680: setting LCD power GPIO direction failed!\n");
-		gpio_free(GPIO_NR_TREO_LCD_POWER);
-		return;
-	}
-
-	treo_lcd_screen.pxafb_lcd_power = treo_lcd_power;
-}
-
-static void __init treo_init(void)
-{
-	pxa_set_ffuart_info(NULL);
-	pxa_set_btuart_info(NULL);
-	pxa_set_stuart_info(NULL);
-
-	treo_pm_init();
-	pxa2xx_mfp_config(ARRAY_AND_SIZE(treo_pin_config));
-	treo_lcd_power_init();
-	set_pxa_fb_info(&treo_lcd_screen);
-	treo_udc_init();
-	pxa_set_udc_info(&treo_udc_info);
-	pxa_set_ac97_info(&treo_ac97_pdata);
-	pxa_set_ficp_info(&treo_ficp_info);
-
-	platform_add_devices(ARRAY_AND_SIZE(treo_devices));
-}
-
 #ifdef CONFIG_MACH_TREO680
+struct palm27x_handheld palmtreo680 = {
+	.mmc_detect	= GPIO_NR_TREO_SD_DETECT_N,
+	.mmc_ro		= GPIO_NR_TREO680_SD_READONLY,
+	.mmc_power	= GPIO_NR_TREO680_SD_POWER,
+	.pm_str_base	= TREO_STR_BASE,
+	.udc_detect	= GPIO_NR_TREO_USB_DETECT,
+	.udc_pullup	= GPIO_NR_TREO_USB_PULLUP,
+	.irda_pwdn	= GPIO_NR_TREO_IR_EN,
+	.bl_bl		= GPIO_NR_TREO_BL_POWER,
+	.bl_lcd		= -1,
+	.power_ac	= GPIO_NR_TREO_POWER_DETECT,
+	.power_usb	= -1,
+	.lcd_power	= GPIO_NR_TREO_BL_POWER,
+};
+
 static void __init treo680_init(void)
 {
-	treo_init();
+	pxa2xx_mfp_config(ARRAY_AND_SIZE(treo_pin_config));
 	pxa2xx_mfp_config(ARRAY_AND_SIZE(treo680_pin_config));
-	pxa_set_mci_info(&treo680_mci_platform_data);
+	palm27x_common_init(&palmtreo680);
 	pxa_set_keypad_info(&treo680_keypad_platform_data);
 	pxa_set_ohci_info(&treo680_ohci_info);
-
 	platform_add_devices(ARRAY_AND_SIZE(treo680_devices));
 }
 
@@ -674,14 +439,27 @@ MACHINE_END
 #endif /* CONFIG_MACH_TREO680 */
 
 #ifdef CONFIG_MACH_CENTRO
+struct palm27x_handheld palmcentro = {
+	.mmc_detect	= GPIO_NR_TREO_SD_DETECT_N,
+	.mmc_ro		= -1,
+	.mmc_power	= GPIO_NR_CENTRO_SD_POWER,
+	.pm_str_base	= TREO_STR_BASE,
+	.udc_detect	= GPIO_NR_TREO_USB_DETECT,
+	.udc_pullup	= GPIO_NR_TREO_USB_PULLUP,
+	.irda_pwdn	= GPIO_NR_TREO_IR_EN,
+	.bl_bl		= GPIO_NR_TREO_BL_POWER,
+	.bl_lcd		= -1,
+	.power_ac	= GPIO_NR_TREO_POWER_DETECT,
+	.power_usb	= -1,
+	.lcd_power	= GPIO_NR_TREO_BL_POWER,
+};
+
 static void __init centro_init(void)
 {
-	treo_init();
+	pxa2xx_mfp_config(ARRAY_AND_SIZE(treo_pin_config));
 	pxa2xx_mfp_config(ARRAY_AND_SIZE(centro685_pin_config));
-	pxa_set_mci_info(&centro_mci_platform_data);
-
+	palm27x_common_init(&palmcentro);
 	pxa_set_keypad_info(&centro_keypad_platform_data);
-
 	platform_add_devices(ARRAY_AND_SIZE(centro_devices));
 }
 
diff --git a/arch/arm/mach-pxa/palmtx.c b/arch/arm/mach-pxa/palmtx.c
index a835034..fe7ef08 100644
--- a/arch/arm/mach-pxa/palmtx.c
+++ b/arch/arm/mach-pxa/palmtx.c
@@ -46,6 +46,7 @@
 #include <mach/pxa27x_keypad.h>
 #include <mach/udc.h>
 #include <mach/palmasoc.h>
+#include <mach/palm27x.h>
 
 #include "generic.h"
 #include "devices.h"
@@ -163,17 +164,6 @@ static struct platform_device palmtx_flash = {
 };
 
 /******************************************************************************
- * SD/MMC card controller
- ******************************************************************************/
-static struct pxamci_platform_data palmtx_mci_platform_data = {
-	.ocr_mask		= MMC_VDD_32_33 | MMC_VDD_33_34,
-	.gpio_card_detect	= GPIO14_PALMTX_SD_DETECT_N,
-	.gpio_card_ro		= GPIO115_PALMTX_SD_READONLY,
-	.gpio_power		= GPIO114_PALMTX_SD_POWER,
-	.detect_delay_ms	= 200,
-};
-
-/******************************************************************************
  * GPIO keyboard
  ******************************************************************************/
 static unsigned int palmtx_matrix_keys[] = {
@@ -222,207 +212,6 @@ static struct platform_device palmtx_pxa_keys = {
 };
 
 /******************************************************************************
- * Backlight
- ******************************************************************************/
-static int palmtx_backlight_init(struct device *dev)
-{
-	int ret;
-
-	ret = gpio_request(GPIO84_PALMTX_BL_POWER, "BL POWER");
-	if (ret)
-		goto err;
-	ret = gpio_direction_output(GPIO84_PALMTX_BL_POWER, 0);
-	if (ret)
-		goto err2;
-	ret = gpio_request(GPIO96_PALMTX_LCD_POWER, "LCD POWER");
-	if (ret)
-		goto err2;
-	ret = gpio_direction_output(GPIO96_PALMTX_LCD_POWER, 0);
-	if (ret)
-		goto err3;
-
-	return 0;
-err3:
-	gpio_free(GPIO96_PALMTX_LCD_POWER);
-err2:
-	gpio_free(GPIO84_PALMTX_BL_POWER);
-err:
-	return ret;
-}
-
-static int palmtx_backlight_notify(struct device *dev, int brightness)
-{
-	gpio_set_value(GPIO84_PALMTX_BL_POWER, brightness);
-	gpio_set_value(GPIO96_PALMTX_LCD_POWER, brightness);
-	return brightness;
-}
-
-static void palmtx_backlight_exit(struct device *dev)
-{
-	gpio_free(GPIO84_PALMTX_BL_POWER);
-	gpio_free(GPIO96_PALMTX_LCD_POWER);
-}
-
-static struct platform_pwm_backlight_data palmtx_backlight_data = {
-	.pwm_id		= 0,
-	.max_brightness	= PALMTX_MAX_INTENSITY,
-	.dft_brightness	= PALMTX_MAX_INTENSITY,
-	.pwm_period_ns	= PALMTX_PERIOD_NS,
-	.init		= palmtx_backlight_init,
-	.notify		= palmtx_backlight_notify,
-	.exit		= palmtx_backlight_exit,
-};
-
-static struct platform_device palmtx_backlight = {
-	.name	= "pwm-backlight",
-	.dev	= {
-		.parent		= &pxa27x_device_pwm0.dev,
-		.platform_data	= &palmtx_backlight_data,
-	},
-};
-
-/******************************************************************************
- * IrDA
- ******************************************************************************/
-static struct pxaficp_platform_data palmtx_ficp_platform_data = {
-	.gpio_pwdown		= GPIO40_PALMTX_IR_DISABLE,
-	.transceiver_cap	= IR_SIRMODE | IR_OFF,
-};
-
-/******************************************************************************
- * UDC
- ******************************************************************************/
-static struct gpio_vbus_mach_info palmtx_udc_info = {
-	.gpio_vbus		= GPIO13_PALMTX_USB_DETECT_N,
-	.gpio_vbus_inverted	= 1,
-	.gpio_pullup		= GPIO93_PALMTX_USB_PULLUP,
-};
-
-static struct platform_device palmtx_gpio_vbus = {
-	.name	= "gpio-vbus",
-	.id	= -1,
-	.dev	= {
-		.platform_data	= &palmtx_udc_info,
-	},
-};
-
-/******************************************************************************
- * Power supply
- ******************************************************************************/
-static int power_supply_init(struct device *dev)
-{
-	int ret;
-
-	ret = gpio_request(GPIO12_PALMTX_POWER_DETECT, "CABLE_STATE_AC");
-	if (ret)
-		goto err1;
-	ret = gpio_direction_input(GPIO12_PALMTX_POWER_DETECT);
-	if (ret)
-		goto err2;
-
-	return 0;
-
-err2:
-	gpio_free(GPIO12_PALMTX_POWER_DETECT);
-err1:
-	return ret;
-}
-
-static int palmtx_is_ac_online(void)
-{
-	return gpio_get_value(GPIO12_PALMTX_POWER_DETECT);
-}
-
-static void power_supply_exit(struct device *dev)
-{
-	gpio_free(GPIO12_PALMTX_POWER_DETECT);
-}
-
-static char *palmtx_supplicants[] = {
-	"main-battery",
-};
-
-static struct pda_power_pdata power_supply_info = {
-	.init            = power_supply_init,
-	.is_ac_online    = palmtx_is_ac_online,
-	.exit            = power_supply_exit,
-	.supplied_to     = palmtx_supplicants,
-	.num_supplicants = ARRAY_SIZE(palmtx_supplicants),
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
- * WM97xx audio, battery
- ******************************************************************************/
-static struct wm97xx_batt_pdata palmtx_batt_pdata = {
-	.batt_aux	= WM97XX_AUX_ID3,
-	.temp_aux	= WM97XX_AUX_ID2,
-	.charge_gpio	= -1,
-	.max_voltage	= PALMTX_BAT_MAX_VOLTAGE,
-	.min_voltage	= PALMTX_BAT_MIN_VOLTAGE,
-	.batt_mult	= 1000,
-	.batt_div	= 414,
-	.temp_mult	= 1,
-	.temp_div	= 1,
-	.batt_tech	= POWER_SUPPLY_TECHNOLOGY_LIPO,
-	.batt_name	= "main-batt",
-};
-
-static struct wm97xx_pdata palmtx_wm97xx_pdata = {
-	.batt_pdata	= &palmtx_batt_pdata,
-};
-
-static pxa2xx_audio_ops_t palmtx_ac97_pdata = {
-	.reset_gpio	= 95,
-	.codec_pdata	= { &palmtx_wm97xx_pdata, },
-};
-
-static struct palm27x_asoc_info palmtx_asoc_pdata = {
-	.jack_gpio	= GPIO107_PALMTX_EARPHONE_DETECT,
-};
-
-static struct platform_device palmtx_asoc = {
-	.name = "palm27x-asoc",
-	.id   = -1,
-	.dev  = {
-		.platform_data = &palmtx_asoc_pdata,
-	},
-};
-
-/******************************************************************************
- * Framebuffer
- ******************************************************************************/
-static struct pxafb_mode_info palmtx_lcd_modes[] = {
-{
-	.pixclock	= 57692,
-	.xres		= 320,
-	.yres		= 480,
-	.bpp		= 16,
-
-	.left_margin	= 32,
-	.right_margin	= 1,
-	.upper_margin	= 7,
-	.lower_margin	= 1,
-
-	.hsync_len	= 4,
-	.vsync_len	= 1,
-},
-};
-
-static struct pxafb_mach_info palmtx_lcd_screen = {
-	.modes		= palmtx_lcd_modes,
-	.num_modes	= ARRAY_SIZE(palmtx_lcd_modes),
-	.lcd_conn	= LCD_COLOR_TFT_16BPP | LCD_PCLK_EDGE_FALL,
-};
-
-/******************************************************************************
  * NAND Flash
  ******************************************************************************/
 static void palmtx_nand_cmd_ctl(struct mtd_info *mtd, int cmd,
@@ -484,20 +273,6 @@ static struct platform_device palmtx_nand = {
 	}
 };
 
-/******************************************************************************
- * Power management - standby
- ******************************************************************************/
-static void __init palmtx_pm_init(void)
-{
-	static u32 resume[] = {
-		0xe3a00101,	/* mov	r0,	#0x40000000 */
-		0xe380060f,	/* orr	r0, r0, #0x00f00000 */
-		0xe590f008,	/* ldr	pc, [r0, #0x08] */
-	};
-
-	/* copy the bootloader */
-	memcpy(phys_to_virt(PALMTX_STR_BASE), resume, sizeof(resume));
-}
 
 /******************************************************************************
  * Machine init
@@ -506,10 +281,6 @@ static struct platform_device *devices[] __initdata = {
 #if defined(CONFIG_KEYBOARD_GPIO) || defined(CONFIG_KEYBOARD_GPIO_MODULE)
 	&palmtx_pxa_keys,
 #endif
-	&palmtx_backlight,
-	&power_supply,
-	&palmtx_asoc,
-	&palmtx_gpio_vbus,
 	&palmtx_flash,
 	&palmtx_nand,
 };
@@ -539,32 +310,28 @@ static void __init palmtx_map_io(void)
 	iotable_init(palmtx_io_desc, ARRAY_SIZE(palmtx_io_desc));
 }
 
-/* setup udc GPIOs initial state */
-static void __init palmtx_udc_init(void)
-{
-	if (!gpio_request(GPIO93_PALMTX_USB_PULLUP, "UDC Vbus")) {
-		gpio_direction_output(GPIO93_PALMTX_USB_PULLUP, 1);
-		gpio_free(GPIO93_PALMTX_USB_PULLUP);
-	}
-}
-
+struct palm27x_handheld palmtx = {
+	.mmc_detect	= GPIO14_PALMTX_SD_DETECT_N,
+	.mmc_ro		= GPIO115_PALMTX_SD_READONLY,
+	.mmc_power	= GPIO114_PALMTX_SD_POWER,
+	.pm_str_base	= PALMTX_STR_BASE,
+	.udc_detect	= GPIO13_PALMTX_USB_DETECT_N,
+	.udc_pullup	= GPIO93_PALMTX_USB_PULLUP,
+	.irda_pwdn	= GPIO40_PALMTX_IR_DISABLE,
+	.batt_minv	= PALMTX_BAT_MIN_VOLTAGE,
+	.batt_maxv	= PALMTX_BAT_MAX_VOLTAGE,
+	.jack_gpio	= GPIO107_PALMTX_EARPHONE_DETECT,
+	.bl_bl		= GPIO84_PALMTX_BL_POWER,
+	.bl_lcd		= GPIO96_PALMTX_LCD_POWER,
+	.power_ac	= GPIO12_PALMTX_POWER_DETECT,
+	.power_usb	= -1,
+};
 
 static void __init palmtx_init(void)
 {
 	pxa2xx_mfp_config(ARRAY_AND_SIZE(palmtx_pin_config));
-
-	pxa_set_ffuart_info(NULL);
-	pxa_set_btuart_info(NULL);
-	pxa_set_stuart_info(NULL);
-
-	palmtx_pm_init();
-	set_pxa_fb_info(&palmtx_lcd_screen);
-	pxa_set_mci_info(&palmtx_mci_platform_data);
-	palmtx_udc_init();
-	pxa_set_ac97_info(&palmtx_ac97_pdata);
-	pxa_set_ficp_info(&palmtx_ficp_platform_data);
+	palm27x_common_init(&palmtx);
 	pxa_set_keypad_info(&palmtx_keypad_platform_data);
-
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 }
 
diff --git a/arch/arm/mach-pxa/palmz72.c b/arch/arm/mach-pxa/palmz72.c
index 91bc5a3..e66e911 100644
--- a/arch/arm/mach-pxa/palmz72.c
+++ b/arch/arm/mach-pxa/palmz72.c
@@ -44,6 +44,7 @@
 #include <mach/pxa27x_keypad.h>
 #include <mach/udc.h>
 #include <mach/palmasoc.h>
+#include <mach/palm27x.h>
 
 #include <mach/pm.h>
 
@@ -109,19 +110,6 @@ static unsigned long palmz72_pin_config[] __initdata = {
 };
 
 /******************************************************************************
- * SD/MMC card controller
- ******************************************************************************/
-/* SD_POWER is not actually power, but it is more like chip
- * select, i.e. it is inverted */
-static struct pxamci_platform_data palmz72_mci_platform_data = {
-	.ocr_mask		= MMC_VDD_32_33 | MMC_VDD_33_34,
-	.gpio_card_detect	= GPIO14_PALMZ72_SD_DETECT_N,
-	.gpio_card_ro		= GPIO115_PALMZ72_SD_RO,
-	.gpio_power		= GPIO98_PALMZ72_SD_POWER_N,
-	.gpio_power_invert	= 1,
-};
-
-/******************************************************************************
  * GPIO keyboard
  ******************************************************************************/
 static unsigned int palmz72_matrix_keys[] = {
@@ -150,74 +138,6 @@ static struct pxa27x_keypad_platform_data palmz72_keypad_platform_data = {
 };
 
 /******************************************************************************
- * Backlight
- ******************************************************************************/
-static int palmz72_backlight_init(struct device *dev)
-{
-	int ret;
-
-	ret = gpio_request(GPIO20_PALMZ72_BL_POWER, "BL POWER");
-	if (ret)
-		goto err;
-	ret = gpio_direction_output(GPIO20_PALMZ72_BL_POWER, 0);
-	if (ret)
-		goto err2;
-	ret = gpio_request(GPIO96_PALMZ72_LCD_POWER, "LCD POWER");
-	if (ret)
-		goto err2;
-	ret = gpio_direction_output(GPIO96_PALMZ72_LCD_POWER, 0);
-	if (ret)
-		goto err3;
-
-	return 0;
-err3:
-	gpio_free(GPIO96_PALMZ72_LCD_POWER);
-err2:
-	gpio_free(GPIO20_PALMZ72_BL_POWER);
-err:
-	return ret;
-}
-
-static int palmz72_backlight_notify(struct device *dev, int brightness)
-{
-	gpio_set_value(GPIO20_PALMZ72_BL_POWER, brightness);
-	gpio_set_value(GPIO96_PALMZ72_LCD_POWER, brightness);
-	return brightness;
-}
-
-static void palmz72_backlight_exit(struct device *dev)
-{
-	gpio_free(GPIO20_PALMZ72_BL_POWER);
-	gpio_free(GPIO96_PALMZ72_LCD_POWER);
-}
-
-static struct platform_pwm_backlight_data palmz72_backlight_data = {
-	.pwm_id		= 0,
-	.max_brightness	= PALMZ72_MAX_INTENSITY,
-	.dft_brightness	= PALMZ72_MAX_INTENSITY,
-	.pwm_period_ns	= PALMZ72_PERIOD_NS,
-	.init		= palmz72_backlight_init,
-	.notify		= palmz72_backlight_notify,
-	.exit		= palmz72_backlight_exit,
-};
-
-static struct platform_device palmz72_backlight = {
-	.name	= "pwm-backlight",
-	.dev	= {
-		.parent		= &pxa27x_device_pwm0.dev,
-		.platform_data	= &palmz72_backlight_data,
-	},
-};
-
-/******************************************************************************
- * IrDA
- ******************************************************************************/
-static struct pxaficp_platform_data palmz72_ficp_platform_data = {
-	.gpio_pwdown		= GPIO49_PALMZ72_IR_DISABLE,
-	.transceiver_cap	= IR_SIRMODE | IR_OFF,
-};
-
-/******************************************************************************
  * LEDs
  ******************************************************************************/
 static struct gpio_led gpio_leds[] = {
@@ -241,145 +161,6 @@ static struct platform_device palmz72_leds = {
 	}
 };
 
-/******************************************************************************
- * UDC
- ******************************************************************************/
-static struct gpio_vbus_mach_info palmz72_udc_info = {
-	.gpio_vbus		= GPIO15_PALMZ72_USB_DETECT_N,
-	.gpio_pullup		= GPIO95_PALMZ72_USB_PULLUP,
-};
-
-static struct platform_device palmz72_gpio_vbus = {
-	.name	= "gpio-vbus",
-	.id	= -1,
-	.dev	= {
-		.platform_data	= &palmz72_udc_info,
-	},
-};
-
-/******************************************************************************
- * Power supply
- ******************************************************************************/
-static int power_supply_init(struct device *dev)
-{
-	int ret;
-
-	ret = gpio_request(GPIO0_PALMZ72_POWER_DETECT, "CABLE_STATE_AC");
-	if (ret)
-		goto err1;
-	ret = gpio_direction_input(GPIO0_PALMZ72_POWER_DETECT);
-	if (ret)
-		goto err2;
-
-	ret = gpio_request(GPIO15_PALMZ72_USB_DETECT_N, "CABLE_STATE_USB");
-	if (ret)
-		goto err2;
-	ret = gpio_direction_input(GPIO15_PALMZ72_USB_DETECT_N);
-	if (ret)
-		goto err3;
-
-	return 0;
-err3:
-	gpio_free(GPIO15_PALMZ72_USB_DETECT_N);
-err2:
-	gpio_free(GPIO0_PALMZ72_POWER_DETECT);
-err1:
-	return ret;
-}
-
-static int palmz72_is_ac_online(void)
-{
-	return gpio_get_value(GPIO0_PALMZ72_POWER_DETECT);
-}
-
-static int palmz72_is_usb_online(void)
-{
-	return !gpio_get_value(GPIO15_PALMZ72_USB_DETECT_N);
-}
-
-static void power_supply_exit(struct device *dev)
-{
-	gpio_free(GPIO15_PALMZ72_USB_DETECT_N);
-	gpio_free(GPIO0_PALMZ72_POWER_DETECT);
-}
-
-static char *palmz72_supplicants[] = {
-	"main-battery",
-};
-
-static struct pda_power_pdata power_supply_info = {
-	.init            = power_supply_init,
-	.is_ac_online    = palmz72_is_ac_online,
-	.is_usb_online   = palmz72_is_usb_online,
-	.exit            = power_supply_exit,
-	.supplied_to     = palmz72_supplicants,
-	.num_supplicants = ARRAY_SIZE(palmz72_supplicants),
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
- * WM97xx audio, battery
- ******************************************************************************/
-static struct wm97xx_batt_pdata palmz72_batt_pdata = {
-	.batt_aux	= WM97XX_AUX_ID3,
-	.temp_aux	= WM97XX_AUX_ID2,
-	.charge_gpio	= -1,
-	.max_voltage	= PALMZ72_BAT_MAX_VOLTAGE,
-	.min_voltage	= PALMZ72_BAT_MIN_VOLTAGE,
-	.batt_mult	= 1000,
-	.batt_div	= 414,
-	.temp_mult	= 1,
-	.temp_div	= 1,
-	.batt_tech	= POWER_SUPPLY_TECHNOLOGY_LIPO,
-	.batt_name	= "main-batt",
-};
-
-static struct wm97xx_pdata palmz72_wm97xx_pdata = {
-	.batt_pdata	= &palmz72_batt_pdata,
-};
-
-static pxa2xx_audio_ops_t palmz72_ac97_pdata = {
-	.codec_pdata	= { &palmz72_wm97xx_pdata, },
-};
-
-static struct platform_device palmz72_asoc = {
-	.name = "palm27x-asoc",
-	.id   = -1,
-};
-
-/******************************************************************************
- * Framebuffer
- ******************************************************************************/
-static struct pxafb_mode_info palmz72_lcd_modes[] = {
-{
-	.pixclock	= 115384,
-	.xres		= 320,
-	.yres		= 320,
-	.bpp		= 16,
-
-	.left_margin	= 27,
-	.right_margin	= 7,
-	.upper_margin	= 7,
-	.lower_margin	= 8,
-
-	.hsync_len	= 6,
-	.vsync_len	= 1,
-},
-};
-
-static struct pxafb_mach_info palmz72_lcd_screen = {
-	.modes		= palmz72_lcd_modes,
-	.num_modes	= ARRAY_SIZE(palmz72_lcd_modes),
-	.lcd_conn	= LCD_COLOR_TFT_16BPP | LCD_PCLK_EDGE_FALL,
-};
-
 #ifdef CONFIG_PM
 
 /* We have some black magic here
@@ -457,39 +238,24 @@ device_initcall(palmz72_pm_init);
 /******************************************************************************
  * Machine init
  ******************************************************************************/
-static struct platform_device *devices[] __initdata = {
-	&palmz72_backlight,
-	&palmz72_leds,
-	&palmz72_asoc,
-	&power_supply,
-	&palmz72_gpio_vbus,
+struct palm27x_handheld palmz72 = {
+	.mmc_detect	= GPIO14_PALMZ72_SD_DETECT_N,
+	.mmc_ro		= GPIO115_PALMZ72_SD_RO,
+	.mmc_power	= GPIO98_PALMZ72_SD_POWER_N,
+	.pm_str_base	= 0,
+	.udc_detect	= GPIO15_PALMZ72_USB_DETECT_N,
+	.udc_pullup	= GPIO95_PALMZ72_USB_PULLUP,
+	.irda_pwdn	= GPIO49_PALMZ72_IR_DISABLE,
+	.batt_minv	= PALMZ72_BAT_MIN_VOLTAGE,
+	.batt_maxv	= PALMZ72_BAT_MAX_VOLTAGE,
 };
 
-/* setup udc GPIOs initial state */
-static void __init palmz72_udc_init(void)
-{
-	if (!gpio_request(GPIO95_PALMZ72_USB_PULLUP, "USB Pullup")) {
-		gpio_direction_output(GPIO95_PALMZ72_USB_PULLUP, 0);
-		gpio_free(GPIO95_PALMZ72_USB_PULLUP);
-	}
-}
-
 static void __init palmz72_init(void)
 {
 	pxa2xx_mfp_config(ARRAY_AND_SIZE(palmz72_pin_config));
-
-	pxa_set_ffuart_info(NULL);
-	pxa_set_btuart_info(NULL);
-	pxa_set_stuart_info(NULL);
-
-	set_pxa_fb_info(&palmz72_lcd_screen);
-	pxa_set_mci_info(&palmz72_mci_platform_data);
-	palmz72_udc_init();
-	pxa_set_ac97_info(&palmz72_ac97_pdata);
-	pxa_set_ficp_info(&palmz72_ficp_platform_data);
+	palm27x_common_init(&palmz72);
 	pxa_set_keypad_info(&palmz72_keypad_platform_data);
-
-	platform_add_devices(devices, ARRAY_SIZE(devices));
+	platform_device_register(&palmz72_leds);
 }
 
 MACHINE_START(PALMZ72, "Palm Zire72")
-- 
1.7.1
