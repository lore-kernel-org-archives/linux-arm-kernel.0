From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Tue,  7 Sep 2010 17:32:24 +0300
Subject: [PATCH 1/3] rx1950: add battery device
In-Reply-To: <1283869946-28296-1-git-send-email-anarsoul@gmail.com>
References: <1283869946-28296-1-git-send-email-anarsoul@gmail.com>
Message-ID: <1283869946-28296-2-git-send-email-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 arch/arm/mach-s3c2440/Kconfig       |    3 +
 arch/arm/mach-s3c2440/mach-rx1950.c |  160 +++++++++++++++++++++++++++++++++++
 2 files changed, 163 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c2440/Kconfig b/arch/arm/mach-s3c2440/Kconfig
index cd8e7de..9b6b026 100644
--- a/arch/arm/mach-s3c2440/Kconfig
+++ b/arch/arm/mach-s3c2440/Kconfig
@@ -198,6 +198,9 @@ config MACH_RX1950
 	select S3C_DEV_NAND
 	select S3C2410_IOTIMING if S3C2440_CPUFREQ
 	select S3C2440_XTAL_16934400
+	select S3C_ADC
+	select PDA_POWER
+	select BATTERY_S3C_ADC
 	help
 	   Say Y here if you're using HP iPAQ rx1950
 
diff --git a/arch/arm/mach-s3c2440/mach-rx1950.c b/arch/arm/mach-s3c2440/mach-rx1950.c
index 142d1f9..1197ab4 100644
--- a/arch/arm/mach-s3c2440/mach-rx1950.c
+++ b/arch/arm/mach-s3c2440/mach-rx1950.c
@@ -25,8 +25,10 @@
 #include <linux/input.h>
 #include <linux/gpio_keys.h>
 #include <linux/sysdev.h>
+#include <linux/pda_power.h>
 #include <linux/pwm_backlight.h>
 #include <linux/pwm.h>
+#include <linux/s3c_adc_battery.h>
 
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
@@ -127,6 +129,162 @@ static struct s3c2410fb_display rx1950_display = {
 
 };
 
+static int power_supply_init(struct device *dev)
+{
+	return gpio_request(S3C2410_GPF(2), "cable plugged");
+}
+
+static int rx1950_is_ac_online(void)
+{
+	return !gpio_get_value(S3C2410_GPF(2));
+}
+
+static void power_supply_exit(struct device *dev)
+{
+	gpio_free(S3C2410_GPF(2));
+}
+
+static char *rx1950_supplicants[] = {
+	"main-battery"
+};
+
+static struct pda_power_pdata power_supply_info = {
+	.init				= power_supply_init,
+	.is_ac_online		= rx1950_is_ac_online,
+	.exit				= power_supply_exit,
+	.supplied_to		= rx1950_supplicants,
+	.num_supplicants	= ARRAY_SIZE(rx1950_supplicants),
+};
+
+static struct resource power_supply_resources[] = {
+	[0] = {
+			.name	= "ac",
+			.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_LOWEDGE |
+					  IORESOURCE_IRQ_HIGHEDGE,
+			.start	= IRQ_EINT2,
+			.end	= IRQ_EINT2,
+	},
+};
+
+static struct platform_device power_supply = {
+	.name			= "pda-power",
+	.id				= -1,
+	.dev			= {
+						.platform_data =
+							&power_supply_info,
+	},
+	.resource		= power_supply_resources,
+	.num_resources	= ARRAY_SIZE(power_supply_resources),
+};
+
+static const struct s3c_adc_bat_thresh bat_lut_noac[] = {
+	{4100, 156, 100},
+	{4050, 156, 95},
+	{4025, 141, 90},
+	{3995, 144, 85},
+	{3957, 162, 80},
+	{3931, 147, 75},
+	{3902, 147, 70},
+	{3863, 153, 65},
+	{3838, 150, 60},
+	{3800, 153, 55},
+	{3765, 153, 50},
+	{3748, 172, 45},
+	{3740, 153, 40},
+	{3714, 175, 35},
+	{3710, 156, 30},
+	{3963, 156, 25},
+	{3672, 178, 20},
+	{3651, 178, 15},
+	{3629, 178, 10},
+	{3612, 162, 5},
+	{3605, 162, 0},
+};
+
+static const struct s3c_adc_bat_thresh bat_lut_acin[] = {
+	{4200, 0, 100},
+	{4190, 0, 99},
+	{4178, 0, 95},
+	{4110, 0, 70},
+	{4076, 0, 65},
+	{4046, 0, 60},
+	{4021, 0, 55},
+	{3999, 0, 50},
+	{3982, 0, 45},
+	{3965, 0, 40},
+	{3957, 0, 35},
+	{3948, 0, 30},
+	{3936, 0, 25},
+	{3927, 0, 20},
+	{3906, 0, 15},
+	{3880, 0, 10},
+	{3829, 0, 5},
+	{3820, 0, 0},
+};
+
+int rx1950_bat_init(void)
+{
+	int ret;
+
+	ret = gpio_request(S3C2410_GPJ(2), "rx1950-charger-enable-1");
+	if (ret)
+		goto err_gpio1;
+	ret = gpio_request(S3C2410_GPJ(3), "rx1950-charger-enable-2");
+	if (ret)
+		goto err_gpio2;
+
+	return 0;
+
+err_gpio2:
+	gpio_free(S3C2410_GPJ(2));
+err_gpio1:
+	return ret;
+}
+
+void rx1950_bat_exit(void)
+{
+	gpio_free(S3C2410_GPJ(2));
+	gpio_free(S3C2410_GPJ(3));
+}
+
+void rx1950_enable_charger(void)
+{
+	gpio_direction_output(S3C2410_GPJ(2), 1);
+	gpio_direction_output(S3C2410_GPJ(3), 1);
+}
+
+void rx1950_disable_charger(void)
+{
+	gpio_direction_output(S3C2410_GPJ(2), 0);
+	gpio_direction_output(S3C2410_GPJ(3), 0);
+}
+
+static struct s3c_adc_bat_pdata rx1950_bat_cfg = {
+	.init = rx1950_bat_init,
+	.exit = rx1950_bat_exit,
+	.enable_charger = rx1950_enable_charger,
+	.disable_charger = rx1950_disable_charger,
+	.gpio_charge_finished = S3C2410_GPF(3),
+	.lut_noac = bat_lut_noac,
+	.lut_noac_cnt = ARRAY_SIZE(bat_lut_noac),
+	.lut_acin = bat_lut_acin,
+	.lut_acin_cnt = ARRAY_SIZE(bat_lut_acin),
+	.volt_channel = 0,
+	.current_channel = 1,
+	.volt_mult = 4235,
+	.current_mult = 2900,
+	.internal_impedance = 200,
+};
+
+static struct platform_device rx1950_battery = {
+	.name             = "s3c-adc-battery",
+	.id               = -1,
+	.dev = {
+		.parent = &s3c_device_adc.dev,
+		.platform_data = &rx1950_bat_cfg,
+	},
+};
+
 static struct s3c2410fb_mach_info rx1950_lcd_cfg = {
 	.displays = &rx1950_display,
 	.num_displays = 1,
@@ -503,6 +661,8 @@ static struct platform_device *rx1950_devices[] __initdata = {
 	&s3c_device_timer[1],
 	&rx1950_backlight,
 	&rx1950_device_gpiokeys,
+	&power_supply,
+	&rx1950_battery,
 };
 
 static struct clk *rx1950_clocks[] __initdata = {
-- 
1.7.2.2
