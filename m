From: xerofoify@gmail.com (Nick)
Date: Fri, 13 Jun 2014 21:47:53 -0400
Subject: [PATCH] Fixes two memory leaks in drivers/clk/sunxi/clk-sunxi.c
Message-ID: <1402710473-3295-1-git-send-email-nickkrause@sympatico.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index 4264834..07b45d1 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -41,9 +41,11 @@ static void __init sun4i_osc_clk_setup(struct device_node *node)
 	const char *clk_name = node->name;
 	u32 rate;
 
-	if (of_property_read_u32(node, "clock-frequency", &rate))
+	if (of_property_read_u32(node, "clock-frequency", &rate)) {
+		kfree(fixed);
+		kfree(gate);
 		return;
-
+	}
 	/* allocate fixed-rate and gate clock structs */
 	fixed = kzalloc(sizeof(struct clk_fixed_rate), GFP_KERNEL);
 	if (!fixed)
-- 
1.9.1
