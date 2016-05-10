From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 10 May 2016 15:52:21 +0200
Subject: [PATCH 2/2] soc: samsung: pm_domains: Prepare for supporting ARMv8
 Exynos
In-Reply-To: <1462888341-21963-1-git-send-email-k.kozlowski@samsung.com>
References: <1462888341-21963-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1462888341-21963-2-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ARMv8 Exynos family (Exynos5433 and Exynos7420) uses different value
(0xf instead of 0x7) for controlling the power domain on/off registers
(both for control and for status).

Choose the value depending on the compatible. This prepares the driver
for supporting ARMv8 SoCs.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/soc/samsung/pm_domains.c | 34 ++++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/drivers/soc/samsung/pm_domains.c b/drivers/soc/samsung/pm_domains.c
index 875a2bab64f6..f60515eefb66 100644
--- a/drivers/soc/samsung/pm_domains.c
+++ b/drivers/soc/samsung/pm_domains.c
@@ -23,9 +23,13 @@
 #include <linux/of_platform.h>
 #include <linux/sched.h>
 
-#define INT_LOCAL_PWR_EN	0x7
 #define MAX_CLK_PER_DOMAIN	4
 
+struct exynos_pm_domain_config {
+	/* Value for LOCAL_PWR_CFG and STATUS fields for each domain */
+	u32 local_pwr_cfg;
+};
+
 /*
  * Exynos specific wrapper around the generic power domain
  */
@@ -38,6 +42,7 @@ struct exynos_pm_domain {
 	struct clk *clk[MAX_CLK_PER_DOMAIN];
 	struct clk *pclk[MAX_CLK_PER_DOMAIN];
 	struct clk *asb_clk[MAX_CLK_PER_DOMAIN];
+	u32 local_pwr_cfg;
 };
 
 static int exynos_pd_power(struct generic_pm_domain *domain, bool power_on)
@@ -69,13 +74,13 @@ static int exynos_pd_power(struct generic_pm_domain *domain, bool power_on)
 		}
 	}
 
-	pwr = power_on ? INT_LOCAL_PWR_EN : 0;
+	pwr = power_on ? pd->local_pwr_cfg : 0;
 	__raw_writel(pwr, base);
 
 	/* Wait max 1ms */
 	timeout = 10;
 
-	while ((__raw_readl(base + 0x4) & INT_LOCAL_PWR_EN) != pwr) {
+	while ((__raw_readl(base + 0x4) & pd->local_pwr_cfg) != pwr) {
 		if (!timeout) {
 			op = (power_on) ? "enable" : "disable";
 			pr_err("Power domain %s %s failed\n", domain->name, op);
@@ -119,14 +124,30 @@ static int exynos_pd_power_off(struct generic_pm_domain *domain)
 	return exynos_pd_power(domain, false);
 }
 
+static const struct exynos_pm_domain_config exynos4210_cfg __initconst = {
+	.local_pwr_cfg		= 0x7,
+};
+
+static const struct of_device_id exynos_pm_domain_of_match[] __initconst = {
+	{
+		.compatible = "samsung,exynos4210-pd",
+		.data = &exynos4210_cfg,
+	},
+	{ },
+};
+
 static __init int exynos4_pm_init_power_domain(void)
 {
 	struct device_node *np;
+	const struct of_device_id *match;
 
-	for_each_compatible_node(np, NULL, "samsung,exynos4210-pd") {
+	for_each_matching_node_and_match(np, exynos_pm_domain_of_match, &match) {
+		const struct exynos_pm_domain_config *pm_domain_cfg;
 		struct exynos_pm_domain *pd;
 		int on, i;
 
+		pm_domain_cfg = match->data;
+
 		pd = kzalloc(sizeof(*pd), GFP_KERNEL);
 		if (!pd) {
 			pr_err("%s: failed to allocate memory for domain\n",
@@ -153,6 +174,7 @@ static __init int exynos4_pm_init_power_domain(void)
 
 		pd->pd.power_off = exynos_pd_power_off;
 		pd->pd.power_on = exynos_pd_power_on;
+		pd->local_pwr_cfg = pm_domain_cfg->local_pwr_cfg;
 
 		for (i = 0; i < MAX_CLK_PER_DOMAIN; i++) {
 			char clk_name[8];
@@ -185,14 +207,14 @@ static __init int exynos4_pm_init_power_domain(void)
 			clk_put(pd->oscclk);
 
 no_clk:
-		on = __raw_readl(pd->base + 0x4) & INT_LOCAL_PWR_EN;
+		on = __raw_readl(pd->base + 0x4) & pd->local_pwr_cfg;
 
 		pm_genpd_init(&pd->pd, NULL, !on);
 		of_genpd_add_provider_simple(np, &pd->pd);
 	}
 
 	/* Assign the child power domains to their parents */
-	for_each_compatible_node(np, NULL, "samsung,exynos4210-pd") {
+	for_each_matching_node(np, exynos_pm_domain_of_match) {
 		struct generic_pm_domain *child_domain, *parent_domain;
 		struct of_phandle_args args;
 
-- 
1.9.1
