From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 09 Feb 2015 08:25:41 +0100
Subject: [PATCH] exynos: pmu: use PS_HOLD based poweroff for all supported SoCs
Message-ID: <1423466741-11421-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PS_HOLD based power off procedure is common for all Exynos SoCs, so use
it for every Exynos SoC.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/mach-exynos/pmu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-exynos/pmu.c b/arch/arm/mach-exynos/pmu.c
index c15761ca2f18..e812c1c85624 100644
--- a/arch/arm/mach-exynos/pmu.c
+++ b/arch/arm/mach-exynos/pmu.c
@@ -681,7 +681,7 @@ static unsigned int const exynos5420_list_disable_pmu_reg[] = {
 	EXYNOS5420_CMU_RESET_FSYS_SYS_PWR_REG,
 };
 
-static void exynos5_power_off(void)
+static void exynos_power_off(void)
 {
 	unsigned int tmp;
 
@@ -872,8 +872,6 @@ static void exynos5420_pmu_init(void)
 			EXYNOS5420_ARM_INTR_SPREAD_USE_STANDBYWFI);
 
 	pmu_raw_writel(0x1, EXYNOS5420_UP_SCHEDULER);
-
-	pm_power_off = exynos5_power_off;
 	pr_info("EXYNOS5420 PMU initialized\n");
 }
 
@@ -984,6 +982,8 @@ static int exynos_pmu_probe(struct platform_device *pdev)
 	if (ret)
 		dev_warn(dev, "can't register restart handler err=%d\n", ret);
 
+	pm_power_off = exynos_power_off;
+
 	dev_dbg(dev, "Exynos PMU Driver probe done\n");
 	return 0;
 }
-- 
1.9.2
