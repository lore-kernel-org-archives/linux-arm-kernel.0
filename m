From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 28 Nov 2013 20:07:10 +0100 (CET)
Subject: [PATCH v2 4/9] clocksource/cadence_ttc: Use enable/disable_irq
In-Reply-To: <b2ed3cbc-c9df-4235-8137-93514c05bffa@DB8EHSMHS031.ehs.local>
References: <1385514296-26702-1-git-send-email-soren.brinkmann@xilinx.com>
 <1385514296-26702-5-git-send-email-soren.brinkmann@xilinx.com>
 <52972F3A.9090103@linaro.org>
 <alpine.DEB.2.02.1311281507280.30673@ionos.tec.linutronix.de>
 <b2ed3cbc-c9df-4235-8137-93514c05bffa@DB8EHSMHS031.ehs.local>
Message-ID: <alpine.DEB.2.02.1311281939000.30673@ionos.tec.linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 28 Nov 2013, S?ren Brinkmann wrote:
> On Thu, Nov 28, 2013 at 03:18:50PM +0100, Thomas Gleixner wrote:
> > Now the problem with this device is that it is not a per cpu
> > device. It's a global device, so this update can conflict with a
> > parallel access on the other CPU. Now the disable_irq() only prevents
> > that the other CPU can handle a device interrupt from that timer. But
> > it does not prevent any parallel access from e.g. the idle code path
> > which will try to reprogram it.
>
> Does that mean interrupts need to be disabled globally? Also, does the

Globally disabling interrupts is not going to work, except you want to
use stomp_machine(). But that would be overkill.

> cpuidle path depend on interrupts or can it interfere no matter what?

It can interfere no matter what. The broadcast is modified for the cpu
which loses its per cpu timer due to the idle state via

      clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, ...);
 
> > Soren, is that timer used as the broadcast device ?
>
> Yes, this is the only broadcast capable timer on Zynq, AFAIK. Other than
> the TTC we only have the arm_global_timer and smp_twd timers, which both
> are per_cpu devices and thus not broadcast capable.

There is a solution to this. We can identify the broadcast device in
the core and serialize all callers including interrupts on a different
cpu against the update. So no need for the disable/enable_irq() dance.

See patch below.

Thanks,

	tglx
---

Index: linux-2.6/kernel/time/clockevents.c
===================================================================
--- linux-2.6.orig/kernel/time/clockevents.c
+++ linux-2.6/kernel/time/clockevents.c
@@ -439,6 +439,16 @@ void clockevents_config_and_register(str
 }
 EXPORT_SYMBOL_GPL(clockevents_config_and_register);
 
+int __clockevents_update_freq(struct clock_event_device *dev, u32 freq)
+{
+	clockevents_config(dev, freq);
+
+	if (dev->mode != CLOCK_EVT_MODE_ONESHOT)
+		return 0;
+
+	return clockevents_program_event(dev, dev->next_event, false);
+}
+
 /**
  * clockevents_update_freq - Update frequency and reprogram a clock event device.
  * @dev:	device to modify
@@ -446,17 +456,22 @@ EXPORT_SYMBOL_GPL(clockevents_config_and
  *
  * Reconfigure and reprogram a clock event device in oneshot
  * mode. Must be called on the cpu for which the device delivers per
- * cpu timer events with interrupts disabled!  Returns 0 on success,
- * -ETIME when the event is in the past.
+ * cpu timer events. If called for the broadcast device the core takes
+ * care of serialization.
+ *
+ * Returns 0 on success, -ETIME when the event is in the past.
  */
 int clockevents_update_freq(struct clock_event_device *dev, u32 freq)
 {
-	clockevents_config(dev, freq);
+	unsigned long flags;
+	int ret;
 
-	if (dev->mode != CLOCK_EVT_MODE_ONESHOT)
-		return 0;
-
-	return clockevents_program_event(dev, dev->next_event, false);
+	local_irq_save(flags);
+	ret = tick_broadcast_update_freq(dev, freq);
+	if (ret == -ENODEV)
+		ret = __clockevents_update_freq(dev, freq);
+	local_irq_restore(flags);
+	return ret;
 }
 
 /*
Index: linux-2.6/kernel/time/tick-broadcast.c
===================================================================
--- linux-2.6.orig/kernel/time/tick-broadcast.c
+++ linux-2.6/kernel/time/tick-broadcast.c
@@ -120,6 +120,19 @@ int tick_is_broadcast_device(struct cloc
 	return (dev && tick_broadcast_device.evtdev == dev);
 }
 
+int tick_broadcast_update_freq(struct clock_event_device *dev, u32 freq)
+{
+	int ret = -ENODEV;
+
+	if (tick_is_broadcast_device(dev)) {
+		raw_spin_lock(&tick_broadcast_lock);
+		ret = __clockevents_update_freq(dev, freq);
+		raw_spin_unlock(&tick_broadcast_lock);
+	}
+	return ret;
+}
+
+
 static void err_broadcast(const struct cpumask *mask)
 {
 	pr_crit_once("Failed to broadcast timer tick. Some CPUs may be unresponsive.\n");
@@ -272,12 +285,8 @@ static void tick_do_broadcast(struct cpu
  */
 static void tick_do_periodic_broadcast(void)
 {
-	raw_spin_lock(&tick_broadcast_lock);
-
 	cpumask_and(tmpmask, cpu_online_mask, tick_broadcast_mask);
 	tick_do_broadcast(tmpmask);
-
-	raw_spin_unlock(&tick_broadcast_lock);
 }
 
 /*
@@ -287,13 +296,15 @@ static void tick_handle_periodic_broadca
 {
 	ktime_t next;
 
+	raw_spin_lock(&tick_broadcast_lock);
+
 	tick_do_periodic_broadcast();
 
 	/*
 	 * The device is in periodic mode. No reprogramming necessary:
 	 */
 	if (dev->mode == CLOCK_EVT_MODE_PERIODIC)
-		return;
+		goto unlock;
 
 	/*
 	 * Setup the next period for devices, which do not have
@@ -306,9 +317,11 @@ static void tick_handle_periodic_broadca
 		next = ktime_add(next, tick_period);
 
 		if (!clockevents_program_event(dev, next, false))
-			return;
+			goto unlock;
 		tick_do_periodic_broadcast();
 	}
+unlock:
+	raw_spin_unlock(&tick_broadcast_lock);
 }
 
 /*
Index: linux-2.6/kernel/time/tick-internal.h
===================================================================
--- linux-2.6.orig/kernel/time/tick-internal.h
+++ linux-2.6/kernel/time/tick-internal.h
@@ -111,6 +111,7 @@ extern int tick_resume_broadcast(void);
 extern void tick_broadcast_init(void);
 extern void
 tick_set_periodic_handler(struct clock_event_device *dev, int broadcast);
+int tick_broadcast_update_freq(struct clock_event_device *dev, u32 freq);
 
 #else /* !BROADCAST */
 
@@ -133,6 +134,8 @@ static inline void tick_shutdown_broadca
 static inline void tick_suspend_broadcast(void) { }
 static inline int tick_resume_broadcast(void) { return 0; }
 static inline void tick_broadcast_init(void) { }
+static inline int tick_broadcast_update_freq(struct clock_event_device *dev,
+					     u32 freq) { return -ENODEV; }
 
 /*
  * Set the periodic handler in non broadcast mode
@@ -154,4 +157,5 @@ static inline int tick_device_is_functio
 
 #endif
 
+int __clockevents_update_freq(struct clock_event_device *dev, u32 freq);
 extern void do_timer(unsigned long ticks);
