From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 20 Sep 2010 14:55:37 +0200
Subject: [PATCHv2 7/7] ARM: S5PC110: add support for MMC regulators on Goni
	board
In-Reply-To: <1284987337-15365-1-git-send-email-m.szyprowski@samsung.com>
References: <1284987337-15365-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1284987337-15365-8-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add required platform definitions for MMC power regulators on Samsung
Goni board. GPIO pin GONI_EXT_FLASH_EN has been transferred from machine
startup code to fixed voltage regulator.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
CC: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/mach-s5pv210/mach-goni.c |   40 ++++++++++++++++++++++++++++++++++--
 1 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-s5pv210/mach-goni.c b/arch/arm/mach-s5pv210/mach-goni.c
index 68e22f2..a7fbe08 100644
--- a/arch/arm/mach-s5pv210/mach-goni.c
+++ b/arch/arm/mach-s5pv210/mach-goni.c
@@ -16,6 +16,7 @@
 #include <linux/i2c.h>
 #include <linux/i2c-gpio.h>
 #include <linux/mfd/max8998.h>
+#include <linux/regulator/fixed.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/spi_gpio.h>
 #include <linux/lcd.h>
@@ -226,6 +227,10 @@ static void __init goni_radio_init(void)
 /* MAX8998 regulators */
 #if defined(CONFIG_REGULATOR_MAX8998) || defined(CONFIG_REGULATOR_MAX8998_MODULE)
 
+static struct regulator_consumer_supply goni_ldo5_consumers[] = {
+	REGULATOR_SUPPLY("vmmc", "s3c-sdhci.0"),
+};
+
 static struct regulator_init_data goni_ldo2_data = {
 	.constraints	= {
 		.name		= "VALIVE_1.1V",
@@ -265,6 +270,8 @@ static struct regulator_init_data goni_ldo5_data = {
 		.max_uV		= 2800000,
 		.apply_uV	= 1,
 	},
+	.num_consumer_supplies = ARRAY_SIZE(goni_ldo5_consumers),
+	.consumer_supplies = goni_ldo5_consumers,
 };
 
 static struct regulator_init_data goni_ldo6_data = {
@@ -556,11 +563,37 @@ static struct s3c_sdhci_platdata goni_hsmmc2_data __initdata = {
 	.ext_cd_gpio_invert	= 1,
 };
 
+static struct regulator_consumer_supply mmc2_supplies[] = {
+	REGULATOR_SUPPLY("vmmc", "s3c-sdhci.2"),
+};
+
+static struct regulator_init_data mmc2_fixed_voltage_init_data = {
+	.constraints		= {
+		.name		= "V_TF_2.8V",
+		.valid_ops_mask	= REGULATOR_CHANGE_STATUS,
+	},
+	.num_consumer_supplies	= ARRAY_SIZE(mmc2_supplies),
+	.consumer_supplies	= mmc2_supplies,
+};
+
+static struct fixed_voltage_config mmc2_fixed_voltage_config = {
+	.supply_name		= "EXT_FLASH_EN",
+	.microvolts		= 2800000,
+	.gpio			= GONI_EXT_FLASH_EN,
+	.enable_high		= true,
+	.init_data		= &mmc2_fixed_voltage_init_data,
+};
+
+static struct platform_device mmc2_fixed_voltage = {
+	.name		= "reg-fixed-voltage",
+	.id		= 2,
+	.dev		= {
+		.platform_data	= &mmc2_fixed_voltage_config,
+	},
+};
+
 static void goni_setup_sdhci(void)
 {
-	gpio_request(GONI_EXT_FLASH_EN, "FLASH_EN");
-	gpio_direction_output(GONI_EXT_FLASH_EN, 1);
-
 	s3c_sdhci0_set_platdata(&goni_hsmmc0_data);
 	s3c_sdhci1_set_platdata(&goni_hsmmc1_data);
 	s3c_sdhci2_set_platdata(&goni_hsmmc2_data);
@@ -572,6 +605,7 @@ static struct platform_device *goni_devices[] __initdata = {
 	&goni_spi_gpio,
 	&s3c_device_usb_hsotg,
 	&goni_i2c_gpio_pmic,
+	&mmc2_fixed_voltage,
 	&goni_device_gpiokeys,
 	&s5p_device_fimc0,
 	&s5p_device_fimc1,
-- 
1.7.1.569.g6f426
