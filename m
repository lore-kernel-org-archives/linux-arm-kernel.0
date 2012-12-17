From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 17 Dec 2012 13:02:15 -0800
Subject: [PATCH 4/4] clk: zynq: Use of_init_clk_data()
In-Reply-To: <1355778135-32458-1-git-send-email-sboyd@codeaurora.org>
References: <1355778135-32458-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1355778135-32458-5-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reduce lines of code and simplify this driver by using the
generic clock binding parsing function. This also fixes a bug
where the 'flags' member of the init struct is not initialized.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Cc: Josh Cartwright <josh.cartwright@ni.com>
Cc: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
 drivers/clk/clk-zynq.c | 28 +++++++++-------------------
 1 file changed, 9 insertions(+), 19 deletions(-)

diff --git a/drivers/clk/clk-zynq.c b/drivers/clk/clk-zynq.c
index 37a3051..0fcc23d 100644
--- a/drivers/clk/clk-zynq.c
+++ b/drivers/clk/clk-zynq.c
@@ -48,7 +48,6 @@ static void __init zynq_pll_clk_setup(struct device_node *np)
 {
 	struct clk_init_data init;
 	struct zynq_pll_clk *pll;
-	const char *parent_name;
 	struct clk *clk;
 	u32 regs[2];
 	int ret;
@@ -64,12 +63,10 @@ static void __init zynq_pll_clk_setup(struct device_node *np)
 	pll->pll_ctrl = slcr_base + regs[0];
 	pll->pll_cfg  = slcr_base + regs[1];
 
-	of_property_read_string(np, "clock-output-names", &init.name);
-
+	ret = of_init_clk_data(np, &init);
+	if (WARN_ON(ret))
+		return;
 	init.ops = &zynq_pll_clk_ops;
-	parent_name = of_clk_get_parent_name(np, 0);
-	init.parent_names = &parent_name;
-	init.num_parents = 1;
 
 	pll->hw.init = &init;
 
@@ -119,13 +116,11 @@ static const struct clk_ops zynq_periph_clk_ops = {
 static void __init zynq_periph_clk_setup(struct device_node *np)
 {
 	struct zynq_periph_clk *periph;
-	const char *parent_names[3];
 	struct clk_init_data init;
 	int clk_num = 0, err;
 	const char *name;
 	struct clk *clk;
 	u32 reg;
-	int i;
 
 	err = of_property_read_u32(np, "reg", &reg);
 	if (WARN_ON(err))
@@ -138,12 +133,10 @@ static void __init zynq_periph_clk_setup(struct device_node *np)
 	periph->clk_ctrl = slcr_base + reg;
 	spin_lock_init(&periph->clkact_lock);
 
-	init.name = np->name;
+	err = of_init_clk_data(np, &init);
+	if (WARN_ON(err))
+		return;
 	init.ops = &zynq_periph_clk_ops;
-	for (i = 0; i < ARRAY_SIZE(parent_names); i++)
-		parent_names[i] = of_clk_get_parent_name(np, i);
-	init.parent_names = parent_names;
-	init.num_parents = ARRAY_SIZE(parent_names);
 
 	periph->hw.init = &init;
 
@@ -315,7 +308,6 @@ err_read_output_name:
 static void __init zynq_cpu_clk_setup(struct device_node *np)
 {
 	struct zynq_cpu_clk *cpuclk;
-	const char *parent_names[3];
 	struct clk_init_data init;
 	void __iomem *clk_621;
 	struct clk *clk;
@@ -335,12 +327,10 @@ static void __init zynq_cpu_clk_setup(struct device_node *np)
 	clk_621 = slcr_base + reg[1];
 	spin_lock_init(&cpuclk->clkact_lock);
 
-	init.name = np->name;
+	err = of_init_clk_data(np, &init);
+	if (WARN_ON(err))
+		return;
 	init.ops = &zynq_cpu_clk_ops;
-	for (i = 0; i < ARRAY_SIZE(parent_names); i++)
-		parent_names[i] = of_clk_get_parent_name(np, i);
-	init.parent_names = parent_names;
-	init.num_parents = ARRAY_SIZE(parent_names);
 
 	cpuclk->hw.init = &init;
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
