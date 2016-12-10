From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sat, 10 Dec 2016 15:47:33 +0200
Subject: [PATCH 2/7] ARM: EXYNOS: Annotate iomem and pm_data pointers
 __ro_after_init
In-Reply-To: <1481377658-22603-1-git-send-email-krzk@kernel.org>
References: <1481377658-22603-1-git-send-email-krzk@kernel.org>
Message-ID: <1481377658-22603-2-git-send-email-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pointers to __iomem sysram and exynos_pm_data are set only during
initcalls.  Later the pointers itself are used only in read-only way so
we can mark them __ro_after_init to increase code safeness.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/mach-exynos/exynos.c      | 4 ++--
 arch/arm/mach-exynos/mcpm-exynos.c | 2 +-
 arch/arm/mach-exynos/suspend.c     | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index fa08ef99b4ad..a863f8ec0f7a 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -36,8 +36,8 @@ static struct platform_device exynos_cpuidle = {
 	.id                = -1,
 };
 
-void __iomem *sysram_base_addr;
-void __iomem *sysram_ns_base_addr;
+void __iomem *sysram_base_addr __ro_after_init;
+void __iomem *sysram_ns_base_addr __ro_after_init;
 
 void __init exynos_sysram_init(void)
 {
diff --git a/arch/arm/mach-exynos/mcpm-exynos.c b/arch/arm/mach-exynos/mcpm-exynos.c
index f086bf615b29..038fd8c993d0 100644
--- a/arch/arm/mach-exynos/mcpm-exynos.c
+++ b/arch/arm/mach-exynos/mcpm-exynos.c
@@ -32,7 +32,7 @@
 #define EXYNOS5420_USE_ARM_CORE_DOWN_STATE	BIT(29)
 #define EXYNOS5420_USE_L2_COMMON_UP_STATE	BIT(30)
 
-static void __iomem *ns_sram_base_addr;
+static void __iomem *ns_sram_base_addr __ro_after_init;
 
 /*
  * The common v7_exit_coherency_flush API could not be used because of the
diff --git a/arch/arm/mach-exynos/suspend.c b/arch/arm/mach-exynos/suspend.c
index d0e6ac7938f3..339fe011d658 100644
--- a/arch/arm/mach-exynos/suspend.c
+++ b/arch/arm/mach-exynos/suspend.c
@@ -64,7 +64,7 @@ struct exynos_pm_data {
 	int (*cpu_suspend)(unsigned long);
 };
 
-static const struct exynos_pm_data *pm_data;
+static const struct exynos_pm_data *pm_data __ro_after_init;
 
 static int exynos5420_cpu_state;
 static unsigned int exynos_pmu_spare3;
-- 
2.7.4
