From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 11 Jan 2012 13:08:48 +0000
Subject: [PATCH 09/15] ARM: ux500: convert to twd_local_timer_register()
 interface
In-Reply-To: <1326287334-1905-1-git-send-email-marc.zyngier@arm.com>
References: <1326287334-1905-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1326287334-1905-10-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the new smp_twd runtime registration interface
to the ux500 platforms, and remove the old compile-time support.

Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-ux500/Makefile     |    1 -
 arch/arm/mach-ux500/cpu.c        |    1 -
 arch/arm/mach-ux500/localtimer.c |   29 ----------------------------
 arch/arm/mach-ux500/timer.c      |   39 +++++++++++++++++++++++++++++++------
 4 files changed, 32 insertions(+), 38 deletions(-)
 delete mode 100644 arch/arm/mach-ux500/localtimer.c

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
 
diff --git a/arch/arm/mach-ux500/cpu.c b/arch/arm/mach-ux500/cpu.c
index f418574..851308b 100644
--- a/arch/arm/mach-ux500/cpu.c
+++ b/arch/arm/mach-ux500/cpu.c
@@ -14,7 +14,6 @@
 
 #include <asm/hardware/gic.h>
 #include <asm/mach/map.h>
-#include <asm/localtimer.h>
 
 #include <mach/hardware.h>
 #include <mach/setup.h>
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
index aea467d..a7667b1 100644
--- a/arch/arm/mach-ux500/timer.c
+++ b/arch/arm/mach-ux500/timer.c
@@ -8,27 +8,47 @@
 #include <linux/errno.h>
 #include <linux/clksrc-dbx500-prcmu.h>
 
-#include <asm/localtimer.h>
+#include <asm/smp_twd.h>
 
 #include <plat/mtu.h>
 
 #include <mach/setup.h>
 #include <mach/hardware.h>
 
+#ifdef CONFIG_HAVE_ARM_TWD
+static struct twd_local_timer twd_local_timer __initdata = {
+	.res =	{
+		{
+			.flags	= IORESOURCE_MEM,
+		},
+		{
+			.start	= IRQ_LOCALTIMER,
+			.end	= IRQ_LOCALTIMER,
+			.flags	= IORESOURCE_IRQ,
+		},
+	},
+};
+
+static void __init ux500_twd_set_base(unsigned long base)
+{
+	twd_local_timer.res[0].start = base;
+	twd_local_timer.res[0].end = base + 0x10;
+}
+#else
+#define ux500_twd_set_base(b)	do { } while(0)
+#endif
+
 static void __init ux500_timer_init(void)
 {
 	void __iomem *prcmu_timer_base;
+	int err;
 
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
@@ -54,6 +74,11 @@ static void __init ux500_timer_init(void)
 
 	nmdk_timer_init();
 	clksrc_dbx500_prcmu_init(prcmu_timer_base);
+#ifdef CONFIG_HAVE_ARM_TWD
+	err = twd_local_timer_register(&twd_local_timer);
+	if (err)
+		pr_err("twd_local_timer_register failed %d\n", err);
+#endif
 }
 
 static void ux500_timer_reset(void)
-- 
1.7.7.1
