From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 22 Dec 2011 17:27:44 +0000
Subject: [PATCH v2 14/15] ARM: local timers: make MSM timers standalone
In-Reply-To: <1324574865-5367-1-git-send-email-marc.zyngier@arm.com>
References: <1324574865-5367-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1324574865-5367-15-git-send-email-marc.zyngier@arm.com>
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
 arch/arm/mach-msm/timer.c |   92 +++++++++++++++++++++++++++++++++-----------
 2 files changed, 70 insertions(+), 24 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index f5563c5..cea5e72 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1564,7 +1564,7 @@ config HOTPLUG_CPU
 
 config LOCAL_TIMERS
 	bool "Use local timer interrupts"
-	depends on SMP && !ARM_SMP_TWD && !EXYNOS4_MCT
+	depends on SMP && !ARM_SMP_TWD && !EXYNOS4_MCT && !MSM
 	default y
 	help
 	  Enable support for local timers on SMP platforms, rather then the
diff --git a/arch/arm/mach-msm/timer.c b/arch/arm/mach-msm/timer.c
index 11d0d8f..ac055c9 100644
--- a/arch/arm/mach-msm/timer.c
+++ b/arch/arm/mach-msm/timer.c
@@ -20,10 +20,11 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/io.h>
+#include <linux/cpu.h>
+#include <linux/slab.h>
 
 #include <asm/mach/time.h>
 #include <asm/hardware/gic.h>
-#include <asm/localtimer.h>
 
 #include <mach/msm_iomap.h>
 #include <mach/cpu.h>
@@ -46,7 +47,7 @@ static void __iomem *event_base;
 
 static irqreturn_t msm_timer_interrupt(int irq, void *dev_id)
 {
-	struct clock_event_device *evt = *(struct clock_event_device **)dev_id;
+	struct clock_event_device *evt = dev_id;
 	/* Stop the timer tick */
 	if (evt->mode == CLOCK_EVT_MODE_ONESHOT) {
 		u32 ctrl = readl_relaxed(event_base + TIMER_ENABLE);
@@ -100,7 +101,7 @@ static struct clock_event_device msm_clockevent = {
 
 static union {
 	struct clock_event_device *evt;
-	struct clock_event_device __percpu **percpu_evt;
+	struct clock_event_device __percpu *percpu_evt;
 } msm_evt;
 
 static void __iomem *source_base;
@@ -127,7 +128,7 @@ static struct clocksource msm_clocksource = {
 	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
-static void __init msm_timer_init(void)
+static void __init msm_timer_primary_setup(void)
 {
 	struct clock_event_device *ce = &msm_clockevent;
 	struct clocksource *cs = &msm_clocksource;
@@ -154,6 +155,13 @@ static void __init msm_timer_init(void)
 		source_base = MSM_TMR0_BASE + 0x24;
 		dgt_hz = 27000000 / 4;
 		writel_relaxed(DGT_CLK_CTL_DIV_4, MSM_TMR_BASE + DGT_CLK_CTL);
+		msm_evt.percpu_evt = alloc_percpu(struct clock_event_device);
+		if (!msm_evt.percpu_evt) {
+			pr_err("memory allocation failed for %s\n", ce->name);
+			goto err;
+		}
+		ce = __this_cpu_ptr(msm_evt.percpu_evt);
+		*ce = msm_clockevent; /* Use msm_clockevent as a template */
 	} else
 		BUG();
 
@@ -165,12 +173,8 @@ static void __init msm_timer_init(void)
 	ce->irq = INT_GP_TIMER_EXP;
 	clockevents_config_and_register(ce, GPT_HZ, 4, 0xffffffff);
 	if (cpu_is_msm8x60() || cpu_is_msm8960()) {
-		msm_evt.percpu_evt = alloc_percpu(struct clock_event_device *);
-		if (!msm_evt.percpu_evt) {
-			pr_err("memory allocation failed for %s\n", ce->name);
-			goto err;
-		}
-		*__this_cpu_ptr(msm_evt.percpu_evt) = ce;
+		msm_clockevent.irq = ce->irq;
+		msm_clockevent.shift = ce->shift;
 		res = request_percpu_irq(ce->irq, msm_timer_interrupt,
 					 ce->name, msm_evt.percpu_evt);
 		if (!res)
@@ -179,7 +183,7 @@ static void __init msm_timer_init(void)
 		msm_evt.evt = ce;
 		res = request_irq(ce->irq, msm_timer_interrupt,
 				  IRQF_TIMER | IRQF_NOBALANCING |
-				  IRQF_TRIGGER_RISING, ce->name, &msm_evt.evt);
+				  IRQF_TRIGGER_RISING, ce->name, msm_evt.evt);
 	}
 
 	if (res)
@@ -191,16 +195,18 @@ err:
 		pr_err("clocksource_register failed\n");
 }
 
-#ifdef CONFIG_LOCAL_TIMERS
-int __cpuinit local_timer_setup(struct clock_event_device *evt)
+#ifdef CONFIG_SMP
+static void __cpuinit msm_timer_secondary_setup(struct clock_event_device *evt)
 {
-	/* Use existing clock_event for cpu 0 */
-	if (!smp_processor_id())
-		return 0;
+	static bool local_timer_inited;
+
+	if (!local_timer_inited) {
+		writel_relaxed(0, event_base + TIMER_ENABLE);
+		writel_relaxed(0, event_base + TIMER_CLEAR);
+		writel_relaxed(~0, event_base + TIMER_MATCH_VAL);
+		local_timer_inited = true;
+	}
 
-	writel_relaxed(0, event_base + TIMER_ENABLE);
-	writel_relaxed(0, event_base + TIMER_CLEAR);
-	writel_relaxed(~0, event_base + TIMER_MATCH_VAL);
 	evt->irq = msm_clockevent.irq;
 	evt->name = "local_timer";
 	evt->features = msm_clockevent.features;
@@ -211,19 +217,59 @@ int __cpuinit local_timer_setup(struct clock_event_device *evt)
 	evt->mult = div_sc(GPT_HZ, NSEC_PER_SEC, evt->shift);
 	evt->max_delta_ns = clockevent_delta2ns(0xf0000000, evt);
 	evt->min_delta_ns = clockevent_delta2ns(4, evt);
+	evt->cpumask = cpumask_of(smp_processor_id());
 
-	*__this_cpu_ptr(msm_evt.percpu_evt) = evt;
 	clockevents_register_device(evt);
+
 	enable_percpu_irq(evt->irq, 0);
-	return 0;
 }
 
-void local_timer_stop(struct clock_event_device *evt)
+void msm_timer_secondary_teardown(void *data)
 {
+	struct clock_event_device *evt = data;
 	evt->set_mode(CLOCK_EVT_MODE_UNUSED, evt);
 	disable_percpu_irq(evt->irq);
 }
-#endif /* CONFIG_LOCAL_TIMERS */
+
+static int __cpuinit msm_timer_cpu_notify(struct notifier_block *self,
+					  unsigned long action, void *data)
+{
+	int cpu = (int)data;
+	struct clock_event_device *clk;
+
+	clk = per_cpu_ptr(msm_evt.percpu_evt, cpu);
+
+	switch (action) {
+	case CPU_STARTING:
+	case CPU_STARTING_FROZEN:
+		msm_timer_secondary_setup(clk);
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
+#endif
+
+static void __init msm_timer_init(void)
+{
+	/* Immediately configure the timer on the boot CPU */
+	msm_timer_primary_setup();
+
+#ifdef CONFIG_SMP
+	if (cpu_is_msm8x60() || cpu_is_msm8960())
+		register_cpu_notifier(&msm_timer_cpu_nb);
+#endif
+}
 
 struct sys_timer msm_timer = {
 	.init = msm_timer_init
-- 
1.7.7.1
