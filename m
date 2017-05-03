From: wens@csie.org (Chen-Yu Tsai)
Date: Wed,  3 May 2017 11:09:25 +0800
Subject: [PATCH v2 4/8] clk: sunxi-ng: Support multiple variable pre-dividers
In-Reply-To: <20170503030929.28763-1-wens@csie.org>
References: <20170503030929.28763-1-wens@csie.org>
Message-ID: <20170503030929.28763-5-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On the A83T, the AHB1 clock has a shared pre-divider on the two
PLL-PERIPH clock parents. To support such instances of shared
pre-dividers, this patch extends the mux clock type to support
multiple variable pre-dividers.

As the pre-dividers are only used to calculate the rate, but
do not participate in the factorization process, this is fairly
straightforward.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/clk/sunxi-ng/ccu-sun50i-a64.c | 10 +++++-----
 drivers/clk/sunxi-ng/ccu-sun6i-a31.c  | 10 +++++-----
 drivers/clk/sunxi-ng/ccu-sun8i-a23.c  | 10 +++++-----
 drivers/clk/sunxi-ng/ccu-sun8i-a33.c  | 10 +++++-----
 drivers/clk/sunxi-ng/ccu-sun8i-h3.c   | 10 +++++-----
 drivers/clk/sunxi-ng/ccu-sun8i-r.c    | 10 +++++-----
 drivers/clk/sunxi-ng/ccu-sun8i-v3s.c  | 10 +++++-----
 drivers/clk/sunxi-ng/ccu_mux.c        | 15 ++++++++-------
 drivers/clk/sunxi-ng/ccu_mux.h        | 13 ++++++++-----
 9 files changed, 51 insertions(+), 47 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
index f54114c607df..2bb4cabf802f 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
@@ -211,6 +211,9 @@ static SUNXI_CCU_M(axi_clk, "axi", "cpux", 0x050, 0, 2, 0);
 
 static const char * const ahb1_parents[] = { "osc32k", "osc24M",
 					     "axi", "pll-periph0" };
+static const struct ccu_mux_var_prediv ahb1_predivs[] = {
+	{ .index = 3, .shift = 6, .width = 2 },
+};
 static struct ccu_div ahb1_clk = {
 	.div		= _SUNXI_CCU_DIV_FLAGS(4, 2, CLK_DIVIDER_POWER_OF_TWO),
 
@@ -218,11 +221,8 @@ static struct ccu_div ahb1_clk = {
 		.shift	= 12,
 		.width	= 2,
 
-		.variable_prediv	= {
-			.index	= 3,
-			.shift	= 6,
-			.width	= 2,
-		},
+		.var_predivs	= ahb1_predivs,
+		.n_var_predivs	= ARRAY_SIZE(ahb1_predivs),
 	},
 
 	.common		= {
diff --git a/drivers/clk/sunxi-ng/ccu-sun6i-a31.c b/drivers/clk/sunxi-ng/ccu-sun6i-a31.c
index 89e68d29bf45..bc9f2ca19233 100644
--- a/drivers/clk/sunxi-ng/ccu-sun6i-a31.c
+++ b/drivers/clk/sunxi-ng/ccu-sun6i-a31.c
@@ -195,6 +195,9 @@ static SUNXI_CCU_DIV_TABLE(axi_clk, "axi", "cpu",
 
 static const char * const ahb1_parents[] = { "osc32k", "osc24M",
 					     "axi", "pll-periph" };
+static const struct ccu_mux_var_prediv ahb1_predivs[] = {
+	{ .index = 3, .shift = 6, .width = 2 },
+};
 
 static struct ccu_div ahb1_clk = {
 	.div		= _SUNXI_CCU_DIV_FLAGS(4, 2, CLK_DIVIDER_POWER_OF_TWO),
@@ -203,11 +206,8 @@ static struct ccu_div ahb1_clk = {
 		.shift	= 12,
 		.width	= 2,
 
-		.variable_prediv	= {
-			.index	= 3,
-			.shift	= 6,
-			.width	= 2,
-		},
+		.var_predivs	= ahb1_predivs,
+		.n_var_predivs	= ARRAY_SIZE(ahb1_predivs),
 	},
 
 	.common		= {
diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-a23.c b/drivers/clk/sunxi-ng/ccu-sun8i-a23.c
index 5c6d37bdf247..8a753ed0426d 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-a23.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-a23.c
@@ -169,6 +169,9 @@ static SUNXI_CCU_M(axi_clk, "axi", "cpux", 0x050, 0, 2, 0);
 
 static const char * const ahb1_parents[] = { "osc32k", "osc24M",
 					     "axi" , "pll-periph" };
+static const struct ccu_mux_var_prediv ahb1_predivs[] = {
+	{ .index = 3, .shift = 6, .width = 2 },
+};
 static struct ccu_div ahb1_clk = {
 	.div		= _SUNXI_CCU_DIV_FLAGS(4, 2, CLK_DIVIDER_POWER_OF_TWO),
 
@@ -176,11 +179,8 @@ static struct ccu_div ahb1_clk = {
 		.shift	= 12,
 		.width	= 2,
 
-		.variable_prediv	= {
-			.index	= 3,
-			.shift	= 6,
-			.width	= 2,
-		},
+		.var_predivs	= ahb1_predivs,
+		.n_var_predivs	= ARRAY_SIZE(ahb1_predivs),
 	},
 
 	.common		= {
diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-a33.c b/drivers/clk/sunxi-ng/ccu-sun8i-a33.c
index 8d38e6510e29..10b38dc46f75 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-a33.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-a33.c
@@ -180,6 +180,9 @@ static SUNXI_CCU_M(axi_clk, "axi", "cpux", 0x050, 0, 2, 0);
 
 static const char * const ahb1_parents[] = { "osc32k", "osc24M",
 					     "axi" , "pll-periph" };
+static const struct ccu_mux_var_prediv ahb1_predivs[] = {
+	{ .index = 3, .shift = 6, .width = 2 },
+};
 static struct ccu_div ahb1_clk = {
 	.div		= _SUNXI_CCU_DIV_FLAGS(4, 2, CLK_DIVIDER_POWER_OF_TWO),
 
@@ -187,11 +190,8 @@ static struct ccu_div ahb1_clk = {
 		.shift	= 12,
 		.width	= 2,
 
-		.variable_prediv	= {
-			.index	= 3,
-			.shift	= 6,
-			.width	= 2,
-		},
+		.var_predivs	= ahb1_predivs,
+		.n_var_predivs	= ARRAY_SIZE(ahb1_predivs),
 	},
 
 	.common		= {
diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-h3.c b/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
index 4cbc1b701b7c..62e4f0d2b2fc 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
@@ -141,6 +141,9 @@ static SUNXI_CCU_M(axi_clk, "axi", "cpux", 0x050, 0, 2, 0);
 
 static const char * const ahb1_parents[] = { "osc32k", "osc24M",
 					     "axi" , "pll-periph0" };
+static const struct ccu_mux_var_prediv ahb1_predivs[] = {
+	{ .index = 3, .shift = 6, .width = 2 },
+};
 static struct ccu_div ahb1_clk = {
 	.div		= _SUNXI_CCU_DIV_FLAGS(4, 2, CLK_DIVIDER_POWER_OF_TWO),
 
@@ -148,11 +151,8 @@ static struct ccu_div ahb1_clk = {
 		.shift	= 12,
 		.width	= 2,
 
-		.variable_prediv	= {
-			.index	= 3,
-			.shift	= 6,
-			.width	= 2,
-		},
+		.var_predivs	= ahb1_predivs,
+		.n_var_predivs	= ARRAY_SIZE(ahb1_predivs),
 	},
 
 	.common		= {
diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-r.c b/drivers/clk/sunxi-ng/ccu-sun8i-r.c
index 119f47b568ea..de02be75785c 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-r.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-r.c
@@ -27,6 +27,9 @@
 
 static const char * const ar100_parents[] = { "osc32k", "osc24M",
 					     "pll-periph0", "iosc" };
+static const struct ccu_mux_var_prediv ar100_predivs[] = {
+	{ .index = 2, .shift = 8, .width = 5 },
+};
 
 static struct ccu_div ar100_clk = {
 	.div		= _SUNXI_CCU_DIV_FLAGS(4, 2, CLK_DIVIDER_POWER_OF_TWO),
@@ -35,11 +38,8 @@ static struct ccu_div ar100_clk = {
 		.shift	= 16,
 		.width	= 2,
 
-		.variable_prediv	= {
-			.index	= 2,
-			.shift	= 8,
-			.width	= 5,
-		},
+		.var_predivs	= ar100_predivs,
+		.n_var_predivs	= ARRAY_SIZE(ar100_predivs),
 	},
 
 	.common		= {
diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c b/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c
index e58706b40ae9..cb7299a94cba 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c
@@ -132,6 +132,9 @@ static SUNXI_CCU_M(axi_clk, "axi", "cpu", 0x050, 0, 2, 0);
 
 static const char * const ahb1_parents[] = { "osc32k", "osc24M",
 					     "axi", "pll-periph0" };
+static const struct ccu_mux_var_prediv ahb1_predivs[] = {
+	{ .index = 3, .shift = 6, .width = 2 },
+};
 static struct ccu_div ahb1_clk = {
 	.div		= _SUNXI_CCU_DIV_FLAGS(4, 2, CLK_DIVIDER_POWER_OF_TWO),
 
@@ -139,11 +142,8 @@ static struct ccu_div ahb1_clk = {
 		.shift	= 12,
 		.width	= 2,
 
-		.variable_prediv	= {
-			.index	= 3,
-			.shift	= 6,
-			.width	= 2,
-		},
+		.var_predivs	= ahb1_predivs,
+		.n_var_predivs	= ARRAY_SIZE(ahb1_predivs),
 	},
 
 	.common		= {
diff --git a/drivers/clk/sunxi-ng/ccu_mux.c b/drivers/clk/sunxi-ng/ccu_mux.c
index c6bb1f523232..b1eaafac9f23 100644
--- a/drivers/clk/sunxi-ng/ccu_mux.c
+++ b/drivers/clk/sunxi-ng/ccu_mux.c
@@ -46,13 +46,14 @@ void ccu_mux_helper_adjust_parent_for_prediv(struct ccu_common *common,
 				prediv = cm->fixed_predivs[i].div;
 
 	if (common->features & CCU_FEATURE_VARIABLE_PREDIV)
-		if (parent_index == cm->variable_prediv.index) {
-			u8 div;
-
-			div = reg >> cm->variable_prediv.shift;
-			div &= (1 << cm->variable_prediv.width) - 1;
-			prediv = div + 1;
-		}
+		for (i = 0; i < cm->n_var_predivs; i++)
+			if (parent_index == cm->var_predivs[i].index) {
+				u8 div;
+
+				div = reg >> cm->var_predivs[i].shift;
+				div &= (1 << cm->var_predivs[i].width) - 1;
+				prediv = div + 1;
+			}
 
 	*parent_rate = *parent_rate / prediv;
 }
diff --git a/drivers/clk/sunxi-ng/ccu_mux.h b/drivers/clk/sunxi-ng/ccu_mux.h
index 47aba3a48245..044262245c07 100644
--- a/drivers/clk/sunxi-ng/ccu_mux.h
+++ b/drivers/clk/sunxi-ng/ccu_mux.h
@@ -10,6 +10,12 @@ struct ccu_mux_fixed_prediv {
 	u16	div;
 };
 
+struct ccu_mux_var_prediv {
+	u8	index;
+	u8	shift;
+	u8	width;
+};
+
 struct ccu_mux_internal {
 	u8		shift;
 	u8		width;
@@ -18,11 +24,8 @@ struct ccu_mux_internal {
 	const struct ccu_mux_fixed_prediv	*fixed_predivs;
 	u8		n_predivs;
 
-	struct {
-		u8	index;
-		u8	shift;
-		u8	width;
-	} variable_prediv;
+	const struct ccu_mux_var_prediv		*var_predivs;
+	u8		n_var_predivs;
 };
 
 #define _SUNXI_CCU_MUX_TABLE(_shift, _width, _table)	\
-- 
2.11.0
