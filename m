From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 10 Apr 2013 15:02:57 -0700
Subject: [PATCH v2 3/3] clk: sunxi: Unify oscillator clock
In-Reply-To: <1365631378-16103-1-git-send-email-mturquette@linaro.org>
References: <1365515284-32061-2-git-send-email-emilio@elopez.com.ar>
 <1365631378-16103-1-git-send-email-mturquette@linaro.org>
Message-ID: <1365631378-16103-4-git-send-email-mturquette@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Emilio L?pez <emilio@elopez.com.ar>

This commit uses the new fixed-rate support on the composite clock to
unify osc24M_fixed and osc24M clocks, so it matches the actual hardware.

Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
Signed-off-by: Mike Turquette <mturquette@linaro.org>
[mturquette at linaro.org: replace clk_register_gatable_osc with a call to
clk_register_composite]
---
Emilio,

I haven't been able to test these changes at run-time.  Can you see if
they are valid for solving your issue on sunxi?

 drivers/clk/sunxi/clk-sunxi.c |   33 ++++++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index 0bb0eb4..8492ad1 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -33,16 +33,36 @@ static DEFINE_SPINLOCK(clk_lock);
 static void __init sunxi_osc_clk_setup(struct device_node *node)
 {
 	struct clk *clk;
+	struct clk_fixed_rate *fixed;
+	struct clk_gate *gate;
 	const char *clk_name = node->name;
-	const char *parent;
-	void *reg;
+	u32 rate;
 
-	reg = of_iomap(node, 0);
+	/* allocate fixed-rate and gate clock structs */
+	fixed = kzalloc(sizeof(struct clk_fixed_rate), GFP_KERNEL);
+	if (!fixed)
+		return;
+	gate = kzalloc(sizeof(struct clk_gate), GFP_KERNEL);
+	if (!gate) {
+		kfree(fixed);
+		return;
+	}
 
-	parent = of_clk_get_parent_name(node, 0);
+	if (of_property_read_u32(node, "clock-frequency", &rate))
+		return;
+
+	/* set up gate and fixed rate properties */
+	gate->reg = of_iomap(node, 0);
+	gate->bit_idx = SUNXI_OSC24M_GATE;
+	gate->lock = &clk_lock;
+	fixed->fixed_rate = rate;
 
-	clk = clk_register_gate(NULL, clk_name, parent, 0, reg,
-				SUNXI_OSC24M_GATE, 0, &clk_lock);
+	clk = clk_register_composite(NULL, clk_name,
+			NULL, 0,
+			NULL, NULL,
+			&fixed->hw, &clk_fixed_rate_ops,
+			&gate->hw, &clk_gate_ops,
+			CLK_IS_ROOT);
 
 	if (clk) {
 		of_clk_add_provider(node, of_clk_src_simple_get, clk);
@@ -380,7 +400,6 @@ static void __init sunxi_gates_clk_setup(struct device_node *node,
 
 /* Matches for of_clk_init */
 static const __initconst struct of_device_id clk_match[] = {
-	{.compatible = "fixed-clock", .data = of_fixed_clk_setup,},
 	{.compatible = "allwinner,sun4i-osc-clk", .data = sunxi_osc_clk_setup,},
 	{}
 };
-- 
1.7.10.4
