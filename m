From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 15 Mar 2011 15:12:57 +0000
Subject: [RFC PATCHv2 14/20] ARM: omap4: dynamically register local timer
	setup function
In-Reply-To: <1300201983-26124-1-git-send-email-marc.zyngier@arm.com>
References: <1300201983-26124-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1300201983-26124-15-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-omap2/Makefile    |    1 -
 arch/arm/mach-omap2/timer-gp.c  |   13 ++++++++++++-
 arch/arm/mach-omap2/timer-mpu.c |   36 ------------------------------------
 3 files changed, 12 insertions(+), 38 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/timer-mpu.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index a45cd64..41f8b67 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -22,7 +22,6 @@ obj-$(CONFIG_TWL4030_CORE) += omap_twl.o
 
 # SMP support ONLY available for OMAP4
 obj-$(CONFIG_SMP)			+= omap-smp.o omap-headsmp.o
-obj-$(CONFIG_LOCAL_TIMERS)		+= timer-mpu.o
 obj-$(CONFIG_HOTPLUG_CPU)		+= omap-hotplug.o
 obj-$(CONFIG_ARCH_OMAP4)		+= omap44xx-smc.o omap4-common.o
 
diff --git a/arch/arm/mach-omap2/timer-gp.c b/arch/arm/mach-omap2/timer-gp.c
index 3b9cf85..98d03c5 100644
--- a/arch/arm/mach-omap2/timer-gp.c
+++ b/arch/arm/mach-omap2/timer-gp.c
@@ -39,6 +39,7 @@
 #include <asm/mach/time.h>
 #include <plat/dmtimer.h>
 #include <asm/localtimer.h>
+#include <asm/smp_twd.h>
 #include <asm/sched_clock.h>
 #include <plat/common.h>
 #include <plat/omap_hwmod.h>
@@ -247,12 +248,22 @@ static void __init omap2_gp_clocksource_init(void)
 }
 #endif
 
+#ifdef CONFIG_LOCAL_TIMERS
+static int __cpuinit omap4_local_timer_setup(struct clock_event_device *evt)
+{
+	evt->irq = OMAP44XX_IRQ_LOCALTIMER;
+	return 0;
+}
+#endif
+
 static void __init omap2_gp_timer_init(void)
 {
 #ifdef CONFIG_LOCAL_TIMERS
-	if (cpu_is_omap44xx()) {
+	if (cpu_is_omap44xx() && omap_rev() != OMAP4430_REV_ES1_0) {
 		twd_base = ioremap(OMAP44XX_LOCAL_TWD_BASE, SZ_256);
 		BUG_ON(!twd_base);
+
+		twd_timer_register_setup(omap4_local_timer_setup);
 	}
 #endif
 	omap_dm_timer_init();
diff --git a/arch/arm/mach-omap2/timer-mpu.c b/arch/arm/mach-omap2/timer-mpu.c
deleted file mode 100644
index 02feaff..0000000
--- a/arch/arm/mach-omap2/timer-mpu.c
+++ /dev/null
@@ -1,36 +0,0 @@
-/*
- * The MPU local timer source file. In OMAP4, both cortex-a9 cores have
- * own timer in it's MPU domain. These timers will be driving the
- * linux kernel SMP tick framework when active. These timers are not
- * part of the wake up domain.
- *
- * Copyright (C) 2009 Texas Instruments, Inc.
- *
- * Author:
- *      Santosh Shilimkar <santosh.shilimkar@ti.com>
- *
- * This file is based on arm realview smp platform file.
- * Copyright (C) 2002 ARM Ltd.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#include <linux/init.h>
-#include <linux/clockchips.h>
-#include <asm/irq.h>
-#include <asm/localtimer.h>
-
-/*
- * Setup the local clock events for a CPU.
- */
-int __cpuinit local_timer_setup(struct clock_event_device *evt)
-{
-	/* Local timers are not supprted on OMAP4430 ES1.0 */
-	if (omap_rev() == OMAP4430_REV_ES1_0)
-		return -ENXIO;
-
-	evt->irq = OMAP44XX_IRQ_LOCALTIMER;
-	return 0;
-}
-
-- 
1.7.0.4
