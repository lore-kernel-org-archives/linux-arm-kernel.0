From: marek.vasut@gmail.com (Marek Vasut)
Date: Wed,  3 Nov 2010 00:51:45 +0100
Subject: [PATCH 08/17] ARM: pxa: Modularize Palm Tungsten|C
In-Reply-To: <1288741914-21328-1-git-send-email-marek.vasut@gmail.com>
References: <1288741914-21328-1-git-send-email-marek.vasut@gmail.com>
Message-ID: <1288741914-21328-8-git-send-email-marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
---
 arch/arm/mach-pxa/palmtc.c |  147 ++++++++++++++++++++++++++++++++++---------
 1 files changed, 116 insertions(+), 31 deletions(-)

diff --git a/arch/arm/mach-pxa/palmtc.c b/arch/arm/mach-pxa/palmtc.c
index b8cda11..73de8c5 100644
--- a/arch/arm/mach-pxa/palmtc.c
+++ b/arch/arm/mach-pxa/palmtc.c
@@ -25,6 +25,7 @@
 #include <linux/power_supply.h>
 #include <linux/gpio_keys.h>
 #include <linux/mtd/physmap.h>
+#include <linux/usb/gpio_vbus.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -116,6 +117,7 @@ static unsigned long palmtc_pin_config[] __initdata = {
 /******************************************************************************
  * SD/MMC card controller
  ******************************************************************************/
+#if defined(CONFIG_MMC_PXA) || defined(CONFIG_MMC_PXA_MODULE)
 static struct pxamci_platform_data palmtc_mci_platform_data = {
 	.ocr_mask		= MMC_VDD_32_33 | MMC_VDD_33_34,
 	.gpio_power		= GPIO_NR_PALMTC_SD_POWER,
@@ -124,9 +126,18 @@ static struct pxamci_platform_data palmtc_mci_platform_data = {
 	.detect_delay_ms	= 200,
 };
 
+static void __init palmtc_mmc_init(void)
+{
+	pxa_set_mci_info(&palmtc_mci_platform_data);
+}
+#else
+static inline void palmtc_mmc_init(void) {}
+#endif
+
 /******************************************************************************
  * GPIO keys
  ******************************************************************************/
+#if defined(CONFIG_KEYBOARD_GPIO) || defined(CONFIG_KEYBOARD_GPIO_MODULE)
 static struct gpio_keys_button palmtc_pxa_buttons[] = {
 	{KEY_F8, GPIO_NR_PALMTC_HOTSYNC_BUTTON, 1, "HotSync Button", EV_KEY, 1},
 };
@@ -144,9 +155,18 @@ static struct platform_device palmtc_pxa_keys = {
 	},
 };
 
+static void __init palmtc_keys_init(void)
+{
+	platform_device_register(&palmtc_pxa_keys);
+}
+#else
+static inline void palmtc_keys_init(void) {}
+#endif
+
 /******************************************************************************
  * Backlight
  ******************************************************************************/
+#if defined(CONFIG_BACKLIGHT_PWM) || defined(CONFIG_BACKLIGHT_PWM_MODULE)
 static int palmtc_backlight_init(struct device *dev)
 {
 	int ret;
@@ -196,17 +216,35 @@ static struct platform_device palmtc_backlight = {
 	},
 };
 
+static void __init palmtc_pwm_init(void)
+{
+	platform_device_register(&palmtc_backlight);
+}
+#else
+static inline void palmtc_pwm_init(void) {}
+#endif
+
 /******************************************************************************
  * IrDA
  ******************************************************************************/
+#if defined(CONFIG_IRDA) || defined(CONFIG_IRDA_MODULE)
 static struct pxaficp_platform_data palmtc_ficp_platform_data = {
 	.gpio_pwdown		= GPIO_NR_PALMTC_IR_DISABLE,
 	.transceiver_cap	= IR_SIRMODE | IR_OFF,
 };
 
+static void __init palmtc_irda_init(void)
+{
+	pxa_set_ficp_info(&palmtc_ficp_platform_data);
+}
+#else
+static inline void palmtc_irda_init(void) {}
+#endif
+
 /******************************************************************************
  * Keyboard
  ******************************************************************************/
+#if defined(CONFIG_KEYBOARD_MATRIX) || defined(CONFIG_KEYBOARD_MATRIX_MODULE)
 static const uint32_t palmtc_matrix_keys[] = {
 	KEY(0, 0, KEY_F1),
 	KEY(0, 1, KEY_X),
@@ -290,27 +328,63 @@ static struct platform_device palmtc_keyboard = {
 		.platform_data = &palmtc_keypad_platform_data,
 	},
 };
+static void __init palmtc_mkp_init(void)
+{
+	platform_device_register(&palmtc_keyboard);
+}
+#else
+static inline void palmtc_mkp_init(void) {}
+#endif
 
 /******************************************************************************
  * UDC
  ******************************************************************************/
-static struct pxa2xx_udc_mach_info palmtc_udc_info __initdata = {
+#if defined(CONFIG_USB_GADGET_PXA25X)||defined(CONFIG_USB_GADGET_PXA25X_MODULE)
+static struct gpio_vbus_mach_info palmtc_udc_info = {
 	.gpio_vbus		= GPIO_NR_PALMTC_USB_DETECT_N,
 	.gpio_vbus_inverted	= 1,
 	.gpio_pullup		= GPIO_NR_PALMTC_USB_POWER,
 };
 
+static struct platform_device palmtc_gpio_vbus = {
+	.name	= "gpio-vbus",
+	.id	= -1,
+	.dev	= {
+		.platform_data	= &palmtc_udc_info,
+	},
+};
+
+static void __init palmtc_udc_init(void)
+{
+	platform_device_register(&palmtc_gpio_vbus);
+};
+#else
+static inline void palmtc_udc_init(void) {}
+#endif
+
 /******************************************************************************
  * Touchscreen / Battery / GPIO-extender
  ******************************************************************************/
-static struct platform_device palmtc_ucb1400_core = {
+#if	defined(CONFIG_TOUCHSCREEN_UCB1400) || \
+	defined(CONFIG_TOUCHSCREEN_UCB1400_MODULE)
+static struct platform_device palmtc_ucb1400_device = {
 	.name	= "ucb1400_core",
 	.id	= -1,
 };
 
+static void __init palmtc_ts_init(void)
+{
+	pxa_set_ac97_info(NULL);
+	platform_device_register(&palmtc_ucb1400_device);
+}
+#else
+static inline void palmtc_ts_init(void) {}
+#endif
+
 /******************************************************************************
  * NOR Flash
  ******************************************************************************/
+#if defined(CONFIG_MTD_PHYSMAP) || defined(CONFIG_MTD_PHYSMAP_MODULE)
 static struct resource palmtc_flash_resource = {
 	.start	= PXA_CS0_PHYS,
 	.end	= PXA_CS0_PHYS + SZ_16M - 1,
@@ -356,24 +430,33 @@ static struct platform_device palmtc_flash = {
 	},
 };
 
+static void __init palmtc_nor_init(void)
+{
+	platform_device_register(&palmtc_flash);
+}
+#else
+static inline void palmtc_nor_init(void) {}
+#endif
+
 /******************************************************************************
  * Framebuffer
  ******************************************************************************/
+#if defined(CONFIG_FB_PXA) || defined(CONFIG_FB_PXA_MODULE)
 static struct pxafb_mode_info palmtc_lcd_modes[] = {
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
+	{
+		.pixclock	= 115384,
+		.xres		= 320,
+		.yres		= 320,
+		.bpp		= 16,
+
+		.left_margin	= 27,
+		.right_margin	= 7,
+		.upper_margin	= 7,
+		.lower_margin	= 8,
+
+		.hsync_len	= 6,
+		.vsync_len	= 1,
+	},
 };
 
 static struct pxafb_mach_info palmtc_lcd_screen = {
@@ -382,17 +465,17 @@ static struct pxafb_mach_info palmtc_lcd_screen = {
 	.lcd_conn		= LCD_COLOR_TFT_16BPP | LCD_PCLK_EDGE_FALL,
 };
 
+static void __init palmtc_lcd_init(void)
+{
+	set_pxa_fb_info(&palmtc_lcd_screen);
+}
+#else
+static inline void palmtc_lcd_init(void) {}
+#endif
+
 /******************************************************************************
  * Machine init
  ******************************************************************************/
-static struct platform_device *devices[] __initdata = {
-	&palmtc_backlight,
-	&palmtc_ucb1400_core,
-	&palmtc_keyboard,
-	&palmtc_pxa_keys,
-	&palmtc_flash,
-};
-
 static void __init palmtc_init(void)
 {
 	pxa2xx_mfp_config(ARRAY_AND_SIZE(palmtc_pin_config));
@@ -402,13 +485,15 @@ static void __init palmtc_init(void)
 	pxa_set_stuart_info(NULL);
 	pxa_set_hwuart_info(NULL);
 
-	set_pxa_fb_info(&palmtc_lcd_screen);
-	pxa_set_mci_info(&palmtc_mci_platform_data);
-	pxa_set_udc_info(&palmtc_udc_info);
-	pxa_set_ac97_info(NULL);
-	pxa_set_ficp_info(&palmtc_ficp_platform_data);
-
-	platform_add_devices(devices, ARRAY_SIZE(devices));
+	palmtc_mmc_init();
+	palmtc_keys_init();
+	palmtc_pwm_init();
+	palmtc_irda_init();
+	palmtc_mkp_init();
+	palmtc_udc_init();
+	palmtc_ts_init();
+	palmtc_nor_init();
+	palmtc_lcd_init();
 };
 
 MACHINE_START(PALMTC, "Palm Tungsten|C")
-- 
1.7.2.3
