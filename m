From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 25 Jan 2016 21:15:38 +0800
Subject: [PATCH RFC 02/11] clk: sunxi: factors: Make struct clk_factors_config
 table const
In-Reply-To: <1453727747-23307-1-git-send-email-wens@csie.org>
References: <1453727747-23307-1-git-send-email-wens@csie.org>
Message-ID: <1453727747-23307-3-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

struct clk_factors_config contains shifts/widths for the factors of
the factors clk. This is used to read out the factors from the register
value. In no case is it written to, so make it const.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/clk/sunxi/clk-factors.c    |  4 ++--
 drivers/clk/sunxi/clk-factors.h    |  4 ++--
 drivers/clk/sunxi/clk-mod0.c       |  2 +-
 drivers/clk/sunxi/clk-sun9i-core.c |  8 ++++----
 drivers/clk/sunxi/clk-sunxi.c      | 16 ++++++++--------
 5 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/clk/sunxi/clk-factors.c b/drivers/clk/sunxi/clk-factors.c
index 59428dbd607a..928c079da193 100644
--- a/drivers/clk/sunxi/clk-factors.c
+++ b/drivers/clk/sunxi/clk-factors.c
@@ -48,7 +48,7 @@ static unsigned long clk_factors_recalc_rate(struct clk_hw *hw,
 	u32 reg;
 	unsigned long rate;
 	struct clk_factors *factors = to_clk_factors(hw);
-	struct clk_factors_config *config = factors->config;
+	const struct clk_factors_config *config = factors->config;
 
 	/* Fetch the register value */
 	reg = readl(factors->reg);
@@ -123,7 +123,7 @@ static int clk_factors_set_rate(struct clk_hw *hw, unsigned long rate,
 	u8 n = 0, k = 0, m = 0, p = 0;
 	u32 reg;
 	struct clk_factors *factors = to_clk_factors(hw);
-	struct clk_factors_config *config = factors->config;
+	const struct clk_factors_config *config = factors->config;
 	unsigned long flags = 0;
 
 	factors->get_factors((u32 *)&rate, (u32)parent_rate, &n, &k, &m, &p);
diff --git a/drivers/clk/sunxi/clk-factors.h b/drivers/clk/sunxi/clk-factors.h
index 171085ab5513..060319be2b99 100644
--- a/drivers/clk/sunxi/clk-factors.h
+++ b/drivers/clk/sunxi/clk-factors.h
@@ -23,7 +23,7 @@ struct factors_data {
 	int enable;
 	int mux;
 	int muxmask;
-	struct clk_factors_config *table;
+	const struct clk_factors_config *table;
 	void (*getter) (u32 *rate, u32 parent_rate, u8 *n, u8 *k, u8 *m, u8 *p);
 	const char *name;
 };
@@ -31,7 +31,7 @@ struct factors_data {
 struct clk_factors {
 	struct clk_hw hw;
 	void __iomem *reg;
-	struct clk_factors_config *config;
+	const struct clk_factors_config *config;
 	void (*get_factors) (u32 *rate, u32 parent, u8 *n, u8 *k, u8 *m, u8 *p);
 	spinlock_t *lock;
 };
diff --git a/drivers/clk/sunxi/clk-mod0.c b/drivers/clk/sunxi/clk-mod0.c
index d167e1efb927..c67fea1a128d 100644
--- a/drivers/clk/sunxi/clk-mod0.c
+++ b/drivers/clk/sunxi/clk-mod0.c
@@ -62,7 +62,7 @@ static void sun4i_a10_get_mod0_factors(u32 *freq, u32 parent_rate,
 }
 
 /* user manual says "n" but it's really "p" */
-static struct clk_factors_config sun4i_a10_mod0_config = {
+static const struct clk_factors_config sun4i_a10_mod0_config = {
 	.mshift = 0,
 	.mwidth = 4,
 	.pshift = 16,
diff --git a/drivers/clk/sunxi/clk-sun9i-core.c b/drivers/clk/sunxi/clk-sun9i-core.c
index 6c4c98324d3c..37c85caaef88 100644
--- a/drivers/clk/sunxi/clk-sun9i-core.c
+++ b/drivers/clk/sunxi/clk-sun9i-core.c
@@ -71,7 +71,7 @@ static void sun9i_a80_get_pll4_factors(u32 *freq, u32 parent_rate,
 	*p_ret = p;
 }
 
-static struct clk_factors_config sun9i_a80_pll4_config = {
+static const struct clk_factors_config sun9i_a80_pll4_config = {
 	.mshift = 18,
 	.mwidth = 1,
 	.nshift = 8,
@@ -134,7 +134,7 @@ static void sun9i_a80_get_gt_factors(u32 *freq, u32 parent_rate,
 	*m = div;
 }
 
-static struct clk_factors_config sun9i_a80_gt_config = {
+static const struct clk_factors_config sun9i_a80_gt_config = {
 	.mshift = 0,
 	.mwidth = 2,
 };
@@ -199,7 +199,7 @@ static void sun9i_a80_get_ahb_factors(u32 *freq, u32 parent_rate,
 	*p = _p;
 }
 
-static struct clk_factors_config sun9i_a80_ahb_config = {
+static const struct clk_factors_config sun9i_a80_ahb_config = {
 	.pshift = 0,
 	.pwidth = 2,
 };
@@ -289,7 +289,7 @@ static void sun9i_a80_get_apb1_factors(u32 *freq, u32 parent_rate,
 	*p = calcp;
 }
 
-static struct clk_factors_config sun9i_a80_apb1_config = {
+static const struct clk_factors_config sun9i_a80_apb1_config = {
 	.mshift = 0,
 	.mwidth = 5,
 	.pshift = 16,
diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index 0d4525365552..7e719d089017 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -608,7 +608,7 @@ static void sun7i_a20_get_out_factors(u32 *freq, u32 parent_rate,
  * sunxi_factors_clk_setup() - Setup function for factor clocks
  */
 
-static struct clk_factors_config sun4i_pll1_config = {
+static const struct clk_factors_config sun4i_pll1_config = {
 	.nshift = 8,
 	.nwidth = 5,
 	.kshift = 4,
@@ -619,7 +619,7 @@ static struct clk_factors_config sun4i_pll1_config = {
 	.pwidth = 2,
 };
 
-static struct clk_factors_config sun6i_a31_pll1_config = {
+static const struct clk_factors_config sun6i_a31_pll1_config = {
 	.nshift	= 8,
 	.nwidth = 5,
 	.kshift = 4,
@@ -629,7 +629,7 @@ static struct clk_factors_config sun6i_a31_pll1_config = {
 	.n_start = 1,
 };
 
-static struct clk_factors_config sun8i_a23_pll1_config = {
+static const struct clk_factors_config sun8i_a23_pll1_config = {
 	.nshift = 8,
 	.nwidth = 5,
 	.kshift = 4,
@@ -641,14 +641,14 @@ static struct clk_factors_config sun8i_a23_pll1_config = {
 	.n_start = 1,
 };
 
-static struct clk_factors_config sun4i_pll5_config = {
+static const struct clk_factors_config sun4i_pll5_config = {
 	.nshift = 8,
 	.nwidth = 5,
 	.kshift = 4,
 	.kwidth = 2,
 };
 
-static struct clk_factors_config sun6i_a31_pll6_config = {
+static const struct clk_factors_config sun6i_a31_pll6_config = {
 	.nshift	= 8,
 	.nwidth = 5,
 	.kshift = 4,
@@ -656,12 +656,12 @@ static struct clk_factors_config sun6i_a31_pll6_config = {
 	.n_start = 1,
 };
 
-static struct clk_factors_config sun5i_a13_ahb_config = {
+static const struct clk_factors_config sun5i_a13_ahb_config = {
 	.pshift = 4,
 	.pwidth = 2,
 };
 
-static struct clk_factors_config sun4i_apb1_config = {
+static const struct clk_factors_config sun4i_apb1_config = {
 	.mshift = 0,
 	.mwidth = 5,
 	.pshift = 16,
@@ -669,7 +669,7 @@ static struct clk_factors_config sun4i_apb1_config = {
 };
 
 /* user manual says "n" but it's really "p" */
-static struct clk_factors_config sun7i_a20_out_config = {
+static const struct clk_factors_config sun7i_a20_out_config = {
 	.mshift = 8,
 	.mwidth = 5,
 	.pshift = 20,
-- 
2.7.0
