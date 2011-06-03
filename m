From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri,  3 Jun 2011 15:57:28 +0100
Subject: [PATCH v1 13/18] ARM: exynos4: dynamically register local timer setup
	function
In-Reply-To: <1307113053-30209-1-git-send-email-marc.zyngier@arm.com>
References: <1307113053-30209-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1307113053-30209-14-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Also convert MCT to the new local timers API.

Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Changhwan Youn <chaos.youn@samsung.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-exynos4/Makefile     |    1 -
 arch/arm/mach-exynos4/localtimer.c |   26 --------------------------
 arch/arm/mach-exynos4/mct.c        |   17 +++++++++++++++--
 arch/arm/mach-exynos4/time.c       |   12 ++++++++++++
 4 files changed, 27 insertions(+), 29 deletions(-)
 delete mode 100644 arch/arm/mach-exynos4/localtimer.c

diff --git a/arch/arm/mach-exynos4/Makefile b/arch/arm/mach-exynos4/Makefile
index a9bb94f..6a0152e 100644
--- a/arch/arm/mach-exynos4/Makefile
+++ b/arch/arm/mach-exynos4/Makefile
@@ -24,7 +24,6 @@ ifeq ($(CONFIG_EXYNOS4_MCT),y)
 obj-y				+= mct.o
 else
 obj-y				+= time.o
-obj-$(CONFIG_LOCAL_TIMERS)	+= localtimer.o
 endif
 
 obj-$(CONFIG_HOTPLUG_CPU)	+= hotplug.o
diff --git a/arch/arm/mach-exynos4/localtimer.c b/arch/arm/mach-exynos4/localtimer.c
deleted file mode 100644
index 6184e29..0000000
--- a/arch/arm/mach-exynos4/localtimer.c
+++ /dev/null
@@ -1,26 +0,0 @@
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
-#include <asm/hardware/gic.h>
-
-/*
- * Setup the local clock events for a CPU.
- */
-int __cpuinit local_timer_setup(struct clock_event_device *evt)
-{
-	evt->irq = gic_ppi_to_vppi(IRQ_LOCALTIMER);
-	return 0;
-}
diff --git a/arch/arm/mach-exynos4/mct.c b/arch/arm/mach-exynos4/mct.c
index 1a30278..f05e2e1 100644
--- a/arch/arm/mach-exynos4/mct.c
+++ b/arch/arm/mach-exynos4/mct.c
@@ -319,7 +319,7 @@ static inline void exynos4_tick_set_mode(enum clock_event_mode mode,
 	}
 }
 
-int local_timer_ack(void)
+static int exynos4_mct_timer_ack(void)
 {
 	unsigned int cpu = smp_processor_id();
 	struct mct_clock_event_device *mevt = &mct_tick[cpu];
@@ -339,7 +339,7 @@ int local_timer_ack(void)
 	return 1;
 }
 
-int __cpuinit local_timer_setup(struct clock_event_device *evt)
+static int __cpuinit exynos4_mct_timer_setup(struct clock_event_device *evt)
 {
 	unsigned int cpu = smp_processor_id();
 	int err = 0;
@@ -389,6 +389,18 @@ int __cpuinit local_timer_setup(struct clock_event_device *evt)
 
 	return err;
 }
+
+static struct local_timer_ops exynos4_mct_ops = {
+	.setup	= exynos4_mct_timer_setup,
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
@@ -404,6 +416,7 @@ static void __init exynos4_timer_init(void)
 	exynos4_timer_resources();
 	exynos4_clocksource_init();
 	exynos4_clockevent_init();
+	percpu_timer_register(exynos4_mct_ops_ptr);
 }
 
 struct sys_timer exynos4_timer = {
diff --git a/arch/arm/mach-exynos4/time.c b/arch/arm/mach-exynos4/time.c
index 86b9fa0..40e585f 100644
--- a/arch/arm/mach-exynos4/time.c
+++ b/arch/arm/mach-exynos4/time.c
@@ -19,9 +19,12 @@
 #include <linux/clockchips.h>
 #include <linux/platform_device.h>
 
+#include <asm/localtimer.h>
 #include <asm/smp_twd.h>
+#include <asm/hardware/gic.h>
 
 #include <mach/map.h>
+#include <mach/irqs.h>
 #include <plat/regs-timer.h>
 #include <asm/mach/time.h>
 
@@ -283,10 +286,19 @@ static void __init exynos4_timer_resources(void)
 	clk_enable(tin4);
 }
 
+#ifdef CONFIG_LOCAL_TIMERS
+static int __cpuinit exynos4_local_timer_setup(struct clock_event_device *evt)
+{
+	evt->irq = gic_ppi_to_vppi(IRQ_LOCALTIMER);
+	return 0;
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
