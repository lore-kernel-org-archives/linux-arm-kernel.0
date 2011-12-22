From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 22 Dec 2011 17:27:37 +0000
Subject: [PATCH v2 07/15] ARM: local timers: switch omap4 to standalone smp_twd
In-Reply-To: <1324574865-5367-1-git-send-email-marc.zyngier@arm.com>
References: <1324574865-5367-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1324574865-5367-8-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert the OMAP4 platforms to the standalone version
of smp_twd.c. Since the timer calibration code requires another
timer to be up and running, the actual initialisation is left
to the late_timer_init hook.

Tested on a Pandaboard.

Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-omap2/Kconfig     |    2 +-
 arch/arm/mach-omap2/Makefile    |    1 -
 arch/arm/mach-omap2/timer-mpu.c |   39 ---------------------------------------
 arch/arm/mach-omap2/timer.c     |   38 +++++++++++++++++++++++++++++++++-----
 4 files changed, 34 insertions(+), 46 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/timer-mpu.c

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index cb760ac..ab0c972 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -45,7 +45,7 @@ config ARCH_OMAP4
 	depends on ARCH_OMAP2PLUS
 	select CPU_V7
 	select ARM_GIC
-	select LOCAL_TIMERS if SMP
+	select ARM_SMP_TWD
 	select PL310_ERRATA_588369
 	select PL310_ERRATA_727915
 	select ARM_ERRATA_720789
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index fc9b238..27ea7c2 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -23,7 +23,6 @@ obj-$(CONFIG_TWL4030_CORE) += omap_twl.o
 
 # SMP support ONLY available for OMAP4
 obj-$(CONFIG_SMP)			+= omap-smp.o omap-headsmp.o
-obj-$(CONFIG_LOCAL_TIMERS)		+= timer-mpu.o
 obj-$(CONFIG_HOTPLUG_CPU)		+= omap-hotplug.o
 obj-$(CONFIG_ARCH_OMAP4)		+= omap4-common.o omap-wakeupgen.o \
 					   sleep44xx.o
diff --git a/arch/arm/mach-omap2/timer-mpu.c b/arch/arm/mach-omap2/timer-mpu.c
deleted file mode 100644
index 31c0ac4..0000000
--- a/arch/arm/mach-omap2/timer-mpu.c
+++ /dev/null
@@ -1,39 +0,0 @@
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
-#include <linux/smp.h>
-#include <linux/clockchips.h>
-#include <asm/irq.h>
-#include <asm/smp_twd.h>
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
-	twd_timer_setup(evt);
-	return 0;
-}
-
diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 9edcd52..a69e686 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -39,7 +39,7 @@
 
 #include <asm/mach/time.h>
 #include <plat/dmtimer.h>
-#include <asm/localtimer.h>
+#include <asm/smp_twd.h>
 #include <asm/sched_clock.h>
 #include "common.h"
 #include <plat/omap_hwmod.h>
@@ -335,15 +335,43 @@ OMAP_SYS_TIMER_INIT(3_secure, OMAP3_SECURE_TIMER, OMAP3_CLKEV_SOURCE,
 OMAP_SYS_TIMER(3_secure)
 #endif
 
+#ifdef CONFIG_ARM_SMP_TWD
+static struct resource omap4_twd_resources[] __initdata = {
+	{
+		.start	= OMAP44XX_LOCAL_TWD_BASE,
+		.end	= OMAP44XX_LOCAL_TWD_BASE + 0x10,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= OMAP44XX_IRQ_LOCALTIMER,
+		.end	= OMAP44XX_IRQ_LOCALTIMER,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static void __init omap4_twd_init(void)
+{
+	int err;
+
+	/* Local timers are not supprted on OMAP4430 ES1.0 */
+	if (omap_rev() == OMAP4430_REV_ES1_0)
+		return;
+
+	err = twd_timer_register(omap4_twd_resources,
+				 ARRAY_SIZE(omap4_twd_resources));
+	if (err)
+		pr_err("twd_timer_register failed %d\n", err);
+}
+#else
+#define omap4_twd_init	NULL
+#endif
+
 #ifdef CONFIG_ARCH_OMAP4
 static void __init omap4_timer_init(void)
 {
-#ifdef CONFIG_LOCAL_TIMERS
-	twd_base = ioremap(OMAP44XX_LOCAL_TWD_BASE, SZ_256);
-	BUG_ON(!twd_base);
-#endif
 	omap2_gp_clockevent_init(1, OMAP4_CLKEV_SOURCE);
 	omap2_gp_clocksource_init(2, OMAP4_MPU_SOURCE);
+	late_time_init = omap4_twd_init;
 }
 OMAP_SYS_TIMER(4)
 #endif
-- 
1.7.7.1
