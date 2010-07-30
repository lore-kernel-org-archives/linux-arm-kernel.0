From: marek.vasut@gmail.com (Marek Vasut)
Date: Fri, 30 Jul 2010 08:34:24 +0200
Subject: [PATCH 2/6] [ARM] pxa/balloon3: Machine file cleanup
In-Reply-To: <1280471668-30955-1-git-send-email-marek.vasut@gmail.com>
References: <1280471668-30955-1-git-send-email-marek.vasut@gmail.com>
Message-ID: <1280471668-30955-2-git-send-email-marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Modularize components of the Balloon3 board.

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
---
 arch/arm/mach-pxa/balloon3.c |  354 +++++++++++++++++++++++++++---------------
 1 files changed, 231 insertions(+), 123 deletions(-)

diff --git a/arch/arm/mach-pxa/balloon3.c b/arch/arm/mach-pxa/balloon3.c
index 8adb87a..572525c 100644
--- a/arch/arm/mach-pxa/balloon3.c
+++ b/arch/arm/mach-pxa/balloon3.c
@@ -22,6 +22,7 @@
 #include <linux/fb.h>
 #include <linux/gpio.h>
 #include <linux/ioport.h>
+#include <linux/ucb1400.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
 #include <linux/types.h>
@@ -61,35 +62,136 @@ static unsigned long balloon3_pin_config[] __initdata = {
 	GPIO44_BTUART_CTS,
 	GPIO45_BTUART_RTS,
 
-	/* Wakeup GPIO */
+	/* Reset, configured as GPIO wakeup source */
 	GPIO1_GPIO | WAKEUP_ON_EDGE_BOTH,
 
-	/* NAND & IDLE LED GPIOs */
-	GPIO9_GPIO,
-	GPIO10_GPIO,
-};
+	/* LEDs */
+	GPIO9_GPIO,	/* NAND activity LED */
+	GPIO10_GPIO,	/* Heartbeat LED */
 
-/******************************************************************************
- * Audio and Touchscreen
- ******************************************************************************/
-static unsigned long balloon3_ac97_pin_config[] = {
+	/* AC97 */
 	GPIO28_AC97_BITCLK,
 	GPIO29_AC97_SDATA_IN_0,
 	GPIO30_AC97_SDATA_OUT,
 	GPIO31_AC97_SYNC,
 	GPIO113_AC97_nRESET,
+	GPIO95_GPIO,
+
+	/* MMC */
+	GPIO32_MMC_CLK,
+	GPIO92_MMC_DAT_0,
+	GPIO109_MMC_DAT_1,
+	GPIO110_MMC_DAT_2,
+	GPIO111_MMC_DAT_3,
+	GPIO112_MMC_CMD,
+
+	/* USB Host */
+	GPIO88_USBH1_PWR,
+	GPIO89_USBH1_PEN,
 };
 
 /******************************************************************************
- * Framebuffer
+ * Compatibility: Parameter parsing
  ******************************************************************************/
+static unsigned long balloon3_irq_enabled;
 
-static void balloon3_backlight_power(int on)
+static unsigned long balloon3_features_present =
+		(1 << BALLOON3_FEATURE_OHCI) | (1 << BALLOON3_FEATURE_CF) |
+		(1 << BALLOON3_FEATURE_AUDIO) |
+		(1 << BALLOON3_FEATURE_TOPPOLY);
+
+int balloon3_has(enum balloon3_features feature)
 {
-	pr_debug("%s: power is %s\n", __func__, on ? "on" : "off");
-	gpio_set_value(BALLOON3_GPIO_RUN_BACKLIGHT, on);
+	return (balloon3_features_present & (1 << feature)) ? 1 : 0;
+}
+EXPORT_SYMBOL_GPL(balloon3_has);
+
+int __init parse_balloon3_features(char *arg)
+{
+	if (!arg)
+		return 0;
+
+	return strict_strtoul(arg, 0, &balloon3_features_present);
 }
+early_param("balloon3_features", parse_balloon3_features);
 
+/******************************************************************************
+ * NOR Flash
+ ******************************************************************************/
+#if defined(CONFIG_MTD_PHYSMAP) || defined(CONFIG_MTD_PHYSMAP_MODULE)
+static struct mtd_partition balloon3_nor_partitions[] = {
+	{
+		.name		= "Flash",
+		.offset		= 0x00000000,
+		.size		= MTDPART_SIZ_FULL,
+	}
+};
+
+static struct physmap_flash_data balloon3_flash_data[] = {
+	{
+		.width		= 2,	/* bankwidth in bytes */
+		.parts		= balloon3_nor_partitions,
+		.nr_parts	= ARRAY_SIZE(balloon3_nor_partitions)
+	}
+};
+
+static struct resource balloon3_flash_resource = {
+	.start	= PXA_CS0_PHYS,
+	.end	= PXA_CS0_PHYS + SZ_64M - 1,
+	.flags	= IORESOURCE_MEM,
+};
+
+static struct platform_device balloon3_flash = {
+	.name		= "physmap-flash",
+	.id		= 0,
+	.resource	= &balloon3_flash_resource,
+	.num_resources	= 1,
+	.dev 		= {
+		.platform_data = balloon3_flash_data,
+	},
+};
+static void __init balloon3_nor_init(void)
+{
+	platform_device_register(&balloon3_flash);
+}
+#else
+static inline void balloon3_nor_init(void) {}
+#endif
+
+/******************************************************************************
+ * Audio and Touchscreen
+ ******************************************************************************/
+#if	defined(CONFIG_TOUCHSCREEN_UCB1400) || \
+	defined(CONFIG_TOUCHSCREEN_UCB1400_MODULE)
+static struct ucb1400_pdata vpac270_ucb1400_pdata = {
+	.irq		= IRQ_GPIO(BALLOON3_GPIO_CODEC_IRQ),
+};
+
+
+static struct platform_device balloon3_ucb1400_device = {
+	.name		= "ucb1400_core",
+	.id		= -1,
+	.dev		= {
+		.platform_data = &vpac270_ucb1400_pdata,
+	},
+};
+
+static void __init balloon3_ts_init(void)
+{
+	if (!balloon3_has(BALLOON3_FEATURE_AUDIO))
+		return;
+
+	pxa_set_ac97_info(NULL);
+	platform_device_register(&balloon3_ucb1400_device);
+}
+#else
+static inline void balloon3_ts_init(void) {}
+#endif
+
+/******************************************************************************
+ * Framebuffer
+ ******************************************************************************/
+#if defined(CONFIG_FB_PXA) || defined(CONFIG_FB_PXA_MODULE)
 static struct pxafb_mode_info balloon3_lcd_modes[] = {
 	{
 		.pixclock		= 38000,
@@ -106,102 +208,147 @@ static struct pxafb_mode_info balloon3_lcd_modes[] = {
 	},
 };
 
-static struct pxafb_mach_info balloon3_pxafb_info = {
+static struct pxafb_mach_info balloon3_lcd_screen = {
 	.modes			= balloon3_lcd_modes,
 	.num_modes		= ARRAY_SIZE(balloon3_lcd_modes),
 	.lcd_conn		= LCD_COLOR_TFT_16BPP | LCD_PCLK_EDGE_FALL,
-	.pxafb_backlight_power	= balloon3_backlight_power,
 };
 
-/******************************************************************************
- * SD/MMC card controller
- ******************************************************************************/
-static unsigned long balloon3_mmc_pin_config[] = {
-	GPIO32_MMC_CLK,
-	GPIO92_MMC_DAT_0,
-	GPIO109_MMC_DAT_1,
-	GPIO110_MMC_DAT_2,
-	GPIO111_MMC_DAT_3,
-	GPIO112_MMC_CMD,
-};
+static void balloon3_backlight_power(int on)
+{
+	gpio_set_value(BALLOON3_GPIO_RUN_BACKLIGHT, on);
+}
 
-static void balloon3_mci_setpower(struct device *dev, unsigned int vdd)
+static void __init balloon3_lcd_init(void)
 {
-	struct pxamci_platform_data *p_d = dev->platform_data;
-
-	if ((1 << vdd) & p_d->ocr_mask) {
-		pr_debug("%s: on\n", __func__);
-		/* FIXME something to prod here? */
-	} else {
-		pr_debug("%s: off\n", __func__);
-		/* FIXME something to prod here? */
+	int ret;
+
+	if (!balloon3_has(BALLOON3_FEATURE_TOPPOLY))
+		return;
+
+	ret = gpio_request(BALLOON3_GPIO_RUN_BACKLIGHT, "BKL-ON");
+	if (ret) {
+		pr_err("Requesting BKL-ON GPIO failed!\n");
+		goto err;
+	}
+
+	ret = gpio_direction_output(BALLOON3_GPIO_RUN_BACKLIGHT, 1);
+	if (ret) {
+		pr_err("Setting BKL-ON GPIO direction failed!\n");
+		goto err2;
 	}
+
+	balloon3_lcd_screen.pxafb_backlight_power = balloon3_backlight_power;
+	set_pxa_fb_info(&balloon3_lcd_screen);
+	return;
+
+err2:
+	gpio_free(BALLOON3_GPIO_RUN_BACKLIGHT);
+err:
+	return;
 }
+#else
+static inline void balloon3_lcd_init(void) {}
+#endif
 
+/******************************************************************************
+ * SD/MMC card controller
+ ******************************************************************************/
+#if defined(CONFIG_MMC_PXA) || defined(CONFIG_MMC_PXA_MODULE)
 static struct pxamci_platform_data balloon3_mci_platform_data = {
-	.ocr_mask	= MMC_VDD_32_33|MMC_VDD_33_34,
-	.setpower 	= balloon3_mci_setpower,
+	.ocr_mask		= MMC_VDD_32_33 | MMC_VDD_33_34,
+	.gpio_card_detect	= -1,
+	.gpio_card_ro		= -1,
+	.gpio_power		= -1,
+	.detect_delay_ms	= 200,
 };
 
+static void __init balloon3_mmc_init(void)
+{
+	pxa_set_mci_info(&balloon3_mci_platform_data);
+}
+#else
+static inline void balloon3_mmc_init(void) {}
+#endif
+
 /******************************************************************************
  * USB Gadget
  ******************************************************************************/
-static int balloon3_udc_is_connected(void)
+#if defined(CONFIG_USB_GADGET_PXA27X)||defined(CONFIG_USB_GADGET_PXA27X_MODULE)
+static void balloon3_udc_command(int cmd)
 {
-	pr_debug("%s: udc connected\n", __func__);
-	return 1;
+	if (cmd == PXA2XX_UDC_CMD_CONNECT)
+		UP2OCR |= UP2OCR_DPPUE | UP2OCR_DPPUBE;
+	else if (cmd == PXA2XX_UDC_CMD_DISCONNECT)
+		UP2OCR &= ~UP2OCR_DPPUE;
 }
 
-static void balloon3_udc_command(int cmd)
+static int balloon3_udc_is_connected(void)
 {
-	switch (cmd) {
-	case PXA2XX_UDC_CMD_CONNECT:
-		UP2OCR |= (UP2OCR_DPPUE + UP2OCR_DPPUBE);
-		pr_debug("%s: connect\n", __func__);
-		break;
-	case PXA2XX_UDC_CMD_DISCONNECT:
-		UP2OCR &= ~UP2OCR_DPPUE;
-		pr_debug("%s: disconnect\n", __func__);
-		break;
-	}
+	return 1;
 }
 
-static struct pxa2xx_udc_mach_info balloon3_udc_info = {
-	.udc_is_connected = balloon3_udc_is_connected,
-	.udc_command      = balloon3_udc_command,
+static struct pxa2xx_udc_mach_info balloon3_udc_info __initdata = {
+	.udc_command		= balloon3_udc_command,
+	.udc_is_connected	= balloon3_udc_is_connected,
+	.gpio_pullup		= -1,
 };
 
+static void __init balloon3_udc_init(void)
+{
+	pxa_set_udc_info(&balloon3_udc_info);
+	platform_device_register(&balloon3_gpio_vbus);
+}
+#else
+static inline void balloon3_udc_init(void) {}
+#endif
+
 /******************************************************************************
  * IrDA
  ******************************************************************************/
+#if defined(CONFIG_IRDA) || defined(CONFIG_IRDA_MODULE)
 static struct pxaficp_platform_data balloon3_ficp_platform_data = {
-	.transceiver_cap  = IR_SIRMODE | IR_FIRMODE | IR_OFF,
+	.transceiver_cap	= IR_FIRMODE | IR_SIRMODE | IR_OFF,
 };
 
+static void __init balloon3_irda_init(void)
+{
+	pxa_set_ficp_info(&balloon3_ficp_platform_data);
+}
+#else
+static inline void balloon3_irda_init(void) {}
+#endif
+
 /******************************************************************************
  * USB Host
  ******************************************************************************/
-static unsigned long balloon3_ohci_pin_config[] = {
-	GPIO88_USBH1_PWR,
-	GPIO89_USBH1_PEN,
-};
-
-static struct pxaohci_platform_data balloon3_ohci_platform_data = {
+#if defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE)
+static struct pxaohci_platform_data balloon3_ohci_info = {
 	.port_mode	= PMM_PERPORT_MODE,
 	.flags		= ENABLE_PORT_ALL | POWER_CONTROL_LOW | POWER_SENSE_LOW,
 };
 
+static void __init balloon3_uhc_init(void)
+{
+	if (!balloon3_has(BALLOON3_FEATURE_OHCI))
+		return;
+	pxa_set_ohci_info(&balloon3_ohci_info);
+}
+#else
+static inline void balloon3_uhc_init(void) {}
+#endif
+
 /******************************************************************************
- * LED
+ * LEDs
  ******************************************************************************/
-static struct gpio_led balloon3_gpio_leds[] = {
+#if defined(CONFIG_LEDS_GPIO) || defined(CONFIG_LEDS_GPIO_MODULE)
+struct gpio_led balloon3_gpio_leds[] = {
 	{
 		.name			= "balloon3:green:idle",
 		.default_trigger	= "heartbeat",
 		.gpio			= BALLOON3_GPIO_LED_IDLE,
 		.active_low		= 1,
-	},
-	{
+	}, {
 		.name			= "balloon3:green:nand",
 		.default_trigger	= "nand-disk",
 		.gpio			= BALLOON3_GPIO_LED_NAND,
@@ -209,43 +356,26 @@ static struct gpio_led balloon3_gpio_leds[] = {
 	},
 };
 
-static struct gpio_led_platform_data balloon3_gpio_leds_platform_data = {
+static struct gpio_led_platform_data balloon3_gpio_led_info = {
 	.leds		= balloon3_gpio_leds,
 	.num_leds	= ARRAY_SIZE(balloon3_gpio_leds),
 };
 
-static struct platform_device balloon3led_device = {
+static struct platform_device balloon3_leds = {
 	.name	= "leds-gpio",
 	.id	= -1,
 	.dev	= {
-		.platform_data	= &balloon3_gpio_leds_platform_data,
-	},
+		.platform_data	= &balloon3_gpio_led_info,
+	}
 };
 
-/******************************************************************************
- * Compatibility: Parameter parsing
- ******************************************************************************/
-static unsigned long balloon3_irq_enabled;
-
-static unsigned long balloon3_features_present =
-		(1 << BALLOON3_FEATURE_OHCI) | (1 << BALLOON3_FEATURE_CF) |
-		(1 << BALLOON3_FEATURE_AUDIO) |
-		(1 << BALLOON3_FEATURE_TOPPOLY);
-
-int balloon3_has(enum balloon3_features feature)
+static void __init balloon3_leds_init(void)
 {
-	return (balloon3_features_present & (1 << feature)) ? 1 : 0;
+	platform_device_register(&balloon3_leds);
 }
-EXPORT_SYMBOL_GPL(balloon3_has);
-
-int __init parse_balloon3_features(char *arg)
-{
-	if (!arg)
-		return 0;
-
-	return strict_strtoul(arg, 0, &balloon3_features_present);
-}
-early_param("balloon3_features", parse_balloon3_features);
+#else
+static inline void balloon3_leds_init(void) {}
+#endif
 
 /******************************************************************************
  * FPGA IRQ
@@ -314,46 +444,24 @@ static void __init balloon3_init_irq(void)
  ******************************************************************************/
 static void __init balloon3_init(void)
 {
-	pr_info("Initialising Balloon3\n");
-
-	/* system bus arbiter setting
-	 * - Core_Park
-	 * - LCD_wt:DMA_wt:CORE_Wt = 2:3:4
-	 */
 	ARB_CNTRL = ARB_CORE_PARK | 0x234;
 
+	pxa2xx_mfp_config(ARRAY_AND_SIZE(balloon3_pin_config));
+
 	pxa_set_ffuart_info(NULL);
 	pxa_set_btuart_info(NULL);
 	pxa_set_stuart_info(NULL);
 
 	pxa_set_i2c_info(NULL);
-	if (balloon3_has(BALLOON3_FEATURE_AUDIO)) {
-		pxa2xx_mfp_config(ARRAY_AND_SIZE(balloon3_ac97_pin_config));
-		pxa_set_ac97_info(NULL);
-	}
-
-	if (balloon3_has(BALLOON3_FEATURE_TOPPOLY)) {
-		pxa2xx_mfp_config(ARRAY_AND_SIZE(balloon3_lcd_pin_config));
-		gpio_request(BALLOON3_GPIO_RUN_BACKLIGHT,
-			"LCD Backlight Power");
-		gpio_direction_output(BALLOON3_GPIO_RUN_BACKLIGHT, 1);
-		set_pxa_fb_info(&balloon3_pxafb_info);
-	}
-
-	if (balloon3_has(BALLOON3_FEATURE_MMC)) {
-		pxa2xx_mfp_config(ARRAY_AND_SIZE(balloon3_mmc_pin_config));
-		pxa_set_mci_info(&balloon3_mci_platform_data);
-	}
-	pxa_set_ficp_info(&balloon3_ficp_platform_data);
-	if (balloon3_has(BALLOON3_FEATURE_OHCI)) {
-		pxa2xx_mfp_config(ARRAY_AND_SIZE(balloon3_ohci_pin_config));
-		pxa_set_ohci_info(&balloon3_ohci_platform_data);
-	}
-	pxa_set_udc_info(&balloon3_udc_info);
-
-	pxa2xx_mfp_config(ARRAY_AND_SIZE(balloon3_pin_config));
 
-	platform_device_register(&balloon3led_device);
+	balloon3_irda_init();
+	balloon3_lcd_init();
+	balloon3_leds_init();
+	balloon3_mmc_init();
+	balloon3_nor_init();
+	balloon3_ts_init();
+	balloon3_udc_init();
+	balloon3_uhc_init();
 }
 
 static struct map_desc balloon3_io_desc[] __initdata = {
-- 
1.7.1
