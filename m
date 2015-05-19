From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 19 May 2015 15:20:38 +0200
Subject: [PATCH v7 18/25] ARM: Exynos: pm_domains: register power domain driver
 from core_initcall
In-Reply-To: <1432041645-11172-1-git-send-email-m.szyprowski@samsung.com>
References: <1432041645-11172-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1432041645-11172-19-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SYSMMU devices are registered very early in arch_initcall, so ensure
that they can get access to power domains by registering power domain
driver from earlier initcall. This change requires dropping usage of the
platform device associated with each power domain and replacing clock
calls with respective of_clk_* equivalents.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/mach-exynos/pm_domains.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-exynos/pm_domains.c b/arch/arm/mach-exynos/pm_domains.c
index a9686535f9ed..6864178e21b9 100644
--- a/arch/arm/mach-exynos/pm_domains.c
+++ b/arch/arm/mach-exynos/pm_domains.c
@@ -117,16 +117,11 @@ static int exynos_pd_power_off(struct generic_pm_domain *domain)
 
 static __init int exynos4_pm_init_power_domain(void)
 {
-	struct platform_device *pdev;
 	struct device_node *np;
 
 	for_each_compatible_node(np, NULL, "samsung,exynos4210-pd") {
 		struct exynos_pm_domain *pd;
 		int on, i;
-		struct device *dev;
-
-		pdev = of_find_device_by_node(np);
-		dev = &pdev->dev;
 
 		pd = kzalloc(sizeof(*pd), GFP_KERNEL);
 		if (!pd) {
@@ -135,7 +130,8 @@ static __init int exynos4_pm_init_power_domain(void)
 			return -ENOMEM;
 		}
 
-		pd->pd.name = kstrdup(dev_name(dev), GFP_KERNEL);
+		pd->pd.name = kstrdup_const(strrchr(np->full_name, '/') + 1,
+					    GFP_KERNEL);
 		pd->name = pd->pd.name;
 		pd->base = of_iomap(np, 0);
 		pd->pd.power_off = exynos_pd_power_off;
@@ -145,12 +141,12 @@ static __init int exynos4_pm_init_power_domain(void)
 			char clk_name[8];
 
 			snprintf(clk_name, sizeof(clk_name), "asb%d", i);
-			pd->asb_clk[i] = clk_get(dev, clk_name);
+			pd->asb_clk[i] = of_clk_get_by_name(np, clk_name);
 			if (IS_ERR(pd->asb_clk[i]))
 				break;
 		}
 
-		pd->oscclk = clk_get(dev, "oscclk");
+		pd->oscclk = of_clk_get_by_name(np, "oscclk");
 		if (IS_ERR(pd->oscclk))
 			goto no_clk;
 
@@ -158,11 +154,11 @@ static __init int exynos4_pm_init_power_domain(void)
 			char clk_name[8];
 
 			snprintf(clk_name, sizeof(clk_name), "clk%d", i);
-			pd->clk[i] = clk_get(dev, clk_name);
+			pd->clk[i] = of_clk_get_by_name(np, clk_name);
 			if (IS_ERR(pd->clk[i]))
 				break;
 			snprintf(clk_name, sizeof(clk_name), "pclk%d", i);
-			pd->pclk[i] = clk_get(dev, clk_name);
+			pd->pclk[i] = of_clk_get_by_name(np, clk_name);
 			if (IS_ERR(pd->pclk[i])) {
 				clk_put(pd->clk[i]);
 				pd->clk[i] = ERR_PTR(-EINVAL);
@@ -210,4 +206,4 @@ no_clk:
 
 	return 0;
 }
-arch_initcall(exynos4_pm_init_power_domain);
+core_initcall(exynos4_pm_init_power_domain);
-- 
1.9.2
