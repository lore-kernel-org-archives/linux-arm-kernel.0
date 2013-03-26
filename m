From: achew@nvidia.com (Andrew Chew)
Date: Mon, 25 Mar 2013 18:21:46 -0700
Subject: [PATCH V5 2/9] ARM: S3C24XX: Provide regulator to pwm-backlight
In-Reply-To: <1364260913-25490-1-git-send-email-achew@nvidia.com>
References: <1364260913-25490-1-git-send-email-achew@nvidia.com>
Message-ID: <1364260913-25490-3-git-send-email-achew@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pwm-backlight driver now takes a mandatory regulator that is gotten
during driver probe.  Initialize a dummy regulator to satisfy this
requirement.

Signed-off-by: Andrew Chew <achew@nvidia.com>
Acked-by: Alexandre Courbot <acourbot@nvidia.com>
---
 arch/arm/mach-s3c24xx/mach-h1940.c  | 8 ++++++++
 arch/arm/mach-s3c24xx/mach-rx1950.c | 9 +++++++++
 2 files changed, 17 insertions(+)

diff --git a/arch/arm/mach-s3c24xx/mach-h1940.c b/arch/arm/mach-s3c24xx/mach-h1940.c
index 8dd6601..008be7e 100644
--- a/arch/arm/mach-s3c24xx/mach-h1940.c
+++ b/arch/arm/mach-s3c24xx/mach-h1940.c
@@ -24,6 +24,8 @@
 #include <linux/gpio.h>
 #include <linux/input.h>
 #include <linux/gpio_keys.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/fixed.h>
 #include <linux/pwm_backlight.h>
 #include <linux/i2c.h>
 #include <linux/leds.h>
@@ -497,6 +499,9 @@ static void h1940_backlight_exit(struct device *dev)
 	gpio_set_value(H1940_LATCH_MAX1698_nSHUTDOWN, 0);
 }
 
+/* Dummy regulator for pwm-backlight driver */
+static struct regulator_consumer_supply backlight_supply =
+	REGULATOR_SUPPLY("power", "pwm-backlight");
 
 static struct platform_pwm_backlight_data backlight_data = {
 	.pwm_id         = 0,
@@ -720,6 +725,9 @@ static void __init h1940_init(void)
 	gpio_request(H1940_LATCH_SD_POWER, "SD power");
 	gpio_direction_output(H1940_LATCH_SD_POWER, 0);
 
+	regulator_register_always_on(-1, "backlight-power",
+				     &backlight_supply, 1, 0);
+
 	platform_add_devices(h1940_devices, ARRAY_SIZE(h1940_devices));
 
 	gpio_request(S3C2410_GPA(1), "Red LED blink");
diff --git a/arch/arm/mach-s3c24xx/mach-rx1950.c b/arch/arm/mach-s3c24xx/mach-rx1950.c
index e4d67a3..f6978b6 100644
--- a/arch/arm/mach-s3c24xx/mach-rx1950.c
+++ b/arch/arm/mach-s3c24xx/mach-rx1950.c
@@ -25,6 +25,8 @@
 #include <linux/gpio_keys.h>
 #include <linux/device.h>
 #include <linux/pda_power.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/fixed.h>
 #include <linux/pwm_backlight.h>
 #include <linux/pwm.h>
 #include <linux/s3c_adc_battery.h>
@@ -518,6 +520,10 @@ static int rx1950_backlight_notify(struct device *dev, int brightness)
 	return brightness;
 }
 
+/* Dummy regulator for pwm-backlight driver */
+static struct regulator_consumer_supply backlight_supply =
+	REGULATOR_SUPPLY("power", "pwm-backlight");
+
 static struct platform_pwm_backlight_data rx1950_backlight_data = {
 	.pwm_id = 0,
 	.max_brightness = 24,
@@ -795,6 +801,9 @@ static void __init rx1950_init_machine(void)
 	gpio_direction_output(S3C2410_GPA(4), 0);
 	gpio_direction_output(S3C2410_GPJ(6), 0);
 
+	regulator_register_always_on(-1, "backlight-power",
+				     &backlight_supply, 1, 0);
+
 	platform_add_devices(rx1950_devices, ARRAY_SIZE(rx1950_devices));
 
 	i2c_register_board_info(0, rx1950_i2c_devices,
-- 
1.8.1.5
