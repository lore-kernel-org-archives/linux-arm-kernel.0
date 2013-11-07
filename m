From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Thu,  7 Nov 2013 16:07:08 +0100
Subject: [PATCH 4/4] ARM: socfpga: clk: add clk_divider to periph
In-Reply-To: <1383836828-24886-1-git-send-email-s.trumtrar@pengutronix.de>
References: <1383836828-24886-1-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <1383836828-24886-5-git-send-email-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The socfpga-perip-clks all have a variable clk_divider in their path.
Add it to the tree and also use clk_register_fixed_factor for the
fixed-dividers instead of a custom implementation.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 drivers/clk/socfpga/clk-periph.c | 78 ++++++++++++++++++----------------------
 drivers/clk/socfpga/clk.h        |  6 ++--
 2 files changed, 38 insertions(+), 46 deletions(-)

diff --git a/drivers/clk/socfpga/clk-periph.c b/drivers/clk/socfpga/clk-periph.c
index 7ff8f80..28f2c2d 100644
--- a/drivers/clk/socfpga/clk-periph.c
+++ b/drivers/clk/socfpga/clk-periph.c
@@ -1,6 +1,7 @@
 /*
  *  Copyright 2011-2012 Calxeda, Inc.
  *  Copyright (C) 2012-2013 Altera Corporation <www.altera.com>
+ *  Copyright (C) 2013 Steffen Trumtrar <s.trumtrar@pengutronix.de>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -25,37 +26,17 @@
 
 #include "clk.h"
 
-#define to_socfpga_periph_clk(p) container_of(p, struct socfpga_periph_clk, hw.hw)
-
-static unsigned long clk_periclk_recalc_rate(struct clk_hw *hwclk,
-					     unsigned long parent_rate)
-{
-	struct socfpga_periph_clk *socfpgaclk = to_socfpga_periph_clk(hwclk);
-	u32 div;
-
-	if (socfpgaclk->fixed_div)
-		div = socfpgaclk->fixed_div;
-	else
-		div = ((readl(socfpgaclk->hw.reg) & 0x1ff) + 1);
-
-	return parent_rate / div;
-}
-
-static const struct clk_ops periclk_ops = {
-	.recalc_rate = clk_periclk_recalc_rate,
-};
-
-static __init void __socfpga_periph_init(struct device_node *node,
-	const struct clk_ops *ops)
+static __init void __socfpga_periph_init(struct device_node *node)
 {
 	u32 reg;
-	struct clk *clk;
 	struct socfpga_periph_clk *periph_clk;
 	const char *clk_name = node->name;
 	const char *parent_name;
-	struct clk_init_data init;
-	int rc;
+	const char *div_name;
 	u32 fixed_div;
+	int ret;
+	int i;
+	unsigned int clk_idx = 0;
 
 	of_property_read_u32(node, "reg", &reg);
 
@@ -63,35 +44,44 @@ static __init void __socfpga_periph_init(struct device_node *node,
 	if (WARN_ON(!periph_clk))
 		return;
 
-	periph_clk->hw.reg = clk_mgr_base_addr + reg;
-
-	rc = of_property_read_u32(node, "fixed-divider", &fixed_div);
-	if (rc)
-		periph_clk->fixed_div = 0;
-	else
-		periph_clk->fixed_div = fixed_div;
+	periph_clk->reg = clk_mgr_base_addr + reg;
 
 	of_property_read_string(node, "clock-output-names", &clk_name);
 
-	init.name = clk_name;
-	init.ops = ops;
-	init.flags = 0;
 	parent_name = of_clk_get_parent_name(node, 0);
-	init.parent_names = &parent_name;
-	init.num_parents = 1;
 
-	periph_clk->hw.hw.init = &init;
+	spin_lock_init(&periph_clk->lock);
 
-	clk = clk_register(NULL, &periph_clk->hw.hw);
-	if (WARN_ON(IS_ERR(clk))) {
-		kfree(periph_clk);
-		return;
+	ret = of_property_read_u32(node, "fixed-divider", &fixed_div);
+	if (!ret) {
+		div_name = kasprintf(GFP_KERNEL, "%s_div", clk_name);
+		periph_clk->clks[clk_idx++] = clk_register_fixed_factor(NULL,
+							div_name, parent_name,
+							0, 1, fixed_div);
+	} else {
+		div_name = kasprintf(GFP_KERNEL, "%s", parent_name);
 	}
-	rc = of_clk_add_provider(node, of_clk_src_simple_get, clk);
+
+	periph_clk->clks[clk_idx++] = clk_register_divider(NULL, clk_name,
+					div_name, 0, periph_clk->reg, 0, 9,
+					CLK_DIVIDER_ONE_BASED |
+					CLK_DIVIDER_ALLOW_ZERO,
+					&periph_clk->lock);
+
+	for (i = 0; i < ARRAY_SIZE(periph_clk->clks); i++)
+		if (IS_ERR(periph_clk->clks[i]))
+			pr_err("%s: clk %d: register failed with %ld\n",
+				node->name, i, PTR_ERR(periph_clk->clks[i]));
+
+	kfree(div_name);
+
+	periph_clk->clk_data.clks = periph_clk->clks;
+	periph_clk->clk_data.clk_num = clk_idx;
+	of_clk_add_provider(node, of_clk_src_simple_get, &periph_clk->clk_data);
 }
 
 static void __init socfpga_periph_init(struct device_node *node)
 {
-	__socfpga_periph_init(node, &periclk_ops);
+	__socfpga_periph_init(node);
 }
 CLK_OF_DECLARE(socfpga_periph, "altr,socfpga-perip-clk", socfpga_periph_init);
diff --git a/drivers/clk/socfpga/clk.h b/drivers/clk/socfpga/clk.h
index d272048..8b60c6b 100644
--- a/drivers/clk/socfpga/clk.h
+++ b/drivers/clk/socfpga/clk.h
@@ -46,9 +46,11 @@ struct socfpga_gate_clk {
 };
 
 struct socfpga_periph_clk {
-	struct clk_gate hw;
+	void __iomem *reg;
+	struct clk_onecell_data clk_data;
+	struct clk *clks[2];
 	char *parent_name;
-	u32 fixed_div;
+	spinlock_t lock;
 };
 
 #endif /* SOCFPGA_CLK_H */
-- 
1.8.4.rc3
