From: jhovold@gmail.com (Johan Hovold)
Date: Tue, 22 Oct 2013 18:32:40 +0200
Subject: [PATCH 2/2] misc: atmel_pwm: set initcall level to subsys
In-Reply-To: <1382459560-26596-1-git-send-email-jhovold@gmail.com>
References: <1382459560-26596-1-git-send-email-jhovold@gmail.com>
Message-ID: <1382459560-26596-3-git-send-email-jhovold@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Even with the atmel_pwm driver and the atmel-pwm-bl backlight driver
supporting deferred probing, we still want to make sure that any
pwm-device is available when the backlight devices are probed to avoid
any unnecessary delays before enabling the backlight.

Signed-off-by: Johan Hovold <jhovold@gmail.com>
---
 drivers/misc/atmel_pwm.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/atmel_pwm.c b/drivers/misc/atmel_pwm.c
index a6dc56e..0d0f599 100644
--- a/drivers/misc/atmel_pwm.c
+++ b/drivers/misc/atmel_pwm.c
@@ -395,7 +395,17 @@ static struct platform_driver atmel_pwm_driver = {
 	 */
 };
 
-module_platform_driver_probe(atmel_pwm_driver, pwm_probe);
+static int __init pwm_init(void)
+{
+	return platform_driver_probe(&atmel_pwm_driver, pwm_probe);
+}
+subsys_initcall(pwm_init);
+
+static void __exit pwm_exit(void)
+{
+	platform_driver_unregister(&atmel_pwm_driver);
+}
+module_exit(pwm_exit);
 
 MODULE_DESCRIPTION("Driver for AT32/AT91 PWM module");
 MODULE_LICENSE("GPL");
-- 
1.8.4
