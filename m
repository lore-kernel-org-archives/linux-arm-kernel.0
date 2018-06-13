From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 13 Jun 2018 13:41:15 +0200
Subject: [PATCH 1/1] soc: renesas: rcar-sysc: Make PM domain initialization
 more robust
In-Reply-To: <cover.1528889592.git.horms+renesas@verge.net.au>
References: <cover.1528889592.git.horms+renesas@verge.net.au>
Message-ID: <977d5ba4507dfe5b1346597ee57750262d8d2b19.1528889592.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

The quirk for R-Car E3 ES1.0 added in commit 086b399965a7ee7e ("soc:
renesas: r8a77990-sysc: Add workaround for 3DG-{A,B}") makes the 3DG-A
PM domain a subdomain of the 3DG-B PM domain.  However, registering
3DG-A with its parent fails silently, as the 3DG-B PM domain hasn't been
registered yet, and such failures are never reported.

Fix this by:
  1. Splitting PM Domain initialization in two steps, so all PM domains
     are registered before any child-parent links are established,
  2. Reporting any failures in establishing child-parent relations.

Check for and report pm_genpd_init() failures, too, as that function
gained a return value in commit 7eb231c337e00735 ("PM / Domains: Convert
pm_genpd_init() to return an error code").

Fixes: 086b399965a7ee7e ("soc: renesas: r8a77990-sysc: Add workaround for 3DG-{A,B}")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/soc/renesas/rcar-sysc.c | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/drivers/soc/renesas/rcar-sysc.c b/drivers/soc/renesas/rcar-sysc.c
index 95120acc4d80..50d03d8b4f9a 100644
--- a/drivers/soc/renesas/rcar-sysc.c
+++ b/drivers/soc/renesas/rcar-sysc.c
@@ -194,11 +194,12 @@ static int rcar_sysc_pd_power_on(struct generic_pm_domain *genpd)
 
 static bool has_cpg_mstp;
 
-static void __init rcar_sysc_pd_setup(struct rcar_sysc_pd *pd)
+static int __init rcar_sysc_pd_setup(struct rcar_sysc_pd *pd)
 {
 	struct generic_pm_domain *genpd = &pd->genpd;
 	const char *name = pd->genpd.name;
 	struct dev_power_governor *gov = &simple_qos_governor;
+	int error;
 
 	if (pd->flags & PD_CPU) {
 		/*
@@ -251,7 +252,11 @@ static void __init rcar_sysc_pd_setup(struct rcar_sysc_pd *pd)
 	rcar_sysc_power_up(&pd->ch);
 
 finalize:
-	pm_genpd_init(genpd, gov, false);
+	error = pm_genpd_init(genpd, gov, false);
+	if (error)
+		pr_err("Failed to init PM domain %s: %d\n", name, error);
+
+	return error;
 }
 
 static const struct of_device_id rcar_sysc_matches[] __initconst = {
@@ -375,6 +380,9 @@ static int __init rcar_sysc_pd_init(void)
 	pr_debug("%pOF: syscier = 0x%08x\n", np, syscier);
 	iowrite32(syscier, base + SYSCIER);
 
+	/*
+	 * First, create all PM domains
+	 */
 	for (i = 0; i < info->num_areas; i++) {
 		const struct rcar_sysc_area *area = &info->areas[i];
 		struct rcar_sysc_pd *pd;
@@ -397,14 +405,29 @@ static int __init rcar_sysc_pd_init(void)
 		pd->ch.isr_bit = area->isr_bit;
 		pd->flags = area->flags;
 
-		rcar_sysc_pd_setup(pd);
-		if (area->parent >= 0)
-			pm_genpd_add_subdomain(domains->domains[area->parent],
-					       &pd->genpd);
+		error = rcar_sysc_pd_setup(pd);
+		if (error)
+			goto out_put;
 
 		domains->domains[area->isr_bit] = &pd->genpd;
 	}
 
+	/*
+	 * Second, link all PM domains to their parents
+	 */
+	for (i = 0; i < info->num_areas; i++) {
+		const struct rcar_sysc_area *area = &info->areas[i];
+
+		if (!area->name || area->parent < 0)
+			continue;
+
+		error = pm_genpd_add_subdomain(domains->domains[area->parent],
+					       domains->domains[area->isr_bit]);
+		if (error)
+			pr_warn("Failed to add PM subdomain %s to parent %u\n",
+				area->name, area->parent);
+	}
+
 	error = of_genpd_add_provider_onecell(np, &domains->onecell_data);
 
 out_put:
-- 
2.11.0
