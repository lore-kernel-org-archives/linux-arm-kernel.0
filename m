From: rob.lee@linaro.org (Robert Lee)
Date: Tue, 31 Jan 2012 21:00:12 -0600
Subject: [RFC PATCH v4 2/4] ARM: omap: Remove cpuidle timekeeping and irq
 enable/disable
In-Reply-To: <1328065215-28108-1-git-send-email-rob.lee@linaro.org>
References: <1328065215-28108-1-git-send-email-rob.lee@linaro.org>
Message-ID: <1328065215-28108-3-git-send-email-rob.lee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the core cpuidle driver keeps time and handles irq enabling,
remove this functionality.  Also, remove irq disabling as all paths to
cpuidle_idle_call already call local_irq_disable.  Also, restructure
idle functions as needed by the cpuidle core driver changes.

Signed-off-by: Robert Lee <rob.lee@linaro.org>
---
 arch/arm/mach-omap2/cpuidle34xx.c |   96 ++++++++++++++++--------------------
 1 files changed, 43 insertions(+), 53 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 464cffd..9ecded5 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -69,7 +69,14 @@ struct omap3_idle_statedata {
 	u32 core_state;
 	u8 valid;
 };
-struct omap3_idle_statedata omap3_idle_data[OMAP3_NUM_STATES];
+
+struct omap3_idle_drvdata {
+	struct omap3_idle_statedata state_data[OMAP3_NUM_STATES];
+	u32 per_saved_state;
+	u32 per_next_state;
+};
+
+static struct omap3_idle_drvdata omap3_idle_data;
 
 struct powerdomain *mpu_pd, *core_pd, *per_pd, *cam_pd;
 
@@ -100,23 +107,20 @@ static int omap3_enter_idle(struct cpuidle_device *dev,
 				struct cpuidle_driver *drv,
 				int index)
 {
-	struct omap3_idle_statedata *cx =
-			cpuidle_get_statedata(&dev->states_usage[index]);
-	struct timespec ts_preidle, ts_postidle, ts_idle;
-	u32 mpu_state = cx->mpu_state, core_state = cx->core_state;
-	int idle_time;
+	struct omap3_idle_drvdata *dd = dev->states_usage[index].driver_data
 
-	/* Used to keep track of the total time in idle */
-	getnstimeofday(&ts_preidle);
+	u32 mpu_state = dd->state_data[index].mpu_state;
+	u32 core_state = dd->state_data[index].core_state;
 
-	local_irq_disable();
 	local_fiq_disable();
 
 	pwrdm_set_next_pwrst(mpu_pd, mpu_state);
 	pwrdm_set_next_pwrst(core_pd, core_state);
 
-	if (omap_irq_pending() || need_resched())
-		goto return_sleep_time;
+	if (omap_irq_pending() || need_resched()) {
+		index = -EBUSY;
+		goto leave;
+	}
 
 	/* Deny idle for C1 */
 	if (index == 0) {
@@ -147,18 +151,12 @@ static int omap3_enter_idle(struct cpuidle_device *dev,
 		pwrdm_for_each_clkdm(core_pd, _cpuidle_allow_idle);
 	}
 
-return_sleep_time:
-	getnstimeofday(&ts_postidle);
-	ts_idle = timespec_sub(ts_postidle, ts_preidle);
-
-	local_irq_enable();
+leave:
 	local_fiq_enable();
 
-	idle_time = ts_idle.tv_nsec / NSEC_PER_USEC + ts_idle.tv_sec * \
-								USEC_PER_SEC;
-
-	/* Update cpuidle counters */
-	dev->last_residency = idle_time;
+	/* Restore original PER state if it was modified */
+	if (dd->per_next_state != dd->per_saved_state)
+		pwrdm_set_next_pwrst(per_pd, dd->per_saved_state);
 
 	return index;
 }
@@ -180,9 +178,10 @@ static int next_valid_state(struct cpuidle_device *dev,
 			struct cpuidle_driver *drv,
 				int index)
 {
-	struct cpuidle_state_usage *curr_usage = &dev->states_usage[index];
 	struct cpuidle_state *curr = &drv->states[index];
-	struct omap3_idle_statedata *cx = cpuidle_get_statedata(curr_usage);
+	struct omap3_idle_drvdata *dd = dev->states_usage[index].driver_data;
+	struct omap3_idle_statedata *cx = &dd->state_data[index];
+
 	u32 mpu_deepest_state = PWRDM_POWER_RET;
 	u32 core_deepest_state = PWRDM_POWER_RET;
 	int next_index = -1;
@@ -223,7 +222,8 @@ static int next_valid_state(struct cpuidle_device *dev,
 		 */
 		idx--;
 		for (; idx >= 0; idx--) {
-			cx = cpuidle_get_statedata(&dev->states_usage[idx]);
+			dd = dev->states_usage[idx].driver_data;
+			cx = &dd->state_data[idx];
 			if ((cx->valid) &&
 			    (cx->mpu_state >= mpu_deepest_state) &&
 			    (cx->core_state >= core_deepest_state)) {
@@ -255,8 +255,9 @@ static int omap3_enter_idle_bm(struct cpuidle_device *dev,
 			       int index)
 {
 	int new_state_idx;
-	u32 core_next_state, per_next_state = 0, per_saved_state = 0, cam_state;
-	struct omap3_idle_statedata *cx;
+	u32 core_next_state, cam_state;
+	struct omap3_idle_drvdata *dd = dev->states_usage[index].driver_data;
+	struct omap3_idle_statedata *cx = &dd->state_data[index];
 	int ret;
 
 	/*
@@ -264,10 +265,8 @@ static int omap3_enter_idle_bm(struct cpuidle_device *dev,
 	 * CAM does not have wakeup capability in OMAP3.
 	 */
 	cam_state = pwrdm_read_pwrst(cam_pd);
-	if (cam_state == PWRDM_POWER_ON) {
-		new_state_idx = drv->safe_state_index;
-		goto select_state;
-	}
+	if (cam_state == PWRDM_POWER_ON)
+		return drv->safe_state_index;
 
 	/*
 	 * FIXME: we currently manage device-specific idle states
@@ -281,27 +280,20 @@ static int omap3_enter_idle_bm(struct cpuidle_device *dev,
 	 * Prevent PER off if CORE is not in retention or off as this
 	 * would disable PER wakeups completely.
 	 */
-	cx = cpuidle_get_statedata(&dev->states_usage[index]);
 	core_next_state = cx->core_state;
-	per_next_state = per_saved_state = pwrdm_read_next_pwrst(per_pd);
-	if ((per_next_state == PWRDM_POWER_OFF) &&
-	    (core_next_state > PWRDM_POWER_RET))
-		per_next_state = PWRDM_POWER_RET;
-
-	/* Are we changing PER target state? */
-	if (per_next_state != per_saved_state)
-		pwrdm_set_next_pwrst(per_pd, per_next_state);
 
-	new_state_idx = next_valid_state(dev, drv, index);
+	dd->per_next_state = dd->per_saved_state =
+			pwrdm_read_next_pwrst(per_pd);
 
-select_state:
-	ret = omap3_enter_idle(dev, drv, new_state_idx);
+	if ((dd->per_next_state == PWRDM_POWER_OFF) &&
+	    (core_next_state > PWRDM_POWER_RET))
+		dd->per_next_state = PWRDM_POWER_RET;
 
-	/* Restore original PER state if it was modified */
-	if (per_next_state != per_saved_state)
-		pwrdm_set_next_pwrst(per_pd, per_saved_state);
+	/* Are we changing PER target state? */
+	if (dd->per_next_state != dd->per_saved_state)
+		pwrdm_set_next_pwrst(per_pd, dd->per_next_state);
 
-	return ret;
+	return next_valid_state(dev, drv, index);
 }
 
 DEFINE_PER_CPU(struct cpuidle_device, omap3_idle_dev);
@@ -337,7 +329,8 @@ static inline void _fill_cstate(struct cpuidle_driver *drv,
 	state->exit_latency	= cpuidle_params_table[idx].exit_latency;
 	state->target_residency	= cpuidle_params_table[idx].target_residency;
 	state->flags		= CPUIDLE_FLAG_TIME_VALID;
-	state->enter		= omap3_enter_idle_bm;
+	state->pre_enter	= omap3_enter_idle_bm;
+	state->enter		= omap3_enter_idle;
 	sprintf(state->name, "C%d", idx + 1);
 	strncpy(state->desc, descr, CPUIDLE_DESC_LEN);
 
@@ -348,13 +341,10 @@ static inline struct omap3_idle_statedata *_fill_cstate_usage(
 					struct cpuidle_device *dev,
 					int idx)
 {
-	struct omap3_idle_statedata *cx = &omap3_idle_data[idx];
-	struct cpuidle_state_usage *state_usage = &dev->states_usage[idx];
-
-	cx->valid		= cpuidle_params_table[idx].valid;
-	cpuidle_set_statedata(state_usage, cx);
+	omap3_idle_data.state_data[idx].valid = cpuidle_params_table[idx].valid;
+	cpuidle_set_statedata(&dev->states_usage[idx], &omap3_idle_data);
 
-	return cx;
+	return &omap3_idle_data.state_data[idx];
 }
 
 /**
-- 
1.7.1
