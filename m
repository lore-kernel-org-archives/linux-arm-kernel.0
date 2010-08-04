From: marek.vasut@gmail.com (Marek Vasut)
Date: Wed,  4 Aug 2010 13:22:04 +0200
Subject: [PATCH 02/11] [ARM] pxa/palm: Flip Palm LD,TX,T5,Z72 to Palm27x
In-Reply-To: <1280920933-3820-1-git-send-email-marek.vasut@gmail.com>
References: <1280920933-3820-1-git-send-email-marek.vasut@gmail.com>
Message-ID: <1280920933-3820-2-git-send-email-marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
---
 arch/arm/mach-pxa/Kconfig    |    4 +
 arch/arm/mach-pxa/palmld.c   |  291 +++++++----------------------------
 arch/arm/mach-pxa/palmt5.c   |  282 ++++------------------------------
 arch/arm/mach-pxa/palmtreo.c |  355 +++++++-----------------------------------
 arch/arm/mach-pxa/palmtx.c   |  298 ++++++------------------------------
 arch/arm/mach-pxa/palmz72.c  |  266 +++----------------------------
 6 files changed, 215 insertions(+), 1281 deletions(-)

diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
index 6f04f21..7aefb90 100644
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
index 83a1a55..91038ee 100644
--- a/arch/arm/mach-pxa/palmld.c
+++ b/arch/arm/mach-pxa/palmld.c
@@ -41,6 +41,7 @@
 #include <mach/irda.h>
 #include <mach/pxa27x_keypad.h>
 #include <mach/palmasoc.h>
+#include <mach/palm27x.h>
 
 #include "generic.h"
 #include "devices.h"
@@ -127,6 +128,7 @@ static unsigned long palmld_pin_config[] __initdata = {
 /******************************************************************************
  * NOR Flash
  ******************************************************************************/
+#if defined(CONFIG_MTD_PHYSMAP) || defined(CONFIG_MTD_PHYSMAP_MODULE)
 static struct mtd_partition palmld_partitions[] = {
 	{
 		.name		= "Flash",
@@ -160,20 +162,18 @@ static struct platform_device palmld_flash = {
 	},
 };
 
-/******************************************************************************
- * SD/MMC card controller
- ******************************************************************************/
-static struct pxamci_platform_data palmld_mci_platform_data = {
-	.ocr_mask		= MMC_VDD_32_33 | MMC_VDD_33_34,
-	.gpio_card_detect	= GPIO_NR_PALMLD_SD_DETECT_N,
-	.gpio_card_ro		= GPIO_NR_PALMLD_SD_READONLY,
-	.gpio_power		= GPIO_NR_PALMLD_SD_POWER,
-	.detect_delay_ms	= 200,
-};
+static void __init palmld_nor_init(void)
+{
+	platform_device_register(&palmld_flash);
+}
+#else
+static inline void palmld_nor_init(void) {}
+#endif
 
 /******************************************************************************
  * GPIO keyboard
  ******************************************************************************/
+#if defined(CONFIG_KEYBOARD_PXA27x) || defined(CONFIG_KEYBOARD_PXA27x_MODULE)
 static unsigned int palmld_matrix_keys[] = {
 	KEY(0, 1, KEY_F2),
 	KEY(0, 2, KEY_UP),
@@ -200,9 +200,18 @@ static struct pxa27x_keypad_platform_data palmld_keypad_platform_data = {
 	.debounce_interval	= 30,
 };
 
+static void __init palmld_kpc_init(void)
+{
+	pxa_set_keypad_info(&palmld_keypad_platform_data);
+}
+#else
+static inline void palmld_kpc_init(void) {}
+#endif
+
 /******************************************************************************
  * GPIO keys
  ******************************************************************************/
+#if defined(CONFIG_KEYBOARD_GPIO) || defined(CONFIG_KEYBOARD_GPIO_MODULE)
 static struct gpio_keys_button palmld_pxa_buttons[] = {
 	{KEY_F8, GPIO_NR_PALMLD_HOTSYNC_BUTTON_N, 1, "HotSync Button" },
 	{KEY_F9, GPIO_NR_PALMLD_LOCK_SWITCH, 0, "Lock Switch" },
@@ -222,77 +231,18 @@ static struct platform_device palmld_pxa_keys = {
 	},
 };
 
-/******************************************************************************
- * Backlight
- ******************************************************************************/
-static int palmld_backlight_init(struct device *dev)
-{
-	int ret;
-
-	ret = gpio_request(GPIO_NR_PALMLD_BL_POWER, "BL POWER");
-	if (ret)
-		goto err;
-	ret = gpio_direction_output(GPIO_NR_PALMLD_BL_POWER, 0);
-	if (ret)
-		goto err2;
-	ret = gpio_request(GPIO_NR_PALMLD_LCD_POWER, "LCD POWER");
-	if (ret)
-		goto err2;
-	ret = gpio_direction_output(GPIO_NR_PALMLD_LCD_POWER, 0);
-	if (ret)
-		goto err3;
-
-	return 0;
-err3:
-	gpio_free(GPIO_NR_PALMLD_LCD_POWER);
-err2:
-	gpio_free(GPIO_NR_PALMLD_BL_POWER);
-err:
-	return ret;
-}
-
-static int palmld_backlight_notify(struct device *dev, int brightness)
+static void __init palmld_keys_init(void)
 {
-	gpio_set_value(GPIO_NR_PALMLD_BL_POWER, brightness);
-	gpio_set_value(GPIO_NR_PALMLD_LCD_POWER, brightness);
-	return brightness;
+	platform_device_register(&palmld_pxa_keys);
 }
-
-static void palmld_backlight_exit(struct device *dev)
-{
-	gpio_free(GPIO_NR_PALMLD_BL_POWER);
-	gpio_free(GPIO_NR_PALMLD_LCD_POWER);
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
-	.gpio_pwdown		= GPIO_NR_PALMLD_IR_DISABLE,
-	.transceiver_cap	= IR_SIRMODE | IR_OFF,
-};
+#else
+static inline void palmld_keys_init(void) {}
+#endif
 
 /******************************************************************************
  * LEDs
  ******************************************************************************/
+#if defined(CONFIG_LEDS_GPIO) || defined(CONFIG_LEDS_GPIO_MODULE)
 struct gpio_led gpio_leds[] = {
 {
 	.name			= "palmld:green:led",
@@ -318,176 +268,34 @@ static struct platform_device palmld_leds = {
 	}
 };
 
-/******************************************************************************
- * Power supply
- ******************************************************************************/
-static int power_supply_init(struct device *dev)
-{
-	int ret;
-
-	ret = gpio_request(GPIO_NR_PALMLD_POWER_DETECT, "CABLE_STATE_AC");
-	if (ret)
-		goto err1;
-	ret = gpio_direction_input(GPIO_NR_PALMLD_POWER_DETECT);
-	if (ret)
-		goto err2;
-
-	ret = gpio_request(GPIO_NR_PALMLD_USB_DETECT_N, "CABLE_STATE_USB");
-	if (ret)
-		goto err2;
-	ret = gpio_direction_input(GPIO_NR_PALMLD_USB_DETECT_N);
-	if (ret)
-		goto err3;
-
-	return 0;
-
-err3:
-	gpio_free(GPIO_NR_PALMLD_USB_DETECT_N);
-err2:
-	gpio_free(GPIO_NR_PALMLD_POWER_DETECT);
-err1:
-	return ret;
-}
-
-static int palmld_is_ac_online(void)
+static void __init palmld_leds_init(void)
 {
-	return gpio_get_value(GPIO_NR_PALMLD_POWER_DETECT);
+	platform_device_register(&palmld_leds);
 }
-
-static int palmld_is_usb_online(void)
-{
-	return !gpio_get_value(GPIO_NR_PALMLD_USB_DETECT_N);
-}
-
-static void power_supply_exit(struct device *dev)
-{
-	gpio_free(GPIO_NR_PALMLD_USB_DETECT_N);
-	gpio_free(GPIO_NR_PALMLD_POWER_DETECT);
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
-	.jack_gpio	= GPIO_NR_PALMLD_EARPHONE_DETECT,
-};
-
-static struct platform_device palmld_asoc = {
-	.name = "palm27x-asoc",
-	.id   = -1,
-	.dev  = {
-		.platform_data = &palmld_asoc_pdata,
-	},
-};
+#else
+static inline void palmld_leds_init(void) {}
+#endif
 
 /******************************************************************************
  * HDD
  ******************************************************************************/
-static struct platform_device palmld_hdd = {
+#if defined(CONFIG_PATA_PALMLD) || defined(CONFIG_PATA_PALMLD_MODULE)
+static struct platform_device palmld_ide_device = {
 	.name	= "pata_palmld",
 	.id	= -1,
 };
 
-/******************************************************************************
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
+static void __init palmld_ide_init(void)
 {
-	static u32 resume[] = {
-		0xe3a00101,	/* mov	r0,	#0x40000000 */
-		0xe380060f,	/* orr	r0, r0, #0x00f00000 */
-		0xe590f008,	/* ldr	pc, [r0, #0x08] */
-	};
-
-	/* copy the bootloader */
-	memcpy(phys_to_virt(PALMLD_STR_BASE), resume, sizeof(resume));
+	platform_device_register(&palmld_ide_device);
 }
+#else
+static inline void palmld_ide_init(void) {}
+#endif
 
 /******************************************************************************
  * Machine init
  ******************************************************************************/
-static struct platform_device *devices[] __initdata = {
-#if defined(CONFIG_KEYBOARD_GPIO) || defined(CONFIG_KEYBOARD_GPIO_MODULE)
-	&palmld_pxa_keys,
-#endif
-	&palmld_backlight,
-	&palmld_leds,
-	&power_supply,
-	&palmld_asoc,
-	&palmld_hdd,
-	&palmld_flash,
-};
-
 static struct map_desc palmld_io_desc[] __initdata = {
 {
 	.virtual	= PALMLD_IDE_VIRT,
@@ -512,19 +320,26 @@ static void __init palmld_map_io(void)
 static void __init palmld_init(void)
 {
 	pxa2xx_mfp_config(ARRAY_AND_SIZE(palmld_pin_config));
-
 	pxa_set_ffuart_info(NULL);
 	pxa_set_btuart_info(NULL);
 	pxa_set_stuart_info(NULL);
 
-	palmld_pm_init();
-	set_pxa_fb_info(&palmld_lcd_screen);
-	pxa_set_mci_info(&palmld_mci_platform_data);
-	pxa_set_ac97_info(&palmld_ac97_pdata);
-	pxa_set_ficp_info(&palmld_ficp_platform_data);
-	pxa_set_keypad_info(&palmld_keypad_platform_data);
-
-	platform_add_devices(devices, ARRAY_SIZE(devices));
+	palm27x_mmc_init(GPIO_NR_PALMLD_SD_DETECT_N, GPIO_NR_PALMLD_SD_READONLY,
+			GPIO_NR_PALMLD_SD_POWER, 0);
+	palm27x_pm_init(PALMLD_STR_BASE);
+	palm27x_lcd_init(-1, &palm_320x480_lcd_mode);
+	palm27x_irda_init(GPIO_NR_PALMLD_IR_DISABLE);
+	palm27x_ac97_init(PALMLD_BAT_MIN_VOLTAGE, PALMLD_BAT_MAX_VOLTAGE,
+			GPIO_NR_PALMLD_EARPHONE_DETECT, 95);
+	palm27x_pwm_init(GPIO_NR_PALMLD_BL_POWER, GPIO_NR_PALMLD_LCD_POWER);
+	palm27x_power_init(GPIO_NR_PALMLD_POWER_DETECT,
+			GPIO_NR_PALMLD_USB_DETECT_N);
+	palm27x_pmic_init();
+	palmld_kpc_init();
+	palmld_keys_init();
+	palmld_nor_init();
+	palmld_leds_init();
+	palmld_ide_init();
 }
 
 MACHINE_START(PALMLD, "Palm LifeDrive")
diff --git a/arch/arm/mach-pxa/palmt5.c b/arch/arm/mach-pxa/palmt5.c
index 0b36d7d..731ee7b 100644
--- a/arch/arm/mach-pxa/palmt5.c
+++ b/arch/arm/mach-pxa/palmt5.c
@@ -41,6 +41,7 @@
 #include <mach/pxa27x_keypad.h>
 #include <mach/udc.h>
 #include <mach/palmasoc.h>
+#include <mach/palm27x.h>
 
 #include "generic.h"
 #include "devices.h"
@@ -103,19 +104,9 @@ static unsigned long palmt5_pin_config[] __initdata = {
 };
 
 /******************************************************************************
- * SD/MMC card controller
- ******************************************************************************/
-static struct pxamci_platform_data palmt5_mci_platform_data = {
-	.ocr_mask		= MMC_VDD_32_33 | MMC_VDD_33_34,
-	.gpio_card_detect	= GPIO_NR_PALMT5_SD_DETECT_N,
-	.gpio_card_ro		= GPIO_NR_PALMT5_SD_READONLY,
-	.gpio_power		= GPIO_NR_PALMT5_SD_POWER,
-	.detect_delay_ms	= 200,
-};
-
-/******************************************************************************
  * GPIO keyboard
  ******************************************************************************/
+#if defined(CONFIG_KEYBOARD_PXA27x) || defined(CONFIG_KEYBOARD_PXA27x_MODULE)
 static unsigned int palmt5_matrix_keys[] = {
 	KEY(0, 0, KEY_POWER),
 	KEY(0, 1, KEY_F1),
@@ -141,9 +132,18 @@ static struct pxa27x_keypad_platform_data palmt5_keypad_platform_data = {
 	.debounce_interval	= 30,
 };
 
+static void __init palmt5_kpc_init(void)
+{
+	pxa_set_keypad_info(&palmt5_keypad_platform_data);
+}
+#else
+static inline void palmt5_kpc_init(void) {}
+#endif
+
 /******************************************************************************
  * GPIO keys
  ******************************************************************************/
+#if defined(CONFIG_KEYBOARD_GPIO) || defined(CONFIG_KEYBOARD_GPIO_MODULE)
 static struct gpio_keys_button palmt5_pxa_buttons[] = {
 	{KEY_F8, GPIO_NR_PALMT5_HOTSYNC_BUTTON_N, 1, "HotSync Button" },
 };
@@ -161,260 +161,38 @@ static struct platform_device palmt5_pxa_keys = {
 	},
 };
 
-/******************************************************************************
- * Backlight
- ******************************************************************************/
-static int palmt5_backlight_init(struct device *dev)
-{
-	int ret;
-
-	ret = gpio_request(GPIO_NR_PALMT5_BL_POWER, "BL POWER");
-	if (ret)
-		goto err;
-	ret = gpio_direction_output(GPIO_NR_PALMT5_BL_POWER, 0);
-	if (ret)
-		goto err2;
-	ret = gpio_request(GPIO_NR_PALMT5_LCD_POWER, "LCD POWER");
-	if (ret)
-		goto err2;
-	ret = gpio_direction_output(GPIO_NR_PALMT5_LCD_POWER, 0);
-	if (ret)
-		goto err3;
-
-	return 0;
-err3:
-	gpio_free(GPIO_NR_PALMT5_LCD_POWER);
-err2:
-	gpio_free(GPIO_NR_PALMT5_BL_POWER);
-err:
-	return ret;
-}
-
-static int palmt5_backlight_notify(struct device *dev, int brightness)
-{
-	gpio_set_value(GPIO_NR_PALMT5_BL_POWER, brightness);
-	gpio_set_value(GPIO_NR_PALMT5_LCD_POWER, brightness);
-	return brightness;
-}
-
-static void palmt5_backlight_exit(struct device *dev)
-{
-	gpio_free(GPIO_NR_PALMT5_BL_POWER);
-	gpio_free(GPIO_NR_PALMT5_LCD_POWER);
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
-	.gpio_pwdown		= GPIO_NR_PALMT5_IR_DISABLE,
-	.transceiver_cap	= IR_SIRMODE | IR_OFF,
-};
-
-/******************************************************************************
- * UDC
- ******************************************************************************/
-static struct gpio_vbus_mach_info palmt5_udc_info = {
-	.gpio_vbus		= GPIO_NR_PALMT5_USB_DETECT_N,
-	.gpio_vbus_inverted	= 1,
-	.gpio_pullup		= GPIO_NR_PALMT5_USB_PULLUP,
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
-	ret = gpio_request(GPIO_NR_PALMT5_POWER_DETECT, "CABLE_STATE_AC");
-	if (ret)
-		goto err1;
-	ret = gpio_direction_input(GPIO_NR_PALMT5_POWER_DETECT);
-	if (ret)
-		goto err2;
-
-	return 0;
-err2:
-	gpio_free(GPIO_NR_PALMT5_POWER_DETECT);
-err1:
-	return ret;
-}
-
-static int palmt5_is_ac_online(void)
-{
-	return gpio_get_value(GPIO_NR_PALMT5_POWER_DETECT);
-}
-
-static void power_supply_exit(struct device *dev)
-{
-	gpio_free(GPIO_NR_PALMT5_POWER_DETECT);
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
-	.jack_gpio	= GPIO_NR_PALMT5_EARPHONE_DETECT,
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
+static void __init palmt5_keys_init(void)
 {
-	static u32 resume[] = {
-		0xe3a00101,	/* mov	r0,	#0x40000000 */
-		0xe380060f,	/* orr	r0, r0, #0x00f00000 */
-		0xe590f008,	/* ldr	pc, [r0, #0x08] */
-	};
-
-	/* copy the bootloader */
-	memcpy(phys_to_virt(PALMT5_STR_BASE), resume, sizeof(resume));
+	platform_device_register(&palmt5_pxa_keys);
 }
+#else
+static inline void palmt5_keys_init(void) {}
+#endif
 
 /******************************************************************************
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
-};
-
-/* setup udc GPIOs initial state */
-static void __init palmt5_udc_init(void)
-{
-	if (!gpio_request(GPIO_NR_PALMT5_USB_PULLUP, "UDC Vbus")) {
-		gpio_direction_output(GPIO_NR_PALMT5_USB_PULLUP, 1);
-		gpio_free(GPIO_NR_PALMT5_USB_PULLUP);
-	}
-}
-
 static void __init palmt5_init(void)
 {
 	pxa2xx_mfp_config(ARRAY_AND_SIZE(palmt5_pin_config));
-
 	pxa_set_ffuart_info(NULL);
 	pxa_set_btuart_info(NULL);
 	pxa_set_stuart_info(NULL);
 
-	palmt5_pm_init();
-	set_pxa_fb_info(&palmt5_lcd_screen);
-	pxa_set_mci_info(&palmt5_mci_platform_data);
-	palmt5_udc_init();
-	pxa_set_ac97_info(&palmt5_ac97_pdata);
-	pxa_set_ficp_info(&palmt5_ficp_platform_data);
-	pxa_set_keypad_info(&palmt5_keypad_platform_data);
-
-	platform_add_devices(devices, ARRAY_SIZE(devices));
+	palm27x_mmc_init(GPIO_NR_PALMT5_SD_DETECT_N, GPIO_NR_PALMT5_SD_READONLY,
+			GPIO_NR_PALMT5_SD_POWER, 0);
+	palm27x_pm_init(PALMT5_STR_BASE);
+	palm27x_lcd_init(-1, &palm_320x480_lcd_mode);
+	palm27x_udc_init(GPIO_NR_PALMT5_USB_DETECT_N,
+			GPIO_NR_PALMT5_USB_PULLUP, 1);
+	palm27x_irda_init(GPIO_NR_PALMT5_IR_DISABLE);
+	palm27x_ac97_init(PALMT5_BAT_MIN_VOLTAGE, PALMT5_BAT_MAX_VOLTAGE,
+			GPIO_NR_PALMT5_EARPHONE_DETECT, 95);
+	palm27x_pwm_init(GPIO_NR_PALMT5_BL_POWER, GPIO_NR_PALMT5_LCD_POWER);
+	palm27x_power_init(GPIO_NR_PALMT5_POWER_DETECT, -1);
+	palm27x_pmic_init();
+	palmt5_kpc_init();
+	palmt5_keys_init();
 }
 
 MACHINE_START(PALMT5, "Palm Tungsten|T5")
diff --git a/arch/arm/mach-pxa/palmtreo.c b/arch/arm/mach-pxa/palmtreo.c
index 4eb0258..08dd89e 100644
--- a/arch/arm/mach-pxa/palmtreo.c
+++ b/arch/arm/mach-pxa/palmtreo.c
@@ -44,6 +44,7 @@
 #include <mach/pxa2xx-regs.h>
 #include <mach/palmasoc.h>
 #include <mach/camera.h>
+#include <mach/palm27x.h>
 
 #include <sound/pxa2xx-lib.h>
 
@@ -158,31 +159,9 @@ static unsigned long centro685_pin_config[] __initdata = {
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
-#ifdef CONFIG_MACH_TREO680
+#if defined(CONFIG_KEYBOARD_PXA27x) || defined(CONFIG_KEYBOARD_PXA27x_MODULE)
 static unsigned int treo680_matrix_keys[] = {
 	KEY(0, 0, KEY_F8),		/* Red/Off/Power */
 	KEY(0, 1, KEY_LEFT),
@@ -242,19 +221,6 @@ static unsigned int treo680_matrix_keys[] = {
 	KEY(7, 5, KEY_I),
 };
 
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
-#endif /* CONFIG_MACH_TREO680 */
-
-#ifdef CONFIG_MACH_CENTRO
 static unsigned int centro_matrix_keys[] = {
 	KEY(0, 0, KEY_F9),		/* Home */
 	KEY(0, 1, KEY_LEFT),
@@ -314,157 +280,50 @@ static unsigned int centro_matrix_keys[] = {
 	KEY(7, 5, KEY_I),
 };
 
-static struct pxa27x_keypad_platform_data centro_keypad_platform_data = {
+static struct pxa27x_keypad_platform_data treo680_keypad_pdata = {
 	.matrix_key_rows	= 8,
 	.matrix_key_cols	= 7,
-	.matrix_key_map		= centro_matrix_keys,
-	.matrix_key_map_size	= ARRAY_SIZE(centro_matrix_keys),
+	.matrix_key_map		= treo680_matrix_keys,
+	.matrix_key_map_size	= ARRAY_SIZE(treo680_matrix_keys),
 	.direct_key_map		= { KEY_CONNECT },
 	.direct_key_num		= 1,
 
 	.debounce_interval	= 30,
 };
-#endif /* CONFIG_MACH_CENTRO */
 
-/******************************************************************************
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
+static void __init palmtreo_kpc_init(void)
 {
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
+	static struct pxa27x_keypad_platform_data *data = &treo680_keypad_pdata;
 
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
+	if (machine_is_centro()) {
+		data->matrix_key_map = centro_matrix_keys;
+		data->matrix_key_map_size = ARRAY_SIZE(centro_matrix_keys);
+	}
 
-static void treo_backlight_exit(struct device *dev)
-{
-	gpio_free(GPIO_NR_TREO_BL_POWER);
+	pxa_set_keypad_info(&treo680_keypad_pdata);
 }
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
+#else
+static inline void palmtreo_kpc_init(void) {}
+#endif
 
 /******************************************************************************
  * USB host
  ******************************************************************************/
-#ifdef CONFIG_MACH_TREO680
+#if defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE)
 static struct pxaohci_platform_data treo680_ohci_info = {
 	.port_mode    = PMM_PERPORT_MODE,
 	.flags        = ENABLE_PORT1 | ENABLE_PORT3,
 	.power_budget = 0,
 };
-#endif /* CONFIG_MACH_TREO680 */
 
-/******************************************************************************
- * Power supply
- ******************************************************************************/
-static int power_supply_init(struct device *dev)
+static void __init palmtreo_uhc_init(void)
 {
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
+	if (machine_is_treo680())
+		pxa_set_ohci_info(&treo680_ohci_info);
 }
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
+#else
+static inline void palmtreo_uhc_init(void) {}
+#endif
 
 /******************************************************************************
  * Vibra and LEDs
@@ -493,16 +352,6 @@ static struct gpio_led_platform_data treo680_gpio_led_info = {
 	.num_leds	= ARRAY_SIZE(treo680_gpio_leds),
 };
 
-static struct platform_device treo680_leds = {
-	.name   = "leds-gpio",
-	.id     = -1,
-	.dev    = {
-		.platform_data  = &treo680_gpio_led_info,
-	}
-};
-#endif /* CONFIG_MACH_TREO680 */
-
-#ifdef CONFIG_MACH_CENTRO
 static struct gpio_led centro_gpio_leds[] = {
 	{
 		.name			= "centro:vibra:vibra",
@@ -527,139 +376,61 @@ static struct gpio_led_platform_data centro_gpio_led_info = {
 	.num_leds	= ARRAY_SIZE(centro_gpio_leds),
 };
 
-static struct platform_device centro_leds = {
+static struct platform_device palmtreo_leds = {
 	.name   = "leds-gpio",
 	.id     = -1,
 	.dev    = {
-		.platform_data  = &centro_gpio_led_info,
+		.platform_data  = &treo680_gpio_led_info,
 	}
 };
-#endif /* CONFIG_MACH_CENTRO */
-
-/******************************************************************************
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
 
-static void treo_lcd_power(int on, struct fb_var_screeninfo *info)
+static void __init palmtreo_leds_init(void)
 {
-	gpio_set_value(GPIO_NR_TREO_BL_POWER, on);
-}
-
-static struct pxafb_mach_info treo_lcd_screen = {
-	.modes		= treo_lcd_modes,
-	.num_modes	= ARRAY_SIZE(treo_lcd_modes),
-	.lcd_conn	= LCD_COLOR_TFT_16BPP | LCD_PCLK_EDGE_FALL,
-};
+	if (machine_is_centro())
+		palmtreo_leds.dev.platform_data = &centro_gpio_led_info;
 
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
+	platform_device_register(&palmtreo_leds);
 }
+#else
+static inline void palmtreo_leds_init(void) {}
+#endif
 
 /******************************************************************************
  * Machine init
  ******************************************************************************/
-static struct platform_device *treo_devices[] __initdata = {
-	&treo_backlight,
-	&power_supply,
-};
-
-#ifdef CONFIG_MACH_TREO680
-static struct platform_device *treo680_devices[] __initdata = {
-	&treo680_leds,
-};
-#endif /* CONFIG_MACH_TREO680 */
-
-#ifdef CONFIG_MACH_CENTRO
-static struct platform_device *centro_devices[] __initdata = {
-	&centro_leds,
-};
-#endif /* CONFIG_MACH_CENTRO */
-
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
+static void __init palmphone_common_init(void)
 {
+	pxa2xx_mfp_config(ARRAY_AND_SIZE(treo_pin_config));
 	pxa_set_ffuart_info(NULL);
 	pxa_set_btuart_info(NULL);
 	pxa_set_stuart_info(NULL);
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
+	palm27x_pm_init(TREO_STR_BASE);
+	palm27x_lcd_init(GPIO_NR_TREO_BL_POWER, &palm_320x320_new_lcd_mode);
+	palm27x_udc_init(GPIO_NR_TREO_USB_DETECT, GPIO_NR_TREO_USB_PULLUP, 1);
+	palm27x_irda_init(GPIO_NR_TREO_IR_EN);
+	palm27x_ac97_init(-1, -1, -1, 95);
+	palm27x_pwm_init(GPIO_NR_TREO_BL_POWER, -1);
+	palm27x_power_init(GPIO_NR_TREO_POWER_DETECT, -1);
+	palm27x_pmic_init();
+	palmtreo_kpc_init();
+	palmtreo_uhc_init();
+	palmtreo_leds_init();
 }
 
-#ifdef CONFIG_MACH_TREO680
 static void __init treo680_init(void)
 {
-	treo_init();
 	pxa2xx_mfp_config(ARRAY_AND_SIZE(treo680_pin_config));
-	pxa_set_mci_info(&treo680_mci_platform_data);
-	pxa_set_keypad_info(&treo680_keypad_platform_data);
-	pxa_set_ohci_info(&treo680_ohci_info);
+	palmphone_common_init();
+	palm27x_mmc_init(GPIO_NR_TREO_SD_DETECT_N, GPIO_NR_TREO680_SD_READONLY,
+			GPIO_NR_TREO680_SD_POWER, 0);
+}
 
-	platform_add_devices(ARRAY_AND_SIZE(treo680_devices));
+static void __init centro_init(void)
+{
+	pxa2xx_mfp_config(ARRAY_AND_SIZE(centro685_pin_config));
+	palmphone_common_init();
+	palm27x_mmc_init(GPIO_NR_TREO_SD_DETECT_N, -1,
+			GPIO_NR_CENTRO_SD_POWER, 1);
 }
 
 MACHINE_START(TREO680, "Palm Treo 680")
@@ -669,21 +440,8 @@ MACHINE_START(TREO680, "Palm Treo 680")
 	.map_io         = pxa_map_io,
 	.init_irq       = pxa27x_init_irq,
 	.timer          = &pxa_timer,
-	.init_machine   = treo680_init,
+	.init_machine   = palmtreo_init,
 MACHINE_END
-#endif /* CONFIG_MACH_TREO680 */
-
-#ifdef CONFIG_MACH_CENTRO
-static void __init centro_init(void)
-{
-	treo_init();
-	pxa2xx_mfp_config(ARRAY_AND_SIZE(centro685_pin_config));
-	pxa_set_mci_info(&centro_mci_platform_data);
-
-	pxa_set_keypad_info(&centro_keypad_platform_data);
-
-	platform_add_devices(ARRAY_AND_SIZE(centro_devices));
-}
 
 MACHINE_START(CENTRO, "Palm Centro 685")
 	.phys_io        = TREO_PHYS_IO_START,
@@ -692,6 +450,5 @@ MACHINE_START(CENTRO, "Palm Centro 685")
 	.map_io         = pxa_map_io,
 	.init_irq       = pxa27x_init_irq,
 	.timer          = &pxa_timer,
-       .init_machine   = centro_init,
+       .init_machine	= palmtreo_init,
 MACHINE_END
-#endif /* CONFIG_MACH_CENTRO */
diff --git a/arch/arm/mach-pxa/palmtx.c b/arch/arm/mach-pxa/palmtx.c
index a5429cd..144dc2b 100644
--- a/arch/arm/mach-pxa/palmtx.c
+++ b/arch/arm/mach-pxa/palmtx.c
@@ -46,6 +46,7 @@
 #include <mach/pxa27x_keypad.h>
 #include <mach/udc.h>
 #include <mach/palmasoc.h>
+#include <mach/palm27x.h>
 
 #include "generic.h"
 #include "devices.h"
@@ -129,6 +130,7 @@ static unsigned long palmtx_pin_config[] __initdata = {
 /******************************************************************************
  * NOR Flash
  ******************************************************************************/
+#if defined(CONFIG_MTD_PHYSMAP) || defined(CONFIG_MTD_PHYSMAP_MODULE)
 static struct mtd_partition palmtx_partitions[] = {
 	{
 		.name		= "Flash",
@@ -162,20 +164,18 @@ static struct platform_device palmtx_flash = {
 	},
 };
 
-/******************************************************************************
- * SD/MMC card controller
- ******************************************************************************/
-static struct pxamci_platform_data palmtx_mci_platform_data = {
-	.ocr_mask		= MMC_VDD_32_33 | MMC_VDD_33_34,
-	.gpio_card_detect	= GPIO_NR_PALMTX_SD_DETECT_N,
-	.gpio_card_ro		= GPIO_NR_PALMTX_SD_READONLY,
-	.gpio_power		= GPIO_NR_PALMTX_SD_POWER,
-	.detect_delay_ms	= 200,
-};
+static void __init palmtx_nor_init(void)
+{
+	platform_device_register(&palmtx_flash);
+}
+#else
+static inline void palmtx_nor_init(void) {}
+#endif
 
 /******************************************************************************
  * GPIO keyboard
  ******************************************************************************/
+#if defined(CONFIG_KEYBOARD_PXA27x) || defined(CONFIG_KEYBOARD_PXA27x_MODULE)
 static unsigned int palmtx_matrix_keys[] = {
 	KEY(0, 0, KEY_POWER),
 	KEY(0, 1, KEY_F1),
@@ -201,9 +201,18 @@ static struct pxa27x_keypad_platform_data palmtx_keypad_platform_data = {
 	.debounce_interval	= 30,
 };
 
+static void __init palmtx_kpc_init(void)
+{
+	pxa_set_keypad_info(&palmtx_keypad_platform_data);
+}
+#else
+static inline void palmtx_kpc_init(void) {}
+#endif
+
 /******************************************************************************
  * GPIO keys
  ******************************************************************************/
+#if defined(CONFIG_KEYBOARD_GPIO) || defined(CONFIG_KEYBOARD_GPIO_MODULE)
 static struct gpio_keys_button palmtx_pxa_buttons[] = {
 	{KEY_F8, GPIO_NR_PALMTX_HOTSYNC_BUTTON_N, 1, "HotSync Button" },
 };
@@ -221,210 +230,18 @@ static struct platform_device palmtx_pxa_keys = {
 	},
 };
 
-/******************************************************************************
- * Backlight
- ******************************************************************************/
-static int palmtx_backlight_init(struct device *dev)
-{
-	int ret;
-
-	ret = gpio_request(GPIO_NR_PALMTX_BL_POWER, "BL POWER");
-	if (ret)
-		goto err;
-	ret = gpio_direction_output(GPIO_NR_PALMTX_BL_POWER, 0);
-	if (ret)
-		goto err2;
-	ret = gpio_request(GPIO_NR_PALMTX_LCD_POWER, "LCD POWER");
-	if (ret)
-		goto err2;
-	ret = gpio_direction_output(GPIO_NR_PALMTX_LCD_POWER, 0);
-	if (ret)
-		goto err3;
-
-	return 0;
-err3:
-	gpio_free(GPIO_NR_PALMTX_LCD_POWER);
-err2:
-	gpio_free(GPIO_NR_PALMTX_BL_POWER);
-err:
-	return ret;
-}
-
-static int palmtx_backlight_notify(struct device *dev, int brightness)
-{
-	gpio_set_value(GPIO_NR_PALMTX_BL_POWER, brightness);
-	gpio_set_value(GPIO_NR_PALMTX_LCD_POWER, brightness);
-	return brightness;
-}
-
-static void palmtx_backlight_exit(struct device *dev)
-{
-	gpio_free(GPIO_NR_PALMTX_BL_POWER);
-	gpio_free(GPIO_NR_PALMTX_LCD_POWER);
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
-	.gpio_pwdown		= GPIO_NR_PALMTX_IR_DISABLE,
-	.transceiver_cap	= IR_SIRMODE | IR_OFF,
-};
-
-/******************************************************************************
- * UDC
- ******************************************************************************/
-static struct gpio_vbus_mach_info palmtx_udc_info = {
-	.gpio_vbus		= GPIO_NR_PALMTX_USB_DETECT_N,
-	.gpio_vbus_inverted	= 1,
-	.gpio_pullup		= GPIO_NR_PALMTX_USB_PULLUP,
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
-	ret = gpio_request(GPIO_NR_PALMTX_POWER_DETECT, "CABLE_STATE_AC");
-	if (ret)
-		goto err1;
-	ret = gpio_direction_input(GPIO_NR_PALMTX_POWER_DETECT);
-	if (ret)
-		goto err2;
-
-	return 0;
-
-err2:
-	gpio_free(GPIO_NR_PALMTX_POWER_DETECT);
-err1:
-	return ret;
-}
-
-static int palmtx_is_ac_online(void)
-{
-	return gpio_get_value(GPIO_NR_PALMTX_POWER_DETECT);
-}
-
-static void power_supply_exit(struct device *dev)
+static void __init palmtx_keys_init(void)
 {
-	gpio_free(GPIO_NR_PALMTX_POWER_DETECT);
+	platform_device_register(&palmtx_pxa_keys);
 }
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
-	.jack_gpio	= GPIO_NR_PALMTX_EARPHONE_DETECT,
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
+#else
+static inline void palmtx_keys_init(void) {}
+#endif
 
 /******************************************************************************
  * NAND Flash
  ******************************************************************************/
+#if defined(CONFIG_MTD_NAND_GPIO) || defined(CONFIG_MTD_NAND_GPIO_MODULE)
 static void palmtx_nand_cmd_ctl(struct mtd_info *mtd, int cmd,
 				 unsigned int ctrl)
 {
@@ -484,36 +301,17 @@ static struct platform_device palmtx_nand = {
 	}
 };
 
-/******************************************************************************
- * Power management - standby
- ******************************************************************************/
-static void __init palmtx_pm_init(void)
+static void __init palmtx_nand_init(void)
 {
-	static u32 resume[] = {
-		0xe3a00101,	/* mov	r0,	#0x40000000 */
-		0xe380060f,	/* orr	r0, r0, #0x00f00000 */
-		0xe590f008,	/* ldr	pc, [r0, #0x08] */
-	};
-
-	/* copy the bootloader */
-	memcpy(phys_to_virt(PALMTX_STR_BASE), resume, sizeof(resume));
+	platform_device_register(&palmtx_nand);
 }
+#else
+static inline void palmtx_nand_init(void) {}
+#endif
 
 /******************************************************************************
  * Machine init
  ******************************************************************************/
-static struct platform_device *devices[] __initdata = {
-#if defined(CONFIG_KEYBOARD_GPIO) || defined(CONFIG_KEYBOARD_GPIO_MODULE)
-	&palmtx_pxa_keys,
-#endif
-	&palmtx_backlight,
-	&power_supply,
-	&palmtx_asoc,
-	&palmtx_gpio_vbus,
-	&palmtx_flash,
-	&palmtx_nand,
-};
-
 static struct map_desc palmtx_io_desc[] __initdata = {
 {
 	.virtual	= PALMTX_PCMCIA_VIRT,
@@ -539,33 +337,29 @@ static void __init palmtx_map_io(void)
 	iotable_init(palmtx_io_desc, ARRAY_SIZE(palmtx_io_desc));
 }
 
-/* setup udc GPIOs initial state */
-static void __init palmtx_udc_init(void)
-{
-	if (!gpio_request(GPIO_NR_PALMTX_USB_PULLUP, "UDC Vbus")) {
-		gpio_direction_output(GPIO_NR_PALMTX_USB_PULLUP, 1);
-		gpio_free(GPIO_NR_PALMTX_USB_PULLUP);
-	}
-}
-
-
 static void __init palmtx_init(void)
 {
 	pxa2xx_mfp_config(ARRAY_AND_SIZE(palmtx_pin_config));
-
 	pxa_set_ffuart_info(NULL);
 	pxa_set_btuart_info(NULL);
 	pxa_set_stuart_info(NULL);
 
-	palmtx_pm_init();
-	set_pxa_fb_info(&palmtx_lcd_screen);
-	pxa_set_mci_info(&palmtx_mci_platform_data);
-	palmtx_udc_init();
-	pxa_set_ac97_info(&palmtx_ac97_pdata);
-	pxa_set_ficp_info(&palmtx_ficp_platform_data);
-	pxa_set_keypad_info(&palmtx_keypad_platform_data);
-
-	platform_add_devices(devices, ARRAY_SIZE(devices));
+	palm27x_mmc_init(GPIO_NR_PALMTX_SD_DETECT_N, GPIO_NR_PALMTX_SD_READONLY,
+			GPIO_NR_PALMTX_SD_POWER, 0);
+	palm27x_pm_init(PALMTX_STR_BASE);
+	palm27x_lcd_init(-1, &palm_320x480_lcd_mode);
+	palm27x_udc_init(GPIO_NR_PALMTX_USB_DETECT_N,
+			GPIO_NR_PALMTX_USB_PULLUP, 1);
+	palm27x_irda_init(GPIO_NR_PALMTX_IR_DISABLE);
+	palm27x_ac97_init(PALMTX_BAT_MIN_VOLTAGE, PALMTX_BAT_MAX_VOLTAGE,
+			GPIO_NR_PALMTX_EARPHONE_DETECT, 95);
+	palm27x_pwm_init(GPIO_NR_PALMTX_BL_POWER, GPIO_NR_PALMTX_LCD_POWER);
+	palm27x_power_init(GPIO_NR_PALMTX_POWER_DETECT, -1);
+	palm27x_pmic_init();
+	palmtx_kpc_init();
+	palmtx_keys_init();
+	palmtx_nor_init();
+	palmtx_nand_init();
 }
 
 MACHINE_START(PALMTX, "Palm T|X")
diff --git a/arch/arm/mach-pxa/palmz72.c b/arch/arm/mach-pxa/palmz72.c
index b78c6b4..87e4b10 100644
--- a/arch/arm/mach-pxa/palmz72.c
+++ b/arch/arm/mach-pxa/palmz72.c
@@ -44,6 +44,7 @@
 #include <mach/pxa27x_keypad.h>
 #include <mach/udc.h>
 #include <mach/palmasoc.h>
+#include <mach/palm27x.h>
 
 #include <mach/pm.h>
 
@@ -109,21 +110,9 @@ static unsigned long palmz72_pin_config[] __initdata = {
 };
 
 /******************************************************************************
- * SD/MMC card controller
- ******************************************************************************/
-/* SD_POWER is not actually power, but it is more like chip
- * select, i.e. it is inverted */
-static struct pxamci_platform_data palmz72_mci_platform_data = {
-	.ocr_mask		= MMC_VDD_32_33 | MMC_VDD_33_34,
-	.gpio_card_detect	= GPIO_NR_PALMZ72_SD_DETECT_N,
-	.gpio_card_ro		= GPIO_NR_PALMZ72_SD_RO,
-	.gpio_power		= GPIO_NR_PALMZ72_SD_POWER_N,
-	.gpio_power_invert	= 1,
-};
-
-/******************************************************************************
  * GPIO keyboard
  ******************************************************************************/
+#if defined(CONFIG_KEYBOARD_PXA27x) || defined(CONFIG_KEYBOARD_PXA27x_MODULE)
 static unsigned int palmz72_matrix_keys[] = {
 	KEY(0, 0, KEY_POWER),
 	KEY(0, 1, KEY_F1),
@@ -149,77 +138,18 @@ static struct pxa27x_keypad_platform_data palmz72_keypad_platform_data = {
 	.debounce_interval	= 30,
 };
 
-/******************************************************************************
- * Backlight
- ******************************************************************************/
-static int palmz72_backlight_init(struct device *dev)
+static void __init palmz72_kpc_init(void)
 {
-	int ret;
-
-	ret = gpio_request(GPIO_NR_PALMZ72_BL_POWER, "BL POWER");
-	if (ret)
-		goto err;
-	ret = gpio_direction_output(GPIO_NR_PALMZ72_BL_POWER, 0);
-	if (ret)
-		goto err2;
-	ret = gpio_request(GPIO_NR_PALMZ72_LCD_POWER, "LCD POWER");
-	if (ret)
-		goto err2;
-	ret = gpio_direction_output(GPIO_NR_PALMZ72_LCD_POWER, 0);
-	if (ret)
-		goto err3;
-
-	return 0;
-err3:
-	gpio_free(GPIO_NR_PALMZ72_LCD_POWER);
-err2:
-	gpio_free(GPIO_NR_PALMZ72_BL_POWER);
-err:
-	return ret;
-}
-
-static int palmz72_backlight_notify(struct device *dev, int brightness)
-{
-	gpio_set_value(GPIO_NR_PALMZ72_BL_POWER, brightness);
-	gpio_set_value(GPIO_NR_PALMZ72_LCD_POWER, brightness);
-	return brightness;
-}
-
-static void palmz72_backlight_exit(struct device *dev)
-{
-	gpio_free(GPIO_NR_PALMZ72_BL_POWER);
-	gpio_free(GPIO_NR_PALMZ72_LCD_POWER);
+	pxa_set_keypad_info(&palmz72_keypad_platform_data);
 }
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
-	.gpio_pwdown		= GPIO_NR_PALMZ72_IR_DISABLE,
-	.transceiver_cap	= IR_SIRMODE | IR_OFF,
-};
+#else
+static inline void palmz72_kpc_init(void) {}
+#endif
 
 /******************************************************************************
  * LEDs
  ******************************************************************************/
+#if defined(CONFIG_LEDS_GPIO) || defined(CONFIG_LEDS_GPIO_MODULE)
 static struct gpio_led gpio_leds[] = {
 	{
 		.name			= "palmz72:green:led",
@@ -241,144 +171,13 @@ static struct platform_device palmz72_leds = {
 	}
 };
 
-/******************************************************************************
- * UDC
- ******************************************************************************/
-static struct gpio_vbus_mach_info palmz72_udc_info = {
-	.gpio_vbus		= GPIO_NR_PALMZ72_USB_DETECT_N,
-	.gpio_pullup		= GPIO_NR_PALMZ72_USB_PULLUP,
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
-	ret = gpio_request(GPIO_NR_PALMZ72_POWER_DETECT, "CABLE_STATE_AC");
-	if (ret)
-		goto err1;
-	ret = gpio_direction_input(GPIO_NR_PALMZ72_POWER_DETECT);
-	if (ret)
-		goto err2;
-
-	ret = gpio_request(GPIO_NR_PALMZ72_USB_DETECT_N, "CABLE_STATE_USB");
-	if (ret)
-		goto err2;
-	ret = gpio_direction_input(GPIO_NR_PALMZ72_USB_DETECT_N);
-	if (ret)
-		goto err3;
-
-	return 0;
-err3:
-	gpio_free(GPIO_NR_PALMZ72_USB_DETECT_N);
-err2:
-	gpio_free(GPIO_NR_PALMZ72_POWER_DETECT);
-err1:
-	return ret;
-}
-
-static int palmz72_is_ac_online(void)
-{
-	return gpio_get_value(GPIO_NR_PALMZ72_POWER_DETECT);
-}
-
-static int palmz72_is_usb_online(void)
+static void __init palmz72_leds_init(void)
 {
-	return !gpio_get_value(GPIO_NR_PALMZ72_USB_DETECT_N);
+	platform_device_register(&palmz72_leds);
 }
-
-static void power_supply_exit(struct device *dev)
-{
-	gpio_free(GPIO_NR_PALMZ72_USB_DETECT_N);
-	gpio_free(GPIO_NR_PALMZ72_POWER_DETECT);
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
+#else
+static inline void palmz72_leds_init(void) {}
+#endif
 
 #ifdef CONFIG_PM
 
@@ -457,39 +256,26 @@ device_initcall(palmz72_pm_init);
 /******************************************************************************
  * Machine init
  ******************************************************************************/
-static struct platform_device *devices[] __initdata = {
-	&palmz72_backlight,
-	&palmz72_leds,
-	&palmz72_asoc,
-	&power_supply,
-	&palmz72_gpio_vbus,
-};
-
-/* setup udc GPIOs initial state */
-static void __init palmz72_udc_init(void)
-{
-	if (!gpio_request(GPIO_NR_PALMZ72_USB_PULLUP, "USB Pullup")) {
-		gpio_direction_output(GPIO_NR_PALMZ72_USB_PULLUP, 0);
-		gpio_free(GPIO_NR_PALMZ72_USB_PULLUP);
-	}
-}
-
 static void __init palmz72_init(void)
 {
 	pxa2xx_mfp_config(ARRAY_AND_SIZE(palmz72_pin_config));
-
 	pxa_set_ffuart_info(NULL);
 	pxa_set_btuart_info(NULL);
 	pxa_set_stuart_info(NULL);
 
-	set_pxa_fb_info(&palmz72_lcd_screen);
-	pxa_set_mci_info(&palmz72_mci_platform_data);
-	palmz72_udc_init();
-	pxa_set_ac97_info(&palmz72_ac97_pdata);
-	pxa_set_ficp_info(&palmz72_ficp_platform_data);
-	pxa_set_keypad_info(&palmz72_keypad_platform_data);
-
-	platform_add_devices(devices, ARRAY_SIZE(devices));
+	palm27x_mmc_init(GPIO_NR_PALMZ72_SD_DETECT_N, GPIO_NR_PALMZ72_SD_RO,
+			GPIO_NR_PALMZ72_SD_POWER_N, 1);
+	palm27x_lcd_init(-1, &palm_320x320_lcd_mode);
+	palm27x_udc_init(GPIO_NR_PALMZ72_USB_DETECT_N,
+			GPIO_NR_PALMZ72_USB_PULLUP, 0);
+	palm27x_irda_init(GPIO_NR_PALMZ72_IR_DISABLE);
+	palm27x_ac97_init(PALMZ72_BAT_MIN_VOLTAGE, PALMZ72_BAT_MAX_VOLTAGE,
+			-1, 113);
+	palm27x_pwm_init(-1, -1);
+	palm27x_power_init(-1, -1);
+	palm27x_pmic_init();
+	palmz72_kpc_init();
+	palmz72_leds_init();
 }
 
 MACHINE_START(PALMZ72, "Palm Zire72")
-- 
1.7.1
