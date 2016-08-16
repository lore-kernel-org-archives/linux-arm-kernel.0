From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 16 Aug 2016 15:35:09 +0200
Subject: [RFC 12/17] ASoC: samsung: Switch to new clock controller API
In-Reply-To: <1471354514-24224-1-git-send-email-k.kozlowski@samsung.com>
References: <1471354514-24224-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1471354514-24224-13-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allocate a clock controller and use new clk_register_with_ctrl() API.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 sound/soc/samsung/i2s.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index fa3ff03d97d5..1ec90daa4df4 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -104,6 +104,7 @@ struct i2s_dai {
 	/* Below fields are only valid if this is the primary FIFO */
 	struct clk *clk_table[3];
 	struct clk_onecell_data clk_data;
+	struct clk_ctrl *clk_ctrl;
 };
 
 /* Lock for cross i/f checks */
@@ -1148,6 +1149,7 @@ static void i2s_unregister_clock_provider(struct platform_device *pdev)
 
 	of_clk_del_provider(pdev->dev.of_node);
 	i2s_unregister_clocks(i2s);
+	clk_ctrl_unregister(i2s->clk_ctrl);
 }
 
 static int i2s_register_clock_provider(struct platform_device *pdev)
@@ -1164,6 +1166,10 @@ static int i2s_register_clock_provider(struct platform_device *pdev)
 	if (!of_find_property(dev->of_node, "#clock-cells", NULL))
 		return 0;
 
+	i2s->clk_ctrl = clk_ctrl_register(dev);
+	if (IS_ERR(i2s->clk_ctrl))
+		return PTR_ERR(i2s->clk_ctrl);
+
 	/* Get the RCLKSRC mux clock parent clock names */
 	for (i = 0; i < ARRAY_SIZE(p_names); i++) {
 		rclksrc = clk_get(dev, clk_name[i]);
@@ -1179,13 +1185,14 @@ static int i2s_register_clock_provider(struct platform_device *pdev)
 		writel(val | PSR_PSREN, i2s->addr + I2SPSR);
 
 		i2s->clk_table[CLK_I2S_RCLK_SRC] = clk_register_mux(NULL,
+				i2s->clk_ctrl,
 				"i2s_rclksrc", p_names, ARRAY_SIZE(p_names),
 				CLK_SET_RATE_NO_REPARENT | CLK_SET_RATE_PARENT,
 				i2s->addr + I2SMOD, reg_info->rclksrc_off,
 				1, 0, i2s->lock);
 
 		i2s->clk_table[CLK_I2S_RCLK_PSR] = clk_register_divider(NULL,
-				"i2s_presc", "i2s_rclksrc",
+				i2s->clk_ctrl, "i2s_presc", "i2s_rclksrc",
 				CLK_SET_RATE_PARENT,
 				i2s->addr + I2SPSR, 8, 6, 0, i2s->lock);
 
@@ -1195,8 +1202,8 @@ static int i2s_register_clock_provider(struct platform_device *pdev)
 	of_property_read_string_index(dev->of_node,
 				"clock-output-names", 0, &clk_name[0]);
 
-	i2s->clk_table[CLK_I2S_CDCLK] = clk_register_gate(NULL, clk_name[0],
-				p_names[0], CLK_SET_RATE_PARENT,
+	i2s->clk_table[CLK_I2S_CDCLK] = clk_register_gate(NULL, i2s->clk_ctrl,
+				clk_name[0], p_names[0], CLK_SET_RATE_PARENT,
 				i2s->addr + I2SMOD, reg_info->cdclkcon_off,
 				CLK_GATE_SET_TO_DISABLE, i2s->lock);
 
-- 
1.9.1
