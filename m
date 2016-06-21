From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Tue, 21 Jun 2016 11:20:25 +0100
Subject: [[PATCH v2] 04/11] ARM: EXYNOS: fixup endian in pm/pmu
In-Reply-To: <1466504432-24187-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1466504432-24187-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1466504432-24187-5-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the PMU code endian access code to deal with kernels built for big endian
operation.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 arch/arm/mach-exynos/common.h     | 4 ++--
 arch/arm/mach-exynos/pm.c         | 4 ++--
 arch/arm/mach-exynos/pm_domains.c | 6 +++---
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
index 5365bf1..19e9d25 100644
--- a/arch/arm/mach-exynos/common.h
+++ b/arch/arm/mach-exynos/common.h
@@ -174,12 +174,12 @@ extern int exynos_get_boot_addr(u32 core_id, unsigned long *boot_addr);
 
 static inline void pmu_raw_writel(u32 val, u32 offset)
 {
-	__raw_writel(val, pmu_base_addr + offset);
+	writel_relaxed(val, pmu_base_addr + offset);
 }
 
 static inline u32 pmu_raw_readl(u32 offset)
 {
-	return __raw_readl(pmu_base_addr + offset);
+	return readl_relaxed(pmu_base_addr + offset);
 }
 
 #endif /* __ARCH_ARM_MACH_EXYNOS_COMMON_H */
diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
index c43b776..52d78eb 100644
--- a/arch/arm/mach-exynos/pm.c
+++ b/arch/arm/mach-exynos/pm.c
@@ -132,9 +132,9 @@ static void exynos_set_wakeupmask(long mask)
 
 static void exynos_cpu_set_boot_vector(long flags)
 {
-	__raw_writel(virt_to_phys(exynos_cpu_resume),
+	writel_relaxed(virt_to_phys(exynos_cpu_resume),
 		     exynos_boot_vector_addr());
-	__raw_writel(flags, exynos_boot_vector_flag());
+	writel_relaxed(flags, exynos_boot_vector_flag());
 }
 
 static int exynos_aftr_finisher(unsigned long flags)
diff --git a/arch/arm/mach-exynos/pm_domains.c b/arch/arm/mach-exynos/pm_domains.c
index 875a2ba..0e075d9 100644
--- a/arch/arm/mach-exynos/pm_domains.c
+++ b/arch/arm/mach-exynos/pm_domains.c
@@ -70,12 +70,12 @@ static int exynos_pd_power(struct generic_pm_domain *domain, bool power_on)
 	}
 
 	pwr = power_on ? INT_LOCAL_PWR_EN : 0;
-	__raw_writel(pwr, base);
+	writel_relaxed(pwr, base);
 
 	/* Wait max 1ms */
 	timeout = 10;
 
-	while ((__raw_readl(base + 0x4) & INT_LOCAL_PWR_EN) != pwr) {
+	while ((readl_relaxed(base + 0x4) & INT_LOCAL_PWR_EN) != pwr) {
 		if (!timeout) {
 			op = (power_on) ? "enable" : "disable";
 			pr_err("Power domain %s %s failed\n", domain->name, op);
@@ -185,7 +185,7 @@ static __init int exynos4_pm_init_power_domain(void)
 			clk_put(pd->oscclk);
 
 no_clk:
-		on = __raw_readl(pd->base + 0x4) & INT_LOCAL_PWR_EN;
+		on = readl_relaxed(pd->base + 0x4) & INT_LOCAL_PWR_EN;
 
 		pm_genpd_init(&pd->pd, NULL, !on);
 		of_genpd_add_provider_simple(np, &pd->pd);
-- 
2.8.1
