From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 22 Dec 2011 17:27:39 +0000
Subject: [PATCH v2 09/15] ARM: local timers: switch ux500 to standalone smp_twd
In-Reply-To: <1324574865-5367-1-git-send-email-marc.zyngier@arm.com>
References: <1324574865-5367-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1324574865-5367-10-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert the ux500 platforms to the standalone version of smp_twd.c.
Since the timer calibration code requires another timer to be up
and running, the actual initialisation is left to the late_timer_init
hook.

Acked-by: Linus Walleij <linus.walleij@stericsson.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-ux500/Kconfig      |    1 +
 arch/arm/mach-ux500/Makefile     |    1 -
 arch/arm/mach-ux500/localtimer.c |   29 --------------------------
 arch/arm/mach-ux500/timer.c      |   41 +++++++++++++++++++++++++++++++------
 4 files changed, 35 insertions(+), 37 deletions(-)
 delete mode 100644 arch/arm/mach-ux500/localtimer.c

diff --git a/arch/arm/mach-ux500/Kconfig b/arch/arm/mach-ux500/Kconfig
index a3e0c86..f69bd06 100644
--- a/arch/arm/mach-ux500/Kconfig
+++ b/arch/arm/mach-ux500/Kconfig
@@ -4,6 +4,7 @@ config UX500_SOC_COMMON
 	bool
 	default y
 	select ARM_GIC
+	select ARM_SMP_TWD
 	select HAS_MTU
 	select ARM_ERRATA_753970
 	select ARM_ERRATA_754322
diff --git a/arch/arm/mach-ux500/Makefile b/arch/arm/mach-ux500/Makefile
index 6bd2f45..35b3894 100644
--- a/arch/arm/mach-ux500/Makefile
+++ b/arch/arm/mach-ux500/Makefile
@@ -15,7 +15,6 @@ obj-$(CONFIG_MACH_U8500)	+= board-mop500.o board-mop500-sdi.o \
 obj-$(CONFIG_MACH_U5500)	+= board-u5500.o board-u5500-sdi.o
 obj-$(CONFIG_SMP)		+= platsmp.o headsmp.o
 obj-$(CONFIG_HOTPLUG_CPU)	+= hotplug.o
-obj-$(CONFIG_LOCAL_TIMERS)	+= localtimer.o
 obj-$(CONFIG_U5500_MODEM_IRQ)	+= modem-irq-db5500.o
 obj-$(CONFIG_U5500_MBOX)	+= mbox-db5500.o
 
diff --git a/arch/arm/mach-ux500/localtimer.c b/arch/arm/mach-ux500/localtimer.c
deleted file mode 100644
index 5ba1133..0000000
--- a/arch/arm/mach-ux500/localtimer.c
+++ /dev/null
@@ -1,29 +0,0 @@
-/*
- * Copyright (C) 2008-2009 ST-Ericsson
- * Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
- *
- * This file is heavily based on relaview platform, almost a copy.
- *
- * Copyright (C) 2002 ARM Ltd.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#include <linux/init.h>
-#include <linux/smp.h>
-#include <linux/clockchips.h>
-
-#include <asm/irq.h>
-#include <asm/smp_twd.h>
-#include <asm/localtimer.h>
-
-/*
- * Setup the local clock events for a CPU.
- */
-int __cpuinit local_timer_setup(struct clock_event_device *evt)
-{
-	evt->irq = IRQ_LOCALTIMER;
-	twd_timer_setup(evt);
-	return 0;
-}
diff --git a/arch/arm/mach-ux500/timer.c b/arch/arm/mach-ux500/timer.c
index aea467d..2518dc8 100644
--- a/arch/arm/mach-ux500/timer.c
+++ b/arch/arm/mach-ux500/timer.c
@@ -8,27 +8,53 @@
 #include <linux/errno.h>
 #include <linux/clksrc-dbx500-prcmu.h>
 
-#include <asm/localtimer.h>
+#include <asm/smp_twd.h>
 
 #include <plat/mtu.h>
 
 #include <mach/setup.h>
 #include <mach/hardware.h>
 
+#ifdef CONFIG_ARM_SMP_TWD
+static struct resource ux500_twd_resources[] __initdata = {
+	{
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= IRQ_LOCALTIMER,
+		.end	= IRQ_LOCALTIMER,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static void __init ux500_twd_init(void)
+{
+	int err = twd_timer_register(ux500_twd_resources,
+				     ARRAY_SIZE(ux500_twd_resources));
+	if (err)
+		pr_err("twd_timer_register failed %d\n", err);
+}
+
+static void __init ux500_twd_set_base(unsigned long base)
+{
+	ux500_twd_resources[0].start = base;
+	ux500_twd_resources[0].end = base + 0x10;
+}
+#else
+#define ux500_twd_init	NULL
+#define ux500_twd_set_base(b)	do { } while(0)
+#endif
+
 static void __init ux500_timer_init(void)
 {
 	void __iomem *prcmu_timer_base;
 
 	if (cpu_is_u5500()) {
-#ifdef CONFIG_LOCAL_TIMERS
-		twd_base = __io_address(U5500_TWD_BASE);
-#endif
+		ux500_twd_set_base(U5500_TWD_BASE);
 		mtu_base = __io_address(U5500_MTU0_BASE);
 		prcmu_timer_base = __io_address(U5500_PRCMU_TIMER_3_BASE);
 	} else if (cpu_is_u8500()) {
-#ifdef CONFIG_LOCAL_TIMERS
-		twd_base = __io_address(U8500_TWD_BASE);
-#endif
+		ux500_twd_set_base(U8500_TWD_BASE);
 		mtu_base = __io_address(U8500_MTU0_BASE);
 		prcmu_timer_base = __io_address(U8500_PRCMU_TIMER_4_BASE);
 	} else {
@@ -54,6 +80,7 @@ static void __init ux500_timer_init(void)
 
 	nmdk_timer_init();
 	clksrc_dbx500_prcmu_init(prcmu_timer_base);
+	late_time_init = ux500_twd_init;
 }
 
 static void ux500_timer_reset(void)
-- 
1.7.7.1
