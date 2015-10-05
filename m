From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon,  5 Oct 2015 10:49:47 +0200
Subject: [PATCH 07/17] ARM: pxa: mainstone: Use PWM lookup table
In-Reply-To: <1444034997-9805-1-git-send-email-thierry.reding@gmail.com>
References: <1444034997-9805-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1444034997-9805-8-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use a PWM lookup table to provide the PWM to the pwm-backlight device.
The driver has a legacy code path that is required only because boards
still use the legacy method of requesting PWMs by global ID. Replacing
these usages allows that legacy fallback to be removed.

Cc: Daniel Mack <daniel@zonque.org>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Robert Jarzmik <robert.jarzmik@free.fr>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
---
 arch/arm/mach-pxa/mainstone.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-pxa/mainstone.c b/arch/arm/mach-pxa/mainstone.c
index 2c0658cf6be2..4ee9f59d45f5 100644
--- a/arch/arm/mach-pxa/mainstone.c
+++ b/arch/arm/mach-pxa/mainstone.c
@@ -26,6 +26,7 @@
 #include <linux/mtd/partitions.h>
 #include <linux/input.h>
 #include <linux/gpio_keys.h>
+#include <linux/pwm.h>
 #include <linux/pwm_backlight.h>
 #include <linux/smc91x.h>
 #include <linux/i2c/pxa-i2c.h>
@@ -248,11 +249,14 @@ static struct platform_device mst_flash_device[2] = {
 };
 
 #if defined(CONFIG_FB_PXA) || defined(CONFIG_FB_PXA_MODULE)
+static struct pwm_lookup mainstone_pwm_lookup[] = {
+	PWM_LOOKUP("pxa27x-pwm.0", 0, "pwm-backlight.0", NULL, 78770,
+		   PWM_POLARITY_NORMAL),
+};
+
 static struct platform_pwm_backlight_data mainstone_backlight_data = {
-	.pwm_id		= 0,
 	.max_brightness	= 1023,
 	.dft_brightness	= 1023,
-	.pwm_period_ns	= 78770,
 	.enable_gpio	= -1,
 };
 
@@ -266,9 +270,15 @@ static struct platform_device mainstone_backlight_device = {
 
 static void __init mainstone_backlight_register(void)
 {
-	int ret = platform_device_register(&mainstone_backlight_device);
-	if (ret)
+	int ret;
+
+	pwm_add_table(mainstone_pwm_lookup, ARRAY_SIZE(mainstone_pwm_lookup));
+
+	ret = platform_device_register(&mainstone_backlight_device);
+	if (ret) {
 		printk(KERN_ERR "mainstone: failed to register backlight device: %d\n", ret);
+		pwm_remove_table(mainstone_pwm_lookup, ARRAY_SIZE(mainstone_pwm_lookup));
+	}
 }
 #else
 #define mainstone_backlight_register()	do { } while (0)
-- 
2.5.0
