From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  9 Aug 2011 11:46:52 +0100
Subject: [RFC PATCH 10/12] ARM: local timers: make MSM timers standalone
In-Reply-To: <1312886814-15627-1-git-send-email-marc.zyngier@arm.com>
References: <1312886814-15627-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1312886814-15627-11-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Following the same pattern used for smp_twd, allow the MSM timers
to be built in standalone, without relying on the CONFIG_LOCAL_TIMER
infrastructure and use a CPU notifier block to stop or start
the timer on the secondary CPU.

Cc: David Brown <davidb@codeaurora.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/Kconfig          |    2 +-
 arch/arm/mach-msm/timer.c |   64 +++++++++++++++++++++++++++++++++------------
 2 files changed, 48 insertions(+), 18 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 12cbeba..13cdba4 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1436,7 +1436,7 @@ config HOTPLUG_CPU
 
 config LOCAL_TIMERS
 	bool "Use local timer interrupts"
-	depends on SMP && !ARM_SMP_TWD
+	depends on SMP && !ARM_SMP_TWD && !ARCH_MSM
 	default y
 	help
 	  Enable support for local timers on SMP platforms, rather then the
diff --git a/arch/arm/mach-msm/timer.c b/arch/arm/mach-msm/timer.c
index 94e6fc5..f67ff1c 100644
--- a/arch/arm/mach-msm/timer.c
+++ b/arch/arm/mach-msm/timer.c
@@ -21,6 +21,7 @@
 #include <linux/clockchips.h>
 #include <linux/delay.h>
 #include <linux/io.h>
+#include <linux/cpu.h>
 
 #include <asm/mach/time.h>
 #include <asm/hardware/gic.h>
@@ -110,15 +111,7 @@ static cycle_t msm_read_timer_count(struct clocksource *cs)
 
 static struct msm_clock *clockevent_to_clock(struct clock_event_device *evt)
 {
-#ifdef CONFIG_SMP
-	int i;
-	for (i = 0; i < NR_TIMERS; i++)
-		if (evt == &(msm_clocks[i].clockevent))
-			return &msm_clocks[i];
-	return &msm_clocks[MSM_GLOBAL_TIMER];
-#else
 	return container_of(evt, struct msm_clock, clockevent);
-#endif
 }
 
 static int msm_timer_set_next_event(unsigned long cycles,
@@ -193,7 +186,7 @@ static struct msm_clock msm_clocks[] = {
 	}
 };
 
-static void __init msm_timer_init(void)
+static void __init msm_timer_primary_setup(void)
 {
 	int i;
 	int res;
@@ -263,16 +256,13 @@ static void __init msm_timer_init(void)
 }
 
 #ifdef CONFIG_SMP
-int __cpuinit local_timer_setup(struct clock_event_device *evt)
+static void __cpuinit msm_timer_secondary_setup(void *data)
 {
 	static bool local_timer_inited;
+	struct clock_event_device *evt = data;
 	struct msm_clock *clock = &msm_clocks[MSM_GLOBAL_TIMER];
 	int res;
 
-	/* Use existing clock_event for cpu 0 */
-	if (!smp_processor_id())
-		return 0;
-
 	writel(DGT_CLK_CTL_DIV_4, MSM_TMR_BASE + DGT_CLK_CTL);
 
 	if (!local_timer_inited) {
@@ -292,25 +282,65 @@ int __cpuinit local_timer_setup(struct clock_event_device *evt)
 	evt->max_delta_ns =
 		clockevent_delta2ns(0xf0000000 >> clock->shift, evt);
 	evt->min_delta_ns = clockevent_delta2ns(4, evt);
+	evt->cpumask = cpumask_of(smp_processor_id());
 
 	res = gic_request_ppi(evt->irq, msm_timer_interrupt, evt);
 	if (res) {
 		pr_err("local_timer_setup: request_irq failed for %s\n",
 			       clock->clockevent.name);
-		return res;
+		return;
 	}
 
 	clockevents_register_device(evt);
-	return 0;
 }
 
-void local_timer_stop(struct clock_event_device *evt)
+void msm_timer_secondary_teardown(void *data)
 {
+	struct clock_event_device *evt = data;
 	evt->set_mode(CLOCK_EVT_MODE_UNUSED, evt);
 	gic_free_ppi(evt->irq, evt);
 }
+
+static int __cpuinit msm_timer_cpu_notify(struct notifier_block *self,
+					  unsigned long action, void *data)
+{
+	int cpu = (int)data;
+	struct clock_event_device *clk;
+
+	clk = &msm_clocks[MSM_GLOBAL_TIMER].clockevent;
+
+	switch (action) {
+	case CPU_STARTING:
+	case CPU_STARTING_FROZEN:
+		smp_call_function_single(cpu, msm_timer_secondary_setup,
+					 clk, 1);
+		break;
+
+	case CPU_DOWN_PREPARE:
+	case CPU_DOWN_PREPARE_FROZEN:
+		smp_call_function_single(cpu, msm_timer_secondary_teardown,
+					 clk, 1);
+		break;
+	}
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block __cpuinitdata msm_timer_cpu_nb = {
+	.notifier_call = msm_timer_cpu_notify,
+};
 #endif
 
+static void __init msm_timer_init(void)
+{
+	/* Immediately configure the timer on the boot CPU */
+	msm_timer_primary_setup();
+
+#ifdef CONFIG_SMP
+	register_cpu_notifier(&msm_timer_cpu_nb);
+#endif
+}
+
 struct sys_timer msm_timer = {
 	.init = msm_timer_init
 };
-- 
1.7.0.4
