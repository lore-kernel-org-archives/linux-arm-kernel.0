From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 14 Apr 2016 21:17:40 +0200
Subject: [PATCH v5 20/24] pwm: add the PWM initial state retrieval infra
In-Reply-To: <1460661464-11216-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1460661464-11216-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1460661464-11216-21-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a ->get_state() function to the pwm_ops struct to let PWM drivers
initialize the PWM state attached to a PWM device.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/pwm/core.c  |  3 +++
 include/linux/pwm.h | 28 ++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index c2759bc..0e7f687 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -270,6 +270,9 @@ int pwmchip_add_with_polarity(struct pwm_chip *chip,
 		pwm->hwpwm = i;
 		pwm->state.polarity = polarity;
 
+		if (chip->ops->get_state)
+			chip->ops->get_state(chip, pwm, &pwm->state);
+
 		radix_tree_insert(&pwm_tree, pwm->pwm, pwm);
 	}
 
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 7bfeacf..73ca679 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -205,6 +205,29 @@ static inline void pwm_get_args(const struct pwm_device *pwm,
 
 static inline void pwm_apply_args(struct pwm_device *pwm)
 {
+	/*
+	 * PWM users calling pwm_apply_args() expect to have a fresh config
+	 * where the polarity and period are set according to pwm_args info.
+	 * The problem is, polarity can only be changed when the PWM is
+	 * disabled.
+	 *
+	 * PWM drivers supporting hardware readout may declare the PWM device
+	 * as enabled, and prevent polarity setting, which changes from the
+	 * existing behavior, where all PWM devices are declared as disabled
+	 * at startup (even if they are actually enabled), thus authorizing
+	 * polarity setting.
+	 *
+	 * Instead of setting ->enabled to false, we call pwm_disable()
+	 * before pwm_set_polarity() to ensure that everything is configured
+	 * as expected, and the PWM is really disabled when the user request
+	 * it.
+	 *
+	 * Note that PWM users requiring a smooth handover between the
+	 * bootloader and the kernel (like critical regulators controlled by
+	 * PWM devices) will have to switch to the atomic API and avoid calling
+	 * pwm_apply_args().
+	 */
+	pwm_disable(pwm);
 	pwm_set_polarity(pwm, pwm->args.polarity);
 }
 
@@ -216,6 +239,9 @@ static inline void pwm_apply_args(struct pwm_device *pwm)
  * @set_polarity: configure the polarity of this PWM
  * @enable: enable PWM output toggling
  * @disable: disable PWM output toggling
+ * @get_state: get the current PWM state. This function is only
+ *	       called once per PWM device when the PWM chip is
+ *	       registered.
  * @dbg_show: optional routine to show contents in debugfs
  * @owner: helps prevent removal of modules exporting active PWMs
  */
@@ -228,6 +254,8 @@ struct pwm_ops {
 			    enum pwm_polarity polarity);
 	int (*enable)(struct pwm_chip *chip, struct pwm_device *pwm);
 	void (*disable)(struct pwm_chip *chip, struct pwm_device *pwm);
+	void (*get_state)(struct pwm_chip *chip, struct pwm_device *pwm,
+			  struct pwm_state *state);
 #ifdef CONFIG_DEBUG_FS
 	void (*dbg_show)(struct pwm_chip *chip, struct seq_file *s);
 #endif
-- 
2.5.0
