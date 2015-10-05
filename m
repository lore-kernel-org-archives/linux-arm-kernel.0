From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon,  5 Oct 2015 10:49:46 +0200
Subject: [PATCH 06/17] ARM: pxa: magician: Use PWM lookup table
In-Reply-To: <1444034997-9805-1-git-send-email-thierry.reding@gmail.com>
References: <1444034997-9805-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1444034997-9805-7-git-send-email-thierry.reding@gmail.com>
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
 arch/arm/mach-pxa/magician.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
index a9761c293028..240e4c34b226 100644
--- a/arch/arm/mach-pxa/magician.c
+++ b/arch/arm/mach-pxa/magician.c
@@ -24,6 +24,7 @@
 #include <linux/mfd/htc-pasic3.h>
 #include <linux/mtd/physmap.h>
 #include <linux/pda_power.h>
+#include <linux/pwm.h>
 #include <linux/pwm_backlight.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/gpio-regulator.h>
@@ -346,6 +347,11 @@ static struct pxafb_mach_info samsung_info = {
  * Backlight
  */
 
+static struct pwm_lookup magician_pwm_lookup[] = {
+	PWM_LOOKUP("pxa27x-pwm.0", 0, "pwm-backlight", NULL, 30923,
+		   PWM_POLARITY_NORMAL),
+};
+
 static struct gpio magician_bl_gpios[] = {
 	{ EGPIO_MAGICIAN_BL_POWER,  GPIOF_DIR_OUT, "Backlight power" },
 	{ EGPIO_MAGICIAN_BL_POWER2, GPIOF_DIR_OUT, "Backlight power 2" },
@@ -374,10 +380,8 @@ static void magician_backlight_exit(struct device *dev)
 }
 
 static struct platform_pwm_backlight_data backlight_data = {
-	.pwm_id         = 0,
 	.max_brightness = 272,
 	.dft_brightness = 100,
-	.pwm_period_ns  = 30923,
 	.enable_gpio    = -1,
 	.init           = magician_backlight_init,
 	.notify         = magician_backlight_notify,
@@ -743,6 +747,7 @@ static void __init magician_init(void)
 	pxa_set_btuart_info(NULL);
 	pxa_set_stuart_info(NULL);
 
+	pwm_add_table(magician_pwm_lookup, ARRAY_SIZE(magician_pwm_lookup));
 	platform_add_devices(ARRAY_AND_SIZE(devices));
 
 	pxa_set_ficp_info(&magician_ficp_info);
-- 
2.5.0
