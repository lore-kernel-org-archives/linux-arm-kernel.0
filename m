From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon,  5 Oct 2015 10:49:42 +0200
Subject: [PATCH 02/17] ARM: pxa: colibri-pxa270-income: Use PWM lookup table
In-Reply-To: <1444034997-9805-1-git-send-email-thierry.reding@gmail.com>
References: <1444034997-9805-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1444034997-9805-3-git-send-email-thierry.reding@gmail.com>
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
 arch/arm/mach-pxa/colibri-pxa270-income.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-pxa/colibri-pxa270-income.c b/arch/arm/mach-pxa/colibri-pxa270-income.c
index 3aa264640c9d..db20d25daaab 100644
--- a/arch/arm/mach-pxa/colibri-pxa270-income.c
+++ b/arch/arm/mach-pxa/colibri-pxa270-income.c
@@ -20,6 +20,7 @@
 #include <linux/ioport.h>
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
+#include <linux/pwm.h>
 #include <linux/pwm_backlight.h>
 #include <linux/i2c/pxa-i2c.h>
 
@@ -184,11 +185,14 @@ static inline void income_lcd_init(void) {}
  * Backlight
  ******************************************************************************/
 #if defined(CONFIG_BACKLIGHT_PWM) || defined(CONFIG_BACKLIGHT_PWM_MODULE)
+static struct pwm_lookup income_pwm_lookup[] = {
+	PWM_LOOKUP("pxa27x-pwm.0", 0, "pwm-backlight.0", NULL, 1000000,
+		   PWM_POLARITY_NORMAL),
+};
+
 static struct platform_pwm_backlight_data income_backlight_data = {
-	.pwm_id		= 0,
 	.max_brightness	= 0x3ff,
 	.dft_brightness	= 0x1ff,
-	.pwm_period_ns	= 1000000,
 	.enable_gpio	= -1,
 };
 
@@ -202,6 +206,7 @@ static struct platform_device income_backlight = {
 
 static void __init income_pwm_init(void)
 {
+	pwm_add_table(income_pwm_lookup, ARRAY_SIZE(income_pwm_lookup));
 	platform_device_register(&income_backlight);
 }
 #else
-- 
2.5.0
