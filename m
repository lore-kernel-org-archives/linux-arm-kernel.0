From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed,  8 Feb 2012 00:30:50 +0000
Subject: [PATCH v6 06/15] ARM: SoC: convert Exynos4 to SoC descriptor
In-Reply-To: <1328661059-24584-1-git-send-email-marc.zyngier@arm.com>
References: <1328661059-24584-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1328661059-24584-7-git-send-email-marc.zyngier@arm.com>
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
 arch/arm/mach-exynos/mach-nuri.c           |    1 +
 arch/arm/mach-exynos/mach-origen.c         |    1 +
 arch/arm/mach-exynos/mach-smdk4x12.c       |    2 ++
 arch/arm/mach-exynos/mach-smdkv310.c       |    2 ++
 arch/arm/mach-exynos/mach-universal_c210.c |    1 +
 arch/arm/mach-exynos/platsmp.c             |   25 +++++++++++++++++++++----
 10 files changed, 50 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
index c59e188..04578e1 100644
--- a/arch/arm/mach-exynos/common.c
+++ b/arch/arm/mach-exynos/common.c
@@ -697,3 +697,9 @@ int __init exynos4_init_irq_eint(void)
 	return 0;
 }
 arch_initcall(exynos4_init_irq_eint);
+
+struct arm_soc_desc exynos4_soc_desc __initdata = {
+	.name	= "Samsung EXYNOS4",
+	soc_smp_init_ops(exynos4_soc_smp_init_ops)
+	soc_smp_ops(exynos4_soc_smp_ops)
+};
diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
index 1ac49de..cd37455 100644
--- a/arch/arm/mach-exynos/common.h
+++ b/arch/arm/mach-exynos/common.h
@@ -12,6 +12,8 @@
 #ifndef __ARCH_ARM_MACH_EXYNOS_COMMON_H
 #define __ARCH_ARM_MACH_EXYNOS_COMMON_H
 
+#include <asm/soc.h>
+
 void exynos_init_io(struct map_desc *mach_desc, int size);
 void exynos4_init_irq(void);
 
@@ -25,6 +27,14 @@ void exynos4_restart(char mode, const char *cmd);
 
 extern struct sys_timer exynos4_timer;
 
+extern struct arm_soc_smp_init_ops	exynos4_soc_smp_init_ops;
+extern struct arm_soc_smp_ops		exynos4_soc_smp_ops;
+extern struct arm_soc_desc		exynos4_soc_desc;
+
+extern int  exynos4_cpu_kill(unsigned int cpu);
+extern void exynos4_cpu_die(unsigned int cpu);
+extern int  exynos4_cpu_disable(unsigned int cpu);
+
 #ifdef CONFIG_ARCH_EXYNOS
 extern  int exynos_init(void);
 extern void exynos4_map_io(void);
diff --git a/arch/arm/mach-exynos/hotplug.c b/arch/arm/mach-exynos/hotplug.c
index dd1ad55..66e202d 100644
--- a/arch/arm/mach-exynos/hotplug.c
+++ b/arch/arm/mach-exynos/hotplug.c
@@ -20,6 +20,8 @@
 
 #include <mach/regs-pmu.h>
 
+#include "common.h"
+
 extern volatile int pen_release;
 
 static inline void cpu_enter_lowpower(void)
@@ -94,7 +96,7 @@ static inline void platform_do_lowpower(unsigned int cpu, int *spurious)
 	}
 }
 
-int platform_cpu_kill(unsigned int cpu)
+int exynos4_cpu_kill(unsigned int cpu)
 {
 	return 1;
 }
@@ -104,7 +106,7 @@ int platform_cpu_kill(unsigned int cpu)
  *
  * Called with IRQs disabled
  */
-void platform_cpu_die(unsigned int cpu)
+void exynos4_cpu_die(unsigned int cpu)
 {
 	int spurious = 0;
 
@@ -124,7 +126,7 @@ void platform_cpu_die(unsigned int cpu)
 		pr_warn("CPU%u: %u spurious wakeup calls\n", cpu, spurious);
 }
 
-int platform_cpu_disable(unsigned int cpu)
+int exynos4_cpu_disable(unsigned int cpu)
 {
 	/*
 	 * we don't allow CPU 0 to be shutdown (it is still too special
diff --git a/arch/arm/mach-exynos/mach-armlex4210.c b/arch/arm/mach-exynos/mach-armlex4210.c
index d726fcd..5e60cea 100644
--- a/arch/arm/mach-exynos/mach-armlex4210.c
+++ b/arch/arm/mach-exynos/mach-armlex4210.c
@@ -210,6 +210,7 @@ static void __init armlex4210_machine_init(void)
 MACHINE_START(ARMLEX4210, "ARMLEX4210")
 	/* Maintainer: Alim Akhtar <alim.akhtar@samsung.com> */
 	.atag_offset	= 0x100,
+	.soc		= &exynos4_soc_desc,
 	.init_irq	= exynos4_init_irq,
 	.map_io		= armlex4210_map_io,
 	.handle_irq	= gic_handle_irq,
diff --git a/arch/arm/mach-exynos/mach-nuri.c b/arch/arm/mach-exynos/mach-nuri.c
index b895ec0..5a3bf74 100644
--- a/arch/arm/mach-exynos/mach-nuri.c
+++ b/arch/arm/mach-exynos/mach-nuri.c
@@ -1328,6 +1328,7 @@ static void __init nuri_machine_init(void)
 MACHINE_START(NURI, "NURI")
 	/* Maintainer: Kyungmin Park <kyungmin.park@samsung.com> */
 	.atag_offset	= 0x100,
+	.soc		= &exynos4_soc_desc,
 	.init_irq	= exynos4_init_irq,
 	.map_io		= nuri_map_io,
 	.handle_irq	= gic_handle_irq,
diff --git a/arch/arm/mach-exynos/mach-origen.c b/arch/arm/mach-exynos/mach-origen.c
index 0679b8a..076d4d8 100644
--- a/arch/arm/mach-exynos/mach-origen.c
+++ b/arch/arm/mach-exynos/mach-origen.c
@@ -708,6 +708,7 @@ static void __init origen_machine_init(void)
 MACHINE_START(ORIGEN, "ORIGEN")
 	/* Maintainer: JeongHyeon Kim <jhkim@insignal.co.kr> */
 	.atag_offset	= 0x100,
+	.soc		= &exynos4_soc_desc,
 	.init_irq	= exynos4_init_irq,
 	.map_io		= origen_map_io,
 	.handle_irq	= gic_handle_irq,
diff --git a/arch/arm/mach-exynos/mach-smdk4x12.c b/arch/arm/mach-exynos/mach-smdk4x12.c
index d00e4f0..fb9a313 100644
--- a/arch/arm/mach-exynos/mach-smdk4x12.c
+++ b/arch/arm/mach-exynos/mach-smdk4x12.c
@@ -287,6 +287,7 @@ static void __init smdk4x12_machine_init(void)
 MACHINE_START(SMDK4212, "SMDK4212")
 	/* Maintainer: Kukjin Kim <kgene.kim@samsung.com> */
 	.atag_offset	= 0x100,
+	.soc		= &exynos4_soc_desc,
 	.init_irq	= exynos4_init_irq,
 	.map_io		= smdk4x12_map_io,
 	.handle_irq	= gic_handle_irq,
@@ -299,6 +300,7 @@ MACHINE_START(SMDK4412, "SMDK4412")
 	/* Maintainer: Kukjin Kim <kgene.kim@samsung.com> */
 	/* Maintainer: Changhwan Youn <chaos.youn@samsung.com> */
 	.atag_offset	= 0x100,
+	.soc		= &exynos4_soc_desc,
 	.init_irq	= exynos4_init_irq,
 	.map_io		= smdk4x12_map_io,
 	.handle_irq	= gic_handle_irq,
diff --git a/arch/arm/mach-exynos/mach-smdkv310.c b/arch/arm/mach-exynos/mach-smdkv310.c
index b2c5557..6672161 100644
--- a/arch/arm/mach-exynos/mach-smdkv310.c
+++ b/arch/arm/mach-exynos/mach-smdkv310.c
@@ -386,6 +386,7 @@ MACHINE_START(SMDKV310, "SMDKV310")
 	/* Maintainer: Kukjin Kim <kgene.kim@samsung.com> */
 	/* Maintainer: Changhwan Youn <chaos.youn@samsung.com> */
 	.atag_offset	= 0x100,
+	.soc		= &exynos4_soc_desc,
 	.init_irq	= exynos4_init_irq,
 	.map_io		= smdkv310_map_io,
 	.handle_irq	= gic_handle_irq,
@@ -398,6 +399,7 @@ MACHINE_END
 MACHINE_START(SMDKC210, "SMDKC210")
 	/* Maintainer: Kukjin Kim <kgene.kim@samsung.com> */
 	.atag_offset	= 0x100,
+	.soc		= &exynos4_soc_desc,
 	.init_irq	= exynos4_init_irq,
 	.map_io		= smdkv310_map_io,
 	.handle_irq	= gic_handle_irq,
diff --git a/arch/arm/mach-exynos/mach-universal_c210.c b/arch/arm/mach-exynos/mach-universal_c210.c
index 37ac93e..3350b50 100644
--- a/arch/arm/mach-exynos/mach-universal_c210.c
+++ b/arch/arm/mach-exynos/mach-universal_c210.c
@@ -1054,6 +1054,7 @@ static void __init universal_machine_init(void)
 MACHINE_START(UNIVERSAL_C210, "UNIVERSAL_C210")
 	/* Maintainer: Kyungmin Park <kyungmin.park@samsung.com> */
 	.atag_offset	= 0x100,
+	.soc		= &exynos4_soc_desc,
 	.init_irq	= exynos4_init_irq,
 	.map_io		= universal_map_io,
 	.handle_irq	= gic_handle_irq,
diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
index 0f2035a..9c6e322 100644
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
+static void __cpuinit exynos4_secondary_init(unsigned int cpu)
 {
 	/*
 	 * if any interrupts are already enabled for the primary
@@ -86,7 +88,7 @@ void __cpuinit platform_secondary_init(unsigned int cpu)
 	spin_unlock(&boot_lock);
 }
 
-int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
+static int __cpuinit exynos4_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
 	unsigned long timeout;
 
@@ -161,7 +163,7 @@ int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
  * which may be present or become present in the system.
  */
 
-void __init smp_init_cpus(void)
+static void __init exynos4_smp_init_cpus(void)
 {
 	void __iomem *scu_base = scu_base_addr();
 	unsigned int i, ncores;
@@ -181,7 +183,7 @@ void __init smp_init_cpus(void)
 	set_smp_cross_call(gic_raise_softirq);
 }
 
-void __init platform_smp_prepare_cpus(unsigned int max_cpus)
+static void __init exynos4_smp_prepare_cpus(unsigned int max_cpus)
 {
 
 	scu_enable(scu_base_addr());
@@ -195,3 +197,18 @@ void __init platform_smp_prepare_cpus(unsigned int max_cpus)
 	__raw_writel(virt_to_phys(exynos4_secondary_startup),
 			CPU1_BOOT_REG);
 }
+
+struct arm_soc_smp_init_ops exynos4_soc_smp_init_ops __initdata = {
+	.smp_init_cpus		= exynos4_smp_init_cpus,
+	.smp_prepare_cpus	= exynos4_smp_prepare_cpus,
+};
+
+struct arm_soc_smp_ops exynos4_soc_smp_ops __initdata = {
+	.smp_secondary_init	= exynos4_secondary_init,
+	.smp_boot_secondary	= exynos4_boot_secondary,
+#ifdef CONFIG_HOTPLUG_CPU
+	.cpu_kill		= exynos4_cpu_kill,
+	.cpu_die		= exynos4_cpu_die,
+	.cpu_disable		= exynos4_cpu_disable,
+#endif
+};
-- 
1.7.3.4
