From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 27 Mar 2015 13:28:25 +0100
Subject: [PATCH v2 3/3] ARM: EXYNOS: Add missing of_node_put() when parsing
 power domains
In-Reply-To: <1427459305-26625-1-git-send-email-k.kozlowski@samsung.com>
References: <1427459305-26625-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1427459305-26625-3-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add missing of_node_put() to:
1. Error return path if allocating memory for exynos_pm_domain failed.
2. Second iteration over power domains if a child domain was not present
   or was incomplete.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Reported-by: Karol Wrona <k.wrona@samsung.com>

---
Changes since v1:
1. New patch.
---
 arch/arm/mach-exynos/pm_domains.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-exynos/pm_domains.c b/arch/arm/mach-exynos/pm_domains.c
index 61c32ccc9f7a..1a90c5da2fd7 100644
--- a/arch/arm/mach-exynos/pm_domains.c
+++ b/arch/arm/mach-exynos/pm_domains.c
@@ -138,6 +138,7 @@ static __init int exynos4_pm_init_power_domain(void)
 		if (!pd) {
 			pr_err("%s: failed to allocate memory for domain\n",
 					__func__);
+			of_node_put(np);
 			return -ENOMEM;
 		}
 
@@ -209,15 +210,15 @@ no_clk:
 		args.args_count = 0;
 		child_domain = of_genpd_get_from_provider(&args);
 		if (!child_domain)
-			continue;
+			goto next_pd;
 
 		if (of_parse_phandle_with_args(np, "power-domains",
 					 "#power-domain-cells", 0, &args) != 0)
-			continue;
+			goto next_pd;
 
 		parent_domain = of_genpd_get_from_provider(&args);
 		if (!parent_domain)
-			continue;
+			goto next_pd;
 
 		if (pm_genpd_add_subdomain(parent_domain, child_domain))
 			pr_warn("%s failed to add subdomain: %s\n",
@@ -225,6 +226,7 @@ no_clk:
 		else
 			pr_info("%s has as child subdomain: %s.\n",
 				parent_domain->name, child_domain->name);
+next_pd:
 		of_node_put(np);
 	}
 
-- 
1.9.1
