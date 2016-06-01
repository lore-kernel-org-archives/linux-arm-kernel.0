From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Wed,  1 Jun 2016 16:15:01 -0700
Subject: [PATCH 02/34] clk: at91: Migrate to clk_hw based registration and OF
 APIs
In-Reply-To: <20160601231533.9354-1-stephen.boyd@linaro.org>
References: <20160601231533.9354-1-stephen.boyd@linaro.org>
Message-ID: <20160601231533.9354-3-stephen.boyd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have clk_hw based provider APIs to register clks, we
can get rid of struct clk pointers in this driver, allowing us to
move closer to a clear split of consumer and provider clk APIs.

Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>
Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---

See commit 58657d189a2f and it's children for details on this
new registration API.

 drivers/clk/at91/clk-generated.c    | 30 +++++++------
 drivers/clk/at91/clk-h32mx.c        |  8 ++--
 drivers/clk/at91/clk-main.c         | 88 ++++++++++++++++++++++---------------
 drivers/clk/at91/clk-master.c       | 21 +++++----
 drivers/clk/at91/clk-peripheral.c   | 39 +++++++++-------
 drivers/clk/at91/clk-pll.c          | 21 +++++----
 drivers/clk/at91/clk-plldiv.c       | 24 +++++-----
 drivers/clk/at91/clk-programmable.c | 22 ++++++----
 drivers/clk/at91/clk-slow.c         | 88 ++++++++++++++++++++++---------------
 drivers/clk/at91/clk-smd.c          | 22 ++++++----
 drivers/clk/at91/clk-system.c       | 22 ++++++----
 drivers/clk/at91/clk-usb.c          | 69 +++++++++++++++++------------
 drivers/clk/at91/clk-utmi.c         | 22 ++++++----
 13 files changed, 277 insertions(+), 199 deletions(-)

diff --git a/drivers/clk/at91/clk-generated.c b/drivers/clk/at91/clk-generated.c
index e1aa210dd7aa..8f1585b3abe5 100644
--- a/drivers/clk/at91/clk-generated.c
+++ b/drivers/clk/at91/clk-generated.c
@@ -233,14 +233,16 @@ static void clk_generated_startup(struct clk_generated *gck)
 					>> AT91_PMC_PCR_GCKDIV_OFFSET;
 }
 
-static struct clk * __init
-at91_clk_register_generated(struct regmap *regmap,  spinlock_t *lock, const char
-			    *name, const char **parent_names, u8 num_parents,
-			    u8 id, const struct clk_range *range)
+static struct clk_hw * __init
+at91_clk_register_generated(struct regmap *regmap, spinlock_t *lock,
+			    const char *name, const char **parent_names,
+			    u8 num_parents, u8 id,
+			    const struct clk_range *range)
 {
 	struct clk_generated *gck;
-	struct clk *clk = NULL;
 	struct clk_init_data init;
+	struct clk_hw *hw;
+	int ret;
 
 	gck = kzalloc(sizeof(*gck), GFP_KERNEL);
 	if (!gck)
@@ -258,13 +260,15 @@ at91_clk_register_generated(struct regmap *regmap,  spinlock_t *lock, const char
 	gck->lock = lock;
 	gck->range = *range;
 
-	clk = clk_register(NULL, &gck->hw);
-	if (IS_ERR(clk))
+	hw = &gck->hw;
+	ret = clk_hw_register(NULL, &gck->hw);
+	if (ret) {
 		kfree(gck);
-	else
+		hw = ERR_PTR(ret);
+	} else
 		clk_generated_startup(gck);
 
-	return clk;
+	return hw;
 }
 
 void __init of_sama5d2_clk_generated_setup(struct device_node *np)
@@ -272,7 +276,7 @@ void __init of_sama5d2_clk_generated_setup(struct device_node *np)
 	int num;
 	u32 id;
 	const char *name;
-	struct clk *clk;
+	struct clk_hw *hw;
 	unsigned int num_parents;
 	const char *parent_names[GENERATED_SOURCE_MAX];
 	struct device_node *gcknp;
@@ -306,13 +310,13 @@ void __init of_sama5d2_clk_generated_setup(struct device_node *np)
 		of_at91_get_clk_range(gcknp, "atmel,clk-output-range",
 				      &range);
 
-		clk = at91_clk_register_generated(regmap, &pmc_pcr_lock, name,
+		hw = at91_clk_register_generated(regmap, &pmc_pcr_lock, name,
 						  parent_names, num_parents,
 						  id, &range);
-		if (IS_ERR(clk))
+		if (IS_ERR(hw))
 			continue;
 
-		of_clk_add_provider(gcknp, of_clk_src_simple_get, clk);
+		of_clk_add_hw_provider(gcknp, of_clk_hw_simple_get, hw);
 	}
 }
 CLK_OF_DECLARE(of_sama5d2_clk_generated_setup, "atmel,sama5d2-clk-generated",
diff --git a/drivers/clk/at91/clk-h32mx.c b/drivers/clk/at91/clk-h32mx.c
index 8e20c8a76db7..e0daa4a31f88 100644
--- a/drivers/clk/at91/clk-h32mx.c
+++ b/drivers/clk/at91/clk-h32mx.c
@@ -92,7 +92,7 @@ static void __init of_sama5d4_clk_h32mx_setup(struct device_node *np)
 	struct clk_init_data init;
 	const char *parent_name;
 	struct regmap *regmap;
-	struct clk *clk;
+	int ret;
 
 	regmap = syscon_node_to_regmap(of_get_parent(np));
 	if (IS_ERR(regmap))
@@ -113,13 +113,13 @@ static void __init of_sama5d4_clk_h32mx_setup(struct device_node *np)
 	h32mxclk->hw.init = &init;
 	h32mxclk->regmap = regmap;
 
-	clk = clk_register(NULL, &h32mxclk->hw);
-	if (IS_ERR(clk)) {
+	ret = clk_hw_register(NULL, &h32mxclk->hw);
+	if (ret) {
 		kfree(h32mxclk);
 		return;
 	}
 
-	of_clk_add_provider(np, of_clk_src_simple_get, clk);
+	of_clk_add_hw_provider(np, of_clk_hw_simple_get, &h32mxclk->hw);
 }
 CLK_OF_DECLARE(of_sama5d4_clk_h32mx_setup, "atmel,sama5d4-clk-h32mx",
 	       of_sama5d4_clk_h32mx_setup);
diff --git a/drivers/clk/at91/clk-main.c b/drivers/clk/at91/clk-main.c
index 58b5baca670c..c813c27f2e58 100644
--- a/drivers/clk/at91/clk-main.c
+++ b/drivers/clk/at91/clk-main.c
@@ -128,15 +128,16 @@ static const struct clk_ops main_osc_ops = {
 	.is_prepared = clk_main_osc_is_prepared,
 };
 
-static struct clk * __init
+static struct clk_hw * __init
 at91_clk_register_main_osc(struct regmap *regmap,
 			   const char *name,
 			   const char *parent_name,
 			   bool bypass)
 {
 	struct clk_main_osc *osc;
-	struct clk *clk = NULL;
 	struct clk_init_data init;
+	struct clk_hw *hw;
+	int ret;
 
 	if (!name || !parent_name)
 		return ERR_PTR(-EINVAL);
@@ -160,16 +161,19 @@ at91_clk_register_main_osc(struct regmap *regmap,
 				   AT91_PMC_MOSCEN,
 				   AT91_PMC_OSCBYPASS | AT91_PMC_KEY);
 
-	clk = clk_register(NULL, &osc->hw);
-	if (IS_ERR(clk))
+	hw = &osc->hw;
+	ret = clk_hw_register(NULL, &osc->hw);
+	if (ret) {
 		kfree(osc);
+		hw = ERR_PTR(ret);
+	}
 
-	return clk;
+	return hw;
 }
 
 static void __init of_at91rm9200_clk_main_osc_setup(struct device_node *np)
 {
-	struct clk *clk;
+	struct clk_hw *hw;
 	const char *name = np->name;
 	const char *parent_name;
 	struct regmap *regmap;
@@ -183,11 +187,11 @@ static void __init of_at91rm9200_clk_main_osc_setup(struct device_node *np)
 	if (IS_ERR(regmap))
 		return;
 
-	clk = at91_clk_register_main_osc(regmap, name, parent_name, bypass);
-	if (IS_ERR(clk))
+	hw = at91_clk_register_main_osc(regmap, name, parent_name, bypass);
+	if (IS_ERR(hw))
 		return;
 
-	of_clk_add_provider(np, of_clk_src_simple_get, clk);
+	of_clk_add_hw_provider(np, of_clk_hw_simple_get, hw);
 }
 CLK_OF_DECLARE(at91rm9200_clk_main_osc, "atmel,at91rm9200-clk-main-osc",
 	       of_at91rm9200_clk_main_osc_setup);
@@ -271,14 +275,15 @@ static const struct clk_ops main_rc_osc_ops = {
 	.recalc_accuracy = clk_main_rc_osc_recalc_accuracy,
 };
 
-static struct clk * __init
+static struct clk_hw * __init
 at91_clk_register_main_rc_osc(struct regmap *regmap,
 			      const char *name,
 			      u32 frequency, u32 accuracy)
 {
 	struct clk_main_rc_osc *osc;
-	struct clk *clk = NULL;
 	struct clk_init_data init;
+	struct clk_hw *hw;
+	int ret;
 
 	if (!name || !frequency)
 		return ERR_PTR(-EINVAL);
@@ -298,16 +303,19 @@ at91_clk_register_main_rc_osc(struct regmap *regmap,
 	osc->frequency = frequency;
 	osc->accuracy = accuracy;
 
-	clk = clk_register(NULL, &osc->hw);
-	if (IS_ERR(clk))
+	hw = &osc->hw;
+	ret = clk_hw_register(NULL, hw);
+	if (ret) {
 		kfree(osc);
+		hw = ERR_PTR(ret);
+	}
 
-	return clk;
+	return hw;
 }
 
 static void __init of_at91sam9x5_clk_main_rc_osc_setup(struct device_node *np)
 {
-	struct clk *clk;
+	struct clk_hw *hw;
 	u32 frequency = 0;
 	u32 accuracy = 0;
 	const char *name = np->name;
@@ -321,11 +329,11 @@ static void __init of_at91sam9x5_clk_main_rc_osc_setup(struct device_node *np)
 	if (IS_ERR(regmap))
 		return;
 
-	clk = at91_clk_register_main_rc_osc(regmap, name, frequency, accuracy);
-	if (IS_ERR(clk))
+	hw = at91_clk_register_main_rc_osc(regmap, name, frequency, accuracy);
+	if (IS_ERR(hw))
 		return;
 
-	of_clk_add_provider(np, of_clk_src_simple_get, clk);
+	of_clk_add_hw_provider(np, of_clk_hw_simple_get, hw);
 }
 CLK_OF_DECLARE(at91sam9x5_clk_main_rc_osc, "atmel,at91sam9x5-clk-main-rc-osc",
 	       of_at91sam9x5_clk_main_rc_osc_setup);
@@ -395,14 +403,15 @@ static const struct clk_ops rm9200_main_ops = {
 	.recalc_rate = clk_rm9200_main_recalc_rate,
 };
 
-static struct clk * __init
+static struct clk_hw * __init
 at91_clk_register_rm9200_main(struct regmap *regmap,
 			      const char *name,
 			      const char *parent_name)
 {
 	struct clk_rm9200_main *clkmain;
-	struct clk *clk = NULL;
 	struct clk_init_data init;
+	struct clk_hw *hw;
+	int ret;
 
 	if (!name)
 		return ERR_PTR(-EINVAL);
@@ -423,16 +432,19 @@ at91_clk_register_rm9200_main(struct regmap *regmap,
 	clkmain->hw.init = &init;
 	clkmain->regmap = regmap;
 
-	clk = clk_register(NULL, &clkmain->hw);
-	if (IS_ERR(clk))
+	hw = &clkmain->hw;
+	ret = clk_hw_register(NULL, &clkmain->hw);
+	if (ret) {
 		kfree(clkmain);
+		hw = ERR_PTR(ret);
+	}
 
-	return clk;
+	return hw;
 }
 
 static void __init of_at91rm9200_clk_main_setup(struct device_node *np)
 {
-	struct clk *clk;
+	struct clk_hw *hw;
 	const char *parent_name;
 	const char *name = np->name;
 	struct regmap *regmap;
@@ -444,11 +456,11 @@ static void __init of_at91rm9200_clk_main_setup(struct device_node *np)
 	if (IS_ERR(regmap))
 		return;
 
-	clk = at91_clk_register_rm9200_main(regmap, name, parent_name);
-	if (IS_ERR(clk))
+	hw = at91_clk_register_rm9200_main(regmap, name, parent_name);
+	if (IS_ERR(hw))
 		return;
 
-	of_clk_add_provider(np, of_clk_src_simple_get, clk);
+	of_clk_add_hw_provider(np, of_clk_hw_simple_get, hw);
 }
 CLK_OF_DECLARE(at91rm9200_clk_main, "atmel,at91rm9200-clk-main",
 	       of_at91rm9200_clk_main_setup);
@@ -529,16 +541,17 @@ static const struct clk_ops sam9x5_main_ops = {
 	.get_parent = clk_sam9x5_main_get_parent,
 };
 
-static struct clk * __init
+static struct clk_hw * __init
 at91_clk_register_sam9x5_main(struct regmap *regmap,
 			      const char *name,
 			      const char **parent_names,
 			      int num_parents)
 {
 	struct clk_sam9x5_main *clkmain;
-	struct clk *clk = NULL;
 	struct clk_init_data init;
 	unsigned int status;
+	struct clk_hw *hw;
+	int ret;
 
 	if (!name)
 		return ERR_PTR(-EINVAL);
@@ -561,16 +574,19 @@ at91_clk_register_sam9x5_main(struct regmap *regmap,
 	regmap_read(clkmain->regmap, AT91_CKGR_MOR, &status);
 	clkmain->parent = status & AT91_PMC_MOSCEN ? 1 : 0;
 
-	clk = clk_register(NULL, &clkmain->hw);
-	if (IS_ERR(clk))
+	hw = &clkmain->hw;
+	ret = clk_hw_register(NULL, &clkmain->hw);
+	if (ret) {
 		kfree(clkmain);
+		hw = ERR_PTR(ret);
+	}
 
-	return clk;
+	return hw;
 }
 
 static void __init of_at91sam9x5_clk_main_setup(struct device_node *np)
 {
-	struct clk *clk;
+	struct clk_hw *hw;
 	const char *parent_names[2];
 	unsigned int num_parents;
 	const char *name = np->name;
@@ -587,12 +603,12 @@ static void __init of_at91sam9x5_clk_main_setup(struct device_node *np)
 
 	of_property_read_string(np, "clock-output-names", &name);
 
-	clk = at91_clk_register_sam9x5_main(regmap, name, parent_names,
+	hw = at91_clk_register_sam9x5_main(regmap, name, parent_names,
 					    num_parents);
-	if (IS_ERR(clk))
+	if (IS_ERR(hw))
 		return;
 
-	of_clk_add_provider(np, of_clk_src_simple_get, clk);
+	of_clk_add_hw_provider(np, of_clk_hw_simple_get, hw);
 }
 CLK_OF_DECLARE(at91sam9x5_clk_main, "atmel,at91sam9x5-clk-main",
 	       of_at91sam9x5_clk_main_setup);
diff --git a/drivers/clk/at91/clk-master.c b/drivers/clk/at91/clk-master.c
index d1021e106191..e9cba9fc26d7 100644
--- a/drivers/clk/at91/clk-master.c
+++ b/drivers/clk/at91/clk-master.c
@@ -120,7 +120,7 @@ static const struct clk_ops master_ops = {
 	.get_parent = clk_master_get_parent,
 };
 
-static struct clk * __init
+static struct clk_hw * __init
 at91_clk_register_master(struct regmap *regmap,
 		const char *name, int num_parents,
 		const char **parent_names,
@@ -128,8 +128,9 @@ at91_clk_register_master(struct regmap *regmap,
 		const struct clk_master_characteristics *characteristics)
 {
 	struct clk_master *master;
-	struct clk *clk = NULL;
 	struct clk_init_data init;
+	struct clk_hw *hw;
+	int ret;
 
 	if (!name || !num_parents || !parent_names)
 		return ERR_PTR(-EINVAL);
@@ -149,12 +150,14 @@ at91_clk_register_master(struct regmap *regmap,
 	master->characteristics = characteristics;
 	master->regmap = regmap;
 
-	clk = clk_register(NULL, &master->hw);
-	if (IS_ERR(clk)) {
+	hw = &master->hw;
+	ret = clk_hw_register(NULL, &master->hw);
+	if (ret) {
 		kfree(master);
+		hw = ERR_PTR(ret);
 	}
 
-	return clk;
+	return hw;
 }
 
 
@@ -198,7 +201,7 @@ static void __init
 of_at91_clk_master_setup(struct device_node *np,
 			 const struct clk_master_layout *layout)
 {
-	struct clk *clk;
+	struct clk_hw *hw;
 	unsigned int num_parents;
 	const char *parent_names[MASTER_SOURCE_MAX];
 	const char *name = np->name;
@@ -221,13 +224,13 @@ of_at91_clk_master_setup(struct device_node *np,
 	if (IS_ERR(regmap))
 		return;
 
-	clk = at91_clk_register_master(regmap, name, num_parents,
+	hw = at91_clk_register_master(regmap, name, num_parents,
 				       parent_names, layout,
 				       characteristics);
-	if (IS_ERR(clk))
+	if (IS_ERR(hw))
 		goto out_free_characteristics;
 
-	of_clk_add_provider(np, of_clk_src_simple_get, clk);
+	of_clk_add_hw_provider(np, of_clk_hw_simple_get, hw);
 	return;
 
 out_free_characteristics:
diff --git a/drivers/clk/at91/clk-peripheral.c b/drivers/clk/at91/clk-peripheral.c
index fd160728e990..dc29fd979d3f 100644
--- a/drivers/clk/at91/clk-peripheral.c
+++ b/drivers/clk/at91/clk-peripheral.c
@@ -104,13 +104,14 @@ static const struct clk_ops peripheral_ops = {
 	.is_enabled = clk_peripheral_is_enabled,
 };
 
-static struct clk * __init
+static struct clk_hw * __init
 at91_clk_register_peripheral(struct regmap *regmap, const char *name,
 			     const char *parent_name, u32 id)
 {
 	struct clk_peripheral *periph;
-	struct clk *clk = NULL;
 	struct clk_init_data init;
+	struct clk_hw *hw;
+	int ret;
 
 	if (!name || !parent_name || id > PERIPHERAL_ID_MAX)
 		return ERR_PTR(-EINVAL);
@@ -129,11 +130,14 @@ at91_clk_register_peripheral(struct regmap *regmap, const char *name,
 	periph->hw.init = &init;
 	periph->regmap = regmap;
 
-	clk = clk_register(NULL, &periph->hw);
-	if (IS_ERR(clk))
+	hw = &periph->hw;
+	ret = clk_hw_register(NULL, &periph->hw);
+	if (ret) {
 		kfree(periph);
+		hw = ERR_PTR(ret);
+	}
 
-	return clk;
+	return hw;
 }
 
 static void clk_sam9x5_peripheral_autodiv(struct clk_sam9x5_peripheral *periph)
@@ -327,14 +331,15 @@ static const struct clk_ops sam9x5_peripheral_ops = {
 	.set_rate = clk_sam9x5_peripheral_set_rate,
 };
 
-static struct clk * __init
+static struct clk_hw * __init
 at91_clk_register_sam9x5_peripheral(struct regmap *regmap, spinlock_t *lock,
 				    const char *name, const char *parent_name,
 				    u32 id, const struct clk_range *range)
 {
 	struct clk_sam9x5_peripheral *periph;
-	struct clk *clk = NULL;
 	struct clk_init_data init;
+	struct clk_hw *hw;
+	int ret;
 
 	if (!name || !parent_name)
 		return ERR_PTR(-EINVAL);
@@ -357,13 +362,15 @@ at91_clk_register_sam9x5_peripheral(struct regmap *regmap, spinlock_t *lock,
 	periph->auto_div = true;
 	periph->range = *range;
 
-	clk = clk_register(NULL, &periph->hw);
-	if (IS_ERR(clk))
+	hw = &periph->hw;
+	ret = clk_hw_register(NULL, &periph->hw);
+	if (ret) {
 		kfree(periph);
-	else
+		hw = ERR_PTR(ret);
+	} else
 		clk_sam9x5_peripheral_autodiv(periph);
 
-	return clk;
+	return hw;
 }
 
 static void __init
@@ -371,7 +378,7 @@ of_at91_clk_periph_setup(struct device_node *np, u8 type)
 {
 	int num;
 	u32 id;
-	struct clk *clk;
+	struct clk_hw *hw;
 	const char *parent_name;
 	const char *name;
 	struct device_node *periphclknp;
@@ -400,7 +407,7 @@ of_at91_clk_periph_setup(struct device_node *np, u8 type)
 			name = periphclknp->name;
 
 		if (type == PERIPHERAL_AT91RM9200) {
-			clk = at91_clk_register_peripheral(regmap, name,
+			hw = at91_clk_register_peripheral(regmap, name,
 							   parent_name, id);
 		} else {
 			struct clk_range range = CLK_RANGE(0, 0);
@@ -409,17 +416,17 @@ of_at91_clk_periph_setup(struct device_node *np, u8 type)
 					      "atmel,clk-output-range",
 					      &range);
 
-			clk = at91_clk_register_sam9x5_peripheral(regmap,
+			hw = at91_clk_register_sam9x5_peripheral(regmap,
 								  &pmc_pcr_lock,
 								  name,
 								  parent_name,
 								  id, &range);
 		}
 
-		if (IS_ERR(clk))
+		if (IS_ERR(hw))
 			continue;
 
-		of_clk_add_provider(periphclknp, of_clk_src_simple_get, clk);
+		of_clk_add_hw_provider(periphclknp, of_clk_hw_simple_get, hw);
 	}
 }
 
diff --git a/drivers/clk/at91/clk-pll.c b/drivers/clk/at91/clk-pll.c
index fb2e0b56d4b7..45ad168e1496 100644
--- a/drivers/clk/at91/clk-pll.c
+++ b/drivers/clk/at91/clk-pll.c
@@ -296,17 +296,18 @@ static const struct clk_ops pll_ops = {
 	.set_rate = clk_pll_set_rate,
 };
 
-static struct clk * __init
+static struct clk_hw * __init
 at91_clk_register_pll(struct regmap *regmap, const char *name,
 		      const char *parent_name, u8 id,
 		      const struct clk_pll_layout *layout,
 		      const struct clk_pll_characteristics *characteristics)
 {
 	struct clk_pll *pll;
-	struct clk *clk = NULL;
+	struct clk_hw *hw;
 	struct clk_init_data init;
 	int offset = PLL_REG(id);
 	unsigned int pllr;
+	int ret;
 
 	if (id > PLL_MAX_ID)
 		return ERR_PTR(-EINVAL);
@@ -330,12 +331,14 @@ at91_clk_register_pll(struct regmap *regmap, const char *name,
 	pll->div = PLL_DIV(pllr);
 	pll->mul = PLL_MUL(pllr, layout);
 
-	clk = clk_register(NULL, &pll->hw);
-	if (IS_ERR(clk)) {
+	hw = &pll->hw;
+	ret = clk_hw_register(NULL, &pll->hw);
+	if (ret) {
 		kfree(pll);
+		hw = ERR_PTR(ret);
 	}
 
-	return clk;
+	return hw;
 }
 
 
@@ -465,7 +468,7 @@ of_at91_clk_pll_setup(struct device_node *np,
 		      const struct clk_pll_layout *layout)
 {
 	u32 id;
-	struct clk *clk;
+	struct clk_hw *hw;
 	struct regmap *regmap;
 	const char *parent_name;
 	const char *name = np->name;
@@ -486,12 +489,12 @@ of_at91_clk_pll_setup(struct device_node *np,
 	if (!characteristics)
 		return;
 
-	clk = at91_clk_register_pll(regmap, name, parent_name, id, layout,
+	hw = at91_clk_register_pll(regmap, name, parent_name, id, layout,
 				    characteristics);
-	if (IS_ERR(clk))
+	if (IS_ERR(hw))
 		goto out_free_characteristics;
 
-	of_clk_add_provider(np, of_clk_src_simple_get, clk);
+	of_clk_add_hw_provider(np, of_clk_hw_simple_get, hw);
 	return;
 
 out_free_characteristics:
diff --git a/drivers/clk/at91/clk-plldiv.c b/drivers/clk/at91/clk-plldiv.c
index 2bed26481027..b4afaf22f3fd 100644
--- a/drivers/clk/at91/clk-plldiv.c
+++ b/drivers/clk/at91/clk-plldiv.c
@@ -75,13 +75,14 @@ static const struct clk_ops plldiv_ops = {
 	.set_rate = clk_plldiv_set_rate,
 };
 
-static struct clk * __init
+static struct clk_hw * __init
 at91_clk_register_plldiv(struct regmap *regmap, const char *name,
 			 const char *parent_name)
 {
 	struct clk_plldiv *plldiv;
-	struct clk *clk = NULL;
+	struct clk_hw *hw;
 	struct clk_init_data init;
+	int ret;
 
 	plldiv = kzalloc(sizeof(*plldiv), GFP_KERNEL);
 	if (!plldiv)
@@ -96,18 +97,20 @@ at91_clk_register_plldiv(struct regmap *regmap, const char *name,
 	plldiv->hw.init = &init;
 	plldiv->regmap = regmap;
 
-	clk = clk_register(NULL, &plldiv->hw);
-
-	if (IS_ERR(clk))
+	hw = &plldiv->hw;
+	ret = clk_hw_register(NULL, &plldiv->hw);
+	if (ret) {
 		kfree(plldiv);
+		hw = ERR_PTR(ret);
+	}
 
-	return clk;
+	return hw;
 }
 
 static void __init
 of_at91sam9x5_clk_plldiv_setup(struct device_node *np)
 {
-	struct clk *clk;
+	struct clk_hw *hw;
 	const char *parent_name;
 	const char *name = np->name;
 	struct regmap *regmap;
@@ -120,12 +123,11 @@ of_at91sam9x5_clk_plldiv_setup(struct device_node *np)
 	if (IS_ERR(regmap))
 		return;
 
-	clk = at91_clk_register_plldiv(regmap, name, parent_name);
-	if (IS_ERR(clk))
+	hw = at91_clk_register_plldiv(regmap, name, parent_name);
+	if (IS_ERR(hw))
 		return;
 
-	of_clk_add_provider(np, of_clk_src_simple_get, clk);
-	return;
+	of_clk_add_hw_provider(np, of_clk_hw_simple_get, hw);
 }
 CLK_OF_DECLARE(at91sam9x5_clk_plldiv, "atmel,at91sam9x5-clk-plldiv",
 	       of_at91sam9x5_clk_plldiv_setup);
diff --git a/drivers/clk/at91/clk-programmable.c b/drivers/clk/at91/clk-programmable.c
index 10f846cc8db1..4e30899753e6 100644
--- a/drivers/clk/at91/clk-programmable.c
+++ b/drivers/clk/at91/clk-programmable.c
@@ -170,15 +170,16 @@ static const struct clk_ops programmable_ops = {
 	.set_rate = clk_programmable_set_rate,
 };
 
-static struct clk * __init
+static struct clk_hw * __init
 at91_clk_register_programmable(struct regmap *regmap,
 			       const char *name, const char **parent_names,
 			       u8 num_parents, u8 id,
 			       const struct clk_programmable_layout *layout)
 {
 	struct clk_programmable *prog;
-	struct clk *clk = NULL;
+	struct clk_hw *hw;
 	struct clk_init_data init;
+	int ret;
 
 	if (id > PROG_ID_MAX)
 		return ERR_PTR(-EINVAL);
@@ -198,11 +199,14 @@ at91_clk_register_programmable(struct regmap *regmap,
 	prog->hw.init = &init;
 	prog->regmap = regmap;
 
-	clk = clk_register(NULL, &prog->hw);
-	if (IS_ERR(clk))
+	hw = &prog->hw;
+	ret = clk_hw_register(NULL, &prog->hw);
+	if (ret) {
 		kfree(prog);
+		hw = &prog->hw;
+	}
 
-	return clk;
+	return hw;
 }
 
 static const struct clk_programmable_layout at91rm9200_programmable_layout = {
@@ -229,7 +233,7 @@ of_at91_clk_prog_setup(struct device_node *np,
 {
 	int num;
 	u32 id;
-	struct clk *clk;
+	struct clk_hw *hw;
 	unsigned int num_parents;
 	const char *parent_names[PROG_SOURCE_MAX];
 	const char *name;
@@ -257,13 +261,13 @@ of_at91_clk_prog_setup(struct device_node *np,
 		if (of_property_read_string(np, "clock-output-names", &name))
 			name = progclknp->name;
 
-		clk = at91_clk_register_programmable(regmap, name,
+		hw = at91_clk_register_programmable(regmap, name,
 						     parent_names, num_parents,
 						     id, layout);
-		if (IS_ERR(clk))
+		if (IS_ERR(hw))
 			continue;
 
-		of_clk_add_provider(progclknp, of_clk_src_simple_get, clk);
+		of_clk_add_hw_provider(progclknp, of_clk_hw_simple_get, hw);
 	}
 }
 
diff --git a/drivers/clk/at91/clk-slow.c b/drivers/clk/at91/clk-slow.c
index 61090b1146cf..cd831e19ba72 100644
--- a/drivers/clk/at91/clk-slow.c
+++ b/drivers/clk/at91/clk-slow.c
@@ -111,7 +111,7 @@ static const struct clk_ops slow_osc_ops = {
 	.is_prepared = clk_slow_osc_is_prepared,
 };
 
-static struct clk * __init
+static struct clk_hw * __init
 at91_clk_register_slow_osc(void __iomem *sckcr,
 			   const char *name,
 			   const char *parent_name,
@@ -119,8 +119,9 @@ at91_clk_register_slow_osc(void __iomem *sckcr,
 			   bool bypass)
 {
 	struct clk_slow_osc *osc;
-	struct clk *clk = NULL;
+	struct clk_hw *hw;
 	struct clk_init_data init;
+	int ret;
 
 	if (!sckcr || !name || !parent_name)
 		return ERR_PTR(-EINVAL);
@@ -143,17 +144,20 @@ at91_clk_register_slow_osc(void __iomem *sckcr,
 		writel((readl(sckcr) & ~AT91_SCKC_OSC32EN) | AT91_SCKC_OSC32BYP,
 		       sckcr);
 
-	clk = clk_register(NULL, &osc->hw);
-	if (IS_ERR(clk))
+	hw = &osc->hw;
+	ret = clk_hw_register(NULL, &osc->hw);
+	if (ret) {
 		kfree(osc);
+		hw = ERR_PTR(ret);
+	}
 
-	return clk;
+	return hw;
 }
 
 void __init of_at91sam9x5_clk_slow_osc_setup(struct device_node *np,
 					     void __iomem *sckcr)
 {
-	struct clk *clk;
+	struct clk_hw *hw;
 	const char *parent_name;
 	const char *name = np->name;
 	u32 startup;
@@ -164,12 +168,12 @@ void __init of_at91sam9x5_clk_slow_osc_setup(struct device_node *np,
 	of_property_read_u32(np, "atmel,startup-time-usec", &startup);
 	bypass = of_property_read_bool(np, "atmel,osc-bypass");
 
-	clk = at91_clk_register_slow_osc(sckcr, name, parent_name, startup,
+	hw = at91_clk_register_slow_osc(sckcr, name, parent_name, startup,
 					 bypass);
-	if (IS_ERR(clk))
+	if (IS_ERR(hw))
 		return;
 
-	of_clk_add_provider(np, of_clk_src_simple_get, clk);
+	of_clk_add_hw_provider(np, of_clk_hw_simple_get, hw);
 }
 
 static unsigned long clk_slow_rc_osc_recalc_rate(struct clk_hw *hw,
@@ -223,7 +227,7 @@ static const struct clk_ops slow_rc_osc_ops = {
 	.recalc_accuracy = clk_slow_rc_osc_recalc_accuracy,
 };
 
-static struct clk * __init
+static struct clk_hw * __init
 at91_clk_register_slow_rc_osc(void __iomem *sckcr,
 			      const char *name,
 			      unsigned long frequency,
@@ -231,8 +235,9 @@ at91_clk_register_slow_rc_osc(void __iomem *sckcr,
 			      unsigned long startup)
 {
 	struct clk_slow_rc_osc *osc;
-	struct clk *clk = NULL;
+	struct clk_hw *hw;
 	struct clk_init_data init;
+	int ret;
 
 	if (!sckcr || !name)
 		return ERR_PTR(-EINVAL);
@@ -253,17 +258,20 @@ at91_clk_register_slow_rc_osc(void __iomem *sckcr,
 	osc->accuracy = accuracy;
 	osc->startup_usec = startup;
 
-	clk = clk_register(NULL, &osc->hw);
-	if (IS_ERR(clk))
+	hw = &osc->hw;
+	ret = clk_hw_register(NULL, &osc->hw);
+	if (ret) {
 		kfree(osc);
+		hw = ERR_PTR(ret);
+	}
 
-	return clk;
+	return hw;
 }
 
 void __init of_at91sam9x5_clk_slow_rc_osc_setup(struct device_node *np,
 						void __iomem *sckcr)
 {
-	struct clk *clk;
+	struct clk_hw *hw;
 	u32 frequency = 0;
 	u32 accuracy = 0;
 	u32 startup = 0;
@@ -274,12 +282,12 @@ void __init of_at91sam9x5_clk_slow_rc_osc_setup(struct device_node *np,
 	of_property_read_u32(np, "clock-accuracy", &accuracy);
 	of_property_read_u32(np, "atmel,startup-time-usec", &startup);
 
-	clk = at91_clk_register_slow_rc_osc(sckcr, name, frequency, accuracy,
+	hw = at91_clk_register_slow_rc_osc(sckcr, name, frequency, accuracy,
 					    startup);
-	if (IS_ERR(clk))
+	if (IS_ERR(hw))
 		return;
 
-	of_clk_add_provider(np, of_clk_src_simple_get, clk);
+	of_clk_add_hw_provider(np, of_clk_hw_simple_get, hw);
 }
 
 static int clk_sam9x5_slow_set_parent(struct clk_hw *hw, u8 index)
@@ -321,15 +329,16 @@ static const struct clk_ops sam9x5_slow_ops = {
 	.get_parent = clk_sam9x5_slow_get_parent,
 };
 
-static struct clk * __init
+static struct clk_hw * __init
 at91_clk_register_sam9x5_slow(void __iomem *sckcr,
 			      const char *name,
 			      const char **parent_names,
 			      int num_parents)
 {
 	struct clk_sam9x5_slow *slowck;
-	struct clk *clk = NULL;
+	struct clk_hw *hw;
 	struct clk_init_data init;
+	int ret;
 
 	if (!sckcr || !name || !parent_names || !num_parents)
 		return ERR_PTR(-EINVAL);
@@ -348,17 +357,20 @@ at91_clk_register_sam9x5_slow(void __iomem *sckcr,
 	slowck->sckcr = sckcr;
 	slowck->parent = !!(readl(sckcr) & AT91_SCKC_OSCSEL);
 
-	clk = clk_register(NULL, &slowck->hw);
-	if (IS_ERR(clk))
+	hw = &slowck->hw;
+	ret = clk_hw_register(NULL, &slowck->hw);
+	if (ret) {
 		kfree(slowck);
+		hw = ERR_PTR(ret);
+	}
 
-	return clk;
+	return hw;
 }
 
 void __init of_at91sam9x5_clk_slow_setup(struct device_node *np,
 					 void __iomem *sckcr)
 {
-	struct clk *clk;
+	struct clk_hw *hw;
 	const char *parent_names[2];
 	unsigned int num_parents;
 	const char *name = np->name;
@@ -371,12 +383,12 @@ void __init of_at91sam9x5_clk_slow_setup(struct device_node *np,
 
 	of_property_read_string(np, "clock-output-names", &name);
 
-	clk = at91_clk_register_sam9x5_slow(sckcr, name, parent_names,
+	hw = at91_clk_register_sam9x5_slow(sckcr, name, parent_names,
 					    num_parents);
-	if (IS_ERR(clk))
+	if (IS_ERR(hw))
 		return;
 
-	of_clk_add_provider(np, of_clk_src_simple_get, clk);
+	of_clk_add_hw_provider(np, of_clk_hw_simple_get, hw);
 }
 
 static u8 clk_sam9260_slow_get_parent(struct clk_hw *hw)
@@ -393,15 +405,16 @@ static const struct clk_ops sam9260_slow_ops = {
 	.get_parent = clk_sam9260_slow_get_parent,
 };
 
-static struct clk * __init
+static struct clk_hw * __init
 at91_clk_register_sam9260_slow(struct regmap *regmap,
 			       const char *name,
 			       const char **parent_names,
 			       int num_parents)
 {
 	struct clk_sam9260_slow *slowck;
-	struct clk *clk = NULL;
+	struct clk_hw *hw;
 	struct clk_init_data init;
+	int ret;
 
 	if (!name)
 		return ERR_PTR(-EINVAL);
@@ -422,16 +435,19 @@ at91_clk_register_sam9260_slow(struct regmap *regmap,
 	slowck->hw.init = &init;
 	slowck->regmap = regmap;
 
-	clk = clk_register(NULL, &slowck->hw);
-	if (IS_ERR(clk))
+	hw = &slowck->hw;
+	ret = clk_hw_register(NULL, &slowck->hw);
+	if (ret) {
 		kfree(slowck);
+		hw = ERR_PTR(ret);
+	}
 
-	return clk;
+	return hw;
 }
 
 static void __init of_at91sam9260_clk_slow_setup(struct device_node *np)
 {
-	struct clk *clk;
+	struct clk_hw *hw;
 	const char *parent_names[2];
 	unsigned int num_parents;
 	const char *name = np->name;
@@ -448,12 +464,12 @@ static void __init of_at91sam9260_clk_slow_setup(struct device_node *np)
 
 	of_property_read_string(np, "clock-output-names", &name);
 
-	clk = at91_clk_register_sam9260_slow(regmap, name, parent_names,
+	hw = at91_clk_register_sam9260_slow(regmap, name, parent_names,
 					     num_parents);
-	if (IS_ERR(clk))
+	if (IS_ERR(hw))
 		return;
 
-	of_clk_add_provider(np, of_clk_src_simple_get, clk);
+	of_clk_add_hw_provider(np, of_clk_hw_simple_get, hw);
 }
 
 CLK_OF_DECLARE(at91sam9260_clk_slow, "atmel,at91sam9260-clk-slow",
diff --git a/drivers/clk/at91/clk-smd.c b/drivers/clk/at91/clk-smd.c
index 3c04b069d5b8..965c662b90a5 100644
--- a/drivers/clk/at91/clk-smd.c
+++ b/drivers/clk/at91/clk-smd.c
@@ -111,13 +111,14 @@ static const struct clk_ops at91sam9x5_smd_ops = {
 	.set_rate = at91sam9x5_clk_smd_set_rate,
 };
 
-static struct clk * __init
+static struct clk_hw * __init
 at91sam9x5_clk_register_smd(struct regmap *regmap, const char *name,
 			    const char **parent_names, u8 num_parents)
 {
 	struct at91sam9x5_clk_smd *smd;
-	struct clk *clk = NULL;
+	struct clk_hw *hw;
 	struct clk_init_data init;
+	int ret;
 
 	smd = kzalloc(sizeof(*smd), GFP_KERNEL);
 	if (!smd)
@@ -132,16 +133,19 @@ at91sam9x5_clk_register_smd(struct regmap *regmap, const char *name,
 	smd->hw.init = &init;
 	smd->regmap = regmap;
 
-	clk = clk_register(NULL, &smd->hw);
-	if (IS_ERR(clk))
+	hw = &smd->hw;
+	ret = clk_hw_register(NULL, &smd->hw);
+	if (ret) {
 		kfree(smd);
+		hw = ERR_PTR(ret);
+	}
 
-	return clk;
+	return hw;
 }
 
 static void __init of_at91sam9x5_clk_smd_setup(struct device_node *np)
 {
-	struct clk *clk;
+	struct clk_hw *hw;
 	unsigned int num_parents;
 	const char *parent_names[SMD_SOURCE_MAX];
 	const char *name = np->name;
@@ -159,12 +163,12 @@ static void __init of_at91sam9x5_clk_smd_setup(struct device_node *np)
 	if (IS_ERR(regmap))
 		return;
 
-	clk = at91sam9x5_clk_register_smd(regmap, name, parent_names,
+	hw = at91sam9x5_clk_register_smd(regmap, name, parent_names,
 					  num_parents);
-	if (IS_ERR(clk))
+	if (IS_ERR(hw))
 		return;
 
-	of_clk_add_provider(np, of_clk_src_simple_get, clk);
+	of_clk_add_hw_provider(np, of_clk_hw_simple_get, hw);
 }
 CLK_OF_DECLARE(at91sam9x5_clk_smd, "atmel,at91sam9x5-clk-smd",
 	       of_at91sam9x5_clk_smd_setup);
diff --git a/drivers/clk/at91/clk-system.c b/drivers/clk/at91/clk-system.c
index 8f35d8172909..86a36809765d 100644
--- a/drivers/clk/at91/clk-system.c
+++ b/drivers/clk/at91/clk-system.c
@@ -88,13 +88,14 @@ static const struct clk_ops system_ops = {
 	.is_prepared = clk_system_is_prepared,
 };
 
-static struct clk * __init
+static struct clk_hw * __init
 at91_clk_register_system(struct regmap *regmap, const char *name,
 			 const char *parent_name, u8 id)
 {
 	struct clk_system *sys;
-	struct clk *clk = NULL;
+	struct clk_hw *hw;
 	struct clk_init_data init;
+	int ret;
 
 	if (!parent_name || id > SYSTEM_MAX_ID)
 		return ERR_PTR(-EINVAL);
@@ -113,18 +114,21 @@ at91_clk_register_system(struct regmap *regmap, const char *name,
 	sys->hw.init = &init;
 	sys->regmap = regmap;
 
-	clk = clk_register(NULL, &sys->hw);
-	if (IS_ERR(clk))
+	hw = &sys->hw;
+	ret = clk_hw_register(NULL, &sys->hw);
+	if (ret) {
 		kfree(sys);
+		hw = ERR_PTR(ret);
+	}
 
-	return clk;
+	return hw;
 }
 
 static void __init of_at91rm9200_clk_sys_setup(struct device_node *np)
 {
 	int num;
 	u32 id;
-	struct clk *clk;
+	struct clk_hw *hw;
 	const char *name;
 	struct device_node *sysclknp;
 	const char *parent_name;
@@ -147,11 +151,11 @@ static void __init of_at91rm9200_clk_sys_setup(struct device_node *np)
 
 		parent_name = of_clk_get_parent_name(sysclknp, 0);
 
-		clk = at91_clk_register_system(regmap, name, parent_name, id);
-		if (IS_ERR(clk))
+		hw = at91_clk_register_system(regmap, name, parent_name, id);
+		if (IS_ERR(hw))
 			continue;
 
-		of_clk_add_provider(sysclknp, of_clk_src_simple_get, clk);
+		of_clk_add_hw_provider(sysclknp, of_clk_hw_simple_get, hw);
 	}
 }
 CLK_OF_DECLARE(at91rm9200_clk_sys, "atmel,at91rm9200-clk-system",
diff --git a/drivers/clk/at91/clk-usb.c b/drivers/clk/at91/clk-usb.c
index d80bdb0a8b02..791770a563fc 100644
--- a/drivers/clk/at91/clk-usb.c
+++ b/drivers/clk/at91/clk-usb.c
@@ -192,13 +192,14 @@ static const struct clk_ops at91sam9n12_usb_ops = {
 	.set_rate = at91sam9x5_clk_usb_set_rate,
 };
 
-static struct clk * __init
+static struct clk_hw * __init
 at91sam9x5_clk_register_usb(struct regmap *regmap, const char *name,
 			    const char **parent_names, u8 num_parents)
 {
 	struct at91sam9x5_clk_usb *usb;
-	struct clk *clk = NULL;
+	struct clk_hw *hw;
 	struct clk_init_data init;
+	int ret;
 
 	usb = kzalloc(sizeof(*usb), GFP_KERNEL);
 	if (!usb)
@@ -214,20 +215,24 @@ at91sam9x5_clk_register_usb(struct regmap *regmap, const char *name,
 	usb->hw.init = &init;
 	usb->regmap = regmap;
 
-	clk = clk_register(NULL, &usb->hw);
-	if (IS_ERR(clk))
+	hw = &usb->hw;
+	ret = clk_hw_register(NULL, &usb->hw);
+	if (ret) {
 		kfree(usb);
+		hw = ERR_PTR(ret);
+	}
 
-	return clk;
+	return hw;
 }
 
-static struct clk * __init
+static struct clk_hw * __init
 at91sam9n12_clk_register_usb(struct regmap *regmap, const char *name,
 			     const char *parent_name)
 {
 	struct at91sam9x5_clk_usb *usb;
-	struct clk *clk = NULL;
+	struct clk_hw *hw;
 	struct clk_init_data init;
+	int ret;
 
 	usb = kzalloc(sizeof(*usb), GFP_KERNEL);
 	if (!usb)
@@ -242,11 +247,14 @@ at91sam9n12_clk_register_usb(struct regmap *regmap, const char *name,
 	usb->hw.init = &init;
 	usb->regmap = regmap;
 
-	clk = clk_register(NULL, &usb->hw);
-	if (IS_ERR(clk))
+	hw = &usb->hw;
+	ret = clk_hw_register(NULL, &usb->hw);
+	if (ret) {
 		kfree(usb);
+		hw = ERR_PTR(ret);
+	}
 
-	return clk;
+	return hw;
 }
 
 static unsigned long at91rm9200_clk_usb_recalc_rate(struct clk_hw *hw,
@@ -334,13 +342,14 @@ static const struct clk_ops at91rm9200_usb_ops = {
 	.set_rate = at91rm9200_clk_usb_set_rate,
 };
 
-static struct clk * __init
+static struct clk_hw * __init
 at91rm9200_clk_register_usb(struct regmap *regmap, const char *name,
 			    const char *parent_name, const u32 *divisors)
 {
 	struct at91rm9200_clk_usb *usb;
-	struct clk *clk = NULL;
+	struct clk_hw *hw;
 	struct clk_init_data init;
+	int ret;
 
 	usb = kzalloc(sizeof(*usb), GFP_KERNEL);
 	if (!usb)
@@ -356,16 +365,19 @@ at91rm9200_clk_register_usb(struct regmap *regmap, const char *name,
 	usb->regmap = regmap;
 	memcpy(usb->divisors, divisors, sizeof(usb->divisors));
 
-	clk = clk_register(NULL, &usb->hw);
-	if (IS_ERR(clk))
+	hw = &usb->hw;
+	ret = clk_hw_register(NULL, &usb->hw);
+	if (ret) {
 		kfree(usb);
+		hw = ERR_PTR(ret);
+	}
 
-	return clk;
+	return hw;
 }
 
 static void __init of_at91sam9x5_clk_usb_setup(struct device_node *np)
 {
-	struct clk *clk;
+	struct clk_hw *hw;
 	unsigned int num_parents;
 	const char *parent_names[USB_SOURCE_MAX];
 	const char *name = np->name;
@@ -383,19 +395,19 @@ static void __init of_at91sam9x5_clk_usb_setup(struct device_node *np)
 	if (IS_ERR(regmap))
 		return;
 
-	clk = at91sam9x5_clk_register_usb(regmap, name, parent_names,
-					  num_parents);
-	if (IS_ERR(clk))
+	hw = at91sam9x5_clk_register_usb(regmap, name, parent_names,
+					 num_parents);
+	if (IS_ERR(hw))
 		return;
 
-	of_clk_add_provider(np, of_clk_src_simple_get, clk);
+	of_clk_add_hw_provider(np, of_clk_hw_simple_get, hw);
 }
 CLK_OF_DECLARE(at91sam9x5_clk_usb, "atmel,at91sam9x5-clk-usb",
 	       of_at91sam9x5_clk_usb_setup);
 
 static void __init of_at91sam9n12_clk_usb_setup(struct device_node *np)
 {
-	struct clk *clk;
+	struct clk_hw *hw;
 	const char *parent_name;
 	const char *name = np->name;
 	struct regmap *regmap;
@@ -410,18 +422,18 @@ static void __init of_at91sam9n12_clk_usb_setup(struct device_node *np)
 	if (IS_ERR(regmap))
 		return;
 
-	clk = at91sam9n12_clk_register_usb(regmap, name, parent_name);
-	if (IS_ERR(clk))
+	hw = at91sam9n12_clk_register_usb(regmap, name, parent_name);
+	if (IS_ERR(hw))
 		return;
 
-	of_clk_add_provider(np, of_clk_src_simple_get, clk);
+	of_clk_add_hw_provider(np, of_clk_hw_simple_get, hw);
 }
 CLK_OF_DECLARE(at91sam9n12_clk_usb, "atmel,at91sam9n12-clk-usb",
 	       of_at91sam9n12_clk_usb_setup);
 
 static void __init of_at91rm9200_clk_usb_setup(struct device_node *np)
 {
-	struct clk *clk;
+	struct clk_hw *hw;
 	const char *parent_name;
 	const char *name = np->name;
 	u32 divisors[4] = {0, 0, 0, 0};
@@ -440,12 +452,11 @@ static void __init of_at91rm9200_clk_usb_setup(struct device_node *np)
 	regmap = syscon_node_to_regmap(of_get_parent(np));
 	if (IS_ERR(regmap))
 		return;
-
-	clk = at91rm9200_clk_register_usb(regmap, name, parent_name, divisors);
-	if (IS_ERR(clk))
+	hw = at91rm9200_clk_register_usb(regmap, name, parent_name, divisors);
+	if (IS_ERR(hw))
 		return;
 
-	of_clk_add_provider(np, of_clk_src_simple_get, clk);
+	of_clk_add_hw_provider(np, of_clk_hw_simple_get, hw);
 }
 CLK_OF_DECLARE(at91rm9200_clk_usb, "atmel,at91rm9200-clk-usb",
 	       of_at91rm9200_clk_usb_setup);
diff --git a/drivers/clk/at91/clk-utmi.c b/drivers/clk/at91/clk-utmi.c
index 61fcf399e58c..aadabd9d1e2b 100644
--- a/drivers/clk/at91/clk-utmi.c
+++ b/drivers/clk/at91/clk-utmi.c
@@ -77,13 +77,14 @@ static const struct clk_ops utmi_ops = {
 	.recalc_rate = clk_utmi_recalc_rate,
 };
 
-static struct clk * __init
+static struct clk_hw * __init
 at91_clk_register_utmi(struct regmap *regmap,
 		       const char *name, const char *parent_name)
 {
 	struct clk_utmi *utmi;
-	struct clk *clk = NULL;
+	struct clk_hw *hw;
 	struct clk_init_data init;
+	int ret;
 
 	utmi = kzalloc(sizeof(*utmi), GFP_KERNEL);
 	if (!utmi)
@@ -98,16 +99,19 @@ at91_clk_register_utmi(struct regmap *regmap,
 	utmi->hw.init = &init;
 	utmi->regmap = regmap;
 
-	clk = clk_register(NULL, &utmi->hw);
-	if (IS_ERR(clk))
+	hw = &utmi->hw;
+	ret = clk_hw_register(NULL, &utmi->hw);
+	if (ret) {
 		kfree(utmi);
+		hw = ERR_PTR(ret);
+	}
 
-	return clk;
+	return hw;
 }
 
 static void __init of_at91sam9x5_clk_utmi_setup(struct device_node *np)
 {
-	struct clk *clk;
+	struct clk_hw *hw;
 	const char *parent_name;
 	const char *name = np->name;
 	struct regmap *regmap;
@@ -120,11 +124,11 @@ static void __init of_at91sam9x5_clk_utmi_setup(struct device_node *np)
 	if (IS_ERR(regmap))
 		return;
 
-	clk = at91_clk_register_utmi(regmap, name, parent_name);
-	if (IS_ERR(clk))
+	hw = at91_clk_register_utmi(regmap, name, parent_name);
+	if (IS_ERR(hw))
 		return;
 
-	of_clk_add_provider(np, of_clk_src_simple_get, clk);
+	of_clk_add_hw_provider(np, of_clk_hw_simple_get, hw);
 	return;
 }
 CLK_OF_DECLARE(at91sam9x5_clk_utmi, "atmel,at91sam9x5-clk-utmi",
-- 
2.7.4
