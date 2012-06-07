From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu,  7 Jun 2012 17:09:23 +0100
Subject: [PATCH v7 06/12] ARM: SoC: convert Exynos4 to SoC descriptor
In-Reply-To: <1339085369-26073-1-git-send-email-marc.zyngier@arm.com>
References: <1339085369-26073-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1339085369-26073-7-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert Exynos4 to use the SoC descriptor to provide its SMP
and CPU hotplug operations.

Cc: Kukjin Kim <kgene.kim@samsung.com>
Tested-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-exynos/common.c              |    6 ++++++
 arch/arm/mach-exynos/common.h              |   10 ++++++++++
 arch/arm/mach-exynos/hotplug.c             |    8 +++++---
 arch/arm/mach-exynos/mach-armlex4210.c     |    1 +
 arch/arm/mach-exynos/mach-exynos5-dt.c     |    1 +
 arch/arm/mach-exynos/mach-nuri.c           |    1 +
 arch/arm/mach-exynos/mach-origen.c         |    1 +
 arch/arm/mach-exynos/mach-smdk4x12.c       |    2 ++
 arch/arm/mach-exynos/mach-smdkv310.c       |    2 ++
 arch/arm/mach-exynos/mach-universal_c210.c |    1 +
 arch/arm/mach-exynos/platsmp.c             |   21 +++++++++++++++++----
 11 files changed, 47 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
index 742edd3..6407bf8 100644
--- a/arch/arm/mach-exynos/common.c
+++ b/arch/arm/mach-exynos/common.c
@@ -1041,3 +1041,9 @@ static int __init exynos_init_irq_eint(void)
 	return 0;
 }
 arch_initcall(exynos_init_irq_eint);
+
+struct arm_soc_desc exynos_soc_desc __initdata = {
+	.name	= "Samsung EXYNOS",
+	soc_smp_init_ops(exynos_soc_smp_init_ops)
+	soc_smp_ops(exynos_soc_smp_ops)
+};
diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
index aed2eeb..c0d64e9 100644
--- a/arch/arm/mach-exynos/common.h
+++ b/arch/arm/mach-exynos/common.h
@@ -12,6 +12,8 @@
 #ifndef __ARCH_ARM_MACH_EXYNOS_COMMON_H
 #define __ARCH_ARM_MACH_EXYNOS_COMMON_H
 
+#include <asm/soc.h>
+
 extern struct sys_timer exynos4_timer;
 
 void exynos_init_io(struct map_desc *mach_desc, int size);
@@ -59,4 +61,12 @@ void exynos4212_register_clocks(void);
 #define exynos4212_register_clocks()
 #endif
 
+extern struct arm_soc_smp_init_ops	exynos_soc_smp_init_ops;
+extern struct arm_soc_smp_ops		exynos_soc_smp_ops;
+extern struct arm_soc_desc		exynos_soc_desc;
+
+extern int  exynos_cpu_kill(unsigned int cpu);
+extern void exynos_cpu_die(unsigned int cpu);
+extern int  exynos_cpu_disable(unsigned int cpu);
+
 #endif /* __ARCH_ARM_MACH_EXYNOS_COMMON_H */
diff --git a/arch/arm/mach-exynos/hotplug.c b/arch/arm/mach-exynos/hotplug.c
index 9c17a0a..244d3ef 100644
--- a/arch/arm/mach-exynos/hotplug.c
+++ b/arch/arm/mach-exynos/hotplug.c
@@ -21,6 +21,8 @@
 
 #include <mach/regs-pmu.h>
 
+#include "common.h"
+
 extern volatile int pen_release;
 
 static inline void cpu_enter_lowpower(void)
@@ -95,7 +97,7 @@ static inline void platform_do_lowpower(unsigned int cpu, int *spurious)
 	}
 }
 
-int platform_cpu_kill(unsigned int cpu)
+int exynos_cpu_kill(unsigned int cpu)
 {
 	return 1;
 }
@@ -105,7 +107,7 @@ int platform_cpu_kill(unsigned int cpu)
  *
  * Called with IRQs disabled
  */
-void platform_cpu_die(unsigned int cpu)
+void exynos_cpu_die(unsigned int cpu)
 {
 	int spurious = 0;
 
@@ -125,7 +127,7 @@ void platform_cpu_die(unsigned int cpu)
 		pr_warn("CPU%u: %u spurious wakeup calls\n", cpu, spurious);
 }
 
-int platform_cpu_disable(unsigned int cpu)
+int exynos_cpu_disable(unsigned int cpu)
 {
 	/*
 	 * we don't allow CPU 0 to be shutdown (it is still too special
diff --git a/arch/arm/mach-exynos/mach-armlex4210.c b/arch/arm/mach-exynos/mach-armlex4210.c
index 5a3daa0..9220619 100644
--- a/arch/arm/mach-exynos/mach-armlex4210.c
+++ b/arch/arm/mach-exynos/mach-armlex4210.c
@@ -199,6 +199,7 @@ static void __init armlex4210_machine_init(void)
 MACHINE_START(ARMLEX4210, "ARMLEX4210")
 	/* Maintainer: Alim Akhtar <alim.akhtar@samsung.com> */
 	.atag_offset	= 0x100,
+	.soc		= &exynos_soc_desc,
 	.init_irq	= exynos4_init_irq,
 	.map_io		= armlex4210_map_io,
 	.handle_irq	= gic_handle_irq,
diff --git a/arch/arm/mach-exynos/mach-exynos5-dt.c b/arch/arm/mach-exynos/mach-exynos5-dt.c
index 7b1e11a..795989f 100644
--- a/arch/arm/mach-exynos/mach-exynos5-dt.c
+++ b/arch/arm/mach-exynos/mach-exynos5-dt.c
@@ -73,6 +73,7 @@ static char const *exynos5250_dt_compat[] __initdata = {
 DT_MACHINE_START(EXYNOS5_DT, "SAMSUNG EXYNOS5 (Flattened Device Tree)")
 	/* Maintainer: Kukjin Kim <kgene.kim@samsung.com> */
 	.init_irq	= exynos5_init_irq,
+	.soc		= &exynos_soc_desc,
 	.map_io		= exynos5250_dt_map_io,
 	.handle_irq	= gic_handle_irq,
 	.init_machine	= exynos5250_dt_machine_init,
diff --git a/arch/arm/mach-exynos/mach-nuri.c b/arch/arm/mach-exynos/mach-nuri.c
index 656f8fc..17a4a2b 100644
--- a/arch/arm/mach-exynos/mach-nuri.c
+++ b/arch/arm/mach-exynos/mach-nuri.c
@@ -1389,6 +1389,7 @@ static void __init nuri_machine_init(void)
 MACHINE_START(NURI, "NURI")
 	/* Maintainer: Kyungmin Park <kyungmin.park@samsung.com> */
 	.atag_offset	= 0x100,
+	.soc		= &exynos_soc_desc,
 	.init_irq	= exynos4_init_irq,
 	.map_io		= nuri_map_io,
 	.handle_irq	= gic_handle_irq,
diff --git a/arch/arm/mach-exynos/mach-origen.c b/arch/arm/mach-exynos/mach-origen.c
index f5572be..d952126 100644
--- a/arch/arm/mach-exynos/mach-origen.c
+++ b/arch/arm/mach-exynos/mach-origen.c
@@ -766,6 +766,7 @@ static void __init origen_machine_init(void)
 MACHINE_START(ORIGEN, "ORIGEN")
 	/* Maintainer: JeongHyeon Kim <jhkim@insignal.co.kr> */
 	.atag_offset	= 0x100,
+	.soc		= &exynos_soc_desc,
 	.init_irq	= exynos4_init_irq,
 	.map_io		= origen_map_io,
 	.handle_irq	= gic_handle_irq,
diff --git a/arch/arm/mach-exynos/mach-smdk4x12.c b/arch/arm/mach-exynos/mach-smdk4x12.c
index fb09c70..530a18d 100644
--- a/arch/arm/mach-exynos/mach-smdk4x12.c
+++ b/arch/arm/mach-exynos/mach-smdk4x12.c
@@ -299,6 +299,7 @@ static void __init smdk4x12_machine_init(void)
 MACHINE_START(SMDK4212, "SMDK4212")
 	/* Maintainer: Kukjin Kim <kgene.kim@samsung.com> */
 	.atag_offset	= 0x100,
+	.soc		= &exynos_soc_desc,
 	.init_irq	= exynos4_init_irq,
 	.map_io		= smdk4x12_map_io,
 	.handle_irq	= gic_handle_irq,
@@ -312,6 +313,7 @@ MACHINE_START(SMDK4412, "SMDK4412")
 	/* Maintainer: Kukjin Kim <kgene.kim@samsung.com> */
 	/* Maintainer: Changhwan Youn <chaos.youn@samsung.com> */
 	.atag_offset	= 0x100,
+	.soc		= &exynos_soc_desc,
 	.init_irq	= exynos4_init_irq,
 	.map_io		= smdk4x12_map_io,
 	.handle_irq	= gic_handle_irq,
diff --git a/arch/arm/mach-exynos/mach-smdkv310.c b/arch/arm/mach-exynos/mach-smdkv310.c
index 262e9e4..4bf018a 100644
--- a/arch/arm/mach-exynos/mach-smdkv310.c
+++ b/arch/arm/mach-exynos/mach-smdkv310.c
@@ -399,6 +399,7 @@ MACHINE_START(SMDKV310, "SMDKV310")
 	/* Maintainer: Kukjin Kim <kgene.kim@samsung.com> */
 	/* Maintainer: Changhwan Youn <chaos.youn@samsung.com> */
 	.atag_offset	= 0x100,
+	.soc		= &exynos_soc_desc,
 	.init_irq	= exynos4_init_irq,
 	.map_io		= smdkv310_map_io,
 	.handle_irq	= gic_handle_irq,
@@ -411,6 +412,7 @@ MACHINE_END
 MACHINE_START(SMDKC210, "SMDKC210")
 	/* Maintainer: Kukjin Kim <kgene.kim@samsung.com> */
 	.atag_offset	= 0x100,
+	.soc		= &exynos_soc_desc,
 	.init_irq	= exynos4_init_irq,
 	.map_io		= smdkv310_map_io,
 	.handle_irq	= gic_handle_irq,
diff --git a/arch/arm/mach-exynos/mach-universal_c210.c b/arch/arm/mach-exynos/mach-universal_c210.c
index cd92fa8..7127ea9 100644
--- a/arch/arm/mach-exynos/mach-universal_c210.c
+++ b/arch/arm/mach-exynos/mach-universal_c210.c
@@ -1157,6 +1157,7 @@ static void __init universal_machine_init(void)
 MACHINE_START(UNIVERSAL_C210, "UNIVERSAL_C210")
 	/* Maintainer: Kyungmin Park <kyungmin.park@samsung.com> */
 	.atag_offset	= 0x100,
+	.soc		= &exynos_soc_desc,
 	.init_irq	= exynos4_init_irq,
 	.map_io		= universal_map_io,
 	.handle_irq	= gic_handle_irq,
diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
index 36c3984..f7007c4 100644
--- a/arch/arm/mach-exynos/platsmp.c
+++ b/arch/arm/mach-exynos/platsmp.c
@@ -32,6 +32,8 @@
 
 #include <plat/cpu.h>
 
+#include "common.h"
+
 extern void exynos4_secondary_startup(void);
 
 #define CPU1_BOOT_REG		(samsung_rev() == EXYNOS4210_REV_1_1 ? \
@@ -64,7 +66,7 @@ static void __iomem *scu_base_addr(void)
 
 static DEFINE_SPINLOCK(boot_lock);
 
-void __cpuinit platform_secondary_init(unsigned int cpu)
+static void __cpuinit exynos_secondary_init(unsigned int cpu)
 {
 	/*
 	 * if any interrupts are already enabled for the primary
@@ -86,7 +88,7 @@ void __cpuinit platform_secondary_init(unsigned int cpu)
 	spin_unlock(&boot_lock);
 }
 
-int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
+static int __cpuinit exynos_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
 	unsigned long timeout;
 
@@ -161,7 +163,7 @@ int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
  * which may be present or become present in the system.
  */
 
-void __init smp_init_cpus(void)
+static void __init exynos_smp_init_cpus(void)
 {
 	void __iomem *scu_base = scu_base_addr();
 	unsigned int i, ncores;
@@ -184,7 +186,7 @@ void __init smp_init_cpus(void)
 	set_smp_cross_call(gic_raise_softirq);
 }
 
-void __init platform_smp_prepare_cpus(unsigned int max_cpus)
+static void __init exynos_smp_prepare_cpus(unsigned int max_cpus)
 {
 	if (!soc_is_exynos5250())
 		scu_enable(scu_base_addr());
@@ -198,3 +200,14 @@ void __init platform_smp_prepare_cpus(unsigned int max_cpus)
 	__raw_writel(virt_to_phys(exynos4_secondary_startup),
 			CPU1_BOOT_REG);
 }
+
+struct arm_soc_smp_init_ops exynos_soc_smp_init_ops __initdata = {
+	.smp_init_cpus		= exynos_smp_init_cpus,
+	.smp_prepare_cpus	= exynos_smp_prepare_cpus,
+};
+
+struct arm_soc_smp_ops exynos_soc_smp_ops __initdata = {
+	.smp_secondary_init	= exynos_secondary_init,
+	.smp_boot_secondary	= exynos_boot_secondary,
+	soc_hotplug_ops(exynos)
+};
-- 
1.7.10.1
