From: rob.lee@linaro.org (Robert Lee)
Date: Wed, 29 Feb 2012 18:42:55 -0600
Subject: [PATCH v7 6/9] ARM: omap: Consolidate OMAP3 time keeping and irq
 enable
In-Reply-To: <1330562578-3410-1-git-send-email-rob.lee@linaro.org>
References: <1330562578-3410-1-git-send-email-rob.lee@linaro.org>
Message-ID: <1330562578-3410-7-git-send-email-rob.lee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use core cpuidle timekeeping and irqen wrapper and remove that
handling from this code.

Signed-off-by: Robert Lee <rob.lee@linaro.org>
---
 arch/arm/mach-omap2/cpuidle34xx.c |   42 +++++++++++++++----------------------
 1 files changed, 17 insertions(+), 25 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 464cffd..5358664 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -87,29 +87,14 @@ static int _cpuidle_deny_idle(struct powerdomain *pwrdm,
 	return 0;
 }
 
-/**
- * omap3_enter_idle - Programs OMAP3 to enter the specified state
- * @dev: cpuidle device
- * @drv: cpuidle driver
- * @index: the index of state to be entered
- *
- * Called from the CPUidle framework to program the device to the
- * specified target state selected by the governor.
- */
-static int omap3_enter_idle(struct cpuidle_device *dev,
+static int __omap3_enter_idle(struct cpuidle_device *dev,
 				struct cpuidle_driver *drv,
 				int index)
 {
 	struct omap3_idle_statedata *cx =
 			cpuidle_get_statedata(&dev->states_usage[index]);
-	struct timespec ts_preidle, ts_postidle, ts_idle;
 	u32 mpu_state = cx->mpu_state, core_state = cx->core_state;
-	int idle_time;
-
-	/* Used to keep track of the total time in idle */
-	getnstimeofday(&ts_preidle);
 
-	local_irq_disable();
 	local_fiq_disable();
 
 	pwrdm_set_next_pwrst(mpu_pd, mpu_state);
@@ -148,22 +133,29 @@ static int omap3_enter_idle(struct cpuidle_device *dev,
 	}
 
 return_sleep_time:
-	getnstimeofday(&ts_postidle);
-	ts_idle = timespec_sub(ts_postidle, ts_preidle);
 
-	local_irq_enable();
 	local_fiq_enable();
 
-	idle_time = ts_idle.tv_nsec / NSEC_PER_USEC + ts_idle.tv_sec * \
-								USEC_PER_SEC;
-
-	/* Update cpuidle counters */
-	dev->last_residency = idle_time;
-
 	return index;
 }
 
 /**
+ * omap3_enter_idle - Programs OMAP3 to enter the specified state
+ * @dev: cpuidle device
+ * @drv: cpuidle driver
+ * @index: the index of state to be entered
+ *
+ * Called from the CPUidle framework to program the device to the
+ * specified target state selected by the governor.
+ */
+static inline int omap3_enter_idle(struct cpuidle_device *dev,
+				struct cpuidle_driver *drv,
+				int index)
+{
+	return cpuidle_wrap_enter(dev, drv, index, __omap3_enter_idle);
+}
+
+/**
  * next_valid_state - Find next valid C-state
  * @dev: cpuidle device
  * @drv: cpuidle driver
-- 
1.7.1
