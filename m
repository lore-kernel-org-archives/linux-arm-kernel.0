From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Fri, 2 Mar 2012 13:56:38 +0100
Subject: [PATCH 1/2] pxa: magician/hx4700: Convert to gpio-regulator from
 bq24022
In-Reply-To: <201203021355.21669.heiko@sntech.de>
References: <201203021355.21669.heiko@sntech.de>
Message-ID: <201203021356.38857.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The bq24022 on these machines is a very simple regulator using gpios.
One provides the on/off functionality and a second one is used to
change the current between 100 and 500 mA.

This functionality can also be provided by the more generic gpio-regulator.

Therefore convert both machines which makes it possible to remove the
bq24022 driver later on.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/configs/magician_defconfig |    2 +-
 arch/arm/mach-pxa/hx4700.c          |   33 +++++++++++++++++++++++++++------
 arch/arm/mach-pxa/magician.c        |   33 +++++++++++++++++++++++++++------
 3 files changed, 55 insertions(+), 13 deletions(-)

diff --git a/arch/arm/configs/magician_defconfig b/arch/arm/configs/magician_defconfig
index 443675d..a691ef4 100644
--- a/arch/arm/configs/magician_defconfig
+++ b/arch/arm/configs/magician_defconfig
@@ -101,7 +101,7 @@ CONFIG_MFD_ASIC3=y
 CONFIG_HTC_EGPIO=y
 CONFIG_HTC_PASIC3=y
 CONFIG_REGULATOR=y
-CONFIG_REGULATOR_BQ24022=y
+CONFIG_REGULATOR_GPIO=y
 CONFIG_FB=y
 CONFIG_FB_PXA=y
 CONFIG_FB_PXA_OVERLAY=y
diff --git a/arch/arm/mach-pxa/hx4700.c b/arch/arm/mach-pxa/hx4700.c
index f2c23ea..7571f0d 100644
--- a/arch/arm/mach-pxa/hx4700.c
+++ b/arch/arm/mach-pxa/hx4700.c
@@ -28,7 +28,8 @@
 #include <linux/mtd/physmap.h>
 #include <linux/pda_power.h>
 #include <linux/pwm_backlight.h>
-#include <linux/regulator/bq24022.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/gpio-regulator.h>
 #include <linux/regulator/machine.h>
 #include <linux/regulator/max1586.h>
 #include <linux/spi/ads7846.h>
@@ -698,14 +699,34 @@ static struct regulator_init_data bq24022_init_data = {
 	.consumer_supplies      = bq24022_consumers,
 };
 
-static struct bq24022_mach_info bq24022_info = {
-	.gpio_nce   = GPIO72_HX4700_BQ24022_nCHARGE_EN,
-	.gpio_iset2 = GPIO96_HX4700_BQ24022_ISET2,
-	.init_data  = &bq24022_init_data,
+static struct gpio bq24022_gpios[] = {
+	{ GPIO96_HX4700_BQ24022_ISET2, GPIOF_OUT_INIT_LOW, "bq24022_iset2" },
+};
+
+static struct gpio_regulator_state bq24022_states[] = {
+	{ .value = 100000, .gpios = (0 << 0) },
+	{ .value = 500000, .gpios = (1 << 0) },
+};
+
+static struct gpio_regulator_config bq24022_info = {
+	.supply_name = "bq24022",
+
+	.enable_gpio = GPIO72_HX4700_BQ24022_nCHARGE_EN,
+	.enable_high = 0,
+	.enabled_at_boot = 0,
+
+	.gpios = bq24022_gpios,
+	.nr_gpios = ARRAY_SIZE(bq24022_gpios),
+
+	.states = bq24022_states,
+	.nr_states = ARRAY_SIZE(bq24022_states),
+
+	.type = REGULATOR_CURRENT,
+	.init_data = &bq24022_init_data,
 };
 
 static struct platform_device bq24022 = {
-	.name = "bq24022",
+	.name = "gpio-regulator",
 	.id   = -1,
 	.dev  = {
 		.platform_data = &bq24022_info,
diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
index 3d6baf9..5e26f3e 100644
--- a/arch/arm/mach-pxa/magician.c
+++ b/arch/arm/mach-pxa/magician.c
@@ -25,7 +25,8 @@
 #include <linux/mtd/physmap.h>
 #include <linux/pda_power.h>
 #include <linux/pwm_backlight.h>
-#include <linux/regulator/bq24022.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/gpio-regulator.h>
 #include <linux/regulator/machine.h>
 #include <linux/usb/gpio_vbus.h>
 #include <linux/i2c/pxa-i2c.h>
@@ -596,14 +597,34 @@ static struct regulator_init_data bq24022_init_data = {
 	.consumer_supplies      = bq24022_consumers,
 };
 
-static struct bq24022_mach_info bq24022_info = {
-	.gpio_nce   = GPIO30_MAGICIAN_BQ24022_nCHARGE_EN,
-	.gpio_iset2 = EGPIO_MAGICIAN_BQ24022_ISET2,
-	.init_data  = &bq24022_init_data,
+static struct gpio bq24022_gpios[] = {
+	{ EGPIO_MAGICIAN_BQ24022_ISET2, GPIOF_OUT_INIT_LOW, "bq24022_iset2" },
+};
+
+static struct gpio_regulator_state bq24022_states[] = {
+	{ .value = 100000, .gpios = (0 << 0) },
+	{ .value = 500000, .gpios = (1 << 0) },
+};
+
+static struct gpio_regulator_config bq24022_info = {
+	.supply_name = "bq24022",
+
+	.enable_gpio = GPIO30_MAGICIAN_BQ24022_nCHARGE_EN,
+	.enable_high = 0,
+	.enabled_at_boot = 0,
+
+	.gpios = bq24022_gpios,
+	.nr_gpios = ARRAY_SIZE(bq24022_gpios),
+
+	.states = bq24022_states,
+	.nr_states = ARRAY_SIZE(bq24022_states),
+
+	.type = REGULATOR_CURRENT,
+	.init_data = &bq24022_init_data,
 };
 
 static struct platform_device bq24022 = {
-	.name = "bq24022",
+	.name = "gpio-regulator",
 	.id   = -1,
 	.dev  = {
 		.platform_data = &bq24022_info,
-- 
1.7.5.4
