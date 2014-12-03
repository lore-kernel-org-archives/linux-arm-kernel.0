From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 03 Dec 2014 13:33:44 +0100
Subject: [PATCH v2 2/7] ARM: Exynos: add support for sub-power domains
In-Reply-To: <1416814256-24288-3-git-send-email-a.hajda@samsung.com>
References: <1416814256-24288-3-git-send-email-a.hajda@samsung.com>
Message-ID: <1417610024-29748-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for making one power domain a sub-domain of
other domain. This is useful for modeling power dependences for devices
like TV Mixer or Camera ISP, which needs to have more than one power
domain enabled to be operational.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 Documentation/devicetree/bindings/arm/exynos/power_domain.txt |  2 ++
 arch/arm/mach-exynos/pm_domains.c                             | 11 ++++++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/exynos/power_domain.txt b/Documentation/devicetree/bindings/arm/exynos/power_domain.txt
index abde1ea8a119..b884358ebb1a 100644
--- a/Documentation/devicetree/bindings/arm/exynos/power_domain.txt
+++ b/Documentation/devicetree/bindings/arm/exynos/power_domain.txt
@@ -22,6 +22,8 @@ Optional Properties:
 	- pclkN, clkN: Pairs of parent of input clock and input clock to the
 		devices in this power domain. Maximum of 4 pairs (N = 0 to 3)
 		are supported currently.
+- samsung,power-domain: phandle to a master power domain that the given domain
+		       is a part of
 
 Node of a device using power domains must have a samsung,power-domain property
 defined with a phandle to respective power domain.
diff --git a/arch/arm/mach-exynos/pm_domains.c b/arch/arm/mach-exynos/pm_domains.c
index 20f267121b3e..fa9a47ddad81 100644
--- a/arch/arm/mach-exynos/pm_domains.c
+++ b/arch/arm/mach-exynos/pm_domains.c
@@ -108,7 +108,7 @@ static int exynos_pd_power_off(struct generic_pm_domain *domain)
 static __init int exynos4_pm_init_power_domain(void)
 {
 	struct platform_device *pdev;
-	struct device_node *np;
+	struct device_node *np, *master_np;
 
 	for_each_compatible_node(np, NULL, "samsung,exynos4210-pd") {
 		struct exynos_pm_domain *pd;
@@ -159,6 +159,15 @@ no_clk:
 
 		pm_genpd_init(&pd->pd, NULL, !on);
 		of_genpd_add_provider_simple(np, &pd->pd);
+
+		/* make master and slave hierarchy */
+		master_np = of_parse_phandle(np, "samsung,power-domain", 0);
+		if (!master_np)
+			master_np = of_parse_phandle(np, "power-domains", 0);
+		if (master_np) {
+			pm_genpd_add_subdomain_names(master_np->name, np->name);
+			of_node_put(master_np);
+		}
 	}
 
 	return 0;
-- 
1.9.2
