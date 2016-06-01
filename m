From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Wed,  1 Jun 2016 16:15:06 -0700
Subject: [PATCH 07/34] clk: berlin: Migrate to clk_hw based registration and
 OF APIs
In-Reply-To: <20160601231533.9354-1-stephen.boyd@linaro.org>
References: <20160601231533.9354-1-stephen.boyd@linaro.org>
Message-ID: <20160601231533.9354-8-stephen.boyd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have clk_hw based provider APIs to register clks, we
can get rid of struct clk pointers while registering clks in
these drivers, allowing us to move closer to a clear split of
consumer and provider clk APIs.

Cc: Jisheng Zhang <jszhang@marvell.com>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---

See commit 58657d189a2f and it's children for details on this
new registration API.

 drivers/clk/berlin/berlin2-avpll.c | 12 ++---
 drivers/clk/berlin/berlin2-avpll.h |  8 +---
 drivers/clk/berlin/berlin2-div.c   |  4 +-
 drivers/clk/berlin/berlin2-div.h   |  4 +-
 drivers/clk/berlin/berlin2-pll.c   |  6 +--
 drivers/clk/berlin/berlin2-pll.h   |  5 +-
 drivers/clk/berlin/bg2.c           | 98 ++++++++++++++++++++------------------
 drivers/clk/berlin/bg2q.c          | 39 ++++++++-------
 8 files changed, 90 insertions(+), 86 deletions(-)

diff --git a/drivers/clk/berlin/berlin2-avpll.c b/drivers/clk/berlin/berlin2-avpll.c
index fd0f26c38465..5b0e4213b3ae 100644
--- a/drivers/clk/berlin/berlin2-avpll.c
+++ b/drivers/clk/berlin/berlin2-avpll.c
@@ -188,7 +188,7 @@ static const struct clk_ops berlin2_avpll_vco_ops = {
 	.recalc_rate	= berlin2_avpll_vco_recalc_rate,
 };
 
-struct clk * __init berlin2_avpll_vco_register(void __iomem *base,
+int __init berlin2_avpll_vco_register(void __iomem *base,
 			       const char *name, const char *parent_name,
 			       u8 vco_flags, unsigned long flags)
 {
@@ -197,7 +197,7 @@ struct clk * __init berlin2_avpll_vco_register(void __iomem *base,
 
 	vco = kzalloc(sizeof(*vco), GFP_KERNEL);
 	if (!vco)
-		return ERR_PTR(-ENOMEM);
+		return -ENOMEM;
 
 	vco->base = base;
 	vco->flags = vco_flags;
@@ -208,7 +208,7 @@ struct clk * __init berlin2_avpll_vco_register(void __iomem *base,
 	init.num_parents = 1;
 	init.flags = flags;
 
-	return clk_register(NULL, &vco->hw);
+	return clk_hw_register(NULL, &vco->hw);
 }
 
 struct berlin2_avpll_channel {
@@ -364,7 +364,7 @@ static const struct clk_ops berlin2_avpll_channel_ops = {
  */
 static const u8 quirk_index[] __initconst = { 0, 6, 5, 4, 3, 2, 1, 7 };
 
-struct clk * __init berlin2_avpll_channel_register(void __iomem *base,
+int __init berlin2_avpll_channel_register(void __iomem *base,
 			   const char *name, u8 index, const char *parent_name,
 			   u8 ch_flags, unsigned long flags)
 {
@@ -373,7 +373,7 @@ struct clk * __init berlin2_avpll_channel_register(void __iomem *base,
 
 	ch = kzalloc(sizeof(*ch), GFP_KERNEL);
 	if (!ch)
-		return ERR_PTR(-ENOMEM);
+		return ENOMEM;
 
 	ch->base = base;
 	if (ch_flags & BERLIN2_AVPLL_SCRAMBLE_QUIRK)
@@ -389,5 +389,5 @@ struct clk * __init berlin2_avpll_channel_register(void __iomem *base,
 	init.num_parents = 1;
 	init.flags = flags;
 
-	return clk_register(NULL, &ch->hw);
+	return clk_hw_register(NULL, &ch->hw);
 }
diff --git a/drivers/clk/berlin/berlin2-avpll.h b/drivers/clk/berlin/berlin2-avpll.h
index a37f5068d299..17e311153b42 100644
--- a/drivers/clk/berlin/berlin2-avpll.h
+++ b/drivers/clk/berlin/berlin2-avpll.h
@@ -19,17 +19,13 @@
 #ifndef __BERLIN2_AVPLL_H
 #define __BERLIN2_AVPLL_H
 
-struct clk;
-
 #define BERLIN2_AVPLL_BIT_QUIRK		BIT(0)
 #define BERLIN2_AVPLL_SCRAMBLE_QUIRK	BIT(1)
 
-struct clk * __init
-berlin2_avpll_vco_register(void __iomem *base, const char *name,
+int berlin2_avpll_vco_register(void __iomem *base, const char *name,
 	   const char *parent_name, u8 vco_flags, unsigned long flags);
 
-struct clk * __init
-berlin2_avpll_channel_register(void __iomem *base, const char *name,
+int berlin2_avpll_channel_register(void __iomem *base, const char *name,
 		       u8 index, const char *parent_name, u8 ch_flags,
 		       unsigned long flags);
 
diff --git a/drivers/clk/berlin/berlin2-div.c b/drivers/clk/berlin/berlin2-div.c
index 81ff97f8aa0b..41ab2d392c57 100644
--- a/drivers/clk/berlin/berlin2-div.c
+++ b/drivers/clk/berlin/berlin2-div.c
@@ -234,7 +234,7 @@ static const struct clk_ops berlin2_div_mux_ops = {
 	.get_parent	= berlin2_div_get_parent,
 };
 
-struct clk * __init
+struct clk_hw * __init
 berlin2_div_register(const struct berlin2_div_map *map,
 		     void __iomem *base, const char *name, u8 div_flags,
 		     const char **parent_names, int num_parents,
@@ -259,7 +259,7 @@ berlin2_div_register(const struct berlin2_div_map *map,
 	if ((div_flags & BERLIN2_DIV_HAS_MUX) == 0)
 		mux_ops = NULL;
 
-	return clk_register_composite(NULL, name, parent_names, num_parents,
+	return clk_hw_register_composite(NULL, name, parent_names, num_parents,
 				      &div->hw, mux_ops, &div->hw, rate_ops,
 				      &div->hw, gate_ops, flags);
 }
diff --git a/drivers/clk/berlin/berlin2-div.h b/drivers/clk/berlin/berlin2-div.h
index 15e3384f3116..10d608eb8716 100644
--- a/drivers/clk/berlin/berlin2-div.h
+++ b/drivers/clk/berlin/berlin2-div.h
@@ -19,7 +19,7 @@
 #ifndef __BERLIN2_DIV_H
 #define __BERLIN2_DIV_H
 
-struct clk;
+struct clk_hw;
 
 #define BERLIN2_DIV_HAS_GATE		BIT(0)
 #define BERLIN2_DIV_HAS_MUX		BIT(1)
@@ -80,7 +80,7 @@ struct berlin2_div_data {
 	u8 div_flags;
 };
 
-struct clk * __init
+struct clk_hw * __init
 berlin2_div_register(const struct berlin2_div_map *map,
 	     void __iomem *base,  const char *name, u8 div_flags,
 	     const char **parent_names, int num_parents,
diff --git a/drivers/clk/berlin/berlin2-pll.c b/drivers/clk/berlin/berlin2-pll.c
index 1c2294d3ba85..4ffbe80f6323 100644
--- a/drivers/clk/berlin/berlin2-pll.c
+++ b/drivers/clk/berlin/berlin2-pll.c
@@ -84,7 +84,7 @@ static const struct clk_ops berlin2_pll_ops = {
 	.recalc_rate	= berlin2_pll_recalc_rate,
 };
 
-struct clk * __init
+int __init
 berlin2_pll_register(const struct berlin2_pll_map *map,
 		     void __iomem *base, const char *name,
 		     const char *parent_name, unsigned long flags)
@@ -94,7 +94,7 @@ berlin2_pll_register(const struct berlin2_pll_map *map,
 
 	pll = kzalloc(sizeof(*pll), GFP_KERNEL);
 	if (!pll)
-		return ERR_PTR(-ENOMEM);
+		return -ENOMEM;
 
 	/* copy pll_map to allow __initconst */
 	memcpy(&pll->map, map, sizeof(*map));
@@ -106,5 +106,5 @@ berlin2_pll_register(const struct berlin2_pll_map *map,
 	init.num_parents = 1;
 	init.flags = flags;
 
-	return clk_register(NULL, &pll->hw);
+	return clk_hw_register(NULL, &pll->hw);
 }
diff --git a/drivers/clk/berlin/berlin2-pll.h b/drivers/clk/berlin/berlin2-pll.h
index 8831ce27ac1e..796874facc4c 100644
--- a/drivers/clk/berlin/berlin2-pll.h
+++ b/drivers/clk/berlin/berlin2-pll.h
@@ -19,8 +19,6 @@
 #ifndef __BERLIN2_PLL_H
 #define __BERLIN2_PLL_H
 
-struct clk;
-
 struct berlin2_pll_map {
 	const u8 vcodiv[16];
 	u8 mult;
@@ -29,8 +27,7 @@ struct berlin2_pll_map {
 	u8 divsel_shift;
 };
 
-struct clk * __init
-berlin2_pll_register(const struct berlin2_pll_map *map,
+int berlin2_pll_register(const struct berlin2_pll_map *map,
 		     void __iomem *base, const char *name,
 		     const char *parent_name, unsigned long flags);
 
diff --git a/drivers/clk/berlin/bg2.c b/drivers/clk/berlin/bg2.c
index 23e0e3be6c37..edf3b96b3b73 100644
--- a/drivers/clk/berlin/bg2.c
+++ b/drivers/clk/berlin/bg2.c
@@ -92,8 +92,7 @@
  */
 
 #define	MAX_CLKS 41
-static struct clk *clks[MAX_CLKS];
-static struct clk_onecell_data clk_data;
+static struct clk_hw_onecell_data *clk_data;
 static DEFINE_SPINLOCK(lock);
 static void __iomem *gbase;
 
@@ -505,8 +504,17 @@ static void __init berlin2_clock_setup(struct device_node *np)
 	struct device_node *parent_np = of_get_parent(np);
 	const char *parent_names[9];
 	struct clk *clk;
+	struct clk_hw *hw;
+	struct clk_hw **hws;
 	u8 avpll_flags = 0;
-	int n;
+	int n, ret;
+
+	clk_data = kzalloc(sizeof(*clk_data) +
+			   sizeof(*clk_data->hws) * MAX_CLKS, GFP_KERNEL);
+	if (!clk_data)
+		return;
+	clk_data->num = MAX_CLKS;
+	hws = clk_data->hws;
 
 	gbase = of_iomap(parent_np, 0);
 	if (!gbase)
@@ -526,118 +534,118 @@ static void __init berlin2_clock_setup(struct device_node *np)
 	}
 
 	/* simple register PLLs */
-	clk = berlin2_pll_register(&bg2_pll_map, gbase + REG_SYSPLLCTL0,
+	ret = berlin2_pll_register(&bg2_pll_map, gbase + REG_SYSPLLCTL0,
 				   clk_names[SYSPLL], clk_names[REFCLK], 0);
-	if (IS_ERR(clk))
+	if (ret)
 		goto bg2_fail;
 
-	clk = berlin2_pll_register(&bg2_pll_map, gbase + REG_MEMPLLCTL0,
+	ret = berlin2_pll_register(&bg2_pll_map, gbase + REG_MEMPLLCTL0,
 				   clk_names[MEMPLL], clk_names[REFCLK], 0);
-	if (IS_ERR(clk))
+	if (ret)
 		goto bg2_fail;
 
-	clk = berlin2_pll_register(&bg2_pll_map, gbase + REG_CPUPLLCTL0,
+	ret = berlin2_pll_register(&bg2_pll_map, gbase + REG_CPUPLLCTL0,
 				   clk_names[CPUPLL], clk_names[REFCLK], 0);
-	if (IS_ERR(clk))
+	if (ret)
 		goto bg2_fail;
 
 	if (of_device_is_compatible(np, "marvell,berlin2-global-register"))
 		avpll_flags |= BERLIN2_AVPLL_SCRAMBLE_QUIRK;
 
 	/* audio/video VCOs */
-	clk = berlin2_avpll_vco_register(gbase + REG_AVPLLCTL0, "avpll_vcoA",
+	ret = berlin2_avpll_vco_register(gbase + REG_AVPLLCTL0, "avpll_vcoA",
 			 clk_names[REFCLK], avpll_flags, 0);
-	if (IS_ERR(clk))
+	if (ret)
 		goto bg2_fail;
 
 	for (n = 0; n < 8; n++) {
-		clk = berlin2_avpll_channel_register(gbase + REG_AVPLLCTL0,
+		ret = berlin2_avpll_channel_register(gbase + REG_AVPLLCTL0,
 			     clk_names[AVPLL_A1 + n], n, "avpll_vcoA",
 			     avpll_flags, 0);
-		if (IS_ERR(clk))
+		if (ret)
 			goto bg2_fail;
 	}
 
-	clk = berlin2_avpll_vco_register(gbase + REG_AVPLLCTL31, "avpll_vcoB",
+	ret = berlin2_avpll_vco_register(gbase + REG_AVPLLCTL31, "avpll_vcoB",
 				 clk_names[REFCLK], BERLIN2_AVPLL_BIT_QUIRK |
 				 avpll_flags, 0);
-	if (IS_ERR(clk))
+	if (ret)
 		goto bg2_fail;
 
 	for (n = 0; n < 8; n++) {
-		clk = berlin2_avpll_channel_register(gbase + REG_AVPLLCTL31,
+		ret = berlin2_avpll_channel_register(gbase + REG_AVPLLCTL31,
 			     clk_names[AVPLL_B1 + n], n, "avpll_vcoB",
 			     BERLIN2_AVPLL_BIT_QUIRK | avpll_flags, 0);
-		if (IS_ERR(clk))
+		if (ret)
 			goto bg2_fail;
 	}
 
 	/* reference clock bypass switches */
 	parent_names[0] = clk_names[SYSPLL];
 	parent_names[1] = clk_names[REFCLK];
-	clk = clk_register_mux(NULL, "syspll_byp", parent_names, 2,
+	hw = clk_hw_register_mux(NULL, "syspll_byp", parent_names, 2,
 			       0, gbase + REG_CLKSWITCH0, 0, 1, 0, &lock);
-	if (IS_ERR(clk))
+	if (IS_ERR(hw))
 		goto bg2_fail;
-	clk_names[SYSPLL] = __clk_get_name(clk);
+	clk_names[SYSPLL] = clk_hw_get_name(hw);
 
 	parent_names[0] = clk_names[MEMPLL];
 	parent_names[1] = clk_names[REFCLK];
-	clk = clk_register_mux(NULL, "mempll_byp", parent_names, 2,
+	hw = clk_hw_register_mux(NULL, "mempll_byp", parent_names, 2,
 			       0, gbase + REG_CLKSWITCH0, 1, 1, 0, &lock);
-	if (IS_ERR(clk))
+	if (IS_ERR(hw))
 		goto bg2_fail;
-	clk_names[MEMPLL] = __clk_get_name(clk);
+	clk_names[MEMPLL] = clk_hw_get_name(hw);
 
 	parent_names[0] = clk_names[CPUPLL];
 	parent_names[1] = clk_names[REFCLK];
-	clk = clk_register_mux(NULL, "cpupll_byp", parent_names, 2,
+	hw = clk_hw_register_mux(NULL, "cpupll_byp", parent_names, 2,
 			       0, gbase + REG_CLKSWITCH0, 2, 1, 0, &lock);
-	if (IS_ERR(clk))
+	if (IS_ERR(hw))
 		goto bg2_fail;
-	clk_names[CPUPLL] = __clk_get_name(clk);
+	clk_names[CPUPLL] = clk_hw_get_name(hw);
 
 	/* clock muxes */
 	parent_names[0] = clk_names[AVPLL_B3];
 	parent_names[1] = clk_names[AVPLL_A3];
-	clk = clk_register_mux(NULL, clk_names[AUDIO1_PLL], parent_names, 2,
+	hw = clk_hw_register_mux(NULL, clk_names[AUDIO1_PLL], parent_names, 2,
 			       0, gbase + REG_CLKSELECT2, 29, 1, 0, &lock);
-	if (IS_ERR(clk))
+	if (IS_ERR(hw))
 		goto bg2_fail;
 
 	parent_names[0] = clk_names[VIDEO0_PLL];
 	parent_names[1] = clk_names[VIDEO_EXT0];
-	clk = clk_register_mux(NULL, clk_names[VIDEO0_IN], parent_names, 2,
+	hw = clk_hw_register_mux(NULL, clk_names[VIDEO0_IN], parent_names, 2,
 			       0, gbase + REG_CLKSELECT3, 4, 1, 0, &lock);
-	if (IS_ERR(clk))
+	if (IS_ERR(hw))
 		goto bg2_fail;
 
 	parent_names[0] = clk_names[VIDEO1_PLL];
 	parent_names[1] = clk_names[VIDEO_EXT0];
-	clk = clk_register_mux(NULL, clk_names[VIDEO1_IN], parent_names, 2,
+	hw = clk_hw_register_mux(NULL, clk_names[VIDEO1_IN], parent_names, 2,
 			       0, gbase + REG_CLKSELECT3, 6, 1, 0, &lock);
-	if (IS_ERR(clk))
+	if (IS_ERR(hw))
 		goto bg2_fail;
 
 	parent_names[0] = clk_names[AVPLL_A2];
 	parent_names[1] = clk_names[AVPLL_B2];
-	clk = clk_register_mux(NULL, clk_names[VIDEO1_PLL], parent_names, 2,
+	hw = clk_hw_register_mux(NULL, clk_names[VIDEO1_PLL], parent_names, 2,
 			       0, gbase + REG_CLKSELECT3, 7, 1, 0, &lock);
-	if (IS_ERR(clk))
+	if (IS_ERR(hw))
 		goto bg2_fail;
 
 	parent_names[0] = clk_names[VIDEO2_PLL];
 	parent_names[1] = clk_names[VIDEO_EXT0];
-	clk = clk_register_mux(NULL, clk_names[VIDEO2_IN], parent_names, 2,
+	hw = clk_hw_register_mux(NULL, clk_names[VIDEO2_IN], parent_names, 2,
 			       0, gbase + REG_CLKSELECT3, 9, 1, 0, &lock);
-	if (IS_ERR(clk))
+	if (IS_ERR(hw))
 		goto bg2_fail;
 
 	parent_names[0] = clk_names[AVPLL_B1];
 	parent_names[1] = clk_names[AVPLL_A5];
-	clk = clk_register_mux(NULL, clk_names[VIDEO2_PLL], parent_names, 2,
+	hw = clk_hw_register_mux(NULL, clk_names[VIDEO2_PLL], parent_names, 2,
 			       0, gbase + REG_CLKSELECT3, 10, 1, 0, &lock);
-	if (IS_ERR(clk))
+	if (IS_ERR(hw))
 		goto bg2_fail;
 
 	/* clock divider cells */
@@ -648,7 +656,7 @@ static void __init berlin2_clock_setup(struct device_node *np)
 		for (k = 0; k < dd->num_parents; k++)
 			parent_names[k] = clk_names[dd->parent_ids[k]];
 
-		clks[CLKID_SYS + n] = berlin2_div_register(&dd->map, gbase,
+		hws[CLKID_SYS + n] = berlin2_div_register(&dd->map, gbase,
 				dd->name, dd->div_flags, parent_names,
 				dd->num_parents, dd->flags, &lock);
 	}
@@ -657,18 +665,18 @@ static void __init berlin2_clock_setup(struct device_node *np)
 	for (n = 0; n < ARRAY_SIZE(bg2_gates); n++) {
 		const struct berlin2_gate_data *gd = &bg2_gates[n];
 
-		clks[CLKID_GETH0 + n] = clk_register_gate(NULL, gd->name,
+		hws[CLKID_GETH0 + n] = clk_hw_register_gate(NULL, gd->name,
 			    gd->parent_name, gd->flags, gbase + REG_CLKENABLE,
 			    gd->bit_idx, 0, &lock);
 	}
 
 	/* twdclk is derived from cpu/3 */
-	clks[CLKID_TWD] =
-		clk_register_fixed_factor(NULL, "twd", "cpu", 0, 1, 3);
+	hws[CLKID_TWD] =
+		clk_hw_register_fixed_factor(NULL, "twd", "cpu", 0, 1, 3);
 
 	/* check for errors on leaf clocks */
 	for (n = 0; n < MAX_CLKS; n++) {
-		if (!IS_ERR(clks[n]))
+		if (!IS_ERR(hws[n]))
 			continue;
 
 		pr_err("%s: Unable to register leaf clock %d\n",
@@ -677,9 +685,7 @@ static void __init berlin2_clock_setup(struct device_node *np)
 	}
 
 	/* register clk-provider */
-	clk_data.clks = clks;
-	clk_data.clk_num = MAX_CLKS;
-	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
+	of_clk_add_hw_provider(np, of_clk_hw_onecell_get, &clk_data);
 
 	return;
 
diff --git a/drivers/clk/berlin/bg2q.c b/drivers/clk/berlin/bg2q.c
index f144547cf76c..0718e831475f 100644
--- a/drivers/clk/berlin/bg2q.c
+++ b/drivers/clk/berlin/bg2q.c
@@ -46,8 +46,7 @@
 #define REG_SDIO1XIN_CLKCTL	0x015c
 
 #define	MAX_CLKS 28
-static struct clk *clks[MAX_CLKS];
-static struct clk_onecell_data clk_data;
+static struct clk_hw_onecell_data *clk_data;
 static DEFINE_SPINLOCK(lock);
 static void __iomem *gbase;
 static void __iomem *cpupll_base;
@@ -293,7 +292,15 @@ static void __init berlin2q_clock_setup(struct device_node *np)
 	struct device_node *parent_np = of_get_parent(np);
 	const char *parent_names[9];
 	struct clk *clk;
-	int n;
+	struct clk_hw **hws;
+	int n, ret;
+
+	clk_data = kzalloc(sizeof(*clk_data) +
+			   sizeof(*clk_data->hws) * MAX_CLKS, GFP_KERNEL);
+	if (!clk_data)
+		return;
+	clk_data->num = MAX_CLKS;
+	hws = clk_data->hws;
 
 	gbase = of_iomap(parent_np, 0);
 	if (!gbase) {
@@ -317,14 +324,14 @@ static void __init berlin2q_clock_setup(struct device_node *np)
 	}
 
 	/* simple register PLLs */
-	clk = berlin2_pll_register(&bg2q_pll_map, gbase + REG_SYSPLLCTL0,
+	ret = berlin2_pll_register(&bg2q_pll_map, gbase + REG_SYSPLLCTL0,
 				   clk_names[SYSPLL], clk_names[REFCLK], 0);
-	if (IS_ERR(clk))
+	if (ret)
 		goto bg2q_fail;
 
-	clk = berlin2_pll_register(&bg2q_pll_map, cpupll_base,
+	ret = berlin2_pll_register(&bg2q_pll_map, cpupll_base,
 				   clk_names[CPUPLL], clk_names[REFCLK], 0);
-	if (IS_ERR(clk))
+	if (ret)
 		goto bg2q_fail;
 
 	/* TODO: add BG2Q AVPLL */
@@ -342,7 +349,7 @@ static void __init berlin2q_clock_setup(struct device_node *np)
 		for (k = 0; k < dd->num_parents; k++)
 			parent_names[k] = clk_names[dd->parent_ids[k]];
 
-		clks[CLKID_SYS + n] = berlin2_div_register(&dd->map, gbase,
+		hws[CLKID_SYS + n] = berlin2_div_register(&dd->map, gbase,
 				dd->name, dd->div_flags, parent_names,
 				dd->num_parents, dd->flags, &lock);
 	}
@@ -351,22 +358,22 @@ static void __init berlin2q_clock_setup(struct device_node *np)
 	for (n = 0; n < ARRAY_SIZE(bg2q_gates); n++) {
 		const struct berlin2_gate_data *gd = &bg2q_gates[n];
 
-		clks[CLKID_GFX2DAXI + n] = clk_register_gate(NULL, gd->name,
+		hws[CLKID_GFX2DAXI + n] = clk_hw_register_gate(NULL, gd->name,
 			    gd->parent_name, gd->flags, gbase + REG_CLKENABLE,
 			    gd->bit_idx, 0, &lock);
 	}
 
 	/* cpuclk divider is fixed to 1 */
-	clks[CLKID_CPU] =
-		clk_register_fixed_factor(NULL, "cpu", clk_names[CPUPLL],
+	hws[CLKID_CPU] =
+		clk_hw_register_fixed_factor(NULL, "cpu", clk_names[CPUPLL],
 					  0, 1, 1);
 	/* twdclk is derived from cpu/3 */
-	clks[CLKID_TWD] =
-		clk_register_fixed_factor(NULL, "twd", "cpu", 0, 1, 3);
+	hws[CLKID_TWD] =
+		clk_hw_register_fixed_factor(NULL, "twd", "cpu", 0, 1, 3);
 
 	/* check for errors on leaf clocks */
 	for (n = 0; n < MAX_CLKS; n++) {
-		if (!IS_ERR(clks[n]))
+		if (!IS_ERR(hws[n]))
 			continue;
 
 		pr_err("%s: Unable to register leaf clock %d\n",
@@ -375,9 +382,7 @@ static void __init berlin2q_clock_setup(struct device_node *np)
 	}
 
 	/* register clk-provider */
-	clk_data.clks = clks;
-	clk_data.clk_num = MAX_CLKS;
-	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
+	of_clk_add_hw_provider(np, of_clk_hw_onecell_get, &clk_data);
 
 	return;
 
-- 
2.7.4
