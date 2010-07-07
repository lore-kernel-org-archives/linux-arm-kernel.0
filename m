From: marek.vasut@gmail.com (Marek Vasut)
Date: Wed,  7 Jul 2010 14:39:12 +0200
Subject: [PATCH 1/2] pxa/spitz: Rework spitz
Message-ID: <1278506353-4143-1-git-send-email-marek.vasut@gmail.com>
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
 arch/arm/mach-pxa/spitz.c              |  475 ++++++++++++++++++++------------
 2 files changed, 304 insertions(+), 173 deletions(-)

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
index c1048a3..26791de 100644
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
@@ -45,10 +44,15 @@
 #include <mach/pxa2xx_spi.h>
 #include <mach/spitz.h>
 
+#include <plat/i2c.h>
+
 #include "generic.h"
 #include "devices.h"
 #include "sharpsl.h"
 
+/******************************************************************************
+ * Pin configuration
+ ******************************************************************************/
 static unsigned long spitz_pin_config[] __initdata = {
 	/* Chip Selects */
 	GPIO78_nCS_2,	/* SCOOP #2 */
@@ -124,6 +128,11 @@ static unsigned long spitz_pin_config[] __initdata = {
 	GPIO1_GPIO | WAKEUP_ON_EDGE_FALL,	/* SPITZ_GPIO_RESET */
 };
 
+
+/******************************************************************************
+ * Scoop GPIO expander
+ ******************************************************************************/
+#if defined(CONFIG_SHARP_SCOOP) || defined(CONFIG_SHARP_SCOOP_MODULE)
 /*
  * Spitz SCOOP Device #1
  */
@@ -182,43 +191,60 @@ struct platform_device spitzscoop2_device = {
 	.resource	= spitz_scoop2_resources,
 };
 
-#define SPITZ_PWR_SD 0x01
-#define SPITZ_PWR_CF 0x02
+static void __init spitz_scoop_init(void)
+{
+	platform_device_register(&spitz_scoop1_device);
+
+	/* Akita doesn't have the second SCOOP chip */
+	if (!machine_is_akita())
+		platform_device_register(&spitzscoop2_device);
+}
 
 /* Power control is shared with between one of the CF slots and SD */
-static void spitz_card_pwr_ctrl(int device, unsigned short new_cpr)
+static void spitz_card_pwr_ctrl(uint8_t enable, uint8_t new_cpr)
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
+	cpr = read_scoop_reg(&spitz_scoop_1_device.dev, SCOOP_CPR);
+
+	if (enable & new_cpr)
+		cpr |= new_cpr;
+	else
+		cpr &= ~enable;
+
+	write_scoop_reg(&spitz_scoop_1_device.dev, SCOOP_CPR, cpr);
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
+static inline void spitz_scoop_init(void) {}
+static inline void spitz_card_pwr_ctrl(uint8_t enable, uint8_t new_cpr) {}
+#endif
+
+/******************************************************************************
+ * PCMCIA
+ ******************************************************************************/
+#if defined(CONFIG_PCMCIA_PXA2XX) || defined(CONFIG_PCMCIA_PXA2XX_MODULE)
+static void spitz_pcmcia_pwr(struct device *scoop, uint16_t cpr, int nr)
 {
 	/* Only need to override behaviour for slot 0 */
 	if (nr == 0)
-		spitz_card_pwr_ctrl(SPITZ_PWR_CF, cpr);
+		spitz_card_pwr_ctrl(
+			cpr & (SCOOP_CPR_CF_3V | SCOOP_CPR_CF_XV), cpr);
 	else
 		write_scoop_reg(scoop, SCOOP_CPR, cpr);
 }
@@ -242,12 +268,23 @@ static struct scoop_pcmcia_config spitz_pcmcia_config = {
 	.power_ctrl   = spitz_pcmcia_pwr,
 };
 
-EXPORT_SYMBOL(spitzscoop_device);
-EXPORT_SYMBOL(spitzscoop2_device);
+static void __init spitz_pcmcia_init(void)
+{
+	/* Akita has only one PCMCIA slot used */
+	if (machine_is_akita())
+		spitz_pcmcia_config.num_devs = 1;
+
+	platform_scoop_config = &spitz_pcmcia_config;
+}
+#else
+static inline void spitz_pcmcia_init(void) {}
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
@@ -359,7 +396,18 @@ static struct platform_device spitzkbd_device = {
 	},
 };
 
+static void __init spitz_mkp_init(void)
+{
+	platform_device_register(&spitzkbd_device);
+}
+#else
+static inline void spitz_mkp_init(void) {}
+#endif
 
+/******************************************************************************
+ * GPIO keys
+ ******************************************************************************/
+#if defined(CONFIG_KEYBOARD_GPIO) || defined(CONFIG_KEYBOARD_GPIO_MODULE)
 static struct gpio_keys_button spitz_gpio_keys[] = {
 	{
 		.type	= EV_PWR,
@@ -396,10 +444,18 @@ static struct platform_device spitz_gpio_keys_device = {
 	},
 };
 
+static void __init spitz_keys_init(void)
+{
+	platform_device_register(&spitz_gpio_keys_device);
+}
+#else
+static inline void spitz_keys_init(void) {}
+#endif
 
-/*
- * Spitz LEDs
- */
+/******************************************************************************
+ * LEDs
+ ******************************************************************************/
+#if defined(CONFIG_LEDS_GPIO) || defined(CONFIG_LEDS_GPIO_MODULE)
 static struct gpio_led spitz_gpio_leds[] = {
 	{
 		.name			= "spitz:amber:charge",
@@ -426,11 +482,18 @@ static struct platform_device spitzled_device = {
 	},
 };
 
-#if defined(CONFIG_SPI_PXA2XX) || defined(CONFIG_SPI_PXA2XX_MODULE)
-static struct pxa2xx_spi_master spitz_spi_info = {
-	.num_chipselect	= 3,
-};
+static void __init spitz_leds_init(void)
+{
+	platform_device_register(&spitzled_device);
+}
+#else
+static inline void spitz_leds_init(void) {}
+#endif
 
+/******************************************************************************
+ * SSP Devices
+ ******************************************************************************/
+#if defined(CONFIG_SPI_PXA2XX) || defined(CONFIG_SPI_PXA2XX_MODULE)
 static void spitz_wait_for_hsync(void)
 {
 	while (gpio_get_value(SPITZ_GPIO_HSYNC))
@@ -508,11 +571,17 @@ static struct spi_board_info spitz_spi_devices[] = {
 	},
 };
 
+static struct pxa2xx_spi_master spitz_spi_info = {
+	.num_chipselect	= 3,
+};
+
 static void __init spitz_init_spi(void)
 {
+	struct corgi_lcd_platform_data *lcd_data = &spitz_lcdcon_info;
+
 	if (machine_is_akita()) {
-		spitz_lcdcon_info.gpio_backlight_cont = AKITA_GPIO_BACKLIGHT_CONT;
-		spitz_lcdcon_info.gpio_backlight_on = AKITA_GPIO_BACKLIGHT_ON;
+		lcd_data->gpio_backlight_cont = AKITA_GPIO_BACKLIGHT_CONT;
+		lcd_data->gpio_backlight_on = AKITA_GPIO_BACKLIGHT_ON;
 	}
 
 	pxa2xx_set_spi_info(2, &spitz_spi_info);
@@ -522,20 +591,22 @@ static void __init spitz_init_spi(void)
 static inline void spitz_init_spi(void) {}
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
 static void spitz_mci_setpower(struct device *dev, unsigned int vdd)
 {
 	struct pxamci_platform_data* p_d = dev->platform_data;
 
-	if (( 1 << vdd) & p_d->ocr_mask)
-		spitz_card_pwr_ctrl(SPITZ_PWR_SD, 0x0004);
+	if ((1 << vdd) & p_d->ocr_mask)
+		spitz_card_pwr_ctrl(SCOOP_CPR_SD_3V, SCOOP_CPR_SD_3V);
 	else
-		spitz_card_pwr_ctrl(SPITZ_PWR_SD, 0x0000);
+		spitz_card_pwr_ctrl(SCOOP_CPR_SD_3V, 0x0);
 }
 
 static struct pxamci_platform_data spitz_mci_platform_data = {
@@ -547,10 +618,18 @@ static struct pxamci_platform_data spitz_mci_platform_data = {
 	.gpio_power		= -1,
 };
 
+static void __init spitz_mmc_init(void)
+{
+	pxa_set_mci_info(&spitz_mci_platform_data);
+}
+#else
+static inline void spitz_mmc_init(void) {}
+#endif
 
-/*
- * USB Host (OHCI)
- */
+/******************************************************************************
+ * USB Host
+ ******************************************************************************/
+#if defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE)
 static int spitz_ohci_init(struct device *dev)
 {
 	int err;
@@ -559,9 +638,7 @@ static int spitz_ohci_init(struct device *dev)
 	if (err)
 		return err;
 
-	/* Only Port 2 is connected
-	 * Setup USB Port 2 Output Control Register
-	 */
+	/* Only Port 2 is connected, setup USB Port 2 Output Control Register */
 	UP2OCR = UP2OCR_HXS | UP2OCR_HXOE | UP2OCR_DPPDE | UP2OCR_DMPDE;
 
 	return gpio_direction_output(SPITZ_GPIO_USB_HOST, 1);
@@ -580,21 +657,39 @@ static struct pxaohci_platform_data spitz_ohci_platform_data = {
 	.power_budget	= 150,
 };
 
+static void __init spitz_uhc_init(void)
+{
+	pxa_set_ohci_info(&spitz_ohci_platform_data);
+}
+#else
+static inline void spitz_uhc_init(void) {}
+#endif
 
-/*
- * Irda
- */
-
+/******************************************************************************
+ * IrDA
+ ******************************************************************************/
+#if defined(CONFIG_PXA_FICP) || defined(CONFIG_PXA_FICP_MODULE)
 static struct pxaficp_platform_data spitz_ficp_platform_data = {
-/* .gpio_pwdown is set in spitz_init() and akita_init() accordingly */
 	.transceiver_cap	= IR_SIRMODE | IR_OFF,
 };
 
+static void __init spitz_irda_init(void)
+{
+	if (machine_is_akita())
+		spitz_ficp_platform_data.gpio_pwdown = AKITA_GPIO_IR_ON;
+	else
+		spitz_ficp_platform_data.gpio_pwdown = SPITZ_GPIO_IR_ON;
 
-/*
- * Spitz PXA Framebuffer
- */
+	pxa_set_ficp_info(&spitz_ficp_platform_data);
+}
+#else
+static inline void spitz_irda_init(void) {}
+#endif
 
+/******************************************************************************
+ * Framebuffer
+ ******************************************************************************/
+#if defined(CONFIG_FB_PXA) || defined(CONFIG_FB_PXA_MODULE)
 static struct pxafb_mode_info spitz_pxafb_modes[] = {
 {
 	.pixclock       = 19231,
@@ -624,12 +719,24 @@ static struct pxafb_mode_info spitz_pxafb_modes[] = {
 };
 
 static struct pxafb_mach_info spitz_pxafb_info = {
-	.modes          = &spitz_pxafb_modes[0],
-	.num_modes      = 2,
+	.modes          = spitz_pxafb_modes,
+	.num_modes      = ARRAY_SIZE(spitz_pxafb_modes),
 	.fixed_modes    = 1,
 	.lcd_conn	= LCD_COLOR_TFT_16BPP | LCD_ALTERNATE_MAPPING,
 };
 
+static void __init spitz_lcd_init(void)
+{
+	set_pxa_fb_info(&spitz_pxafb_info);
+}
+#else
+static inline void spitz_lcd_init(void) {}
+#endif
+
+/******************************************************************************
+ * Framebuffer
+ ******************************************************************************/
+#if defined(CONFIG_MTD_NAND_SHARPSL) || defined(CONFIG_MTD_NAND_SHARPSL_MODULE)
 static struct mtd_partition sharpsl_nand_partitions[] = {
 	{
 		.name = "System Area",
@@ -656,6 +763,16 @@ static struct nand_bbt_descr sharpsl_bbt = {
 	.pattern = scan_ff_pattern
 };
 
+static struct nand_ecclayout spitz_akita_oobinfo = {
+	.oobfree	= { {0x08, 0x09} },
+	.eccbytes	= 24,
+	.eccpos		= {
+			0x05, 0x01, 0x02, 0x03, 0x06, 0x07, 0x15, 0x11,
+			0x12, 0x13, 0x16, 0x17, 0x25, 0x21, 0x22, 0x23,
+			0x26, 0x27, 0x35, 0x31, 0x32, 0x33, 0x36, 0x37,
+	},
+};
+
 static struct sharpsl_nand_platform_data sharpsl_nand_platform_data = {
 	.badblock_pattern	= &sharpsl_bbt,
 	.partitions		= sharpsl_nand_partitions,
@@ -664,8 +781,8 @@ static struct sharpsl_nand_platform_data sharpsl_nand_platform_data = {
 
 static struct resource sharpsl_nand_resources[] = {
 	{
-		.start	= 0x0C000000,
-		.end	= 0x0C000FFF,
+		.start	= PXA_CS3_PHYS,
+		.end	= PXA_CS3_PHYS + SZ_4K - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 };
@@ -675,10 +792,35 @@ static struct platform_device sharpsl_nand_device = {
 	.id		= -1,
 	.resource	= sharpsl_nand_resources,
 	.num_resources	= ARRAY_SIZE(sharpsl_nand_resources),
-	.dev.platform_data	= &sharpsl_nand_platform_data,
+	.dev		= {
+		.platform_data	= &sharpsl_nand_platform_data,
+	}
 };
 
+static void __init spitz_nand_init(void)
+{
+	if (machine_is_spitz()) {
+		sharpsl_nand_partitions[1].size = 5 * 1024 * 1024;
+	} else if (machine_is_akita()) {
+		sharpsl_nand_partitions[1].size = 58 * 1024 * 1024;
+		sharpsl_nand_bbt.len = 1;
+		sharpsl_nand_pdata.ecc_layout = &spitz_akita_oobinfo;
+	} else if (machine_is_borzoi()) {
+		sharpsl_nand_partitions[1].size = 32 * 1024 * 1024;
+		sharpsl_nand_bbt.len = 1;
+		sharpsl_nand_pdata.ecc_layout = &spitz_akita_oobinfo;
+	}
 
+	platform_device_register(&sharpsl_nand_device);
+}
+#else
+static inline void spitz_nand_init(void) {}
+#endif
+
+/******************************************************************************
+ * NOR Flash
+ ******************************************************************************/
+#if defined(CONFIG_MTD_PHYSMAP) || defined(CONFIG_MTD_PHYSMAP_MODULE)
 static struct mtd_partition sharpsl_rom_parts[] = {
 	{
 		.name	="Boot PROM Filesystem",
@@ -695,8 +837,8 @@ static struct physmap_flash_data sharpsl_rom_data = {
 
 static struct resource sharpsl_rom_resources[] = {
 	{
-		.start	= 0x00000000,
-		.end	= 0x007fffff,
+		.start	= PXA_CS0_PHYS,
+		.end	= PXA_CS0_PHYS + SZ_8M - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 };
@@ -706,18 +848,86 @@ static struct platform_device sharpsl_rom_device = {
 	.id	= -1,
 	.resource = sharpsl_rom_resources,
 	.num_resources = ARRAY_SIZE(sharpsl_rom_resources),
-	.dev.platform_data = &sharpsl_rom_data,
+	.dev		= {
+		.platform_data	= &sharpsl_rom_data,
+	},
+};
+
+static void __init spitz_nor_init(void)
+{
+	platform_device_register(&sharpsl_rom_device);
+}
+#else
+static inline void spitz_nor_init(void) {}
+#endif
+
+/******************************************************************************
+ * GPIO expander
+ ******************************************************************************/
+#if defined(CONFIG_I2C_PXA) || defined(CONFIG_I2C_PXA_MODULE)
+static struct pca953x_platform_data akita_pca953x_pdata = {
+	.gpio_base		= AKITA_IOEXP_GPIO_BASE,
+};
+
+static struct i2c_board_info spitz_i2c_devs[] = {
+	{
+		.type		= "wm8750",
+		.addr		= 0x1b,
+	}, {
+		.type		= "max7310",
+		.addr		= 0x18,
+		.platform_data	= &akita_pca953x_pdata,
+	},
+};
+
+static struct regulator_consumer_supply isl6271a_consumers[] = {
+	{
+		.supply	= "vcc_core",
+	}
+};
+
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
 };
 
-static struct platform_device *devices[] __initdata = {
-	&spitzscoop_device,
-	&spitzkbd_device,
-	&spitz_gpio_keys_device,
-	&spitzled_device,
-	&sharpsl_nand_device,
-	&sharpsl_rom_device,
+static struct i2c_board_info spitz_pi2c_devs[] = {
+	{
+		.type		= "isl6271a",
+		.addr		= 0x0c,
+		.platform_data	= &isl6271a_info,
+	},
 };
 
+static void __init spitz_i2c_init(void)
+{
+	int size = ARRAY_SIZE(spitz_i2c_devs);
+
+	/* Only Akita has the max7310 chip */
+	if (!machine_is_akita())
+		size--;
+
+	pxa_set_i2c_info(NULL);
+	pxa27x_set_i2c_power_info(NULL);
+	i2c_register_board_info(0, spitz_i2c_devs, size);
+	i2c_register_board_info(1, ARRAY_AND_SIZE(spitz_pi2c_devs));
+}
+#else
+static inline void spitz_i2c_init(void) {}
+#endif
+
+/******************************************************************************
+ * Machine init
+ ******************************************************************************/
 static void spitz_poweroff(void)
 {
 	arm_machine_restart('g', NULL);
@@ -726,26 +936,18 @@ static void spitz_poweroff(void)
 static void spitz_restart(char mode, const char *cmd)
 {
 	/* Bootloader magic for a reboot */
-	if((MSC0 & 0xffff0000) == 0x7ff00000)
+	if ((MSC0 & 0xffff0000) == 0x7ff00000)
 		MSC0 = (MSC0 & 0xffff) | 0x7ee00000;
 
 	spitz_poweroff();
 }
 
-static void __init common_init(void)
+static void __init spitz_init(void)
 {
 	init_gpio_reset(SPITZ_GPIO_ON_RESET, 1, 0);
 	pm_power_off = spitz_poweroff;
 	arm_pm_restart = spitz_restart;
 
-	if (machine_is_spitz()) {
-		sharpsl_nand_partitions[1].size = 5 * 1024 * 1024;
-	} else if (machine_is_akita()) {
-		sharpsl_nand_partitions[1].size = 58 * 1024 * 1024;
-	} else if (machine_is_borzoi()) {
-		sharpsl_nand_partitions[1].size = 32 * 1024 * 1024;
-	}
-
 	PMCR = 0x00;
 
 	/* Stop 3.6MHz and drive HIGH to PCMCIA and CS */
@@ -758,89 +960,20 @@ static void __init common_init(void)
 	pxa_set_stuart_info(NULL);
 
 	spitz_init_spi();
-
-	platform_add_devices(devices, ARRAY_SIZE(devices));
-	pxa_set_mci_info(&spitz_mci_platform_data);
-	pxa_set_ohci_info(&spitz_ohci_platform_data);
-	pxa_set_ficp_info(&spitz_ficp_platform_data);
-	set_pxa_fb_info(&spitz_pxafb_info);
-	pxa_set_i2c_info(NULL);
+	spitz_scoop_init();
+	spitz_mkp_init();
+	spitz_keys_init();
+	spitz_leds_init();
+	spitz_mmc_init();
+	spitz_pcmcia_init();
+	spitz_irda_init();
+	spitz_uhc_init();
+	spitz_lcd_init();
+	spitz_nor_init();
+	spitz_nand_init();
+	spitz_i2c_init();
 }
 
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
-#endif
-
-#if defined(CONFIG_MACH_SPITZ) || defined(CONFIG_MACH_BORZOI)
-static void __init spitz_init(void)
-{
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
-}
-#endif
-
-#ifdef CONFIG_MACH_AKITA
-/*
- * Akita IO Expander
- */
-static struct pca953x_platform_data akita_ioexp = {
-	.gpio_base		= AKITA_IOEXP_GPIO_BASE,
-};
-
-static struct i2c_board_info akita_i2c_board_info[] = {
-	{
-		.type		= "max7310",
-		.addr		= 0x18,
-		.platform_data	= &akita_ioexp,
-	}, {
-		.type		= "wm8750",
-		.addr		= 0x1b,
-	},
-};
-
-static void __init akita_init(void)
-{
-	spitz_ficp_platform_data.gpio_pwdown = AKITA_GPIO_IR_ON;
-
-	sharpsl_nand_platform_data.badblock_pattern = &sharpsl_akita_bbt;
-	sharpsl_nand_platform_data.ecc_layout = &akita_oobinfo;
-
-	/* We just pretend the second element of the array doesn't exist */
-	spitz_pcmcia_config.num_devs = 1;
-	platform_scoop_config = &spitz_pcmcia_config;
-
-	i2c_register_board_info(0, ARRAY_AND_SIZE(akita_i2c_board_info));
-
-	common_init();
-}
-#endif
-
 static void __init fixup_spitz(struct machine_desc *desc,
 		struct tag *tags, char **cmdline, struct meminfo *mi)
 {
@@ -882,7 +1015,7 @@ MACHINE_START(AKITA, "SHARP Akita")
 	.fixup		= fixup_spitz,
 	.map_io		= pxa_map_io,
 	.init_irq	= pxa27x_init_irq,
-	.init_machine	= akita_init,
+	.init_machine	= spitz_init,
 	.timer		= &pxa_timer,
 MACHINE_END
 #endif
-- 
1.7.1
