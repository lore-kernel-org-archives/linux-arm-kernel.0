From: mathias.nyman@nokia.com (Mathias Nyman)
Date: Tue, 6 Jul 2010 17:05:34 +0300
Subject: [PATCH] omap: tsl2563 ALS support for Nokia N900
Message-ID: <mailman.64.1278664535.27306.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit will enable usage of tsl2563 ambient light sensor on Nokia N900.

Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
Signed-off-by: Mathias Nyman <mathias.nyman@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index 3c3f975..a3a396c 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -35,6 +35,8 @@
 #include <sound/tlv320aic3x.h>
 #include <sound/tpa6130a2-plat.h>
 
+#include <../drivers/staging/iio/light/tsl2563.h>
+
 #include "mux.h"
 #include "hsmmc.h"
 
@@ -53,6 +55,12 @@ enum {
 
 static struct wl12xx_platform_data wl1251_pdata;
 
+#if defined(CONFIG_SENSORS_TSL2563) || defined(CONFIG_SENSORS_TSL2563_MODULE)
+static struct tsl2563_platform_data rx51_tsl2563_platform_data = {
+	.cover_comp_gain = 16,
+};
+#endif
+
 static struct omap2_mcspi_device_config wl1251_mcspi_config = {
 	.turbo_mode	= 0,
 	.single_channel	= 1,
@@ -714,6 +722,12 @@ static struct i2c_board_info __initdata rx51_peripherals_i2c_board_info_2[] = {
 		I2C_BOARD_INFO("tlv320aic3x", 0x18),
 		.platform_data = &rx51_aic3x_data,
 	},
+#if defined(CONFIG_SENSORS_TSL2563) || defined(CONFIG_SENSORS_TSL2563_MODULE)
+	{
+		I2C_BOARD_INFO("tsl2563", 0x29),
+		.platform_data = &rx51_tsl2563_platform_data,
+	},
+#endif
 	{
 		I2C_BOARD_INFO("tpa6130a2", 0x60),
 		.platform_data = &rx51_tpa6130a2_data,

--BXVAT5kNtrzKuDFl--
