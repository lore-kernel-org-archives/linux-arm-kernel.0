From: anna-maria@linutronix.de (Anna-Maria Gleixner)
Date: Mon, 11 Jul 2016 12:28:49 -0000
Subject: [patch 38/66] clocksource/arm_global_timer: Convert to hotplug state
 machine.
References: <20160711122450.923603742@linutronix.de>
Message-ID: <20160711122533.836621791@linutronix.de>
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
 drivers/clocksource/arm_global_timer.c |   41 ++++++++-------------------------
 include/linux/cpuhotplug.h             |    1 
 2 files changed, 11 insertions(+), 31 deletions(-)

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
@@ -252,24 +255,6 @@ static void __init gt_clocksource_init(v
 	clocksource_register_hz(&gt_clocksource, gt_clk_rate);
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
 static void __init global_timer_of_register(struct device_node *np)
 {
 	struct clk *gt_clk;
@@ -325,21 +310,15 @@ static void __init global_timer_of_regis
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
 	gt_clocksource_init();
-	gt_clockevents_init(this_cpu_ptr(gt_evt));
+	cpuhp_setup_state(CPUHP_AP_ARM_GLOBAL_TIMER_STARTING,
+			  "AP_ARM_GLOBAL_TIMER_STARTING", gt_starting_cpu,
+			  gt_dying_cpu);
 	gt_delay_timer_init();
 
 	return;
 
-out_irq:
-	free_percpu_irq(gt_ppi, gt_evt);
 out_free:
 	free_percpu(gt_evt);
 out_clk:
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -38,6 +38,7 @@ enum cpuhp_state {
 	CPUHP_AP_ARM_VFP_STARTING,
 	CPUHP_AP_PERF_ARM_STARTING,
 	CPUHP_AP_ARM_ARCH_TIMER_STARTING,
+	CPUHP_AP_ARM_GLOBAL_TIMER_STARTING,
 	CPUHP_AP_KVM_STARTING,
 	CPUHP_AP_NOTIFY_STARTING,
 	CPUHP_AP_ONLINE,
