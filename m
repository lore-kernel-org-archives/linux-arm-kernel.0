From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue, 14 Jun 2016 11:13:09 +0200
Subject: [PATCH v3 01/14] pwm: Add an helper to prepare a new PWM state
In-Reply-To: <1465895602-31008-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1465895602-31008-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1465895602-31008-2-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pwm_init_state() helper prepares a new state object containing the
current PWM state except for the polarity and period fields which are
set to the reference values (those in pwm_args).
This is particularly useful for PWM users who want to apply a new
duty-cycle expressed relatively to the reference period without
changing the enable state.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Tested-by: Heiko Stuebner <heiko@sntech.de>
---
 include/linux/pwm.h | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 17018f3..a100f6e 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -148,6 +148,39 @@ static inline void pwm_get_args(const struct pwm_device *pwm,
 }
 
 /**
+ * pwm_init_state() - prepare a new state to be applied with pwm_apply_state()
+ * @pwm: PWM device
+ * @state: state to fill with the prepared PWM state
+ *
+ * This functions prepares a state that can later be tweaked and applied
+ * to the PWM device with pwm_apply_state(). This is a convenient function
+ * that first retrieves the current PWM state and the replaces the period
+ * and polarity fields with the reference values defined in pwm->args.
+ * Once the function returns, you can adjust the ->enabled and ->duty_cycle
+ * fields according to your needs before calling pwm_apply_state().
+ *
+ * ->duty_cycle is initially set to zero to avoid cases where the current
+ * ->duty_cycle value exceed the pwm_args->period one, which would trigger
+ * an error if the user calls pwm_apply_state() without adjusting ->duty_cycle
+ * first.
+ */
+static inline void pwm_init_state(const struct pwm_device *pwm,
+				  struct pwm_state *state)
+{
+	struct pwm_args args;
+
+	/* First get the current state. */
+	pwm_get_state(pwm, state);
+
+	/* Then fill it with the reference config */
+	pwm_get_args(pwm, &args);
+
+	state->period = args.period;
+	state->polarity = args.polarity;
+	state->duty_cycle = 0;
+}
+
+/**
  * struct pwm_ops - PWM controller operations
  * @request: optional hook for requesting a PWM
  * @free: optional hook for freeing a PWM
-- 
2.7.4
