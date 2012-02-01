From: rob.lee@linaro.org (Robert Lee)
Date: Tue, 31 Jan 2012 21:00:13 -0600
Subject: [RFC PATCH v4 3/4] acpi: Remove cpuidle timekeeping and irq
 enable/disable
In-Reply-To: <1328065215-28108-1-git-send-email-rob.lee@linaro.org>
References: <1328065215-28108-1-git-send-email-rob.lee@linaro.org>
Message-ID: <1328065215-28108-4-git-send-email-rob.lee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the core cpuidle driver keeps time and handles irq enabling,
remove this functionality.  Also, remove irq disabling as all paths to
cpuidle_idle_call already call local_irq_disable.  Also, restructure
idle functions as needed by the cpuidle core driver changes.

Signed-off-by: Robert Lee <rob.lee@linaro.org>
---
 drivers/acpi/processor_idle.c |  203 ++++++++++++++++++++++++-----------------
 1 files changed, 119 insertions(+), 84 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 0e8e2de..7182b7e 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -139,7 +139,6 @@ static void acpi_safe_halt(void)
 	smp_mb();
 	if (!need_resched()) {
 		safe_halt();
-		local_irq_disable();
 	}
 	current_thread_info()->status |= TS_POLLING;
 }
@@ -730,70 +729,74 @@ static inline void acpi_idle_do_entry(struct acpi_processor_cx *cx)
 }
 
 /**
- * acpi_idle_enter_c1 - enters an ACPI C1 state-type
+ * acpi_idle_pre_enter_c1 - prepares an ACPI C1 state-type
  * @dev: the target CPU
  * @drv: cpuidle driver containing cpuidle state info
  * @index: index of target state
- *
- * This is equivalent to the HALT instruction.
  */
-static int acpi_idle_enter_c1(struct cpuidle_device *dev,
+static int acpi_idle_pre_enter_c1(struct cpuidle_device *dev,
 		struct cpuidle_driver *drv, int index)
 {
-	ktime_t  kt1, kt2;
-	s64 idle_time;
-	struct acpi_processor *pr;
-	struct cpuidle_state_usage *state_usage = &dev->states_usage[index];
-	struct acpi_processor_cx *cx = cpuidle_get_statedata(state_usage);
-
-	pr = __this_cpu_read(processors);
-	dev->last_residency = 0;
+	struct acpi_processor_cx *cx = dev->states_usage[index].driver_data;
+	struct acpi_processor *pr = __this_cpu_read(processors);
 
 	if (unlikely(!pr))
 		return -EINVAL;
 
-	local_irq_disable();
-
 	lapic_timer_state_broadcast(pr, cx, 1);
-	kt1 = ktime_get_real();
+
+	return index;
+}
+
+/**
+ * acpi_idle_enter_c1 - enters an ACPI C1 state-type
+ * @dev: the target CPU
+ * @drv: cpuidle driver containing cpuidle state info
+ * @index: index of target state
+ *
+ * This is equivalent to the HALT instruction.
+ */
+static int acpi_idle_enter_c1(struct cpuidle_device *dev,
+		struct cpuidle_driver *drv, int index)
+{
+	struct acpi_processor_cx *cx = dev->states_usage[index].driver_data;
+
 	acpi_idle_do_entry(cx);
-	kt2 = ktime_get_real();
-	idle_time =  ktime_to_us(ktime_sub(kt2, kt1));
 
-	/* Update device last_residency*/
-	dev->last_residency = (int)idle_time;
+	return index;
+}
+/**
+ * acpi_idle_enter_c1 - post ACPI C1 state-type cleanup
+ * @dev: the target CPU
+ * @drv: cpuidle driver containing cpuidle state info
+ * @index: index of target state
+ */
+static int acpi_idle_post_enter_c1(struct cpuidle_device *dev,
+		struct cpuidle_driver *drv, int index)
+{
+	struct acpi_processor_cx *cx = dev->states_usage[index].driver_data;
+	struct acpi_processor *pr = __this_cpu_read(processors);
 
-	local_irq_enable();
-	cx->usage++;
 	lapic_timer_state_broadcast(pr, cx, 0);
 
-	return index;
+	return 0;
 }
 
 /**
- * acpi_idle_enter_simple - enters an ACPI state without BM handling
+ * acpi_idle_preenter_simple - prepare an ACPI state without BM handling
  * @dev: the target CPU
  * @drv: cpuidle driver with cpuidle state information
  * @index: the index of suggested state
  */
-static int acpi_idle_enter_simple(struct cpuidle_device *dev,
+static int acpi_idle_pre_enter_simple(struct cpuidle_device *dev,
 		struct cpuidle_driver *drv, int index)
 {
-	struct acpi_processor *pr;
-	struct cpuidle_state_usage *state_usage = &dev->states_usage[index];
-	struct acpi_processor_cx *cx = cpuidle_get_statedata(state_usage);
-	ktime_t  kt1, kt2;
-	s64 idle_time_ns;
-	s64 idle_time;
-
-	pr = __this_cpu_read(processors);
-	dev->last_residency = 0;
+	struct acpi_processor_cx *cx = dev->states_usage[index].driver_data;
+	struct acpi_processor *pr = __this_cpu_read(processors);
 
 	if (unlikely(!pr))
 		return -EINVAL;
 
-	local_irq_disable();
-
 	if (cx->entry_method != ACPI_CSTATE_FFH) {
 		current_thread_info()->status &= ~TS_POLLING;
 		/*
@@ -804,7 +807,6 @@ static int acpi_idle_enter_simple(struct cpuidle_device *dev,
 
 		if (unlikely(need_resched())) {
 			current_thread_info()->status |= TS_POLLING;
-			local_irq_enable();
 			return -EINVAL;
 		}
 	}
@@ -818,56 +820,65 @@ static int acpi_idle_enter_simple(struct cpuidle_device *dev,
 	if (cx->type == ACPI_STATE_C3)
 		ACPI_FLUSH_CPU_CACHE();
 
-	kt1 = ktime_get_real();
 	/* Tell the scheduler that we are going deep-idle: */
 	sched_clock_idle_sleep_event();
+
+	return index;
+}
+
+/**
+ * acpi_idle_enter_simple - enters an ACPI state without BM handling
+ * @dev: the target CPU
+ * @drv: cpuidle driver with cpuidle state information
+ * @index: the index of suggested state
+ */
+static int acpi_idle_enter_simple(struct cpuidle_device *dev,
+		struct cpuidle_driver *drv, int index)
+{
+	struct acpi_processor_cx *cx = dev->states_usage[index].driver_data;
+
 	acpi_idle_do_entry(cx);
-	kt2 = ktime_get_real();
-	idle_time_ns = ktime_to_ns(ktime_sub(kt2, kt1));
-	idle_time = idle_time_ns;
-	do_div(idle_time, NSEC_PER_USEC);
 
-	/* Update device last_residency*/
-	dev->last_residency = (int)idle_time;
+	sched_clock_idle_wakeup_event(0);
 
-	/* Tell the scheduler how much we idled: */
-	sched_clock_idle_wakeup_event(idle_time_ns);
+	return index;
+}
+
+
+/**
+ * acpi_idle_post_enter_simple - ACPI state without BM handling cleanup
+ * @dev: the target CPU
+ * @drv: cpuidle driver with cpuidle state information
+ * @index: the index of suggested state
+ */
+static int acpi_idle_post_enter_simple(struct cpuidle_device *dev,
+		struct cpuidle_driver *drv, int index)
+{
+	struct acpi_processor_cx *cx = dev->states_usage[index].driver_data;
+	struct acpi_processor *pr = __this_cpu_read(processors);
 
-	local_irq_enable();
 	if (cx->entry_method != ACPI_CSTATE_FFH)
 		current_thread_info()->status |= TS_POLLING;
 
-	cx->usage++;
-
 	lapic_timer_state_broadcast(pr, cx, 0);
-	cx->time += idle_time;
-	return index;
+
+	return 0;
 }
 
 static int c3_cpu_count;
 static DEFINE_RAW_SPINLOCK(c3_lock);
 
 /**
- * acpi_idle_enter_bm - enters C3 with proper BM handling
+ * acpi_idle_pre_enter_bm - runs checks and prepares for C3
  * @dev: the target CPU
  * @drv: cpuidle driver containing state data
  * @index: the index of suggested state
- *
- * If BM is detected, the deepest non-C3 idle state is entered instead.
  */
-static int acpi_idle_enter_bm(struct cpuidle_device *dev,
+static int acpi_idle_pre_enter_bm(struct cpuidle_device *dev,
 		struct cpuidle_driver *drv, int index)
 {
-	struct acpi_processor *pr;
-	struct cpuidle_state_usage *state_usage = &dev->states_usage[index];
-	struct acpi_processor_cx *cx = cpuidle_get_statedata(state_usage);
-	ktime_t  kt1, kt2;
-	s64 idle_time_ns;
-	s64 idle_time;
-
-
-	pr = __this_cpu_read(processors);
-	dev->last_residency = 0;
+	struct acpi_processor_cx *cx = dev->states_usage[index].driver_data;
+	struct acpi_processor *pr = __this_cpu_read(processors);
 
 	if (unlikely(!pr))
 		return -EINVAL;
@@ -877,15 +888,11 @@ static int acpi_idle_enter_bm(struct cpuidle_device *dev,
 			return drv->states[drv->safe_state_index].enter(dev,
 						drv, drv->safe_state_index);
 		} else {
-			local_irq_disable();
 			acpi_safe_halt();
-			local_irq_enable();
 			return -EINVAL;
 		}
 	}
 
-	local_irq_disable();
-
 	if (cx->entry_method != ACPI_CSTATE_FFH) {
 		current_thread_info()->status &= ~TS_POLLING;
 		/*
@@ -896,7 +903,6 @@ static int acpi_idle_enter_bm(struct cpuidle_device *dev,
 
 		if (unlikely(need_resched())) {
 			current_thread_info()->status |= TS_POLLING;
-			local_irq_enable();
 			return -EINVAL;
 		}
 	}
@@ -911,7 +917,22 @@ static int acpi_idle_enter_bm(struct cpuidle_device *dev,
 	 */
 	lapic_timer_state_broadcast(pr, cx, 1);
 
-	kt1 = ktime_get_real();
+	return index;
+}
+
+/**
+ * acpi_idle_enter_bm - enters C3 with proper BM handling
+ * @dev: the target CPU
+ * @drv: cpuidle driver containing state data
+ * @index: the index of suggested state
+ *
+ * If BM is detected, the deepest non-C3 idle state is entered instead.
+ */
+static int acpi_idle_enter_bm(struct cpuidle_device *dev,
+		struct cpuidle_driver *drv, int index)
+{
+	struct acpi_processor_cx *cx = dev->states_usage[index].driver_data;
+	struct acpi_processor *pr = __this_cpu_read(processors);
 	/*
 	 * disable bus master
 	 * bm_check implies we need ARB_DIS
@@ -942,26 +963,30 @@ static int acpi_idle_enter_bm(struct cpuidle_device *dev,
 		c3_cpu_count--;
 		raw_spin_unlock(&c3_lock);
 	}
-	kt2 = ktime_get_real();
-	idle_time_ns = ktime_to_ns(ktime_sub(kt2, kt1));
-	idle_time = idle_time_ns;
-	do_div(idle_time, NSEC_PER_USEC);
 
-	/* Update device last_residency*/
-	dev->last_residency = (int)idle_time;
+	sched_clock_idle_wakeup_event(0);
 
-	/* Tell the scheduler how much we idled: */
-	sched_clock_idle_wakeup_event(idle_time_ns);
+	return index;
+}
+
+/**
+ * acpi_idle_post_enter_bm - cleanup after exiting C3
+ * @dev: the target CPU
+ * @drv: cpuidle driver containing state data
+ * @index: the index of suggested state
+ */
+static int acpi_idle_post_enter_bm(struct cpuidle_device *dev,
+		struct cpuidle_driver *drv, int index)
+{
+	struct acpi_processor_cx *cx = dev->states_usage[index].driver_data;
+	struct acpi_processor *pr = __this_cpu_read(processors);
 
-	local_irq_enable();
 	if (cx->entry_method != ACPI_CSTATE_FFH)
 		current_thread_info()->status |= TS_POLLING;
 
-	cx->usage++;
-
 	lapic_timer_state_broadcast(pr, cx, 0);
-	cx->time += idle_time;
-	return index;
+
+	return 0;
 }
 
 struct cpuidle_driver acpi_idle_driver = {
@@ -1076,21 +1101,31 @@ static int acpi_processor_setup_cpuidle_states(struct acpi_processor *pr)
 			if (cx->entry_method == ACPI_CSTATE_FFH)
 				state->flags |= CPUIDLE_FLAG_TIME_VALID;
 
+			state->pre_enter = acpi_idle_pre_enter_c1;
 			state->enter = acpi_idle_enter_c1;
+			state->enter = acpi_idle_post_enter_c1;
 			drv->safe_state_index = count;
 			break;
 
 			case ACPI_STATE_C2:
 			state->flags |= CPUIDLE_FLAG_TIME_VALID;
+			state->pre_enter = acpi_idle_pre_enter_simple;
 			state->enter = acpi_idle_enter_simple;
+			state->post_enter = acpi_idle_post_enter_simple;
 			drv->safe_state_index = count;
 			break;
 
 			case ACPI_STATE_C3:
 			state->flags |= CPUIDLE_FLAG_TIME_VALID;
+			state->pre_enter = pr->flags.bm_check ?
+					acpi_idle_pre_enter_bm :
+					acpi_idle_pre_enter_simple;
 			state->enter = pr->flags.bm_check ?
 					acpi_idle_enter_bm :
 					acpi_idle_enter_simple;
+			state->post_enter = pr->flags.bm_check ?
+					acpi_idle_post_enter_bm :
+					acpi_idle_post_enter_simple;
 			break;
 		}
 
-- 
1.7.1
