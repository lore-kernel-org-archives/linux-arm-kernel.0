From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 15 Jun 2012 10:54:32 +0200
Subject: [PATCH 1/2] ARM: Exynos4: read initial state of power domain from hw
 registers
In-Reply-To: <1339750473-32699-1-git-send-email-m.szyprowski@samsung.com>
References: <1339750473-32699-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1339750473-32699-2-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some bootloaders disable unused power domains to reduce power
consuption. Power domain driver can easily read the actual state from
the hardware registers instead of assuming that their initial state is
always 'on'.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-exynos/pm_domains.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-exynos/pm_domains.c b/arch/arm/mach-exynos/pm_domains.c
index e9fafcf..0a952a5 100644
--- a/arch/arm/mach-exynos/pm_domains.c
+++ b/arch/arm/mach-exynos/pm_domains.c
@@ -151,9 +151,12 @@ static __init int exynos4_pm_init_power_domain(void)
 	if (of_have_populated_dt())
 		return exynos_pm_dt_parse_domains();
 
-	for (idx = 0; idx < ARRAY_SIZE(exynos4_pm_domains); idx++)
-		pm_genpd_init(&exynos4_pm_domains[idx]->pd, NULL,
-				exynos4_pm_domains[idx]->is_off);
+	for (idx = 0; idx < ARRAY_SIZE(exynos4_pm_domains); idx++) {
+		struct exynos_pm_domain *pd = exynos4_pm_domains[idx];
+		int on = __raw_readl(pd->base + 0x4) & S5P_INT_LOCAL_PWR_EN;
+
+		pm_genpd_init(&pd->pd, NULL, !on);
+	}
 
 #ifdef CONFIG_S5P_DEV_FIMD0
 	exynos_pm_add_dev_to_genpd(&s5p_device_fimd0, &exynos4_pd_lcd0);
-- 
1.7.1.569.g6f426
