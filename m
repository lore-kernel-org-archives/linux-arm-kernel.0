From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 10 Oct 2011 15:02:19 +0100
Subject: [PATCH v5 07/10] ARM: SoC: convert MSM SMP to SoC descriptor
In-Reply-To: <1318255342-17451-1-git-send-email-marc.zyngier@arm.com>
References: <1318255342-17451-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1318255342-17451-8-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert MSM SMP platforms to use the SoC descriptor to provide
their SMP and CPU hotplug operations.

Cc: David Brown <davidb@codeaurora.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-msm/Makefile        |    2 +-
 arch/arm/mach-msm/board-msm8960.c |    3 +++
 arch/arm/mach-msm/board-msm8x60.c |    7 +++++++
 arch/arm/mach-msm/core.c          |   17 +++++++++++++++++
 arch/arm/mach-msm/core.h          |    9 +++++++++
 arch/arm/mach-msm/hotplug.c       |    8 +++++---
 arch/arm/mach-msm/platsmp.c       |   24 ++++++++++++++++++++----
 7 files changed, 62 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm/mach-msm/core.c
 create mode 100644 arch/arm/mach-msm/core.h

diff --git a/arch/arm/mach-msm/Makefile b/arch/arm/mach-msm/Makefile
index 4ad3969..cba9355 100644
--- a/arch/arm/mach-msm/Makefile
+++ b/arch/arm/mach-msm/Makefile
@@ -1,5 +1,5 @@
 obj-y += io.o idle.o timer.o
-obj-y += clock.o
+obj-y += clock.o core.o
 obj-$(CONFIG_DEBUG_FS) += clock-debug.o
 
 obj-$(CONFIG_MSM_VIC) += irq-vic.o
diff --git a/arch/arm/mach-msm/board-msm8960.c b/arch/arm/mach-msm/board-msm8960.c
index b04468e..c811e29 100644
--- a/arch/arm/mach-msm/board-msm8960.c
+++ b/arch/arm/mach-msm/board-msm8960.c
@@ -30,6 +30,7 @@
 #include <mach/board.h>
 #include <mach/msm_iomap.h>
 
+#include "core.h"
 #include "devices.h"
 
 static void __init msm8960_fixup(struct machine_desc *desc, struct tag *tag,
@@ -94,6 +95,7 @@ static void __init msm8960_rumi3_init(void)
 }
 
 MACHINE_START(MSM8960_SIM, "QCT MSM8960 SIMULATOR")
+	.soc = &msm_soc_desc,
 	.fixup = msm8960_fixup,
 	.reserve = msm8960_reserve,
 	.map_io = msm8960_map_io,
@@ -103,6 +105,7 @@ MACHINE_START(MSM8960_SIM, "QCT MSM8960 SIMULATOR")
 MACHINE_END
 
 MACHINE_START(MSM8960_RUMI3, "QCT MSM8960 RUMI3")
+	.soc = &msm_soc_desc,
 	.fixup = msm8960_fixup,
 	.reserve = msm8960_reserve,
 	.map_io = msm8960_map_io,
diff --git a/arch/arm/mach-msm/board-msm8x60.c b/arch/arm/mach-msm/board-msm8x60.c
index 4ad2afb..a4bd858 100644
--- a/arch/arm/mach-msm/board-msm8x60.c
+++ b/arch/arm/mach-msm/board-msm8x60.c
@@ -28,6 +28,8 @@
 #include <mach/board.h>
 #include <mach/msm_iomap.h>
 
+#include "core.h"
+
 static void __init msm8x60_fixup(struct machine_desc *desc, struct tag *tag,
 			 char **cmdline, struct meminfo *mi)
 {
@@ -115,6 +117,7 @@ static const char *msm8x60_fluid_match[] __initdata = {
 #endif /* CONFIG_OF */
 
 MACHINE_START(MSM8X60_RUMI3, "QCT MSM8X60 RUMI3")
+	.soc = &msm_soc_desc,
 	.fixup = msm8x60_fixup,
 	.reserve = msm8x60_reserve,
 	.map_io = msm8x60_map_io,
@@ -124,6 +127,7 @@ MACHINE_START(MSM8X60_RUMI3, "QCT MSM8X60 RUMI3")
 MACHINE_END
 
 MACHINE_START(MSM8X60_SURF, "QCT MSM8X60 SURF")
+	.soc = &msm_soc_desc,
 	.fixup = msm8x60_fixup,
 	.reserve = msm8x60_reserve,
 	.map_io = msm8x60_map_io,
@@ -133,6 +137,7 @@ MACHINE_START(MSM8X60_SURF, "QCT MSM8X60 SURF")
 MACHINE_END
 
 MACHINE_START(MSM8X60_SIM, "QCT MSM8X60 SIMULATOR")
+	.soc = &msm_soc_desc,
 	.fixup = msm8x60_fixup,
 	.reserve = msm8x60_reserve,
 	.map_io = msm8x60_map_io,
@@ -142,6 +147,7 @@ MACHINE_START(MSM8X60_SIM, "QCT MSM8X60 SIMULATOR")
 MACHINE_END
 
 MACHINE_START(MSM8X60_FFA, "QCT MSM8X60 FFA")
+	.soc = &msm_soc_desc,
 	.fixup = msm8x60_fixup,
 	.reserve = msm8x60_reserve,
 	.map_io = msm8x60_map_io,
@@ -153,6 +159,7 @@ MACHINE_END
 #ifdef CONFIG_OF
 /* TODO: General device tree support for all MSM. */
 DT_MACHINE_START(MSM_DT, "Qualcomm MSM (Flattened Device Tree)")
+	.soc = &msm_soc_desc,
 	.fixup = msm8x60_fixup,
 	.reserve = msm8x60_reserve,
 	.map_io = msm8x60_map_io,
diff --git a/arch/arm/mach-msm/core.c b/arch/arm/mach-msm/core.c
new file mode 100644
index 0000000..390cde7
--- /dev/null
+++ b/arch/arm/mach-msm/core.c
@@ -0,0 +1,17 @@
+/*
+ *  Copyright (C) 2011 ARM Ltd.
+ *  All Rights Reserved
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/init.h>
+#include "core.h"
+
+struct arm_soc_desc msm_soc_desc __initdata = {
+	.name		= "Qualcomm MSM",
+	soc_smp_init_ops(msm_soc_smp_init_ops)
+	soc_smp_ops(msm_soc_smp_ops)
+};
diff --git a/arch/arm/mach-msm/core.h b/arch/arm/mach-msm/core.h
new file mode 100644
index 0000000..e8394dd
--- /dev/null
+++ b/arch/arm/mach-msm/core.h
@@ -0,0 +1,9 @@
+#include <asm/soc.h>
+
+extern struct arm_soc_smp_init_ops	msm_soc_smp_init_ops;
+extern struct arm_soc_smp_ops		msm_soc_smp_ops;
+extern struct arm_soc_desc		msm_soc_desc;
+
+extern int  msm_cpu_kill(unsigned int cpu);
+extern void msm_cpu_die(unsigned int cpu);
+extern int  msm_cpu_disable(unsigned int cpu);
diff --git a/arch/arm/mach-msm/hotplug.c b/arch/arm/mach-msm/hotplug.c
index 41c252d..eef1b30 100644
--- a/arch/arm/mach-msm/hotplug.c
+++ b/arch/arm/mach-msm/hotplug.c
@@ -12,6 +12,8 @@
 
 #include <asm/cacheflush.h>
 
+#include "core.h"
+
 extern volatile int pen_release;
 
 static inline void cpu_enter_lowpower(void)
@@ -56,7 +58,7 @@ static inline void platform_do_lowpower(unsigned int cpu)
 	}
 }
 
-int platform_cpu_kill(unsigned int cpu)
+int msm_cpu_kill(unsigned int cpu)
 {
 	return 1;
 }
@@ -66,7 +68,7 @@ int platform_cpu_kill(unsigned int cpu)
  *
  * Called with IRQs disabled
  */
-void platform_cpu_die(unsigned int cpu)
+void msm_cpu_die(unsigned int cpu)
 {
 	/*
 	 * we're ready for shutdown now, so do it
@@ -81,7 +83,7 @@ void platform_cpu_die(unsigned int cpu)
 	cpu_leave_lowpower();
 }
 
-int platform_cpu_disable(unsigned int cpu)
+int msm_cpu_disable(unsigned int cpu)
 {
 	/*
 	 * we don't allow CPU 0 to be shutdown (it is still too special
diff --git a/arch/arm/mach-msm/platsmp.c b/arch/arm/mach-msm/platsmp.c
index e3375ee..4902c16 100644
--- a/arch/arm/mach-msm/platsmp.c
+++ b/arch/arm/mach-msm/platsmp.c
@@ -24,6 +24,7 @@
 #include <mach/msm_iomap.h>
 
 #include "scm-boot.h"
+#include "core.h"
 
 #define VDD_SC1_ARRAY_CLAMP_GFS_CTL 0x15A0
 #define SCSS_CPU1CORE_RESET 0xD80
@@ -47,7 +48,7 @@ static inline int get_core_count(void)
 	return ((read_cpuid_id() >> 4) & 3) + 1;
 }
 
-void __cpuinit platform_secondary_init(unsigned int cpu)
+static void __cpuinit msm_secondary_init(unsigned int cpu)
 {
 	/* Configure edge-triggered PPIs */
 	writel(GIC_PPI_EDGE_MASK, MSM_QGIC_DIST_BASE + GIC_DIST_CONFIG + 4);
@@ -92,7 +93,7 @@ static __cpuinit void prepare_cold_cpu(unsigned int cpu)
 				  "address\n");
 }
 
-int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
+static int __cpuinit msm_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
 	unsigned long timeout;
 	static int cold_boot_done;
@@ -152,7 +153,7 @@ int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
  * does not support the ARM SCU, so just set the possible cpu mask to
  * NR_CPUS.
  */
-void __init smp_init_cpus(void)
+static void __init msm_smp_init_cpus(void)
 {
 	unsigned int i, ncores = get_core_count();
 
@@ -162,6 +163,21 @@ void __init smp_init_cpus(void)
         set_smp_cross_call(gic_raise_softirq);
 }
 
-void __init platform_smp_prepare_cpus(unsigned int max_cpus)
+static void __init msm_smp_prepare_cpus(unsigned int max_cpus)
 {
 }
+
+struct arm_soc_smp_init_ops msm_soc_smp_init_ops __initdata = {
+	.smp_init_cpus		= msm_smp_init_cpus,
+	.smp_prepare_cpus	= msm_smp_prepare_cpus,
+};
+
+struct arm_soc_smp_ops msm_soc_smp_ops __initdata = {
+	.smp_secondary_init	= msm_secondary_init,
+	.smp_boot_secondary	= msm_boot_secondary,
+#ifdef CONFIG_HOTPLUG_CPU
+	.cpu_kill		= msm_cpu_kill,
+	.cpu_die		= msm_cpu_die,
+	.cpu_disable		= msm_cpu_disable,
+#endif
+};
-- 
1.7.0.4
