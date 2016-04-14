From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 14 Apr 2016 21:17:39 +0200
Subject: [PATCH v5 19/24] pwm: move the enabled/disabled info into pwm_state
In-Reply-To: <1460661464-11216-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1460661464-11216-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1460661464-11216-20-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Prepare the transition to PWM atomic update by moving the enabled/disabled
state into the pwm_state struct. This way we can easily update the whole
PWM state by copying the new state in the ->state field.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/pwm/core.c  | 13 +++++++++----
 include/linux/pwm.h | 11 ++++++++---
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 59bcece..c2759bc 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -499,10 +499,10 @@ int pwm_enable(struct pwm_device *pwm)
 	if (!pwm)
 		return -EINVAL;
 
-	if (!test_and_set_bit(PWMF_ENABLED, &pwm->flags)) {
+	if (!pwm_is_enabled(pwm)) {
 		err = pwm->chip->ops->enable(pwm->chip, pwm);
-		if (err)
-			clear_bit(PWMF_ENABLED, &pwm->flags);
+		if (!err)
+			pwm->state.enabled = true;
 	}
 
 	return err;
@@ -515,8 +515,13 @@ EXPORT_SYMBOL_GPL(pwm_enable);
  */
 void pwm_disable(struct pwm_device *pwm)
 {
-	if (pwm && test_and_clear_bit(PWMF_ENABLED, &pwm->flags))
+	if (!pwm)
+		return;
+
+	if (pwm_is_enabled(pwm)) {
 		pwm->chip->ops->disable(pwm->chip, pwm);
+		pwm->state.enabled = false;
+	}
 }
 EXPORT_SYMBOL_GPL(pwm_disable);
 
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 3022c05..7bfeacf 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -93,8 +93,7 @@ struct pwm_args {
 
 enum {
 	PWMF_REQUESTED = 1 << 0,
-	PWMF_ENABLED = 1 << 1,
-	PWMF_EXPORTED = 1 << 2,
+	PWMF_EXPORTED = 1 << 1,
 };
 
 /*
@@ -102,11 +101,13 @@ enum {
  * @period: PWM period (in nanoseconds)
  * @duty_cycle: PWM duty cycle (in nanoseconds)
  * @polarity: PWM polarity
+ * @enabled: PWM enabled status
  */
 struct pwm_state {
 	unsigned int period;
 	unsigned int duty_cycle;
 	enum pwm_polarity polarity;
+	bool enabled;
 };
 
 /**
@@ -145,7 +146,11 @@ static inline void pwm_get_state(const struct pwm_device *pwm,
 
 static inline bool pwm_is_enabled(const struct pwm_device *pwm)
 {
-	return test_bit(PWMF_ENABLED, &pwm->flags);
+	struct pwm_state state;
+
+	pwm_get_state(pwm, &state);
+
+	return state.enabled;
 }
 
 static inline void pwm_set_period(struct pwm_device *pwm, unsigned int period)
-- 
2.5.0
