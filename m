From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon,  5 Oct 2015 10:49:45 +0200
Subject: [PATCH 05/17] ARM: pxa: lpd270: Use PWM lookup table
In-Reply-To: <1444034997-9805-1-git-send-email-thierry.reding@gmail.com>
References: <1444034997-9805-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1444034997-9805-6-git-send-email-thierry.reding@gmail.com>
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
 arch/arm/mach-pxa/lpd270.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-pxa/lpd270.c b/arch/arm/mach-pxa/lpd270.c
index b070167deef2..ab4e84f4ee0c 100644
--- a/arch/arm/mach-pxa/lpd270.c
+++ b/arch/arm/mach-pxa/lpd270.c
@@ -23,6 +23,7 @@
 #include <linux/ioport.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
+#include <linux/pwm.h>
 #include <linux/pwm_backlight.h>
 #include <linux/smc91x.h>
 
@@ -271,11 +272,14 @@ static struct platform_device lpd270_flash_device[2] = {
 	},
 };
 
+static struct pwm_lookup lpd270_pwm_lookup[] = {
+	PWM_LOOKUP("pxa27x-pwm.0", 0, "pwm-backlight.0", NULL, 78770,
+		   PWM_POLARITY_NORMAL),
+};
+
 static struct platform_pwm_backlight_data lpd270_backlight_data = {
-	.pwm_id		= 0,
 	.max_brightness	= 1,
 	.dft_brightness	= 1,
-	.pwm_period_ns	= 78770,
 	.enable_gpio	= -1,
 };
 
@@ -474,6 +478,7 @@ static void __init lpd270_init(void)
 	 */
 	ARB_CNTRL = ARB_CORE_PARK | 0x234;
 
+	pwm_add_table(lpd270_pwm_lookup, ARRAY_SIZE(lpd270_pwm_lookup));
 	platform_add_devices(platform_devices, ARRAY_SIZE(platform_devices));
 
 	pxa_set_ac97_info(NULL);
-- 
2.5.0
