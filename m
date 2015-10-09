From: 21cnbao@gmail.com (Barry Song)
Date: Fri,  9 Oct 2015 08:05:31 +0000
Subject: [PATCH] clk: atlas7: merge lots of discrete clocks into arrays
Message-ID: <1444377931-5178-1-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Guo Zeng <Guo.Zeng@csr.com>

this patch merges lots of discrete dividers, divider tables and dto
into arrays, then drops lots of codes.

Signed-off-by: Guo Zeng <Guo.Zeng@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/clk/sirf/clk-atlas7.c | 211 ++++++++++--------------------------------
 1 file changed, 47 insertions(+), 164 deletions(-)

diff --git a/drivers/clk/sirf/clk-atlas7.c b/drivers/clk/sirf/clk-atlas7.c
index 957aae6..6c6cbe4 100644
--- a/drivers/clk/sirf/clk-atlas7.c
+++ b/drivers/clk/sirf/clk-atlas7.c
@@ -211,6 +211,8 @@
 #define SIRFSOC_NOC_CLK_SLVRDY_CLR		0x02EC
 #define SIRFSOC_NOC_CLK_IDLE_STATUS		0x02F4
 
+#define SIRFSOC_DIVIDOR_TYPE_TABLE	0x1
+
 struct clk_pll {
 	struct clk_hw hw;
 	u16 regofs;  /* register offset */
@@ -653,6 +655,12 @@ static struct clk_dto clk_disp1_dto = {
 	},
 };
 
+static struct clk_dto *dto_list[] __initdata = {
+	&clk_audio_dto,
+	&clk_disp0_dto,
+	&clk_disp1_dto,
+};
+
 static struct atlas7_div_init_data divider_list[] __initdata = {
 	/* div_name, parent_name, gate_name, clk_flag, divider_flag, gate_flag, div_offset, shift, wdith, gate_offset, bit_enable, lock */
 	{ "sys0pll_qa1", "sys0pll_fixdiv", "sys0pll_a1", 0, 0, 0, SIRFSOC_CLKC_USBPHY_CLKDIV_CFG, 0, 6, SIRFSOC_CLKC_USBPHY_CLKDIV_ENA, 0, &usbphy_div_lock },
@@ -719,6 +727,24 @@ static struct atlas7_div_init_data divider_list[] __initdata = {
 	{ "sys2pll_qa20", "sys2pll_fixdiv", "sys2pll_a20", 0, 0, 0, SIRFSOC_CLKC_SHARED_DIVIDER_CFG0, 0, 6, SIRFSOC_CLKC_SHARED_DIVIDER_ENA, 0, &share_div_lock },
 	{ "sys1pll_qa17", "sys1pll_fixdiv", "sys1pll_a17", 0, 0, CLK_IGNORE_UNUSED, SIRFSOC_CLKC_SHARED_DIVIDER_CFG1, 8, 6, SIRFSOC_CLKC_SHARED_DIVIDER_ENA, 20, &share_div_lock },
 	{ "sys0pll_qa20", "sys0pll_fixdiv", "sys0pll_a20", 0, 0, 0, SIRFSOC_CLKC_SHARED_DIVIDER_CFG1, 0, 6, SIRFSOC_CLKC_SHARED_DIVIDER_ENA, 16, &share_div_lock },
+	{ "sys0pll_div1", "sys0pll_vco", "sys0pll_clk1", 1, 0, 0, SIRFSOC_CLKC_SYS0PLL_AB_CTRL1, 0, 3, SIRFSOC_CLKC_SYS0PLL_AB_CTRL1, 12, &sys0pll_ctrl1_lock },
+	{ "sys0pll_div2", "sys0pll_vco", "sys0pll_clk2", 1, 0, 0, SIRFSOC_CLKC_SYS0PLL_AB_CTRL1, 4, 3, SIRFSOC_CLKC_SYS0PLL_AB_CTRL1, 13, &sys0pll_ctrl1_lock },
+	{ "sys0pll_div3", "sys0pll_vco", "sys0pll_clk3", 1, 0, 0, SIRFSOC_CLKC_SYS0PLL_AB_CTRL1, 8, 3, SIRFSOC_CLKC_SYS0PLL_AB_CTRL1, 14, &sys0pll_ctrl1_lock },
+	{ "sys1pll_div1", "sys1pll_vco", "sys1pll_clk1", 1, 0, 0, SIRFSOC_CLKC_SYS1PLL_AB_CTRL1, 0, 3, SIRFSOC_CLKC_SYS1PLL_AB_CTRL1, 12, &sys1pll_ctrl1_lock },
+	{ "sys1pll_div2", "sys1pll_vco", "sys1pll_clk2", 1, 0, 0, SIRFSOC_CLKC_SYS1PLL_AB_CTRL1, 4, 3, SIRFSOC_CLKC_SYS1PLL_AB_CTRL1, 13, &sys1pll_ctrl1_lock },
+	{ "sys1pll_div3", "sys1pll_vco", "sys1pll_clk3", 1, 0, 0, SIRFSOC_CLKC_SYS1PLL_AB_CTRL1, 8, 3, SIRFSOC_CLKC_SYS1PLL_AB_CTRL1, 14, &sys1pll_ctrl1_lock },
+	{ "sys2pll_div1", "sys2pll_vco", "sys2pll_clk1", 1, 0, 0, SIRFSOC_CLKC_SYS2PLL_AB_CTRL1, 0, 3, SIRFSOC_CLKC_SYS2PLL_AB_CTRL1, 12, &sys2pll_ctrl1_lock },
+	{ "sys2pll_div2", "sys2pll_vco", "sys2pll_clk2", 1, 0, 0, SIRFSOC_CLKC_SYS2PLL_AB_CTRL1, 4, 3, SIRFSOC_CLKC_SYS2PLL_AB_CTRL1, 13, &sys2pll_ctrl1_lock },
+	{ "sys2pll_div3", "sys2pll_vco", "sys2pll_clk3", 1, 0, 0, SIRFSOC_CLKC_SYS2PLL_AB_CTRL1, 8, 3, SIRFSOC_CLKC_SYS2PLL_AB_CTRL1, 14, &sys2pll_ctrl1_lock },
+	{ "sys3pll_div1", "sys3pll_vco", "sys3pll_clk1", 1, 0, 0, SIRFSOC_CLKC_SYS3PLL_AB_CTRL1, 0, 3, SIRFSOC_CLKC_SYS3PLL_AB_CTRL1, 12, &sys3pll_ctrl1_lock },
+	{ "sys3pll_div2", "sys3pll_vco", "sys3pll_clk2", 1, 0, 0, SIRFSOC_CLKC_SYS3PLL_AB_CTRL1, 4, 3, SIRFSOC_CLKC_SYS3PLL_AB_CTRL1, 13, &sys3pll_ctrl1_lock },
+	{ "sys3pll_div3", "sys3pll_vco", "sys3pll_clk3", 1, 0, 0, SIRFSOC_CLKC_SYS3PLL_AB_CTRL1, 8, 3, SIRFSOC_CLKC_SYS3PLL_AB_CTRL1, 14, &sys3pll_ctrl1_lock },
+	{ "cpupll_div1", "cpupll_vco", "cpupll_clk1", 1, 0, 0, SIRFSOC_CLKC_CPUPLL_AB_CTRL1, 0, 3, SIRFSOC_CLKC_CPUPLL_AB_CTRL1, 12, &cpupll_ctrl1_lock },
+	{ "cpupll_div2", "cpupll_vco", "cpupll_clk2", 1, 0, 0, SIRFSOC_CLKC_CPUPLL_AB_CTRL1, 4, 3, SIRFSOC_CLKC_CPUPLL_AB_CTRL1, 13, &cpupll_ctrl1_lock },
+	{ "cpupll_div3", "cpupll_vco", "cpupll_clk3", 1, 0, 0, SIRFSOC_CLKC_CPUPLL_AB_CTRL1, 8, 3, SIRFSOC_CLKC_CPUPLL_AB_CTRL1, 14, &cpupll_ctrl1_lock },
+	{ "mempll_div1", "mempll_vco", "mempll_clk1", 1, 0, 0, SIRFSOC_CLKC_MEMPLL_AB_CTRL1, 0, 3, SIRFSOC_CLKC_MEMPLL_AB_CTRL1, 12, &mempll_ctrl1_lock },
+	{ "mempll_div2", "mempll_vco", "mempll_clk2", 1, 0, 0, SIRFSOC_CLKC_MEMPLL_AB_CTRL1, 4, 3, SIRFSOC_CLKC_MEMPLL_AB_CTRL1, 13, &mempll_ctrl1_lock },
+	{ "mempll_div3", "mempll_vco", "mempll_clk3", 1, 0, 0, SIRFSOC_CLKC_MEMPLL_AB_CTRL1, 8, 3, SIRFSOC_CLKC_MEMPLL_AB_CTRL1, 14, &mempll_ctrl1_lock },
 };
 
 static const char * const i2s_clk_parents[] = {
@@ -1199,7 +1225,8 @@ static struct atlas7_unit_init_data unit_list[] __initdata = {
 	{ 141, "thcgum_sys", "sys_mux", 0, SIRFSOC_CLKC_LEAF_CLK_EN0_SET, 3, 0, 0, &leaf0_gate_lock },
 };
 
-static struct clk *atlas7_clks[ARRAY_SIZE(unit_list) + ARRAY_SIZE(mux_list)];
+static struct clk *atlas7_clks[ARRAY_SIZE(unit_list) + ARRAY_SIZE(mux_list) +
+			ARRAY_SIZE(divider_list) + ARRAY_SIZE(dto_list)];
 
 static int unit_clk_is_enabled(struct clk_hw *hw)
 {
@@ -1461,88 +1488,14 @@ static void __init atlas7_clk_init(struct device_node *np)
 	clk = clk_register(NULL, &clk_sys3pll.hw);
 	BUG_ON(!clk);
 
-	clk = clk_register_divider_table(NULL, "cpupll_div1", "cpupll_vco", 0,
-			 sirfsoc_clk_vbase + SIRFSOC_CLKC_CPUPLL_AB_CTRL1, 0, 3, 0,
-			 pll_div_table, &cpupll_ctrl1_lock);
-	BUG_ON(!clk);
-	clk = clk_register_divider_table(NULL, "cpupll_div2", "cpupll_vco", 0,
-			 sirfsoc_clk_vbase + SIRFSOC_CLKC_CPUPLL_AB_CTRL1, 4, 3, 0,
-			 pll_div_table, &cpupll_ctrl1_lock);
-	BUG_ON(!clk);
-	clk = clk_register_divider_table(NULL, "cpupll_div3", "cpupll_vco", 0,
-			 sirfsoc_clk_vbase + SIRFSOC_CLKC_CPUPLL_AB_CTRL1, 8, 3, 0,
-			 pll_div_table, &cpupll_ctrl1_lock);
-	BUG_ON(!clk);
-
-	clk = clk_register_divider_table(NULL, "mempll_div1", "mempll_vco", 0,
-			 sirfsoc_clk_vbase + SIRFSOC_CLKC_MEMPLL_AB_CTRL1, 0, 3, 0,
-			 pll_div_table, &mempll_ctrl1_lock);
-	BUG_ON(!clk);
-	clk = clk_register_divider_table(NULL, "mempll_div2", "mempll_vco", 0,
-			 sirfsoc_clk_vbase + SIRFSOC_CLKC_MEMPLL_AB_CTRL1, 4, 3, 0,
-			 pll_div_table, &mempll_ctrl1_lock);
-	BUG_ON(!clk);
-	clk = clk_register_divider_table(NULL, "mempll_div3", "mempll_vco", 0,
-			 sirfsoc_clk_vbase + SIRFSOC_CLKC_MEMPLL_AB_CTRL1, 8, 3, 0,
-			 pll_div_table, &mempll_ctrl1_lock);
-	BUG_ON(!clk);
-
-	clk = clk_register_divider_table(NULL, "sys0pll_div1", "sys0pll_vco", 0,
-			 sirfsoc_clk_vbase + SIRFSOC_CLKC_SYS0PLL_AB_CTRL1, 0, 3, 0,
-			 pll_div_table, &sys0pll_ctrl1_lock);
-	BUG_ON(!clk);
-	clk = clk_register_divider_table(NULL, "sys0pll_div2", "sys0pll_vco", 0,
-			 sirfsoc_clk_vbase + SIRFSOC_CLKC_SYS0PLL_AB_CTRL1, 4, 3, 0,
-			 pll_div_table, &sys0pll_ctrl1_lock);
-	BUG_ON(!clk);
-	clk = clk_register_divider_table(NULL, "sys0pll_div3", "sys0pll_vco", 0,
-			 sirfsoc_clk_vbase + SIRFSOC_CLKC_SYS0PLL_AB_CTRL1, 8, 3, 0,
-			 pll_div_table, &sys0pll_ctrl1_lock);
-	BUG_ON(!clk);
 	clk = clk_register_fixed_factor(NULL, "sys0pll_fixdiv", "sys0pll_vco",
 					CLK_SET_RATE_PARENT, 1, 2);
-
-	clk = clk_register_divider_table(NULL, "sys1pll_div1", "sys1pll_vco", 0,
-			 sirfsoc_clk_vbase + SIRFSOC_CLKC_SYS1PLL_AB_CTRL1, 0, 3, 0,
-			 pll_div_table, &sys1pll_ctrl1_lock);
-	BUG_ON(!clk);
-	clk = clk_register_divider_table(NULL, "sys1pll_div2", "sys1pll_vco", 0,
-			 sirfsoc_clk_vbase + SIRFSOC_CLKC_SYS1PLL_AB_CTRL1, 4, 3, 0,
-			 pll_div_table, &sys1pll_ctrl1_lock);
-	BUG_ON(!clk);
-	clk = clk_register_divider_table(NULL, "sys1pll_div3", "sys1pll_vco", 0,
-			 sirfsoc_clk_vbase + SIRFSOC_CLKC_SYS1PLL_AB_CTRL1, 8, 3, 0,
-			 pll_div_table, &sys1pll_ctrl1_lock);
 	BUG_ON(!clk);
 	clk = clk_register_fixed_factor(NULL, "sys1pll_fixdiv", "sys1pll_vco",
 					CLK_SET_RATE_PARENT, 1, 2);
-
-	clk = clk_register_divider_table(NULL, "sys2pll_div1", "sys2pll_vco", 0,
-			 sirfsoc_clk_vbase + SIRFSOC_CLKC_SYS2PLL_AB_CTRL1, 0, 3, 0,
-			 pll_div_table, &sys2pll_ctrl1_lock);
-	BUG_ON(!clk);
-	clk = clk_register_divider_table(NULL, "sys2pll_div2", "sys2pll_vco", 0,
-			 sirfsoc_clk_vbase + SIRFSOC_CLKC_SYS2PLL_AB_CTRL1, 4, 3, 0,
-			 pll_div_table, &sys2pll_ctrl1_lock);
-	BUG_ON(!clk);
-	clk = clk_register_divider_table(NULL, "sys2pll_div3", "sys2pll_vco", 0,
-			 sirfsoc_clk_vbase + SIRFSOC_CLKC_SYS2PLL_AB_CTRL1, 8, 3, 0,
-			 pll_div_table, &sys2pll_ctrl1_lock);
 	BUG_ON(!clk);
 	clk = clk_register_fixed_factor(NULL, "sys2pll_fixdiv", "sys2pll_vco",
 					CLK_SET_RATE_PARENT, 1, 2);
-
-	clk = clk_register_divider_table(NULL, "sys3pll_div1", "sys3pll_vco", 0,
-			 sirfsoc_clk_vbase + SIRFSOC_CLKC_SYS3PLL_AB_CTRL1, 0, 3, 0,
-			 pll_div_table, &sys3pll_ctrl1_lock);
-	BUG_ON(!clk);
-	clk = clk_register_divider_table(NULL, "sys3pll_div2", "sys3pll_vco", 0,
-			 sirfsoc_clk_vbase + SIRFSOC_CLKC_SYS3PLL_AB_CTRL1, 4, 3, 0,
-			 pll_div_table, &sys3pll_ctrl1_lock);
-	BUG_ON(!clk);
-	clk = clk_register_divider_table(NULL, "sys3pll_div3", "sys3pll_vco", 0,
-			 sirfsoc_clk_vbase + SIRFSOC_CLKC_SYS3PLL_AB_CTRL1, 8, 3, 0,
-			 pll_div_table, &sys3pll_ctrl1_lock);
 	BUG_ON(!clk);
 	clk = clk_register_fixed_factor(NULL, "sys3pll_fixdiv", "sys3pll_vco",
 					CLK_SET_RATE_PARENT, 1, 2);
@@ -1552,104 +1505,33 @@ static void __init atlas7_clk_init(struct device_node *np)
 					CLK_SET_RATE_PARENT, 1, 4);
 
 	BUG_ON(!clk);
-	clk = clk_register_gate(NULL, "cpupll_clk1", "cpupll_div1",
-		CLK_SET_RATE_PARENT, sirfsoc_clk_vbase + SIRFSOC_CLKC_CPUPLL_AB_CTRL1,
-				12, 0, &cpupll_ctrl1_lock);
-	BUG_ON(!clk);
-	clk = clk_register_gate(NULL, "cpupll_clk2", "cpupll_div2",
-		CLK_SET_RATE_PARENT, sirfsoc_clk_vbase + SIRFSOC_CLKC_CPUPLL_AB_CTRL1,
-				13, 0, &cpupll_ctrl1_lock);
-	BUG_ON(!clk);
-	clk = clk_register_gate(NULL, "cpupll_clk3", "cpupll_div3",
-		CLK_SET_RATE_PARENT, sirfsoc_clk_vbase + SIRFSOC_CLKC_CPUPLL_AB_CTRL1,
-				14, 0, &cpupll_ctrl1_lock);
-	BUG_ON(!clk);
-
-	clk = clk_register_gate(NULL, "mempll_clk1", "mempll_div1",
-		CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
-		sirfsoc_clk_vbase + SIRFSOC_CLKC_MEMPLL_AB_CTRL1,
-		12, 0, &mempll_ctrl1_lock);
-	BUG_ON(!clk);
-	clk = clk_register_gate(NULL, "mempll_clk2", "mempll_div2",
-		CLK_SET_RATE_PARENT, sirfsoc_clk_vbase + SIRFSOC_CLKC_MEMPLL_AB_CTRL1,
-				13, 0, &mempll_ctrl1_lock);
-	BUG_ON(!clk);
-	clk = clk_register_gate(NULL, "mempll_clk3", "mempll_div3",
-		CLK_SET_RATE_PARENT, sirfsoc_clk_vbase + SIRFSOC_CLKC_MEMPLL_AB_CTRL1,
-				14, 0, &mempll_ctrl1_lock);
-	BUG_ON(!clk);
-
-	clk = clk_register_gate(NULL, "sys0pll_clk1", "sys0pll_div1",
-		CLK_SET_RATE_PARENT, sirfsoc_clk_vbase + SIRFSOC_CLKC_SYS0PLL_AB_CTRL1,
-				12, 0, &sys0pll_ctrl1_lock);
-	BUG_ON(!clk);
-	clk = clk_register_gate(NULL, "sys0pll_clk2", "sys0pll_div2",
-		CLK_SET_RATE_PARENT, sirfsoc_clk_vbase + SIRFSOC_CLKC_SYS0PLL_AB_CTRL1,
-				13, 0, &sys0pll_ctrl1_lock);
-	BUG_ON(!clk);
-	clk = clk_register_gate(NULL, "sys0pll_clk3", "sys0pll_div3",
-		CLK_SET_RATE_PARENT, sirfsoc_clk_vbase + SIRFSOC_CLKC_SYS0PLL_AB_CTRL1,
-				14, 0, &sys0pll_ctrl1_lock);
-	BUG_ON(!clk);
-
-	clk = clk_register_gate(NULL, "sys1pll_clk1", "sys1pll_div1",
-		CLK_SET_RATE_PARENT, sirfsoc_clk_vbase + SIRFSOC_CLKC_SYS1PLL_AB_CTRL1,
-				12, 0, &sys1pll_ctrl1_lock);
-	BUG_ON(!clk);
-	clk = clk_register_gate(NULL, "sys1pll_clk2", "sys1pll_div2",
-		CLK_SET_RATE_PARENT, sirfsoc_clk_vbase + SIRFSOC_CLKC_SYS1PLL_AB_CTRL1,
-				13, 0, &sys1pll_ctrl1_lock);
-	BUG_ON(!clk);
-	clk = clk_register_gate(NULL, "sys1pll_clk3", "sys1pll_div3",
-		CLK_SET_RATE_PARENT, sirfsoc_clk_vbase + SIRFSOC_CLKC_SYS1PLL_AB_CTRL1,
-				14, 0, &sys1pll_ctrl1_lock);
-	BUG_ON(!clk);
 
-	clk = clk_register_gate(NULL, "sys2pll_clk1", "sys2pll_div1",
-		CLK_SET_RATE_PARENT, sirfsoc_clk_vbase + SIRFSOC_CLKC_SYS2PLL_AB_CTRL1,
-				12, 0, &sys2pll_ctrl1_lock);
-	BUG_ON(!clk);
-	clk = clk_register_gate(NULL, "sys2pll_clk2", "sys2pll_div2",
-		CLK_SET_RATE_PARENT, sirfsoc_clk_vbase + SIRFSOC_CLKC_SYS2PLL_AB_CTRL1,
-				13, 0, &sys2pll_ctrl1_lock);
-	BUG_ON(!clk);
-	clk = clk_register_gate(NULL, "sys2pll_clk3", "sys2pll_div3",
-		CLK_SET_RATE_PARENT, sirfsoc_clk_vbase + SIRFSOC_CLKC_SYS2PLL_AB_CTRL1,
-				14, 0, &sys2pll_ctrl1_lock);
-	BUG_ON(!clk);
-
-	clk = clk_register_gate(NULL, "sys3pll_clk1", "sys3pll_div1",
-		CLK_SET_RATE_PARENT, sirfsoc_clk_vbase + SIRFSOC_CLKC_SYS3PLL_AB_CTRL1,
-				12, 0, &sys3pll_ctrl1_lock);
-	BUG_ON(!clk);
-	clk = clk_register_gate(NULL, "sys3pll_clk2", "sys3pll_div2",
-		CLK_SET_RATE_PARENT, sirfsoc_clk_vbase + SIRFSOC_CLKC_SYS3PLL_AB_CTRL1,
-				13, 0, &sys3pll_ctrl1_lock);
-	BUG_ON(!clk);
-	clk = clk_register_gate(NULL, "sys3pll_clk3", "sys3pll_div3",
-		CLK_SET_RATE_PARENT, sirfsoc_clk_vbase + SIRFSOC_CLKC_SYS3PLL_AB_CTRL1,
-				14, 0, &sys3pll_ctrl1_lock);
-	BUG_ON(!clk);
-
-	clk = clk_register(NULL, &clk_audio_dto.hw);
-	BUG_ON(!clk);
-
-	clk = clk_register(NULL, &clk_disp0_dto.hw);
-	BUG_ON(!clk);
+	for (i = 0; i < ARRAY_SIZE(dto_list); i++) {
+		clk = clk_register(NULL, &dto_list[i]->hw);
+		BUG_ON(!clk);
 
-	clk = clk_register(NULL, &clk_disp1_dto.hw);
-	BUG_ON(!clk);
+		atlas7_clks[ARRAY_SIZE(unit_list) + ARRAY_SIZE(mux_list) +
+			ARRAY_SIZE(divider_list) + i] = clk;
+	}
 
 	for (i = 0; i < ARRAY_SIZE(divider_list); i++) {
 		div = &divider_list[i];
-		clk = clk_register_divider(NULL, div->div_name,
-			div->parent_name, div->divider_flags, sirfsoc_clk_vbase + div->div_offset,
-			div->shift, div->width, 0, div->lock);
+		if (div->flags == SIRFSOC_DIVIDOR_TYPE_TABLE)
+			clk = clk_register_divider_table(NULL, div->div_name,
+				div->parent_name, div->divider_flags, sirfsoc_clk_vbase + div->div_offset,
+				div->shift, div->width, 0, pll_div_table, div->lock);
+		else
+			clk = clk_register_divider(NULL, div->div_name,
+				div->parent_name, div->divider_flags, sirfsoc_clk_vbase + div->div_offset,
+				div->shift, div->width, 0, div->lock);
 		BUG_ON(!clk);
+
 		clk = clk_register_gate(NULL, div->gate_name, div->div_name,
 			div->gate_flags, sirfsoc_clk_vbase + div->gate_offset,
 				div->gate_bit, 0, div->lock);
 		BUG_ON(!clk);
+
+		atlas7_clks[ARRAY_SIZE(unit_list) + ARRAY_SIZE(mux_list) + i] = clk;
 	}
 	/* ignore selector status register check */
 	for (i = 0; i < ARRAY_SIZE(mux_list); i++) {
@@ -1671,7 +1553,8 @@ static void __init atlas7_clk_init(struct device_node *np)
 	}
 
 	clk_data.clks = atlas7_clks;
-	clk_data.clk_num = ARRAY_SIZE(unit_list) + ARRAY_SIZE(mux_list);
+	clk_data.clk_num = ARRAY_SIZE(unit_list) + ARRAY_SIZE(mux_list) +
+		ARRAY_SIZE(divider_list) + ARRAY_SIZE(dto_list);
 
 	ret = of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
 	BUG_ON(ret);
-- 
1.9.1
