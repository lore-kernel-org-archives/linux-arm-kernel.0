From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri,  3 Jun 2011 15:57:31 +0100
Subject: [PATCH v1 16/18] ARM: ux500: dynamically register local timer setup
	function
In-Reply-To: <1307113053-30209-1-git-send-email-marc.zyngier@arm.com>
References: <1307113053-30209-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1307113053-30209-17-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
Cc: Linus Walleij <linus.walleij@stericsson.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-ux500/Makefile     |    1 -
 arch/arm/mach-ux500/cpu.c        |   14 ++++++++++++++
 arch/arm/mach-ux500/localtimer.c |   27 ---------------------------
 3 files changed, 14 insertions(+), 28 deletions(-)
 delete mode 100644 arch/arm/mach-ux500/localtimer.c

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
index 1da23bb..64e2aae 100644
--- a/arch/arm/mach-ux500/cpu.c
+++ b/arch/arm/mach-ux500/cpu.c
@@ -8,6 +8,7 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/clk.h>
+#include <linux/clockchips.h>
 #include <linux/mfd/db8500-prcmu.h>
 #include <linux/mfd/db5500-prcmu.h>
 
@@ -15,7 +16,10 @@
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/hardware/gic.h>
 #include <asm/mach/map.h>
+#include <asm/irq.h>
 #include <asm/localtimer.h>
+#include <asm/smp_twd.h>
+#include <asm/hardware/gic.h>
 
 #include <plat/mtu.h>
 #include <mach/hardware.h>
@@ -120,6 +124,14 @@ static int ux500_l2x0_init(void)
 early_initcall(ux500_l2x0_init);
 #endif
 
+#ifdef CONFIG_LOCAL_TIMERS
+static int __cpuinit ux500_local_timer_setup(struct clock_event_device *evt)
+{
+	evt->irq = gic_ppi_to_vppi(IRQ_LOCALTIMER);
+	return 0;
+}
+#endif
+
 static void __init ux500_timer_init(void)
 {
 #ifdef CONFIG_LOCAL_TIMERS
@@ -130,6 +142,8 @@ static void __init ux500_timer_init(void)
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
index 2697f4e..0000000
--- a/arch/arm/mach-ux500/localtimer.c
+++ /dev/null
@@ -1,27 +0,0 @@
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
-- 
1.7.0.4
