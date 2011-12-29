From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 29 Dec 2011 01:31:59 +0000
Subject: [PATCH] ARM: S3C64XX: Add hookup for Tomatin module on Cragganmore
Message-ID: <1325122319-5148-1-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Tomatin module carries a WM0010 audio DSP. Provide basic hookup for
this, though additional platform data will be needed to fully integrate
with the driver.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/mach-s3c64xx/mach-crag6410-module.c |   27 +++++++++++++++++++++++++-
 arch/arm/mach-s3c64xx/mach-crag6410.c        |   12 ++++++++++-
 2 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/mach-crag6410-module.c b/arch/arm/mach-s3c64xx/mach-crag6410-module.c
index cd3c97e..b4ed351 100644
--- a/arch/arm/mach-s3c64xx/mach-crag6410-module.c
+++ b/arch/arm/mach-s3c64xx/mach-crag6410-module.c
@@ -11,6 +11,7 @@
 #include <linux/export.h>
 #include <linux/interrupt.h>
 #include <linux/i2c.h>
+#include <linux/spi/spi.h>
 
 #include <linux/mfd/wm831x/irq.h>
 #include <linux/mfd/wm831x/gpio.h>
@@ -21,8 +22,25 @@
 #include <sound/wm8962.h>
 #include <sound/wm9081.h>
 
+#include <plat/s3c64xx-spi.h>
+
 #include <mach/crag6410.h>
 
+static struct s3c64xx_spi_csinfo wm0010_spi_csinfo = {
+	.set_level = gpio_set_value,
+	.line = S3C64XX_GPC(3),
+};
+
+static struct spi_board_info wm1253_devs[] = {
+	[0] = {
+		.modalias	= "wm0010",
+		.bus_num	= 0,
+		.chip_select	= 0,
+		.mode		= SPI_MODE_0,
+		.controller_data = &wm0010_spi_csinfo,
+	},
+};
+
 static struct wm5100_pdata wm5100_pdata = {
 	.ldo_ena = S3C64XX_GPN(7),
 	.irq_flags = IRQF_TRIGGER_HIGH,
@@ -158,6 +176,8 @@ static __devinitdata const struct {
 	const char *name;
 	const struct i2c_board_info *i2c_devs;
 	int num_i2c_devs;
+	const struct spi_board_info *spi_devs;
+	int num_spi_devs;
 } gf_mods[] = {
 	{ .id = 0x01, .name = "1250-EV1 Springbank" },
 	{ .id = 0x02, .name = "1251-EV1 Jura" },
@@ -165,7 +185,8 @@ static __devinitdata const struct {
 	{ .id = 0x11, .name = "6249-EV2 Glenfarclas", },
 	{ .id = 0x21, .name = "1275-EV1 Mortlach" },
 	{ .id = 0x25, .name = "1274-EV1 Glencadam" },
-	{ .id = 0x31, .name = "1253-EV1 Tomatin", },
+	{ .id = 0x31, .name = "1253-EV1 Tomatin",
+	  .spi_devs = wm1253_devs, .num_spi_devs = ARRAY_SIZE(wm1253_devs) },
 	{ .id = 0x39, .name = "1254-EV1 Dallas Dhu",
 	  .i2c_devs = wm1254_devs, .num_i2c_devs = ARRAY_SIZE(wm1254_devs) },
 	{ .id = 0x3a, .name = "1259-EV1 Tobermory",
@@ -197,12 +218,16 @@ static __devinit int wlf_gf_module_probe(struct i2c_client *i2c,
 	if (i < ARRAY_SIZE(gf_mods)) {
 		dev_info(&i2c->dev, "%s revision %d\n",
 			 gf_mods[i].name, rev + 1);
+
 		for (j = 0; j < gf_mods[i].num_i2c_devs; j++) {
 			if (!i2c_new_device(i2c->adapter,
 					    &(gf_mods[i].i2c_devs[j])))
 				dev_err(&i2c->dev,
 					"Failed to register dev: %d\n", ret);
 		}
+
+		spi_register_board_info(gf_mods[i].spi_devs,
+					gf_mods[i].num_spi_devs);
 	} else {
 		dev_warn(&i2c->dev, "Unknown module ID 0x%x revision %d\n",
 			 id, rev + 1);
diff --git a/arch/arm/mach-s3c64xx/mach-crag6410.c b/arch/arm/mach-s3c64xx/mach-crag6410.c
index f4c0a12..df2820e 100644
--- a/arch/arm/mach-s3c64xx/mach-crag6410.c
+++ b/arch/arm/mach-s3c64xx/mach-crag6410.c
@@ -575,11 +575,19 @@ static struct s3c2410_platform_i2c i2c0_pdata = {
 	.frequency = 400000,
 };
 
+static struct regulator_consumer_supply pvdd_1v2_consumers[] __initdata = {
+	REGULATOR_SUPPLY("DCVDD", "spi0.0"),
+	REGULATOR_SUPPLY("AVDD", "spi0.0"),
+};
+
 static struct regulator_init_data pvdd_1v2 __initdata = {
 	.constraints = {
 		.name = "PVDD_1V2",
-		.always_on = 1,
+		.valid_ops_mask = REGULATOR_CHANGE_STATUS,
 	},
+
+	.consumer_supplies = pvdd_1v2_consumers,
+	.num_consumer_supplies = ARRAY_SIZE(pvdd_1v2_consumers),
 };
 
 static struct regulator_consumer_supply pvdd_1v8_consumers[] __initdata = {
@@ -593,6 +601,7 @@ static struct regulator_consumer_supply pvdd_1v8_consumers[] __initdata = {
 	REGULATOR_SUPPLY("AVDD2", "1-001a"),
 	REGULATOR_SUPPLY("DCVDD", "1-001a"),
 	REGULATOR_SUPPLY("AVDD", "1-001a"),
+	REGULATOR_SUPPLY("DBVDD", "spi0.0"),
 };
 
 static struct regulator_init_data pvdd_1v8 __initdata = {
@@ -776,6 +785,7 @@ static void __init crag6410_machine_init(void)
 	i2c_register_board_info(1, i2c_devs1, ARRAY_SIZE(i2c_devs1));
 
 	samsung_keypad_set_platdata(&crag6410_keypad_data);
+	s3c64xx_spi0_set_platdata(NULL, 0, 1);
 
 	platform_add_devices(crag6410_devices, ARRAY_SIZE(crag6410_devices));
 
-- 
1.7.7.3
