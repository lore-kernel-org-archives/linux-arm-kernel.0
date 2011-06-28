From: jacmet@sunsite.dk (Peter Korsgaard)
Date: Tue, 28 Jun 2011 14:49:13 +0200
Subject: [PATCH 1/5] mach-jive: convert to spi_gpio
In-Reply-To: <1309265357-15879-1-git-send-email-jacmet@sunsite.dk>
References: <1309265357-15879-1-git-send-email-jacmet@sunsite.dk>
Message-ID: <1309265357-15879-2-git-send-email-jacmet@sunsite.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rather than the deprecated spi_s3c24xx_gpio driver. Compile tested only.

Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
---
 arch/arm/mach-s3c2412/mach-jive.c |   41 ++++++++++++------------------------
 1 files changed, 14 insertions(+), 27 deletions(-)

diff --git a/arch/arm/mach-s3c2412/mach-jive.c b/arch/arm/mach-s3c2412/mach-jive.c
index 85dcaeb..5eeb475 100644
--- a/arch/arm/mach-s3c2412/mach-jive.c
+++ b/arch/arm/mach-s3c2412/mach-jive.c
@@ -25,6 +25,7 @@
 #include <video/ili9320.h>
 
 #include <linux/spi/spi.h>
+#include <linux/spi/spi_gpio.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -38,7 +39,6 @@
 #include <mach/regs-gpio.h>
 #include <mach/regs-mem.h>
 #include <mach/regs-lcd.h>
-#include <mach/spi-gpio.h>
 #include <mach/fb.h>
 
 #include <asm/mach-types.h>
@@ -389,45 +389,30 @@ static struct ili9320_platdata jive_lcm_config = {
 
 /* LCD SPI support */
 
-static void jive_lcd_spi_chipselect(struct s3c2410_spigpio_info *spi, int cs)
-{
-	gpio_set_value(S3C2410_GPB(7), cs ? 0 : 1);
-}
-
-static struct s3c2410_spigpio_info jive_lcd_spi = {
-	.bus_num	= 1,
-	.pin_clk	= S3C2410_GPG(8),
-	.pin_mosi	= S3C2410_GPB(8),
-	.num_chipselect	= 1,
-	.chip_select	= jive_lcd_spi_chipselect,
+static struct spi_gpio_platform_data jive_lcd_spi = {
+	.sck		= S3C2410_GPG(8),
+	.mosi		= S3C2410_GPB(8),
+	.miso		= SPI_GPIO_NO_MISO,
 };
 
 static struct platform_device jive_device_lcdspi = {
-	.name		= "spi_s3c24xx_gpio",
+	.name		= "spi-gpio",
 	.id		= 1,
-	.num_resources  = 0,
 	.dev.platform_data = &jive_lcd_spi,
 };
 
-/* WM8750 audio code SPI definition */
 
-static void jive_wm8750_chipselect(struct s3c2410_spigpio_info *spi, int cs)
-{
-	gpio_set_value(S3C2410_GPH(10), cs ? 0 : 1);
-}
+/* WM8750 audio code SPI definition */
 
-static struct s3c2410_spigpio_info jive_wm8750_spi = {
-	.bus_num	= 2,
-	.pin_clk	= S3C2410_GPB(4),
-	.pin_mosi	= S3C2410_GPB(9),
-	.num_chipselect	= 1,
-	.chip_select	= jive_wm8750_chipselect,
+static struct spi_gpio_platform_data jive_wm8750_spi = {
+	.sck		= S3C2410_GPB(4),
+	.mosi		= S3C2410_GPB(9),
+	.miso		= SPI_GPIO_NO_MISO,
 };
 
 static struct platform_device jive_device_wm8750 = {
-	.name		= "spi_s3c24xx_gpio",
+	.name		= "spi-gpio",
 	.id		= 2,
-	.num_resources  = 0,
 	.dev.platform_data = &jive_wm8750_spi,
 };
 
@@ -441,12 +426,14 @@ static struct spi_board_info __initdata jive_spi_devs[] = {
 		.mode		= SPI_MODE_3,	/* CPOL=1, CPHA=1 */
 		.max_speed_hz	= 100000,
 		.platform_data	= &jive_lcm_config,
+		.controller_data = (void *)S3C2410_GPB(7),
 	}, {
 		.modalias	= "WM8750",
 		.bus_num	= 2,
 		.chip_select	= 0,
 		.mode		= SPI_MODE_0,	/* CPOL=0, CPHA=0 */
 		.max_speed_hz	= 100000,
+		.controller_data = (void *)S3C2410_GPH(10),
 	},
 };
 
-- 
1.7.5.4
