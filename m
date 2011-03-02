From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed,  2 Mar 2011 16:53:21 +0000
Subject: [RFC PATCH 15/20] ARM: exynos4: dynamically register local timer
	setup function
In-Reply-To: <1299084806-16546-1-git-send-email-marc.zyngier@arm.com>
References: <1299084806-16546-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1299084806-16546-16-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-exynos4/Makefile     |    1 -
 arch/arm/mach-exynos4/localtimer.c |   25 -------------------------
 arch/arm/mach-exynos4/time.c       |   10 ++++++++++
 3 files changed, 10 insertions(+), 26 deletions(-)
 delete mode 100644 arch/arm/mach-exynos4/localtimer.c

diff --git a/arch/arm/mach-exynos4/Makefile b/arch/arm/mach-exynos4/Makefile
index 0558235..0d8880e 100644
--- a/arch/arm/mach-exynos4/Makefile
+++ b/arch/arm/mach-exynos4/Makefile
@@ -17,7 +17,6 @@ obj-$(CONFIG_CPU_EXYNOS4210)	+= setup-i2c0.o time.o gpiolib.o irq-eint.o dma.o
 obj-$(CONFIG_CPU_FREQ)		+= cpufreq.o
 
 obj-$(CONFIG_SMP)		+= platsmp.o headsmp.o
-obj-$(CONFIG_LOCAL_TIMERS)	+= localtimer.o
 obj-$(CONFIG_HOTPLUG_CPU)	+= hotplug.o
 
 # machine support
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
diff --git a/arch/arm/mach-exynos4/time.c b/arch/arm/mach-exynos4/time.c
index e30ac70..6f3682e 100644
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
 
@@ -267,10 +269,18 @@ static void __init exynos4_timer_resources(void)
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
