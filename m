From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Fri,  9 Jul 2010 14:27:22 +0300
Subject: [PATCH 3/3] rx1950: add battery device
In-Reply-To: <1278674842-17583-1-git-send-email-anarsoul@gmail.com>
References: <1278674842-17583-1-git-send-email-anarsoul@gmail.com>
Message-ID: <1278674842-17583-4-git-send-email-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 arch/arm/mach-s3c2440/Kconfig       |    2 +
 arch/arm/mach-s3c2440/mach-rx1950.c |  111 +++++++++++++++++++++++++++++++++++
 2 files changed, 113 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c2440/Kconfig b/arch/arm/mach-s3c2440/Kconfig
index cd8e7de..ee3137e 100644
--- a/arch/arm/mach-s3c2440/Kconfig
+++ b/arch/arm/mach-s3c2440/Kconfig
@@ -198,6 +198,8 @@ config MACH_RX1950
 	select S3C_DEV_NAND
 	select S3C2410_IOTIMING if S3C2440_CPUFREQ
 	select S3C2440_XTAL_16934400
+	select S3C_ADC
+	select BATTERY_S3C_ADC
 	help
 	   Say Y here if you're using HP iPAQ rx1950
 
diff --git a/arch/arm/mach-s3c2440/mach-rx1950.c b/arch/arm/mach-s3c2440/mach-rx1950.c
index 55b806a..a335eb9 100644
--- a/arch/arm/mach-s3c2440/mach-rx1950.c
+++ b/arch/arm/mach-s3c2440/mach-rx1950.c
@@ -26,6 +26,7 @@
 #include <linux/sysdev.h>
 #include <linux/pwm_backlight.h>
 #include <linux/pwm.h>
+#include <linux/s3c_adc_battery.h>
 
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
@@ -131,6 +132,115 @@ static struct platform_device rx1950_device_leds = {
 	.id               = -1,
 };
 
+static const struct s3c_adc_batt_thresh batt_lut_noac[] = {
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
+static const struct s3c_adc_batt_thresh batt_lut_acin[] = {
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
+int rx1950_batt_init(void)
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
+void rx1950_batt_exit(void)
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
+static struct s3c_adc_batt_pdata rx1950_batt_cfg = {
+	.init = rx1950_batt_init,
+	.exit = rx1950_batt_exit,
+	.enable_charger = rx1950_enable_charger,
+	.disable_charger = rx1950_disable_charger,
+	.gpio_cable_plugged = S3C2410_GPF(2),
+	.gpio_charge_finished = S3C2410_GPF(3),
+	.lut_noac = batt_lut_noac,
+	.lut_noac_cnt = ARRAY_SIZE(batt_lut_noac),
+	.lut_acin = batt_lut_acin,
+	.lut_acin_cnt = ARRAY_SIZE(batt_lut_acin),
+	.volt_channel = 0,
+	.current_channel = 1,
+	.volt_mult = 4235,
+	.current_mult = 2900,
+	.internal_impedance = 200,
+};
+
+static struct platform_device rx1950_device_battery = {
+	.name             = "s3c-adc-battery",
+	.id               = -1,
+	.dev = {
+		.parent = &s3c_device_adc.dev,
+		.platform_data = &rx1950_batt_cfg,
+	},
+};
+
 static struct s3c2410fb_mach_info rx1950_lcd_cfg = {
 	.displays = &rx1950_display,
 	.num_displays = 1,
@@ -508,6 +618,7 @@ static struct platform_device *rx1950_devices[] __initdata = {
 	&rx1950_backlight,
 	&rx1950_device_gpiokeys,
 	&rx1950_device_leds,
+	&rx1950_device_battery,
 };
 
 static struct clk *rx1950_clocks[] __initdata = {
-- 
1.7.1
