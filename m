From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 30 Mar 2016 22:03:37 +0200
Subject: [PATCH v5 14/46] pwm: keep PWM state in sync with hardware state
In-Reply-To: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1459368249-13241-15-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Before the introduction of pwm_args, the core and some drivers were
resetting the PWM period and polarity states to the reference values
(those provided through the DT, a PWM lookup table or hardcoded in the
driver).

Now that all PWM users are correctly using pwm_args to configure their
PWM device, we can safely remove some pwm_set_period/polarity() calls.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/pwm/core.c         | 5 -----
 drivers/pwm/pwm-clps711x.c | 1 -
 drivers/pwm/pwm-pxa.c      | 1 -
 3 files changed, 7 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index cd55d61..6433059 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -147,13 +147,11 @@ of_pwm_xlate_with_flags(struct pwm_chip *pc, const struct of_phandle_args *args)
 		return pwm;
 
 	pwm->args.period = args->args[1];
-	pwm_set_period(pwm, pwm->args.period);
 
 	if (args->args[2] & PWM_POLARITY_INVERTED)
 		pwm->args.polarity = PWM_POLARITY_INVERSED;
 	else
 		pwm->args.polarity = PWM_POLARITY_NORMAL;
-	pwm_set_polarity(pwm, pwm->args.polarity);
 
 	return pwm;
 }
@@ -175,7 +173,6 @@ of_pwm_simple_xlate(struct pwm_chip *pc, const struct of_phandle_args *args)
 		return pwm;
 
 	pwm->args.period = args->args[1];
-	pwm_set_period(pwm, pwm->args.period);
 
 	return pwm;
 }
@@ -745,8 +742,6 @@ struct pwm_device *pwm_get(struct device *dev, const char *con_id)
 
 	pwm->args.period = chosen->period;
 	pwm->args.polarity = chosen->polarity;
-	pwm_set_period(pwm, chosen->period);
-	pwm_set_polarity(pwm, chosen->polarity);
 
 out:
 	mutex_unlock(&pwm_lookup_lock);
diff --git a/drivers/pwm/pwm-clps711x.c b/drivers/pwm/pwm-clps711x.c
index 807a48d..7d33542 100644
--- a/drivers/pwm/pwm-clps711x.c
+++ b/drivers/pwm/pwm-clps711x.c
@@ -61,7 +61,6 @@ static int clps711x_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 
 	/* Store constant period value */
 	pwm->args.period = DIV_ROUND_CLOSEST(NSEC_PER_SEC, freq);
-	pwm_set_period(pwm, pwm->args.period);
 
 	return 0;
 }
diff --git a/drivers/pwm/pwm-pxa.c b/drivers/pwm/pwm-pxa.c
index 3fcc886..58b709f 100644
--- a/drivers/pwm/pwm-pxa.c
+++ b/drivers/pwm/pwm-pxa.c
@@ -161,7 +161,6 @@ pxa_pwm_of_xlate(struct pwm_chip *pc, const struct of_phandle_args *args)
 		return pwm;
 
 	pwm->args.period = args->args[0];
-	pwm_set_period(pwm, args->args[0]);
 
 	return pwm;
 }
-- 
2.5.0
