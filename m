From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon,  5 Oct 2015 10:49:53 +0200
Subject: [PATCH 13/17] ARM: pxa: raumfeld: Use PWM lookup table
In-Reply-To: <1444034997-9805-1-git-send-email-thierry.reding@gmail.com>
References: <1444034997-9805-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1444034997-9805-14-git-send-email-thierry.reding@gmail.com>
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
 arch/arm/mach-pxa/raumfeld.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-pxa/raumfeld.c b/arch/arm/mach-pxa/raumfeld.c
index 88f70c37ad0d..adb96d8d5b7a 100644
--- a/arch/arm/mach-pxa/raumfeld.c
+++ b/arch/arm/mach-pxa/raumfeld.c
@@ -29,6 +29,7 @@
 #include <linux/leds.h>
 #include <linux/w1-gpio.h>
 #include <linux/sched.h>
+#include <linux/pwm.h>
 #include <linux/pwm_backlight.h>
 #include <linux/i2c.h>
 #include <linux/i2c/pxa-i2c.h>
@@ -531,13 +532,15 @@ static void __init raumfeld_w1_init(void)
  * Framebuffer device
  */
 
+static struct pwm_lookup raumfeld_pwm_lookup[] = {
+	PWM_LOOKUP("pxa27x-pwm.0", 0, "pwm-backlight", NULL, 10000,
+		   PWM_POLARITY_NORMAL),
+};
+
 /* PWM controlled backlight */
 static struct platform_pwm_backlight_data raumfeld_pwm_backlight_data = {
-	.pwm_id		= 0,
 	.max_brightness	= 100,
 	.dft_brightness	= 100,
-	/* 10000 ns = 10 ms ^= 100 kHz */
-	.pwm_period_ns	= 10000,
 	.enable_gpio	= -1,
 };
 
@@ -618,6 +621,8 @@ static void __init raumfeld_lcd_init(void)
 	} else {
 		mfp_cfg_t raumfeld_pwm_pin_config = GPIO17_PWM0_OUT;
 		pxa3xx_mfp_config(&raumfeld_pwm_pin_config, 1);
+		pwm_add_table(raumfeld_pwm_lookup,
+			      ARRAY_SIZE(raumfeld_pwm_lookup));
 		platform_device_register(&raumfeld_pwm_backlight_device);
 	}
 
-- 
2.5.0
