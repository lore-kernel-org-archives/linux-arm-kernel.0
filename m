From: jonathanh@nvidia.com (Jon Hunter)
Date: Tue, 16 Aug 2016 10:49:28 +0100
Subject: [PATCH 02/10] ARM: EXYNOS: Remove calls to
 of_genpd_get_from_provider()
In-Reply-To: <1471340976-5379-1-git-send-email-jonathanh@nvidia.com>
References: <1471340976-5379-1-git-send-email-jonathanh@nvidia.com>
Message-ID: <1471340976-5379-3-git-send-email-jonathanh@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update the EXYNOS PM domain code to use the of_genpd_add_subdomain()
and remove any calls to of_genpd_get_from_provider().

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/soc/samsung/pm_domains.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/soc/samsung/pm_domains.c b/drivers/soc/samsung/pm_domains.c
index 4822346aadc6..7112004b8032 100644
--- a/drivers/soc/samsung/pm_domains.c
+++ b/drivers/soc/samsung/pm_domains.c
@@ -215,29 +215,22 @@ no_clk:
 
 	/* Assign the child power domains to their parents */
 	for_each_matching_node(np, exynos_pm_domain_of_match) {
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
