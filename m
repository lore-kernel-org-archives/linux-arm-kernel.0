From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 31 Jul 2015 15:14:30 +0200
Subject: [PATCH] ARM/clocksource: use automatic DT probing
Message-ID: <1438348470-6656-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ARM core kernel already calls clocksource_of_init() so why
go to all the trouble of locating and probing this node in the
machine. CLOCKSOURCE_OF_DECLARE() will take care of it in the
clocksource driver, and thus we can also get rid of the
dangling header file <linux/clksrc-dbx500-prcmu.h>

Suggested-by: Arnd Bergmann <arndb@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Clocksource maintainers: please ACK this so I can take it through
ARM SoC with a bunch of other cleanups.
---
 arch/arm/mach-ux500/Makefile              |  2 +-
 arch/arm/mach-ux500/cpu-db8500.c          |  2 --
 arch/arm/mach-ux500/cpu.c                 |  1 -
 arch/arm/mach-ux500/setup.h               |  3 --
 arch/arm/mach-ux500/timer.c               | 48 -------------------------------
 drivers/clocksource/clksrc-dbx500-prcmu.c |  9 ++++--
 include/linux/clksrc-dbx500-prcmu.h       | 20 -------------
 7 files changed, 7 insertions(+), 78 deletions(-)
 delete mode 100644 arch/arm/mach-ux500/timer.c
 delete mode 100644 include/linux/clksrc-dbx500-prcmu.h

diff --git a/arch/arm/mach-ux500/Makefile b/arch/arm/mach-ux500/Makefile
index c8643ac5db71..edfff1ae1f8d 100644
--- a/arch/arm/mach-ux500/Makefile
+++ b/arch/arm/mach-ux500/Makefile
@@ -2,7 +2,7 @@
 # Makefile for the linux kernel, U8500 machine.
 #
 
-obj-y				:= cpu.o id.o timer.o pm.o
+obj-y				:= cpu.o id.o pm.o
 obj-$(CONFIG_CACHE_L2X0)	+= cache-l2x0.o
 obj-$(CONFIG_UX500_SOC_DB8500)	+= cpu-db8500.o
 obj-$(CONFIG_MACH_MOP500)	+= board-mop500-regulators.o \
diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
index ba708ce08616..59675d809080 100644
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -156,8 +156,6 @@ static const char * stericsson_dt_platform_compat[] = {
 DT_MACHINE_START(U8500_DT, "ST-Ericsson Ux5x0 platform (Device Tree Support)")
 	.map_io		= u8500_map_io,
 	.init_irq	= ux500_init_irq,
-	/* we re-use nomadik timer here */
-	.init_time	= ux500_timer_init,
 	.init_machine	= u8500_init_machine,
 	.init_late	= NULL,
 	.dt_compat      = stericsson_dt_platform_compat,
diff --git a/arch/arm/mach-ux500/cpu.c b/arch/arm/mach-ux500/cpu.c
index b316e18a76aa..9c49922414c2 100644
--- a/arch/arm/mach-ux500/cpu.c
+++ b/arch/arm/mach-ux500/cpu.c
@@ -9,7 +9,6 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/mfd/dbx500-prcmu.h>
-#include <linux/clksrc-dbx500-prcmu.h>
 #include <linux/sys_soc.h>
 #include <linux/err.h>
 #include <linux/slab.h>
diff --git a/arch/arm/mach-ux500/setup.h b/arch/arm/mach-ux500/setup.h
index 65876eac0761..c704254ab67c 100644
--- a/arch/arm/mach-ux500/setup.h
+++ b/arch/arm/mach-ux500/setup.h
@@ -12,7 +12,6 @@
 #define __ASM_ARCH_SETUP_H
 
 #include <asm/mach/arch.h>
-#include <asm/mach/time.h>
 #include <linux/init.h>
 #include <linux/mfd/abx500/ab8500.h>
 
@@ -24,8 +23,6 @@ extern void __init ux500_init_irq(void);
 
 extern struct device *ux500_soc_device_init(const char *soc_id);
 
-extern void ux500_timer_init(void);
-
 extern void ux500_cpu_die(unsigned int cpu);
 
 #endif /*  __ASM_ARCH_SETUP_H */
diff --git a/arch/arm/mach-ux500/timer.c b/arch/arm/mach-ux500/timer.c
deleted file mode 100644
index ff28d8ad1ed7..000000000000
--- a/arch/arm/mach-ux500/timer.c
+++ /dev/null
@@ -1,48 +0,0 @@
-/*
- * Copyright (C) ST-Ericsson SA 2011
- *
- * License Terms: GNU General Public License v2
- * Author: Mattias Wallin <mattias.wallin@stericsson.com> for ST-Ericsson
- */
-#include <linux/io.h>
-#include <linux/errno.h>
-#include <linux/clksrc-dbx500-prcmu.h>
-#include <linux/clocksource.h>
-#include <linux/of.h>
-#include <linux/of_address.h>
-
-#include "setup.h"
-
-#include "db8500-regs.h"
-#include "id.h"
-
-static const struct of_device_id prcmu_timer_of_match[] __initconst = {
-	{ .compatible = "stericsson,db8500-prcmu-timer-4", },
-	{ },
-};
-
-void __init ux500_timer_init(void)
-{
-	void __iomem *prcmu_timer_base;
-	void __iomem *tmp_base;
-	struct device_node *np;
-
-	if (cpu_is_u8500_family() || cpu_is_ux540_family())
-		prcmu_timer_base = __io_address(U8500_PRCMU_TIMER_4_BASE);
-	else
-		ux500_unknown_soc();
-
-	np = of_find_matching_node(NULL, prcmu_timer_of_match);
-	if (!np)
-		goto dt_fail;
-
-	tmp_base = of_iomap(np, 0);
-	if (!tmp_base)
-		goto dt_fail;
-
-	prcmu_timer_base = tmp_base;
-
-dt_fail:
-	clksrc_dbx500_prcmu_init(prcmu_timer_base);
-	clocksource_of_init();
-}
diff --git a/drivers/clocksource/clksrc-dbx500-prcmu.c b/drivers/clocksource/clksrc-dbx500-prcmu.c
index b375106844d8..dfad6eb99662 100644
--- a/drivers/clocksource/clksrc-dbx500-prcmu.c
+++ b/drivers/clocksource/clksrc-dbx500-prcmu.c
@@ -12,8 +12,9 @@
  * power domain.  We use the Timer 4 for our always-on clock
  * source on DB8500.
  */
+#include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/clockchips.h>
-#include <linux/clksrc-dbx500-prcmu.h>
 #include <linux/sched_clock.h>
 
 #define RATE_32K		32768
@@ -63,9 +64,9 @@ static u64 notrace dbx500_prcmu_sched_clock_read(void)
 
 #endif
 
-void __init clksrc_dbx500_prcmu_init(void __iomem *base)
+static void __init clksrc_dbx500_prcmu_init(struct device_node *node)
 {
-	clksrc_dbx500_timer_base = base;
+	clksrc_dbx500_timer_base = of_iomap(node, 0);
 
 	/*
 	 * The A9 sub system expects the timer to be configured as
@@ -85,3 +86,5 @@ void __init clksrc_dbx500_prcmu_init(void __iomem *base)
 #endif
 	clocksource_register_hz(&clocksource_dbx500_prcmu, RATE_32K);
 }
+CLOCKSOURCE_OF_DECLARE(dbx500_prcmu, "stericsson,db8500-prcmu-timer-4",
+		       clksrc_dbx500_prcmu_init);
diff --git a/include/linux/clksrc-dbx500-prcmu.h b/include/linux/clksrc-dbx500-prcmu.h
deleted file mode 100644
index 4fb8119c49e4..000000000000
--- a/include/linux/clksrc-dbx500-prcmu.h
+++ /dev/null
@@ -1,20 +0,0 @@
-/*
- * Copyright (C) ST-Ericsson SA 2011
- *
- * License Terms: GNU General Public License v2
- * Author: Mattias Wallin <mattias.wallin@stericsson.com>
- *
- */
-#ifndef __CLKSRC_DBX500_PRCMU_H
-#define __CLKSRC_DBX500_PRCMU_H
-
-#include <linux/init.h>
-#include <linux/io.h>
-
-#ifdef CONFIG_CLKSRC_DBX500_PRCMU
-void __init clksrc_dbx500_prcmu_init(void __iomem *base);
-#else
-static inline void __init clksrc_dbx500_prcmu_init(void __iomem *base) {}
-#endif
-
-#endif
-- 
2.4.3
