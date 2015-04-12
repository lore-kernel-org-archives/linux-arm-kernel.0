From: linux.amoon@gmail.com (Anand Moon)
Date: Mon, 13 Apr 2015 00:24:12 +0930
Subject: [PATCH v3 6/6] hwmon: pwm-fan: Update the duty cycle inorder to
 control the pwm-fan
In-Reply-To: <1428850452-4178-1-git-send-email-linux.amoon@gmail.com>
References: <1428850452-4178-1-git-send-email-linux.amoon@gmail.com>
Message-ID: <1428850452-4178-7-git-send-email-linux.amoon@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to disable the PWM we need to update using following sequence.

	pwm_config(pwm, 0, period);
 	pwm_disable(pwm);

pwm_config() with a zero duty cycle to make it clear the timer and update the PWM registers.
pwm_disable will clear the TCON_AUTORELOAD(tcon_chan) and update the PWM register.

Next change in state will get trigger unless a new PWM cycle happened.

	pwm_config(pwm, duty, period);
 	pwm_enable(pwm);

Through pwm_config we update the duty cycle and period and update the PWM register.
pwm_enable will update the state to TCON_MANUALUPDATE(tcon_chan)
and TCON_START(tcon_chan) | TCON_AUTORELOAD(tcon_chan) and update the PWM register.

Reported-by: Markus Reichl <m.reichl@fivetechno.de>
Tested-by: Markus Reichl <m.reichl@fivetechno.de>
Reviewed-by: Lukasz Majewski <l.majewski@samsung.com>
Reviewed-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/hwmon/pwm-fan.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
index 7c83dc4..f25c841 100644
--- a/drivers/hwmon/pwm-fan.c
+++ b/drivers/hwmon/pwm-fan.c
@@ -44,26 +44,24 @@ static int  __set_pwm(struct pwm_fan_ctx *ctx, unsigned long pwm)
 	int ret = 0;
 
 	mutex_lock(&ctx->lock);
+
 	if (ctx->pwm_value == pwm)
 		goto exit_set_pwm_err;
 
-	if (pwm == 0) {
-		pwm_disable(ctx->pwm);
-		goto exit_set_pwm;
-	}
-
 	duty = DIV_ROUND_UP(pwm * (ctx->pwm->period - 1), MAX_PWM);
 	ret = pwm_config(ctx->pwm, duty, ctx->pwm->period);
 	if (ret)
 		goto exit_set_pwm_err;
 
+	if (pwm == 0)
+		pwm_disable(ctx->pwm);
+
 	if (ctx->pwm_value == 0) {
 		ret = pwm_enable(ctx->pwm);
 		if (ret)
 			goto exit_set_pwm_err;
 	}
 
-exit_set_pwm:
 	ctx->pwm_value = pwm;
 exit_set_pwm_err:
 	mutex_unlock(&ctx->lock);
-- 
1.9.1
