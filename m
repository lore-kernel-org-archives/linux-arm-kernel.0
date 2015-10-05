From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon,  5 Oct 2015 10:49:41 +0200
Subject: [PATCH 01/17] ARM: pxa: cm-x300: Use PWM lookup table
In-Reply-To: <1444034997-9805-1-git-send-email-thierry.reding@gmail.com>
References: <1444034997-9805-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1444034997-9805-2-git-send-email-thierry.reding@gmail.com>
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
 arch/arm/mach-pxa/cm-x300.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-pxa/cm-x300.c b/arch/arm/mach-pxa/cm-x300.c
index 5851f4c254c1..a7dae60810e8 100644
--- a/arch/arm/mach-pxa/cm-x300.c
+++ b/arch/arm/mach-pxa/cm-x300.c
@@ -26,6 +26,7 @@
 #include <linux/dm9000.h>
 #include <linux/leds.h>
 #include <linux/rtc-v3020.h>
+#include <linux/pwm.h>
 #include <linux/pwm_backlight.h>
 
 #include <linux/i2c.h>
@@ -305,11 +306,14 @@ static inline void cm_x300_init_lcd(void) {}
 #endif
 
 #if defined(CONFIG_BACKLIGHT_PWM) || defined(CONFIG_BACKLIGHT_PWM_MODULE)
+static struct pwm_lookup cm_x300_pwm_lookup[] = {
+	PWM_LOOKUP("pxa27x-pwm.0", 1, "pwm-backlight.0", NULL, 10000,
+		   PWM_POLARITY_NORMAL),
+};
+
 static struct platform_pwm_backlight_data cm_x300_backlight_data = {
-	.pwm_id		= 2,
 	.max_brightness	= 100,
 	.dft_brightness	= 100,
-	.pwm_period_ns	= 10000,
 	.enable_gpio	= -1,
 };
 
@@ -323,6 +327,7 @@ static struct platform_device cm_x300_backlight_device = {
 
 static void cm_x300_init_bl(void)
 {
+	pwm_add_table(cm_x300_pwm_lookup, ARRAY_SIZE(cm_x300_pwm_lookup));
 	platform_device_register(&cm_x300_backlight_device);
 }
 #else
-- 
2.5.0
