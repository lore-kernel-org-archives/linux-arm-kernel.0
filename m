From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  9 Aug 2011 11:46:54 +0100
Subject: [RFC PATCH 12/12] ARM: local timers: Remove CONFIG_LOCAL_TIMERS
	support
In-Reply-To: <1312886814-15627-1-git-send-email-marc.zyngier@arm.com>
References: <1312886814-15627-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1312886814-15627-13-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Local timer support in arch/arm is now completely unused, as all
in-tree platforms are using standalone timers.

It allows us to simplify the code, only preserving the broadcast
timer. The broadcast timer is always installed, and we leave it up
to the kernel to pick the more suitable timer (usually the one with
the highest priority).

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/Kconfig                  |   10 ------
 arch/arm/include/asm/localtimer.h |   46 ------------------------------
 arch/arm/kernel/smp.c             |   56 +++++++++---------------------------
 3 files changed, 14 insertions(+), 98 deletions(-)
 delete mode 100644 arch/arm/include/asm/localtimer.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index ef67b64..9aba6c2 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1434,16 +1434,6 @@ config HOTPLUG_CPU
 	  Say Y here to experiment with turning CPUs off and on.  CPUs
 	  can be controlled through /sys/devices/system/cpu.
 
-config LOCAL_TIMERS
-	bool "Use local timer interrupts"
-	depends on SMP && !ARM_SMP_TWD && !ARCH_MSM && !EXYNOS4_MCT
-	default y
-	help
-	  Enable support for local timers on SMP platforms, rather then the
-	  legacy IPI broadcast method.  Local timers allows the system
-	  accounting to be spread across the timer interval, preventing a
-	  "thundering herd" at every timer tick.
-
 source kernel/Kconfig.preempt
 
 config HZ
diff --git a/arch/arm/include/asm/localtimer.h b/arch/arm/include/asm/localtimer.h
deleted file mode 100644
index af5c371..0000000
--- a/arch/arm/include/asm/localtimer.h
+++ /dev/null
@@ -1,46 +0,0 @@
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
-#ifdef CONFIG_LOCAL_TIMERS
-
-/*
- * Stop the local timer
- */
-void local_timer_stop(struct clock_event_device *);
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
-
-static inline void local_timer_stop(struct clock_event_device *evt)
-{
-}
-#endif
-
-#endif
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 5d1f2e2..32471ac 100644
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
@@ -286,6 +278,8 @@ static void __cpuinit smp_store_cpu_info(unsigned int cpuid)
 	cpu_info->loops_per_jiffy = loops_per_jiffy;
 }
 
+static void broadcast_timer_setup(void);
+
 /*
  * This is the secondary CPU boot entry.  We're using this CPUs
  * idle thread stack, but a set of temporary page tables.
@@ -325,9 +319,9 @@ asmlinkage void __cpuinit secondary_start_kernel(void)
 	local_fiq_enable();
 
 	/*
-	 * Setup the percpu timer for this CPU.
+	 * Setup the broadcast timer for this CPU.
 	 */
-	percpu_timer_setup();
+	broadcast_timer_setup();
 
 	calibrate_delay();
 
@@ -383,10 +377,10 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 		max_cpus = ncores;
 	if (ncores > 1 && max_cpus) {
 		/*
-		 * Enable the local timer or broadcast device for the
-		 * boot CPU, but only if we have more than one CPU.
+		 * Enable the broadcast device for the boot CPU, but
+		 * only if we have more than one CPU.
 		 */
-		percpu_timer_setup();
+		broadcast_timer_setup();
 
 		/*
 		 * Initialise the present map, which describes the set of CPUs
@@ -457,7 +451,7 @@ u64 smp_irq_stat_cpu(unsigned int cpu)
 }
 
 /*
- * Timer (local or broadcast) support
+ * Broadcast timer support
  */
 static DEFINE_PER_CPU(struct clock_event_device, percpu_clockevent);
 
@@ -483,8 +477,11 @@ static void broadcast_timer_set_mode(enum clock_event_mode mode,
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
@@ -492,37 +489,12 @@ static void __cpuinit broadcast_timer_setup(struct clock_event_device *evt)
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
-	local_timer_stop(evt);
-}
-#endif
-
 static DEFINE_SPINLOCK(stop_lock);
 
 /*
-- 
1.7.0.4
