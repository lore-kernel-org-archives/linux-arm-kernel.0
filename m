From: srivatsa.bhat@linux.vnet.ibm.com (Srivatsa S. Bhat)
Date: Tue, 22 Jan 2013 13:07:19 +0530
Subject: [PATCH v5 16/45] time/clocksource: Use get/put_online_cpus_atomic()
 to prevent CPU offline
In-Reply-To: <20130122073210.13822.50434.stgit@srivatsabhat.in.ibm.com>
References: <20130122073210.13822.50434.stgit@srivatsabhat.in.ibm.com>
Message-ID: <20130122073713.13822.11706.stgit@srivatsabhat.in.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Once stop_machine() is gone from the CPU offline path, we won't be able to
depend on preempt_disable() or local_irq_disable() to prevent CPUs from going
offline from under us.

Use the get/put_online_cpus_atomic() APIs to prevent CPUs from going offline,
while invoking from atomic context.

Cc: John Stultz <john.stultz@linaro.org>
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 kernel/time/clocksource.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index c958338..1c8d735 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -30,6 +30,7 @@
 #include <linux/sched.h> /* for spin_unlock_irq() using preempt_count() m68k */
 #include <linux/tick.h>
 #include <linux/kthread.h>
+#include <linux/cpu.h>
 
 void timecounter_init(struct timecounter *tc,
 		      const struct cyclecounter *cc,
@@ -320,11 +321,13 @@ static void clocksource_watchdog(unsigned long data)
 	 * Cycle through CPUs to check if the CPUs stay synchronized
 	 * to each other.
 	 */
+	get_online_cpus_atomic();
 	next_cpu = cpumask_next(raw_smp_processor_id(), cpu_online_mask);
 	if (next_cpu >= nr_cpu_ids)
 		next_cpu = cpumask_first(cpu_online_mask);
 	watchdog_timer.expires += WATCHDOG_INTERVAL;
 	add_timer_on(&watchdog_timer, next_cpu);
+	put_online_cpus_atomic();
 out:
 	spin_unlock(&watchdog_lock);
 }
@@ -336,7 +339,9 @@ static inline void clocksource_start_watchdog(void)
 	init_timer(&watchdog_timer);
 	watchdog_timer.function = clocksource_watchdog;
 	watchdog_timer.expires = jiffies + WATCHDOG_INTERVAL;
+	get_online_cpus_atomic();
 	add_timer_on(&watchdog_timer, cpumask_first(cpu_online_mask));
+	put_online_cpus_atomic();
 	watchdog_running = 1;
 }
 
