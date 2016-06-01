From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Wed,  1 Jun 2016 16:15:07 -0700
Subject: [PATCH 08/34] clk: asm9260: Migrate to clk_hw based registration and
 OF APIs
In-Reply-To: <20160601231533.9354-1-stephen.boyd@linaro.org>
References: <20160601231533.9354-1-stephen.boyd@linaro.org>
Message-ID: <20160601231533.9354-9-stephen.boyd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have clk_hw based provider APIs to register clks, we
can get rid of struct clk pointers while registering clks in
these drivers, allowing us to move closer to a clear split of
consumer and provider clk APIs.

Cc: Oleksij Rempel <linux@rempel-privat.de>
Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---

See commit 58657d189a2f and it's children for details on this
new registration API.

 drivers/clk/clk-asm9260.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/clk/clk-asm9260.c b/drivers/clk/clk-asm9260.c
index 90897af8d9f7..ea8568536193 100644
--- a/drivers/clk/clk-asm9260.c
+++ b/drivers/clk/clk-asm9260.c
@@ -68,8 +68,7 @@
 #define HW_LCDCLKDIV		0x01fc
 #define HW_ADCANACLKDIV		0x0200
 
-static struct clk *clks[MAX_CLKS];
-static struct clk_onecell_data clk_data;
+static struct clk_hw_onecell_data *clk_data;
 static DEFINE_SPINLOCK(asm9260_clk_lock);
 
 struct asm9260_div_clk {
@@ -267,12 +266,20 @@ static struct asm9260_mux_clock asm9260_mux_clks[] __initdata = {
 
 static void __init asm9260_acc_init(struct device_node *np)
 {
-	struct clk *clk;
+	struct clk_hw *hw;
+	struct clk_hw **hws;
 	const char *ref_clk, *pll_clk = "pll";
 	u32 rate;
 	int n;
 	u32 accuracy = 0;
 
+	clk_data = kzalloc(sizeof(*clk_data) +
+			   sizeof(*clk_data->hws) * MAX_CLKS, GFP_KERNEL);
+	if (!clk_data)
+		return;
+	clk_data->num = MAX_CLKS;
+	hws = clk_data->hws;
+
 	base = of_io_request_and_map(np, 0, np->name);
 	if (IS_ERR(base))
 		panic("%s: unable to map resource", np->name);
@@ -282,10 +289,10 @@ static void __init asm9260_acc_init(struct device_node *np)
 
 	ref_clk = of_clk_get_parent_name(np, 0);
 	accuracy = clk_get_accuracy(__clk_lookup(ref_clk));
-	clk = clk_register_fixed_rate_with_accuracy(NULL, pll_clk,
+	hw = clk_hw_register_fixed_rate_with_accuracy(NULL, pll_clk,
 			ref_clk, 0, rate, accuracy);
 
-	if (IS_ERR(clk))
+	if (IS_ERR(hw))
 		panic("%s: can't register REFCLK. Check DT!", np->name);
 
 	for (n = 0; n < ARRAY_SIZE(asm9260_mux_clks); n++) {
@@ -293,7 +300,7 @@ static void __init asm9260_acc_init(struct device_node *np)
 
 		mc->parent_names[0] = ref_clk;
 		mc->parent_names[1] = pll_clk;
-		clk = clk_register_mux_table(NULL, mc->name, mc->parent_names,
+		hw = clk_hw_register_mux_table(NULL, mc->name, mc->parent_names,
 				mc->num_parents, mc->flags, base + mc->offset,
 				0, mc->mask, 0, mc->table, &asm9260_clk_lock);
 	}
@@ -302,7 +309,7 @@ static void __init asm9260_acc_init(struct device_node *np)
 	for (n = 0; n < ARRAY_SIZE(asm9260_mux_gates); n++) {
 		const struct asm9260_gate_data *gd = &asm9260_mux_gates[n];
 
-		clk = clk_register_gate(NULL, gd->name,
+		hw = clk_hw_register_gate(NULL, gd->name,
 			gd->parent_name, gd->flags | CLK_SET_RATE_PARENT,
 			base + gd->reg, gd->bit_idx, 0, &asm9260_clk_lock);
 	}
@@ -311,7 +318,7 @@ static void __init asm9260_acc_init(struct device_node *np)
 	for (n = 0; n < ARRAY_SIZE(asm9260_div_clks); n++) {
 		const struct asm9260_div_clk *dc = &asm9260_div_clks[n];
 
-		clks[dc->idx] = clk_register_divider(NULL, dc->name,
+		hws[dc->idx] = clk_hw_register_divider(NULL, dc->name,
 				dc->parent_name, CLK_SET_RATE_PARENT,
 				base + dc->reg, 0, 8, CLK_DIVIDER_ONE_BASED,
 				&asm9260_clk_lock);
@@ -321,14 +328,14 @@ static void __init asm9260_acc_init(struct device_node *np)
 	for (n = 0; n < ARRAY_SIZE(asm9260_ahb_gates); n++) {
 		const struct asm9260_gate_data *gd = &asm9260_ahb_gates[n];
 
-		clks[gd->idx] = clk_register_gate(NULL, gd->name,
+		hws[gd->idx] = clk_hw_register_gate(NULL, gd->name,
 				gd->parent_name, gd->flags, base + gd->reg,
 				gd->bit_idx, 0, &asm9260_clk_lock);
 	}
 
 	/* check for errors on leaf clocks */
 	for (n = 0; n < MAX_CLKS; n++) {
-		if (!IS_ERR(clks[n]))
+		if (!IS_ERR(hws[n]))
 			continue;
 
 		pr_err("%s: Unable to register leaf clock %d\n",
@@ -337,9 +344,7 @@ static void __init asm9260_acc_init(struct device_node *np)
 	}
 
 	/* register clk-provider */
-	clk_data.clks = clks;
-	clk_data.clk_num = MAX_CLKS;
-	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
+	of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_data);
 	return;
 fail:
 	iounmap(base);
-- 
2.7.4
