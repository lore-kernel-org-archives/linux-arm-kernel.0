From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Mon, 30 Mar 2015 13:39:29 +0300
Subject: [PATCH 1/3] ARM: pxa: add gpio-charger configuration on poodle
Message-ID: <1427711971-8164-1-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add declration of gpio-charger device for Sharp SL-5600 poodle device.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/arm/mach-pxa/poodle.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/mach-pxa/poodle.c b/arch/arm/mach-pxa/poodle.c
index 6002112..4dd29a7 100644
--- a/arch/arm/mach-pxa/poodle.c
+++ b/arch/arm/mach-pxa/poodle.c
@@ -31,6 +31,7 @@
 #include <linux/spi/ads7846.h>
 #include <linux/spi/pxa2xx_spi.h>
 #include <linux/mtd/sharpsl.h>
+#include <linux/power/gpio-charger.h>
 #include <linux/memblock.h>
 #include <linux/iio/machine.h>
 #include <linux/mfd/locomo.h>
@@ -413,12 +414,31 @@ static struct platform_device sharpsl_rom_device = {
 	.dev.platform_data = &sharpsl_rom_data,
 };
 
+static char *poodle_ac_supplied_to[] = {
+	"main-battery",
+};
+
+static struct gpio_charger_platform_data poodle_power_data = {
+	.name			= "charger",
+	.type			= POWER_SUPPLY_TYPE_MAINS,
+	.gpio			= POODLE_GPIO_AC_IN,
+	.supplied_to		= poodle_ac_supplied_to,
+	.num_supplicants	= ARRAY_SIZE(poodle_ac_supplied_to),
+};
+
+static struct platform_device poodle_power_device = {
+	.name			= "gpio-charger",
+	.id			= -1,
+	.dev.platform_data	= &poodle_power_data,
+};
+
 static struct platform_device *devices[] __initdata = {
 	&poodle_locomo_device,
 	&poodle_scoop_device,
 	&poodle_audio_device,
 	&sharpsl_nand_device,
 	&sharpsl_rom_device,
+	&poodle_power_device,
 };
 
 static struct i2c_board_info __initdata poodle_i2c_devices[] = {
-- 
2.1.4
