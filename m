From: alexandre.belloni@bootlin.com (Alexandre Belloni)
Date: Tue, 16 Oct 2018 16:21:42 +0200
Subject: [PATCH v2 04/22] clk: at91: audio-pll: separate registration from DT
 parsing
In-Reply-To: <20181016142200.19741-1-alexandre.belloni@bootlin.com>
References: <20181016142200.19741-1-alexandre.belloni@bootlin.com>
Message-ID: <20181016142200.19741-5-alexandre.belloni@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Separate registration out of of_sama5d2_clk_audio_pll*_setup to allow other
code to use it.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/clk/at91/clk-audio-pll.c | 147 +++++++++++++++++++++++--------
 1 file changed, 109 insertions(+), 38 deletions(-)

diff --git a/drivers/clk/at91/clk-audio-pll.c b/drivers/clk/at91/clk-audio-pll.c
index b3eaf654fac9..f326023a50a3 100644
--- a/drivers/clk/at91/clk-audio-pll.c
+++ b/drivers/clk/at91/clk-audio-pll.c
@@ -444,85 +444,156 @@ static const struct clk_ops audio_pll_pmc_ops = {
 	.set_rate = clk_audio_pll_pmc_set_rate,
 };
 
-static int of_sama5d2_clk_audio_pll_setup(struct device_node *np,
-					  struct clk_init_data *init,
-					  struct clk_hw *hw,
-					  struct regmap **clk_audio_regmap)
+struct clk_hw * __init
+at91_clk_register_audio_pll_frac(struct regmap *regmap, const char *name,
+				 const char *parent_name)
 {
-	struct regmap *regmap;
-	const char *parent_names[1];
+	struct clk_audio_frac *frac_ck;
+	struct clk_init_data init = {};
 	int ret;
 
-	regmap = syscon_node_to_regmap(of_get_parent(np));
-	if (IS_ERR(regmap))
-		return PTR_ERR(regmap);
+	frac_ck = kzalloc(sizeof(*frac_ck), GFP_KERNEL);
+	if (!frac_ck)
+		return ERR_PTR(-ENOMEM);
 
-	init->name = np->name;
-	of_clk_parent_fill(np, parent_names, 1);
-	init->parent_names = parent_names;
-	init->num_parents = 1;
+	init.name = name;
+	init.ops = &audio_pll_frac_ops;
+	init.parent_names = &parent_name;
+	init.num_parents = 1;
+	init.flags = CLK_SET_RATE_GATE;
 
-	hw->init = init;
-	*clk_audio_regmap = regmap;
+	frac_ck->hw.init = &init;
+	frac_ck->regmap = regmap;
 
-	ret = clk_hw_register(NULL, hw);
-	if (ret)
-		return ret;
+	ret = clk_hw_register(NULL, &frac_ck->hw);
+	if (ret) {
+		kfree(frac_ck);
+		return ERR_PTR(ret);
+	}
 
-	return of_clk_add_hw_provider(np, of_clk_hw_simple_get, hw);
+	return &frac_ck->hw;
 }
 
 static void __init of_sama5d2_clk_audio_pll_frac_setup(struct device_node *np)
 {
-	struct clk_audio_frac *frac_ck;
-	struct clk_init_data init = {};
+	struct clk_hw *hw;
+	const char *name = np->name;
+	const char *parent_name;
+	struct regmap *regmap;
 
-	frac_ck = kzalloc(sizeof(*frac_ck), GFP_KERNEL);
-	if (!frac_ck)
+	regmap = syscon_node_to_regmap(of_get_parent(np));
+	if (IS_ERR(regmap))
 		return;
 
-	init.ops = &audio_pll_frac_ops;
-	init.flags = CLK_SET_RATE_GATE;
+	parent_name = of_clk_get_parent_name(np, 0);
 
-	if (of_sama5d2_clk_audio_pll_setup(np, &init, &frac_ck->hw,
-					   &frac_ck->regmap))
-		kfree(frac_ck);
+	hw = at91_clk_register_audio_pll_frac(regmap, name, parent_name);
+	if (IS_ERR(hw))
+		return;
+
+	of_clk_add_hw_provider(np, of_clk_hw_simple_get, hw);
 }
 
-static void __init of_sama5d2_clk_audio_pll_pad_setup(struct device_node *np)
+struct clk_hw * __init
+at91_clk_register_audio_pll_pad(struct regmap *regmap, const char *name,
+				const char *parent_name)
 {
 	struct clk_audio_pad *apad_ck;
-	struct clk_init_data init = {};
+	struct clk_init_data init;
+	int ret;
 
 	apad_ck = kzalloc(sizeof(*apad_ck), GFP_KERNEL);
 	if (!apad_ck)
-		return;
+		return ERR_PTR(-ENOMEM);
 
+	init.name = name;
 	init.ops = &audio_pll_pad_ops;
+	init.parent_names = &parent_name;
+	init.num_parents = 1;
 	init.flags = CLK_SET_RATE_GATE | CLK_SET_PARENT_GATE |
 		CLK_SET_RATE_PARENT;
 
-	if (of_sama5d2_clk_audio_pll_setup(np, &init, &apad_ck->hw,
-					   &apad_ck->regmap))
+	apad_ck->hw.init = &init;
+	apad_ck->regmap = regmap;
+
+	ret = clk_hw_register(NULL, &apad_ck->hw);
+	if (ret) {
 		kfree(apad_ck);
+		return ERR_PTR(ret);
+	}
+
+	return &apad_ck->hw;
 }
 
-static void __init of_sama5d2_clk_audio_pll_pmc_setup(struct device_node *np)
+static void __init of_sama5d2_clk_audio_pll_pad_setup(struct device_node *np)
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
+	hw = at91_clk_register_audio_pll_pad(regmap, name, parent_name);
+	if (IS_ERR(hw))
+		return;
+
+	of_clk_add_hw_provider(np, of_clk_hw_simple_get, hw);
+}
+
+struct clk_hw * __init
+at91_clk_register_audio_pll_pmc(struct regmap *regmap, const char *name,
+				const char *parent_name)
 {
 	struct clk_audio_pmc *apmc_ck;
-	struct clk_init_data init = {};
+	struct clk_init_data init;
+	int ret;
 
 	apmc_ck = kzalloc(sizeof(*apmc_ck), GFP_KERNEL);
 	if (!apmc_ck)
-		return;
+		return ERR_PTR(-ENOMEM);
 
+	init.name = name;
 	init.ops = &audio_pll_pmc_ops;
+	init.parent_names = &parent_name;
+	init.num_parents = 1;
 	init.flags = CLK_SET_RATE_GATE | CLK_SET_PARENT_GATE |
 		CLK_SET_RATE_PARENT;
 
-	if (of_sama5d2_clk_audio_pll_setup(np, &init, &apmc_ck->hw,
-					   &apmc_ck->regmap))
+	apmc_ck->hw.init = &init;
+	apmc_ck->regmap = regmap;
+
+	ret = clk_hw_register(NULL, &apmc_ck->hw);
+	if (ret) {
 		kfree(apmc_ck);
+		return ERR_PTR(ret);
+	}
+
+	return &apmc_ck->hw;
+}
+
+static void __init of_sama5d2_clk_audio_pll_pmc_setup(struct device_node *np)
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
+	hw = at91_clk_register_audio_pll_pmc(regmap, name, parent_name);
+	if (IS_ERR(hw))
+		return;
+
+	of_clk_add_hw_provider(np, of_clk_hw_simple_get, hw);
 }
 
 CLK_OF_DECLARE(of_sama5d2_clk_audio_pll_frac_setup,
-- 
2.19.1
