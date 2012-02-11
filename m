From: hs1218.kang@samsung.com (Huisung Kang)
Date: Sat, 11 Feb 2012 16:04:00 +0900
Subject: [PATCH 2/2] ARM: SAMSUNG: Fix PMU platform device for EXYNOS SoC
Message-ID: <019001cce88b$54f3e530$fedbaf90$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Exynos4210, Exynos4212 has 2 core and Exynos4412 has 4 core and
each core has its own PMU IRQ. Configure these PMU IRQs for
performance monitor unit.

Signed-off-by: Huisung Kang <hs1218.kang@samsung.com>
---
 arch/arm/plat-samsung/devs.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-samsung/devs.c b/arch/arm/plat-samsung/devs.c
index 32a6e39..3e38dc4 100644
--- a/arch/arm/plat-samsung/devs.c
+++ b/arch/arm/plat-samsung/devs.c
@@ -1073,7 +1073,14 @@ struct platform_device s5p_device_onenand = {
 
 #ifdef CONFIG_PLAT_S5P
 static struct resource s5p_pmu_resource[] = {
-	DEFINE_RES_IRQ(IRQ_PMU)
+	[0] = DEFINE_RES_IRQ(IRQ_PMU),
+#if CONFIG_NR_CPUS > 1
+	[1] = DEFINE_RES_IRQ(IRQ_PMU_CPU1),
+#endif
+#if CONFIG_NR_CPUS > 2
+	[2] = DEFINE_RES_IRQ(IRQ_PMU_CPU2),
+	[3] = DEFINE_RES_IRQ(IRQ_PMU_CPU3),
+#endif
 };
 
 struct platform_device s5p_device_pmu = {
-- 
1.7.1
