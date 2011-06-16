From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 16 Jun 2011 20:06:44 +0100
Subject: [RFC PATCH 16/16] ARM: local timers: remove local timer support from
	arch/arm
In-Reply-To: <1308251204-16719-1-git-send-email-marc.zyngier@arm.com>
References: <1308251204-16719-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1308251204-16719-17-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Local timer support in arch/arm is now completely unused, as all
in-tree platforms are using LOCAL_TIMER_DEVICES.

It allows us to simplify the code, only preserving the broadcast timer.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/Kconfig                  |   10 -----
 arch/arm/include/asm/localtimer.h |   48 -------------------------
 arch/arm/kernel/smp.c             |   70 +++++++-----------------------------
 3 files changed, 14 insertions(+), 114 deletions(-)
 delete mode 100644 arch/arm/include/asm/localtimer.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index f3c1124..3f4eecd 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1406,16 +1406,6 @@ config HOTPLUG_CPU
 	  Say Y here to experiment with turning CPUs off and on.  CPUs
 	  can be controlled through /sys/devices/system/cpu.
 
-config LOCAL_TIMERS
-	bool "Use local timer interrupts"
-	depends on SMP && !LOCAL_TIMER_DEVICES
-	default y
-	help
-	  Enable support for local timers on SMP platforms, rather then the
-	  legacy IPI broadcast method.  Local timers allows the system
-	  accounting to be spread across the timer interval, preventing a
-	  "thundering herd" at every timer tick.
-
 config LOCAL_TIMER_DEVICES
 	bool
 
diff --git a/arch/arm/include/asm/localtimer.h b/arch/arm/include/asm/localtimer.h
deleted file mode 100644
index 74af2cd..0000000
--- a/arch/arm/include/asm/localtimer.h
+++ /dev/null
@@ -1,48 +0,0 @@
-/*
- *  arch/arm/include/asm/localtimer.h
- *
- *  Copyright (C) 2004-2005 ARM Ltd.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#ifndef __ASM_ARM_LOCALTIMER_H
-#define __ASM_ARM_LOCALTIMER_H
-
-#include <linux/interrupt.h>
-
-struct clock_event_device;
-
-/*
- * Setup a per-cpu timer, whether it be a local timer or dummy broadcast
- */
-void percpu_timer_setup(void);
-
-/*
- * Per-cpu timer IRQ handler
- */
-irqreturn_t percpu_timer_handler(int irq, void *dev_id);
-
-#ifdef CONFIG_LOCAL_TIMERS
-
-/*
- * Platform provides this to acknowledge a local timer IRQ.
- * Returns true if the local timer IRQ is to be processed.
- */
-int local_timer_ack(void);
-
-/*
- * Setup a local timer interrupt for a CPU.
- */
-int local_timer_setup(struct clock_event_device *);
-
-#else
-
-static inline int local_timer_setup(struct clock_event_device *evt)
-{
-	return -ENXIO;
-}
-#endif
-
-#endif
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 35135b0..214dee3 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -38,7 +38,6 @@
 #include <asm/sections.h>
 #include <asm/tlbflush.h>
 #include <asm/ptrace.h>
-#include <asm/localtimer.h>
 
 /*
  * as from 2.5, kernels no longer have an init_tasks structure
@@ -154,8 +153,6 @@ int __cpuinit __cpu_up(unsigned int cpu)
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
-static void percpu_timer_stop(void);
-
 /*
  * __cpu_disable runs on the processor to be shutdown.
  */
@@ -181,11 +178,6 @@ int __cpu_disable(void)
 	migrate_irqs();
 
 	/*
-	 * Stop the local timer for this CPU.
-	 */
-	percpu_timer_stop();
-
-	/*
 	 * Flush user cache and TLB mappings, and then remove this CPU
 	 * from the vm mask set of all processes.
 	 */
@@ -270,6 +262,8 @@ static void __cpuinit smp_store_cpu_info(unsigned int cpuid)
 	cpu_info->loops_per_jiffy = loops_per_jiffy;
 }
 
+static void broadcast_timer_setup(void);
+
 /*
  * This is the secondary CPU boot entry.  We're using this CPUs
  * idle thread stack, but a set of temporary page tables.
@@ -309,9 +303,9 @@ asmlinkage void __cpuinit secondary_start_kernel(void)
 	local_fiq_enable();
 
 	/*
-	 * Setup the percpu timer for this CPU.
+	 * Setup the broadcast timer for this CPU.
 	 */
-	percpu_timer_setup();
+	broadcast_timer_setup();
 
 	calibrate_delay();
 
@@ -364,10 +358,10 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 
 	if (max_cpus > 1) {
 		/*
-		 * Enable the local timer or broadcast device for the
-		 * boot CPU, but only if we have more than one CPU.
+		 * Enable the broadcast device for the boot CPU, but
+		 * only if we have more than one CPU.
 		 */
-		percpu_timer_setup();
+		broadcast_timer_setup();
 
 		/*
 		 * Initialise the SCU if there are more than one CPU
@@ -430,7 +424,7 @@ u64 smp_irq_stat_cpu(unsigned int cpu)
 }
 
 /*
- * Timer (local or broadcast) support
+ * Broadcast timer support
  */
 static DEFINE_PER_CPU(struct clock_event_device, percpu_clockevent);
 
@@ -442,20 +436,6 @@ static void ipi_timer(void)
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
 #ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
 static void smp_timer_broadcast(const struct cpumask *mask)
 {
@@ -470,8 +450,11 @@ static void broadcast_timer_set_mode(enum clock_event_mode mode,
 {
 }
 
-static void __cpuinit broadcast_timer_setup(struct clock_event_device *evt)
+static void __cpuinit broadcast_timer_setup(void)
 {
+	unsigned int cpu = smp_processor_id();
+	struct clock_event_device *evt = &per_cpu(percpu_clockevent, cpu);
+
 	evt->name	= "dummy_timer";
 	evt->features	= CLOCK_EVT_FEAT_ONESHOT |
 			  CLOCK_EVT_FEAT_PERIODIC |
@@ -479,37 +462,12 @@ static void __cpuinit broadcast_timer_setup(struct clock_event_device *evt)
 	evt->rating	= 400;
 	evt->mult	= 1;
 	evt->set_mode	= broadcast_timer_set_mode;
+	evt->cpumask	= cpumask_of(cpu);
+	evt->broadcast	= smp_timer_broadcast;
 
 	clockevents_register_device(evt);
 }
 
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
-#endif
-
 static DEFINE_SPINLOCK(stop_lock);
 
 /*
-- 
1.7.0.4
