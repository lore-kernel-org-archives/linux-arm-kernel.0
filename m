From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 17 Oct 2012 16:38:34 +0900
Subject: [PATCH 3/8] ARM: S3C64XX: Provide platform data for Tomatin/Balblair
 on Cragganmore
In-Reply-To: <1350459519-20462-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20121017073813.GI14199@opensource.wolfsonmicro.com>
 <1350459519-20462-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <1350459519-20462-4-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is required for operation of the WM0010 on the boards.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/mach-s3c64xx/mach-crag6410-module.c |   25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-s3c64xx/mach-crag6410-module.c b/arch/arm/mach-s3c64xx/mach-crag6410-module.c
index 89f5e7d..32b82c0 100644
--- a/arch/arm/mach-s3c64xx/mach-crag6410-module.c
+++ b/arch/arm/mach-s3c64xx/mach-crag6410-module.c
@@ -20,6 +20,7 @@
 
 #include <linux/regulator/machine.h>
 
+#include <sound/wm0010.h>
 #include <sound/wm5100.h>
 #include <sound/wm8996.h>
 #include <sound/wm8962.h>
@@ -33,14 +34,34 @@ static struct s3c64xx_spi_csinfo wm0010_spi_csinfo = {
 	.line = S3C64XX_GPC(3),
 };
 
+static struct wm0010_pdata wm0010_pdata = {
+	.gpio_reset = S3C64XX_GPN(6),
+	.reset_active_high = 1, /* Active high for Glenfarclas Rev 2 */
+};
+
 static struct spi_board_info wm1253_devs[] = {
 	[0] = {
 		.modalias	= "wm0010",
+		.max_speed_hz	= 26 * 1000 * 1000,
+		.bus_num	= 0,
+		.chip_select	= 0,
+		.mode		= SPI_MODE_0,
+		.irq		= S3C_EINT(5),
+		.controller_data = &wm0010_spi_csinfo,
+		.platform_data = &wm0010_pdata,
+	},
+};
+
+static struct spi_board_info balblair_devs[] = {
+	[0] = {
+		.modalias	= "wm0010",
+		.max_speed_hz	= 26 * 1000 * 1000,
 		.bus_num	= 0,
 		.chip_select	= 0,
 		.mode		= SPI_MODE_0,
 		.irq		= S3C_EINT(5),
 		.controller_data = &wm0010_spi_csinfo,
+		.platform_data = &wm0010_pdata,
 	},
 };
 
@@ -244,7 +265,9 @@ static __devinitdata const struct {
 	  .spi_devs = wm1253_devs, .num_spi_devs = ARRAY_SIZE(wm1253_devs) },
 	{ .id = 0x32, .name = "XXXX-EV1 Caol Illa" },
 	{ .id = 0x33, .name = "XXXX-EV1 Oban" },
-	{ .id = 0x34, .name = "WM0010-6320-CS42 Balblair" },
+	{ .id = 0x34, .name = "WM0010-6320-CS42 Balblair",
+	  .spi_devs = balblair_devs,
+	  .num_spi_devs = ARRAY_SIZE(balblair_devs) },
 	{ .id = 0x39, .name = "1254-EV1 Dallas Dhu",
 	  .i2c_devs = wm1254_devs, .num_i2c_devs = ARRAY_SIZE(wm1254_devs) },
 	{ .id = 0x3a, .name = "1259-EV1 Tobermory",
-- 
1.7.10.4
