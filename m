From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon,  5 Oct 2015 10:49:56 +0200
Subject: [PATCH 16/17] ARM: pxa: z2: Use PWM lookup table
In-Reply-To: <1444034997-9805-1-git-send-email-thierry.reding@gmail.com>
References: <1444034997-9805-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1444034997-9805-17-git-send-email-thierry.reding@gmail.com>
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
 arch/arm/mach-pxa/z2.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-pxa/z2.c b/arch/arm/mach-pxa/z2.c
index 36caac726ea7..9c9c2ebdb422 100644
--- a/arch/arm/mach-pxa/z2.c
+++ b/arch/arm/mach-pxa/z2.c
@@ -16,6 +16,7 @@
 #include <linux/platform_device.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
+#include <linux/pwm.h>
 #include <linux/pwm_backlight.h>
 #include <linux/z2_battery.h>
 #include <linux/dma-mapping.h>
@@ -199,21 +200,24 @@ static inline void z2_nor_init(void) {}
  * Backlight
  ******************************************************************************/
 #if defined(CONFIG_BACKLIGHT_PWM) || defined(CONFIG_BACKLIGHT_PWM_MODULE)
+static struct pwm_lookup z2_pwm_lookup[] = {
+	PWM_LOOKUP("pxa27x-pwm.1", 0, "pwm-backlight.0", NULL, 1260320,
+		   PWM_POLARITY_NORMAL),
+	PWM_LOOKUP("pxa27x-pwm.0", 1, "pwm-backlight.1", NULL, 1260320,
+		   PWM_POLARITY_NORMAL),
+};
+
 static struct platform_pwm_backlight_data z2_backlight_data[] = {
 	[0] = {
 		/* Keypad Backlight */
-		.pwm_id		= 1,
 		.max_brightness	= 1023,
 		.dft_brightness	= 0,
-		.pwm_period_ns	= 1260320,
 		.enable_gpio	= -1,
 	},
 	[1] = {
 		/* LCD Backlight */
-		.pwm_id		= 2,
 		.max_brightness	= 1023,
 		.dft_brightness	= 512,
-		.pwm_period_ns	= 1260320,
 		.enable_gpio	= -1,
 	},
 };
@@ -236,6 +240,7 @@ static struct platform_device z2_backlight_devices[2] = {
 };
 static void __init z2_pwm_init(void)
 {
+	pwm_add_table(z2_pwm_lookup, ARRAY_SIZE(z2_pwm_lookup));
 	platform_device_register(&z2_backlight_devices[0]);
 	platform_device_register(&z2_backlight_devices[1]);
 }
-- 
2.5.0
