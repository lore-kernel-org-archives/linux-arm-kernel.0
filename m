From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 12 Jun 2012 13:30:49 +0100
Subject: [PATCH v8 06/13] ARM: convert MSM SMP to smp_ops
In-Reply-To: <1339504256-11266-1-git-send-email-marc.zyngier@arm.com>
References: <1339504256-11266-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1339504256-11266-7-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert MSM SMP platforms to use the smp_ops to provide
their SMP and CPU hotplug operations.

Acked-by: David Brown <davidb@codeaurora.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-msm/board-msm8960.c |    3 +++
 arch/arm/mach-msm/board-msm8x60.c |    7 +++++++
 arch/arm/mach-msm/core.h          |    7 +++++++
 arch/arm/mach-msm/hotplug.c       |    8 +++++---
 arch/arm/mach-msm/platsmp.c       |   15 +++++++++++----
 5 files changed, 33 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm/mach-msm/core.h

diff --git a/arch/arm/mach-msm/board-msm8960.c b/arch/arm/mach-msm/board-msm8960.c
index 65f4a1d..20cbd87 100644
--- a/arch/arm/mach-msm/board-msm8960.c
+++ b/arch/arm/mach-msm/board-msm8960.c
@@ -30,6 +30,7 @@
 #include <mach/board.h>
 #include <mach/msm_iomap.h>
 
+#include "core.h"
 #include "devices.h"
 
 static void __init msm8960_fixup(struct tag *tag, char **cmdline,
@@ -99,6 +100,7 @@ static void __init msm8960_init_late(void)
 }
 
 MACHINE_START(MSM8960_SIM, "QCT MSM8960 SIMULATOR")
+	smp_ops(msm_smp_ops)
 	.fixup = msm8960_fixup,
 	.reserve = msm8960_reserve,
 	.map_io = msm8960_map_io,
@@ -110,6 +112,7 @@ MACHINE_START(MSM8960_SIM, "QCT MSM8960 SIMULATOR")
 MACHINE_END
 
 MACHINE_START(MSM8960_RUMI3, "QCT MSM8960 RUMI3")
+	smp_ops(msm_smp_ops)
 	.fixup = msm8960_fixup,
 	.reserve = msm8960_reserve,
 	.map_io = msm8960_map_io,
diff --git a/arch/arm/mach-msm/board-msm8x60.c b/arch/arm/mach-msm/board-msm8x60.c
index e37a724..4dafaeb 100644
--- a/arch/arm/mach-msm/board-msm8x60.c
+++ b/arch/arm/mach-msm/board-msm8x60.c
@@ -29,6 +29,8 @@
 #include <mach/board.h>
 #include <mach/msm_iomap.h>
 
+#include "core.h"
+
 static void __init msm8x60_fixup(struct tag *tag, char **cmdline,
 		struct meminfo *mi)
 {
@@ -110,6 +112,7 @@ static const char *msm8x60_fluid_match[] __initdata = {
 #endif /* CONFIG_OF */
 
 MACHINE_START(MSM8X60_RUMI3, "QCT MSM8X60 RUMI3")
+	smp_ops(msm_smp_ops)
 	.fixup = msm8x60_fixup,
 	.reserve = msm8x60_reserve,
 	.map_io = msm8x60_map_io,
@@ -121,6 +124,7 @@ MACHINE_START(MSM8X60_RUMI3, "QCT MSM8X60 RUMI3")
 MACHINE_END
 
 MACHINE_START(MSM8X60_SURF, "QCT MSM8X60 SURF")
+	smp_ops(msm_smp_ops)
 	.fixup = msm8x60_fixup,
 	.reserve = msm8x60_reserve,
 	.map_io = msm8x60_map_io,
@@ -132,6 +136,7 @@ MACHINE_START(MSM8X60_SURF, "QCT MSM8X60 SURF")
 MACHINE_END
 
 MACHINE_START(MSM8X60_SIM, "QCT MSM8X60 SIMULATOR")
+	smp_ops(msm_smp_ops)
 	.fixup = msm8x60_fixup,
 	.reserve = msm8x60_reserve,
 	.map_io = msm8x60_map_io,
@@ -143,6 +148,7 @@ MACHINE_START(MSM8X60_SIM, "QCT MSM8X60 SIMULATOR")
 MACHINE_END
 
 MACHINE_START(MSM8X60_FFA, "QCT MSM8X60 FFA")
+	smp_ops(msm_smp_ops)
 	.fixup = msm8x60_fixup,
 	.reserve = msm8x60_reserve,
 	.map_io = msm8x60_map_io,
@@ -156,6 +162,7 @@ MACHINE_END
 #ifdef CONFIG_OF
 /* TODO: General device tree support for all MSM. */
 DT_MACHINE_START(MSM_DT, "Qualcomm MSM (Flattened Device Tree)")
+	smp_ops(msm_smp_ops)
 	.map_io = msm8x60_map_io,
 	.init_irq = msm8x60_init_irq,
 	.init_machine = msm8x60_dt_init,
diff --git a/arch/arm/mach-msm/core.h b/arch/arm/mach-msm/core.h
new file mode 100644
index 0000000..ecad798
--- /dev/null
+++ b/arch/arm/mach-msm/core.h
@@ -0,0 +1,7 @@
+#include <asm/smp_ops.h>
+
+extern struct smp_ops		msm_smp_ops;
+
+extern int  msm_cpu_kill(unsigned int cpu);
+extern void msm_cpu_die(unsigned int cpu);
+extern int  msm_cpu_disable(unsigned int cpu);
diff --git a/arch/arm/mach-msm/hotplug.c b/arch/arm/mach-msm/hotplug.c
index a446fc1..6ba3602 100644
--- a/arch/arm/mach-msm/hotplug.c
+++ b/arch/arm/mach-msm/hotplug.c
@@ -13,6 +13,8 @@
 #include <asm/cacheflush.h>
 #include <asm/smp_plat.h>
 
+#include "core.h"
+
 extern volatile int pen_release;
 
 static inline void cpu_enter_lowpower(void)
@@ -57,7 +59,7 @@ static inline void platform_do_lowpower(unsigned int cpu)
 	}
 }
 
-int platform_cpu_kill(unsigned int cpu)
+int msm_cpu_kill(unsigned int cpu)
 {
 	return 1;
 }
@@ -67,7 +69,7 @@ int platform_cpu_kill(unsigned int cpu)
  *
  * Called with IRQs disabled
  */
-void platform_cpu_die(unsigned int cpu)
+void msm_cpu_die(unsigned int cpu)
 {
 	/*
 	 * we're ready for shutdown now, so do it
@@ -82,7 +84,7 @@ void platform_cpu_die(unsigned int cpu)
 	cpu_leave_lowpower();
 }
 
-int platform_cpu_disable(unsigned int cpu)
+int msm_cpu_disable(unsigned int cpu)
 {
 	/*
 	 * we don't allow CPU 0 to be shutdown (it is still too special
diff --git a/arch/arm/mach-msm/platsmp.c b/arch/arm/mach-msm/platsmp.c
index db0117e..7670ace 100644
--- a/arch/arm/mach-msm/platsmp.c
+++ b/arch/arm/mach-msm/platsmp.c
@@ -25,6 +25,7 @@
 #include <mach/msm_iomap.h>
 
 #include "scm-boot.h"
+#include "core.h"
 
 #define VDD_SC1_ARRAY_CLAMP_GFS_CTL 0x15A0
 #define SCSS_CPU1CORE_RESET 0xD80
@@ -48,7 +49,7 @@ static inline int get_core_count(void)
 	return ((read_cpuid_id() >> 4) & 3) + 1;
 }
 
-void __cpuinit platform_secondary_init(unsigned int cpu)
+static void __cpuinit msm_secondary_init(unsigned int cpu)
 {
 	/* Configure edge-triggered PPIs */
 	writel(GIC_PPI_EDGE_MASK, MSM_QGIC_DIST_BASE + GIC_DIST_CONFIG + 4);
@@ -93,7 +94,7 @@ static __cpuinit void prepare_cold_cpu(unsigned int cpu)
 				  "address\n");
 }
 
-int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
+static int __cpuinit msm_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
 	unsigned long timeout;
 	static int cold_boot_done;
@@ -153,7 +154,7 @@ int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
  * does not support the ARM SCU, so just set the possible cpu mask to
  * NR_CPUS.
  */
-void __init smp_init_cpus(void)
+static void __init msm_smp_init_cpus(void)
 {
 	unsigned int i, ncores = get_core_count();
 
@@ -169,6 +170,12 @@ void __init smp_init_cpus(void)
         set_smp_cross_call(gic_raise_softirq);
 }
 
-void __init platform_smp_prepare_cpus(unsigned int max_cpus)
+static void __init msm_smp_prepare_cpus(unsigned int max_cpus)
 {
 }
+
+struct smp_ops msm_smp_ops __initdata = {	
+	smp_init_ops(msm)
+	smp_secondary_ops(msm)
+	smp_hotplug_ops(msm)
+};
-- 
1.7.10.3
