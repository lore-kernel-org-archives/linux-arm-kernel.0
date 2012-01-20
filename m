From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 20 Jan 2012 12:03:53 +0000
Subject: [PATCH v4 06/15] ARM: plat-versatile: convert to
 twd_local_timer_register() interface
In-Reply-To: <1327061042-14857-1-git-send-email-marc.zyngier@arm.com>
References: <1327061042-14857-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1327061042-14857-7-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the new smp_twd runtime registration interface
to the RealView/VE platforms, and remove the old compile-time support.
Tested on EB11MP.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-realview/realview_eb.c     |   27 +++++++++++++++++++++------
 arch/arm/mach-realview/realview_pb11mp.c |   21 +++++++++++++++++----
 arch/arm/mach-realview/realview_pbx.c    |   20 ++++++++++++++++----
 arch/arm/mach-vexpress/ct-ca9x4.c        |   17 ++++++++++++++---
 arch/arm/plat-versatile/Makefile         |    1 -
 arch/arm/plat-versatile/localtimer.c     |   27 ---------------------------
 6 files changed, 68 insertions(+), 45 deletions(-)
 delete mode 100644 arch/arm/plat-versatile/localtimer.c

diff --git a/arch/arm/mach-realview/realview_eb.c b/arch/arm/mach-realview/realview_eb.c
index e629621..9ae8a8c 100644
--- a/arch/arm/mach-realview/realview_eb.c
+++ b/arch/arm/mach-realview/realview_eb.c
@@ -36,7 +36,7 @@
 #include <asm/pgtable.h>
 #include <asm/hardware/gic.h>
 #include <asm/hardware/cache-l2x0.h>
-#include <asm/localtimer.h>
+#include <asm/smp_twd.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -388,6 +388,23 @@ static void realview_eb11mp_fixup(void)
 	realview_eb_isp1761_resources[1].end	= IRQ_EB11MP_USB;
 }
 
+#ifdef CONFIG_HAVE_ARM_TWD
+static DEFINE_TWD_LOCAL_TIMER(twd_local_timer,
+			      REALVIEW_EB11MP_TWD_BASE,
+			      IRQ_LOCALTIMER);
+
+static void __init realview_eb_twd_init(void)
+{
+	if (core_tile_eb11mp() || core_tile_a9mp()) {
+		int err = twd_local_timer_register(&twd_local_timer);
+		if (err)
+			pr_err("twd_local_timer_register failed %d\n", err);
+	}
+}
+#else
+#define realview_eb_twd_init()	do { } while(0)
+#endif
+
 static void __init realview_eb_timer_init(void)
 {
 	unsigned int timer_irq;
@@ -397,15 +414,13 @@ static void __init realview_eb_timer_init(void)
 	timer2_va_base = __io_address(REALVIEW_EB_TIMER2_3_BASE);
 	timer3_va_base = __io_address(REALVIEW_EB_TIMER2_3_BASE) + 0x20;
 
-	if (core_tile_eb11mp() || core_tile_a9mp()) {
-#ifdef CONFIG_LOCAL_TIMERS
-		twd_base = __io_address(REALVIEW_EB11MP_TWD_BASE);
-#endif
+	if (core_tile_eb11mp() || core_tile_a9mp())
 		timer_irq = IRQ_EB11MP_TIMER0_1;
-	} else
+	else
 		timer_irq = IRQ_EB_TIMER0_1;
 
 	realview_timer_init(timer_irq);
+	realview_eb_twd_init();
 }
 
 static struct sys_timer realview_eb_timer = {
diff --git a/arch/arm/mach-realview/realview_pb11mp.c b/arch/arm/mach-realview/realview_pb11mp.c
index 127a3fd..fb08361 100644
--- a/arch/arm/mach-realview/realview_pb11mp.c
+++ b/arch/arm/mach-realview/realview_pb11mp.c
@@ -36,7 +36,7 @@
 #include <asm/pgtable.h>
 #include <asm/hardware/gic.h>
 #include <asm/hardware/cache-l2x0.h>
-#include <asm/localtimer.h>
+#include <asm/smp_twd.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/flash.h>
@@ -295,6 +295,21 @@ static void __init gic_init_irq(void)
 	gic_cascade_irq(1, IRQ_TC11MP_PB_IRQ1);
 }
 
+#ifdef CONFIG_HAVE_ARM_TWD
+static DEFINE_TWD_LOCAL_TIMER(twd_local_timer,
+			      REALVIEW_TC11MP_TWD_BASE,
+			      IRQ_LOCALTIMER);
+
+static void __init realview_pb11mp_twd_init(void)
+{
+	int err = twd_local_timer_register(&twd_local_timer);
+	if (err)
+		pr_err("twd_local_timer_register failed %d\n", err);
+}
+#else
+#define realview_pb11mp_twd_init()	do {} while(0)
+#endif
+
 static void __init realview_pb11mp_timer_init(void)
 {
 	timer0_va_base = __io_address(REALVIEW_PB11MP_TIMER0_1_BASE);
@@ -302,10 +317,8 @@ static void __init realview_pb11mp_timer_init(void)
 	timer2_va_base = __io_address(REALVIEW_PB11MP_TIMER2_3_BASE);
 	timer3_va_base = __io_address(REALVIEW_PB11MP_TIMER2_3_BASE) + 0x20;
 
-#ifdef CONFIG_LOCAL_TIMERS
-	twd_base = __io_address(REALVIEW_TC11MP_TWD_BASE);
-#endif
 	realview_timer_init(IRQ_TC11MP_TIMER0_1);
+	realview_pb11mp_twd_init();
 }
 
 static struct sys_timer realview_pb11mp_timer = {
diff --git a/arch/arm/mach-realview/realview_pbx.c b/arch/arm/mach-realview/realview_pbx.c
index ac71564..6ddcc61 100644
--- a/arch/arm/mach-realview/realview_pbx.c
+++ b/arch/arm/mach-realview/realview_pbx.c
@@ -298,6 +298,21 @@ static void __init gic_init_irq(void)
 	}
 }
 
+#ifdef CONFIG_HAVE_ARM_TWD
+static DEFINE_TWD_LOCAL_TIMER(twd_local_timer,
+			      REALVIEW_PBX_TILE_TWD_BASE,
+			      IRQ_LOCALTIMER);
+
+static void __init realview_pbx_twd_init(void)
+{
+	int err = twd_local_timer_register(&twd_local_timer);
+	if (err)
+		pr_err("twd_local_timer_register failed %d\n", err);
+}
+#else
+#define realview_pbx_twd_init()	do { } while(0)
+#endif
+
 static void __init realview_pbx_timer_init(void)
 {
 	timer0_va_base = __io_address(REALVIEW_PBX_TIMER0_1_BASE);
@@ -305,11 +320,8 @@ static void __init realview_pbx_timer_init(void)
 	timer2_va_base = __io_address(REALVIEW_PBX_TIMER2_3_BASE);
 	timer3_va_base = __io_address(REALVIEW_PBX_TIMER2_3_BASE) + 0x20;
 
-#ifdef CONFIG_LOCAL_TIMERS
-	if (core_tile_pbx11mp() || core_tile_pbxa9mp())
-		twd_base = __io_address(REALVIEW_PBX_TILE_TWD_BASE);
-#endif
 	realview_timer_init(IRQ_PBX_TIMER0_1);
+	realview_pbx_twd_init();
 }
 
 static struct sys_timer realview_pbx_timer = {
diff --git a/arch/arm/mach-vexpress/ct-ca9x4.c b/arch/arm/mach-vexpress/ct-ca9x4.c
index 2b1e836..dda84f9 100644
--- a/arch/arm/mach-vexpress/ct-ca9x4.c
+++ b/arch/arm/mach-vexpress/ct-ca9x4.c
@@ -53,16 +53,27 @@ static struct map_desc ct_ca9x4_io_desc[] __initdata = {
 
 static void __init ct_ca9x4_map_io(void)
 {
-#ifdef CONFIG_LOCAL_TIMERS
-	twd_base = MMIO_P2V(A9_MPCORE_TWD);
-#endif
 	iotable_init(ct_ca9x4_io_desc, ARRAY_SIZE(ct_ca9x4_io_desc));
 }
 
+#ifdef CONFIG_HAVE_ARM_TWD
+static DEFINE_TWD_LOCAL_TIMER(twd_local_timer, A9_MPCORE_TWD, IRQ_LOCALTIMER);
+
+static void __init ca9x4_twd_init(void)
+{
+	int err = twd_local_timer_register(&twd_local_timer);
+	if (err)
+		pr_err("twd_local_timer_register failed %d\n", err);
+}
+#else
+#define ca9x4_twd_init()	do {} while(0)
+#endif
+
 static void __init ct_ca9x4_init_irq(void)
 {
 	gic_init(0, 29, MMIO_P2V(A9_MPCORE_GIC_DIST),
 		 MMIO_P2V(A9_MPCORE_GIC_CPU));
+	ca9x4_twd_init();
 }
 
 #if 0
diff --git a/arch/arm/plat-versatile/Makefile b/arch/arm/plat-versatile/Makefile
index 69714db..a5cb194 100644
--- a/arch/arm/plat-versatile/Makefile
+++ b/arch/arm/plat-versatile/Makefile
@@ -1,5 +1,4 @@
 obj-y	:= clock.o
-obj-$(CONFIG_LOCAL_TIMERS) += localtimer.o
 obj-$(CONFIG_PLAT_VERSATILE_CLCD) += clcd.o
 obj-$(CONFIG_PLAT_VERSATILE_FPGA_IRQ) += fpga-irq.o
 obj-$(CONFIG_PLAT_VERSATILE_LEDS) += leds.o
diff --git a/arch/arm/plat-versatile/localtimer.c b/arch/arm/plat-versatile/localtimer.c
deleted file mode 100644
index 0fb3961..0000000
--- a/arch/arm/plat-versatile/localtimer.c
+++ /dev/null
@@ -1,27 +0,0 @@
-/*
- *  linux/arch/arm/plat-versatile/localtimer.c
- *
- *  Copyright (C) 2002 ARM Ltd.
- *  All Rights Reserved
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#include <linux/init.h>
-#include <linux/smp.h>
-#include <linux/clockchips.h>
-
-#include <asm/smp_twd.h>
-#include <asm/localtimer.h>
-#include <mach/irqs.h>
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
1.7.7.1
