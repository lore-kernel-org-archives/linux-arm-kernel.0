From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri, 16 Nov 2018 07:52:08 +0100
Subject: [PATCH] pwm: lpc18xx-sct: don't reconfigure PWM in .request and .free
In-Reply-To: <20181114115025.GC2620@ulmo>
References: <20181114115025.GC2620@ulmo>
Message-ID: <20181116065208.3920-1-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Regarding the .request case: The consumer might be interested in taking
over the configured state from the boot loader. So the initially
configured state should be retained.

For the free case the PWM consumer is responsible to disable the PWM
before calling pwm_release and there are three subcases to consider:

 a) The pwm is already off. Then there is no gain in disabling the PWM
    once more.
 b) The pwm is still running and there is a good reason for that. (Not
    sure this is a valid case, I cannot imagine such a good reason.)
    Then it is contra productive to disable the pwm.
 c) The pwm is still running because the consumer failed to disable the
    PWM. Then the consumer needs fixing and there is little incentive to
    paper over the problem in the backend driver.

This aligns the lpc18xx-sct driver to the other PWM drivers that also
don't reconfigure the hardware in .request and .free.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-lpc18xx-sct.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/pwm/pwm-lpc18xx-sct.c b/drivers/pwm/pwm-lpc18xx-sct.c
index d7f5f7de030d..475918d9f543 100644
--- a/drivers/pwm/pwm-lpc18xx-sct.c
+++ b/drivers/pwm/pwm-lpc18xx-sct.c
@@ -296,7 +296,6 @@ static int lpc18xx_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 
 	set_bit(event, &lpc18xx_pwm->event_map);
 	lpc18xx_data->duty_event = event;
-	lpc18xx_pwm_config_duty(chip, pwm, pwm_get_duty_cycle(pwm));
 
 	return 0;
 }
@@ -306,8 +305,6 @@ static void lpc18xx_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 	struct lpc18xx_pwm_chip *lpc18xx_pwm = to_lpc18xx_pwm_chip(chip);
 	struct lpc18xx_pwm_data *lpc18xx_data = pwm_get_chip_data(pwm);
 
-	pwm_disable(pwm);
-	pwm_set_duty_cycle(pwm, 0);
 	clear_bit(lpc18xx_data->duty_event, &lpc18xx_pwm->event_map);
 }
 
-- 
2.19.1
