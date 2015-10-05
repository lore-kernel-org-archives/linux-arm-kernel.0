From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon,  5 Oct 2015 14:47:15 +0200
Subject: [PATCH 4/6] ARM: s3c64xx: crag6410: Use PWM lookup table
In-Reply-To: <1444049237-29878-1-git-send-email-thierry.reding@gmail.com>
References: <1444049237-29878-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1444049237-29878-5-git-send-email-thierry.reding@gmail.com>
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
 arch/arm/mach-s3c64xx/mach-crag6410.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/mach-crag6410.c b/arch/arm/mach-s3c64xx/mach-crag6410.c
index 65c426bc45f7..d13aa3f9bac4 100644
--- a/arch/arm/mach-s3c64xx/mach-crag6410.c
+++ b/arch/arm/mach-s3c64xx/mach-crag6410.c
@@ -25,6 +25,7 @@
 #include <linux/mmc/host.h>
 #include <linux/regulator/machine.h>
 #include <linux/regulator/fixed.h>
+#include <linux/pwm.h>
 #include <linux/pwm_backlight.h>
 #include <linux/dm9000.h>
 #include <linux/gpio_keys.h>
@@ -108,11 +109,14 @@ static struct s3c2410_uartcfg crag6410_uartcfgs[] __initdata = {
 	},
 };
 
+static struct pwm_lookup crag6410_pwm_lookup[] = {
+	PWM_LOOKUP("samsung-pwm", 0, "pwm-backlight", NULL, 100000,
+		   PWM_POLARITY_NORMAL),
+};
+
 static struct platform_pwm_backlight_data crag6410_backlight_data = {
-	.pwm_id		= 0,
 	.max_brightness	= 1000,
 	.dft_brightness	= 600,
-	.pwm_period_ns	= 100000,	/* about 1kHz */
 	.enable_gpio	= -1,
 };
 
@@ -843,6 +847,7 @@ static void __init crag6410_machine_init(void)
 	samsung_keypad_set_platdata(&crag6410_keypad_data);
 	s3c64xx_spi0_set_platdata(NULL, 0, 2);
 
+	pwm_add_table(crag6410_pwm_lookup, ARRAY_SIZE(crag6410_pwm_lookup));
 	platform_add_devices(crag6410_devices, ARRAY_SIZE(crag6410_devices));
 
 	gpio_led_register_device(-1, &gpio_leds_pdata);
-- 
2.5.0
