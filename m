From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 14 Apr 2016 21:17:37 +0200
Subject: [PATCH v5 17/24] pwm: keep PWM state in sync with hardware state
In-Reply-To: <1460661464-11216-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1460661464-11216-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1460661464-11216-18-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Before the introduction of pwm_args, the core was resetting the PWM period
and polarity states to the reference values (those provided through the
DT, a PWM lookup table or hardcoded in the driver).

Now that all PWM users are correctly using pwm_args to configure their
PWM device, we can safely remove the pwm_apply_args() call in
pwm_device_request().

We can also get rid of the pwm_set_period() call done in
pwm_apply_args(), because PWM users are now directly using pargs->period
instead of pwm_get_period(). By doing that we avoid messing with the
current PWM period.

The only remaining bit in pwm_apply_args() is the initial polarity
setting, and it should go away when all PWM users have been patched to
use the atomic API (with this API the polarity will be set along with
other PWM arguments when configuring the PWM).

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/pwm/core.c  | 8 --------
 include/linux/pwm.h | 1 -
 2 files changed, 9 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index ac89529..26c3cf5 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -128,14 +128,6 @@ static int pwm_device_request(struct pwm_device *pwm, const char *label)
 	set_bit(PWMF_REQUESTED, &pwm->flags);
 	pwm->label = label;
 
-	/*
-	 * FIXME: this should be removed as soon as all PWM users are
-	 * properly making use of pwm_args to initialize the PWM device.
-	 * If we don't get rid of it, then PWM state and hardware can be
-	 * desynchronized.
-	 */
-	pwm_apply_args(pwm);
-
 	return 0;
 }
 
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index c8859b7..2f500a5 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -170,7 +170,6 @@ static inline void pwm_get_args(const struct pwm_device *pwm,
 
 static inline void pwm_apply_args(struct pwm_device *pwm)
 {
-	pwm_set_period(pwm, pwm->args.period);
 	pwm_set_polarity(pwm, pwm->args.polarity);
 }
 
-- 
2.5.0
