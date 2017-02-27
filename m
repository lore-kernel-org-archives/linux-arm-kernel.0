From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 27 Feb 2017 10:13:38 +0100
Subject: [PATCH] ARM: ux500: resume the second core properly
Message-ID: <20170227091338.9800-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pen hold/release scheme was copied over to Ux500 from the ARM
reference designs like most of these at the time. It is not needed
at all, and was mostly removed in commit c00def71efd9
"ARM: ux500: simplify secondary CPU boot".

However on the suspend/resume path and hot plug/unplug of CPUs,
the .cpu_die() callback was still waiting for the pen to be
released which made it spin forever and the second core never come
back online after suspend/resume.

Fix this by simply replacing the strange custom .cpu_die() with
a oneline wfi() just like e.g. the qcom platform does. This fixes
the issue and makes the second core come up properly after
suspend/resume.

As a side effect, this rids us of the completely surplus local
setup.h and hotplug.c files, and we just compile this into platsmp.c
with everything else SMP.

Cc: stable at vger.kernel.org
Fixes: c00def71efd9 ("ARM: ux500: simplify secondary CPU boot")
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ARM SoC folks: please apply this directly for fixes. The bug
has been around for a while, it is nice to have both CPUs
online after suspend/resume.
---
 arch/arm/mach-ux500/Makefile     |  3 ---
 arch/arm/mach-ux500/cpu-db8500.c |  2 --
 arch/arm/mach-ux500/hotplug.c    | 37 -------------------------------------
 arch/arm/mach-ux500/platsmp.c    |  9 +++++++--
 arch/arm/mach-ux500/setup.h      | 16 ----------------
 5 files changed, 7 insertions(+), 60 deletions(-)
 delete mode 100644 arch/arm/mach-ux500/hotplug.c
 delete mode 100644 arch/arm/mach-ux500/setup.h

diff --git a/arch/arm/mach-ux500/Makefile b/arch/arm/mach-ux500/Makefile
index c2499bff4986..a9a3453548f4 100644
--- a/arch/arm/mach-ux500/Makefile
+++ b/arch/arm/mach-ux500/Makefile
@@ -5,7 +5,4 @@
 obj-y				:= pm.o
 obj-$(CONFIG_UX500_SOC_DB8500)	+= cpu-db8500.o
 obj-$(CONFIG_SMP)		+= platsmp.o
-obj-$(CONFIG_HOTPLUG_CPU)	+= hotplug.o
 obj-$(CONFIG_PM_GENERIC_DOMAINS) += pm_domains.o
-
-CFLAGS_hotplug.o		+= -march=armv7-a
diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
index 24529cf58df6..28083ef72819 100644
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -31,8 +31,6 @@
 #include <asm/mach/map.h>
 #include <asm/mach/arch.h>
 
-#include "setup.h"
-
 #include "db8500-regs.h"
 
 static int __init ux500_l2x0_unlock(void)
diff --git a/arch/arm/mach-ux500/hotplug.c b/arch/arm/mach-ux500/hotplug.c
deleted file mode 100644
index 1cbed0331fd3..000000000000
--- a/arch/arm/mach-ux500/hotplug.c
+++ /dev/null
@@ -1,37 +0,0 @@
-/*
- * Copyright (C) STMicroelectronics 2009
- * Copyright (C) ST-Ericsson SA 2010
- *
- * License Terms: GNU General Public License v2
- *	Based on ARM realview platform
- *
- * Author: Sundar Iyer <sundar.iyer@stericsson.com>
- *
- */
-#include <linux/kernel.h>
-#include <linux/errno.h>
-#include <linux/smp.h>
-
-#include <asm/smp_plat.h>
-
-#include "setup.h"
-
-/*
- * platform-specific code to shutdown a CPU
- *
- * Called with IRQs disabled
- */
-void ux500_cpu_die(unsigned int cpu)
-{
-	/* directly enter low power state, skipping secure registers */
-	for (;;) {
-		__asm__ __volatile__("dsb\n\t" "wfi\n\t"
-				: : : "memory");
-		if (pen_release == cpu_logical_map(cpu)) {
-			/*
-			 * OK, proper wakeup, we're done
-			 */
-			break;
-		}
-	}
-}
diff --git a/arch/arm/mach-ux500/platsmp.c b/arch/arm/mach-ux500/platsmp.c
index e0ee139fdebf..19c165aeecd2 100644
--- a/arch/arm/mach-ux500/platsmp.c
+++ b/arch/arm/mach-ux500/platsmp.c
@@ -23,8 +23,6 @@
 #include <asm/smp_plat.h>
 #include <asm/smp_scu.h>
 
-#include "setup.h"
-
 #include "db8500-regs.h"
 
 /* Magic triggers in backup RAM */
@@ -90,6 +88,13 @@ static int ux500_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	return 0;
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
+void ux500_cpu_die(unsigned int cpu)
+{
+	wfi();
+}
+#endif
+
 static const struct smp_operations ux500_smp_ops __initconst = {
 	.smp_prepare_cpus	= ux500_smp_prepare_cpus,
 	.smp_boot_secondary	= ux500_boot_secondary,
diff --git a/arch/arm/mach-ux500/setup.h b/arch/arm/mach-ux500/setup.h
deleted file mode 100644
index 988e7c77068d..000000000000
--- a/arch/arm/mach-ux500/setup.h
+++ /dev/null
@@ -1,16 +0,0 @@
-/*
- * Copyright (C) 2009 ST-Ericsson.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * These symbols are needed for board-specific files to call their
- * own cpu-specific files
- */
-#ifndef __ASM_ARCH_SETUP_H
-#define __ASM_ARCH_SETUP_H
-
-extern void ux500_cpu_die(unsigned int cpu);
-
-#endif /*  __ASM_ARCH_SETUP_H */
-- 
2.9.3
