From: jonathanh@nvidia.com (Jon Hunter)
Date: Fri, 4 Mar 2016 11:23:48 +0000
Subject: [RFC PATCH 2/8] ARM: EXYNOS: Remove calls to
 of_genpd_get_from_provider()
In-Reply-To: <1457090634-14785-1-git-send-email-jonathanh@nvidia.com>
References: <1457090634-14785-1-git-send-email-jonathanh@nvidia.com>
Message-ID: <1457090634-14785-3-git-send-email-jonathanh@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update the EXYNOS PM domain code to use the of_genpd_add_subdomain()
and remove any calls to of_genpd_get_from_provider().

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 arch/arm/mach-exynos/pm_domains.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-exynos/pm_domains.c b/arch/arm/mach-exynos/pm_domains.c
index 7c21760f590f..871f72a292ae 100644
--- a/arch/arm/mach-exynos/pm_domains.c
+++ b/arch/arm/mach-exynos/pm_domains.c
@@ -193,29 +193,22 @@ no_clk:
 
 	/* Assign the child power domains to their parents */
 	for_each_compatible_node(np, NULL, "samsung,exynos4210-pd") {
-		struct generic_pm_domain *child_domain, *parent_domain;
-		struct of_phandle_args args;
+		struct of_phandle_args child, parent;
 
-		args.np = np;
-		args.args_count = 0;
-		child_domain = of_genpd_get_from_provider(&args);
-		if (IS_ERR(child_domain))
-			continue;
+		child.np = np;
+		child.args_count = 0;
 
 		if (of_parse_phandle_with_args(np, "power-domains",
-					 "#power-domain-cells", 0, &args) != 0)
-			continue;
-
-		parent_domain = of_genpd_get_from_provider(&args);
-		if (IS_ERR(parent_domain))
+					       "#power-domain-cells", 0,
+					       &parent) != 0)
 			continue;
 
-		if (pm_genpd_add_subdomain(parent_domain, child_domain))
+		if (of_genpd_add_subdomain(&parent, &child))
 			pr_warn("%s failed to add subdomain: %s\n",
-				parent_domain->name, child_domain->name);
+				parent.np->name, child.np->name);
 		else
 			pr_info("%s has as child subdomain: %s.\n",
-				parent_domain->name, child_domain->name);
+				parent.np->name, child.np->name);
 	}
 
 	return 0;
-- 
2.1.4
