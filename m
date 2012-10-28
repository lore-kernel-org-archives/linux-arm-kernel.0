From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Sun, 28 Oct 2012 18:35:55 +0300
Subject: [PATCH 5/5] ARM: PXA: Zipit Z2: Fix backlight PWM device number
In-Reply-To: <1351438555-4668-1-git-send-email-anarsoul@gmail.com>
References: <1351438555-4668-1-git-send-email-anarsoul@gmail.com>
Message-ID: <1351438555-4668-5-git-send-email-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Recent changes to PXA PWM support changed the PXA27X PWM device
numbering scheme, so keyboard and LCD backlight is not
working anymore on Z2.

Fix it and move from legacy to new PWM API.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 arch/arm/mach-pxa/z2.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-pxa/z2.c b/arch/arm/mach-pxa/z2.c
index fac7cba..06b8078 100644
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
@@ -206,17 +207,22 @@ static inline void z2_nor_init(void) {}
  * Backlight
  ******************************************************************************/
 #if defined(CONFIG_BACKLIGHT_PWM) || defined(CONFIG_BACKLIGHT_PWM_MODULE)
+static struct pwm_lookup z2_pwm_lookup[] = {
+	PWM_LOOKUP("pxa27x-pwm.0", 1, "pwm-backlight.0", NULL),
+	PWM_LOOKUP("pxa27x-pwm.1", 0, "pwm-backlight.1", NULL),
+};
+
 static struct platform_pwm_backlight_data z2_backlight_data[] = {
 	[0] = {
 		/* Keypad Backlight */
-		.pwm_id		= 1,
+		.pwm_id		= -1,
 		.max_brightness	= 1023,
 		.dft_brightness	= 0,
 		.pwm_period_ns	= 1260320,
 	},
 	[1] = {
 		/* LCD Backlight */
-		.pwm_id		= 2,
+		.pwm_id		= -1,
 		.max_brightness	= 1023,
 		.dft_brightness	= 512,
 		.pwm_period_ns	= 1260320,
@@ -243,6 +249,7 @@ static void __init z2_pwm_init(void)
 {
 	platform_device_register(&z2_backlight_devices[0]);
 	platform_device_register(&z2_backlight_devices[1]);
+	pwm_add_table(z2_pwm_lookup, ARRAY_SIZE(z2_pwm_lookup));
 }
 #else
 static inline void z2_pwm_init(void) {}
-- 
1.7.12.4
