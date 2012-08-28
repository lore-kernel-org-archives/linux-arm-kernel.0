From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 28 Aug 2012 13:13:40 +0200
Subject: [PATCH] ARM: EXYNOS: Add support for secondary CPU bring-up on
 Exynos4412
Message-ID: <1422318.SfZfh0XoVo@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Exynos4412 uses different information register for each core. This patch
adjusts the bring-up code to take that into account.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-exynos/platsmp.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
index 36c3984..1114ced 100644
--- a/arch/arm/mach-exynos/platsmp.c
+++ b/arch/arm/mach-exynos/platsmp.c
@@ -34,8 +34,19 @@
 
 extern void exynos4_secondary_startup(void);
 
-#define CPU1_BOOT_REG		(samsung_rev() == EXYNOS4210_REV_1_1 ? \
-				S5P_INFORM5 : S5P_VA_SYSRAM)
+static inline volatile void *cpu_boot_reg_base(void)
+{
+	if (soc_is_exynos4210() && samsung_rev() == EXYNOS4210_REV_1_1)
+		return S5P_INFORM5;
+	return S5P_VA_SYSRAM;
+}
+
+static inline volatile void *cpu_boot_reg(int cpu)
+{
+	if (soc_is_exynos4412())
+		return cpu_boot_reg_base() + 4*cpu;
+	return cpu_boot_reg_base();
+}
 
 /*
  * control for which core is the next to come out of the secondary
@@ -138,7 +149,7 @@ int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
 		smp_rmb();
 
 		__raw_writel(virt_to_phys(exynos4_secondary_startup),
-			CPU1_BOOT_REG);
+							cpu_boot_reg(cpu));
 		gic_raise_softirq(cpumask_of(cpu), 1);
 
 		if (pen_release == -1)
@@ -186,6 +197,8 @@ void __init smp_init_cpus(void)
 
 void __init platform_smp_prepare_cpus(unsigned int max_cpus)
 {
+	int i;
+
 	if (!soc_is_exynos5250())
 		scu_enable(scu_base_addr());
 
@@ -195,6 +208,8 @@ void __init platform_smp_prepare_cpus(unsigned int max_cpus)
 	 * until it receives a soft interrupt, and then the
 	 * secondary CPU branches to this address.
 	 */
-	__raw_writel(virt_to_phys(exynos4_secondary_startup),
-			CPU1_BOOT_REG);
+	for (i = 1; i < max_cpus; ++i) {
+		__raw_writel(virt_to_phys(exynos4_secondary_startup),
+							cpu_boot_reg(i));
+	}
 }
-- 
1.7.12
