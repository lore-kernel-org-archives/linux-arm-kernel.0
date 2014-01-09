From: wens@csie.org (Chen-Yu Tsai)
Date: Thu,  9 Jan 2014 16:52:41 +0800
Subject: [PATCH v3 4/8] clk: sunxi: get divs parent clock name from parent
 factor clock
In-Reply-To: <1389257565-19797-1-git-send-email-wens@csie.org>
References: <1389257565-19797-1-git-send-email-wens@csie.org>
Message-ID: <1389257565-19797-5-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Divs clocks consist of a parent factor clock with multiple outputs,
and seperate clocks for each output. Get the name of the parent
clock from the parent factor clock, instead of the DT node name.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/clk/sunxi/clk-sunxi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index b5c18de..a741683 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -863,7 +863,7 @@ static void __init sunxi_divs_clk_setup(struct device_node *node,
 					struct divs_data *data)
 {
 	struct clk_onecell_data *clk_data;
-	const char *parent  = node->name;
+	const char *parent;
 	const char *clk_name;
 	struct clk **clks, *pclk;
 	struct clk_hw *gate_hw, *rate_hw;
@@ -877,6 +877,7 @@ static void __init sunxi_divs_clk_setup(struct device_node *node,
 
 	/* Set up factor clock that we will be dividing */
 	pclk = sunxi_factors_clk_setup(node, data->factors);
+	parent = __clk_get_name(pclk);
 
 	reg = of_iomap(node, 0);
 
-- 
1.8.5.2
