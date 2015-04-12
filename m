From: linux.amoon@gmail.com (Anand Moon)
Date: Mon, 13 Apr 2015 04:14:11 +0930
Subject: [PATCH v4 6/6] hwmon: pwm-fan: Update the duty cycle inorder to
 control the pwm-fan
In-Reply-To: <1428864251-31780-1-git-send-email-linux.amoon@gmail.com>
References: <1428864251-31780-1-git-send-email-linux.amoon@gmail.com>
Message-ID: <1428864251-31780-7-git-send-email-linux.amoon@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pwm_config() must be called with a duty cycle of 0 prior to calling
pwm_disable() to ensure that the pwm signal is set to low.

Changes since v1 : None.
Changes since v2 : None
Changes since v3 : Simplify the comment.

Reported-by: Markus Reichl <m.reichl@fivetechno.de>
Tested-by: Markus Reichl <m.reichl@fivetechno.de>
Reviewed-by: Lukasz Majewski <l.majewski@samsung.com>
Reviewed-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/hwmon/pwm-fan.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
index 7c83dc4..c2a469e 100644
--- a/drivers/hwmon/pwm-fan.c
+++ b/drivers/hwmon/pwm-fan.c
@@ -47,23 +47,20 @@ static int  __set_pwm(struct pwm_fan_ctx *ctx, unsigned long pwm)
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
