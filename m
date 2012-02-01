From: rob.lee@linaro.org (Robert Lee)
Date: Tue, 31 Jan 2012 21:00:11 -0600
Subject: [RFC PATCH v4 1/4] cpuidle: Add time keeping and irq enabling
In-Reply-To: <1328065215-28108-1-git-send-email-rob.lee@linaro.org>
References: <1328065215-28108-1-git-send-email-rob.lee@linaro.org>
Message-ID: <1328065215-28108-2-git-send-email-rob.lee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make necessary changes to add implement time keepign and irq enabling
in the core cpuidle code.  This will allow the remove of these
functionalities from the platform cpuidle implementations.

Signed-off-by: Robert Lee <rob.lee@linaro.org>
---
 drivers/cpuidle/cpuidle.c |   75 +++++++++++++++++++++++++++++++++++---------
 include/linux/cpuidle.h   |   26 ++++++++++-----
 2 files changed, 76 insertions(+), 25 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 59f4261..8ea0fc3 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -57,14 +57,18 @@ static int __cpuidle_register_device(struct cpuidle_device *dev);
  * cpuidle_idle_call - the main idle loop
  *
  * NOTE: no locks or semaphores should be used here
+ * NOTE: Should only be called from a local irq disabled context
  * return non-zero on failure
+ *
  */
 int cpuidle_idle_call(void)
 {
 	struct cpuidle_device *dev = __this_cpu_read(cpuidle_devices);
 	struct cpuidle_driver *drv = cpuidle_get_driver();
 	struct cpuidle_state *target_state;
-	int next_state, entered_state;
+	int idx, ret = 0;
+	ktime_t	t1, t2;
+	s64 diff;
 
 	if (off)
 		return -ENODEV;
@@ -86,37 +90,76 @@ int cpuidle_idle_call(void)
 #endif
 
 	/* ask the governor for the next state */
-	next_state = cpuidle_curr_governor->select(drv, dev);
+	idx = cpuidle_curr_governor->select(drv, dev);
+
+	target_state = &drv->states[idx];
+
+	/*
+	 * Check with the device to see if it can enter this state or if another
+	 * state should be used.
+	 */
+	if (target_state->pre_enter) {
+		idx = target_state->
+			pre_enter(dev, drv, idx);
+	}
+
+	if (idx < 0) {
+		local_irq_enable();
+		return idx;
+	}
+
 	if (need_resched()) {
 		local_irq_enable();
-		return 0;
+		return -EBUSY;
 	}
 
-	target_state = &drv->states[next_state];
+	target_state = &drv->states[idx];
 
-	trace_power_start(POWER_CSTATE, next_state, dev->cpu);
-	trace_cpu_idle(next_state, dev->cpu);
+	if ((target_state->flags & CPUIDLE_FLAG_TIME_VALID))
+		t1 = ktime_get();
 
-	entered_state = target_state->enter(dev, drv, next_state);
+	trace_power_start(POWER_CSTATE, idx, dev->cpu);
+	trace_cpu_idle(idx, dev->cpu);
+
+	idx = target_state->enter(dev, drv, idx);
 
 	trace_power_end(dev->cpu);
 	trace_cpu_idle(PWR_EVENT_EXIT, dev->cpu);
 
-	if (entered_state >= 0) {
-		/* Update cpuidle counters */
-		/* This can be moved to within driver enter routine
-		 * but that results in multiple copies of same code.
-		 */
-		dev->states_usage[entered_state].time +=
+	if (idx < 0) {
+		local_irq_enable();
+		return idx;
+	}
+
+	if (likely(target_state->flags & drv->states[idx].flags &
+		CPUIDLE_FLAG_TIME_VALID))
+		t2 = ktime_get();
+
+	local_irq_enable();
+
+	if (target_state->post_enter)
+		target_state->post_enter(dev, drv, idx);
+
+	if (likely(target_state->flags & drv->states[idx].flags &
+		CPUIDLE_FLAG_TIME_VALID)) {
+
+		diff = ktime_to_us(ktime_sub(t2, t1));
+		if (diff > INT_MAX)
+			diff = INT_MAX;
+
+		dev->last_residency = (int) diff;
+
+		dev->states_usage[idx].time +=
 				(unsigned long long)dev->last_residency;
-		dev->states_usage[entered_state].usage++;
 	}
 
+	dev->states_usage[idx].usage++;
+
 	/* give the governor an opportunity to reflect on the outcome */
 	if (cpuidle_curr_governor->reflect)
-		cpuidle_curr_governor->reflect(dev, entered_state);
+		cpuidle_curr_governor->reflect(dev, idx);
 
-	return 0;
+	return ret;
 }
 
 /**
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index 712abcc..8154f60 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -38,17 +38,25 @@ struct cpuidle_state_usage {
 };
 
 struct cpuidle_state {
-	char		name[CPUIDLE_NAME_LEN];
-	char		desc[CPUIDLE_DESC_LEN];
+	char			name[CPUIDLE_NAME_LEN];
+	char			desc[CPUIDLE_DESC_LEN];
+
+	unsigned int		flags;
+	unsigned int		exit_latency; /* in US */
+	unsigned int		power_usage; /* in mW */
+	unsigned int		target_residency; /* in US */
+
+	int (*pre_enter)	(struct cpuidle_device *dev,
+				struct cpuidle_driver *drv,
+				int index);
 
-	unsigned int	flags;
-	unsigned int	exit_latency; /* in US */
-	unsigned int	power_usage; /* in mW */
-	unsigned int	target_residency; /* in US */
+	int (*enter)		(struct cpuidle_device *dev,
+				struct cpuidle_driver *drv,
+				int index);
 
-	int (*enter)	(struct cpuidle_device *dev,
-			struct cpuidle_driver *drv,
-			int index);
+	int (*post_enter)	(struct cpuidle_device *dev,
+				struct cpuidle_driver *drv,
+				int index);
 };
 
 /* Idle State Flags */
-- 
1.7.1
