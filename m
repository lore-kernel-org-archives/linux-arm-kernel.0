From: jernej.skrabec@siol.net (Jernej Skrabec)
Date: Tue, 10 Jul 2018 22:34:57 +0200
Subject: [PATCH v2 04/18] drm/sun4i: tcon-top: Cleanup clock handling
In-Reply-To: <20180710203511.18454-1-jernej.skrabec@siol.net>
References: <20180710203511.18454-1-jernej.skrabec@siol.net>
Message-ID: <20180710203511.18454-5-jernej.skrabec@siol.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no need to acquire reference to clock just to get its name.

This commit just cleans up the code. There is no functional change.

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun8i_tcon_top.c | 48 ++++++--------------------
 1 file changed, 11 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c b/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
index 8da0460e0028..9fb51940156f 100644
--- a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
+++ b/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
@@ -44,15 +44,20 @@ static int sun8i_tcon_top_get_connected_ep_id(struct device_node *node,
 }
 
 static struct clk_hw *sun8i_tcon_top_register_gate(struct device *dev,
-						   struct clk *parent,
+						   const char *parent,
 						   void __iomem *regs,
 						   spinlock_t *lock,
 						   u8 bit, int name_index)
 {
 	const char *clk_name, *parent_name;
-	int ret;
+	int ret, index;
+
+	index = of_property_match_string(dev->of_node, "clock-names", parent);
+	if (IS_ERR_VALUE(index))
+		return ERR_PTR(index);
+
+	parent_name = of_clk_get_parent_name(dev->of_node, index);
 
-	parent_name = __clk_get_name(parent);
 	ret = of_property_read_string_index(dev->of_node,
 					    "clock-output-names", name_index,
 					    &clk_name);
@@ -69,7 +74,6 @@ static int sun8i_tcon_top_bind(struct device *dev, struct device *master,
 			       void *data)
 {
 	struct platform_device *pdev = to_platform_device(dev);
-	struct clk *dsi, *tcon_tv0, *tcon_tv1, *tve0, *tve1;
 	struct clk_hw_onecell_data *clk_data;
 	struct sun8i_tcon_top *tcon_top;
 	bool mixer0_unused = false;
@@ -103,36 +107,6 @@ static int sun8i_tcon_top_bind(struct device *dev, struct device *master,
 		return PTR_ERR(tcon_top->bus);
 	}
 
-	dsi = devm_clk_get(dev, "dsi");
-	if (IS_ERR(dsi)) {
-		dev_err(dev, "Couldn't get the dsi clock\n");
-		return PTR_ERR(dsi);
-	}
-
-	tcon_tv0 = devm_clk_get(dev, "tcon-tv0");
-	if (IS_ERR(tcon_tv0)) {
-		dev_err(dev, "Couldn't get the tcon-tv0 clock\n");
-		return PTR_ERR(tcon_tv0);
-	}
-
-	tcon_tv1 = devm_clk_get(dev, "tcon-tv1");
-	if (IS_ERR(tcon_tv1)) {
-		dev_err(dev, "Couldn't get the tcon-tv1 clock\n");
-		return PTR_ERR(tcon_tv1);
-	}
-
-	tve0 = devm_clk_get(dev, "tve0");
-	if (IS_ERR(tve0)) {
-		dev_err(dev, "Couldn't get the tve0 clock\n");
-		return PTR_ERR(tve0);
-	}
-
-	tve1 = devm_clk_get(dev, "tve1");
-	if (IS_ERR(tve1)) {
-		dev_err(dev, "Couldn't get the tve1 clock\n");
-		return PTR_ERR(tve1);
-	}
-
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	regs = devm_ioremap_resource(dev, res);
 	if (IS_ERR(regs))
@@ -203,17 +177,17 @@ static int sun8i_tcon_top_bind(struct device *dev, struct device *master,
 	 * to TVE clock parent.
 	 */
 	clk_data->hws[CLK_TCON_TOP_TV0] =
-		sun8i_tcon_top_register_gate(dev, tcon_tv0, regs,
+		sun8i_tcon_top_register_gate(dev, "tcon-tv0", regs,
 					     &tcon_top->reg_lock,
 					     TCON_TOP_TCON_TV0_GATE, 0);
 
 	clk_data->hws[CLK_TCON_TOP_TV1] =
-		sun8i_tcon_top_register_gate(dev, tcon_tv1, regs,
+		sun8i_tcon_top_register_gate(dev, "tcon-tv1", regs,
 					     &tcon_top->reg_lock,
 					     TCON_TOP_TCON_TV1_GATE, 1);
 
 	clk_data->hws[CLK_TCON_TOP_DSI] =
-		sun8i_tcon_top_register_gate(dev, dsi, regs,
+		sun8i_tcon_top_register_gate(dev, "dsi", regs,
 					     &tcon_top->reg_lock,
 					     TCON_TOP_TCON_DSI_GATE, 2);
 
-- 
2.18.0
