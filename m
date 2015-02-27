From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 27 Feb 2015 17:21:33 +0530
Subject: [PATCH 2/3] clockevents: Manage device's state separately for the core
In-Reply-To: <cover.1425037853.git.viresh.kumar@linaro.org>
References: <cover.1425037853.git.viresh.kumar@linaro.org>
Message-ID: <b6b0143a8a57bd58352ad35e08c25424c879c0cb.1425037853.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

'enum clock_event_mode' is used for two purposes today:
- to pass mode to the driver of clockevent device::set_mode().
- for managing state of the device for clockevents core.

For supporting new modes/states we have moved away from the legacy set_mode()
callback to new per-mode/state callbacks. New modes/states shouldn't be exposed
to the legacy (now OBSOLOTE) callbacks and so we shouldn't add new states to
'enum clock_event_mode'.

Lets have separate enums for the two use cases mentioned above. Keep using the
earlier enum for legacy set_mode() callback and mark it OBSOLETE. And add
another enum to clearly specify the possible states of a clockevent device.

This also renames the newly added per-mode callbacks to reflect state changes.

We haven't got rid of 'mode' member of 'struct clock_event_device' as it is used
by some of the clockevent drivers and it would automatically die down once we
migrate those drivers to the new interface. It ('mode') is only updated now for
the drivers using the legacy interface.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Suggested-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/common/bL_switcher.c |  8 ++--
 include/linux/clockchips.h    | 44 +++++++++++++------
 kernel/time/clockevents.c     | 99 +++++++++++++++++++++++--------------------
 kernel/time/tick-broadcast.c  | 20 ++++-----
 kernel/time/tick-common.c     |  7 +--
 kernel/time/tick-oneshot.c    |  6 +--
 kernel/time/timer_list.c      | 12 +++---
 7 files changed, 111 insertions(+), 85 deletions(-)

diff --git a/arch/arm/common/bL_switcher.c b/arch/arm/common/bL_switcher.c
index 6eaddc47c43d..d4f970a4d255 100644
--- a/arch/arm/common/bL_switcher.c
+++ b/arch/arm/common/bL_switcher.c
@@ -152,7 +152,7 @@ static int bL_switch_to(unsigned int new_cluster_id)
 	unsigned int ob_mpidr, ob_cpu, ob_cluster, ib_mpidr, ib_cpu, ib_cluster;
 	struct completion inbound_alive;
 	struct tick_device *tdev;
-	enum clock_event_mode tdev_mode;
+	enum clock_event_state tdev_state;
 	long volatile *handshake_ptr;
 	int ipi_nr, ret;
 
@@ -223,8 +223,8 @@ static int bL_switch_to(unsigned int new_cluster_id)
 	if (tdev && !cpumask_equal(tdev->evtdev->cpumask, cpumask_of(this_cpu)))
 		tdev = NULL;
 	if (tdev) {
-		tdev_mode = tdev->evtdev->mode;
-		clockevents_set_mode(tdev->evtdev, CLOCK_EVT_MODE_SHUTDOWN);
+		tdev_state = tdev->evtdev->state;
+		clockevents_set_state(tdev->evtdev, CLOCK_EVT_STATE_SHUTDOWN);
 	}
 
 	ret = cpu_pm_enter();
@@ -252,7 +252,7 @@ static int bL_switch_to(unsigned int new_cluster_id)
 	ret = cpu_pm_exit();
 
 	if (tdev) {
-		clockevents_set_mode(tdev->evtdev, tdev_mode);
+		clockevents_set_state(tdev->evtdev, tdev_state);
 		clockevents_program_event(tdev->evtdev,
 					  tdev->evtdev->next_event, 1);
 	}
diff --git a/include/linux/clockchips.h b/include/linux/clockchips.h
index a41749543d48..e20232c3320a 100644
--- a/include/linux/clockchips.h
+++ b/include/linux/clockchips.h
@@ -32,15 +32,31 @@ enum clock_event_nofitiers {
 struct clock_event_device;
 struct module;
 
-/* Clock event mode commands */
+/* Clock event mode commands for legacy ->set_mode(): OBSOLETE */
 enum clock_event_mode {
 	CLOCK_EVT_MODE_UNUSED = 0,
 	CLOCK_EVT_MODE_SHUTDOWN,
 	CLOCK_EVT_MODE_PERIODIC,
 	CLOCK_EVT_MODE_ONESHOT,
 	CLOCK_EVT_MODE_RESUME,
+};
 
-	/* Legacy ->set_mode() callback doesn't support below modes */
+/*
+ * Possible states of a clock event device.
+ *
+ * DETACHED:	Device is not used by clockevents core. Initial state or can be
+ *		reached from SHUTDOWN.
+ * SHUTDOWN:	Device is powered-off. Can be reached from PERIODIC or ONESHOT.
+ * PERIODIC:	Device is programmed to generate events periodically. Can be
+ *		reached from DETACHED or SHUTDOWN.
+ * ONESHOT:	Device is programmed to generate event only once. Can be reached
+ *		from DETACHED or SHUTDOWN.
+ */
+enum clock_event_state {
+	CLOCK_EVT_STATE_DETACHED = 0,
+	CLOCK_EVT_STATE_SHUTDOWN,
+	CLOCK_EVT_STATE_PERIODIC,
+	CLOCK_EVT_STATE_ONESHOT,
 };
 
 /*
@@ -80,13 +96,14 @@ enum clock_event_mode {
  * @min_delta_ns:	minimum delta value in ns
  * @mult:		nanosecond to cycles multiplier
  * @shift:		nanoseconds to cycles divisor (power of two)
- * @mode:		operating mode assigned by the management code
+ * @mode:		operating mode, relevant only to ->set_mode(), OBSOLETE
+ * @state:		current state of the device, assigned by the core code
  * @features:		features
  * @retries:		number of forced programming retries
  * @set_mode:		legacy set mode function, only for modes <= CLOCK_EVT_MODE_RESUME.
- * @set_mode_periodic:	switch mode to periodic, if !set_mode
- * @set_mode_oneshot:	switch mode to oneshot, if !set_mode
- * @set_mode_shutdown:	switch mode to shutdown, if !set_mode
+ * @set_state_periodic:	switch state to periodic, if !set_mode
+ * @set_state_oneshot:	switch state to oneshot, if !set_mode
+ * @set_state_shutdown:	switch state to shutdown, if !set_mode
  * @tick_resume:	resume clkevt device, if !set_mode
  * @broadcast:		function to broadcast events
  * @min_delta_ticks:	minimum delta value in ticks stored for reconfiguration
@@ -111,20 +128,21 @@ struct clock_event_device {
 	u32			mult;
 	u32			shift;
 	enum clock_event_mode	mode;
+	enum clock_event_state	state;
 	unsigned int		features;
 	unsigned long		retries;
 
 	/*
-	 * Mode transition callback(s): Only one of the two groups should be
+	 * State transition callback(s): Only one of the two groups should be
 	 * defined:
 	 * - set_mode(), only for modes <= CLOCK_EVT_MODE_RESUME.
-	 * - set_mode_{shutdown|periodic|oneshot|resume}().
+	 * - set_state_{shutdown|periodic|oneshot}(), tick_resume().
 	 */
 	void			(*set_mode)(enum clock_event_mode mode,
 					    struct clock_event_device *);
-	int			(*set_mode_periodic)(struct clock_event_device *);
-	int			(*set_mode_oneshot)(struct clock_event_device *);
-	int			(*set_mode_shutdown)(struct clock_event_device *);
+	int			(*set_state_periodic)(struct clock_event_device *);
+	int			(*set_state_oneshot)(struct clock_event_device *);
+	int			(*set_state_shutdown)(struct clock_event_device *);
 	int			(*tick_resume)(struct clock_event_device *);
 
 	void			(*broadcast)(const struct cpumask *mask);
@@ -177,8 +195,8 @@ extern int clockevents_update_freq(struct clock_event_device *ce, u32 freq);
 
 extern void clockevents_exchange_device(struct clock_event_device *old,
 					struct clock_event_device *new);
-extern void clockevents_set_mode(struct clock_event_device *dev,
-				 enum clock_event_mode mode);
+extern void clockevents_set_state(struct clock_event_device *dev,
+				  enum clock_event_state state);
 extern int clockevents_program_event(struct clock_event_device *dev,
 				     ktime_t expires, bool force);
 
diff --git a/kernel/time/clockevents.c b/kernel/time/clockevents.c
index 1b0ea63de69c..6e53e9a0c2e8 100644
--- a/kernel/time/clockevents.c
+++ b/kernel/time/clockevents.c
@@ -94,44 +94,49 @@ u64 clockevent_delta2ns(unsigned long latch, struct clock_event_device *evt)
 }
 EXPORT_SYMBOL_GPL(clockevent_delta2ns);
 
-static int __clockevents_set_mode(struct clock_event_device *dev,
-				  enum clock_event_mode mode)
+static int __clockevents_set_state(struct clock_event_device *dev,
+				   enum clock_event_state state)
 {
 	/* Transition with legacy set_mode() callback */
 	if (dev->set_mode) {
 		/* Legacy callback doesn't support new modes */
-		if (mode > CLOCK_EVT_MODE_ONESHOT)
+		if (state > CLOCK_EVT_STATE_ONESHOT)
 			return -ENOSYS;
-		dev->set_mode(mode, dev);
+		/*
+		 * 'clock_event_state' and 'clock_event_mode' have 1-to-1
+		 * mapping until *_ONESHOT, and so a simple cast will work.
+		 */
+		dev->set_mode((enum clock_event_mode)state, dev);
+		dev->mode = (enum clock_event_mode)state;
 		return 0;
 	}
 
 	if (dev->features & CLOCK_EVT_FEAT_DUMMY)
 		return 0;
 
-	/* Transition with new mode-specific callbacks */
-	switch (mode) {
-	case CLOCK_EVT_MODE_UNUSED:
+	/* Transition with new state-specific callbacks */
+	switch (state) {
+	case CLOCK_EVT_STATE_DETACHED:
 		/*
 		 * This is an internal state, which is guaranteed to go from
-		 * SHUTDOWN to UNUSED. No driver interaction required.
+		 * SHUTDOWN to DETACHED. No driver interaction required.
 		 */
 		return 0;
 
-	case CLOCK_EVT_MODE_SHUTDOWN:
-		return dev->set_mode_shutdown(dev);
+	case CLOCK_EVT_STATE_SHUTDOWN:
+		return dev->set_state_shutdown(dev);
 
-	case CLOCK_EVT_MODE_PERIODIC:
+	case CLOCK_EVT_STATE_PERIODIC:
 		/* Core internal bug */
 		if (!(dev->features & CLOCK_EVT_FEAT_PERIODIC))
 			return -ENOSYS;
-		return dev->set_mode_periodic(dev);
+		return dev->set_state_periodic(dev);
 
-	case CLOCK_EVT_MODE_ONESHOT:
+	case CLOCK_EVT_STATE_ONESHOT:
 		/* Core internal bug */
 		if (!(dev->features & CLOCK_EVT_FEAT_ONESHOT))
 			return -ENOSYS;
-		return dev->set_mode_oneshot(dev);
+		return dev->set_state_oneshot(dev);
 
 	default:
 		return -ENOSYS;
@@ -139,26 +144,26 @@ static int __clockevents_set_mode(struct clock_event_device *dev,
 }
 
 /**
- * clockevents_set_mode - set the operating mode of a clock event device
+ * clockevents_set_state - set the operating state of a clock event device
  * @dev:	device to modify
- * @mode:	new mode
+ * @state:	new state
  *
  * Must be called with interrupts disabled !
  */
-void clockevents_set_mode(struct clock_event_device *dev,
-				 enum clock_event_mode mode)
+void clockevents_set_state(struct clock_event_device *dev,
+			   enum clock_event_state state)
 {
-	if (dev->mode != mode) {
-		if (__clockevents_set_mode(dev, mode))
+	if (dev->state != state) {
+		if (__clockevents_set_state(dev, state))
 			return;
 
-		dev->mode = mode;
+		dev->state = state;
 
 		/*
 		 * A nsec2cyc multiplicator of 0 is invalid and we'd crash
 		 * on it, so fix it up and emit a warning:
 		 */
-		if (mode == CLOCK_EVT_MODE_ONESHOT) {
+		if (state == CLOCK_EVT_STATE_ONESHOT) {
 			if (unlikely(!dev->mult)) {
 				dev->mult = 1;
 				WARN_ON(1);
@@ -173,7 +178,7 @@ void clockevents_set_mode(struct clock_event_device *dev,
  */
 void clockevents_shutdown(struct clock_event_device *dev)
 {
-	clockevents_set_mode(dev, CLOCK_EVT_MODE_SHUTDOWN);
+	clockevents_set_state(dev, CLOCK_EVT_STATE_SHUTDOWN);
 	dev->next_event.tv64 = KTIME_MAX;
 }
 
@@ -185,13 +190,12 @@ int clockevents_tick_resume(struct clock_event_device *dev)
 {
 	int ret = 0;
 
-	if (dev->set_mode)
+	if (dev->set_mode) {
 		dev->set_mode(CLOCK_EVT_MODE_RESUME, dev);
-	else if (dev->tick_resume)
-		ret = dev->tick_resume(dev);
-
-	if (likely(!ret))
 		dev->mode = CLOCK_EVT_MODE_RESUME;
+	} else if (dev->tick_resume) {
+		ret = dev->tick_resume(dev);
+	}
 
 	return ret;
 }
@@ -248,7 +252,7 @@ static int clockevents_program_min_delta(struct clock_event_device *dev)
 		delta = dev->min_delta_ns;
 		dev->next_event = ktime_add_ns(ktime_get(), delta);
 
-		if (dev->mode == CLOCK_EVT_MODE_SHUTDOWN)
+		if (dev->state == CLOCK_EVT_STATE_SHUTDOWN)
 			return 0;
 
 		dev->retries++;
@@ -285,7 +289,7 @@ static int clockevents_program_min_delta(struct clock_event_device *dev)
 	delta = dev->min_delta_ns;
 	dev->next_event = ktime_add_ns(ktime_get(), delta);
 
-	if (dev->mode == CLOCK_EVT_MODE_SHUTDOWN)
+	if (dev->state == CLOCK_EVT_STATE_SHUTDOWN)
 		return 0;
 
 	dev->retries++;
@@ -317,7 +321,7 @@ int clockevents_program_event(struct clock_event_device *dev, ktime_t expires,
 
 	dev->next_event = expires;
 
-	if (dev->mode == CLOCK_EVT_MODE_SHUTDOWN)
+	if (dev->state == CLOCK_EVT_STATE_SHUTDOWN)
 		return 0;
 
 	/* Shortcut for clockevent devices that can deal with ktime. */
@@ -362,7 +366,7 @@ static int clockevents_replace(struct clock_event_device *ced)
 	struct clock_event_device *dev, *newdev = NULL;
 
 	list_for_each_entry(dev, &clockevent_devices, list) {
-		if (dev == ced || dev->mode != CLOCK_EVT_MODE_UNUSED)
+		if (dev == ced || dev->state != CLOCK_EVT_STATE_DETACHED)
 			continue;
 
 		if (!tick_check_replacement(newdev, dev))
@@ -388,7 +392,7 @@ static int clockevents_replace(struct clock_event_device *ced)
 static int __clockevents_try_unbind(struct clock_event_device *ced, int cpu)
 {
 	/* Fast track. Device is unused */
-	if (ced->mode == CLOCK_EVT_MODE_UNUSED) {
+	if (ced->state == CLOCK_EVT_STATE_DETACHED) {
 		list_del_init(&ced->list);
 		return 0;
 	}
@@ -438,30 +442,30 @@ int clockevents_unbind_device(struct clock_event_device *ced, int cpu)
 }
 EXPORT_SYMBOL_GPL(clockevents_unbind);
 
-/* Sanity check of mode transition callbacks */
+/* Sanity check of state transition callbacks */
 static int clockevents_sanity_check(struct clock_event_device *dev)
 {
 	/* Legacy set_mode() callback */
 	if (dev->set_mode) {
 		/* We shouldn't be supporting new modes now */
-		WARN_ON(dev->set_mode_periodic || dev->set_mode_oneshot ||
-			dev->set_mode_shutdown || dev->tick_resume);
+		WARN_ON(dev->set_state_periodic || dev->set_state_oneshot ||
+			dev->set_state_shutdown || dev->tick_resume);
 		return 0;
 	}
 
 	if (dev->features & CLOCK_EVT_FEAT_DUMMY)
 		return 0;
 
-	/* New mode-specific callbacks */
-	if (!dev->set_mode_shutdown)
+	/* New state-specific callbacks */
+	if (!dev->set_state_shutdown)
 		return -EINVAL;
 
 	if ((dev->features & CLOCK_EVT_FEAT_PERIODIC) &&
-	    !dev->set_mode_periodic)
+	    !dev->set_state_periodic)
 		return -EINVAL;
 
 	if ((dev->features & CLOCK_EVT_FEAT_ONESHOT) &&
-	    !dev->set_mode_oneshot)
+	    !dev->set_state_oneshot)
 		return -EINVAL;
 
 	return 0;
@@ -478,6 +482,9 @@ void clockevents_register_device(struct clock_event_device *dev)
 	BUG_ON(dev->mode != CLOCK_EVT_MODE_UNUSED);
 	BUG_ON(clockevents_sanity_check(dev));
 
+	/* Initialize state to DETACHED */
+	dev->state = CLOCK_EVT_STATE_DETACHED;
+
 	if (!dev->cpumask) {
 		WARN_ON(num_possible_cpus() > 1);
 		dev->cpumask = cpumask_of(smp_processor_id());
@@ -541,11 +548,11 @@ int __clockevents_update_freq(struct clock_event_device *dev, u32 freq)
 {
 	clockevents_config(dev, freq);
 
-	if (dev->mode == CLOCK_EVT_MODE_ONESHOT)
+	if (dev->state == CLOCK_EVT_STATE_ONESHOT)
 		return clockevents_program_event(dev, dev->next_event, false);
 
-	if (dev->mode == CLOCK_EVT_MODE_PERIODIC)
-		return __clockevents_set_mode(dev, CLOCK_EVT_MODE_PERIODIC);
+	if (dev->state == CLOCK_EVT_STATE_PERIODIC)
+		return __clockevents_set_state(dev, CLOCK_EVT_STATE_PERIODIC);
 
 	return 0;
 }
@@ -601,13 +608,13 @@ void clockevents_exchange_device(struct clock_event_device *old,
 	 */
 	if (old) {
 		module_put(old->owner);
-		clockevents_set_mode(old, CLOCK_EVT_MODE_UNUSED);
+		clockevents_set_state(old, CLOCK_EVT_STATE_DETACHED);
 		list_del(&old->list);
 		list_add(&old->list, &clockevents_released);
 	}
 
 	if (new) {
-		BUG_ON(new->mode != CLOCK_EVT_MODE_UNUSED);
+		BUG_ON(new->state != CLOCK_EVT_STATE_DETACHED);
 		clockevents_shutdown(new);
 	}
 	local_irq_restore(flags);
@@ -693,7 +700,7 @@ int clockevents_notify(unsigned long reason, void *arg)
 			if (cpumask_test_cpu(cpu, dev->cpumask) &&
 			    cpumask_weight(dev->cpumask) == 1 &&
 			    !tick_is_broadcast_device(dev)) {
-				BUG_ON(dev->mode != CLOCK_EVT_MODE_UNUSED);
+				BUG_ON(dev->state != CLOCK_EVT_STATE_DETACHED);
 				list_del(&dev->list);
 			}
 		}
diff --git a/kernel/time/tick-broadcast.c b/kernel/time/tick-broadcast.c
index 542d5bb5c13d..f0f8ee9dbc28 100644
--- a/kernel/time/tick-broadcast.c
+++ b/kernel/time/tick-broadcast.c
@@ -303,7 +303,7 @@ static void tick_handle_periodic_broadcast(struct clock_event_device *dev)
 	/*
 	 * The device is in periodic mode. No reprogramming necessary:
 	 */
-	if (dev->mode == CLOCK_EVT_MODE_PERIODIC)
+	if (dev->state == CLOCK_EVT_STATE_PERIODIC)
 		goto unlock;
 
 	/*
@@ -532,8 +532,8 @@ static int tick_broadcast_set_event(struct clock_event_device *bc, int cpu,
 {
 	int ret;
 
-	if (bc->mode != CLOCK_EVT_MODE_ONESHOT)
-		clockevents_set_mode(bc, CLOCK_EVT_MODE_ONESHOT);
+	if (bc->state != CLOCK_EVT_STATE_ONESHOT)
+		clockevents_set_state(bc, CLOCK_EVT_STATE_ONESHOT);
 
 	ret = clockevents_program_event(bc, expires, force);
 	if (!ret)
@@ -543,7 +543,7 @@ static int tick_broadcast_set_event(struct clock_event_device *bc, int cpu,
 
 int tick_resume_broadcast_oneshot(struct clock_event_device *bc)
 {
-	clockevents_set_mode(bc, CLOCK_EVT_MODE_ONESHOT);
+	clockevents_set_state(bc, CLOCK_EVT_STATE_ONESHOT);
 	return 0;
 }
 
@@ -562,8 +562,8 @@ void tick_check_oneshot_broadcast_this_cpu(void)
 		 * switched over, leave the device alone.
 		 */
 		if (td->mode == TICKDEV_MODE_ONESHOT) {
-			clockevents_set_mode(td->evtdev,
-					     CLOCK_EVT_MODE_ONESHOT);
+			clockevents_set_state(td->evtdev,
+					      CLOCK_EVT_STATE_ONESHOT);
 		}
 	}
 }
@@ -666,7 +666,7 @@ static void broadcast_shutdown_local(struct clock_event_device *bc,
 		if (dev->next_event.tv64 < bc->next_event.tv64)
 			return;
 	}
-	clockevents_set_mode(dev, CLOCK_EVT_MODE_SHUTDOWN);
+	clockevents_set_state(dev, CLOCK_EVT_STATE_SHUTDOWN);
 }
 
 static void broadcast_move_bc(int deadcpu)
@@ -741,7 +741,7 @@ int tick_broadcast_oneshot_control(unsigned long reason)
 			cpumask_clear_cpu(cpu, tick_broadcast_oneshot_mask);
 	} else {
 		if (cpumask_test_and_clear_cpu(cpu, tick_broadcast_oneshot_mask)) {
-			clockevents_set_mode(dev, CLOCK_EVT_MODE_ONESHOT);
+			clockevents_set_state(dev, CLOCK_EVT_STATE_ONESHOT);
 			/*
 			 * The cpu which was handling the broadcast
 			 * timer marked this cpu in the broadcast
@@ -842,7 +842,7 @@ void tick_broadcast_setup_oneshot(struct clock_event_device *bc)
 
 	/* Set it up only once ! */
 	if (bc->event_handler != tick_handle_oneshot_broadcast) {
-		int was_periodic = bc->mode == CLOCK_EVT_MODE_PERIODIC;
+		int was_periodic = bc->state == CLOCK_EVT_STATE_PERIODIC;
 
 		bc->event_handler = tick_handle_oneshot_broadcast;
 
@@ -858,7 +858,7 @@ void tick_broadcast_setup_oneshot(struct clock_event_device *bc)
 			   tick_broadcast_oneshot_mask, tmpmask);
 
 		if (was_periodic && !cpumask_empty(tmpmask)) {
-			clockevents_set_mode(bc, CLOCK_EVT_MODE_ONESHOT);
+			clockevents_set_state(bc, CLOCK_EVT_STATE_ONESHOT);
 			tick_broadcast_init_next_event(tmpmask,
 						       tick_next_period);
 			tick_broadcast_set_event(bc, cpu, tick_next_period, 1);
diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index 5c50664c21d7..a5b877130ae9 100644
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -102,7 +102,7 @@ void tick_handle_periodic(struct clock_event_device *dev)
 
 	tick_periodic(cpu);
 
-	if (dev->mode != CLOCK_EVT_MODE_ONESHOT)
+	if (dev->state != CLOCK_EVT_STATE_ONESHOT)
 		return;
 	for (;;) {
 		/*
@@ -140,7 +140,7 @@ void tick_setup_periodic(struct clock_event_device *dev, int broadcast)
 
 	if ((dev->features & CLOCK_EVT_FEAT_PERIODIC) &&
 	    !tick_broadcast_oneshot_active()) {
-		clockevents_set_mode(dev, CLOCK_EVT_MODE_PERIODIC);
+		clockevents_set_state(dev, CLOCK_EVT_STATE_PERIODIC);
 	} else {
 		unsigned long seq;
 		ktime_t next;
@@ -150,7 +150,7 @@ void tick_setup_periodic(struct clock_event_device *dev, int broadcast)
 			next = tick_next_period;
 		} while (read_seqretry(&jiffies_lock, seq));
 
-		clockevents_set_mode(dev, CLOCK_EVT_MODE_ONESHOT);
+		clockevents_set_state(dev, CLOCK_EVT_STATE_ONESHOT);
 
 		for (;;) {
 			if (!clockevents_program_event(dev, next, false))
@@ -365,6 +365,7 @@ void tick_shutdown(unsigned int *cpup)
 		 * Prevent that the clock events layer tries to call
 		 * the set mode function!
 		 */
+		dev->state = CLOCK_EVT_STATE_DETACHED;
 		dev->mode = CLOCK_EVT_MODE_UNUSED;
 		clockevents_exchange_device(dev, NULL);
 		dev->event_handler = clockevents_handle_noop;
diff --git a/kernel/time/tick-oneshot.c b/kernel/time/tick-oneshot.c
index 7ce740e78e1b..67a64b1670bf 100644
--- a/kernel/time/tick-oneshot.c
+++ b/kernel/time/tick-oneshot.c
@@ -38,7 +38,7 @@ void tick_resume_oneshot(void)
 {
 	struct clock_event_device *dev = __this_cpu_read(tick_cpu_device.evtdev);
 
-	clockevents_set_mode(dev, CLOCK_EVT_MODE_ONESHOT);
+	clockevents_set_state(dev, CLOCK_EVT_STATE_ONESHOT);
 	clockevents_program_event(dev, ktime_get(), true);
 }
 
@@ -50,7 +50,7 @@ void tick_setup_oneshot(struct clock_event_device *newdev,
 			ktime_t next_event)
 {
 	newdev->event_handler = handler;
-	clockevents_set_mode(newdev, CLOCK_EVT_MODE_ONESHOT);
+	clockevents_set_state(newdev, CLOCK_EVT_STATE_ONESHOT);
 	clockevents_program_event(newdev, next_event, true);
 }
 
@@ -81,7 +81,7 @@ int tick_switch_to_oneshot(void (*handler)(struct clock_event_device *))
 
 	td->mode = TICKDEV_MODE_ONESHOT;
 	dev->event_handler = handler;
-	clockevents_set_mode(dev, CLOCK_EVT_MODE_ONESHOT);
+	clockevents_set_state(dev, CLOCK_EVT_STATE_ONESHOT);
 	tick_broadcast_switch_to_oneshot();
 	return 0;
 }
diff --git a/kernel/time/timer_list.c b/kernel/time/timer_list.c
index 2b3e9393034d..05aa5590106a 100644
--- a/kernel/time/timer_list.c
+++ b/kernel/time/timer_list.c
@@ -233,21 +233,21 @@ print_tickdevice(struct seq_file *m, struct tick_device *td, int cpu)
 		print_name_offset(m, dev->set_mode);
 		SEQ_printf(m, "\n");
 	} else {
-		if (dev->set_mode_shutdown) {
+		if (dev->set_state_shutdown) {
 			SEQ_printf(m, " shutdown: ");
-			print_name_offset(m, dev->set_mode_shutdown);
+			print_name_offset(m, dev->set_state_shutdown);
 			SEQ_printf(m, "\n");
 		}
 
-		if (dev->set_mode_periodic) {
+		if (dev->set_state_periodic) {
 			SEQ_printf(m, " periodic: ");
-			print_name_offset(m, dev->set_mode_periodic);
+			print_name_offset(m, dev->set_state_periodic);
 			SEQ_printf(m, "\n");
 		}
 
-		if (dev->set_mode_oneshot) {
+		if (dev->set_state_oneshot) {
 			SEQ_printf(m, " oneshot:  ");
-			print_name_offset(m, dev->set_mode_oneshot);
+			print_name_offset(m, dev->set_state_oneshot);
 			SEQ_printf(m, "\n");
 		}
 
-- 
2.3.0.rc0.44.ga94655d
