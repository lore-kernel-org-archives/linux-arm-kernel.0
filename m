From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 30 Mar 2016 22:04:02 +0200
Subject: [PATCH v5 39/46] leds: pwm: switch to the atomic PWM API
In-Reply-To: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1459368249-13241-40-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pwm_config/enable/disable() have been deprecated and should be replaced
by pwm_apply_state().

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/leds/leds-pwm.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/leds/leds-pwm.c b/drivers/leds/leds-pwm.c
index b48231c..f69b222 100644
--- a/drivers/leds/leds-pwm.c
+++ b/drivers/leds/leds-pwm.c
@@ -40,13 +40,18 @@ struct led_pwm_priv {
 static void __led_pwm_set(struct led_pwm_data *led_dat)
 {
 	int new_duty = led_dat->duty;
+	struct pwm_state pstate;
 
-	pwm_config(led_dat->pwm, new_duty, led_dat->period);
+	pwm_get_state(led_dat->pwm, &pstate);
+	pstate.duty_cycle = new_duty;
+	pstate.period = led_dat->period;
 
 	if (new_duty == 0)
-		pwm_disable(led_dat->pwm);
+		pstate.enabled = false;
 	else
-		pwm_enable(led_dat->pwm);
+		pstate.enabled = true;
+
+	pwm_apply_state(led_dat->pwm, &pstate);
 }
 
 static void led_pwm_set(struct led_classdev *led_cdev,
-- 
2.5.0
