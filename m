From: vikas.sajjan@samsung.com (Vikas Sajjan)
Date: Wed, 09 Jul 2014 16:55:47 +0530
Subject: [PATCH 3/3] arm: exynos: Add PMU and S2R support for exynos5800 SoC
In-Reply-To: <1404905147-30319-1-git-send-email-vikas.sajjan@samsung.com>
References: <1404905147-30319-1-git-send-email-vikas.sajjan@samsung.com>
Message-ID: <1404905147-30319-4-git-send-email-vikas.sajjan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds PMU and S2R support for exynos5800 SoC.

Signed-off-by: Vikas Sajjan <vikas.sajjan@samsung.com>
---
 arch/arm/mach-exynos/pm.c       |    3 +++
 arch/arm/mach-exynos/pmu.c      |   22 ++++++++++++++++++++++
 arch/arm/mach-exynos/regs-pmu.h |    3 ++-
 3 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
index 5052261..908369f 100644
--- a/arch/arm/mach-exynos/pm.c
+++ b/arch/arm/mach-exynos/pm.c
@@ -807,6 +807,9 @@ static struct of_device_id exynos_pmu_of_device_ids[] = {
 	}, {
 		.compatible = "samsung,exynos5420-pmu",
 		.data = (void *)&exynos5420_pm_data,
+	}, {
+		.compatible = "samsung,exynos5800-pmu",
+		.data = (void *)&exynos5420_pm_data,
 	},
 	{ /*sentinel*/ },
 };
diff --git a/arch/arm/mach-exynos/pmu.c b/arch/arm/mach-exynos/pmu.c
index d8485a4..0dd0be0 100644
--- a/arch/arm/mach-exynos/pmu.c
+++ b/arch/arm/mach-exynos/pmu.c
@@ -718,6 +718,19 @@ static void exynos5420_pmu_init(void)
 	pr_info("EXYNOS5420 PMU initialized\n");
 }
 
+static void exynos5800_pmu_init(void)
+{
+	unsigned int value;
+
+	exynos5420_pmu_init();
+
+	value = pmu_raw_readl(EXYNOS5420_LPI_MASK);
+	value |= EXYNOS5800_POWER_GATE_CTRL;
+	pmu_raw_writel(value, EXYNOS5420_LPI_MASK);
+
+	pr_info("EXYNOS5800 PMU initialized\n");
+}
+
 
 static const struct exynos_pmu_data exynos4210_pmu_data = {
 	.pmu_config	= exynos4210_pmu_config,
@@ -744,6 +757,12 @@ static struct exynos_pmu_data exynos5420_pmu_data = {
 	.powerdown_conf	= exynos5420_powerdown_conf,
 };
 
+static struct exynos_pmu_data exynos5800_pmu_data = {
+	.pmu_config	= exynos5420_pmu_config,
+	.pmu_init	= exynos5800_pmu_init,
+	.powerdown_conf	= exynos5420_powerdown_conf,
+};
+
 static const struct regmap_config pmu_regmap_config = {
 	.reg_bits = 32,
 	.val_bits = 32,
@@ -769,6 +788,9 @@ static const struct of_device_id exynos_pmu_of_device_ids[] = {
 	}, {
 		.compatible = "samsung,exynos5420-pmu",
 		.data = (void *)&exynos5420_pmu_data,
+	}, {
+		.compatible = "samsung,exynos5800-pmu",
+		.data = (void *)&exynos5800_pmu_data,
 	},
 	{ /*sentinel*/ },
 };
diff --git a/arch/arm/mach-exynos/regs-pmu.h b/arch/arm/mach-exynos/regs-pmu.h
index 3a6a559..3a0140c 100644
--- a/arch/arm/mach-exynos/regs-pmu.h
+++ b/arch/arm/mach-exynos/regs-pmu.h
@@ -555,5 +555,6 @@ static inline unsigned int exynos_pmu_cpunr(unsigned int mpidr)
 					 | EXYNOS5420_KFC_USE_STANDBY_WFI1  \
 					 | EXYNOS5420_KFC_USE_STANDBY_WFI2  \
 					 | EXYNOS5420_KFC_USE_STANDBY_WFI3)
-
+/* for exynos5800 only */
+#define EXYNOS5800_POWER_GATE_CTRL                              (1 << 15)
 #endif /* __ASM_ARCH_REGS_PMU_H */
-- 
1.7.9.5
