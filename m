From: leoy@marvell.com (Leo Yan)
Date: Thu, 4 Sep 2014 09:25:33 +0800
Subject: [RFC PATCH v2] clockevents: re-calculate event when cpu enter idle
Message-ID: <1409793933-29938-1-git-send-email-leoy@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Below flow will have the redundant interrupts for broadcast timer:

1. Process A starts a hrtimer with 100ms timeout, then Process A will
   wait on the waitqueue to sleep;
2. The CPU which Process A runs on will enter idle and call notify
   CLOCK_EVT_NOTIFY_BROADCAST_ENTER, so the CPU will shutdown its local
   and set broadcast timer's next event with delta for 100ms timeout;
3. After 70ms later, the CPU is waken up by other peripheral's interrupt
   and Process A will be waken up as well; Process A will cancel the hrtimer
   at this point, kernel will remove the timer event from the event queue
   but it will not really disable broadcast timer;
4. So after 30ms later, the broadcast timer interrupt will be triggered
   even though the timer has been cancelled by s/w in step 3.

To fix this issue, in theory cpu can check this situation when the cpu
enter and exit idle; So it can iterate the related idle cpus to calculate
the correct broadcast event value.

But with upper method, it has the side effect. Due the cpu enter and exit
idle state very frequently in short time, so can optimize to only calculate
the correct state only when the cpu join into broadcast timer and set the
next event after calculate a different event compare to previous time.

Signed-off-by: Leo Yan <leoy@marvell.com>
---
 kernel/time/tick-broadcast.c | 56 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 48 insertions(+), 8 deletions(-)

diff --git a/kernel/time/tick-broadcast.c b/kernel/time/tick-broadcast.c
index 64c5990..52f8879 100644
--- a/kernel/time/tick-broadcast.c
+++ b/kernel/time/tick-broadcast.c
@@ -324,6 +324,31 @@ unlock:
 	raw_spin_unlock(&tick_broadcast_lock);
 }
 
+static void tick_broadcast_oneshot_get_earlier_event(void)
+{
+	struct clock_event_device *bc;
+	struct tick_device *td;
+	ktime_t next_event;
+	int cpu, next_cpu = 0;
+
+	next_event.tv64 = KTIME_MAX;
+
+	/* iterate all expired events */
+	for_each_cpu(cpu, tick_broadcast_oneshot_mask) {
+
+		td = &per_cpu(tick_cpu_device, cpu);
+		if (td->evtdev->next_event.tv64 < next_event.tv64) {
+			next_event.tv64 = td->evtdev->next_event.tv64;
+			next_cpu = cpu;
+		}
+	}
+
+	bc = tick_broadcast_device.evtdev;
+	if (next_event.tv64 != KTIME_MAX &&
+	    next_event.tv64 != bc->next_event.tv64)
+		tick_broadcast_set_event(bc, next_cpu, next_event, 0);
+}
+
 /*
  * Powerstate information: The system enters/leaves a state, where
  * affected devices might stop
@@ -717,17 +742,32 @@ int tick_broadcast_oneshot_control(unsigned long reason)
 		if (!cpumask_test_and_set_cpu(cpu, tick_broadcast_oneshot_mask)) {
 			WARN_ON_ONCE(cpumask_test_cpu(cpu, tick_broadcast_pending_mask));
 			broadcast_shutdown_local(bc, dev);
+
+			/*
+			 * We only reprogram the broadcast timer if we did not
+			 * mark ourself in the force mask; If the current CPU
+			 * is in the force mask, then we are going to be woken
+			 * by the IPI right away.
+			 */
+			if (cpumask_test_cpu(cpu, tick_broadcast_force_mask))
+				goto out;
+
 			/*
-			 * We only reprogram the broadcast timer if we
-			 * did not mark ourself in the force mask and
-			 * if the cpu local event is earlier than the
-			 * broadcast event. If the current CPU is in
-			 * the force mask, then we are going to be
-			 * woken by the IPI right away.
+			 * Reprogram the broadcast timer if the cpu local event
+			 * is earlier than the broadcast event;
 			 */
-			if (!cpumask_test_cpu(cpu, tick_broadcast_force_mask) &&
-			    dev->next_event.tv64 < bc->next_event.tv64)
+			if (dev->next_event.tv64 < bc->next_event.tv64) {
 				tick_broadcast_set_event(bc, cpu, dev->next_event, 1);
+				goto out;
+			}
+
+			/*
+			 * It's possible the cpu has cancelled the timer which
+			 * has set the broadcast event at last time, so
+			 * re-calculate the broadcast timer according to all
+			 * related cpus' expire events.
+			 */
+			tick_broadcast_oneshot_get_earlier_event();
 		}
 		/*
 		 * If the current CPU owns the hrtimer broadcast
-- 
1.9.1
