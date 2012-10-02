From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 02 Oct 2012 11:24:03 +0200
Subject: [PATCH v2 1/4] ARM: EXYNOS: pm_domain: Detect domain state on
 registration from DT
In-Reply-To: <1349169846-30385-1-git-send-email-t.figa@samsung.com>
References: <1349169846-30385-1-git-send-email-t.figa@samsung.com>
Message-ID: <1349169846-30385-2-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Initial state of power domains might vary on different boards and with
different bootloaders. This patch adds detection of initial state of
power domains when being registered from DT.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 Documentation/devicetree/bindings/arm/exynos/power_domain.txt | 4 ----
 arch/arm/mach-exynos/pm_domains.c                             | 8 +++++---
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/exynos/power_domain.txt b/Documentation/devicetree/bindings/arm/exynos/power_domain.txt
index 6528e21..843b546 100644
--- a/Documentation/devicetree/bindings/arm/exynos/power_domain.txt
+++ b/Documentation/devicetree/bindings/arm/exynos/power_domain.txt
@@ -9,10 +9,6 @@ Required Properties:
 - reg: physical base address of the controller and length of memory mapped
     region.
 
-Optional Properties:
-- samsung,exynos4210-pd-off: Specifies that the power domain is in turned-off
-    state during boot and remains to be turned-off until explicitly turned-on.
-
 Example:
 
 	lcd0: power-domain-lcd0 {
diff --git a/arch/arm/mach-exynos/pm_domains.c b/arch/arm/mach-exynos/pm_domains.c
index c0bc83a..d1abc1a 100644
--- a/arch/arm/mach-exynos/pm_domains.c
+++ b/arch/arm/mach-exynos/pm_domains.c
@@ -89,6 +89,7 @@ static __init int exynos_pm_dt_parse_domains(void)
 
 	for_each_compatible_node(np, NULL, "samsung,exynos4210-pd") {
 		struct exynos_pm_domain *pd;
+		int on;
 
 		pd = kzalloc(sizeof(*pd), GFP_KERNEL);
 		if (!pd) {
@@ -97,14 +98,15 @@ static __init int exynos_pm_dt_parse_domains(void)
 			return -ENOMEM;
 		}
 
-		if (of_get_property(np, "samsung,exynos4210-pd-off", NULL))
-			pd->is_off = true;
 		pd->name = np->name;
 		pd->base = of_iomap(np, 0);
 		pd->pd.power_off = exynos_pd_power_off;
 		pd->pd.power_on = exynos_pd_power_on;
 		pd->pd.of_node = np;
-		pm_genpd_init(&pd->pd, NULL, false);
+
+		on = __raw_readl(pd->base + 0x4) & S5P_INT_LOCAL_PWR_EN;
+
+		pm_genpd_init(&pd->pd, NULL, !on);
 	}
 	return 0;
 }
-- 
1.7.12
