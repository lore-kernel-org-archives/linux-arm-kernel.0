From: anna-maria@linutronix.de (Anna-Maria Gleixner)
Date: Mon, 11 Jul 2016 12:28:58 -0000
Subject: [patch 51/66] arm: twd: Convert to hotplug state machine
References: <20160711122450.923603742@linutronix.de>
Message-ID: <20160711122534.924382135@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Richard Cochran <rcochran@linutronix.de>

Install the callbacks via the state machine. The callbacks won't be invoked on
already online CPUs.

Signed-off-by: Richard Cochran <rcochran@linutronix.de>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
---
 arch/arm/kernel/smp_twd.c  |   31 +++++++++++--------------------
 include/linux/cpuhotplug.h |    1 +
 2 files changed, 12 insertions(+), 20 deletions(-)

--- a/arch/arm/kernel/smp_twd.c
+++ b/arch/arm/kernel/smp_twd.c
@@ -310,24 +310,17 @@ static void twd_timer_setup(void)
 	enable_percpu_irq(clk->irq, 0);
 }
 
-static int twd_timer_cpu_notify(struct notifier_block *self,
-				unsigned long action, void *hcpu)
+static int twd_timer_starting_cpu(unsigned int cpu)
 {
-	switch (action & ~CPU_TASKS_FROZEN) {
-	case CPU_STARTING:
-		twd_timer_setup();
-		break;
-	case CPU_DYING:
-		twd_timer_stop();
-		break;
-	}
-
-	return NOTIFY_OK;
+	twd_timer_setup();
+	return 0;
 }
 
-static struct notifier_block twd_timer_cpu_nb = {
-	.notifier_call = twd_timer_cpu_notify,
-};
+static int twd_timer_dying_cpu(unsigned int cpu)
+{
+	twd_timer_stop();
+	return 0;
+}
 
 static int __init twd_local_timer_common_register(struct device_node *np)
 {
@@ -345,9 +338,9 @@ static int __init twd_local_timer_common
 		goto out_free;
 	}
 
-	err = register_cpu_notifier(&twd_timer_cpu_nb);
-	if (err)
-		goto out_irq;
+	cpuhp_setup_state_nocalls(CPUHP_AP_ARM_TWD_STARTING,
+				  "AP_ARM_TWD_STARTING",
+				  twd_timer_starting_cpu, twd_timer_dying_cpu);
 
 	twd_get_clock(np);
 	if (!of_property_read_bool(np, "always-on"))
@@ -365,8 +358,6 @@ static int __init twd_local_timer_common
 
 	return 0;
 
-out_irq:
-	free_percpu_irq(twd_ppi, twd_evt);
 out_free:
 	iounmap(twd_base);
 	twd_base = NULL;
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -42,6 +42,7 @@ enum cpuhp_state {
 	CPUHP_AP_ARM_ARCH_TIMER_STARTING,
 	CPUHP_AP_ARM_GLOBAL_TIMER_STARTING,
 	CPUHP_AP_DUMMY_TIMER_STARTING,
+	CPUHP_AP_ARM_TWD_STARTING,
 	CPUHP_AP_EXYNOS4_MCT_TIMER_STARTING,
 	CPUHP_AP_METAG_TIMER_STARTING,
 	CPUHP_AP_QCOM_TIMER_STARTING,
