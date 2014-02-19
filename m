From: dinguyen@altera.com (dinguyen at altera.com)
Date: Wed, 19 Feb 2014 15:11:11 -0600
Subject: [PATCH 2/3] clk: socfpga: Support multiple parents for the pll clocks
In-Reply-To: <1392844273-11918-1-git-send-email-dinguyen@altera.com>
References: <1392844273-11918-1-git-send-email-dinguyen@altera.com>
Message-ID: <1392844273-11918-2-git-send-email-dinguyen@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@altera.com>

The PLLs can be from 3 different sources: osc1, osc2, or the f2s_ref_clk.
Update the clock driver to be able to get the correct parent.

Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
Cc: Mike Turquette <mturquette@linaro.org>
Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 drivers/clk/socfpga/clk-pll.c |   26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/socfpga/clk-pll.c b/drivers/clk/socfpga/clk-pll.c
index 834b6e9..88dafb5 100644
--- a/drivers/clk/socfpga/clk-pll.c
+++ b/drivers/clk/socfpga/clk-pll.c
@@ -38,6 +38,9 @@
 #define SOCFPGA_PLL_DIVQ_MASK		0x003F0000
 #define SOCFPGA_PLL_DIVQ_SHIFT		16
 
+#define CLK_MGR_PLL_CLK_SRC_SHIFT	22
+#define CLK_MGR_PLL_CLK_SRC_MASK	0x3
+
 #define to_socfpga_clk(p) container_of(p, struct socfpga_pll, hw.hw)
 
 static unsigned long clk_pll_recalc_rate(struct clk_hw *hwclk,
@@ -60,8 +63,19 @@ static unsigned long clk_pll_recalc_rate(struct clk_hw *hwclk,
 	return (unsigned long)vco_freq;
 }
 
+static u8 clk_pll_get_parent(struct clk_hw *hwclk)
+{
+	u32 pll_src;
+	struct socfpga_pll *socfpgaclk = to_socfpga_clk(hwclk);
+
+	pll_src = readl(socfpgaclk->hw.reg);
+	return (pll_src >> CLK_MGR_PLL_CLK_SRC_SHIFT) &
+			CLK_MGR_PLL_CLK_SRC_MASK;
+}
+
 static struct clk_ops clk_pll_ops = {
 	.recalc_rate = clk_pll_recalc_rate,
+	.get_parent = clk_pll_get_parent,
 };
 
 static __init struct clk *__socfpga_pll_init(struct device_node *node,
@@ -71,9 +85,10 @@ static __init struct clk *__socfpga_pll_init(struct device_node *node,
 	struct clk *clk;
 	struct socfpga_pll *pll_clk;
 	const char *clk_name = node->name;
-	const char *parent_name;
+	const char *parent_name[SOCFPGA_MAX_PARENTS];
 	struct clk_init_data init;
 	int rc;
+	int i = 0;
 
 	of_property_read_u32(node, "reg", &reg);
 
@@ -88,10 +103,13 @@ static __init struct clk *__socfpga_pll_init(struct device_node *node,
 	init.name = clk_name;
 	init.ops = ops;
 	init.flags = 0;
-	parent_name = of_clk_get_parent_name(node, 0);
-	init.parent_names = parent_name ? &parent_name : NULL;
-	init.num_parents = parent_name ? 1 : 0;
 
+	while (i < SOCFPGA_MAX_PARENTS && (parent_name[i] =
+			of_clk_get_parent_name(node, i)) != NULL)
+		i++;
+
+	init.num_parents = i;
+	init.parent_names = parent_name;
 	pll_clk->hw.hw.init = &init;
 
 	pll_clk->hw.bit_idx = SOCFPGA_PLL_EXT_ENA;
-- 
1.7.9.5
