From: marek.vasut@gmail.com (Marek Vasut)
Date: Sat, 12 Jun 2010 14:44:39 +0200
Subject: [PATCH 3/3] pxa/spitz: Rework spitz
In-Reply-To: <1276346679-2893-1-git-send-email-marek.vasut@gmail.com>
References: <1276346679-2893-1-git-send-email-marek.vasut@gmail.com>
Message-ID: <1276346679-2893-3-git-send-email-marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This huge patch mostly shuffles code. The spitz.c file contained terrible mess
and needed a cleanup, here it is:

1) Made every part modular, components are not built in if not selected.
2) Removed loads of preprocessor goo, mostly "#ifdef MACH_AKITA .... #endif" and
   similar code. The kernel size will grow by a few kb now, but the file is much
   more readable.
3) Reworked SD/CF power setting function and made it reentrant.
4) Add ISL6271A regulator support
5) Correctly register WM8750

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
---
 arch/arm/mach-pxa/include/mach/spitz.h |    2 -
 arch/arm/mach-pxa/spitz.c              |  810 ++++++++++++++++++-------------
 2 files changed, 470 insertions(+), 342 deletions(-)

diff --git a/arch/arm/mach-pxa/include/mach/spitz.h b/arch/arm/mach-pxa/include/mach/spitz.h
index fa1998c..685749a 100644
--- a/arch/arm/mach-pxa/include/mach/spitz.h
+++ b/arch/arm/mach-pxa/include/mach/spitz.h
@@ -185,7 +185,5 @@
 /*
  * Shared data structures
  */
-extern struct platform_device spitzscoop_device;
-extern struct platform_device spitzscoop2_device;
 extern struct platform_device spitzssp_device;
 extern struct sharpsl_charger_machinfo spitz_pm_machinfo;
diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
index 4d2413e..fa31980 100644
--- a/arch/arm/mach-pxa/spitz.c
+++ b/arch/arm/mach-pxa/spitz.c
@@ -18,14 +18,15 @@
 #include <linux/gpio_keys.h>
 #include <linux/gpio.h>
 #include <linux/leds.h>
-#include <linux/mtd/physmap.h>
 #include <linux/i2c.h>
 #include <linux/i2c/pca953x.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/ads7846.h>
 #include <linux/spi/corgi_lcd.h>
+#include <linux/mtd/physmap.h>
 #include <linux/mtd/sharpsl.h>
 #include <linux/input/matrix_keypad.h>
+#include <linux/regulator/machine.h>
 
 #include <asm/setup.h>
 #include <asm/mach-types.h>
@@ -33,11 +34,9 @@
 #include <asm/mach/sharpsl_param.h>
 #include <asm/hardware/scoop.h>
 
-
 #include <mach/pxa27x.h>
 #include <mach/pxa27x-udc.h>
 #include <mach/reset.h>
-#include <plat/i2c.h>
 #include <mach/irda.h>
 #include <mach/mmc.h>
 #include <mach/ohci.h>
@@ -45,11 +44,16 @@
 #include <mach/pxa2xx_spi.h>
 #include <mach/spitz.h>
 
+#include <plat/i2c.h>
+
 #include "generic.h"
 #include "devices.h"
 #include "sharpsl.h"
 
-static unsigned long spitz_pin_config[] __initdata = {
+/******************************************************************************
+ * Pin configuration
+ ******************************************************************************/
+static unsigned long sharpslc_pin_config[] __initdata = {
 	/* Chip Selects */
 	GPIO78_nCS_2,	/* SCOOP #2 */
 	GPIO79_nCS_3,	/* NAND */
@@ -124,10 +128,13 @@ static unsigned long spitz_pin_config[] __initdata = {
 	GPIO1_GPIO | WAKEUP_ON_EDGE_FALL,	/* SPITZ_GPIO_RESET */
 };
 
-/*
- * Spitz SCOOP Device #1
- */
-static struct resource spitz_scoop_resources[] = {
+
+/******************************************************************************
+ * Scoop GPIO expander
+ ******************************************************************************/
+#if defined(CONFIG_SHARP_SCOOP) || defined(CONFIG_SHARP_SCOOP_MODULE)
+/* SCOOP Device #1 */
+static struct resource sharpslc_scoop_1_resources[] = {
 	[0] = {
 		.start		= 0x10800000,
 		.end		= 0x10800fff,
@@ -135,7 +142,7 @@ static struct resource spitz_scoop_resources[] = {
 	},
 };
 
-static struct scoop_config spitz_scoop_setup = {
+static struct scoop_config sharpslc_scoop_1_setup = {
 	.io_dir		= SPITZ_SCP_IO_DIR,
 	.io_out		= SPITZ_SCP_IO_OUT,
 	.suspend_clr	= SPITZ_SCP_SUS_CLR,
@@ -143,20 +150,18 @@ static struct scoop_config spitz_scoop_setup = {
 	.gpio_base	= SPITZ_SCP_GPIO_BASE,
 };
 
-struct platform_device spitzscoop_device = {
+struct platform_device sharpslc_scoop_1_device = {
 	.name		= "sharp-scoop",
 	.id		= 0,
 	.dev		= {
- 		.platform_data	= &spitz_scoop_setup,
+		.platform_data	= &sharpslc_scoop_1_setup,
 	},
-	.num_resources	= ARRAY_SIZE(spitz_scoop_resources),
-	.resource	= spitz_scoop_resources,
+	.num_resources	= ARRAY_SIZE(sharpslc_scoop_1_resources),
+	.resource	= sharpslc_scoop_1_resources,
 };
 
-/*
- * Spitz SCOOP Device #2
- */
-static struct resource spitz_scoop2_resources[] = {
+/* SCOOP Device #2 */
+static struct resource sharpslc_scoop_2_resources[] = {
 	[0] = {
 		.start		= 0x08800040,
 		.end		= 0x08800fff,
@@ -164,7 +169,7 @@ static struct resource spitz_scoop2_resources[] = {
 	},
 };
 
-static struct scoop_config spitz_scoop2_setup = {
+static struct scoop_config sharpslc_scoop_2_setup = {
 	.io_dir		= SPITZ_SCP2_IO_DIR,
 	.io_out		= SPITZ_SCP2_IO_OUT,
 	.suspend_clr	= SPITZ_SCP2_SUS_CLR,
@@ -172,82 +177,110 @@ static struct scoop_config spitz_scoop2_setup = {
 	.gpio_base	= SPITZ_SCP2_GPIO_BASE,
 };
 
-struct platform_device spitzscoop2_device = {
+struct platform_device sharpslc_scoop_2_device = {
 	.name		= "sharp-scoop",
 	.id		= 1,
 	.dev		= {
- 		.platform_data	= &spitz_scoop2_setup,
+		.platform_data	= &sharpslc_scoop_2_setup,
 	},
-	.num_resources	= ARRAY_SIZE(spitz_scoop2_resources),
-	.resource	= spitz_scoop2_resources,
+	.num_resources	= ARRAY_SIZE(sharpslc_scoop_2_resources),
+	.resource	= sharpslc_scoop_2_resources,
 };
 
-#define SPITZ_PWR_SD 0x01
-#define SPITZ_PWR_CF 0x02
+static void __init sharpslc_scoop_init(void)
+{
+	platform_device_register(&sharpslc_scoop_1_device);
+
+	/* Akita doesn't have the second SCOOP chip */
+	if (!machine_is_akita())
+		platform_device_register(&sharpslc_scoop_2_device);
+}
 
 /* Power control is shared with between one of the CF slots and SD */
-static void spitz_card_pwr_ctrl(int device, unsigned short new_cpr)
+static void sharpslc_card_pwr_ctrl(uint8_t enable, uint8_t new_cpr)
 {
-	unsigned short cpr = read_scoop_reg(&spitzscoop_device.dev, SCOOP_CPR);
+	unsigned short cpr;
+	unsigned long flags;
 
-	if (new_cpr & 0x0007) {
+	if (new_cpr & 0x7) {
 		gpio_set_value(SPITZ_GPIO_CF_POWER, 1);
-		if (!(cpr & 0x0002) && !(cpr & 0x0004))
-		        mdelay(5);
-		if (device == SPITZ_PWR_CF)
-		        cpr |= 0x0002;
-		if (device == SPITZ_PWR_SD)
-		        cpr |= 0x0004;
-	        write_scoop_reg(&spitzscoop_device.dev, SCOOP_CPR, cpr | new_cpr);
-	} else {
-		if (device == SPITZ_PWR_CF)
-		        cpr &= ~0x0002;
-		if (device == SPITZ_PWR_SD)
-		        cpr &= ~0x0004;
-		if (!(cpr & 0x0002) && !(cpr & 0x0004)) {
-			write_scoop_reg(&spitzscoop_device.dev, SCOOP_CPR, 0x0000);
-		        mdelay(1);
-			gpio_set_value(SPITZ_GPIO_CF_POWER, 0);
-		} else {
-		        write_scoop_reg(&spitzscoop_device.dev, SCOOP_CPR, cpr | new_cpr);
-		}
+		mdelay(5);
+	}
+
+	local_irq_save(flags);
+
+	cpr = read_scoop_reg(&sharpslc_scoop_1_device.dev, SCOOP_CPR);
+
+	if (enable & new_cpr)
+		cpr |= new_cpr;
+	else
+		cpr &= ~enable;
+
+	write_scoop_reg(&sharpslc_scoop_1_device.dev, SCOOP_CPR, cpr);
+
+	local_irq_restore(flags);
+
+	if (!(cpr & 0x7)) {
+		mdelay(1);
+		gpio_set_value(SPITZ_GPIO_CF_POWER, 0);
 	}
 }
 
-static void spitz_pcmcia_pwr(struct device *scoop, unsigned short cpr, int nr)
+#else
+static inline void sharpslc_scoop_init(void) {}
+static inline void sharpslc_card_pwr_ctrl(uint8_t enable, uint8_t new_cpr) {}
+#endif
+
+/******************************************************************************
+ * PCMCIA
+ ******************************************************************************/
+#if defined(CONFIG_PCMCIA_PXA2XX) || defined(CONFIG_PCMCIA_PXA2XX_MODULE)
+static void sharpslc_pcmcia_pwr(struct device *scoop, uint16_t cpr, int nr)
 {
 	/* Only need to override behaviour for slot 0 */
 	if (nr == 0)
-		spitz_card_pwr_ctrl(SPITZ_PWR_CF, cpr);
+		sharpslc_card_pwr_ctrl(
+			cpr & (SCOOP_CPR_CF_3V | SCOOP_CPR_CF_XV), cpr);
 	else
 		write_scoop_reg(scoop, SCOOP_CPR, cpr);
 }
 
-static struct scoop_pcmcia_dev spitz_pcmcia_scoop[] = {
-{
-	.dev        = &spitzscoop_device.dev,
-	.irq        = SPITZ_IRQ_GPIO_CF_IRQ,
-	.cd_irq     = SPITZ_IRQ_GPIO_CF_CD,
-	.cd_irq_str = "PCMCIA0 CD",
-},{
-	.dev        = &spitzscoop2_device.dev,
-	.irq        = SPITZ_IRQ_GPIO_CF2_IRQ,
-	.cd_irq     = -1,
-},
+static struct scoop_pcmcia_dev sharpslc_pcmcia_scoop[] = {
+	{
+		.dev        = &sharpslc_scoop_1_device.dev,
+		.irq        = SPITZ_IRQ_GPIO_CF_IRQ,
+		.cd_irq     = SPITZ_IRQ_GPIO_CF_CD,
+		.cd_irq_str = "PCMCIA0 CD",
+	}, {
+		.dev        = &sharpslc_scoop_2_device.dev,
+		.irq        = SPITZ_IRQ_GPIO_CF2_IRQ,
+		.cd_irq     = -1,
+	},
 };
 
-static struct scoop_pcmcia_config spitz_pcmcia_config = {
-	.devs         = &spitz_pcmcia_scoop[0],
-	.num_devs     = 2,
-	.power_ctrl   = spitz_pcmcia_pwr,
+static struct scoop_pcmcia_config sharpslc_pcmcia_config = {
+	.devs		= &sharpslc_pcmcia_scoop[0],
+	.num_devs	= 2,
+	.power_ctrl	= sharpslc_pcmcia_pwr,
 };
 
-EXPORT_SYMBOL(spitzscoop_device);
-EXPORT_SYMBOL(spitzscoop2_device);
+static void __init sharpslc_pcmcia_init(void)
+{
+	/* Akita has only one PCMCIA slot used */
+	if (machine_is_akita())
+		sharpslc_pcmcia_config.num_devs = 1;
+
+	platform_scoop_config = &sharpslc_pcmcia_config;
+}
+#else
+static inline void sharpslc_pcmcia_init(void) {}
+#endif
+
+/******************************************************************************
+ * GPIO keyboard
+ ******************************************************************************/
+#if defined(CONFIG_KEYBOARD_MATRIX) || defined(CONFIG_KEYBOARD_MATRIX_MODULE)
 
-/*
- * Spitz Keyboard Device
- */
 #define SPITZ_KEY_CALENDAR	KEY_F1
 #define SPITZ_KEY_ADDRESS	KEY_F2
 #define SPITZ_KEY_FN		KEY_F3
@@ -263,7 +296,7 @@ EXPORT_SYMBOL(spitzscoop2_device);
 #define SPITZ_KEY_OK		KEY_F11
 #define SPITZ_KEY_MENU		KEY_F12
 
-static const uint32_t spitzkbd_keymap[] = {
+static const uint32_t sharpslc_keymap[] = {
 	KEY(0, 0, KEY_LEFTCTRL),
 	KEY(0, 1, KEY_1),
 	KEY(0, 2, KEY_3),
@@ -330,37 +363,48 @@ static const uint32_t spitzkbd_keymap[] = {
 	KEY(6, 8, KEY_RIGHT),
 };
 
-static const struct matrix_keymap_data spitzkbd_keymap_data = {
-	.keymap		= spitzkbd_keymap,
-	.keymap_size	= ARRAY_SIZE(spitzkbd_keymap),
+static const struct matrix_keymap_data sharpslc_keymap_data = {
+	.keymap		= sharpslc_keymap,
+	.keymap_size	= ARRAY_SIZE(sharpslc_keymap),
 };
 
-static const uint32_t spitzkbd_row_gpios[] =
+static const uint32_t sharpslc_row_gpios[] =
 		{ 12, 17, 91, 34, 36, 38, 39 };
-static const uint32_t spitzkbd_col_gpios[] =
+static const uint32_t sharpslc_col_gpios[] =
 		{ 88, 23, 24, 25, 26, 27, 52, 103, 107, 108, 114 };
 
-static struct matrix_keypad_platform_data spitzkbd_pdata = {
-	.keymap_data		= &spitzkbd_keymap_data,
-	.row_gpios		= spitzkbd_row_gpios,
-	.col_gpios		= spitzkbd_col_gpios,
-	.num_row_gpios		= ARRAY_SIZE(spitzkbd_row_gpios),
-	.num_col_gpios		= ARRAY_SIZE(spitzkbd_col_gpios),
+static struct matrix_keypad_platform_data sharpslc_mkp_pdata = {
+	.keymap_data		= &sharpslc_keymap_data,
+	.row_gpios		= sharpslc_row_gpios,
+	.col_gpios		= sharpslc_col_gpios,
+	.num_row_gpios		= ARRAY_SIZE(sharpslc_row_gpios),
+	.num_col_gpios		= ARRAY_SIZE(sharpslc_col_gpios),
 	.col_scan_delay_us	= 10,
 	.debounce_ms		= 10,
 	.wakeup			= 1,
 };
 
-static struct platform_device spitzkbd_device = {
+static struct platform_device sharpslc_mkp_device = {
 	.name		= "matrix-keypad",
 	.id		= -1,
 	.dev		= {
-		.platform_data = &spitzkbd_pdata,
+		.platform_data	= &sharpslc_mkp_pdata,
 	},
 };
 
+static void __init sharpslc_mkp_init(void)
+{
+	platform_device_register(&sharpslc_mkp_device);
+}
+#else
+static inline void sharpslc_mkp_init(void) {}
+#endif
 
-static struct gpio_keys_button spitz_gpio_keys[] = {
+/******************************************************************************
+ * GPIO keys
+ ******************************************************************************/
+#if defined(CONFIG_KEYBOARD_GPIO) || defined(CONFIG_KEYBOARD_GPIO_MODULE)
+static struct gpio_keys_button sharpslc_gpio_keys[] = {
 	{
 		.type	= EV_PWR,
 		.code	= KEY_SUSPEND,
@@ -383,27 +427,35 @@ static struct gpio_keys_button spitz_gpio_keys[] = {
 	},
 };
 
-static struct gpio_keys_platform_data spitz_gpio_keys_platform_data = {
-	.buttons	= spitz_gpio_keys,
-	.nbuttons	= ARRAY_SIZE(spitz_gpio_keys),
+static struct gpio_keys_platform_data sharpslc_gpio_keys_platform_data = {
+	.buttons	= sharpslc_gpio_keys,
+	.nbuttons	= ARRAY_SIZE(sharpslc_gpio_keys),
 };
 
-static struct platform_device spitz_gpio_keys_device = {
+static struct platform_device sharpslc_gpio_keys_device = {
 	.name	= "gpio-keys",
 	.id	= -1,
 	.dev	= {
-		.platform_data	= &spitz_gpio_keys_platform_data,
+		.platform_data	= &sharpslc_gpio_keys_platform_data,
 	},
 };
 
+static void __init sharpslc_keys_init(void)
+{
+	platform_device_register(&sharpslc_gpio_keys_device);
+}
+#else
+static inline void sharpslc_keys_init(void) {}
+#endif
 
-/*
- * Spitz LEDs
- */
-static struct gpio_led spitz_gpio_leds[] = {
+/******************************************************************************
+ * LEDs
+ ******************************************************************************/
+#if defined(CONFIG_LEDS_GPIO) || defined(CONFIG_LEDS_GPIO_MODULE)
+static struct gpio_led sharpslc_gpio_leds[] = {
 	{
 		.name			= "spitz:amber:charge",
-		.default_trigger	= "sharpsl-charge",
+		.default_trigger	= "sharpslc-charge",
 		.gpio			= SPITZ_GPIO_LED_ORANGE,
 	},
 	{
@@ -413,25 +465,32 @@ static struct gpio_led spitz_gpio_leds[] = {
 	},
 };
 
-static struct gpio_led_platform_data spitz_gpio_leds_info = {
-	.leds		= spitz_gpio_leds,
-	.num_leds	= ARRAY_SIZE(spitz_gpio_leds),
+static struct gpio_led_platform_data sharpslc_gpio_leds_info = {
+	.leds		= sharpslc_gpio_leds,
+	.num_leds	= ARRAY_SIZE(sharpslc_gpio_leds),
 };
 
-static struct platform_device spitzled_device = {
+static struct platform_device sharpslc_led_device = {
 	.name		= "leds-gpio",
 	.id		= -1,
 	.dev		= {
-		.platform_data = &spitz_gpio_leds_info,
+		.platform_data	= &sharpslc_gpio_leds_info,
 	},
 };
 
-#if defined(CONFIG_SPI_PXA2XX) || defined(CONFIG_SPI_PXA2XX_MODULE)
-static struct pxa2xx_spi_master spitz_spi_info = {
-	.num_chipselect	= 3,
-};
+static void __init sharpslc_leds_init(void)
+{
+	platform_device_register(&sharpslc_led_device);
+}
+#else
+static inline void sharpslc_leds_init(void) {}
+#endif
 
-static void spitz_wait_for_hsync(void)
+/******************************************************************************
+ * SSP Devices
+ ******************************************************************************/
+#if defined(CONFIG_SPI_PXA2XX) || defined(CONFIG_SPI_PXA2XX_MODULE)
+static void sharpslc_ads7846_wait_for_hsync(void)
 {
 	while (gpio_get_value(SPITZ_GPIO_HSYNC))
 		cpu_relax();
@@ -440,21 +499,21 @@ static void spitz_wait_for_hsync(void)
 		cpu_relax();
 }
 
-static struct ads7846_platform_data spitz_ads7846_info = {
+static struct ads7846_platform_data sharpslc_ads7846_info = {
 	.model			= 7846,
 	.vref_delay_usecs	= 100,
 	.x_plate_ohms		= 419,
 	.y_plate_ohms		= 486,
 	.pressure_max		= 1024,
 	.gpio_pendown		= SPITZ_GPIO_TP_INT,
-	.wait_for_sync		= spitz_wait_for_hsync,
+	.wait_for_sync		= sharpslc_ads7846_wait_for_hsync,
 };
 
-static struct pxa2xx_spi_chip spitz_ads7846_chip = {
+static struct pxa2xx_spi_chip sharpslc_ads7846_chip = {
 	.gpio_cs		= SPITZ_GPIO_ADS7846_CS,
 };
 
-static void spitz_bl_kick_battery(void)
+static void sharpslc_bl_kick_battery(void)
 {
 	void (*kick_batt)(void);
 
@@ -465,93 +524,109 @@ static void spitz_bl_kick_battery(void)
 	}
 }
 
-static struct corgi_lcd_platform_data spitz_lcdcon_info = {
+static struct corgi_lcd_platform_data sharpslc_lcdcon_info = {
 	.init_mode		= CORGI_LCD_MODE_VGA,
 	.max_intensity		= 0x2f,
 	.default_intensity	= 0x1f,
 	.limit_mask		= 0x0b,
 	.gpio_backlight_cont	= SPITZ_GPIO_BACKLIGHT_CONT,
 	.gpio_backlight_on	= SPITZ_GPIO_BACKLIGHT_ON,
-	.kick_battery		= spitz_bl_kick_battery,
+	.kick_battery		= sharpslc_bl_kick_battery,
 };
 
-static struct pxa2xx_spi_chip spitz_lcdcon_chip = {
+static struct pxa2xx_spi_chip sharpslc_lcdcon_chip = {
 	.gpio_cs	= SPITZ_GPIO_LCDCON_CS,
 };
 
-static struct pxa2xx_spi_chip spitz_max1111_chip = {
+static struct pxa2xx_spi_chip sharpslc_max1111_chip = {
 	.gpio_cs	= SPITZ_GPIO_MAX1111_CS,
 };
 
-static struct spi_board_info spitz_spi_devices[] = {
+static struct spi_board_info sharpslc_spi_devices[] = {
 	{
-		.modalias	= "ads7846",
-		.max_speed_hz	= 1200000,
-		.bus_num	= 2,
-		.chip_select	= 0,
-		.platform_data	= &spitz_ads7846_info,
-		.controller_data= &spitz_ads7846_chip,
-		.irq		= gpio_to_irq(SPITZ_GPIO_TP_INT),
+		.modalias		= "ads7846",
+		.max_speed_hz		= 1200000,
+		.bus_num		= 2,
+		.chip_select		= 0,
+		.platform_data		= &sharpslc_ads7846_info,
+		.controller_data	= &sharpslc_ads7846_chip,
+		.irq			= gpio_to_irq(SPITZ_GPIO_TP_INT),
 	}, {
-		.modalias	= "corgi-lcd",
-		.max_speed_hz	= 50000,
-		.bus_num	= 2,
-		.chip_select	= 1,
-		.platform_data	= &spitz_lcdcon_info,
-		.controller_data= &spitz_lcdcon_chip,
+		.modalias		= "corgi-lcd",
+		.max_speed_hz		= 50000,
+		.bus_num		= 2,
+		.chip_select		= 1,
+		.platform_data		= &sharpslc_lcdcon_info,
+		.controller_data	= &sharpslc_lcdcon_chip,
 	}, {
-		.modalias	= "max1111",
-		.max_speed_hz	= 450000,
-		.bus_num	= 2,
-		.chip_select	= 2,
-		.controller_data= &spitz_max1111_chip,
+		.modalias		= "max1111",
+		.max_speed_hz		= 450000,
+		.bus_num		= 2,
+		.chip_select		= 2,
+		.controller_data	= &sharpslc_max1111_chip,
 	},
 };
 
-static void __init spitz_init_spi(void)
+static struct pxa2xx_spi_master sharpslc_spi_info = {
+	.num_chipselect	= 3,
+};
+
+static void __init sharpslc_spi_init(void)
 {
+	struct corgi_lcd_platform_data *lcd_data = &sharpslc_lcdcon_info;
+
 	if (machine_is_akita()) {
-		spitz_lcdcon_info.gpio_backlight_cont = AKITA_GPIO_BACKLIGHT_CONT;
-		spitz_lcdcon_info.gpio_backlight_on = AKITA_GPIO_BACKLIGHT_ON;
+		lcd_data->gpio_backlight_cont = AKITA_GPIO_BACKLIGHT_CONT;
+		lcd_data->gpio_backlight_on = AKITA_GPIO_BACKLIGHT_ON;
 	}
 
-	pxa2xx_set_spi_info(2, &spitz_spi_info);
-	spi_register_board_info(ARRAY_AND_SIZE(spitz_spi_devices));
+	pxa2xx_set_spi_info(2, &sharpslc_spi_info);
+	spi_register_board_info(ARRAY_AND_SIZE(sharpslc_spi_devices));
 }
 #else
-static inline void spitz_init_spi(void) {}
+static inline void sharpslc_spi_init(void) {}
 #endif
 
+/******************************************************************************
+ * SD/MMC card controller
+ ******************************************************************************/
+#if defined(CONFIG_MMC_PXA) || defined(CONFIG_MMC_PXA_MODULE)
 /*
- * MMC/SD Device
- *
- * The card detect interrupt isn't debounced so we delay it by 250ms
- * to give the card a chance to fully insert/eject.
+ * NOTE: The card detect interrupt isn't debounced so we delay it by 250ms to
+ * give the card a chance to fully insert/eject.
  */
-static void spitz_mci_setpower(struct device *dev, unsigned int vdd)
+static void sharpslc_mci_setpower(struct device *dev, unsigned int vdd)
 {
 	struct pxamci_platform_data* p_d = dev->platform_data;
 
-	if (( 1 << vdd) & p_d->ocr_mask)
-		spitz_card_pwr_ctrl(SPITZ_PWR_SD, 0x0004);
+	if ((1 << vdd) & p_d->ocr_mask)
+		sharpslc_card_pwr_ctrl(SCOOP_CPR_SD_3V, SCOOP_CPR_SD_3V);
 	else
-		spitz_card_pwr_ctrl(SPITZ_PWR_SD, 0x0000);
+		sharpslc_card_pwr_ctrl(SCOOP_CPR_SD_3V, 0x0);
 }
 
-static struct pxamci_platform_data spitz_mci_platform_data = {
+static struct pxamci_platform_data sharpslc_mci_platform_data = {
 	.detect_delay_ms	= 250,
 	.ocr_mask		= MMC_VDD_32_33|MMC_VDD_33_34,
-	.setpower 		= spitz_mci_setpower,
+	.setpower		= sharpslc_mci_setpower,
 	.gpio_card_detect	= SPITZ_GPIO_nSD_DETECT,
 	.gpio_card_ro		= SPITZ_GPIO_nSD_WP,
 	.gpio_power		= -1,
 };
 
+static void __init sharpslc_mmc_init(void)
+{
+	pxa_set_mci_info(&sharpslc_mci_platform_data);
+}
+#else
+static inline void sharpslc_mmc_init(void) {}
+#endif
 
-/*
- * USB Host (OHCI)
- */
-static int spitz_ohci_init(struct device *dev)
+/******************************************************************************
+ * USB Host
+ ******************************************************************************/
+#if defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE)
+static int sharpslc_ohci_init(struct device *dev)
 {
 	int err;
 
@@ -559,88 +634,114 @@ static int spitz_ohci_init(struct device *dev)
 	if (err)
 		return err;
 
-	/* Only Port 2 is connected
-	 * Setup USB Port 2 Output Control Register
-	 */
+	/* Only Port 2 is connected, setup USB Port 2 Output Control Register */
 	UP2OCR = UP2OCR_HXS | UP2OCR_HXOE | UP2OCR_DPPDE | UP2OCR_DMPDE;
 
 	return gpio_direction_output(SPITZ_GPIO_USB_HOST, 1);
 }
 
-static void spitz_ohci_exit(struct device *dev)
+static void sharpslc_ohci_exit(struct device *dev)
 {
 	gpio_free(SPITZ_GPIO_USB_HOST);
 }
 
-static struct pxaohci_platform_data spitz_ohci_platform_data = {
+static struct pxaohci_platform_data sharpslc_ohci_platform_data = {
 	.port_mode	= PMM_NPS_MODE,
-	.init		= spitz_ohci_init,
-	.exit		= spitz_ohci_exit,
+	.init		= sharpslc_ohci_init,
+	.exit		= sharpslc_ohci_exit,
 	.flags		= ENABLE_PORT_ALL | NO_OC_PROTECTION,
 	.power_budget	= 150,
 };
 
+static void __init sharpslc_uhc_init(void)
+{
+	pxa_set_ohci_info(&sharpslc_ohci_platform_data);
+}
+#else
+static inline void sharpslc_uhc_init(void) {}
+#endif
 
-/*
- * Irda
- */
-
-static struct pxaficp_platform_data spitz_ficp_platform_data = {
-/* .gpio_pwdown is set in spitz_init() and akita_init() accordingly */
+/******************************************************************************
+ * IrDA
+ ******************************************************************************/
+#if defined(CONFIG_PXA_FICP) || defined(CONFIG_PXA_FICP_MODULE)
+static struct pxaficp_platform_data sharpslc_ficp_platform_data = {
 	.transceiver_cap	= IR_SIRMODE | IR_OFF,
 };
 
+static void __init sharpslc_irda_init(void)
+{
+	if (machine_is_akita())
+		sharpslc_ficp_platform_data.gpio_pwdown = AKITA_GPIO_IR_ON;
+	else
+		sharpslc_ficp_platform_data.gpio_pwdown = SPITZ_GPIO_IR_ON;
 
-/*
- * Spitz PXA Framebuffer
- */
+	pxa_set_ficp_info(&sharpslc_ficp_platform_data);
+}
+#else
+static inline void sharpslc_irda_init(void) {}
+#endif
 
-static struct pxafb_mode_info spitz_pxafb_modes[] = {
-{
-	.pixclock       = 19231,
-	.xres           = 480,
-	.yres           = 640,
-	.bpp            = 16,
-	.hsync_len      = 40,
-	.left_margin    = 46,
-	.right_margin   = 125,
-	.vsync_len      = 3,
-	.upper_margin   = 1,
-	.lower_margin   = 0,
-	.sync           = 0,
-},{
-	.pixclock       = 134617,
-	.xres           = 240,
-	.yres           = 320,
-	.bpp            = 16,
-	.hsync_len      = 20,
-	.left_margin    = 20,
-	.right_margin   = 46,
-	.vsync_len      = 2,
-	.upper_margin   = 1,
-	.lower_margin   = 0,
-	.sync           = 0,
-},
-};
-
-static struct pxafb_mach_info spitz_pxafb_info = {
-	.modes          = &spitz_pxafb_modes[0],
-	.num_modes      = 2,
+/******************************************************************************
+ * Framebuffer
+ ******************************************************************************/
+#if defined(CONFIG_FB_PXA) || defined(CONFIG_FB_PXA_MODULE)
+static struct pxafb_mode_info sharpslc_pxafb_modes[] = {
+	{
+		.pixclock       = 19231,
+		.xres           = 480,
+		.yres           = 640,
+		.bpp            = 16,
+		.hsync_len      = 40,
+		.left_margin    = 46,
+		.right_margin   = 125,
+		.vsync_len      = 3,
+		.upper_margin   = 1,
+		.lower_margin   = 0,
+		.sync           = 0,
+	}, {
+		.pixclock       = 134617,
+		.xres           = 240,
+		.yres           = 320,
+		.bpp            = 16,
+		.hsync_len      = 20,
+		.left_margin    = 20,
+		.right_margin   = 46,
+		.vsync_len      = 2,
+		.upper_margin   = 1,
+		.lower_margin   = 0,
+		.sync           = 0,
+	},
+};
+
+static struct pxafb_mach_info sharpslc_pxafb_info = {
+	.modes          = sharpslc_pxafb_modes,
+	.num_modes      = ARRAY_SIZE(sharpslc_pxafb_modes),
 	.fixed_modes    = 1,
 	.lcd_conn	= LCD_COLOR_TFT_16BPP | LCD_ALTERNATE_MAPPING,
 };
 
-static struct mtd_partition sharpsl_nand_partitions[] = {
+static void __init sharpslc_lcd_init(void)
+{
+	set_pxa_fb_info(&sharpslc_pxafb_info);
+}
+#else
+static inline void sharpslc_lcd_init(void) {}
+#endif
+
+/******************************************************************************
+ * Framebuffer
+ ******************************************************************************/
+#if defined(CONFIG_MTD_NAND_SHARPSL) || defined(CONFIG_MTD_NAND_SHARPSL_MODULE)
+static struct mtd_partition sharpslc_nand_partitions[] = {
 	{
 		.name = "System Area",
 		.offset = 0,
 		.size = 7 * 1024 * 1024,
-	},
-	{
+	}, {
 		.name = "Root Filesystem",
 		.offset = 7 * 1024 * 1024,
-	},
-	{
+	}, {
 		.name = "Home Filesystem",
 		.offset = MTDPART_OFS_APPEND,
 		.size = MTDPART_SIZ_FULL,
@@ -649,37 +750,72 @@ static struct mtd_partition sharpsl_nand_partitions[] = {
 
 static uint8_t scan_ff_pattern[] = { 0xff, 0xff };
 
-static struct nand_bbt_descr sharpsl_bbt = {
-	.options = 0,
-	.offs = 4,
-	.len = 2,
-	.pattern = scan_ff_pattern
+static struct nand_bbt_descr sharpslc_nand_bbt = {
+	.options	= 0,
+	.offs		= 4,
+	.len		= 2,
+	.pattern	= scan_ff_pattern
+};
+
+static struct nand_ecclayout sharpslc_akita_oobinfo = {
+	.oobfree	= { {0x08, 0x09} },
+	.eccbytes	= 24,
+	.eccpos		= {
+			0x05, 0x01, 0x02, 0x03, 0x06, 0x07, 0x15, 0x11,
+			0x12, 0x13, 0x16, 0x17, 0x25, 0x21, 0x22, 0x23,
+			0x26, 0x27, 0x35, 0x31, 0x32, 0x33, 0x36, 0x37,
+	},
 };
 
-static struct sharpsl_nand_platform_data sharpsl_nand_platform_data = {
-	.badblock_pattern	= &sharpsl_bbt,
-	.partitions		= sharpsl_nand_partitions,
-	.nr_partitions		= ARRAY_SIZE(sharpsl_nand_partitions),
+static struct sharpsl_nand_platform_data sharpslc_nand_pdata = {
+	.badblock_pattern	= &sharpslc_nand_bbt,
+	.partitions		= sharpslc_nand_partitions,
+	.nr_partitions		= ARRAY_SIZE(sharpslc_nand_partitions),
 };
 
-static struct resource sharpsl_nand_resources[] = {
+static struct resource sharpslc_nand_resources[] = {
 	{
-		.start	= 0x0C000000,
-		.end	= 0x0C000FFF,
+		.start	= PXA_CS3_PHYS,
+		.end	= PXA_CS3_PHYS + SZ_4K - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 };
 
-static struct platform_device sharpsl_nand_device = {
+static struct platform_device sharpslc_nand_device = {
 	.name		= "sharpsl-nand",
 	.id		= -1,
-	.resource	= sharpsl_nand_resources,
-	.num_resources	= ARRAY_SIZE(sharpsl_nand_resources),
-	.dev.platform_data	= &sharpsl_nand_platform_data,
+	.resource	= sharpslc_nand_resources,
+	.num_resources	= ARRAY_SIZE(sharpslc_nand_resources),
+	.dev		= {
+		.platform_data	= &sharpslc_nand_pdata,
+	}
 };
 
+static void __init sharpslc_nand_init(void)
+{
+	if (machine_is_spitz()) {
+		sharpslc_nand_partitions[1].size = 5 * 1024 * 1024;
+	} else if (machine_is_akita()) {
+		sharpslc_nand_partitions[1].size = 58 * 1024 * 1024;
+		sharpslc_nand_bbt.len = 1;
+		sharpslc_nand_pdata.ecc_layout = &sharpslc_akita_oobinfo;
+	} else if (machine_is_borzoi()) {
+		sharpslc_nand_partitions[1].size = 32 * 1024 * 1024;
+		sharpslc_nand_bbt.len = 1;
+		sharpslc_nand_pdata.ecc_layout = &sharpslc_akita_oobinfo;
+	}
+
+	platform_device_register(&sharpslc_nand_device);
+}
+#else
+static inline void sharpslc_nand_init(void) {}
+#endif
 
-static struct mtd_partition sharpsl_rom_parts[] = {
+/******************************************************************************
+ * NOR Flash
+ ******************************************************************************/
+#if defined(CONFIG_MTD_PHYSMAP) || defined(CONFIG_MTD_PHYSMAP_MODULE)
+static struct mtd_partition sharpslc_rom_parts[] = {
 	{
 		.name	="Boot PROM Filesystem",
 		.offset	= 0x00140000,
@@ -687,158 +823,152 @@ static struct mtd_partition sharpsl_rom_parts[] = {
 	},
 };
 
-static struct physmap_flash_data sharpsl_rom_data = {
+static struct physmap_flash_data sharpslc_rom_data = {
 	.width		= 2,
-	.nr_parts	= ARRAY_SIZE(sharpsl_rom_parts),
-	.parts		= sharpsl_rom_parts,
+	.nr_parts	= ARRAY_SIZE(sharpslc_rom_parts),
+	.parts		= sharpslc_rom_parts,
 };
 
-static struct resource sharpsl_rom_resources[] = {
+static struct resource sharpslc_rom_resources[] = {
 	{
-		.start	= 0x00000000,
-		.end	= 0x007fffff,
+		.start	= PXA_CS0_PHYS,
+		.end	= PXA_CS0_PHYS + SZ_8M - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 };
 
-static struct platform_device sharpsl_rom_device = {
-	.name	= "physmap-flash",
-	.id	= -1,
-	.resource = sharpsl_rom_resources,
-	.num_resources = ARRAY_SIZE(sharpsl_rom_resources),
-	.dev.platform_data = &sharpsl_rom_data,
-};
-
-static struct platform_device *devices[] __initdata = {
-	&spitzscoop_device,
-	&spitzkbd_device,
-	&spitz_gpio_keys_device,
-	&spitzled_device,
-	&sharpsl_nand_device,
-	&sharpsl_rom_device,
+static struct platform_device sharpslc_rom_device = {
+	.name		= "physmap-flash",
+	.id		= -1,
+	.resource	= sharpslc_rom_resources,
+	.num_resources	= ARRAY_SIZE(sharpslc_rom_resources),
+	.dev		= {
+		.platform_data	= &sharpslc_rom_data,
+	},
 };
 
-static void spitz_poweroff(void)
+static void __init sharpslc_nor_init(void)
 {
-	arm_machine_restart('g', NULL);
+	platform_device_register(&sharpslc_rom_device);
 }
+#else
+static inline void sharpslc_nor_init(void) {}
+#endif
 
-static void spitz_restart(char mode, const char *cmd)
-{
-	/* Bootloader magic for a reboot */
-	if((MSC0 & 0xffff0000) == 0x7ff00000)
-		MSC0 = (MSC0 & 0xffff) | 0x7ee00000;
-
-	spitz_poweroff();
-}
+/******************************************************************************
+ * GPIO expander
+ ******************************************************************************/
+#if defined(CONFIG_I2C_PXA) || defined(CONFIG_I2C_PXA_MODULE)
+static struct pca953x_platform_data akita_pca953x_pdata = {
+	.gpio_base		= AKITA_IOEXP_GPIO_BASE,
+};
 
-static void __init common_init(void)
-{
-	init_gpio_reset(SPITZ_GPIO_ON_RESET, 1, 0);
-	pm_power_off = spitz_poweroff;
-	arm_pm_restart = spitz_restart;
+static struct i2c_board_info sharpslc_i2c_devs[] = {
+	{
+		.type		= "wm8750",
+		.addr		= 0x1b,
+	}, {
+		.type		= "max7310",
+		.addr		= 0x18,
+		.platform_data	= &akita_pca953x_pdata,
+	},
+};
 
-	if (machine_is_spitz()) {
-		sharpsl_nand_partitions[1].size = 5 * 1024 * 1024;
-	} else if (machine_is_akita()) {
-		sharpsl_nand_partitions[1].size = 58 * 1024 * 1024;
-	} else if (machine_is_borzoi()) {
-		sharpsl_nand_partitions[1].size = 32 * 1024 * 1024;
+static struct regulator_consumer_supply isl6271a_consumers[] = {
+	{
+		.supply	= "vcc_core",
 	}
+};
 
-	PMCR = 0x00;
-
-	/* Stop 3.6MHz and drive HIGH to PCMCIA and CS */
-	PCFR |= PCFR_OPDE;
+static struct regulator_init_data isl6271a_info[] = {
+	{
+		.constraints = {
+			.name		= "vcc_core range",
+			.min_uV		= 850000,
+			.max_uV		= 1600000,
+			.always_on	= 1,
+			.valid_ops_mask	= REGULATOR_CHANGE_VOLTAGE,
+		},
+	.consumer_supplies	= isl6271a_consumers,
+	.num_consumer_supplies	= ARRAY_SIZE(isl6271a_consumers),
+	}
+};
 
-	pxa2xx_mfp_config(ARRAY_AND_SIZE(spitz_pin_config));
+static struct i2c_board_info sharpslc_pi2c_devs[] = {
+	{
+		.type		= "isl6271a",
+		.addr		= 0x0c,
+		.platform_data	= &isl6271a_info,
+	},
+};
 
-	pxa_set_ffuart_info(NULL);
-	pxa_set_btuart_info(NULL);
-	pxa_set_stuart_info(NULL);
+static void __init sharpslc_i2c_init(void)
+{
+	int size = ARRAY_SIZE(sharpslc_i2c_devs);
 
-	spitz_init_spi();
+	/* Only Akita has the max7310 chip */
+	if (!machine_is_akita())
+		size--;
 
-	platform_add_devices(devices, ARRAY_SIZE(devices));
-	pxa_set_mci_info(&spitz_mci_platform_data);
-	pxa_set_ohci_info(&spitz_ohci_platform_data);
-	pxa_set_ficp_info(&spitz_ficp_platform_data);
-	set_pxa_fb_info(&spitz_pxafb_info);
 	pxa_set_i2c_info(NULL);
+	pxa27x_set_i2c_power_info(NULL);
+	i2c_register_board_info(0, sharpslc_i2c_devs, size);
+	i2c_register_board_info(1, ARRAY_AND_SIZE(sharpslc_pi2c_devs));
 }
-
-#if defined(CONFIG_MACH_AKITA) || defined(CONFIG_MACH_BORZOI)
-static struct nand_bbt_descr sharpsl_akita_bbt = {
-	.options = 0,
-	.offs = 4,
-	.len = 1,
-	.pattern = scan_ff_pattern
-};
-
-static struct nand_ecclayout akita_oobinfo = {
-	.eccbytes = 24,
-	.eccpos = {
-		   0x5, 0x1, 0x2, 0x3, 0x6, 0x7, 0x15, 0x11,
-		   0x12, 0x13, 0x16, 0x17, 0x25, 0x21, 0x22, 0x23,
-		   0x26, 0x27, 0x35, 0x31, 0x32, 0x33, 0x36, 0x37},
-	.oobfree = {{0x08, 0x09}}
-};
+#else
+static inline void sharpslc_i2c_init(void) {}
 #endif
 
-#if defined(CONFIG_MACH_SPITZ) || defined(CONFIG_MACH_BORZOI)
-static void __init spitz_init(void)
+/******************************************************************************
+ * Machine init
+ ******************************************************************************/
+static void sharpslc_poweroff(void)
 {
-	spitz_ficp_platform_data.gpio_pwdown = SPITZ_GPIO_IR_ON;
-
-#ifdef CONFIG_MACH_BORZOI
-	if (machine_is_borzoi()) {
-		sharpsl_nand_platform_data.badblock_pattern = &sharpsl_akita_bbt;
-		sharpsl_nand_platform_data.ecc_layout = &akita_oobinfo;
-	}
-#endif
-
-	platform_scoop_config = &spitz_pcmcia_config;
-
-	common_init();
-
-	platform_device_register(&spitzscoop2_device);
+	arm_machine_restart('g', NULL);
 }
-#endif
 
-#ifdef CONFIG_MACH_AKITA
-/*
- * Akita IO Expander
- */
-static struct pca953x_platform_data akita_ioexp = {
-	.gpio_base		= AKITA_IOEXP_GPIO_BASE,
-};
+static void sharpslc_restart(char mode, const char *cmd)
+{
+	/* Bootloader magic for a reboot */
+	if ((MSC0 & 0xffff0000) == 0x7ff00000)
+		MSC0 = (MSC0 & 0xffff) | 0x7ee00000;
 
-static struct i2c_board_info akita_i2c_board_info[] = {
-	{
-		.type		= "max7310",
-		.addr		= 0x18,
-		.platform_data	= &akita_ioexp,
-	},
-};
+	sharpslc_poweroff();
+}
 
-static void __init akita_init(void)
+static void __init sharpslc_init(void)
 {
-	spitz_ficp_platform_data.gpio_pwdown = AKITA_GPIO_IR_ON;
+	init_gpio_reset(SPITZ_GPIO_ON_RESET, 1, 0);
+	pm_power_off = sharpslc_poweroff;
+	arm_pm_restart = sharpslc_restart;
 
-	sharpsl_nand_platform_data.badblock_pattern = &sharpsl_akita_bbt;
-	sharpsl_nand_platform_data.ecc_layout = &akita_oobinfo;
+	PMCR = 0x00;
 
-	/* We just pretend the second element of the array doesn't exist */
-	spitz_pcmcia_config.num_devs = 1;
-	platform_scoop_config = &spitz_pcmcia_config;
+	/* Stop 3.6MHz and drive HIGH to PCMCIA and CS */
+	PCFR |= PCFR_OPDE;
 
-	i2c_register_board_info(0, ARRAY_AND_SIZE(akita_i2c_board_info));
+	pxa2xx_mfp_config(ARRAY_AND_SIZE(sharpslc_pin_config));
 
-	common_init();
+	pxa_set_ffuart_info(NULL);
+	pxa_set_btuart_info(NULL);
+	pxa_set_stuart_info(NULL);
+
+	sharpslc_spi_init();
+	sharpslc_scoop_init();
+	sharpslc_mkp_init();
+	sharpslc_keys_init();
+	sharpslc_leds_init();
+	sharpslc_mmc_init();
+	sharpslc_pcmcia_init();
+	sharpslc_irda_init();
+	sharpslc_uhc_init();
+	sharpslc_lcd_init();
+	sharpslc_nor_init();
+	sharpslc_nand_init();
+	sharpslc_i2c_init();
 }
-#endif
 
-static void __init fixup_spitz(struct machine_desc *desc,
+static void __init sharpslc_fixup(struct machine_desc *desc,
 		struct tag *tags, char **cmdline, struct meminfo *mi)
 {
 	sharpsl_save_param();
@@ -852,10 +982,10 @@ static void __init fixup_spitz(struct machine_desc *desc,
 MACHINE_START(SPITZ, "SHARP Spitz")
 	.phys_io	= 0x40000000,
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
-	.fixup		= fixup_spitz,
+	.fixup		= sharpslc_fixup,
 	.map_io		= pxa_map_io,
 	.init_irq	= pxa27x_init_irq,
-	.init_machine	= spitz_init,
+	.init_machine	= sharpslc_init,
 	.timer		= &pxa_timer,
 MACHINE_END
 #endif
@@ -864,10 +994,10 @@ MACHINE_END
 MACHINE_START(BORZOI, "SHARP Borzoi")
 	.phys_io	= 0x40000000,
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
-	.fixup		= fixup_spitz,
+	.fixup		= sharpslc_fixup,
 	.map_io		= pxa_map_io,
 	.init_irq	= pxa27x_init_irq,
-	.init_machine	= spitz_init,
+	.init_machine	= sharpslc_init,
 	.timer		= &pxa_timer,
 MACHINE_END
 #endif
@@ -876,10 +1006,10 @@ MACHINE_END
 MACHINE_START(AKITA, "SHARP Akita")
 	.phys_io	= 0x40000000,
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
-	.fixup		= fixup_spitz,
+	.fixup		= sharpslc_fixup,
 	.map_io		= pxa_map_io,
 	.init_irq	= pxa27x_init_irq,
-	.init_machine	= akita_init,
+	.init_machine	= sharpslc_init,
 	.timer		= &pxa_timer,
 MACHINE_END
 #endif
-- 
1.7.1
