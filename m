From: zhengxing@rock-chips.com (Xing Zheng)
Date: Wed, 20 Jan 2016 17:06:49 +0800
Subject: [PATCH v2] clk: rockchip: Add support for multiple clock providers
Message-ID: <1453280809-3120-1-git-send-email-zhengxing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are need to support Multi-CRUs probability in future, but
it is not supported on the current Rockchip Clock Framework.

Therefore, this patch add support a provider as the parameter
handler when we call the clock register functions for per CRU.

Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
---

Changes in v2:
- Fix missed to call rockchip_clk_common_cru_init when SoCs clock init.

 drivers/clk/rockchip/clk-rk3036.c |   15 +++--
 drivers/clk/rockchip/clk-rk3188.c |   40 ++++++++-----
 drivers/clk/rockchip/clk-rk3228.c |   15 +++--
 drivers/clk/rockchip/clk-rk3288.c |   17 ++++--
 drivers/clk/rockchip/clk-rk3368.c |   19 +++---
 drivers/clk/rockchip/clk.c        |  120 +++++++++++++++++++++++--------------
 drivers/clk/rockchip/clk.h        |   35 ++++++++---
 7 files changed, 170 insertions(+), 91 deletions(-)

diff --git a/drivers/clk/rockchip/clk-rk3036.c b/drivers/clk/rockchip/clk-rk3036.c
index 483913b..050ad13 100644
--- a/drivers/clk/rockchip/clk-rk3036.c
+++ b/drivers/clk/rockchip/clk-rk3036.c
@@ -434,6 +434,7 @@ static const char *const rk3036_critical_clocks[] __initconst = {
 
 static void __init rk3036_clk_init(struct device_node *np)
 {
+	struct rockchip_clk_provider *ctx;
 	void __iomem *reg_base;
 	struct clk *clk;
 
@@ -443,7 +444,9 @@ static void __init rk3036_clk_init(struct device_node *np)
 		return;
 	}
 
-	rockchip_clk_init(np, reg_base, CLK_NR_CLKS);
+	ctx = rockchip_clk_init(reg_base, CLK_NR_CLKS);
+
+	rockchip_clk_common_cru_init(np);
 
 	/* xin12m is created by an cru-internal divider */
 	clk = clk_register_fixed_factor(NULL, "xin12m", "xin24m", 0, 1, 2);
@@ -473,15 +476,15 @@ static void __init rk3036_clk_init(struct device_node *np)
 		pr_warn("%s: could not register clock sclk_macref_out: %ld\n",
 			__func__, PTR_ERR(clk));
 
-	rockchip_clk_register_plls(rk3036_pll_clks,
+	rockchip_clk_register_plls(ctx, rk3036_pll_clks,
 				   ARRAY_SIZE(rk3036_pll_clks),
 				   RK3036_GRF_SOC_STATUS0);
-	rockchip_clk_register_branches(rk3036_clk_branches,
+	rockchip_clk_register_branches(ctx, rk3036_clk_branches,
 				  ARRAY_SIZE(rk3036_clk_branches));
 	rockchip_clk_protect_critical(rk3036_critical_clocks,
 				      ARRAY_SIZE(rk3036_critical_clocks));
 
-	rockchip_clk_register_armclk(ARMCLK, "armclk",
+	rockchip_clk_register_armclk(ctx, ARMCLK, "armclk",
 			mux_armclk_p, ARRAY_SIZE(mux_armclk_p),
 			&rk3036_cpuclk_data, rk3036_cpuclk_rates,
 			ARRAY_SIZE(rk3036_cpuclk_rates));
@@ -489,6 +492,8 @@ static void __init rk3036_clk_init(struct device_node *np)
 	rockchip_register_softrst(np, 9, reg_base + RK2928_SOFTRST_CON(0),
 				  ROCKCHIP_SOFTRST_HIWORD_MASK);
 
-	rockchip_register_restart_notifier(RK2928_GLB_SRST_FST, NULL);
+	rockchip_register_restart_notifier(ctx, RK2928_GLB_SRST_FST, NULL);
+
+	rockchip_clk_of_add_provider(np, ctx);
 }
 CLK_OF_DECLARE(rk3036_cru, "rockchip,rk3036-cru", rk3036_clk_init);
diff --git a/drivers/clk/rockchip/clk-rk3188.c b/drivers/clk/rockchip/clk-rk3188.c
index 7f7444c..338a22e 100644
--- a/drivers/clk/rockchip/clk-rk3188.c
+++ b/drivers/clk/rockchip/clk-rk3188.c
@@ -750,18 +750,19 @@ static const char *const rk3188_critical_clocks[] __initconst = {
 	"pclk_peri",
 };
 
-static void __init rk3188_common_clk_init(struct device_node *np)
+static struct rockchip_clk_provider *__init rk3188_common_clk_init(struct device_node *np)
 {
+	struct rockchip_clk_provider *ctx;
 	void __iomem *reg_base;
 	struct clk *clk;
 
 	reg_base = of_iomap(np, 0);
-	if (!reg_base) {
-		pr_err("%s: could not map cru region\n", __func__);
-		return;
-	}
+	if (!reg_base)
+		panic("%s: could not map cru region\n", __func__);
+
+	ctx = rockchip_clk_init(reg_base, CLK_NR_CLKS);
 
-	rockchip_clk_init(np, reg_base, CLK_NR_CLKS);
+	rockchip_clk_common_cru_init(np);
 
 	/* xin12m is created by an cru-internal divider */
 	clk = clk_register_fixed_factor(NULL, "xin12m", "xin24m", 0, 1, 2);
@@ -774,45 +775,51 @@ static void __init rk3188_common_clk_init(struct device_node *np)
 		pr_warn("%s: could not register clock usb480m: %ld\n",
 			__func__, PTR_ERR(clk));
 
-	rockchip_clk_register_branches(common_clk_branches,
+	rockchip_clk_register_branches(ctx, common_clk_branches,
 				  ARRAY_SIZE(common_clk_branches));
 
 	rockchip_register_softrst(np, 9, reg_base + RK2928_SOFTRST_CON(0),
 				  ROCKCHIP_SOFTRST_HIWORD_MASK);
 
-	rockchip_register_restart_notifier(RK2928_GLB_SRST_FST, NULL);
+	rockchip_register_restart_notifier(ctx, RK2928_GLB_SRST_FST, NULL);
+
+	return ctx;
 }
 
 static void __init rk3066a_clk_init(struct device_node *np)
 {
-	rk3188_common_clk_init(np);
-	rockchip_clk_register_plls(rk3066_pll_clks,
+	struct rockchip_clk_provider *ctx;
+
+	ctx = rk3188_common_clk_init(np);
+	rockchip_clk_register_plls(ctx, rk3066_pll_clks,
 				   ARRAY_SIZE(rk3066_pll_clks),
 				   RK3066_GRF_SOC_STATUS);
-	rockchip_clk_register_branches(rk3066a_clk_branches,
+	rockchip_clk_register_branches(ctx, rk3066a_clk_branches,
 				  ARRAY_SIZE(rk3066a_clk_branches));
-	rockchip_clk_register_armclk(ARMCLK, "armclk",
+	rockchip_clk_register_armclk(ctx, ARMCLK, "armclk",
 			mux_armclk_p, ARRAY_SIZE(mux_armclk_p),
 			&rk3066_cpuclk_data, rk3066_cpuclk_rates,
 			ARRAY_SIZE(rk3066_cpuclk_rates));
 	rockchip_clk_protect_critical(rk3188_critical_clocks,
 				      ARRAY_SIZE(rk3188_critical_clocks));
+	rockchip_clk_of_add_provider(np, ctx);
 }
 CLK_OF_DECLARE(rk3066a_cru, "rockchip,rk3066a-cru", rk3066a_clk_init);
 
 static void __init rk3188a_clk_init(struct device_node *np)
 {
+	struct rockchip_clk_provider *ctx;
 	struct clk *clk1, *clk2;
 	unsigned long rate;
 	int ret;
 
-	rk3188_common_clk_init(np);
-	rockchip_clk_register_plls(rk3188_pll_clks,
+	ctx = rk3188_common_clk_init(np);
+	rockchip_clk_register_plls(ctx, rk3188_pll_clks,
 				   ARRAY_SIZE(rk3188_pll_clks),
 				   RK3188_GRF_SOC_STATUS);
-	rockchip_clk_register_branches(rk3188_clk_branches,
+	rockchip_clk_register_branches(ctx, rk3188_clk_branches,
 				  ARRAY_SIZE(rk3188_clk_branches));
-	rockchip_clk_register_armclk(ARMCLK, "armclk",
+	rockchip_clk_register_armclk(ctx, ARMCLK, "armclk",
 				  mux_armclk_p, ARRAY_SIZE(mux_armclk_p),
 				  &rk3188_cpuclk_data, rk3188_cpuclk_rates,
 				  ARRAY_SIZE(rk3188_cpuclk_rates));
@@ -836,6 +843,7 @@ static void __init rk3188a_clk_init(struct device_node *np)
 
 	rockchip_clk_protect_critical(rk3188_critical_clocks,
 				      ARRAY_SIZE(rk3188_critical_clocks));
+	rockchip_clk_of_add_provider(np, ctx);
 }
 CLK_OF_DECLARE(rk3188a_cru, "rockchip,rk3188a-cru", rk3188a_clk_init);
 
diff --git a/drivers/clk/rockchip/clk-rk3228.c b/drivers/clk/rockchip/clk-rk3228.c
index 981a502..2457c57 100644
--- a/drivers/clk/rockchip/clk-rk3228.c
+++ b/drivers/clk/rockchip/clk-rk3228.c
@@ -623,6 +623,7 @@ static const char *const rk3228_critical_clocks[] __initconst = {
 
 static void __init rk3228_clk_init(struct device_node *np)
 {
+	struct rockchip_clk_provider *ctx;
 	void __iomem *reg_base;
 	struct clk *clk;
 
@@ -632,7 +633,9 @@ static void __init rk3228_clk_init(struct device_node *np)
 		return;
 	}
 
-	rockchip_clk_init(np, reg_base, CLK_NR_CLKS);
+	ctx = rockchip_clk_init(reg_base, CLK_NR_CLKS);
+
+	rockchip_clk_common_cru_init(np);
 
 	/* xin12m is created by an cru-internal divider */
 	clk = clk_register_fixed_factor(NULL, "xin12m", "xin24m", 0, 1, 2);
@@ -657,15 +660,15 @@ static void __init rk3228_clk_init(struct device_node *np)
 		pr_warn("%s: could not register clock hclk_rkvdec_pre: %ld\n",
 			__func__, PTR_ERR(clk));
 
-	rockchip_clk_register_plls(rk3228_pll_clks,
+	rockchip_clk_register_plls(ctx, rk3228_pll_clks,
 				   ARRAY_SIZE(rk3228_pll_clks),
 				   RK3228_GRF_SOC_STATUS0);
-	rockchip_clk_register_branches(rk3228_clk_branches,
+	rockchip_clk_register_branches(ctx, rk3228_clk_branches,
 				  ARRAY_SIZE(rk3228_clk_branches));
 	rockchip_clk_protect_critical(rk3228_critical_clocks,
 				      ARRAY_SIZE(rk3228_critical_clocks));
 
-	rockchip_clk_register_armclk(ARMCLK, "armclk",
+	rockchip_clk_register_armclk(ctx, ARMCLK, "armclk",
 			mux_armclk_p, ARRAY_SIZE(mux_armclk_p),
 			&rk3228_cpuclk_data, rk3228_cpuclk_rates,
 			ARRAY_SIZE(rk3228_cpuclk_rates));
@@ -673,6 +676,8 @@ static void __init rk3228_clk_init(struct device_node *np)
 	rockchip_register_softrst(np, 9, reg_base + RK2928_SOFTRST_CON(0),
 				  ROCKCHIP_SOFTRST_HIWORD_MASK);
 
-	rockchip_register_restart_notifier(RK3228_GLB_SRST_FST, NULL);
+	rockchip_register_restart_notifier(ctx, RK3228_GLB_SRST_FST, NULL);
+
+	rockchip_clk_of_add_provider(np, ctx);
 }
 CLK_OF_DECLARE(rk3228_cru, "rockchip,rk3228-cru", rk3228_clk_init);
diff --git a/drivers/clk/rockchip/clk-rk3288.c b/drivers/clk/rockchip/clk-rk3288.c
index 984fc18..d2680e8 100644
--- a/drivers/clk/rockchip/clk-rk3288.c
+++ b/drivers/clk/rockchip/clk-rk3288.c
@@ -878,6 +878,7 @@ static struct syscore_ops rk3288_clk_syscore_ops = {
 
 static void __init rk3288_clk_init(struct device_node *np)
 {
+	struct rockchip_clk_provider *ctx;
 	struct clk *clk;
 
 	rk3288_cru_base = of_iomap(np, 0);
@@ -886,7 +887,9 @@ static void __init rk3288_clk_init(struct device_node *np)
 		return;
 	}
 
-	rockchip_clk_init(np, rk3288_cru_base, CLK_NR_CLKS);
+	ctx = rockchip_clk_init(rk3288_cru_base, CLK_NR_CLKS);
+
+	rockchip_clk_common_cru_init(np);
 
 	/* xin12m is created by an cru-internal divider */
 	clk = clk_register_fixed_factor(NULL, "xin12m", "xin24m", 0, 1, 2);
@@ -912,17 +915,17 @@ static void __init rk3288_clk_init(struct device_node *np)
 		pr_warn("%s: could not register clock pclk_wdt: %ld\n",
 			__func__, PTR_ERR(clk));
 	else
-		rockchip_clk_add_lookup(clk, PCLK_WDT);
+		rockchip_clk_add_lookup(ctx, clk, PCLK_WDT);
 
-	rockchip_clk_register_plls(rk3288_pll_clks,
+	rockchip_clk_register_plls(ctx, rk3288_pll_clks,
 				   ARRAY_SIZE(rk3288_pll_clks),
 				   RK3288_GRF_SOC_STATUS1);
-	rockchip_clk_register_branches(rk3288_clk_branches,
+	rockchip_clk_register_branches(ctx, rk3288_clk_branches,
 				  ARRAY_SIZE(rk3288_clk_branches));
 	rockchip_clk_protect_critical(rk3288_critical_clocks,
 				      ARRAY_SIZE(rk3288_critical_clocks));
 
-	rockchip_clk_register_armclk(ARMCLK, "armclk",
+	rockchip_clk_register_armclk(ctx, ARMCLK, "armclk",
 			mux_armclk_p, ARRAY_SIZE(mux_armclk_p),
 			&rk3288_cpuclk_data, rk3288_cpuclk_rates,
 			ARRAY_SIZE(rk3288_cpuclk_rates));
@@ -931,8 +934,10 @@ static void __init rk3288_clk_init(struct device_node *np)
 				  rk3288_cru_base + RK3288_SOFTRST_CON(0),
 				  ROCKCHIP_SOFTRST_HIWORD_MASK);
 
-	rockchip_register_restart_notifier(RK3288_GLB_SRST_FST,
+	rockchip_register_restart_notifier(ctx, RK3288_GLB_SRST_FST,
 					   rk3288_clk_shutdown);
 	register_syscore_ops(&rk3288_clk_syscore_ops);
+
+	rockchip_clk_of_add_provider(np, ctx);
 }
 CLK_OF_DECLARE(rk3288_cru, "rockchip,rk3288-cru", rk3288_clk_init);
diff --git a/drivers/clk/rockchip/clk-rk3368.c b/drivers/clk/rockchip/clk-rk3368.c
index be0ede5..08376bb 100644
--- a/drivers/clk/rockchip/clk-rk3368.c
+++ b/drivers/clk/rockchip/clk-rk3368.c
@@ -831,6 +831,7 @@ static const char *const rk3368_critical_clocks[] __initconst = {
 
 static void __init rk3368_clk_init(struct device_node *np)
 {
+	struct rockchip_clk_provider *ctx;
 	void __iomem *reg_base;
 	struct clk *clk;
 
@@ -840,7 +841,9 @@ static void __init rk3368_clk_init(struct device_node *np)
 		return;
 	}
 
-	rockchip_clk_init(np, reg_base, CLK_NR_CLKS);
+	ctx = rockchip_clk_init(reg_base, CLK_NR_CLKS);
+
+	rockchip_clk_common_cru_init(np);
 
 	/* xin12m is created by a cru-internal divider */
 	clk = clk_register_fixed_factor(NULL, "xin12m", "xin24m", 0, 1, 2);
@@ -866,22 +869,22 @@ static void __init rk3368_clk_init(struct device_node *np)
 		pr_warn("%s: could not register clock pclk_wdt: %ld\n",
 			__func__, PTR_ERR(clk));
 	else
-		rockchip_clk_add_lookup(clk, PCLK_WDT);
+		rockchip_clk_add_lookup(ctx, clk, PCLK_WDT);
 
-	rockchip_clk_register_plls(rk3368_pll_clks,
+	rockchip_clk_register_plls(ctx, rk3368_pll_clks,
 				   ARRAY_SIZE(rk3368_pll_clks),
 				   RK3368_GRF_SOC_STATUS0);
-	rockchip_clk_register_branches(rk3368_clk_branches,
+	rockchip_clk_register_branches(ctx, rk3368_clk_branches,
 				  ARRAY_SIZE(rk3368_clk_branches));
 	rockchip_clk_protect_critical(rk3368_critical_clocks,
 				      ARRAY_SIZE(rk3368_critical_clocks));
 
-	rockchip_clk_register_armclk(ARMCLKB, "armclkb",
+	rockchip_clk_register_armclk(ctx, ARMCLKB, "armclkb",
 			mux_armclkb_p, ARRAY_SIZE(mux_armclkb_p),
 			&rk3368_cpuclkb_data, rk3368_cpuclkb_rates,
 			ARRAY_SIZE(rk3368_cpuclkb_rates));
 
-	rockchip_clk_register_armclk(ARMCLKL, "armclkl",
+	rockchip_clk_register_armclk(ctx, ARMCLKL, "armclkl",
 			mux_armclkl_p, ARRAY_SIZE(mux_armclkl_p),
 			&rk3368_cpuclkl_data, rk3368_cpuclkl_rates,
 			ARRAY_SIZE(rk3368_cpuclkl_rates));
@@ -889,6 +892,8 @@ static void __init rk3368_clk_init(struct device_node *np)
 	rockchip_register_softrst(np, 15, reg_base + RK3368_SOFTRST_CON(0),
 				  ROCKCHIP_SOFTRST_HIWORD_MASK);
 
-	rockchip_register_restart_notifier(RK3368_GLB_SRST_FST, NULL);
+	rockchip_register_restart_notifier(ctx, RK3368_GLB_SRST_FST, NULL);
+
+	rockchip_clk_of_add_provider(np, ctx);
 }
 CLK_OF_DECLARE(rk3368_cru, "rockchip,rk3368-cru", rk3368_clk_init);
diff --git a/drivers/clk/rockchip/clk.c b/drivers/clk/rockchip/clk.c
index d9a0b5d..fba4667 100644
--- a/drivers/clk/rockchip/clk.c
+++ b/drivers/clk/rockchip/clk.c
@@ -150,7 +150,8 @@ static int rockchip_clk_frac_notifier_cb(struct notifier_block *nb,
 	return notifier_from_errno(ret);
 }
 
-static struct clk *rockchip_clk_register_frac_branch(const char *name,
+static struct clk *rockchip_clk_register_frac_branch(
+		struct rockchip_clk_provider *ctx, const char *name,
 		const char *const *parent_names, u8 num_parents,
 		void __iomem *base, int muxdiv_offset, u8 div_flags,
 		int gate_offset, u8 gate_shift, u8 gate_flags,
@@ -243,7 +244,7 @@ static struct clk *rockchip_clk_register_frac_branch(const char *name,
 		if (IS_ERR(mux_clk))
 			return clk;
 
-		rockchip_clk_add_lookup(mux_clk, child->id);
+		rockchip_clk_add_lookup(ctx, mux_clk, child->id);
 
 		/* notifier on the fraction divider to catch rate changes */
 		if (frac->mux_frac_idx >= 0) {
@@ -260,27 +261,49 @@ static struct clk *rockchip_clk_register_frac_branch(const char *name,
 	return clk;
 }
 
-static DEFINE_SPINLOCK(clk_lock);
-static struct clk **clk_table;
-static void __iomem *reg_base;
-static struct clk_onecell_data clk_data;
 static struct device_node *cru_node;
 static struct regmap *grf;
 
-void __init rockchip_clk_init(struct device_node *np, void __iomem *base,
-			      unsigned long nr_clks)
+struct rockchip_clk_provider *__init rockchip_clk_init(
+			void __iomem *base, unsigned long nr_clks)
 {
-	reg_base = base;
-	cru_node = np;
-	grf = ERR_PTR(-EPROBE_DEFER);
+	struct rockchip_clk_provider *ctx;
+	struct clk **clk_table;
+	int i;
+
+	ctx = kzalloc(sizeof(struct rockchip_clk_provider), GFP_KERNEL);
+	if (!ctx)
+		panic("could not allocate clock provider context.\n");
 
 	clk_table = kcalloc(nr_clks, sizeof(struct clk *), GFP_KERNEL);
 	if (!clk_table)
-		pr_err("%s: could not allocate clock lookup table\n", __func__);
+		panic("could not allocate clock lookup table\n");
+
+	for (i = 0; i < nr_clks; ++i)
+		clk_table[i] = ERR_PTR(-ENOENT);
+
+	ctx->reg_base = base;
+	ctx->clk_data.clks = clk_table;
+	ctx->clk_data.clk_num = nr_clks;
+	spin_lock_init(&ctx->lock);
+
+	return ctx;
+}
 
-	clk_data.clks = clk_table;
-	clk_data.clk_num = nr_clks;
-	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
+void __init rockchip_clk_common_cru_init(struct device_node *np)
+{
+	cru_node = np;
+	grf = ERR_PTR(-EPROBE_DEFER);
+}
+
+void __init rockchip_clk_of_add_provider(struct device_node *np,
+				struct rockchip_clk_provider *ctx)
+{
+	if (np) {
+		if (of_clk_add_provider(np, of_clk_src_onecell_get,
+					&ctx->clk_data))
+			panic("could not register clk provider\n");
+	}
 }
 
 struct regmap *rockchip_clk_get_grf(void)
@@ -290,13 +313,15 @@ struct regmap *rockchip_clk_get_grf(void)
 	return grf;
 }
 
-void rockchip_clk_add_lookup(struct clk *clk, unsigned int id)
+void rockchip_clk_add_lookup(struct rockchip_clk_provider *ctx,
+			     struct clk *clk, unsigned int id)
 {
-	if (clk_table && id)
-		clk_table[id] = clk;
+	if (ctx->clk_data.clks && id)
+		ctx->clk_data.clks[id] = clk;
 }
 
-void __init rockchip_clk_register_plls(struct rockchip_pll_clock *list,
+void __init rockchip_clk_register_plls(struct rockchip_clk_provider *ctx,
+				struct rockchip_pll_clock *list,
 				unsigned int nr_pll, int grf_lock_offset)
 {
 	struct clk *clk;
@@ -305,21 +330,22 @@ void __init rockchip_clk_register_plls(struct rockchip_pll_clock *list,
 	for (idx = 0; idx < nr_pll; idx++, list++) {
 		clk = rockchip_clk_register_pll(list->type, list->name,
 				list->parent_names, list->num_parents,
-				reg_base, list->con_offset, grf_lock_offset,
+				ctx->reg_base, list->con_offset, grf_lock_offset,
 				list->lock_shift, list->mode_offset,
 				list->mode_shift, list->rate_table,
-				list->pll_flags, &clk_lock);
+				list->pll_flags, &ctx->lock);
 		if (IS_ERR(clk)) {
 			pr_err("%s: failed to register clock %s\n", __func__,
 				list->name);
 			continue;
 		}
 
-		rockchip_clk_add_lookup(clk, list->id);
+		rockchip_clk_add_lookup(ctx, clk, list->id);
 	}
 }
 
 void __init rockchip_clk_register_branches(
+				      struct rockchip_clk_provider *ctx,
 				      struct rockchip_clk_branch *list,
 				      unsigned int nr_clk)
 {
@@ -335,56 +361,56 @@ void __init rockchip_clk_register_branches(
 		case branch_mux:
 			clk = clk_register_mux(NULL, list->name,
 				list->parent_names, list->num_parents,
-				flags, reg_base + list->muxdiv_offset,
+				flags, ctx->reg_base + list->muxdiv_offset,
 				list->mux_shift, list->mux_width,
-				list->mux_flags, &clk_lock);
+				list->mux_flags, &ctx->lock);
 			break;
 		case branch_divider:
 			if (list->div_table)
 				clk = clk_register_divider_table(NULL,
 					list->name, list->parent_names[0],
-					flags, reg_base + list->muxdiv_offset,
+					flags, ctx->reg_base + list->muxdiv_offset,
 					list->div_shift, list->div_width,
 					list->div_flags, list->div_table,
-					&clk_lock);
+					&ctx->lock);
 			else
 				clk = clk_register_divider(NULL, list->name,
 					list->parent_names[0], flags,
-					reg_base + list->muxdiv_offset,
+					ctx->reg_base + list->muxdiv_offset,
 					list->div_shift, list->div_width,
-					list->div_flags, &clk_lock);
+					list->div_flags, &ctx->lock);
 			break;
 		case branch_fraction_divider:
-			clk = rockchip_clk_register_frac_branch(list->name,
+			clk = rockchip_clk_register_frac_branch(ctx, list->name,
 				list->parent_names, list->num_parents,
-				reg_base, list->muxdiv_offset, list->div_flags,
+				ctx->reg_base, list->muxdiv_offset, list->div_flags,
 				list->gate_offset, list->gate_shift,
 				list->gate_flags, flags, list->child,
-				&clk_lock);
+				&ctx->lock);
 			break;
 		case branch_gate:
 			flags |= CLK_SET_RATE_PARENT;
 
 			clk = clk_register_gate(NULL, list->name,
 				list->parent_names[0], flags,
-				reg_base + list->gate_offset,
-				list->gate_shift, list->gate_flags, &clk_lock);
+				ctx->reg_base + list->gate_offset,
+				list->gate_shift, list->gate_flags, &ctx->lock);
 			break;
 		case branch_composite:
 			clk = rockchip_clk_register_branch(list->name,
 				list->parent_names, list->num_parents,
-				reg_base, list->muxdiv_offset, list->mux_shift,
+				ctx->reg_base, list->muxdiv_offset, list->mux_shift,
 				list->mux_width, list->mux_flags,
 				list->div_shift, list->div_width,
 				list->div_flags, list->div_table,
 				list->gate_offset, list->gate_shift,
-				list->gate_flags, flags, &clk_lock);
+				list->gate_flags, flags, &ctx->lock);
 			break;
 		case branch_mmc:
 			clk = rockchip_clk_register_mmc(
 				list->name,
 				list->parent_names, list->num_parents,
-				reg_base + list->muxdiv_offset,
+				ctx->reg_base + list->muxdiv_offset,
 				list->div_shift
 			);
 			break;
@@ -392,8 +418,8 @@ void __init rockchip_clk_register_branches(
 			clk = rockchip_clk_register_inverter(
 				list->name, list->parent_names,
 				list->num_parents,
-				reg_base + list->muxdiv_offset,
-				list->div_shift, list->div_flags, &clk_lock);
+				ctx->reg_base + list->muxdiv_offset,
+				list->div_shift, list->div_flags, &ctx->lock);
 			break;
 		}
 
@@ -410,11 +436,12 @@ void __init rockchip_clk_register_branches(
 			continue;
 		}
 
-		rockchip_clk_add_lookup(clk, list->id);
+		rockchip_clk_add_lookup(ctx, clk, list->id);
 	}
 }
 
-void __init rockchip_clk_register_armclk(unsigned int lookup_id,
+void __init rockchip_clk_register_armclk(struct rockchip_clk_provider *ctx,
+			unsigned int lookup_id,
 			const char *name, const char *const *parent_names,
 			u8 num_parents,
 			const struct rockchip_cpuclk_reg_data *reg_data,
@@ -424,15 +451,15 @@ void __init rockchip_clk_register_armclk(unsigned int lookup_id,
 	struct clk *clk;
 
 	clk = rockchip_clk_register_cpuclk(name, parent_names, num_parents,
-					   reg_data, rates, nrates, reg_base,
-					   &clk_lock);
+					   reg_data, rates, nrates, ctx->reg_base,
+					   &ctx->lock);
 	if (IS_ERR(clk)) {
 		pr_err("%s: failed to register clock %s: %ld\n",
 		       __func__, name, PTR_ERR(clk));
 		return;
 	}
 
-	rockchip_clk_add_lookup(clk, lookup_id);
+	rockchip_clk_add_lookup(ctx, clk, lookup_id);
 }
 
 void __init rockchip_clk_protect_critical(const char *const clocks[],
@@ -449,6 +476,7 @@ void __init rockchip_clk_protect_critical(const char *const clocks[],
 	}
 }
 
+static void __iomem *rst_base;
 static unsigned int reg_restart;
 static void (*cb_restart)(void);
 static int rockchip_restart_notify(struct notifier_block *this,
@@ -457,7 +485,7 @@ static int rockchip_restart_notify(struct notifier_block *this,
 	if (cb_restart)
 		cb_restart();
 
-	writel(0xfdb9, reg_base + reg_restart);
+	writel(0xfdb9, rst_base + reg_restart);
 	return NOTIFY_DONE;
 }
 
@@ -466,10 +494,12 @@ static struct notifier_block rockchip_restart_handler = {
 	.priority = 128,
 };
 
-void __init rockchip_register_restart_notifier(unsigned int reg, void (*cb)(void))
+void __init rockchip_register_restart_notifier(struct rockchip_clk_provider *ctx,
+					       unsigned int reg, void (*cb)(void))
 {
 	int ret;
 
+	rst_base = ctx->reg_base;
 	reg_restart = reg;
 	cb_restart = cb;
 	ret = register_restart_handler(&rockchip_restart_handler);
diff --git a/drivers/clk/rockchip/clk.h b/drivers/clk/rockchip/clk.h
index ff8bd23..f6552b6 100644
--- a/drivers/clk/rockchip/clk.h
+++ b/drivers/clk/rockchip/clk.h
@@ -27,6 +27,7 @@
 #define CLK_ROCKCHIP_CLK_H
 
 #include <linux/io.h>
+#include <linux/clk-provider.h>
 
 struct clk;
 
@@ -127,6 +128,18 @@ enum rockchip_pll_type {
 	.nb = _nb,						\
 }
 
+/**
+ * struct rockchip_clk_provider: information about clock provider
+ * @reg_base: virtual address for the register base.
+ * @clk_data: holds clock related data like clk* and number of clocks.
+ * @lock: maintains exclusion between callbacks for a given clock-provider.
+ */
+struct rockchip_clk_provider {
+	void __iomem *reg_base;
+	struct clk_onecell_data clk_data;
+	spinlock_t lock;
+};
+
 struct rockchip_pll_rate_table {
 	unsigned long rate;
 	unsigned int nr;
@@ -508,21 +521,29 @@ struct rockchip_clk_branch {
 		.div_flags	= if,				\
 	}
 
-void rockchip_clk_init(struct device_node *np, void __iomem *base,
-		       unsigned long nr_clks);
+struct rockchip_clk_provider *rockchip_clk_init(
+			void __iomem *base, unsigned long nr_clks);
+void rockchip_clk_common_cru_init(struct device_node *np);
+void rockchip_clk_of_add_provider(struct device_node *np,
+				struct rockchip_clk_provider *ctx);
 struct regmap *rockchip_clk_get_grf(void);
-void rockchip_clk_add_lookup(struct clk *clk, unsigned int id);
-void rockchip_clk_register_branches(struct rockchip_clk_branch *clk_list,
+void rockchip_clk_add_lookup(struct rockchip_clk_provider *ctx,
+			     struct clk *clk, unsigned int id);
+void rockchip_clk_register_branches(struct rockchip_clk_provider *ctx,
+				    struct rockchip_clk_branch *list,
 				    unsigned int nr_clk);
-void rockchip_clk_register_plls(struct rockchip_pll_clock *pll_list,
+void rockchip_clk_register_plls(struct rockchip_clk_provider *ctx,
+				struct rockchip_pll_clock *pll_list,
 				unsigned int nr_pll, int grf_lock_offset);
-void rockchip_clk_register_armclk(unsigned int lookup_id, const char *name,
+void rockchip_clk_register_armclk(struct rockchip_clk_provider *ctx,
+			unsigned int lookup_id, const char *name,
 			const char *const *parent_names, u8 num_parents,
 			const struct rockchip_cpuclk_reg_data *reg_data,
 			const struct rockchip_cpuclk_rate_table *rates,
 			int nrates);
 void rockchip_clk_protect_critical(const char *const clocks[], int nclocks);
-void rockchip_register_restart_notifier(unsigned int reg, void (*cb)(void));
+void rockchip_register_restart_notifier(struct rockchip_clk_provider *ctx,
+					unsigned int reg, void (*cb)(void));
 
 #define ROCKCHIP_SOFTRST_HIWORD_MASK	BIT(0)
 
-- 
1.7.9.5
