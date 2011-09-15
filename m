From: kmpark@infradead.org (Kyungmin Park)
Date: Thu, 15 Sep 2011 16:58:51 +0900
Subject: [PATCH] ARM: exynos4: use the variable for S5P_VA_SYSRAM
Message-ID: <20110915075851.GA31795@july>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kyungmin Park <kyungmin.park@samsung.com>

The CPU1_BOOT_REG and S5P_VA_SYSRAM is used mixed for setup secondary_startup.
Make it consistent statement for setup.

It's also helpful for EVT0 which has another SYSRAM address handling.

	if (soc_is_exynos4210_evt0())
		sysram = ioremap(EXYNOS4210_EVT0_SYSRAM, SZ_4K);

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
diff --git a/arch/arm/mach-exynos4/platsmp.c b/arch/arm/mach-exynos4/platsmp.c
index 7c2282c..6cdb750 100644
--- a/arch/arm/mach-exynos4/platsmp.c
+++ b/arch/arm/mach-exynos4/platsmp.c
@@ -32,7 +32,7 @@
 
 extern void exynos4_secondary_startup(void);
 
-#define CPU1_BOOT_REG S5P_VA_SYSRAM
+static void __iomem *sysram;
 
 /*
  * control for which core is the next to come out of the secondary
@@ -160,7 +160,7 @@ int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
 		smp_rmb();
 
 		__raw_writel(BSYM(virt_to_phys(exynos4_secondary_startup)),
-			CPU1_BOOT_REG);
+			sysram);
 		gic_raise_softirq(cpumask_of(cpu), 1);
 
 		if (pen_release == -1)
@@ -207,6 +207,7 @@ void __init smp_init_cpus(void)
 
 void __init platform_smp_prepare_cpus(unsigned int max_cpus)
 {
+	sysram = S5P_VA_SYSRAM;
 
 	scu_enable(scu_base_addr());
 
@@ -216,5 +217,5 @@ void __init platform_smp_prepare_cpus(unsigned int max_cpus)
 	 * until it receives a soft interrupt, and then the
 	 * secondary CPU branches to this address.
 	 */
-	__raw_writel(BSYM(virt_to_phys(exynos4_secondary_startup)), S5P_VA_SYSRAM);
+	__raw_writel(BSYM(virt_to_phys(exynos4_secondary_startup)), sysram);
 }
