From: anna-maria@linutronix.de (Anna-Maria Gleixner)
Date: Wed, 13 Jul 2016 17:17:04 -0000
Subject: [patch V2 62/67] [PATCH] clocksource: arm_global_timer: Convert to
 hotplug state machine.
References: <20160713153219.128052238@linutronix.de>
Message-ID: <20160713153338.062741642@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Richard Cochran <rcochran@linutronix.de>

Install the callbacks via the state machine and let the core invoke
the callbacks on the already online CPUs.

Signed-off-by: Richard Cochran <rcochran@linutronix.de>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Srinivas Kandagatla <srinivas.kandagatla@gmail.com>
Cc: Maxime Coquelin <maxime.coquelin@st.com>
Cc: Patrice Chotard <patrice.chotard@st.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-arm-kernel at lists.infradead.org
Cc: kernel at stlinux.com
Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
---
 drivers/clocksource/arm_global_timer.c |   39 ++++++++-------------------------
 include/linux/cpuhotplug.h             |    1 
 2 files changed, 11 insertions(+), 29 deletions(-)

--- a/drivers/clocksource/arm_global_timer.c
+++ b/drivers/clocksource/arm_global_timer.c
@@ -165,9 +165,9 @@ static irqreturn_t gt_clockevent_interru
 	return IRQ_HANDLED;
 }
 
-static int gt_clockevents_init(struct clock_event_device *clk)
+static int gt_starting_cpu(unsigned int cpu)
 {
-	int cpu = smp_processor_id();
+	struct clock_event_device *clk = this_cpu_ptr(gt_evt);
 
 	clk->name = "arm_global_timer";
 	clk->features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT |
@@ -186,10 +186,13 @@ static int gt_clockevents_init(struct cl
 	return 0;
 }
 
-static void gt_clockevents_stop(struct clock_event_device *clk)
+static int gt_dying_cpu(unsigned int cpu)
 {
+	struct clock_event_device *clk = this_cpu_ptr(gt_evt);
+
 	gt_clockevent_shutdown(clk);
 	disable_percpu_irq(clk->irq);
+	return 0;
 }
 
 static cycle_t gt_clocksource_read(struct clocksource *cs)
@@ -252,24 +255,6 @@ static int __init gt_clocksource_init(vo
 	return clocksource_register_hz(&gt_clocksource, gt_clk_rate);
 }
 
-static int gt_cpu_notify(struct notifier_block *self, unsigned long action,
-			 void *hcpu)
-{
-	switch (action & ~CPU_TASKS_FROZEN) {
-	case CPU_STARTING:
-		gt_clockevents_init(this_cpu_ptr(gt_evt));
-		break;
-	case CPU_DYING:
-		gt_clockevents_stop(this_cpu_ptr(gt_evt));
-		break;
-	}
-
-	return NOTIFY_OK;
-}
-static struct notifier_block gt_cpu_nb = {
-	.notifier_call = gt_cpu_notify,
-};
-
 static int __init global_timer_of_register(struct device_node *np)
 {
 	struct clk *gt_clk;
@@ -325,18 +310,14 @@ static int __init global_timer_of_regist
 		goto out_free;
 	}
 
-	err = register_cpu_notifier(&gt_cpu_nb);
-	if (err) {
-		pr_warn("global-timer: unable to register cpu notifier.\n");
-		goto out_irq;
-	}
-
-	/* Immediately configure the timer on the boot CPU */
+	/* Register and immediately configure the timer on the boot CPU */
 	err = gt_clocksource_init();
 	if (err)
 		goto out_irq;
 	
-	err = gt_clockevents_init(this_cpu_ptr(gt_evt));
+	err = cpuhp_setup_state(CPUHP_AP_ARM_GLOBAL_TIMER_STARTING,
+				"AP_ARM_GLOBAL_TIMER_STARTING",
+				gt_starting_cpu, gt_dying_cpu);
 	if (err)
 		goto out_irq;
 
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -48,6 +48,7 @@ enum cpuhp_state {
 	CPUHP_AP_PERF_ARM_STARTING,
 	CPUHP_AP_ARM_L2X0_STARTING,
 	CPUHP_AP_ARM_ARCH_TIMER_STARTING,
+	CPUHP_AP_ARM_GLOBAL_TIMER_STARTING,
 	CPUHP_AP_DUMMY_TIMER_STARTING,
 	CPUHP_AP_ARM_TWD_STARTING,
 	CPUHP_AP_METAG_TIMER_STARTING,
