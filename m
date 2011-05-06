From: bryan.wu@canonical.com (Bryan Wu)
Date: Fri,  6 May 2011 16:27:04 +0800
Subject: [PATCH 1/2] arm: localtimer: remove duplicated localtimer code
Message-ID: <1304670425-26672-1-git-send-email-bryan.wu@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Create a localtimer implementation in common place which can be shared by SoC.
Remove duplicae code from Tegra, Exynos4, SH-Mobile, UX500 and Versatile.
Use weak attribute to allow machine like OMAP, MSM and Exynos4 MCT to override
this TWD based implementation.

Building test is OK with this patch.

Signed-off-by: Bryan Wu <bryan.wu@canonical.com>
---
 arch/arm/kernel/Makefile                    |    1 +
 arch/arm/kernel/localtimer.c                |   28 ++++++++++++++++++++++++++
 arch/arm/mach-exynos4/Makefile              |    1 -
 arch/arm/mach-exynos4/localtimer.c          |   26 ------------------------
 arch/arm/mach-shmobile/Makefile             |    1 -
 arch/arm/mach-shmobile/include/mach/irqs.h  |    2 +
 arch/arm/mach-shmobile/localtimer.c         |   26 ------------------------
 arch/arm/mach-tegra/Makefile                |    2 +-
 arch/arm/mach-tegra/localtimer.c            |   26 ------------------------
 arch/arm/mach-ux500/Makefile                |    1 -
 arch/arm/mach-ux500/localtimer.c            |   29 ---------------------------
 arch/arm/plat-omap/include/plat/irqs-44xx.h |    1 +
 arch/arm/plat-versatile/Makefile            |    1 -
 arch/arm/plat-versatile/localtimer.c        |   27 -------------------------
 14 files changed, 33 insertions(+), 139 deletions(-)
 create mode 100644 arch/arm/kernel/localtimer.c
 delete mode 100644 arch/arm/mach-exynos4/localtimer.c
 delete mode 100644 arch/arm/mach-shmobile/localtimer.c
 delete mode 100644 arch/arm/mach-tegra/localtimer.c
 delete mode 100644 arch/arm/mach-ux500/localtimer.c
 delete mode 100644 arch/arm/plat-versatile/localtimer.c

diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index 8d95446..60f233c 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -34,6 +34,7 @@ obj-$(CONFIG_HAVE_SCHED_CLOCK)	+= sched_clock.o
 obj-$(CONFIG_SMP)		+= smp.o smp_tlb.o
 obj-$(CONFIG_HAVE_ARM_SCU)	+= smp_scu.o
 obj-$(CONFIG_HAVE_ARM_TWD)	+= smp_twd.o
+obj-$(CONFIG_LOCAL_TIMERS)	+= localtimer.o
 obj-$(CONFIG_DYNAMIC_FTRACE)	+= ftrace.o
 obj-$(CONFIG_FUNCTION_GRAPH_TRACER)	+= ftrace.o
 obj-$(CONFIG_KEXEC)		+= machine_kexec.o relocate_kernel.o
diff --git a/arch/arm/kernel/localtimer.c b/arch/arm/kernel/localtimer.c
new file mode 100644
index 0000000..65b674b
--- /dev/null
+++ b/arch/arm/kernel/localtimer.c
@@ -0,0 +1,28 @@
+/*
+ *  arch/arm/kernel/localtimer.c
+ *
+ *  Copyright (C) 2010 Bryan Wu <bryan.wu@canonical.com>
+ *  All Rights Reserved
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/init.h>
+#include <linux/smp.h>
+#include <linux/clockchips.h>
+
+#include <asm/irq.h>
+#include <asm/smp_twd.h>
+#include <asm/localtimer.h>
+
+/*
+ * Setup the local clock events for a CPU.
+ */
+int __attribute__((weak)) __cpuinit
+local_timer_setup(struct clock_event_device *evt)
+{
+	evt->irq = IRQ_LOCALTIMER;
+	twd_timer_setup(evt);
+	return 0;
+}
diff --git a/arch/arm/mach-exynos4/Makefile b/arch/arm/mach-exynos4/Makefile
index 9be104f..21b6701 100644
--- a/arch/arm/mach-exynos4/Makefile
+++ b/arch/arm/mach-exynos4/Makefile
@@ -23,7 +23,6 @@ ifeq ($(CONFIG_EXYNOS4_MCT),y)
 obj-y				+= mct.o
 else
 obj-y				+= time.o
-obj-$(CONFIG_LOCAL_TIMERS)	+= localtimer.o
 endif
 
 obj-$(CONFIG_HOTPLUG_CPU)	+= hotplug.o
diff --git a/arch/arm/mach-exynos4/localtimer.c b/arch/arm/mach-exynos4/localtimer.c
deleted file mode 100644
index 6bf3d0a..0000000
--- a/arch/arm/mach-exynos4/localtimer.c
+++ /dev/null
@@ -1,26 +0,0 @@
-/* linux/arch/arm/mach-exynos4/localtimer.c
- *
- * Cloned from linux/arch/arm/mach-realview/localtimer.c
- *
- *  Copyright (C) 2002 ARM Ltd.
- *  All Rights Reserved
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
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
-	twd_timer_setup(evt);
-	return 0;
-}
diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index e2507f6..290a232 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -14,7 +14,6 @@ obj-$(CONFIG_ARCH_SH73A0)	+= setup-sh73a0.o clock-sh73a0.o intc-sh73a0.o
 # SMP objects
 smp-y				:= platsmp.o headsmp.o
 smp-$(CONFIG_HOTPLUG_CPU)	+= hotplug.o
-smp-$(CONFIG_LOCAL_TIMERS)	+= localtimer.o
 smp-$(CONFIG_ARCH_SH73A0)	+= smp-sh73a0.o
 
 # Pinmux setup
diff --git a/arch/arm/mach-shmobile/include/mach/irqs.h b/arch/arm/mach-shmobile/include/mach/irqs.h
index dcb714f..0383cfd 100644
--- a/arch/arm/mach-shmobile/include/mach/irqs.h
+++ b/arch/arm/mach-shmobile/include/mach/irqs.h
@@ -15,4 +15,6 @@
 #define INTCS_VECT(n, vect)	INTC_VECT((n), INTCS_VECT_BASE + (vect))
 #define intcs_evt2irq(evt)	evt2irq(INTCS_VECT_BASE + (evt))
 
+#define IRQ_LOCALTIMER		29
+
 #endif /* __ASM_MACH_IRQS_H */
diff --git a/arch/arm/mach-shmobile/localtimer.c b/arch/arm/mach-shmobile/localtimer.c
deleted file mode 100644
index ad9ccc9..0000000
--- a/arch/arm/mach-shmobile/localtimer.c
+++ /dev/null
@@ -1,26 +0,0 @@
-/*
- * SMP support for R-Mobile / SH-Mobile - local timer portion
- *
- * Copyright (C) 2010  Magnus Damm
- *
- * Based on vexpress, Copyright (C) 2002 ARM Ltd, All Rights Reserved
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#include <linux/init.h>
-#include <linux/smp.h>
-#include <linux/clockchips.h>
-#include <asm/smp_twd.h>
-#include <asm/localtimer.h>
-
-/*
- * Setup the local clock events for a CPU.
- */
-int __cpuinit local_timer_setup(struct clock_event_device *evt)
-{
-	evt->irq = 29;
-	twd_timer_setup(evt);
-	return 0;
-}
diff --git a/arch/arm/mach-tegra/Makefile b/arch/arm/mach-tegra/Makefile
index 1afe050..d7ee013 100644
--- a/arch/arm/mach-tegra/Makefile
+++ b/arch/arm/mach-tegra/Makefile
@@ -12,7 +12,7 @@ obj-$(CONFIG_ARCH_TEGRA_2x_SOC)         += clock.o
 obj-$(CONFIG_ARCH_TEGRA_2x_SOC)         += tegra2_clocks.o
 obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= tegra2_emc.o
 obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= pinmux-t2-tables.o
-obj-$(CONFIG_SMP)                       += platsmp.o localtimer.o headsmp.o
+obj-$(CONFIG_SMP)                       += platsmp.o headsmp.o
 obj-$(CONFIG_HOTPLUG_CPU)               += hotplug.o
 obj-$(CONFIG_TEGRA_SYSTEM_DMA)		+= dma.o
 obj-$(CONFIG_CPU_FREQ)                  += cpu-tegra.o
diff --git a/arch/arm/mach-tegra/localtimer.c b/arch/arm/mach-tegra/localtimer.c
deleted file mode 100644
index e91d681..0000000
--- a/arch/arm/mach-tegra/localtimer.c
+++ /dev/null
@@ -1,26 +0,0 @@
-/*
- *  arch/arm/mach-tegra/localtimer.c
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
diff --git a/arch/arm/plat-omap/include/plat/irqs-44xx.h b/arch/arm/plat-omap/include/plat/irqs-44xx.h
index 518322c..8a0eb52 100644
--- a/arch/arm/plat-omap/include/plat/irqs-44xx.h
+++ b/arch/arm/plat-omap/include/plat/irqs-44xx.h
@@ -22,6 +22,7 @@
 
 /* OMAP44XX IRQs numbers definitions */
 #define OMAP44XX_IRQ_LOCALTIMER			29
+#define IRQ_LOCALTIMER				OMAP44XX_IRQ_LOCALTIMER
 #define OMAP44XX_IRQ_LOCALWDT			30
 
 #define OMAP44XX_IRQ_GIC_START			32
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
1.7.5
