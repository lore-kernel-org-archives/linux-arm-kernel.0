From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 02 Feb 2015 14:20:21 +0100
Subject: [PATCH v5 2/9] ARM: Exynos: add support for sub-power domains
In-Reply-To: <1422883228-10690-1-git-send-email-m.szyprowski@samsung.com>
References: <1422883228-10690-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1422883228-10690-3-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for making one power domain a sub-domain of
other domain. This is useful for modeling power dependences for devices
like TV Mixer or Camera ISP, which needs to have more than one power
domain enabled to be operational.

Based on previous work by Amit Daniel Kachhap <amit.daniel@samsung.com>.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 .../bindings/arm/exynos/power_domain.txt           |  2 ++
 arch/arm/mach-exynos/pm_domains.c                  | 28 ++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/exynos/power_domain.txt b/Documentation/devicetree/bindings/arm/exynos/power_domain.txt
index f4445e5a2bbb..1e097037349c 100644
--- a/Documentation/devicetree/bindings/arm/exynos/power_domain.txt
+++ b/Documentation/devicetree/bindings/arm/exynos/power_domain.txt
@@ -22,6 +22,8 @@ Optional Properties:
 	- pclkN, clkN: Pairs of parent of input clock and input clock to the
 		devices in this power domain. Maximum of 4 pairs (N = 0 to 3)
 		are supported currently.
+- power-domains: phandle pointing to the parent power domain, for more details
+		 see Documentation/devicetree/bindings/power/power_domain.txt
 
 Node of a device using power domains must have a power-domains property
 defined with a phandle to respective power domain.
diff --git a/arch/arm/mach-exynos/pm_domains.c b/arch/arm/mach-exynos/pm_domains.c
index 20f267121b3e..37266a826437 100644
--- a/arch/arm/mach-exynos/pm_domains.c
+++ b/arch/arm/mach-exynos/pm_domains.c
@@ -161,6 +161,34 @@ no_clk:
 		of_genpd_add_provider_simple(np, &pd->pd);
 	}
 
+	/* Assign the child power domains to their parents */
+	for_each_compatible_node(np, NULL, "samsung,exynos4210-pd") {
+		struct generic_pm_domain *child_domain, *parent_domain;
+		struct of_phandle_args args;
+
+		args.np = np;
+		args.args_count = 0;
+		child_domain = of_genpd_get_from_provider(&args);
+		if (!child_domain)
+			continue;
+
+		if (of_parse_phandle_with_args(np, "power-domains",
+					 "#power-domain-cells", 0, &args) != 0)
+			continue;
+
+		parent_domain = of_genpd_get_from_provider(&args);
+		if (!parent_domain)
+			continue;
+
+		if (pm_genpd_add_subdomain(parent_domain, child_domain))
+			pr_warn("%s failed to add subdomain: %s\n",
+				parent_domain->name, child_domain->name);
+		else
+			pr_info("%s has as child subdomain: %s.\n",
+				parent_domain->name, child_domain->name);
+		of_node_put(np);
+	}
+
 	return 0;
 }
 arch_initcall(exynos4_pm_init_power_domain);
-- 
1.9.2
