From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Thu,  6 Jan 2011 21:52:49 +0200
Subject: [PATCH 4/7] ARM: S3C2410: H1940: Add battery support
In-Reply-To: <1294343572-28518-1-git-send-email-anarsoul@gmail.com>
References: <1294343572-28518-1-git-send-email-anarsoul@gmail.com>
Message-ID: <1294343572-28518-5-git-send-email-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add battery monitoring/charging support via pda_power and
s3c_adc_battery drivers

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 arch/arm/mach-s3c2410/mach-h1940.c |  144 ++++++++++++++++++++++++++++++++++++
 1 files changed, 144 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c2410/mach-h1940.c b/arch/arm/mach-s3c2410/mach-h1940.c
index 5d0d2ae..6a3cf78 100644
--- a/arch/arm/mach-s3c2410/mach-h1940.c
+++ b/arch/arm/mach-s3c2410/mach-h1940.c
@@ -28,6 +28,8 @@
 #include <linux/pwm_backlight.h>
 #include <linux/i2c.h>
 #include <linux/leds.h>
+#include <linux/pda_power.h>
+#include <linux/s3c_adc_battery.h>
 
 #include <video/platform_lcd.h>
 
@@ -237,6 +239,146 @@ static struct s3c2410fb_mach_info h1940_fb_info __initdata = {
 	.gpdup_mask=	0xffffffff,
 };
 
+static int power_supply_init(struct device *dev)
+{
+	return gpio_request(S3C2410_GPF(2), "cable plugged");
+}
+
+static int h1940_is_ac_online(void)
+{
+	return !gpio_get_value(S3C2410_GPF(2));
+}
+
+static void power_supply_exit(struct device *dev)
+{
+	gpio_free(S3C2410_GPF(2));
+}
+
+static char *h1940_supplicants[] = {
+	"main-battery",
+	"backup-battery",
+};
+
+static struct pda_power_pdata power_supply_info = {
+	.init			= power_supply_init,
+	.is_ac_online		= h1940_is_ac_online,
+	.exit			= power_supply_exit,
+	.supplied_to		= h1940_supplicants,
+	.num_supplicants	= ARRAY_SIZE(h1940_supplicants),
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
+	.name		= "pda-power",
+	.id		= -1,
+	.dev		= {
+				.platform_data =
+					&power_supply_info,
+	},
+	.resource	= power_supply_resources,
+	.num_resources	= ARRAY_SIZE(power_supply_resources),
+};
+
+static const struct s3c_adc_bat_thresh bat_lut_noac[] = {
+	{ .volt = 4070, .cur = 162, .level = 100},
+	{ .volt = 4040, .cur = 165, .level = 95},
+	{ .volt = 4016, .cur = 164, .level = 90},
+	{ .volt = 3996, .cur = 166, .level = 85},
+	{ .volt = 3971, .cur = 168, .level = 80},
+	{ .volt = 3951, .cur = 168, .level = 75},
+	{ .volt = 3931, .cur = 170, .level = 70},
+	{ .volt = 3903, .cur = 172, .level = 65},
+	{ .volt = 3886, .cur = 172, .level = 60},
+	{ .volt = 3858, .cur = 176, .level = 55},
+	{ .volt = 3842, .cur = 176, .level = 50},
+	{ .volt = 3818, .cur = 176, .level = 45},
+	{ .volt = 3789, .cur = 180, .level = 40},
+	{ .volt = 3769, .cur = 180, .level = 35},
+	{ .volt = 3749, .cur = 184, .level = 30},
+	{ .volt = 3732, .cur = 184, .level = 25},
+	{ .volt = 3716, .cur = 184, .level = 20},
+	{ .volt = 3708, .cur = 184, .level = 15},
+	{ .volt = 3716, .cur = 96, .level = 10},
+	{ .volt = 3700, .cur = 96, .level = 5},
+	{ .volt = 3684, .cur = 96, .level = 0},
+};
+
+static const struct s3c_adc_bat_thresh bat_lut_acin[] = {
+	{ .volt = 4130, .cur = 0, .level = 100},
+	{ .volt = 3982, .cur = 0, .level = 50},
+	{ .volt = 3854, .cur = 0, .level = 10},
+	{ .volt = 3841, .cur = 0, .level = 0},
+};
+
+int h1940_bat_init(void)
+{
+	int ret;
+
+	ret = gpio_request(H1940_LATCH_SM803_ENABLE, "h1940-charger-enable");
+	if (ret)
+		return ret;
+	gpio_direction_output(H1940_LATCH_SM803_ENABLE, 0);
+
+	return 0;
+
+}
+
+void h1940_bat_exit(void)
+{
+	gpio_free(H1940_LATCH_SM803_ENABLE);
+}
+
+void h1940_enable_charger(void)
+{
+	gpio_set_value(H1940_LATCH_SM803_ENABLE, 1);
+}
+
+void h1940_disable_charger(void)
+{
+	gpio_set_value(H1940_LATCH_SM803_ENABLE, 0);
+}
+
+static struct s3c_adc_bat_pdata h1940_bat_cfg = {
+	.init = h1940_bat_init,
+	.exit = h1940_bat_exit,
+	.enable_charger = h1940_enable_charger,
+	.disable_charger = h1940_disable_charger,
+	.gpio_charge_finished = S3C2410_GPF(3),
+	.gpio_inverted = 1,
+	.lut_noac = bat_lut_noac,
+	.lut_noac_cnt = ARRAY_SIZE(bat_lut_noac),
+	.lut_acin = bat_lut_acin,
+	.lut_acin_cnt = ARRAY_SIZE(bat_lut_acin),
+	.volt_channel = 0,
+	.current_channel = 1,
+	.volt_mult = 4056,
+	.current_mult = 1893,
+	.internal_impedance = 200,
+	.backup_volt_channel = 3,
+	/* TODO Check backup volt multiplier */
+	.backup_volt_mult = 4056,
+	.backup_volt_min = 0,
+	.backup_volt_max = 4149288
+};
+
+static struct platform_device h1940_battery = {
+	.name             = "s3c-adc-battery",
+	.id               = -1,
+	.dev = {
+		.parent = &s3c_device_adc.dev,
+		.platform_data = &h1940_bat_cfg,
+	},
+};
+
 DEFINE_SPINLOCK(h1940_blink_spin);
 
 int h1940_led_blink_set(unsigned gpio, int state,
@@ -517,6 +659,8 @@ static struct platform_device *h1940_devices[] __initdata = {
 	&h1940_lcd_powerdev,
 	&s3c_device_adc,
 	&s3c_device_ts,
+	&power_supply,
+	&h1940_battery,
 };
 
 static void __init h1940_map_io(void)
-- 
1.7.3.2
