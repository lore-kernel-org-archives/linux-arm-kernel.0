From: william.towle@codethink.co.uk (William Towle)
Date: Tue,  4 Feb 2014 18:17:38 +0000
Subject: [PATCH 3/3] clk: shmobile: handle multiple parent clocks for cpg
 clocks
In-Reply-To: <1391537858-28593-1-git-send-email-william.towle@codethink.co.uk>
References: <1391537858-28593-1-git-send-email-william.towle@codethink.co.uk>
Message-ID: <1391537858-28593-4-git-send-email-william.towle@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current action on registering the cpg_clocks is to have
them all registered with a single parent clock. This is not
the correct action, as some of the clocks such as the SDHI
and QSPI are actually parented to PLL1 or PLL1/2.

This also requires a change to the device-tree files to make
sure that appropriate parent clocks are assigned.

[ben.dooks at codethink.co.uk: updated patch description]
Signed-off-by: William Towle <william.towle@codethink.co.uk>
Reviewed-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/clk/shmobile/clk-rcar-gen2.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/shmobile/clk-rcar-gen2.c b/drivers/clk/shmobile/clk-rcar-gen2.c
index df4a1e6..57bc2e4 100644
--- a/drivers/clk/shmobile/clk-rcar-gen2.c
+++ b/drivers/clk/shmobile/clk-rcar-gen2.c
@@ -185,7 +185,7 @@ static u32 cpg_mode __initdata;
 static struct clk * __init
 rcar_gen2_cpg_register_clock(struct device_node *np, struct rcar_gen2_cpg *cpg,
 			     const struct cpg_pll_config *config,
-			     const char *name)
+			     const char *name, int index)
 {
 	const struct clk_div_table *table = NULL;
 	const char *parent_name = "main";
@@ -193,8 +193,13 @@ rcar_gen2_cpg_register_clock(struct device_node *np, struct rcar_gen2_cpg *cpg,
 	unsigned int mult = 1;
 	unsigned int div = 1;
 
+	parent_name = of_clk_get_parent_name(np, index);
+	if (!parent_name) {
+		pr_err("no parent set for clocks array\n");
+		return ERR_PTR(-ENOENT);
+	}
+
 	if (!strcmp(name, "main")) {
-		parent_name = of_clk_get_parent_name(np, 0);
 		div = config->extal_div;
 	} else if (!strcmp(name, "pll0")) {
 		/* PLL0 is a configurable multiplier clock. Register it as a
@@ -279,7 +284,7 @@ static void __init rcar_gen2_cpg_clocks_init(struct device_node *np)
 		of_property_read_string_index(np, "clock-output-names", i,
 					      &name);
 
-		clk = rcar_gen2_cpg_register_clock(np, cpg, config, name);
+		clk = rcar_gen2_cpg_register_clock(np, cpg, config, name, i);
 		if (IS_ERR(clk))
 			pr_err("%s: failed to register %s %s clock (%ld)\n",
 			       __func__, np->name, name, PTR_ERR(clk));
-- 
1.7.10.4
