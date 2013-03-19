From: achew@nvidia.com (Andrew Chew)
Date: Tue, 19 Mar 2013 11:59:29 -0700
Subject: [PATCH V4 5/9] unicore32: Provide regulator to pwm-backlight
In-Reply-To: <1363719573-20926-1-git-send-email-achew@nvidia.com>
References: <1363719573-20926-1-git-send-email-achew@nvidia.com>
Message-ID: <1363719573-20926-6-git-send-email-achew@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pwm-backlight driver now takes a mandatory regulator that is gotten
during driver probe.  Initialize a dummy regulator to satisfy this
requirement.

Signed-off-by: Andrew Chew <achew@nvidia.com>
---
 arch/unicore32/kernel/puv3-nb0916.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/unicore32/kernel/puv3-nb0916.c b/arch/unicore32/kernel/puv3-nb0916.c
index 181108b..ff84d77 100644
--- a/arch/unicore32/kernel/puv3-nb0916.c
+++ b/arch/unicore32/kernel/puv3-nb0916.c
@@ -19,6 +19,8 @@
 #include <linux/reboot.h>
 #include <linux/interrupt.h>
 #include <linux/i2c.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/fixed.h>
 #include <linux/pwm_backlight.h>
 #include <linux/gpio.h>
 #include <linux/gpio_keys.h>
@@ -49,6 +51,10 @@ static struct resource puv3_i2c_resources[] = {
 	}
 };
 
+/* Dummy regulator for pwm-backlight driver */
+static struct regulator_consumer_supply backlight_supply =
+	REGULATOR_SUPPLY("enable", "pwm-backlight");
+
 static struct platform_pwm_backlight_data nb0916_backlight_data = {
 	.pwm_id		= 0,
 	.max_brightness	= 100,
@@ -111,6 +117,9 @@ int __init mach_nb0916_init(void)
 	platform_device_register_simple("PKUnity-v3-I2C", -1,
 			puv3_i2c_resources, ARRAY_SIZE(puv3_i2c_resources));
 
+	regulator_register_always_on(-1, "backlight-enable",
+				     &backlight_supply, 1, 0);
+
 	platform_device_register_data(&platform_bus, "pwm-backlight", -1,
 			&nb0916_backlight_data, sizeof(nb0916_backlight_data));
 
-- 
1.8.1.5
