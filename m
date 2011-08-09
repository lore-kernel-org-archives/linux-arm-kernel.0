From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  9 Aug 2011 11:46:50 +0100
Subject: [RFC PATCH 08/12] ARM: local timers: switch ux500 to standalone
	smp_twd
In-Reply-To: <1312886814-15627-1-git-send-email-marc.zyngier@arm.com>
References: <1312886814-15627-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1312886814-15627-9-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert the ux500 platforms to the standalone version of smp_twd.c.
Since the timer calibration code requires another timer to be up
and running, the actual initialisation is left to the late_timer_init
hook.

Cc: Linus Walleij <linus.walleij@stericsson.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-ux500/Kconfig      |    1 +
 arch/arm/mach-ux500/Makefile     |    1 -
 arch/arm/mach-ux500/cpu.c        |   40 +++++++++++++++++++++++++++++++------
 arch/arm/mach-ux500/localtimer.c |   29 ---------------------------
 4 files changed, 34 insertions(+), 37 deletions(-)
 delete mode 100644 arch/arm/mach-ux500/localtimer.c

diff --git a/arch/arm/mach-ux500/Kconfig b/arch/arm/mach-ux500/Kconfig
index 4210cb4..3b1f972 100644
--- a/arch/arm/mach-ux500/Kconfig
+++ b/arch/arm/mach-ux500/Kconfig
@@ -4,6 +4,7 @@ config UX500_SOC_COMMON
 	bool
 	default y
 	select ARM_GIC
+	select ARM_SMP_TWD
 	select HAS_MTU
 	select ARM_ERRATA_753970
 
diff --git a/arch/arm/mach-ux500/Makefile b/arch/arm/mach-ux500/Makefile
index 1694916..2e30a80 100644
--- a/arch/arm/mach-ux500/Makefile
+++ b/arch/arm/mach-ux500/Makefile
@@ -14,7 +14,6 @@ obj-$(CONFIG_MACH_U8500)	+= board-mop500.o board-mop500-sdi.o \
 obj-$(CONFIG_MACH_U5500)	+= board-u5500.o board-u5500-sdi.o
 obj-$(CONFIG_SMP)		+= platsmp.o headsmp.o
 obj-$(CONFIG_HOTPLUG_CPU)	+= hotplug.o
-obj-$(CONFIG_LOCAL_TIMERS)	+= localtimer.o
 obj-$(CONFIG_U5500_MODEM_IRQ)	+= modem-irq-db5500.o
 obj-$(CONFIG_U5500_MBOX)	+= mbox-db5500.o
 
diff --git a/arch/arm/mach-ux500/cpu.c b/arch/arm/mach-ux500/cpu.c
index 1da23bb..ec622b6 100644
--- a/arch/arm/mach-ux500/cpu.c
+++ b/arch/arm/mach-ux500/cpu.c
@@ -15,7 +15,7 @@
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/hardware/gic.h>
 #include <asm/mach/map.h>
-#include <asm/localtimer.h>
+#include <asm/smp_twd.h>
 
 #include <plat/mtu.h>
 #include <mach/hardware.h>
@@ -120,15 +120,40 @@ static int ux500_l2x0_init(void)
 early_initcall(ux500_l2x0_init);
 #endif
 
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
+#else
+#define ux500_twd_init	NULL
+#endif
+
 static void __init ux500_timer_init(void)
 {
-#ifdef CONFIG_LOCAL_TIMERS
+#ifdef CONFIG_ARM_SMP_TWD
 	/* Setup the local timer base */
-	if (cpu_is_u5500())
-		twd_base = __io_address(U5500_TWD_BASE);
-	else if (cpu_is_u8500())
-		twd_base = __io_address(U8500_TWD_BASE);
-	else
+	if (cpu_is_u5500()) {
+		ux500_twd_resources[0].start = U5500_TWD_BASE;
+		ux500_twd_resources[0]end = U5500_TWD_BASE + 0x10;
+	} else if (cpu_is_u8500()) {
+		ux500_twd_resources[0].start = U8500_TWD_BASE;
+		ux500_twd_resources[0]end = U8500_TWD_BASE + 0x10;
+	} else
 		ux500_unknown_soc();
 #endif
 	if (cpu_is_u5500())
@@ -141,6 +166,7 @@ static void __init ux500_timer_init(void)
 		ux500_unknown_soc();
 
 	nmdk_timer_init();
+	late_time_init = ux500_twd_init;
 }
 
 struct sys_timer ux500_timer = {
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
-- 
1.7.0.4
