From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 15 Mar 2011 15:12:58 +0000
Subject: [RFC PATCHv2 15/20] ARM: exynos4: dynamically register local timer
	setup function
In-Reply-To: <1300201983-26124-1-git-send-email-marc.zyngier@arm.com>
References: <1300201983-26124-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1300201983-26124-16-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Also convert MCT to the new local timers API.

Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Changhwan Youn <chaos.youn@samsung.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-exynos4/Makefile     |    1 -
 arch/arm/mach-exynos4/localtimer.c |   25 -------------------------
 arch/arm/mach-exynos4/mct.c        |   22 +++++++++++++++-------
 arch/arm/mach-exynos4/time.c       |   10 ++++++++++
 4 files changed, 25 insertions(+), 33 deletions(-)
 delete mode 100644 arch/arm/mach-exynos4/localtimer.c

diff --git a/arch/arm/mach-exynos4/Makefile b/arch/arm/mach-exynos4/Makefile
index 9473adb..f6f3075 100644
--- a/arch/arm/mach-exynos4/Makefile
+++ b/arch/arm/mach-exynos4/Makefile
@@ -23,7 +23,6 @@ ifeq ($(CONFIG_EXYNOS4_MCT),y)
 obj-y				+= mct.o
 else
 obj-y				+= time.o
-obj-$(CONFIG_LOCAL_TIMERS)	+= localtimer.o
 endif
 
 obj-$(CONFIG_HOTPLUG_CPU)	+= hotplug.o
diff --git a/arch/arm/mach-exynos4/localtimer.c b/arch/arm/mach-exynos4/localtimer.c
deleted file mode 100644
index 9d9be20..0000000
--- a/arch/arm/mach-exynos4/localtimer.c
+++ /dev/null
@@ -1,25 +0,0 @@
-/* linux/arch/arm/mach-exynos4/localtimer.c
- *
- * Cloned from linux/arch/arm/mach-realview/localtimer.c
- *
- *  Copyright (C) 2002 ARM Ltd.
- *  All Rights Reserved
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <linux/clockchips.h>
-
-#include <asm/irq.h>
-#include <asm/localtimer.h>
-
-/*
- * Setup the local clock events for a CPU.
- */
-int __cpuinit local_timer_setup(struct clock_event_device *evt)
-{
-	evt->irq = IRQ_LOCALTIMER;
-	return 0;
-}
diff --git a/arch/arm/mach-exynos4/mct.c b/arch/arm/mach-exynos4/mct.c
index af82a8f..4d67123 100644
--- a/arch/arm/mach-exynos4/mct.c
+++ b/arch/arm/mach-exynos4/mct.c
@@ -348,7 +348,7 @@ static struct irqaction mct_tick1_event_irq = {
 	.handler	= exynos4_mct_tick_isr,
 };
 
-static void exynos4_mct_tick_init(struct clock_event_device *evt)
+static int __cpuinit exynos4_mct_tick_init(struct clock_event_device *evt)
 {
 	unsigned int cpu = smp_processor_id();
 
@@ -386,19 +386,26 @@ static void exynos4_mct_tick_init(struct clock_event_device *evt)
 		irq_set_affinity(IRQ_MCT1, cpumask_of(1));
 		setup_irq(IRQ_MCT_L1, &mct_tick1_event_irq);
 	}
-}
 
-/* Setup the local clock events for a CPU */
-void __cpuinit local_timer_setup(struct clock_event_device *evt)
-{
-	exynos4_mct_tick_init(evt);
+	return 0;
 }
 
-int local_timer_ack(void)
+static int exynos4_mct_timer_ack(void)
 {
 	return 0;
 }
 
+static struct local_timer_ops exynos4_mct_ops = {
+	.setup	= exynos4_mct_tick_init,
+	.ack	= exynos4_mct_timer_ack,
+};
+
+#define exynos4_mct_ops_ptr	(&exynos4_mct_ops)
+
+#else
+
+#define exynos4_mct_ops_ptr	NULL
+
 #endif /* CONFIG_LOCAL_TIMERS */
 
 static void __init exynos4_timer_resources(void)
@@ -414,6 +421,7 @@ static void __init exynos4_timer_init(void)
 	exynos4_timer_resources();
 	exynos4_clocksource_init();
 	exynos4_clockevent_init();
+	percpu_timer_register(exynos4_mct_ops_ptr);
 }
 
 struct sys_timer exynos4_timer = {
diff --git a/arch/arm/mach-exynos4/time.c b/arch/arm/mach-exynos4/time.c
index 86b9fa0..ce08297 100644
--- a/arch/arm/mach-exynos4/time.c
+++ b/arch/arm/mach-exynos4/time.c
@@ -19,9 +19,11 @@
 #include <linux/clockchips.h>
 #include <linux/platform_device.h>
 
+#include <asm/localtimer.h>
 #include <asm/smp_twd.h>
 
 #include <mach/map.h>
+#include <mach/irqs.h>
 #include <plat/regs-timer.h>
 #include <asm/mach/time.h>
 
@@ -283,10 +285,18 @@ static void __init exynos4_timer_resources(void)
 	clk_enable(tin4);
 }
 
+#ifdef CONFIG_LOCAL_TIMERS
+static void __cpuinit exynos4_local_timer_setup(struct clock_event_device *evt)
+{
+	evt->irq = IRQ_LOCALTIMER;
+}
+#endif
+
 static void __init exynos4_timer_init(void)
 {
 #ifdef CONFIG_LOCAL_TIMERS
 	twd_base = S5P_VA_TWD;
+	twd_timer_register_setup(exynos4_local_timer_setup);
 #endif
 
 	exynos4_timer_resources();
-- 
1.7.0.4
