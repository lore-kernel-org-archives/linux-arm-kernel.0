From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri, 26 Oct 2018 20:41:55 +0200
Subject: [PATCH 1/4] pwm: Add new helper to initialize a pwm_state variable
 with defaults
Message-ID: <20181026184157.16371-1-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This helps to convert drivers from the legacy API to pwm_apply_state without
having to make the aware of the configured polarity (and in some cases even
period).

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 include/linux/pwm.h | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index d5199b507d79..017d1e13e29d 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -522,6 +522,15 @@ static inline void devm_pwm_put(struct device *dev, struct pwm_device *pwm)
 }
 #endif
 
+static inline void pwm_get_state_default(const struct pwm_device *pwm,
+					 struct pwm_state *state)
+{
+	state->period = pwm->args.period;
+	state->duty_cycle = 0;
+	state->polarity = pwm->args.polarity;
+	state->enabled = false;
+}
+
 static inline void pwm_apply_args(struct pwm_device *pwm)
 {
 	struct pwm_state state = { };
@@ -547,9 +556,7 @@ static inline void pwm_apply_args(struct pwm_device *pwm)
 	 * pwm_apply_args().
 	 */
 
-	state.enabled = false;
-	state.polarity = pwm->args.polarity;
-	state.period = pwm->args.period;
+	pwm_get_state_default(pwm, &state);
 
 	pwm_apply_state(pwm, &state);
 }
-- 
2.19.1
