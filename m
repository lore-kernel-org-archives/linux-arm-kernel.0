From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Tue, 21 Jun 2016 11:20:28 +0100
Subject: [[PATCH v2] 07/11] ARM: EXYNOS: fixup for __raw operations in
 suspend.c
In-Reply-To: <1466504432-24187-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1466504432-24187-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1466504432-24187-8-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the PMU code endian access code to deal with kernels built for
big endian operation by changing the __raw IO accessors to the
_relaxed variants.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
---
 arch/arm/mach-exynos/suspend.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-exynos/suspend.c b/arch/arm/mach-exynos/suspend.c
index f216909..3750575 100644
--- a/arch/arm/mach-exynos/suspend.c
+++ b/arch/arm/mach-exynos/suspend.c
@@ -301,7 +301,7 @@ static int exynos5420_cpu_suspend(unsigned long arg)
 	unsigned int cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
 	unsigned int cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
 
-	__raw_writel(0x0, sysram_base_addr + EXYNOS5420_CPU_STATE);
+	writel_relaxed(0x0, sysram_base_addr + EXYNOS5420_CPU_STATE);
 
 	if (IS_ENABLED(CONFIG_EXYNOS5420_MCPM)) {
 		mcpm_set_entry_vector(cpu, cluster, exynos_cpu_resume);
@@ -373,8 +373,8 @@ static void exynos5420_pm_prepare(void)
 	 * needs to restore it back in case, the primary cpu fails to
 	 * suspend for any reason.
 	 */
-	exynos5420_cpu_state = __raw_readl(sysram_base_addr +
-						EXYNOS5420_CPU_STATE);
+	exynos5420_cpu_state = readl_relaxed(sysram_base_addr +
+					     EXYNOS5420_CPU_STATE);
 
 	exynos_pm_enter_sleep_mode();
 
@@ -504,11 +504,11 @@ static void exynos5420_pm_resume(void)
 	/* Restore the CPU0 low power state register */
 	tmp = pmu_raw_readl(EXYNOS5_ARM_CORE0_SYS_PWR_REG);
 	pmu_raw_writel(tmp | S5P_CORE_LOCAL_PWR_EN,
-		EXYNOS5_ARM_CORE0_SYS_PWR_REG);
+		       EXYNOS5_ARM_CORE0_SYS_PWR_REG);
 
 	/* Restore the sysram cpu state register */
-	__raw_writel(exynos5420_cpu_state,
-		sysram_base_addr + EXYNOS5420_CPU_STATE);
+	writel_relaxed(exynos5420_cpu_state,
+		       sysram_base_addr + EXYNOS5420_CPU_STATE);
 
 	pmu_raw_writel(EXYNOS5420_USE_STANDBY_WFI_ALL,
 			S5P_CENTRAL_SEQ_OPTION);
-- 
2.8.1
