From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri,  3 Jun 2011 15:57:16 +0100
Subject: [PATCH v1 01/18] ARM: Move local timer support out of smp.c
In-Reply-To: <1307113053-30209-1-git-send-email-marc.zyngier@arm.com>
References: <1307113053-30209-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1307113053-30209-2-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Historically, local timer support has been tied to SMP.
This is less true these days, as some cores have local timers
even in UP configuration. Furthermore, it is desirable to have
converging implementations for both UP and SMP.

As a result of the above, move the timer code out of smp.c to
percpu_timer.c. Very little else is changed.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/Kconfig                  |    6 +-
 arch/arm/include/asm/localtimer.h |    9 ++++
 arch/arm/include/asm/smp.h        |    4 ++
 arch/arm/kernel/Makefile          |    1 +
 arch/arm/kernel/percpu_timer.c    |   89 +++++++++++++++++++++++++++++++++++++
 arch/arm/kernel/smp.c             |   74 ++-----------------------------
 6 files changed, 110 insertions(+), 73 deletions(-)
 create mode 100644 arch/arm/kernel/percpu_timer.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 6094268..eda2230 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1315,6 +1315,7 @@ config SMP
 	select USE_GENERIC_SMP_HELPERS
 	select ARM_GIC_VPPI
 	select HAVE_ARM_SCU if !ARCH_MSM_SCORPIONMP
+	select HAVE_ARM_TWD if (!ARCH_MSM_SCORPIONMP && !EXYNOS4_MCT)
 	help
 	  This enables support for systems with more than one CPU. If you have
 	  a system with only one CPU, like most personal computers, say N. If
@@ -1395,10 +1396,9 @@ config HOTPLUG_CPU
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
diff --git a/arch/arm/include/asm/localtimer.h b/arch/arm/include/asm/localtimer.h
index 5c8acb4..b3fd6ea 100644
--- a/arch/arm/include/asm/localtimer.h
+++ b/arch/arm/include/asm/localtimer.h
@@ -24,6 +24,11 @@ void percpu_timer_setup(void);
  */
 irqreturn_t percpu_timer_handler(int irq, void *dev_id);
 
+/*
+ * Kick per-cpu timer event_handler
+ */
+void percpu_timer_run(void);
+
 #ifdef CONFIG_LOCAL_TIMERS
 
 #ifdef CONFIG_HAVE_ARM_TWD
@@ -41,6 +46,10 @@ irqreturn_t percpu_timer_handler(int irq, void *dev_id);
 int local_timer_ack(void);
 
 #endif
+/*
+ * Stop a per-cpu timer
+ */
+void percpu_timer_stop(void);
 
 /*
  * Setup a local timer interrupt for a CPU.
diff --git a/arch/arm/include/asm/smp.h b/arch/arm/include/asm/smp.h
index 73ec155..030a98b 100644
--- a/arch/arm/include/asm/smp.h
+++ b/arch/arm/include/asm/smp.h
@@ -88,4 +88,8 @@ extern void platform_cpu_enable(unsigned int cpu);
 extern void arch_send_call_function_single_ipi(int cpu);
 extern void arch_send_call_function_ipi_mask(const struct cpumask *mask);
 
+#ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
+void smp_timer_broadcast(const struct cpumask *mask);
+#endif
+
 #endif /* ifndef __ASM_ARM_SMP_H */
diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index a5b31af..a5a5e64 100644
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
diff --git a/arch/arm/kernel/percpu_timer.c b/arch/arm/kernel/percpu_timer.c
new file mode 100644
index 0000000..4b6e230
--- /dev/null
+++ b/arch/arm/kernel/percpu_timer.c
@@ -0,0 +1,89 @@
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
+#include <linux/interrupt.h>
+#include <linux/clockchips.h>
+
+#include <asm/localtimer.h>
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
+/*
+ * Timer (local or broadcast) support
+ */
+static DEFINE_PER_CPU(struct clock_event_device, percpu_clockevent);
+
+irqreturn_t percpu_timer_handler(int irq, void *dev_id)
+{
+	struct clock_event_device *evt = dev_id;
+
+	if (local_timer_ack()) {
+		evt->event_handler(evt);
+		return IRQ_HANDLED;
+	}
+
+	return IRQ_NONE;
+}
+
+void percpu_timer_run(void)
+{
+	struct clock_event_device *evt = &__get_cpu_var(percpu_clockevent);
+	percpu_timer_handler(0, evt);
+}
+
+void __cpuinit percpu_timer_setup(void)
+{
+	unsigned int cpu = smp_processor_id();
+	struct clock_event_device *evt = &per_cpu(percpu_clockevent, cpu);
+
+	evt->cpumask = cpumask_of(cpu);
+	evt->broadcast = smp_timer_broadcast;
+
+	if (local_timer_setup(evt))
+		broadcast_timer_setup(evt);
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
index 476cbff..34b5eeb 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -154,8 +154,6 @@ int __cpuinit __cpu_up(unsigned int cpu)
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
-static void percpu_timer_stop(void);
-
 /*
  * __cpu_disable runs on the processor to be shutdown.
  */
@@ -424,84 +422,20 @@ u64 smp_irq_stat_cpu(unsigned int cpu)
 }
 
 /*
- * Timer (local or broadcast) support
+ * Broadcast timer support
  */
-static DEFINE_PER_CPU(struct clock_event_device, percpu_clockevent);
-
+#ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
 static void ipi_timer(void)
 {
-	struct clock_event_device *evt = &__get_cpu_var(percpu_clockevent);
 	irq_enter();
-	evt->event_handler(evt);
+	percpu_timer_run();
 	irq_exit();
 }
 
-#ifdef CONFIG_LOCAL_TIMERS
-irqreturn_t percpu_timer_handler(int irq, void *dev_id)
-{
-	struct clock_event_device *evt = dev_id;
-
-	if (local_timer_ack()) {
-		evt->event_handler(evt);
-		return IRQ_HANDLED;
-	}
-
-	return IRQ_NONE;
-}
-#endif
-
-#ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
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
-static void __cpuinit broadcast_timer_setup(struct clock_event_device *evt)
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
-- 
1.7.0.4
