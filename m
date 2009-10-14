From: mike@compulab.co.il (Mike Rapoport)
Date: Wed, 14 Oct 2009 09:20:19 +0200
Subject: [PATCH 02/10] [ARM] pxa/cm-x300: add TDO35S lcd support
In-Reply-To: <cover.1255504387.git.mike@compulab.co.il>
References: <cover.1255504387.git.mike@compulab.co.il>
Message-ID: <a3ae318346e518ae787288d09feff4844b3dc1ca.1255504387.git.mike@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Igor Grinberg <grinberg@compulab.co.il>

Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
Signed-off-by: Mike Rapoport <mike@compulab.co.il>
---
 arch/arm/mach-pxa/cm-x300.c |   60 ++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 57 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-pxa/cm-x300.c b/arch/arm/mach-pxa/cm-x300.c
index 256cfac..05f1d56 100644
--- a/arch/arm/mach-pxa/cm-x300.c
+++ b/arch/arm/mach-pxa/cm-x300.c
@@ -26,6 +26,10 @@
 #include <linux/i2c.h>
 #include <linux/i2c/pca953x.h>
 
+#include <linux/spi/spi.h>
+#include <linux/spi/spi_gpio.h>
+#include <linux/spi/tdo24m.h>
+
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/setup.h>
@@ -208,17 +212,18 @@ static void __init cm_x300_init_dm9000(void)
 static inline void cm_x300_init_dm9000(void) {}
 #endif
 
+/* LCD */
 #if defined(CONFIG_FB_PXA) || defined(CONFIG_FB_PXA_MODULE)
 static struct pxafb_mode_info cm_x300_lcd_modes[] = {
 	[0] = {
-		.pixclock	= 38000,
+		.pixclock	= 38250,
 		.bpp		= 16,
 		.xres		= 480,
 		.yres		= 640,
 		.hsync_len	= 8,
 		.vsync_len	= 2,
 		.left_margin	= 8,
-		.upper_margin	= 0,
+		.upper_margin	= 2,
 		.right_margin	= 24,
 		.lower_margin	= 4,
 		.cmap_greyscale	= 0,
@@ -240,7 +245,7 @@ static struct pxafb_mode_info cm_x300_lcd_modes[] = {
 
 static struct pxafb_mach_info cm_x300_lcd = {
 	.modes			= cm_x300_lcd_modes,
-	.num_modes		= 2,
+	.num_modes		= ARRAY_SIZE(cm_x300_lcd_modes),
 	.lcd_conn		= LCD_COLOR_TFT_16BPP | LCD_PCLK_EDGE_FALL,
 };
 
@@ -252,6 +257,54 @@ static void __init cm_x300_init_lcd(void)
 static inline void cm_x300_init_lcd(void) {}
 #endif
 
+#if defined(CONFIG_SPI_GPIO) || defined(CONFIG_SPI_GPIO_MODULE)
+#define GPIO_LCD_BASE	(144)
+#define GPIO_LCD_DIN	(GPIO_LCD_BASE + 8)	/* aux_gpio3_0 */
+#define GPIO_LCD_DOUT	(GPIO_LCD_BASE + 9)	/* aux_gpio3_1 */
+#define GPIO_LCD_SCL	(GPIO_LCD_BASE + 10)	/* aux_gpio3_2 */
+#define GPIO_LCD_CS	(GPIO_LCD_BASE + 11)	/* aux_gpio3_3 */
+#define LCD_SPI_BUS_NUM	(1)
+
+static struct spi_gpio_platform_data cm_x300_spi_gpio_pdata = {
+	.sck		= GPIO_LCD_SCL,
+	.mosi		= GPIO_LCD_DIN,
+	.miso		= GPIO_LCD_DOUT,
+	.num_chipselect	= 1,
+};
+
+static struct platform_device cm_x300_spi_gpio = {
+	.name		= "spi_gpio",
+	.id		= LCD_SPI_BUS_NUM,
+	.dev		= {
+		.platform_data	= &cm_x300_spi_gpio_pdata,
+	},
+};
+
+static struct tdo24m_platform_data cm_x300_tdo24m_pdata = {
+	.model = TDO35S,
+};
+
+static struct spi_board_info cm_x300_spi_devices[] __initdata = {
+	{
+		.modalias		= "tdo24m",
+		.max_speed_hz		= 1000000,
+		.bus_num		= LCD_SPI_BUS_NUM,
+		.chip_select		= 0,
+		.controller_data	= (void *) GPIO_LCD_CS,
+		.platform_data		= &cm_x300_tdo24m_pdata,
+	},
+};
+
+static void __init cm_x300_init_spi(void)
+{
+	spi_register_board_info(cm_x300_spi_devices,
+				ARRAY_SIZE(cm_x300_spi_devices));
+	platform_device_register(&cm_x300_spi_gpio);
+}
+#else
+static inline void cm_x300_init_spi(void) {}
+#endif
+
 #if defined(CONFIG_MTD_NAND_PXA3xx) || defined(CONFIG_MTD_NAND_PXA3xx_MODULE)
 static struct mtd_partition cm_x300_nand_partitions[] = {
 	[0] = {
@@ -471,6 +524,7 @@ static void __init cm_x300_init(void)
 	cm_x300_init_nand();
 	cm_x300_init_leds();
 	cm_x300_init_i2c();
+	cm_x300_init_spi();
 	cm_x300_init_rtc();
 }
 
-- 
1.6.0.6
