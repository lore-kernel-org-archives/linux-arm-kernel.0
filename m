From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  9 Aug 2011 11:46:53 +0100
Subject: [RFC PATCH 11/12] ARM: local timers: make MCT timer standalone
In-Reply-To: <1312886814-15627-1-git-send-email-marc.zyngier@arm.com>
References: <1312886814-15627-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1312886814-15627-12-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Following the same pattern used for smp_twd, allow the MCT timers
to be built in standalone, without relying on the CONFIG_LOCAL_TIMER
infrastructure and use a CPU notifier block to stop or start
the timer on the right CPU.

Cc: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/Kconfig            |    2 +-
 arch/arm/mach-exynos4/mct.c |   75 ++++++++++++++++++++++++++++++++----------
 2 files changed, 58 insertions(+), 19 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 13cdba4..ef67b64 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1436,7 +1436,7 @@ config HOTPLUG_CPU
 
 config LOCAL_TIMERS
 	bool "Use local timer interrupts"
-	depends on SMP && !ARM_SMP_TWD && !ARCH_MSM
+	depends on SMP && !ARM_SMP_TWD && !ARCH_MSM && !EXYNOS4_MCT
 	default y
 	help
 	  Enable support for local timers on SMP platforms, rather then the
diff --git a/arch/arm/mach-exynos4/mct.c b/arch/arm/mach-exynos4/mct.c
index 194fc6d..abe92cf 100644
--- a/arch/arm/mach-exynos4/mct.c
+++ b/arch/arm/mach-exynos4/mct.c
@@ -19,6 +19,7 @@
 #include <linux/platform_device.h>
 #include <linux/delay.h>
 #include <linux/percpu.h>
+#include <linux/cpu.h>
 
 #include <mach/map.h>
 #include <mach/regs-mct.h>
@@ -28,11 +29,11 @@ static unsigned long clk_cnt_per_tick;
 static unsigned long clk_rate;
 
 struct mct_clock_event_device {
-	struct clock_event_device *evt;
+	struct clock_event_device evt;
 	void __iomem *base;
 };
 
-struct mct_clock_event_device mct_tick[2];
+static struct mct_clock_event_device __percpu *mct_tick;
 
 static void exynos4_mct_write(unsigned int value, void *addr)
 {
@@ -249,10 +250,10 @@ static void exynos4_clockevent_init(void)
 	setup_irq(IRQ_MCT_G0, &mct_comp_event_irq);
 }
 
-#ifdef CONFIG_LOCAL_TIMERS
 /* Clock event handling */
-static void exynos4_mct_tick_stop(struct mct_clock_event_device *mevt)
+static void exynos4_mct_tick_stop(void *data)
 {
+	struct mct_clock_event_device *mevt = data;
 	unsigned long tmp;
 	unsigned long mask = MCT_L_TCON_INT_START | MCT_L_TCON_TIMER_START;
 	void __iomem *addr = mevt->base + MCT_L_TCON_OFFSET;
@@ -288,8 +289,9 @@ static void exynos4_mct_tick_start(unsigned long cycles,
 static int exynos4_tick_set_next_event(unsigned long cycles,
 				       struct clock_event_device *evt)
 {
-	struct mct_clock_event_device *mevt = &mct_tick[smp_processor_id()];
+	struct mct_clock_event_device *mevt;
 
+	mevt = container_of(evt, struct mct_clock_event_device, evt);
 	exynos4_mct_tick_start(cycles, mevt);
 
 	return 0;
@@ -298,8 +300,9 @@ static int exynos4_tick_set_next_event(unsigned long cycles,
 static inline void exynos4_tick_set_mode(enum clock_event_mode mode,
 					 struct clock_event_device *evt)
 {
-	struct mct_clock_event_device *mevt = &mct_tick[smp_processor_id()];
+	struct mct_clock_event_device *mevt;
 
+	mevt = container_of(evt, struct mct_clock_event_device, evt);
 	exynos4_mct_tick_stop(mevt);
 
 	switch (mode) {
@@ -318,7 +321,7 @@ static inline void exynos4_tick_set_mode(enum clock_event_mode mode,
 static irqreturn_t exynos4_mct_tick_isr(int irq, void *dev_id)
 {
 	struct mct_clock_event_device *mevt = dev_id;
-	struct clock_event_device *evt = mevt->evt;
+	struct clock_event_device *evt = &mevt->evt;
 
 	/*
 	 * This is for supporting oneshot mode.
@@ -348,17 +351,17 @@ static struct irqaction mct_tick1_event_irq = {
 	.handler	= exynos4_mct_tick_isr,
 };
 
-static void exynos4_mct_tick_init(struct clock_event_device *evt)
+static void __cpuinit exynos4_mct_tick_init(void *data)
 {
+	struct mct_clock_event_device *mevt = data;
+	struct clock_event_device *evt = &mevt->evt;
 	unsigned int cpu = smp_processor_id();
 
-	mct_tick[cpu].evt = evt;
-
 	if (cpu == 0) {
-		mct_tick[cpu].base = EXYNOS4_MCT_L0_BASE;
+		mct_tick->base = EXYNOS4_MCT_L0_BASE;
 		evt->name = "mct_tick0";
 	} else {
-		mct_tick[cpu].base = EXYNOS4_MCT_L1_BASE;
+		mct_tick->base = EXYNOS4_MCT_L1_BASE;
 		evt->name = "mct_tick1";
 	}
 
@@ -379,21 +382,56 @@ static void exynos4_mct_tick_init(struct clock_event_device *evt)
 	exynos4_mct_write(0x1, mct_tick[cpu].base + MCT_L_TCNTB_OFFSET);
 
 	if (cpu == 0) {
-		mct_tick0_event_irq.dev_id = &mct_tick[cpu];
+		mct_tick0_event_irq.dev_id = mevt;
 		setup_irq(IRQ_MCT_L0, &mct_tick0_event_irq);
 	} else {
-		mct_tick1_event_irq.dev_id = &mct_tick[cpu];
+		mct_tick1_event_irq.dev_id = mevt;
 		setup_irq(IRQ_MCT_L1, &mct_tick1_event_irq);
 		irq_set_affinity(IRQ_MCT_L1, cpumask_of(1));
 	}
 }
 
-/* Setup the local clock events for a CPU */
-void __cpuinit local_timer_setup(struct clock_event_device *evt)
+static int __cpuinit exynos4_mct_cpu_notify(struct notifier_block *self,
+					    unsigned long action, void *data)
 {
-	exynos4_mct_tick_init(evt);
+	int cpu = (int)data;
+	struct mct_clock_event_device *mevt = per_cpu_ptr(mct_tick, cpu);
+
+	switch (action) {
+	case CPU_STARTING:
+	case CPU_STARTING_FROZEN:
+		smp_call_function_single(cpu, exynos4_mct_tick_init, mevt, 1);
+		break;
+
+	case CPU_DOWN_PREPARE:
+	case CPU_DOWN_PREPARE_FROZEN:
+		smp_call_function_single(cpu, exynos4_mct_tick_stop, mevt, 1);
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
 }
-#endif /* CONFIG_LOCAL_TIMERS */
 
 static void __init exynos4_timer_resources(void)
 {
@@ -408,6 +446,7 @@ static void __init exynos4_timer_init(void)
 	exynos4_timer_resources();
 	exynos4_clocksource_init();
 	exynos4_clockevent_init();
+	exynos4_mct_init();
 }
 
 struct sys_timer exynos4_timer = {
-- 
1.7.0.4
