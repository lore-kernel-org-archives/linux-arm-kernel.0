From: t.figa@samsung.com (Tomasz Figa)
Date: Fri, 14 Jun 2013 21:32:40 +0200
Subject: [PATCH 04/28] ARM: EXYNOS: common: Remove legacy PMU initialization
 code
In-Reply-To: <1371238384-1504-1-git-send-email-t.figa@samsung.com>
References: <1371238384-1504-1-git-send-email-t.figa@samsung.com>
Message-ID: <1371238384-1504-5-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes legacy PMU initialization code that was used to set
up PMU when booting with ATAGS, which is not supported any more.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-exynos/common.c | 27 ---------------------------
 1 file changed, 27 deletions(-)

diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
index 98343577..cb07f4a 100644
--- a/arch/arm/mach-exynos/common.c
+++ b/arch/arm/mach-exynos/common.c
@@ -922,30 +922,3 @@ static int __init exynos_init_irq_eint(void)
 	return 0;
 }
 arch_initcall(exynos_init_irq_eint);
-
-static struct resource exynos4_pmu_resource[] = {
-	DEFINE_RES_IRQ(EXYNOS4_IRQ_PMU),
-	DEFINE_RES_IRQ(EXYNOS4_IRQ_PMU_CPU1),
-#if defined(CONFIG_SOC_EXYNOS4412)
-	DEFINE_RES_IRQ(EXYNOS4_IRQ_PMU_CPU2),
-	DEFINE_RES_IRQ(EXYNOS4_IRQ_PMU_CPU3),
-#endif
-};
-
-static struct platform_device exynos4_device_pmu = {
-	.name		= "arm-pmu",
-	.num_resources	= ARRAY_SIZE(exynos4_pmu_resource),
-	.resource	= exynos4_pmu_resource,
-};
-
-static int __init exynos_armpmu_init(void)
-{
-	if (!of_have_populated_dt()) {
-		if (soc_is_exynos4210() || soc_is_exynos4212())
-			exynos4_device_pmu.num_resources = 2;
-		platform_device_register(&exynos4_device_pmu);
-	}
-
-	return 0;
-}
-arch_initcall(exynos_armpmu_init);
-- 
1.8.2.1
