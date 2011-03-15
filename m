From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 15 Mar 2011 15:12:44 +0000
Subject: [RFC PATCHv2 01/20] ARM: architected timers: move local timer support
	to percpu_timer.c
In-Reply-To: <1300201983-26124-1-git-send-email-marc.zyngier@arm.com>
References: <1300201983-26124-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1300201983-26124-2-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To introduce the A15 architected timers without causing too
much disruption on the rest of the kernel, introduce percpu_timer.c
to act as a registration interface that the platform can call at
runtime.

Timer functions are moved out of smp.c (as the A15 can use the
local timer in UP configuration) and  smp_twd.c now returns
a set of operations that percpu_timer.c can call.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/Kconfig                         |    6 +-
 arch/arm/include/asm/entry-macro-multi.S |    2 +-
 arch/arm/include/asm/localtimer.h        |   60 +++++++----
 arch/arm/include/asm/smp.h               |    7 +-
 arch/arm/include/asm/smp_twd.h           |   27 ++++-
 arch/arm/kernel/Makefile                 |    1 +
 arch/arm/kernel/irq.c                    |    1 +
 arch/arm/kernel/percpu_timer.c           |  164 ++++++++++++++++++++++++++++++
 arch/arm/kernel/smp.c                    |   92 +----------------
 arch/arm/kernel/smp_twd.c                |   29 +++++-
 10 files changed, 266 insertions(+), 123 deletions(-)
 create mode 100644 arch/arm/kernel/percpu_timer.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 93d595a..b7e504b 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1326,6 +1326,7 @@ config SMP
 		 ARCH_MSM_SCORPIONMP || ARCH_SHMOBILE
 	select USE_GENERIC_SMP_HELPERS
 	select HAVE_ARM_SCU if !ARCH_MSM_SCORPIONMP
+	select HAVE_ARM_TWD if (!ARCH_MSM_SCORPIONMP && !EXYNOS4_MCT)
 	help
 	  This enables support for systems with more than one CPU. If you have
 	  a system with only one CPU, like most personal computers, say N. If
@@ -1407,10 +1408,9 @@ config HOTPLUG_CPU
 	  can be controlled through /sys/devices/system/cpu.
 
 config LOCAL_TIMERS
-	bool "Use local timer interrupts"
-	depends on SMP
+	bool
+	depends on SMP || ARCH_MSM_SCORPIONMP
 	default y
-	select HAVE_ARM_TWD if (!ARCH_MSM_SCORPIONMP && !EXYNOS4_MCT)
 	help
 	  Enable support for local timers on SMP platforms, rather then the
 	  legacy IPI broadcast method.  Local timers allows the system
diff --git a/arch/arm/include/asm/entry-macro-multi.S b/arch/arm/include/asm/entry-macro-multi.S
index ec0bbf7..589d4ef 100644
--- a/arch/arm/include/asm/entry-macro-multi.S
+++ b/arch/arm/include/asm/entry-macro-multi.S
@@ -23,6 +23,7 @@
 	movne	r1, sp
 	adrne	lr, BSYM(1b)
 	bne	do_IPI
+#endif
 
 #ifdef CONFIG_LOCAL_TIMERS
 	test_for_ltirq r0, r6, r5, lr
@@ -30,7 +31,6 @@
 	adrne	lr, BSYM(1b)
 	bne	do_local_timer
 #endif
-#endif
 9997:
 	.endm
 
diff --git a/arch/arm/include/asm/localtimer.h b/arch/arm/include/asm/localtimer.h
index 080d74f..8988c50 100644
--- a/arch/arm/include/asm/localtimer.h
+++ b/arch/arm/include/asm/localtimer.h
@@ -10,7 +10,9 @@
 #ifndef __ASM_ARM_LOCALTIMER_H
 #define __ASM_ARM_LOCALTIMER_H
 
-struct clock_event_device;
+#include <linux/clockchips.h>
+
+struct seq_file;
 
 /*
  * Setup a per-cpu timer, whether it be a local timer or dummy broadcast
@@ -18,40 +20,58 @@ struct clock_event_device;
 void percpu_timer_setup(void);
 
 /*
- * Called from assembly, this is the local timer IRQ handler
+ * Call a per-cpu timer handler
  */
-asmlinkage void do_local_timer(struct pt_regs *);
-
-
-#ifdef CONFIG_LOCAL_TIMERS
-
-#ifdef CONFIG_HAVE_ARM_TWD
+void percpu_timer_run(void);
 
-#include "smp_twd.h"
-
-#define local_timer_ack()	twd_timer_ack()
-
-#else
+/*
+ * Stop a per-cpu timer
+ */
+void percpu_timer_stop(void);
 
 /*
- * Platform provides this to acknowledge a local timer IRQ.
- * Returns true if the local timer IRQ is to be processed.
+ * Called from assembly, this is the local timer IRQ handler
  */
-int local_timer_ack(void);
+asmlinkage void do_local_timer(struct pt_regs *);
 
-#endif
+struct local_timer_ops {
+	void	(*const pre_setup)(struct clock_event_device *clk);
+	int	(*plat_setup)(struct clock_event_device *clk);
+	void	(*const setup)(struct clock_event_device *clk);
+	int	(*const ack)(void);
+};
 
+#ifdef CONFIG_LOCAL_TIMERS
 /*
  * Setup a local timer interrupt for a CPU.
  */
 int local_timer_setup(struct clock_event_device *);
 
+/*
+ * Register a local timer.
+ */
+void percpu_timer_register(struct local_timer_ops *);
 #else
-
-static inline int local_timer_setup(struct clock_event_device *evt)
+static inline void percpu_timer_register(void *dummy)
 {
-	return -ENXIO;
 }
 #endif
 
+static inline int percpu_timer_register_setup(struct local_timer_ops *ops,
+					      int (*plat_setup)(struct clock_event_device *))
+{
+	if (ops) {
+		ops->plat_setup = plat_setup;
+		percpu_timer_register(ops);
+		return 0;
+	}
+
+	return -ENODEV;
+}
+
+/*
+ * show local interrupt info
+ */
+extern void show_local_irqs(struct seq_file *, int);
+
 #endif
diff --git a/arch/arm/include/asm/smp.h b/arch/arm/include/asm/smp.h
index 96ed521..2e31e8d 100644
--- a/arch/arm/include/asm/smp.h
+++ b/arch/arm/include/asm/smp.h
@@ -95,9 +95,8 @@ extern void platform_cpu_enable(unsigned int cpu);
 extern void arch_send_call_function_single_ipi(int cpu);
 extern void arch_send_call_function_ipi_mask(const struct cpumask *mask);
 
-/*
- * show local interrupt info
- */
-extern void show_local_irqs(struct seq_file *, int);
+#ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
+void smp_timer_broadcast(const struct cpumask *mask);
+#endif
 
 #endif /* ifndef __ASM_ARM_SMP_H */
diff --git a/arch/arm/include/asm/smp_twd.h b/arch/arm/include/asm/smp_twd.h
index fed9981..4096736 100644
--- a/arch/arm/include/asm/smp_twd.h
+++ b/arch/arm/include/asm/smp_twd.h
@@ -1,6 +1,8 @@
 #ifndef __ASMARM_SMP_TWD_H
 #define __ASMARM_SMP_TWD_H
 
+#include <linux/clockchips.h>
+
 #define TWD_TIMER_LOAD			0x00
 #define TWD_TIMER_COUNTER		0x04
 #define TWD_TIMER_CONTROL		0x08
@@ -18,11 +20,28 @@
 #define TWD_TIMER_CONTROL_PERIODIC	(1 << 1)
 #define TWD_TIMER_CONTROL_IT_ENABLE	(1 << 2)
 
-struct clock_event_device;
-
 extern void __iomem *twd_base;
 
-int twd_timer_ack(void);
-void twd_timer_setup(struct clock_event_device *);
+#ifdef CONFIG_HAVE_ARM_TWD
+struct local_timer_ops *local_timer_get_twd_ops(void);
+int twd_timer_register_setup(int (*setup)(struct clock_event_device *));
+#else
+static inline struct local_timer_ops *local_timer_get_twd_ops(void)
+{
+	return NULL;
+}
+
+static inline int twd_timer_register_setup(int (*setup)(struct clock_event_device *))
+{
+	return -ENODEV;
+}
+#endif
+
+/*
+ * Dummy function, to be removed once there is no in-tree user anymore.
+ */
+static inline void twd_timer_setup(void *dummy)
+{
+}
 
 #endif
diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index 74554f1..277f6ff 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -34,6 +34,7 @@ obj-$(CONFIG_HAVE_SCHED_CLOCK)	+= sched_clock.o
 obj-$(CONFIG_SMP)		+= smp.o smp_tlb.o
 obj-$(CONFIG_HAVE_ARM_SCU)	+= smp_scu.o
 obj-$(CONFIG_HAVE_ARM_TWD)	+= smp_twd.o
+obj-$(CONFIG_LOCAL_TIMERS)	+= percpu_timer.o
 obj-$(CONFIG_DYNAMIC_FTRACE)	+= ftrace.o
 obj-$(CONFIG_FUNCTION_GRAPH_TRACER)	+= ftrace.o
 obj-$(CONFIG_KEXEC)		+= machine_kexec.o relocate_kernel.o
diff --git a/arch/arm/kernel/irq.c b/arch/arm/kernel/irq.c
index 3535d37..97154bc 100644
--- a/arch/arm/kernel/irq.c
+++ b/arch/arm/kernel/irq.c
@@ -38,6 +38,7 @@
 #include <linux/ftrace.h>
 
 #include <asm/system.h>
+#include <asm/localtimer.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/irq.h>
 #include <asm/mach/time.h>
diff --git a/arch/arm/kernel/percpu_timer.c b/arch/arm/kernel/percpu_timer.c
new file mode 100644
index 0000000..5992fae
--- /dev/null
+++ b/arch/arm/kernel/percpu_timer.c
@@ -0,0 +1,164 @@
+/*
+ *  linux/arch/arm/kernel/percpu_timer.c
+ *
+ *  Copyright (C) 2011 ARM Ltd.
+ *  All Rights Reserved
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/irq.h>
+#include <linux/seq_file.h>
+#include <linux/interrupt.h>
+
+#include <asm/localtimer.h>
+#include <asm/hardware/gic.h>
+
+#ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
+static void broadcast_timer_set_mode(enum clock_event_mode mode,
+	struct clock_event_device *evt)
+{
+}
+#else
+#define broadcast_timer_set_mode	NULL
+#define smp_timer_broadcast		NULL
+#endif
+
+static void broadcast_timer_setup(struct clock_event_device *evt)
+{
+	/* check that no-one has registered the timer in plat_setup */
+	if (evt->name)
+		return;
+
+	evt->name	= "dummy_timer";
+	evt->features	= CLOCK_EVT_FEAT_ONESHOT |
+			  CLOCK_EVT_FEAT_PERIODIC |
+			  CLOCK_EVT_FEAT_DUMMY;
+	evt->rating	= 400;
+	evt->mult	= 1;
+	evt->set_mode	= broadcast_timer_set_mode;
+	evt->broadcast	= smp_timer_broadcast;
+
+	clockevents_register_device(evt);
+}
+
+static struct local_timer_ops broadcast_timer_ops = {
+	.setup	= broadcast_timer_setup,
+};
+
+static struct local_timer_ops *timer_ops;
+
+int __attribute__ ((weak)) local_timer_setup(struct clock_event_device *evt)
+{
+	return -ENXIO;
+}
+
+void percpu_timer_register(struct local_timer_ops *ops)
+{
+	timer_ops = ops;
+}
+
+/*
+ * local_timer_ack: checks for a local timer interrupt.
+ *
+ * If a local timer interrupt has occurred, acknowledge and return 1.
+ * Otherwise, return 0.
+ *
+ * This can be overloaded by platform code that doesn't provide its
+ * timer in timer_fns way (msm at the moment). Once all platforms have
+ * migrated, the weak alias can be removed.
+ */
+static int percpu_timer_ack(void)
+{
+	return timer_ops->ack();
+}
+
+int local_timer_ack(void) __attribute__ ((weak, alias("percpu_timer_ack")));
+
+asmlinkage void __exception_irq_entry do_local_timer(struct pt_regs *regs)
+{
+	struct pt_regs *old_regs = set_irq_regs(regs);
+	int cpu = smp_processor_id();
+
+	if (local_timer_ack()) {
+		__inc_irq_stat(cpu, local_timer_irqs);
+		percpu_timer_run();
+	}
+
+	set_irq_regs(old_regs);
+}
+
+void show_local_irqs(struct seq_file *p, int prec)
+{
+	unsigned int cpu;
+
+	seq_printf(p, "%*s: ", prec, "LOC");
+
+	for_each_present_cpu(cpu)
+		seq_printf(p, "%10u ", __get_irq_stat(cpu, local_timer_irqs));
+
+	seq_printf(p, " Local timer interrupts\n");
+}
+
+/*
+ * Timer (local or broadcast) support
+ */
+static DEFINE_PER_CPU(struct clock_event_device, percpu_clockevent);
+
+void percpu_timer_run(void)
+{
+	struct clock_event_device *evt = &__get_cpu_var(percpu_clockevent);
+	irq_enter();
+	evt->event_handler(evt);
+	irq_exit();
+}
+
+void __cpuinit percpu_timer_setup(void)
+{
+	int ret = 0;
+	unsigned int cpu = smp_processor_id();
+	struct clock_event_device *evt = &per_cpu(percpu_clockevent, cpu);
+
+	if (evt->name)
+		return;
+
+	/*
+	 * All this can go away once we've migrated all users to
+	 * properly register the timer they use, and broadcast can
+	 * become the fallback.
+	 */
+	if (!timer_ops)
+		timer_ops = local_timer_get_twd_ops();
+	if (!timer_ops)
+		timer_ops = &broadcast_timer_ops;
+	if (!timer_ops->plat_setup)
+		timer_ops->plat_setup = local_timer_setup;
+
+	evt->cpumask = cpumask_of(cpu);
+
+	if (timer_ops->pre_setup)
+		timer_ops->pre_setup(evt);
+	if (timer_ops->plat_setup)
+		ret = timer_ops->plat_setup(evt);
+	if (ret)	/* Fallback to broadcast */
+		timer_ops = &broadcast_timer_ops;
+	if (timer_ops->setup)
+		timer_ops->setup(evt);
+}
+
+#ifdef CONFIG_HOTPLUG_CPU
+/*
+ * The generic clock events code purposely does not stop the local timer
+ * on CPU_DEAD/CPU_DEAD_FROZEN hotplug events, so we have to do it
+ * manually here.
+ */
+void percpu_timer_stop(void)
+{
+	unsigned int cpu = smp_processor_id();
+	struct clock_event_device *evt = &per_cpu(percpu_clockevent, cpu);
+
+	evt->set_mode(CLOCK_EVT_MODE_UNUSED, evt);
+}
+#endif
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 8fe05ad..b94b19c 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -153,8 +153,6 @@ int __cpuinit __cpu_up(unsigned int cpu)
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
-static void percpu_timer_stop(void);
-
 /*
  * __cpu_disable runs on the processor to be shutdown.
  */
@@ -426,97 +424,13 @@ u64 smp_irq_stat_cpu(unsigned int cpu)
 }
 
 /*
- * Timer (local or broadcast) support
+ * Broadcast timer support
  */
-static DEFINE_PER_CPU(struct clock_event_device, percpu_clockevent);
-
-static void ipi_timer(void)
-{
-	struct clock_event_device *evt = &__get_cpu_var(percpu_clockevent);
-	irq_enter();
-	evt->event_handler(evt);
-	irq_exit();
-}
-
-#ifdef CONFIG_LOCAL_TIMERS
-asmlinkage void __exception_irq_entry do_local_timer(struct pt_regs *regs)
-{
-	struct pt_regs *old_regs = set_irq_regs(regs);
-	int cpu = smp_processor_id();
-
-	if (local_timer_ack()) {
-		__inc_irq_stat(cpu, local_timer_irqs);
-		ipi_timer();
-	}
-
-	set_irq_regs(old_regs);
-}
-
-void show_local_irqs(struct seq_file *p, int prec)
-{
-	unsigned int cpu;
-
-	seq_printf(p, "%*s: ", prec, "LOC");
-
-	for_each_present_cpu(cpu)
-		seq_printf(p, "%10u ", __get_irq_stat(cpu, local_timer_irqs));
-
-	seq_printf(p, " Local timer interrupts\n");
-}
-#endif
-
 #ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
-static void smp_timer_broadcast(const struct cpumask *mask)
+void smp_timer_broadcast(const struct cpumask *mask)
 {
 	smp_cross_call(mask, IPI_TIMER);
 }
-#else
-#define smp_timer_broadcast	NULL
-#endif
-
-static void broadcast_timer_set_mode(enum clock_event_mode mode,
-	struct clock_event_device *evt)
-{
-}
-
-static void broadcast_timer_setup(struct clock_event_device *evt)
-{
-	evt->name	= "dummy_timer";
-	evt->features	= CLOCK_EVT_FEAT_ONESHOT |
-			  CLOCK_EVT_FEAT_PERIODIC |
-			  CLOCK_EVT_FEAT_DUMMY;
-	evt->rating	= 400;
-	evt->mult	= 1;
-	evt->set_mode	= broadcast_timer_set_mode;
-
-	clockevents_register_device(evt);
-}
-
-void __cpuinit percpu_timer_setup(void)
-{
-	unsigned int cpu = smp_processor_id();
-	struct clock_event_device *evt = &per_cpu(percpu_clockevent, cpu);
-
-	evt->cpumask = cpumask_of(cpu);
-	evt->broadcast = smp_timer_broadcast;
-
-	if (local_timer_setup(evt))
-		broadcast_timer_setup(evt);
-}
-
-#ifdef CONFIG_HOTPLUG_CPU
-/*
- * The generic clock events code purposely does not stop the local timer
- * on CPU_DEAD/CPU_DEAD_FROZEN hotplug events, so we have to do it
- * manually here.
- */
-static void percpu_timer_stop(void)
-{
-	unsigned int cpu = smp_processor_id();
-	struct clock_event_device *evt = &per_cpu(percpu_clockevent, cpu);
-
-	evt->set_mode(CLOCK_EVT_MODE_UNUSED, evt);
-}
 #endif
 
 static DEFINE_SPINLOCK(stop_lock);
@@ -556,7 +470,7 @@ asmlinkage void __exception_irq_entry do_IPI(int ipinr, struct pt_regs *regs)
 
 	switch (ipinr) {
 	case IPI_TIMER:
-		ipi_timer();
+		percpu_timer_run();
 		break;
 
 	case IPI_RESCHEDULE:
diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
index 60636f4..4fdfb85 100644
--- a/arch/arm/kernel/smp_twd.c
+++ b/arch/arm/kernel/smp_twd.c
@@ -18,6 +18,7 @@
 #include <linux/irq.h>
 #include <linux/io.h>
 
+#include <asm/localtimer.h>
 #include <asm/smp_twd.h>
 #include <asm/hardware/gic.h>
 
@@ -70,7 +71,7 @@ static int twd_set_next_event(unsigned long evt,
  * If a local timer interrupt has occurred, acknowledge and return 1.
  * Otherwise, return 0.
  */
-int twd_timer_ack(void)
+static int twd_timer_ack(void)
 {
 	if (__raw_readl(twd_base + TWD_TIMER_INTSTAT)) {
 		__raw_writel(1, twd_base + TWD_TIMER_INTSTAT);
@@ -122,7 +123,7 @@ static void __cpuinit twd_calibrate_rate(void)
 /*
  * Setup the local clock events for a CPU.
  */
-void __cpuinit twd_timer_setup(struct clock_event_device *clk)
+static void __cpuinit twd_setup(struct clock_event_device *clk)
 {
 	twd_calibrate_rate();
 
@@ -142,3 +143,27 @@ void __cpuinit twd_timer_setup(struct clock_event_device *clk)
 
 	clockevents_register_device(clk);
 }
+
+static struct local_timer_ops twd_timer_ops = {
+	.setup		= twd_setup,
+	.ack		= twd_timer_ack,
+};
+
+struct local_timer_ops *local_timer_get_twd_ops(void)
+{
+	if (!twd_base) {
+		pr_warn("TWD base address not set\n");
+		return NULL;
+	}
+
+	return &twd_timer_ops;
+}
+
+int __init twd_timer_register_setup(int (*setup)(struct clock_event_device *))
+{
+	if (!twd_base)
+		return -ENODEV;
+
+	percpu_timer_register_setup(&twd_timer_ops, setup);
+	return 0;
+}
-- 
1.7.0.4
