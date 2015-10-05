From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon,  5 Oct 2015 10:49:50 +0200
Subject: [PATCH 10/17] ARM: pxa: palmtc: Use PWM lookup table
In-Reply-To: <1444034997-9805-1-git-send-email-thierry.reding@gmail.com>
References: <1444034997-9805-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1444034997-9805-11-git-send-email-thierry.reding@gmail.com>
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
 arch/arm/mach-pxa/palmtc.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-pxa/palmtc.c b/arch/arm/mach-pxa/palmtc.c
index 7691c974ca4b..aebf6de62468 100644
--- a/arch/arm/mach-pxa/palmtc.c
+++ b/arch/arm/mach-pxa/palmtc.c
@@ -18,6 +18,7 @@
 #include <linux/delay.h>
 #include <linux/irq.h>
 #include <linux/input.h>
+#include <linux/pwm.h>
 #include <linux/pwm_backlight.h>
 #include <linux/gpio.h>
 #include <linux/input/matrix_keypad.h>
@@ -166,11 +167,14 @@ static inline void palmtc_keys_init(void) {}
  * Backlight
  ******************************************************************************/
 #if defined(CONFIG_BACKLIGHT_PWM) || defined(CONFIG_BACKLIGHT_PWM_MODULE)
+static struct pwm_lookup palmtc_pwm_lookup[] = {
+	PWM_LOOKUP("pxa25x-pwm.1", 0, "pwm-backlight.0", NULL, PALMTC_PERIOD_NS,
+		   PWM_PERIOD_NORMAL),
+};
+
 static struct platform_pwm_backlight_data palmtc_backlight_data = {
-	.pwm_id		= 1,
 	.max_brightness	= PALMTC_MAX_INTENSITY,
 	.dft_brightness	= PALMTC_MAX_INTENSITY,
-	.pwm_period_ns	= PALMTC_PERIOD_NS,
 	.enable_gpio	= GPIO_NR_PALMTC_BL_POWER,
 };
 
@@ -184,6 +188,7 @@ static struct platform_device palmtc_backlight = {
 
 static void __init palmtc_pwm_init(void)
 {
+	pwm_add_table(palmtc_pwm_lookup, ARRAY_SIZE(palmtc_pwm_lookup));
 	platform_device_register(&palmtc_backlight);
 }
 #else
-- 
2.5.0
