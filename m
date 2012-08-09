From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu,  9 Aug 2012 19:05:48 +0100
Subject: [PATCH 1/2] ARM: S3C64XX: Update configuration for WM5102 module on
 Cragganmore
Message-ID: <1344535549-4371-1-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SPI is also connected on the board, use that instead of I2C as it's much
faster. Also define platform data now the core driver is in mainline.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/mach-s3c64xx/mach-crag6410-module.c |   35 ++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/mach-crag6410-module.c b/arch/arm/mach-s3c64xx/mach-crag6410-module.c
index f81f089..22dd77b 100644
--- a/arch/arm/mach-s3c64xx/mach-crag6410-module.c
+++ b/arch/arm/mach-s3c64xx/mach-crag6410-module.c
@@ -192,9 +192,33 @@ static const struct i2c_board_info wm1277_devs[] = {
 	},
 };
 
-static const struct i2c_board_info wm5102_devs[] = {
-	{ I2C_BOARD_INFO("wm5102", 0x1a),
-	  .irq = GLENFARCLAS_PMIC_IRQ_BASE + WM831X_IRQ_GPIO_2, },
+static struct arizona_pdata wm5102_pdata = {
+	.ldoena = S3C64XX_GPN(7),
+	.gpio_base = CODEC_GPIO_BASE,
+	.irq_active_high = true,
+	.micd_pol_gpio = CODEC_GPIO_BASE + 4,
+	.gpio_defaults = {
+		[2] = 0x10000, /* AIF3TXLRCLK */
+		[3] = 0x4,     /* OPCLK */
+	},
+};
+
+static struct s3c64xx_spi_csinfo wm5102_spi_csinfo = {
+	.line = S3C64XX_GPN(5),
+};
+
+static struct spi_board_info wm5102_spi_devs[] = {
+	[0] = {
+		.modalias	= "wm5102",
+		.max_speed_hz	= 10 * 1000 * 1000,
+		.bus_num	= 0,
+		.chip_select	= 0,
+		.mode		= SPI_MODE_0,
+		.irq            = GLENFARCLAS_PMIC_IRQ_BASE +
+				  WM831X_IRQ_GPIO_2,
+		.controller_data = &wm5102_spi_csinfo,
+		.platform_data = &wm5102_pdata,
+	},
 };
 
 static const struct i2c_board_info wm6230_i2c_devs[] = {
@@ -234,8 +258,9 @@ static __devinitdata const struct {
 	{ .id = 0x3c, .name = "1273-EV1 Longmorn" },
 	{ .id = 0x3d, .name = "1277-EV1 Littlemill",
 	  .i2c_devs = wm1277_devs, .num_i2c_devs = ARRAY_SIZE(wm1277_devs) },
-	{ .id = 0x3e, .name = "WM5102-6271-EV1-CS127",
-	  .i2c_devs = wm5102_devs, .num_i2c_devs = ARRAY_SIZE(wm5102_devs) },
+	{ .id = 0x3e, .name = "WM5102-6271-EV1-CS127 Amrut",
+	  .spi_devs = wm5102_spi_devs,
+	  .num_spi_devs = ARRAY_SIZE(wm5102_spi_devs) },
 };
 
 static __devinit int wlf_gf_module_probe(struct i2c_client *i2c,
-- 
1.7.10.4
