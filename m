From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 15 Mar 2011 15:13:01 +0000
Subject: [RFC PATCHv2 18/20] ARM: ux500: dynamically register local timer
	setup function
In-Reply-To: <1300201983-26124-1-git-send-email-marc.zyngier@arm.com>
References: <1300201983-26124-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1300201983-26124-19-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
Cc: Linus Walleij <linus.walleij@stericsson.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-ux500/Makefile     |    1 -
 arch/arm/mach-ux500/cpu.c        |   13 +++++++++++++
 arch/arm/mach-ux500/localtimer.c |   26 --------------------------
 3 files changed, 13 insertions(+), 27 deletions(-)
 delete mode 100644 arch/arm/mach-ux500/localtimer.c

diff --git a/arch/arm/mach-ux500/Makefile b/arch/arm/mach-ux500/Makefile
index b549a8f..224bc74 100644
--- a/arch/arm/mach-ux500/Makefile
+++ b/arch/arm/mach-ux500/Makefile
@@ -14,7 +14,6 @@ obj-$(CONFIG_MACH_U8500)	+= board-mop500.o board-mop500-sdi.o \
 obj-$(CONFIG_MACH_U5500)	+= board-u5500.o board-u5500-sdi.o
 obj-$(CONFIG_SMP)		+= platsmp.o headsmp.o
 obj-$(CONFIG_HOTPLUG_CPU)	+= hotplug.o
-obj-$(CONFIG_LOCAL_TIMERS)	+= localtimer.o
 obj-$(CONFIG_U5500_MODEM_IRQ)	+= modem-irq-db5500.o
 obj-$(CONFIG_U5500_MBOX)	+= mbox-db5500.o
 obj-$(CONFIG_CPU_FREQ)		+= cpufreq.o
diff --git a/arch/arm/mach-ux500/cpu.c b/arch/arm/mach-ux500/cpu.c
index 5a43107..e4b1bb6 100644
--- a/arch/arm/mach-ux500/cpu.c
+++ b/arch/arm/mach-ux500/cpu.c
@@ -8,12 +8,15 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/clk.h>
+#include <linux/clockchips.h>
 
 #include <asm/cacheflush.h>
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/hardware/gic.h>
 #include <asm/mach/map.h>
+#include <asm/irq.h>
 #include <asm/localtimer.h>
+#include <asm/smp_twd.h>
 
 #include <plat/mtu.h>
 #include <mach/hardware.h>
@@ -115,6 +118,14 @@ static int ux500_l2x0_init(void)
 early_initcall(ux500_l2x0_init);
 #endif
 
+#ifdef CONFIG_LOCAL_TIMERS
+static int __cpuinit ux500_local_timer_setup(struct clock_event_device *evt)
+{
+	evt->irq = IRQ_LOCALTIMER;
+	return 0;
+}
+#endif
+
 static void __init ux500_timer_init(void)
 {
 #ifdef CONFIG_LOCAL_TIMERS
@@ -125,6 +136,8 @@ static void __init ux500_timer_init(void)
 		twd_base = __io_address(U8500_TWD_BASE);
 	else
 		ux500_unknown_soc();
+
+	twd_timer_register_setup(ux500_local_timer_setup);
 #endif
 	if (cpu_is_u5500())
 		mtu_base = __io_address(U5500_MTU0_BASE);
diff --git a/arch/arm/mach-ux500/localtimer.c b/arch/arm/mach-ux500/localtimer.c
deleted file mode 100644
index c648725..0000000
--- a/arch/arm/mach-ux500/localtimer.c
+++ /dev/null
@@ -1,26 +0,0 @@
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
-- 
1.7.0.4
