From: rob.lee@linaro.org (Robert Lee)
Date: Tue, 31 Jan 2012 21:00:14 -0600
Subject: [RFC PATCH v4 4/4] x86: Remove cpuidle timekeeping and irq
 enable/disable
In-Reply-To: <1328065215-28108-1-git-send-email-rob.lee@linaro.org>
References: <1328065215-28108-1-git-send-email-rob.lee@linaro.org>
Message-ID: <1328065215-28108-5-git-send-email-rob.lee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the core cpuidle driver keeps time and handles irq enabling,
remove this functionality.  Also, remove irq disabling as all paths to
cpuidle_idle_call already call local_irq_disable.  Also, restructure
idle functions as needed by the cpuidle core driver changes.

Signed-off-by: Robert Lee <rob.lee@linaro.org>
---
 drivers/idle/intel_idle.c |  110 ++++++++++++++++++++++++++++++++-------------
 1 files changed, 79 insertions(+), 31 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 20bce51..482deb6 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -82,8 +82,14 @@ static unsigned int mwait_substates;
 static unsigned int lapic_timer_reliable_states = (1 << 1);	 /* Default to only C1 */
 
 static struct cpuidle_device __percpu *intel_idle_cpuidle_devices;
+
+static int intel_pre_idle(struct cpuidle_device *dev,
+			struct cpuidle_driver *drv, int index);
 static int intel_idle(struct cpuidle_device *dev,
 			struct cpuidle_driver *drv, int index);
+static int intel_post_idle(struct cpuidle_device *dev,
+			struct cpuidle_driver *drv, int index);
+
 
 static struct cpuidle_state *cpuidle_state_table;
 
@@ -114,21 +120,27 @@ static struct cpuidle_state nehalem_cstates[MWAIT_MAX_NUM_CSTATES] = {
 		.flags = CPUIDLE_FLAG_TIME_VALID,
 		.exit_latency = 3,
 		.target_residency = 6,
-		.enter = &intel_idle },
+		.pre_enter = &intel_pre_idle,
+		.enter = &intel_idle,
+		.post_enter = &intel_post_idle },
 	{ /* MWAIT C2 */
 		.name = "C3-NHM",
 		.desc = "MWAIT 0x10",
 		.flags = CPUIDLE_FLAG_TIME_VALID | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 20,
 		.target_residency = 80,
-		.enter = &intel_idle },
+		.pre_enter = &intel_pre_idle,
+		.enter = &intel_idle,
+		.post_enter = &intel_post_idle },
 	{ /* MWAIT C3 */
 		.name = "C6-NHM",
 		.desc = "MWAIT 0x20",
 		.flags = CPUIDLE_FLAG_TIME_VALID | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 200,
 		.target_residency = 800,
-		.enter = &intel_idle },
+		.pre_enter = &intel_pre_idle,
+		.enter = &intel_idle,
+		.post_enter = &intel_post_idle },
 };
 
 static struct cpuidle_state snb_cstates[MWAIT_MAX_NUM_CSTATES] = {
@@ -139,28 +151,36 @@ static struct cpuidle_state snb_cstates[MWAIT_MAX_NUM_CSTATES] = {
 		.flags = CPUIDLE_FLAG_TIME_VALID,
 		.exit_latency = 1,
 		.target_residency = 1,
-		.enter = &intel_idle },
+		.pre_enter = &intel_pre_idle,
+		.enter = &intel_idle,
+		.post_enter = &intel_post_idle },
 	{ /* MWAIT C2 */
 		.name = "C3-SNB",
 		.desc = "MWAIT 0x10",
 		.flags = CPUIDLE_FLAG_TIME_VALID | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 80,
 		.target_residency = 211,
-		.enter = &intel_idle },
+		.pre_enter = &intel_pre_idle,
+		.enter = &intel_idle,
+		.post_enter = &intel_post_idle },
 	{ /* MWAIT C3 */
 		.name = "C6-SNB",
 		.desc = "MWAIT 0x20",
 		.flags = CPUIDLE_FLAG_TIME_VALID | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 104,
 		.target_residency = 345,
-		.enter = &intel_idle },
+		.pre_enter = &intel_pre_idle,
+		.enter = &intel_idle,
+		.post_enter = &intel_post_idle },
 	{ /* MWAIT C4 */
 		.name = "C7-SNB",
 		.desc = "MWAIT 0x30",
 		.flags = CPUIDLE_FLAG_TIME_VALID | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 109,
 		.target_residency = 345,
-		.enter = &intel_idle },
+		.pre_enter = &intel_pre_idle,
+		.enter = &intel_idle,
+		.post_enter = &intel_post_idle },
 };
 
 static struct cpuidle_state atom_cstates[MWAIT_MAX_NUM_CSTATES] = {
@@ -171,14 +191,18 @@ static struct cpuidle_state atom_cstates[MWAIT_MAX_NUM_CSTATES] = {
 		.flags = CPUIDLE_FLAG_TIME_VALID,
 		.exit_latency = 1,
 		.target_residency = 4,
-		.enter = &intel_idle },
+		.pre_enter = &intel_pre_idle,
+		.enter = &intel_idle,
+		.post_enter = &intel_post_idle },
 	{ /* MWAIT C2 */
 		.name = "C2-ATM",
 		.desc = "MWAIT 0x10",
 		.flags = CPUIDLE_FLAG_TIME_VALID,
 		.exit_latency = 20,
 		.target_residency = 80,
-		.enter = &intel_idle },
+		.pre_enter = &intel_pre_idle,
+		.enter = &intel_idle,
+		.post_enter = &intel_post_idle },
 	{ /* MWAIT C3 */ },
 	{ /* MWAIT C4 */
 		.name = "C4-ATM",
@@ -186,7 +210,9 @@ static struct cpuidle_state atom_cstates[MWAIT_MAX_NUM_CSTATES] = {
 		.flags = CPUIDLE_FLAG_TIME_VALID | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 100,
 		.target_residency = 400,
-		.enter = &intel_idle },
+		.pre_enter = &intel_pre_idle,
+		.enter = &intel_idle,
+		.post_enter = &intel_post_idle },
 	{ /* MWAIT C5 */ },
 	{ /* MWAIT C6 */
 		.name = "C6-ATM",
@@ -194,7 +220,9 @@ static struct cpuidle_state atom_cstates[MWAIT_MAX_NUM_CSTATES] = {
 		.flags = CPUIDLE_FLAG_TIME_VALID | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 140,
 		.target_residency = 560,
-		.enter = &intel_idle },
+		.pre_enter = &intel_pre_idle,
+		.enter = &intel_idle,
+		.post_enter = &intel_post_idle },
 };
 
 static long get_driver_data(int cstate)
@@ -227,24 +255,20 @@ static long get_driver_data(int cstate)
 }
 
 /**
- * intel_idle
+ * intel_pre_idle
  * @dev: cpuidle_device
  * @drv: cpuidle driver
  * @index: index of cpuidle state
  *
  * Must be called under local_irq_disable().
  */
-static int intel_idle(struct cpuidle_device *dev,
+static int intel_pre_idle(struct cpuidle_device *dev,
 		struct cpuidle_driver *drv, int index)
 {
-	unsigned long ecx = 1; /* break on interrupt flag */
 	struct cpuidle_state *state = &drv->states[index];
-	struct cpuidle_state_usage *state_usage = &dev->states_usage[index];
-	unsigned long eax = (unsigned long)cpuidle_get_statedata(state_usage);
+	const unsigned long eax =
+			(unsigned long)dev->states_usage[index].driver_data;
 	unsigned int cstate;
-	ktime_t kt_before, kt_after;
-	s64 usec_delta;
-	int cpu = smp_processor_id();
 
 	cstate = (((eax) >> MWAIT_SUBSTATE_SIZE) & MWAIT_CSTATE_MASK) + 1;
 
@@ -253,12 +277,27 @@ static int intel_idle(struct cpuidle_device *dev,
 	 * for flushing the user TLB's associated with the active mm.
 	 */
 	if (state->flags & CPUIDLE_FLAG_TLB_FLUSHED)
-		leave_mm(cpu);
+		leave_mm(dev->cpu);
 
 	if (!(lapic_timer_reliable_states & (1 << (cstate))))
-		clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &cpu);
+		clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &dev->cpu);
 
-	kt_before = ktime_get_real();
+	return index;
+}
+
+/**
+ * intel_idle
+ * @dev: cpuidle_device
+ * @drv: cpuidle driver
+ * @index: index of cpuidle state
+ *
+ * Must be called under local_irq_disable().
+ */
+static int intel_idle(struct cpuidle_device *dev,
+		struct cpuidle_driver *drv, int index)
+{
+	const unsigned long eax =
+			(unsigned long)dev->states_usage[index].driver_data;
 
 	stop_critical_timings();
 	if (!need_resched()) {
@@ -266,21 +305,30 @@ static int intel_idle(struct cpuidle_device *dev,
 		__monitor((void *)&current_thread_info()->flags, 0, 0);
 		smp_mb();
 		if (!need_resched())
-			__mwait(eax, ecx);
+			__mwait(eax, 1);
 	}
-
 	start_critical_timings();
 
-	kt_after = ktime_get_real();
-	usec_delta = ktime_to_us(ktime_sub(kt_after, kt_before));
+	return index;
+}
 
-	local_irq_enable();
+/**
+ * intel_post_idle
+ * @dev: cpuidle_device
+ * @drv: cpuidle driver
+ * @index: index of cpuidle state
+ */
+static int intel_post_idle(struct cpuidle_device *dev,
+		struct cpuidle_driver *drv, int index)
+{
+	const unsigned long eax =
+			(unsigned long)dev->states_usage[index].driver_data;
+	unsigned int cstate;
 
-	if (!(lapic_timer_reliable_states & (1 << (cstate))))
-		clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &cpu);
+	cstate = (((eax) >> MWAIT_SUBSTATE_SIZE) & MWAIT_CSTATE_MASK) + 1;
 
-	/* Update cpuidle counters */
-	dev->last_residency = (int)usec_delta;
+	if (!(lapic_timer_reliable_states & (1 << (cstate))))
+		clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &dev->cpu);
 
 	return index;
 }
-- 
1.7.1
