From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Fri, 13 Nov 2015 14:59:36 +0530
Subject: [PATCH v5 2/9] ARM: EXYNOS: Fix potential NULL pointer access in
 exynos_sys_powerdown_conf
In-Reply-To: <1447406983-27835-1-git-send-email-pankaj.dubey@samsung.com>
References: <1447406983-27835-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <1447406983-27835-3-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If no platform devices binded to the driver but driver itself loaded and
exynos_sys_powerdown_conf is called from
arch/arm/mach-exynos/{suspend.c, pm.c} it will result in NULL pointer access,
to prevent this added check on pmu_context for NULL.

Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/mach-exynos/pmu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-exynos/pmu.c b/arch/arm/mach-exynos/pmu.c
index 64ea7d6..d40f7e9 100644
--- a/arch/arm/mach-exynos/pmu.c
+++ b/arch/arm/mach-exynos/pmu.c
@@ -749,8 +749,12 @@ static void exynos5_powerdown_conf(enum sys_powerdown mode)
 void exynos_sys_powerdown_conf(enum sys_powerdown mode)
 {
 	unsigned int i;
+	const struct exynos_pmu_data *pmu_data;
+
+	if (!pmu_context)
+		return;
 
-	const struct exynos_pmu_data *pmu_data = pmu_context->pmu_data;
+	pmu_data = pmu_context->pmu_data;
 
 	if (pmu_data->powerdown_conf)
 		pmu_data->powerdown_conf(mode);
-- 
2.4.5
