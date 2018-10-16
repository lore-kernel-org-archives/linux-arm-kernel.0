From: alexandre.belloni@bootlin.com (Alexandre Belloni)
Date: Tue, 16 Oct 2018 16:21:41 +0200
Subject: [PATCH v2 03/22] clk: at91: h32mx: separate registration from DT
 parsing
In-Reply-To: <20181016142200.19741-1-alexandre.belloni@bootlin.com>
References: <20181016142200.19741-1-alexandre.belloni@bootlin.com>
Message-ID: <20181016142200.19741-4-alexandre.belloni@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Separate registration out of of_sama5d4_clk_h32mx_setup to allow other code
to use it.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/clk/at91/clk-h32mx.c | 40 ++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 13 deletions(-)

diff --git a/drivers/clk/at91/clk-h32mx.c b/drivers/clk/at91/clk-h32mx.c
index e0daa4a31f88..a3274648b6c0 100644
--- a/drivers/clk/at91/clk-h32mx.c
+++ b/drivers/clk/at91/clk-h32mx.c
@@ -86,25 +86,19 @@ static const struct clk_ops h32mx_ops = {
 	.set_rate = clk_sama5d4_h32mx_set_rate,
 };
 
-static void __init of_sama5d4_clk_h32mx_setup(struct device_node *np)
+struct clk_hw * __init
+at91_clk_register_h32mx(struct regmap *regmap, const char *name,
+			const char *parent_name)
 {
 	struct clk_sama5d4_h32mx *h32mxclk;
 	struct clk_init_data init;
-	const char *parent_name;
-	struct regmap *regmap;
 	int ret;
 
-	regmap = syscon_node_to_regmap(of_get_parent(np));
-	if (IS_ERR(regmap))
-		return;
-
 	h32mxclk = kzalloc(sizeof(*h32mxclk), GFP_KERNEL);
 	if (!h32mxclk)
-		return;
-
-	parent_name = of_clk_get_parent_name(np, 0);
+		return ERR_PTR(-ENOMEM);
 
-	init.name = np->name;
+	init.name = name;
 	init.ops = &h32mx_ops;
 	init.parent_names = parent_name ? &parent_name : NULL;
 	init.num_parents = parent_name ? 1 : 0;
@@ -116,10 +110,30 @@ static void __init of_sama5d4_clk_h32mx_setup(struct device_node *np)
 	ret = clk_hw_register(NULL, &h32mxclk->hw);
 	if (ret) {
 		kfree(h32mxclk);
-		return;
+		return ERR_PTR(ret);
 	}
 
-	of_clk_add_hw_provider(np, of_clk_hw_simple_get, &h32mxclk->hw);
+	return &h32mxclk->hw;
+}
+
+static void __init of_sama5d4_clk_h32mx_setup(struct device_node *np)
+{
+	struct clk_hw *hw;
+	const char *name = np->name;
+	const char *parent_name;
+	struct regmap *regmap;
+
+	regmap = syscon_node_to_regmap(of_get_parent(np));
+	if (IS_ERR(regmap))
+		return;
+
+	parent_name = of_clk_get_parent_name(np, 0);
+
+	hw = at91_clk_register_h32mx(regmap, name, parent_name);
+	if (IS_ERR(hw))
+		return;
+
+	of_clk_add_hw_provider(np, of_clk_hw_simple_get, hw);
 }
 CLK_OF_DECLARE(of_sama5d4_clk_h32mx_setup, "atmel,sama5d4-clk-h32mx",
 	       of_sama5d4_clk_h32mx_setup);
-- 
2.19.1
