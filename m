From: rob.lee@linaro.org (Robert Lee)
Date: Sun, 26 Feb 2012 22:47:35 -0600
Subject: [PATCH v5 1/9] cpuidle: Add commonly used functionality for
 consolidation
In-Reply-To: <1330318063-25460-1-git-send-email-rob.lee@linaro.org>
References: <1330318063-25460-1-git-send-email-rob.lee@linaro.org>
Message-ID: <1330318063-25460-2-git-send-email-rob.lee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add functionality that is commonly duplicated by various platforms.

Signed-off-by: Robert Lee <rob.lee@linaro.org>
---
 drivers/cpuidle/cpuidle.c |   37 ++++++++++++++++++------------
 include/linux/cpuidle.h   |   55 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 77 insertions(+), 15 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 59f4261..f21d58e 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -18,6 +18,7 @@
 #include <linux/ktime.h>
 #include <linux/hrtimer.h>
 #include <linux/module.h>
+#include <asm/proc-fns.h>
 #include <trace/events/power.h>
 
 #include "cpuidle.h"
@@ -97,7 +98,11 @@ int cpuidle_idle_call(void)
 	trace_power_start(POWER_CSTATE, next_state, dev->cpu);
 	trace_cpu_idle(next_state, dev->cpu);
 
-	entered_state = target_state->enter(dev, drv, next_state);
+	if (drv->en_core_tk_irqen)
+		entered_state = cpuidle_wrap_enter(dev,	drv, next_state,
+						target_state->enter);
+	else
+		entered_state = target_state->enter(dev, drv, next_state);
 
 	trace_power_end(dev->cpu);
 	trace_cpu_idle(PWR_EVENT_EXIT, dev->cpu);
@@ -164,28 +169,31 @@ void cpuidle_resume_and_unlock(void)
 
 EXPORT_SYMBOL_GPL(cpuidle_resume_and_unlock);
 
-#ifdef CONFIG_ARCH_HAS_CPU_RELAX
-static int poll_idle(struct cpuidle_device *dev,
+int cpuidle_simple_enter(struct cpuidle_device *dev,
 		struct cpuidle_driver *drv, int index)
 {
-	ktime_t	t1, t2;
-	s64 diff;
+	cpu_do_idle();
+
+	return index;
+}
 
-	t1 = ktime_get();
-	local_irq_enable();
+#ifdef CONFIG_ARCH_HAS_CPU_RELAX
+static inline int __poll_idle(struct cpuidle_device *dev,
+		struct cpuidle_driver *drv, int index)
+{
 	while (!need_resched())
 		cpu_relax();
 
-	t2 = ktime_get();
-	diff = ktime_to_us(ktime_sub(t2, t1));
-	if (diff > INT_MAX)
-		diff = INT_MAX;
-
-	dev->last_residency = (int) diff;
-
 	return index;
 }
 
+static int poll_idle(struct cpuidle_device *dev,
+		struct cpuidle_driver *drv, int index)
+{
+	return cpuidle_wrap_enter(dev,	drv, next_state,
+				__poll_idle);
+}
+
 static void poll_idle_init(struct cpuidle_driver *drv)
 {
 	struct cpuidle_state *state = &drv->states[0];
@@ -195,7 +203,6 @@ static void poll_idle_init(struct cpuidle_driver *drv)
 	state->exit_latency = 0;
 	state->target_residency = 0;
 	state->power_usage = -1;
-	state->flags = 0;
 	state->enter = poll_idle;
 }
 #else
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index 712abcc..6563683 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -15,6 +15,7 @@
 #include <linux/list.h>
 #include <linux/kobject.h>
 #include <linux/completion.h>
+#include <linux/hrtimer.h>
 
 #define CPUIDLE_STATE_MAX	8
 #define CPUIDLE_NAME_LEN	16
@@ -56,6 +57,16 @@ struct cpuidle_state {
 
 #define CPUIDLE_DRIVER_FLAGS_MASK (0xFFFF0000)
 
+/* Common ARM WFI state */
+#define CPUIDLE_ARM_WFI_STATE {\
+	.enter                  = cpuidle_simple_enter,\
+	.exit_latency           = 1,\
+	.target_residency       = 1,\
+	.flags                  = CPUIDLE_FLAG_TIME_VALID,\
+	.name                   = "WFI",\
+	.desc                   = "ARM core clock gating (WFI)",\
+}
+
 /**
  * cpuidle_get_statedata - retrieves private driver state data
  * @st_usage: the state usage statistics
@@ -122,6 +133,14 @@ struct cpuidle_driver {
 	struct module 		*owner;
 
 	unsigned int		power_specified:1;
+	/*
+	 * use the core cpuidle time keeping. This has been implemented for the
+	 * entire driver instead of per state as currently the device enter
+	 * fuction allows the entered state to change which requires handling
+	 * that requires a (subjectively) unnecessary decrease to efficiency
+	 * in this commonly called code.
+	 */
+	unsigned int		en_core_tk_irqen:1;
 	struct cpuidle_state	states[CPUIDLE_STATE_MAX];
 	int			state_count;
 	int			safe_state_index;
@@ -140,6 +159,39 @@ extern void cpuidle_pause_and_lock(void);
 extern void cpuidle_resume_and_unlock(void);
 extern int cpuidle_enable_device(struct cpuidle_device *dev);
 extern void cpuidle_disable_device(struct cpuidle_device *dev);
+extern int cpuidle_simple_enter(struct cpuidle_device *dev,
+		struct cpuidle_driver *drv, int index);
+
+/**
+ * cpuidle_enter_wrap - performing timekeeping and irq around enter function
+ * @dev: pointer to a valid cpuidle_device object
+ * @drv: pointer to a valid cpuidle_driver object
+ * @index: index of the target cpuidle state.
+ */
+static inline int cpuidle_wrap_enter(struct cpuidle_device *dev,
+				struct cpuidle_driver *drv, int index,
+				int (*enter)(struct cpuidle_device *dev,
+					struct cpuidle_driver *drv, int index))
+{
+	ktime_t time_start, time_end;
+	s64 diff;
+
+	time_start = ktime_get();
+
+	index = enter(dev, drv, index);
+
+	time_end = ktime_get();
+
+	local_irq_enable();
+
+	diff = ktime_to_us(ktime_sub(time_end, time_start));
+	if (diff > INT_MAX)
+		diff = INT_MAX;
+
+	dev->last_residency = (int) diff;
+
+	return index;
+}
 
 #else
 static inline void disable_cpuidle(void) { }
@@ -157,6 +209,9 @@ static inline void cpuidle_resume_and_unlock(void) { }
 static inline int cpuidle_enable_device(struct cpuidle_device *dev)
 {return -ENODEV; }
 static inline void cpuidle_disable_device(struct cpuidle_device *dev) { }
+static inline int cpuidle_simple_enter(struct cpuidle_device *dev,
+		struct cpuidle_driver *drv, int index)
+{return -ENODEV; }
 
 #endif
 
-- 
1.7.1
