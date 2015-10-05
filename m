From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon,  5 Oct 2015 14:47:14 +0200
Subject: [PATCH 3/6] ARM: s3c64xx: smdk6410: Use PWM lookup table
In-Reply-To: <1444049237-29878-1-git-send-email-thierry.reding@gmail.com>
References: <1444049237-29878-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1444049237-29878-4-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use a PWM lookup table to provide the PWM to the pwm-backlight device.
The driver has a legacy code path that is required only because boards
still use the legacy method of requesting PWMs by global ID. Replacing
these usages allows that legacy fallback to be removed.

Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
---
 arch/arm/mach-s3c64xx/dev-backlight.c | 4 ----
 arch/arm/mach-s3c64xx/mach-smdk6410.c | 8 +++++++-
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/dev-backlight.c b/arch/arm/mach-s3c64xx/dev-backlight.c
index 38c323e68e3f..e62e789f9aee 100644
--- a/arch/arm/mach-s3c64xx/dev-backlight.c
+++ b/arch/arm/mach-s3c64xx/dev-backlight.c
@@ -69,7 +69,6 @@ static struct samsung_bl_drvdata samsung_dfl_bl_data __initdata = {
 	.plat_data = {
 		.max_brightness = 255,
 		.dft_brightness = 255,
-		.pwm_period_ns  = 78770,
 		.enable_gpio    = -1,
 		.init           = samsung_bl_init,
 		.exit           = samsung_bl_exit,
@@ -111,7 +110,6 @@ void __init samsung_bl_set(struct samsung_bl_gpio_info *gpio_info,
 	samsung_bl_data = &samsung_bl_drvdata->plat_data;
 
 	/* Copy board specific data provided by user */
-	samsung_bl_data->pwm_id = bl_data->pwm_id;
 	samsung_bl_device->dev.parent = &samsung_device_pwm.dev;
 
 	if (bl_data->max_brightness)
@@ -120,8 +118,6 @@ void __init samsung_bl_set(struct samsung_bl_gpio_info *gpio_info,
 		samsung_bl_data->dft_brightness = bl_data->dft_brightness;
 	if (bl_data->lth_brightness)
 		samsung_bl_data->lth_brightness = bl_data->lth_brightness;
-	if (bl_data->pwm_period_ns)
-		samsung_bl_data->pwm_period_ns = bl_data->pwm_period_ns;
 	if (bl_data->enable_gpio >= 0)
 		samsung_bl_data->enable_gpio = bl_data->enable_gpio;
 	if (bl_data->init)
diff --git a/arch/arm/mach-s3c64xx/mach-smdk6410.c b/arch/arm/mach-s3c64xx/mach-smdk6410.c
index d590b88bd8a8..2722800d5c11 100644
--- a/arch/arm/mach-s3c64xx/mach-smdk6410.c
+++ b/arch/arm/mach-s3c64xx/mach-smdk6410.c
@@ -30,6 +30,7 @@
 #include <linux/smsc911x.h>
 #include <linux/regulator/fixed.h>
 #include <linux/regulator/machine.h>
+#include <linux/pwm.h>
 #include <linux/pwm_backlight.h>
 #include <linux/platform_data/s3c-hsotg.h>
 
@@ -623,8 +624,12 @@ static struct samsung_bl_gpio_info smdk6410_bl_gpio_info = {
 	.func = S3C_GPIO_SFN(2),
 };
 
+static struct pwm_lookup smdk6410_pwm_lookup[] = {
+	PWM_LOOKUP("samsung-pwm", 1, "pwm-backlight.0", NULL, 78770,
+		   PWM_POLARITY_NORMAL),
+};
+
 static struct platform_pwm_backlight_data smdk6410_bl_data = {
-	.pwm_id = 1,
 	.enable_gpio = -1,
 };
 
@@ -695,6 +700,7 @@ static void __init smdk6410_machine_init(void)
 
 	platform_add_devices(smdk6410_devices, ARRAY_SIZE(smdk6410_devices));
 
+	pwm_add_table(smdk6410_pwm_lookup, ARRAY_SIZE(smdk6410_pwm_lookup));
 	samsung_bl_set(&smdk6410_bl_gpio_info, &smdk6410_bl_data);
 }
 
-- 
2.5.0
