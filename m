From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 22 Dec 2011 17:27:43 +0000
Subject: [PATCH v2 13/15] ARM: local timers: make MCT timer standalone
In-Reply-To: <1324574865-5367-1-git-send-email-marc.zyngier@arm.com>
References: <1324574865-5367-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1324574865-5367-14-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Following the same pattern used for smp_twd, allow the MCT timers
to be built in standalone, without relying on the CONFIG_LOCAL_TIMER
infrastructure and use a CPU notifier block to stop or start
the timer on the right CPU.

Cc: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/Kconfig           |    2 +-
 arch/arm/mach-exynos/mct.c |   85 ++++++++++++++++++++++++++++++-------------
 2 files changed, 60 insertions(+), 27 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index c3732bb..f5563c5 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1564,7 +1564,7 @@ config HOTPLUG_CPU
 
 config LOCAL_TIMERS
 	bool "Use local timer interrupts"
-	depends on SMP && !ARM_SMP_TWD
+	depends on SMP && !ARM_SMP_TWD && !EXYNOS4_MCT
 	default y
 	help
 	  Enable support for local timers on SMP platforms, rather then the
diff --git a/arch/arm/mach-exynos/mct.c b/arch/arm/mach-exynos/mct.c
index 85b5527..2f1ab9f 100644
--- a/arch/arm/mach-exynos/mct.c
+++ b/arch/arm/mach-exynos/mct.c
@@ -19,6 +19,7 @@
 #include <linux/platform_device.h>
 #include <linux/delay.h>
 #include <linux/percpu.h>
+#include <linux/cpu.h>
 
 #include <asm/hardware/gic.h>
 
@@ -39,7 +40,7 @@ static unsigned long clk_rate;
 static unsigned int mct_int_type;
 
 struct mct_clock_event_device {
-	struct clock_event_device *evt;
+	struct clock_event_device evt;
 	void __iomem *base;
 	char name[10];
 };
@@ -261,9 +262,7 @@ static void exynos4_clockevent_init(void)
 	setup_irq(IRQ_MCT_G0, &mct_comp_event_irq);
 }
 
-#ifdef CONFIG_LOCAL_TIMERS
-
-static DEFINE_PER_CPU(struct mct_clock_event_device, percpu_mct_tick);
+static struct mct_clock_event_device __percpu *mct_tick;
 
 /* Clock event handling */
 static void exynos4_mct_tick_stop(struct mct_clock_event_device *mevt)
@@ -303,8 +302,9 @@ static void exynos4_mct_tick_start(unsigned long cycles,
 static int exynos4_tick_set_next_event(unsigned long cycles,
 				       struct clock_event_device *evt)
 {
-	struct mct_clock_event_device *mevt = this_cpu_ptr(&percpu_mct_tick);
+	struct mct_clock_event_device *mevt;
 
+	mevt = container_of(evt, struct mct_clock_event_device, evt);
 	exynos4_mct_tick_start(cycles, mevt);
 
 	return 0;
@@ -313,8 +313,9 @@ static int exynos4_tick_set_next_event(unsigned long cycles,
 static inline void exynos4_tick_set_mode(enum clock_event_mode mode,
 					 struct clock_event_device *evt)
 {
-	struct mct_clock_event_device *mevt = this_cpu_ptr(&percpu_mct_tick);
+	struct mct_clock_event_device *mevt;
 
+	mevt = container_of(evt, struct mct_clock_event_device, evt);
 	exynos4_mct_tick_stop(mevt);
 
 	switch (mode) {
@@ -332,7 +333,7 @@ static inline void exynos4_tick_set_mode(enum clock_event_mode mode,
 
 static int exynos4_mct_tick_clear(struct mct_clock_event_device *mevt)
 {
-	struct clock_event_device *evt = mevt->evt;
+	struct clock_event_device *evt = &mevt->evt;
 
 	/*
 	 * This is for supporting oneshot mode.
@@ -354,7 +355,7 @@ static int exynos4_mct_tick_clear(struct mct_clock_event_device *mevt)
 static irqreturn_t exynos4_mct_tick_isr(int irq, void *dev_id)
 {
 	struct mct_clock_event_device *mevt = dev_id;
-	struct clock_event_device *evt = mevt->evt;
+	struct clock_event_device *evt = &mevt->evt;
 
 	exynos4_mct_tick_clear(mevt);
 
@@ -375,14 +376,11 @@ static struct irqaction mct_tick1_event_irq = {
 	.handler	= exynos4_mct_tick_isr,
 };
 
-static void exynos4_mct_tick_init(struct clock_event_device *evt)
+static void __cpuinit exynos4_mct_tick_init(struct mct_clock_event_device *mevt)
 {
-	struct mct_clock_event_device *mevt;
+	struct clock_event_device *evt = &mevt->evt;
 	unsigned int cpu = smp_processor_id();
 
-	mevt = this_cpu_ptr(&percpu_mct_tick);
-	mevt->evt = evt;
-
 	mevt->base = EXYNOS4_MCT_L_BASE(cpu);
 	sprintf(mevt->name, "mct_tick%d", cpu);
 
@@ -419,17 +417,12 @@ static void exynos4_mct_tick_init(struct clock_event_device *evt)
 	}
 }
 
-/* Setup the local clock events for a CPU */
-int __cpuinit local_timer_setup(struct clock_event_device *evt)
-{
-	exynos4_mct_tick_init(evt);
-
-	return 0;
-}
-
-void local_timer_stop(struct clock_event_device *evt)
+void exynos4_mct_tick_halt(void *data)
 {
+	struct mct_clock_event_device *mevt = data;
+	struct clock_event_device *evt = &mevt->evt;
 	unsigned int cpu = smp_processor_id();
+
 	evt->set_mode(CLOCK_EVT_MODE_UNUSED, evt);
 	if (mct_int_type == MCT_INT_SPI)
 		if (cpu == 0)
@@ -439,7 +432,48 @@ void local_timer_stop(struct clock_event_device *evt)
 	else
 		disable_percpu_irq(IRQ_MCT_LOCALTIMER);
 }
-#endif /* CONFIG_LOCAL_TIMERS */
+
+static int __cpuinit exynos4_mct_cpu_notify(struct notifier_block *self,
+					    unsigned long action, void *data)
+{
+	int cpu = (int)data;
+	struct mct_clock_event_device *mevt = per_cpu_ptr(mct_tick, cpu);
+
+	switch (action) {
+	case CPU_STARTING:
+	case CPU_STARTING_FROZEN:
+		exynos4_mct_tick_init(mevt);
+		break;
+
+	case CPU_DOWN_PREPARE:
+	case CPU_DOWN_PREPARE_FROZEN:
+		smp_call_function_single(cpu, exynos4_mct_tick_halt, mevt, 1);
+		break;
+	}
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block __cpuinitdata exynos4_mct_cpu_nb = {
+	.notifier_call = exynos4_mct_cpu_notify,
+};
+
+static void __init exynos4_mct_init(void)
+{
+	struct mct_clock_event_device *mevt;
+
+	mct_tick = alloc_percpu(struct mct_clock_event_device);
+	if (!mct_tick) {
+		pr_err("exynos4_mct_init: can't allocate memory\n");
+		return;
+	}
+
+	/* Immediately configure the timer on the boot CPU */
+	mevt = per_cpu_ptr(mct_tick, smp_processor_id());
+	exynos4_mct_tick_init(mevt);
+
+	register_cpu_notifier(&exynos4_mct_cpu_nb);
+}
 
 static void __init exynos4_timer_resources(void)
 {
@@ -448,17 +482,15 @@ static void __init exynos4_timer_resources(void)
 
 	clk_rate = clk_get_rate(mct_clk);
 
-#ifdef CONFIG_LOCAL_TIMERS
 	if (mct_int_type == MCT_INT_PPI) {
 		int err;
 
 		err = request_percpu_irq(IRQ_MCT_LOCALTIMER,
 					 exynos4_mct_tick_isr, "MCT",
-					 &percpu_mct_tick);
+					 mct_tick);
 		WARN(err, "MCT: can't request IRQ %d (%d)\n",
 		     IRQ_MCT_LOCALTIMER, err);
 	}
-#endif /* CONFIG_LOCAL_TIMERS */
 }
 
 static void __init exynos4_timer_init(void)
@@ -471,6 +503,7 @@ static void __init exynos4_timer_init(void)
 	exynos4_timer_resources();
 	exynos4_clocksource_init();
 	exynos4_clockevent_init();
+	exynos4_mct_init();
 }
 
 struct sys_timer exynos4_timer = {
-- 
1.7.7.1
