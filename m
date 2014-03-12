From: rahul.sharma@samsung.com (Rahul Sharma)
Date: Wed, 12 Mar 2014 20:26:44 +0530
Subject: [PATCH v5 1/5] clk/samsung: add support for multiple clock providers
In-Reply-To: <1394636208-3125-1-git-send-email-rahul.sharma@samsung.com>
References: <1394636208-3125-1-git-send-email-rahul.sharma@samsung.com>
Message-ID: <1394636208-3125-2-git-send-email-rahul.sharma@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Samsung CCF helper functions do not provide support to
register multiple Clock Providers for a given SoC. Due to
this limitation, SoC platforms are not able to use these
helpers for registering multiple clock providers and are
forced to bypass this layer.

This layer is modified accordingly to enable the support
for multiple clock providers.

Clock file for exynos4, exynos5250, exynos5420, exynos5440,
S3c64xx, S3c2412 and S3c2443 are also modified as per changed
helper functions.

Signed-off-by: Rahul Sharma <rahul.sharma@samsung.com>
---
 drivers/clk/samsung/clk-exynos4.c    |   47 +++++++-------
 drivers/clk/samsung/clk-exynos5250.c |   25 +++++---
 drivers/clk/samsung/clk-exynos5420.c |   24 ++++---
 drivers/clk/samsung/clk-exynos5440.c |   18 +++---
 drivers/clk/samsung/clk-pll.c        |   14 +++--
 drivers/clk/samsung/clk-s3c2412.c    |   29 +++++----
 drivers/clk/samsung/clk-s3c2443.c    |   46 +++++++-------
 drivers/clk/samsung/clk-s3c64xx.c    |   44 +++++++------
 drivers/clk/samsung/clk.c            |  114 ++++++++++++++++++----------------
 drivers/clk/samsung/clk.h            |   72 ++++++++++++++-------
 10 files changed, 251 insertions(+), 182 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos4.c b/drivers/clk/samsung/clk-exynos4.c
index b4f9672..57ed5a8 100644
--- a/drivers/clk/samsung/clk-exynos4.c
+++ b/drivers/clk/samsung/clk-exynos4.c
@@ -1043,7 +1043,7 @@ static unsigned long exynos4_get_xom(void)
 	return xom;
 }
 
-static void __init exynos4_clk_register_finpll(void)
+static void __init exynos4_clk_register_finpll(struct samsung_clk_provider *ctx)
 {
 	struct samsung_fixed_rate_clock fclk;
 	struct clk *clk;
@@ -1066,7 +1066,7 @@ static void __init exynos4_clk_register_finpll(void)
 	fclk.parent_name = NULL;
 	fclk.flags = CLK_IS_ROOT;
 	fclk.fixed_rate = finpll_f;
-	samsung_clk_register_fixed_rate(&fclk, 1);
+	samsung_clk_register_fixed_rate(ctx, &fclk, 1);
 
 }
 
@@ -1176,22 +1176,25 @@ static struct samsung_pll_clock exynos4x12_plls[nr_plls] __initdata = {
 static void __init exynos4_clk_init(struct device_node *np,
 				    enum exynos4_soc soc)
 {
+	struct samsung_clk_provider *ctx;
 	exynos4_soc = soc;
 
 	reg_base = of_iomap(np, 0);
 	if (!reg_base)
 		panic("%s: failed to map registers\n", __func__);
 
-	samsung_clk_init(np, reg_base, CLK_NR_CLKS);
+	ctx = samsung_clk_init(np, reg_base, CLK_NR_CLKS);
+	if (!ctx)
+		panic("%s: unable to allocate context.\n", __func__);
 
-	samsung_clk_of_register_fixed_ext(exynos4_fixed_rate_ext_clks,
+	samsung_clk_of_register_fixed_ext(ctx, exynos4_fixed_rate_ext_clks,
 			ARRAY_SIZE(exynos4_fixed_rate_ext_clks),
 			ext_clk_match);
 
-	exynos4_clk_register_finpll();
+	exynos4_clk_register_finpll(ctx);
 
 	if (exynos4_soc == EXYNOS4210) {
-		samsung_clk_register_mux(exynos4210_mux_early,
+		samsung_clk_register_mux(ctx, exynos4210_mux_early,
 					ARRAY_SIZE(exynos4210_mux_early));
 
 		if (_get_rate("fin_pll") == 24000000) {
@@ -1205,7 +1208,7 @@ static void __init exynos4_clk_init(struct device_node *np,
 			exynos4210_plls[vpll].rate_table =
 							exynos4210_vpll_rates;
 
-		samsung_clk_register_pll(exynos4210_plls,
+		samsung_clk_register_pll(ctx, exynos4210_plls,
 					ARRAY_SIZE(exynos4210_plls), reg_base);
 	} else {
 		if (_get_rate("fin_pll") == 24000000) {
@@ -1217,42 +1220,42 @@ static void __init exynos4_clk_init(struct device_node *np,
 							exynos4x12_vpll_rates;
 		}
 
-		samsung_clk_register_pll(exynos4x12_plls,
+		samsung_clk_register_pll(ctx, exynos4x12_plls,
 					ARRAY_SIZE(exynos4x12_plls), reg_base);
 	}
 
-	samsung_clk_register_fixed_rate(exynos4_fixed_rate_clks,
+	samsung_clk_register_fixed_rate(ctx, exynos4_fixed_rate_clks,
 			ARRAY_SIZE(exynos4_fixed_rate_clks));
-	samsung_clk_register_mux(exynos4_mux_clks,
+	samsung_clk_register_mux(ctx, exynos4_mux_clks,
 			ARRAY_SIZE(exynos4_mux_clks));
-	samsung_clk_register_div(exynos4_div_clks,
+	samsung_clk_register_div(ctx, exynos4_div_clks,
 			ARRAY_SIZE(exynos4_div_clks));
-	samsung_clk_register_gate(exynos4_gate_clks,
+	samsung_clk_register_gate(ctx, exynos4_gate_clks,
 			ARRAY_SIZE(exynos4_gate_clks));
 
 	if (exynos4_soc == EXYNOS4210) {
-		samsung_clk_register_fixed_rate(exynos4210_fixed_rate_clks,
+		samsung_clk_register_fixed_rate(ctx, exynos4210_fixed_rate_clks,
 			ARRAY_SIZE(exynos4210_fixed_rate_clks));
-		samsung_clk_register_mux(exynos4210_mux_clks,
+		samsung_clk_register_mux(ctx, exynos4210_mux_clks,
 			ARRAY_SIZE(exynos4210_mux_clks));
-		samsung_clk_register_div(exynos4210_div_clks,
+		samsung_clk_register_div(ctx, exynos4210_div_clks,
 			ARRAY_SIZE(exynos4210_div_clks));
-		samsung_clk_register_gate(exynos4210_gate_clks,
+		samsung_clk_register_gate(ctx, exynos4210_gate_clks,
 			ARRAY_SIZE(exynos4210_gate_clks));
-		samsung_clk_register_alias(exynos4210_aliases,
+		samsung_clk_register_alias(ctx, exynos4210_aliases,
 			ARRAY_SIZE(exynos4210_aliases));
 	} else {
-		samsung_clk_register_mux(exynos4x12_mux_clks,
+		samsung_clk_register_mux(ctx, exynos4x12_mux_clks,
 			ARRAY_SIZE(exynos4x12_mux_clks));
-		samsung_clk_register_div(exynos4x12_div_clks,
+		samsung_clk_register_div(ctx, exynos4x12_div_clks,
 			ARRAY_SIZE(exynos4x12_div_clks));
-		samsung_clk_register_gate(exynos4x12_gate_clks,
+		samsung_clk_register_gate(ctx, exynos4x12_gate_clks,
 			ARRAY_SIZE(exynos4x12_gate_clks));
-		samsung_clk_register_alias(exynos4x12_aliases,
+		samsung_clk_register_alias(ctx, exynos4x12_aliases,
 			ARRAY_SIZE(exynos4x12_aliases));
 	}
 
-	samsung_clk_register_alias(exynos4_aliases,
+	samsung_clk_register_alias(ctx, exynos4_aliases,
 			ARRAY_SIZE(exynos4_aliases));
 
 	exynos4_clk_sleep_init();
diff --git a/drivers/clk/samsung/clk-exynos5250.c b/drivers/clk/samsung/clk-exynos5250.c
index d1d16cf..d1d53ca 100644
--- a/drivers/clk/samsung/clk-exynos5250.c
+++ b/drivers/clk/samsung/clk-exynos5250.c
@@ -687,6 +687,8 @@ static struct of_device_id ext_clk_match[] __initdata = {
 /* register exynox5250 clocks */
 static void __init exynos5250_clk_init(struct device_node *np)
 {
+	struct samsung_clk_provider *ctx;
+
 	if (np) {
 		reg_base = of_iomap(np, 0);
 		if (!reg_base)
@@ -695,11 +697,13 @@ static void __init exynos5250_clk_init(struct device_node *np)
 		panic("%s: unable to determine soc\n", __func__);
 	}
 
-	samsung_clk_init(np, reg_base, CLK_NR_CLKS);
-	samsung_clk_of_register_fixed_ext(exynos5250_fixed_rate_ext_clks,
+	ctx = samsung_clk_init(np, reg_base, CLK_NR_CLKS);
+	if (!ctx)
+		panic("%s: unable to allocate context.\n", __func__);
+	samsung_clk_of_register_fixed_ext(ctx, exynos5250_fixed_rate_ext_clks,
 			ARRAY_SIZE(exynos5250_fixed_rate_ext_clks),
 			ext_clk_match);
-	samsung_clk_register_mux(exynos5250_pll_pmux_clks,
+	samsung_clk_register_mux(ctx, exynos5250_pll_pmux_clks,
 				ARRAY_SIZE(exynos5250_pll_pmux_clks));
 
 	if (_get_rate("fin_pll") == 24 * MHZ) {
@@ -710,17 +714,18 @@ static void __init exynos5250_clk_init(struct device_node *np)
 	if (_get_rate("mout_vpllsrc") == 24 * MHZ)
 		exynos5250_plls[vpll].rate_table =  vpll_24mhz_tbl;
 
-	samsung_clk_register_pll(exynos5250_plls, ARRAY_SIZE(exynos5250_plls),
-					reg_base);
-	samsung_clk_register_fixed_rate(exynos5250_fixed_rate_clks,
+	samsung_clk_register_pll(ctx, exynos5250_plls,
+			ARRAY_SIZE(exynos5250_plls),
+			reg_base);
+	samsung_clk_register_fixed_rate(ctx, exynos5250_fixed_rate_clks,
 			ARRAY_SIZE(exynos5250_fixed_rate_clks));
-	samsung_clk_register_fixed_factor(exynos5250_fixed_factor_clks,
+	samsung_clk_register_fixed_factor(ctx, exynos5250_fixed_factor_clks,
 			ARRAY_SIZE(exynos5250_fixed_factor_clks));
-	samsung_clk_register_mux(exynos5250_mux_clks,
+	samsung_clk_register_mux(ctx, exynos5250_mux_clks,
 			ARRAY_SIZE(exynos5250_mux_clks));
-	samsung_clk_register_div(exynos5250_div_clks,
+	samsung_clk_register_div(ctx, exynos5250_div_clks,
 			ARRAY_SIZE(exynos5250_div_clks));
-	samsung_clk_register_gate(exynos5250_gate_clks,
+	samsung_clk_register_gate(ctx, exynos5250_gate_clks,
 			ARRAY_SIZE(exynos5250_gate_clks));
 
 	exynos5250_clk_sleep_init();
diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index 35311e1..9f0f426 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -782,6 +782,8 @@ static struct of_device_id ext_clk_match[] __initdata = {
 /* register exynos5420 clocks */
 static void __init exynos5420_clk_init(struct device_node *np)
 {
+	struct samsung_clk_provider *ctx;
+
 	if (np) {
 		reg_base = of_iomap(np, 0);
 		if (!reg_base)
@@ -790,21 +792,25 @@ static void __init exynos5420_clk_init(struct device_node *np)
 		panic("%s: unable to determine soc\n", __func__);
 	}
 
-	samsung_clk_init(np, reg_base, CLK_NR_CLKS);
-	samsung_clk_of_register_fixed_ext(exynos5420_fixed_rate_ext_clks,
+	ctx = samsung_clk_init(np, reg_base, CLK_NR_CLKS);
+	if (!ctx)
+		panic("%s: unable to allocate context.\n", __func__);
+
+	samsung_clk_of_register_fixed_ext(ctx, exynos5420_fixed_rate_ext_clks,
 			ARRAY_SIZE(exynos5420_fixed_rate_ext_clks),
 			ext_clk_match);
-	samsung_clk_register_pll(exynos5420_plls, ARRAY_SIZE(exynos5420_plls),
-					reg_base);
-	samsung_clk_register_fixed_rate(exynos5420_fixed_rate_clks,
+	samsung_clk_register_pll(ctx, exynos5420_plls,
+			ARRAY_SIZE(exynos5420_plls),
+			reg_base);
+	samsung_clk_register_fixed_rate(ctx, exynos5420_fixed_rate_clks,
 			ARRAY_SIZE(exynos5420_fixed_rate_clks));
-	samsung_clk_register_fixed_factor(exynos5420_fixed_factor_clks,
+	samsung_clk_register_fixed_factor(ctx, exynos5420_fixed_factor_clks,
 			ARRAY_SIZE(exynos5420_fixed_factor_clks));
-	samsung_clk_register_mux(exynos5420_mux_clks,
+	samsung_clk_register_mux(ctx, exynos5420_mux_clks,
 			ARRAY_SIZE(exynos5420_mux_clks));
-	samsung_clk_register_div(exynos5420_div_clks,
+	samsung_clk_register_div(ctx, exynos5420_div_clks,
 			ARRAY_SIZE(exynos5420_div_clks));
-	samsung_clk_register_gate(exynos5420_gate_clks,
+	samsung_clk_register_gate(ctx, exynos5420_gate_clks,
 			ARRAY_SIZE(exynos5420_gate_clks));
 
 	exynos5420_clk_sleep_init();
diff --git a/drivers/clk/samsung/clk-exynos5440.c b/drivers/clk/samsung/clk-exynos5440.c
index 2bfad5a..647f144 100644
--- a/drivers/clk/samsung/clk-exynos5440.c
+++ b/drivers/clk/samsung/clk-exynos5440.c
@@ -93,6 +93,7 @@ static struct of_device_id ext_clk_match[] __initdata = {
 static void __init exynos5440_clk_init(struct device_node *np)
 {
 	void __iomem *reg_base;
+	struct samsung_clk_provider *ctx;
 
 	reg_base = of_iomap(np, 0);
 	if (!reg_base) {
@@ -101,22 +102,25 @@ static void __init exynos5440_clk_init(struct device_node *np)
 		return;
 	}
 
-	samsung_clk_init(np, reg_base, CLK_NR_CLKS);
-	samsung_clk_of_register_fixed_ext(exynos5440_fixed_rate_ext_clks,
+	ctx = samsung_clk_init(np, reg_base, CLK_NR_CLKS);
+	if (!ctx)
+		panic("%s: unable to allocate context.\n", __func__);
+
+	samsung_clk_of_register_fixed_ext(ctx, exynos5440_fixed_rate_ext_clks,
 		ARRAY_SIZE(exynos5440_fixed_rate_ext_clks), ext_clk_match);
 
 	samsung_clk_register_pll2550x("cplla", "xtal", reg_base + 0x1c, 0x10);
 	samsung_clk_register_pll2550x("cpllb", "xtal", reg_base + 0x20, 0x10);
 
-	samsung_clk_register_fixed_rate(exynos5440_fixed_rate_clks,
+	samsung_clk_register_fixed_rate(ctx, exynos5440_fixed_rate_clks,
 			ARRAY_SIZE(exynos5440_fixed_rate_clks));
-	samsung_clk_register_fixed_factor(exynos5440_fixed_factor_clks,
+	samsung_clk_register_fixed_factor(ctx, exynos5440_fixed_factor_clks,
 			ARRAY_SIZE(exynos5440_fixed_factor_clks));
-	samsung_clk_register_mux(exynos5440_mux_clks,
+	samsung_clk_register_mux(ctx, exynos5440_mux_clks,
 			ARRAY_SIZE(exynos5440_mux_clks));
-	samsung_clk_register_div(exynos5440_div_clks,
+	samsung_clk_register_div(ctx, exynos5440_div_clks,
 			ARRAY_SIZE(exynos5440_div_clks));
-	samsung_clk_register_gate(exynos5440_gate_clks,
+	samsung_clk_register_gate(ctx, exynos5440_gate_clks,
 			ARRAY_SIZE(exynos5440_gate_clks));
 
 	pr_info("Exynos5440: arm_clk = %ldHz\n", _get_rate("arm_clk"));
diff --git a/drivers/clk/samsung/clk-pll.c b/drivers/clk/samsung/clk-pll.c
index 7fb0a28..1f310be 100644
--- a/drivers/clk/samsung/clk-pll.c
+++ b/drivers/clk/samsung/clk-pll.c
@@ -947,8 +947,9 @@ struct clk * __init samsung_clk_register_pll2550x(const char *name,
 	return clk;
 }
 
-static void __init _samsung_clk_register_pll(struct samsung_pll_clock *pll_clk,
-						void __iomem *base)
+static void __init _samsung_clk_register_pll(struct samsung_clk_provider *ctx,
+				struct samsung_pll_clock *pll_clk,
+				void __iomem *base)
 {
 	struct samsung_clk_pll *pll;
 	struct clk *clk;
@@ -1066,7 +1067,7 @@ static void __init _samsung_clk_register_pll(struct samsung_pll_clock *pll_clk,
 		return;
 	}
 
-	samsung_clk_add_lookup(clk, pll_clk->id);
+	samsung_clk_add_lookup(ctx, clk, pll_clk->id);
 
 	if (!pll_clk->alias)
 		return;
@@ -1077,11 +1078,12 @@ static void __init _samsung_clk_register_pll(struct samsung_pll_clock *pll_clk,
 			__func__, pll_clk->name, ret);
 }
 
-void __init samsung_clk_register_pll(struct samsung_pll_clock *pll_list,
-				unsigned int nr_pll, void __iomem *base)
+void __init samsung_clk_register_pll(struct samsung_clk_provider *ctx,
+			struct samsung_pll_clock *pll_list,
+			unsigned int nr_pll, void __iomem *base)
 {
 	int cnt;
 
 	for (cnt = 0; cnt < nr_pll; cnt++)
-		_samsung_clk_register_pll(&pll_list[cnt], base);
+		_samsung_clk_register_pll(ctx, &pll_list[cnt], base);
 }
diff --git a/drivers/clk/samsung/clk-s3c2412.c b/drivers/clk/samsung/clk-s3c2412.c
index 0f11a07..23e4313 100644
--- a/drivers/clk/samsung/clk-s3c2412.c
+++ b/drivers/clk/samsung/clk-s3c2412.c
@@ -214,23 +214,25 @@ struct samsung_fixed_rate_clock s3c2412_common_frate_clks[] __initdata = {
 	FRATE(0, "ext", NULL, CLK_IS_ROOT, 0),
 };
 
-static void __init s3c2412_common_clk_register_fixed_ext(unsigned long xti_f,
-							 unsigned long ext_f)
+static void __init s3c2412_common_clk_register_fixed_ext(
+		struct samsung_clk_provider *ctx,
+		unsigned long xti_f, unsigned long ext_f)
 {
 	/* xtal alias is necessary for the current cpufreq driver */
 	struct samsung_clock_alias xti_alias = ALIAS(XTI, NULL, "xtal");
 
 	s3c2412_common_frate_clks[0].fixed_rate = xti_f;
 	s3c2412_common_frate_clks[1].fixed_rate = ext_f;
-	samsung_clk_register_fixed_rate(s3c2412_common_frate_clks,
+	samsung_clk_register_fixed_rate(ctx, s3c2412_common_frate_clks,
 				ARRAY_SIZE(s3c2412_common_frate_clks));
 
-	samsung_clk_register_alias(&xti_alias, 1);
+	samsung_clk_register_alias(ctx, &xti_alias, 1);
 }
 
 void __init s3c2412_common_clk_init(struct device_node *np, unsigned long xti_f,
 				    unsigned long ext_f, void __iomem *base)
 {
+	struct samsung_clk_provider *ctx;
 	reg_base = base;
 
 	if (np) {
@@ -239,24 +241,27 @@ void __init s3c2412_common_clk_init(struct device_node *np, unsigned long xti_f,
 			panic("%s: failed to map registers\n", __func__);
 	}
 
-	samsung_clk_init(np, reg_base, NR_CLKS);
+	ctx = samsung_clk_init(np, reg_base, NR_CLKS);
+	if (!ctx)
+		panic("%s: unable to allocate context.\n", __func__);
 
 	/* Register external clocks only in non-dt cases */
 	if (!np)
-		s3c2412_common_clk_register_fixed_ext(xti_f, ext_f);
+		s3c2412_common_clk_register_fixed_ext(ctx, xti_f, ext_f);
 
 	/* Register PLLs. */
-	samsung_clk_register_pll(s3c2412_plls, ARRAY_SIZE(s3c2412_plls),
+	samsung_clk_register_pll(ctx, s3c2412_plls, ARRAY_SIZE(s3c2412_plls),
 				 reg_base);
 
 	/* Register common internal clocks. */
-	samsung_clk_register_mux(s3c2412_muxes, ARRAY_SIZE(s3c2412_muxes));
-	samsung_clk_register_div(s3c2412_dividers,
+	samsung_clk_register_mux(ctx, s3c2412_muxes, ARRAY_SIZE(s3c2412_muxes));
+	samsung_clk_register_div(ctx, s3c2412_dividers,
 					  ARRAY_SIZE(s3c2412_dividers));
-	samsung_clk_register_gate(s3c2412_gates, ARRAY_SIZE(s3c2412_gates));
-	samsung_clk_register_fixed_factor(s3c2412_ffactor,
+	samsung_clk_register_gate(ctx, s3c2412_gates,
+					ARRAY_SIZE(s3c2412_gates));
+	samsung_clk_register_fixed_factor(ctx, s3c2412_ffactor,
 					  ARRAY_SIZE(s3c2412_ffactor));
-	samsung_clk_register_alias(s3c2412_aliases,
+	samsung_clk_register_alias(ctx, s3c2412_aliases,
 				   ARRAY_SIZE(s3c2412_aliases));
 
 	s3c2412_clk_sleep_init();
diff --git a/drivers/clk/samsung/clk-s3c2443.c b/drivers/clk/samsung/clk-s3c2443.c
index 8e4f451..c4bbdab 100644
--- a/drivers/clk/samsung/clk-s3c2443.c
+++ b/drivers/clk/samsung/clk-s3c2443.c
@@ -365,10 +365,11 @@ struct samsung_fixed_rate_clock s3c2443_common_frate_clks[] __initdata = {
 	FRATE(0, "ext_uart", NULL, CLK_IS_ROOT, 0),
 };
 
-static void __init s3c2443_common_clk_register_fixed_ext(unsigned long xti_f)
+static void __init s3c2443_common_clk_register_fixed_ext(
+		struct samsung_clk_provider *ctx, unsigned long xti_f)
 {
 	s3c2443_common_frate_clks[0].fixed_rate = xti_f;
-	samsung_clk_register_fixed_rate(s3c2443_common_frate_clks,
+	samsung_clk_register_fixed_rate(ctx, s3c2443_common_frate_clks,
 				ARRAY_SIZE(s3c2443_common_frate_clks));
 }
 
@@ -376,6 +377,7 @@ void __init s3c2443_common_clk_init(struct device_node *np, unsigned long xti_f,
 				    int current_soc,
 				    void __iomem *base)
 {
+	struct samsung_clk_provider *ctx;
 	reg_base = base;
 
 	if (np) {
@@ -384,58 +386,60 @@ void __init s3c2443_common_clk_init(struct device_node *np, unsigned long xti_f,
 			panic("%s: failed to map registers\n", __func__);
 	}
 
-	samsung_clk_init(np, reg_base, NR_CLKS);
+	ctx = samsung_clk_init(np, reg_base, NR_CLKS);
+	if (!ctx)
+		panic("%s: unable to allocate context.\n", __func__);
 
 	/* Register external clocks only in non-dt cases */
 	if (!np)
-		s3c2443_common_clk_register_fixed_ext(xti_f);
+		s3c2443_common_clk_register_fixed_ext(ctx, xti_f);
 
 	/* Register PLLs. */
 	if (current_soc == S3C2416 || current_soc == S3C2450)
-		samsung_clk_register_pll(s3c2416_pll_clks,
+		samsung_clk_register_pll(ctx, s3c2416_pll_clks,
 				ARRAY_SIZE(s3c2416_pll_clks), reg_base);
 	else
-		samsung_clk_register_pll(s3c2443_pll_clks,
+		samsung_clk_register_pll(ctx, s3c2443_pll_clks,
 				ARRAY_SIZE(s3c2443_pll_clks), reg_base);
 
 	/* Register common internal clocks. */
-	samsung_clk_register_mux(s3c2443_common_muxes,
+	samsung_clk_register_mux(ctx, s3c2443_common_muxes,
 			ARRAY_SIZE(s3c2443_common_muxes));
-	samsung_clk_register_div(s3c2443_common_dividers,
+	samsung_clk_register_div(ctx, s3c2443_common_dividers,
 			ARRAY_SIZE(s3c2443_common_dividers));
-	samsung_clk_register_gate(s3c2443_common_gates,
+	samsung_clk_register_gate(ctx, s3c2443_common_gates,
 		ARRAY_SIZE(s3c2443_common_gates));
-	samsung_clk_register_alias(s3c2443_common_aliases,
+	samsung_clk_register_alias(ctx, s3c2443_common_aliases,
 		ARRAY_SIZE(s3c2443_common_aliases));
 
 	/* Register SoC-specific clocks. */
 	switch (current_soc) {
 	case S3C2450:
-		samsung_clk_register_div(s3c2450_dividers,
+		samsung_clk_register_div(ctx, s3c2450_dividers,
 				ARRAY_SIZE(s3c2450_dividers));
-		samsung_clk_register_mux(s3c2450_muxes,
+		samsung_clk_register_mux(ctx, s3c2450_muxes,
 				ARRAY_SIZE(s3c2450_muxes));
-		samsung_clk_register_gate(s3c2450_gates,
+		samsung_clk_register_gate(ctx, s3c2450_gates,
 				ARRAY_SIZE(s3c2450_gates));
-		samsung_clk_register_alias(s3c2450_aliases,
+		samsung_clk_register_alias(ctx, s3c2450_aliases,
 				ARRAY_SIZE(s3c2450_aliases));
 		/* fall through, as s3c2450 extends the s3c2416 clocks */
 	case S3C2416:
-		samsung_clk_register_div(s3c2416_dividers,
+		samsung_clk_register_div(ctx, s3c2416_dividers,
 				ARRAY_SIZE(s3c2416_dividers));
-		samsung_clk_register_mux(s3c2416_muxes,
+		samsung_clk_register_mux(ctx, s3c2416_muxes,
 				ARRAY_SIZE(s3c2416_muxes));
-		samsung_clk_register_gate(s3c2416_gates,
+		samsung_clk_register_gate(ctx, s3c2416_gates,
 				ARRAY_SIZE(s3c2416_gates));
-		samsung_clk_register_alias(s3c2416_aliases,
+		samsung_clk_register_alias(ctx, s3c2416_aliases,
 				ARRAY_SIZE(s3c2416_aliases));
 		break;
 	case S3C2443:
-		samsung_clk_register_div(s3c2443_dividers,
+		samsung_clk_register_div(ctx, s3c2443_dividers,
 				ARRAY_SIZE(s3c2443_dividers));
-		samsung_clk_register_gate(s3c2443_gates,
+		samsung_clk_register_gate(ctx, s3c2443_gates,
 				ARRAY_SIZE(s3c2443_gates));
-		samsung_clk_register_alias(s3c2443_aliases,
+		samsung_clk_register_alias(ctx, s3c2443_aliases,
 				ARRAY_SIZE(s3c2443_aliases));
 		break;
 	}
diff --git a/drivers/clk/samsung/clk-s3c64xx.c b/drivers/clk/samsung/clk-s3c64xx.c
index 8bda658..efa16ee 100644
--- a/drivers/clk/samsung/clk-s3c64xx.c
+++ b/drivers/clk/samsung/clk-s3c64xx.c
@@ -442,12 +442,14 @@ static struct samsung_clock_alias s3c6410_clock_aliases[] = {
 	ALIAS(MEM0_SROM, NULL, "srom"),
 };
 
-static void __init s3c64xx_clk_register_fixed_ext(unsigned long fin_pll_f,
-							unsigned long xusbxti_f)
+static void __init s3c64xx_clk_register_fixed_ext(
+				struct samsung_clk_provider *ctx,
+				unsigned long fin_pll_f,
+				unsigned long xusbxti_f)
 {
 	s3c64xx_fixed_rate_ext_clks[0].fixed_rate = fin_pll_f;
 	s3c64xx_fixed_rate_ext_clks[1].fixed_rate = xusbxti_f;
-	samsung_clk_register_fixed_rate(s3c64xx_fixed_rate_ext_clks,
+	samsung_clk_register_fixed_rate(ctx, s3c64xx_fixed_rate_ext_clks,
 				ARRAY_SIZE(s3c64xx_fixed_rate_ext_clks));
 }
 
@@ -456,6 +458,8 @@ void __init s3c64xx_clk_init(struct device_node *np, unsigned long xtal_f,
 			     unsigned long xusbxti_f, bool s3c6400,
 			     void __iomem *base)
 {
+	struct samsung_clk_provider *ctx;
+
 	reg_base = base;
 	is_s3c6400 = s3c6400;
 
@@ -465,48 +469,50 @@ void __init s3c64xx_clk_init(struct device_node *np, unsigned long xtal_f,
 			panic("%s: failed to map registers\n", __func__);
 	}
 
-	samsung_clk_init(np, reg_base, NR_CLKS);
+	ctx = samsung_clk_init(np, reg_base, NR_CLKS);
+	if (!ctx)
+		panic("%s: unable to allocate context.\n", __func__);
 
 	/* Register external clocks. */
 	if (!np)
-		s3c64xx_clk_register_fixed_ext(xtal_f, xusbxti_f);
+		s3c64xx_clk_register_fixed_ext(ctx, xtal_f, xusbxti_f);
 
 	/* Register PLLs. */
-	samsung_clk_register_pll(s3c64xx_pll_clks,
+	samsung_clk_register_pll(ctx, s3c64xx_pll_clks,
 				ARRAY_SIZE(s3c64xx_pll_clks), reg_base);
 
 	/* Register common internal clocks. */
-	samsung_clk_register_fixed_rate(s3c64xx_fixed_rate_clks,
+	samsung_clk_register_fixed_rate(ctx, s3c64xx_fixed_rate_clks,
 					ARRAY_SIZE(s3c64xx_fixed_rate_clks));
-	samsung_clk_register_mux(s3c64xx_mux_clks,
+	samsung_clk_register_mux(ctx, s3c64xx_mux_clks,
 					ARRAY_SIZE(s3c64xx_mux_clks));
-	samsung_clk_register_div(s3c64xx_div_clks,
+	samsung_clk_register_div(ctx, s3c64xx_div_clks,
 					ARRAY_SIZE(s3c64xx_div_clks));
-	samsung_clk_register_gate(s3c64xx_gate_clks,
+	samsung_clk_register_gate(ctx, s3c64xx_gate_clks,
 					ARRAY_SIZE(s3c64xx_gate_clks));
 
 	/* Register SoC-specific clocks. */
 	if (is_s3c6400) {
-		samsung_clk_register_mux(s3c6400_mux_clks,
+		samsung_clk_register_mux(ctx, s3c6400_mux_clks,
 					ARRAY_SIZE(s3c6400_mux_clks));
-		samsung_clk_register_div(s3c6400_div_clks,
+		samsung_clk_register_div(ctx, s3c6400_div_clks,
 					ARRAY_SIZE(s3c6400_div_clks));
-		samsung_clk_register_gate(s3c6400_gate_clks,
+		samsung_clk_register_gate(ctx, s3c6400_gate_clks,
 					ARRAY_SIZE(s3c6400_gate_clks));
-		samsung_clk_register_alias(s3c6400_clock_aliases,
+		samsung_clk_register_alias(ctx, s3c6400_clock_aliases,
 					ARRAY_SIZE(s3c6400_clock_aliases));
 	} else {
-		samsung_clk_register_mux(s3c6410_mux_clks,
+		samsung_clk_register_mux(ctx, s3c6410_mux_clks,
 					ARRAY_SIZE(s3c6410_mux_clks));
-		samsung_clk_register_div(s3c6410_div_clks,
+		samsung_clk_register_div(ctx, s3c6410_div_clks,
 					ARRAY_SIZE(s3c6410_div_clks));
-		samsung_clk_register_gate(s3c6410_gate_clks,
+		samsung_clk_register_gate(ctx, s3c6410_gate_clks,
 					ARRAY_SIZE(s3c6410_gate_clks));
-		samsung_clk_register_alias(s3c6410_clock_aliases,
+		samsung_clk_register_alias(ctx, s3c6410_clock_aliases,
 					ARRAY_SIZE(s3c6410_clock_aliases));
 	}
 
-	samsung_clk_register_alias(s3c64xx_clock_aliases,
+	samsung_clk_register_alias(ctx, s3c64xx_clock_aliases,
 					ARRAY_SIZE(s3c64xx_clock_aliases));
 	s3c64xx_clk_sleep_init();
 
diff --git a/drivers/clk/samsung/clk.c b/drivers/clk/samsung/clk.c
index f3a71d0..25c8303 100644
--- a/drivers/clk/samsung/clk.c
+++ b/drivers/clk/samsung/clk.c
@@ -14,13 +14,6 @@
 #include <linux/syscore_ops.h>
 #include "clk.h"
 
-static DEFINE_SPINLOCK(lock);
-static struct clk **clk_table;
-static void __iomem *reg_base;
-#ifdef CONFIG_OF
-static struct clk_onecell_data clk_data;
-#endif
-
 void samsung_clk_save(void __iomem *base,
 				    struct samsung_clk_reg_dump *rd,
 				    unsigned int num_regs)
@@ -55,12 +48,17 @@ struct samsung_clk_reg_dump *samsung_clk_alloc_reg_dump(
 }
 
 /* setup the essentials required to support clock lookup using ccf */
-void __init samsung_clk_init(struct device_node *np, void __iomem *base,
-			     unsigned long nr_clks)
+struct samsung_clk_provider *__init samsung_clk_init(struct device_node *np,
+			void __iomem *base, unsigned long nr_clks)
 {
 	int i;
+	struct samsung_clk_provider *ctx;
+	struct clk **clk_table;
+	int ret;
 
-	reg_base = base;
+	ctx = kzalloc(sizeof(struct samsung_clk_provider), GFP_KERNEL);
+	if (!ctx)
+		panic("could not allocate clock provider context.\n");
 
 	clk_table = kmalloc(sizeof(struct clk *) * nr_clks, GFP_KERNEL);
 	if (!clk_table)
@@ -69,31 +67,39 @@ void __init samsung_clk_init(struct device_node *np, void __iomem *base,
 	for (i = 0; i < nr_clks; ++i)
 		clk_table[i] = ERR_PTR(-ENOENT);
 
+	ctx->reg_base = base;
+	ctx->clk_data.clks = clk_table;
+	ctx->clk_data.clk_num = nr_clks;
+	spin_lock_init(&ctx->lock);
+
 	if (!np)
-		return;
+		return ctx;
 
-#ifdef CONFIG_OF
-	clk_data.clks = clk_table;
-	clk_data.clk_num = nr_clks;
-	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
-#endif
+	ret = of_clk_add_provider(np, of_clk_src_onecell_get,
+			&ctx->clk_data);
+	if (ret)
+		panic("could not register clock provide\n");
+
+	return ctx;
 }
 
 /* add a clock instance to the clock lookup table used for dt based lookup */
-void samsung_clk_add_lookup(struct clk *clk, unsigned int id)
+void samsung_clk_add_lookup(struct samsung_clk_provider *ctx, struct clk *clk,
+				unsigned int id)
 {
-	if (clk_table && id)
-		clk_table[id] = clk;
+	if (ctx->clk_data.clks && id)
+		ctx->clk_data.clks[id] = clk;
 }
 
 /* register a list of aliases */
-void __init samsung_clk_register_alias(struct samsung_clock_alias *list,
-					unsigned int nr_clk)
+void __init samsung_clk_register_alias(struct samsung_clk_provider *ctx,
+				struct samsung_clock_alias *list,
+				unsigned int nr_clk)
 {
 	struct clk *clk;
 	unsigned int idx, ret;
 
-	if (!clk_table) {
+	if (!ctx->clk_data.clks) {
 		pr_err("%s: clock table missing\n", __func__);
 		return;
 	}
@@ -105,7 +111,7 @@ void __init samsung_clk_register_alias(struct samsung_clock_alias *list,
 			continue;
 		}
 
-		clk = clk_table[list->id];
+		clk = ctx->clk_data.clks[list->id];
 		if (!clk) {
 			pr_err("%s: failed to find clock %d\n", __func__,
 				list->id);
@@ -120,7 +126,7 @@ void __init samsung_clk_register_alias(struct samsung_clock_alias *list,
 }
 
 /* register a list of fixed clocks */
-void __init samsung_clk_register_fixed_rate(
+void __init samsung_clk_register_fixed_rate(struct samsung_clk_provider *ctx,
 		struct samsung_fixed_rate_clock *list, unsigned int nr_clk)
 {
 	struct clk *clk;
@@ -135,7 +141,7 @@ void __init samsung_clk_register_fixed_rate(
 			continue;
 		}
 
-		samsung_clk_add_lookup(clk, list->id);
+		samsung_clk_add_lookup(ctx, clk, list->id);
 
 		/*
 		 * Unconditionally add a clock lookup for the fixed rate clocks.
@@ -149,7 +155,7 @@ void __init samsung_clk_register_fixed_rate(
 }
 
 /* register a list of fixed factor clocks */
-void __init samsung_clk_register_fixed_factor(
+void __init samsung_clk_register_fixed_factor(struct samsung_clk_provider *ctx,
 		struct samsung_fixed_factor_clock *list, unsigned int nr_clk)
 {
 	struct clk *clk;
@@ -164,28 +170,30 @@ void __init samsung_clk_register_fixed_factor(
 			continue;
 		}
 
-		samsung_clk_add_lookup(clk, list->id);
+		samsung_clk_add_lookup(ctx, clk, list->id);
 	}
 }
 
 /* register a list of mux clocks */
-void __init samsung_clk_register_mux(struct samsung_mux_clock *list,
-					unsigned int nr_clk)
+void __init samsung_clk_register_mux(struct samsung_clk_provider *ctx,
+				struct samsung_mux_clock *list,
+				unsigned int nr_clk)
 {
 	struct clk *clk;
 	unsigned int idx, ret;
 
 	for (idx = 0; idx < nr_clk; idx++, list++) {
 		clk = clk_register_mux(NULL, list->name, list->parent_names,
-			list->num_parents, list->flags, reg_base + list->offset,
-			list->shift, list->width, list->mux_flags, &lock);
+			list->num_parents, list->flags,
+			ctx->reg_base + list->offset,
+			list->shift, list->width, list->mux_flags, &ctx->lock);
 		if (IS_ERR(clk)) {
 			pr_err("%s: failed to register clock %s\n", __func__,
 				list->name);
 			continue;
 		}
 
-		samsung_clk_add_lookup(clk, list->id);
+		samsung_clk_add_lookup(ctx, clk, list->id);
 
 		/* register a clock lookup only if a clock alias is specified */
 		if (list->alias) {
@@ -199,8 +207,9 @@ void __init samsung_clk_register_mux(struct samsung_mux_clock *list,
 }
 
 /* register a list of div clocks */
-void __init samsung_clk_register_div(struct samsung_div_clock *list,
-					unsigned int nr_clk)
+void __init samsung_clk_register_div(struct samsung_clk_provider *ctx,
+				struct samsung_div_clock *list,
+				unsigned int nr_clk)
 {
 	struct clk *clk;
 	unsigned int idx, ret;
@@ -208,22 +217,22 @@ void __init samsung_clk_register_div(struct samsung_div_clock *list,
 	for (idx = 0; idx < nr_clk; idx++, list++) {
 		if (list->table)
 			clk = clk_register_divider_table(NULL, list->name,
-					list->parent_name, list->flags,
-					reg_base + list->offset, list->shift,
-					list->width, list->div_flags,
-					list->table, &lock);
+				list->parent_name, list->flags,
+				ctx->reg_base + list->offset,
+				list->shift, list->width, list->div_flags,
+				list->table, &ctx->lock);
 		else
 			clk = clk_register_divider(NULL, list->name,
-					list->parent_name, list->flags,
-					reg_base + list->offset, list->shift,
-					list->width, list->div_flags, &lock);
+				list->parent_name, list->flags,
+				ctx->reg_base + list->offset, list->shift,
+				list->width, list->div_flags, &ctx->lock);
 		if (IS_ERR(clk)) {
 			pr_err("%s: failed to register clock %s\n", __func__,
 				list->name);
 			continue;
 		}
 
-		samsung_clk_add_lookup(clk, list->id);
+		samsung_clk_add_lookup(ctx, clk, list->id);
 
 		/* register a clock lookup only if a clock alias is specified */
 		if (list->alias) {
@@ -237,16 +246,17 @@ void __init samsung_clk_register_div(struct samsung_div_clock *list,
 }
 
 /* register a list of gate clocks */
-void __init samsung_clk_register_gate(struct samsung_gate_clock *list,
-						unsigned int nr_clk)
+void __init samsung_clk_register_gate(struct samsung_clk_provider *ctx,
+				struct samsung_gate_clock *list,
+				unsigned int nr_clk)
 {
 	struct clk *clk;
 	unsigned int idx, ret;
 
 	for (idx = 0; idx < nr_clk; idx++, list++) {
 		clk = clk_register_gate(NULL, list->name, list->parent_name,
-				list->flags, reg_base + list->offset,
-				list->bit_idx, list->gate_flags, &lock);
+				list->flags, ctx->reg_base + list->offset,
+				list->bit_idx, list->gate_flags, &ctx->lock);
 		if (IS_ERR(clk)) {
 			pr_err("%s: failed to register clock %s\n", __func__,
 				list->name);
@@ -262,7 +272,7 @@ void __init samsung_clk_register_gate(struct samsung_gate_clock *list,
 					__func__, list->alias);
 		}
 
-		samsung_clk_add_lookup(clk, list->id);
+		samsung_clk_add_lookup(ctx, clk, list->id);
 	}
 }
 
@@ -271,21 +281,21 @@ void __init samsung_clk_register_gate(struct samsung_gate_clock *list,
  * tree and register it
  */
 #ifdef CONFIG_OF
-void __init samsung_clk_of_register_fixed_ext(
+void __init samsung_clk_of_register_fixed_ext(struct samsung_clk_provider *ctx,
 			struct samsung_fixed_rate_clock *fixed_rate_clk,
 			unsigned int nr_fixed_rate_clk,
 			struct of_device_id *clk_matches)
 {
 	const struct of_device_id *match;
-	struct device_node *np;
+	struct device_node *clk_np;
 	u32 freq;
 
-	for_each_matching_node_and_match(np, clk_matches, &match) {
-		if (of_property_read_u32(np, "clock-frequency", &freq))
+	for_each_matching_node_and_match(clk_np, clk_matches, &match) {
+		if (of_property_read_u32(clk_np, "clock-frequency", &freq))
 			continue;
 		fixed_rate_clk[(u32)match->data].fixed_rate = freq;
 	}
-	samsung_clk_register_fixed_rate(fixed_rate_clk, nr_fixed_rate_clk);
+	samsung_clk_register_fixed_rate(ctx, fixed_rate_clk, nr_fixed_rate_clk);
 }
 #endif
 
diff --git a/drivers/clk/samsung/clk.h b/drivers/clk/samsung/clk.h
index c7141ba..9693b80 100644
--- a/drivers/clk/samsung/clk.h
+++ b/drivers/clk/samsung/clk.h
@@ -22,6 +22,18 @@
 #include "clk-pll.h"
 
 /**
+ * struct samsung_clk_provider: information about clock provider
+ * @reg_base: virtual address for the register base.
+ * @clk_data: holds clock related data like clk* and number of clocks.
+ * @lock: maintains exclusion bwtween callbacks for a given clock-provider.
+ */
+struct samsung_clk_provider {
+	void __iomem *reg_base;
+	struct clk_onecell_data clk_data;
+	spinlock_t lock;
+};
+
+/**
  * struct samsung_clock_alias: information about mux clock
  * @id: platform specific id of the clock.
  * @dev_name: name of the device to which this clock belongs.
@@ -312,40 +324,52 @@ struct samsung_pll_clock {
 	__PLL(_typ, _id, NULL, _name, _pname, CLK_GET_RATE_NOCACHE,	\
 		_lock, _con, _rtable, _alias)
 
-extern void __init samsung_clk_init(struct device_node *np, void __iomem *base,
-				    unsigned long nr_clks);
+extern struct samsung_clk_provider *__init samsung_clk_init(
+			struct device_node *np, void __iomem *base,
+			unsigned long nr_clks);
 extern void __init samsung_clk_of_register_fixed_ext(
-		struct samsung_fixed_rate_clock *fixed_rate_clk,
-		unsigned int nr_fixed_rate_clk,
-		struct of_device_id *clk_matches);
+			struct samsung_clk_provider *ctx,
+			struct samsung_fixed_rate_clock *fixed_rate_clk,
+			unsigned int nr_fixed_rate_clk,
+			struct of_device_id *clk_matches);
 
-extern void samsung_clk_add_lookup(struct clk *clk, unsigned int id);
+extern void samsung_clk_add_lookup(struct samsung_clk_provider *ctx,
+			struct clk *clk, unsigned int id);
 
-extern void samsung_clk_register_alias(struct samsung_clock_alias *list,
-		unsigned int nr_clk);
+extern void samsung_clk_register_alias(struct samsung_clk_provider *ctx,
+			struct samsung_clock_alias *list,
+			unsigned int nr_clk);
 extern void __init samsung_clk_register_fixed_rate(
-		struct samsung_fixed_rate_clock *clk_list, unsigned int nr_clk);
+			struct samsung_clk_provider *ctx,
+			struct samsung_fixed_rate_clock *clk_list,
+			unsigned int nr_clk);
 extern void __init samsung_clk_register_fixed_factor(
-		struct samsung_fixed_factor_clock *list, unsigned int nr_clk);
-extern void __init samsung_clk_register_mux(struct samsung_mux_clock *clk_list,
-		unsigned int nr_clk);
-extern void __init samsung_clk_register_div(struct samsung_div_clock *clk_list,
-		unsigned int nr_clk);
-extern void __init samsung_clk_register_gate(
-		struct samsung_gate_clock *clk_list, unsigned int nr_clk);
-extern void __init samsung_clk_register_pll(struct samsung_pll_clock *pll_list,
-		unsigned int nr_clk, void __iomem *base);
+			struct samsung_clk_provider *ctx,
+			struct samsung_fixed_factor_clock *list,
+			unsigned int nr_clk);
+extern void __init samsung_clk_register_mux(struct samsung_clk_provider *ctx,
+			struct samsung_mux_clock *clk_list,
+			unsigned int nr_clk);
+extern void __init samsung_clk_register_div(struct samsung_clk_provider *ctx,
+			struct samsung_div_clock *clk_list,
+			unsigned int nr_clk);
+extern void __init samsung_clk_register_gate(struct samsung_clk_provider *ctx,
+			struct samsung_gate_clock *clk_list,
+			unsigned int nr_clk);
+extern void __init samsung_clk_register_pll(struct samsung_clk_provider *ctx,
+			struct samsung_pll_clock *pll_list,
+			unsigned int nr_clk, void __iomem *base);
 
 extern unsigned long _get_rate(const char *clk_name);
 
 extern void samsung_clk_save(void __iomem *base,
-			     struct samsung_clk_reg_dump *rd,
-			     unsigned int num_regs);
+			struct samsung_clk_reg_dump *rd,
+			unsigned int num_regs);
 extern void samsung_clk_restore(void __iomem *base,
-				const struct samsung_clk_reg_dump *rd,
-				unsigned int num_regs);
+			const struct samsung_clk_reg_dump *rd,
+			unsigned int num_regs);
 extern struct samsung_clk_reg_dump *samsung_clk_alloc_reg_dump(
-						const unsigned long *rdump,
-						unsigned long nr_rdump);
+			const unsigned long *rdump,
+			unsigned long nr_rdump);
 
 #endif /* __SAMSUNG_CLK_H */
-- 
1.7.9.5
