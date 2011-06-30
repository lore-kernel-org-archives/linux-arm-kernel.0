From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Thu, 30 Jun 2011 17:15:28 +0900
Subject: [PATCH v3 5/6] Exynos4 NURI: configure MAX8903 secondary charger
In-Reply-To: <1309421729-11172-1-git-send-email-myungjoo.ham@samsung.com>
References: <1309421729-11172-1-git-send-email-myungjoo.ham@samsung.com>
Message-ID: <1309421729-11172-6-git-send-email-myungjoo.ham@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-exynos4/mach-nuri.c |   78 +++++++++++++++++++++++++++++++++++++
 1 files changed, 78 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-exynos4/mach-nuri.c b/arch/arm/mach-exynos4/mach-nuri.c
index e81e8ca..0c9401c 100644
--- a/arch/arm/mach-exynos4/mach-nuri.c
+++ b/arch/arm/mach-exynos4/mach-nuri.c
@@ -16,6 +16,7 @@
 #include <linux/i2c-gpio.h>
 #include <linux/gpio_keys.h>
 #include <linux/gpio.h>
+#include <linux/power/max8903_charger.h>
 #include <linux/power/max17042_battery.h>
 #include <linux/regulator/machine.h>
 #include <linux/regulator/fixed.h>
@@ -58,6 +59,7 @@
 
 enum fixed_regulator_id {
 	FIXED_REG_ID_MMC = 0,
+	FIXED_REG_ID_MAX8903,
 };
 
 static struct s3c2410_uartcfg nuri_uartcfgs[] __initdata = {
@@ -980,10 +982,70 @@ static struct i2c_board_info i2c9_devs[] __initdata = {
 	},
 };
 
+/* MAX8903 Secondary Charger */
+static struct regulator_consumer_supply supplies_max8903[] = {
+	REGULATOR_SUPPLY("vinchg2", "charger-manager.0"),
+};
+
+static struct regulator_init_data max8903_charger_en_data = {
+	.constraints = {
+		.name		= "VOUT_CHARGER",
+		.valid_ops_mask = REGULATOR_CHANGE_STATUS,
+		.boot_on	= 1,
+	},
+	.num_consumer_supplies = ARRAY_SIZE(supplies_max8903),
+	.consumer_supplies = supplies_max8903,
+};
+
+static struct fixed_voltage_config max8903_charger_en = {
+	.supply_name = "VOUT_CHARGER",
+	.microvolts = 5000000, /* Assume 5VDC */
+	.gpio = EXYNOS4_GPY4(5), /* TA_EN negaged */
+	.enable_high = 0, /* Enable = Low */
+	.enabled_at_boot = 1,
+	.init_data = &max8903_charger_en_data,
+};
+
+static struct platform_device max8903_fixed_reg_dev = {
+	.name = "reg-fixed-voltage",
+	.id = FIXED_REG_ID_MAX8903,
+	.dev = { .platform_data	= &max8903_charger_en },
+};
+
+static struct max8903_pdata nuri_max8903 = {
+	/*
+	 * cen: don't control with the driver, let it be
+	 * controlled by regulator above
+	 */
+	.dok = EXYNOS4_GPX1(4), /* TA_nCONNECTED */
+	/* uok, usus: not connected */
+	.chg = EXYNOS4_GPE2(0), /* TA_nCHG */
+	/* flt: vcc_1.8V_pda */
+	.dcm = EXYNOS4_GPL0(1), /* CURR_ADJ */
+
+	.dc_valid = true,
+	.usb_valid = false, /* USB is not wired to MAX8903 */
+};
+
+static struct platform_device nuri_max8903_device = {
+	.name			= "max8903-charger",
+	.dev			= {
+		.platform_data	= &nuri_max8903,
+	},
+};
+
+static struct device *nuri_cm_devices[] = {
+	&s3c_device_i2c5.dev,
+	&s3c_device_adc.dev,
+	NULL, /* Reserved for UART */
+	NULL,
+};
+
 static void __init nuri_power_init(void)
 {
 	int gpio;
 	int irq_base = IRQ_GPIO_END + 1;
+	int ta_en = 0;
 
 	nuri_max8997_pdata.irq_base = irq_base;
 	irq_base += MAX8997_IRQ_NR;
@@ -997,6 +1059,20 @@ static void __init nuri_power_init(void)
 	gpio_request(gpio, "FUEL_ALERT");
 	s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(0xf));
 	s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
+
+	gpio = nuri_max8903.dok;
+	gpio_request(gpio, "TA_nCONNECTED");
+	s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(0xf));
+	s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
+	ta_en = gpio_get_value(gpio) ? 0 : 1;
+
+	gpio = nuri_max8903.chg;
+	gpio_request(gpio, "TA_nCHG");
+	gpio_direction_input(gpio);
+
+	gpio = nuri_max8903.dcm;
+	gpio_request(gpio, "CURR_ADJ");
+	gpio_direction_output(gpio, ta_en);
 }
 
 /* USB EHCI */
@@ -1027,6 +1103,8 @@ static struct platform_device *nuri_devices[] __initdata = {
 	&nuri_gpio_keys,
 	&nuri_lcd_device,
 	&nuri_backlight_device,
+	&max8903_fixed_reg_dev,
+	&nuri_max8903_device,
 };
 
 static void __init nuri_map_io(void)
-- 
1.7.4.1
