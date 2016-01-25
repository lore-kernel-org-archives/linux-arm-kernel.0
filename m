From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 25 Jan 2016 21:15:42 +0800
Subject: [PATCH RFC 06/11] clk: sunxi: factors: Consolidate get_factors
 parameters into a struct
In-Reply-To: <1453727747-23307-1-git-send-email-wens@csie.org>
References: <1453727747-23307-1-git-send-email-wens@csie.org>
Message-ID: <1453727747-23307-7-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The .get_factors callback of factors_clk has 6 parameters. To extend
factors_clk in any way that requires adding parameters to .get_factors
would make that list even longer, not to mention changing all the
function declarations.

Do this once now and consolidate all the parameters into a struct.
Also drop the space before function pointer arguments, since checkpatch
complains.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/clk/sunxi/clk-factors.c    |  24 ++--
 drivers/clk/sunxi/clk-factors.h    |  13 ++-
 drivers/clk/sunxi/clk-mod0.c       |  20 ++--
 drivers/clk/sunxi/clk-sun8i-mbus.c |  18 +--
 drivers/clk/sunxi/clk-sun9i-core.c |  77 +++++--------
 drivers/clk/sunxi/clk-sunxi.c      | 222 +++++++++++++++----------------------
 6 files changed, 155 insertions(+), 219 deletions(-)

diff --git a/drivers/clk/sunxi/clk-factors.c b/drivers/clk/sunxi/clk-factors.c
index b464ca4a232e..47b7d918b74c 100644
--- a/drivers/clk/sunxi/clk-factors.c
+++ b/drivers/clk/sunxi/clk-factors.c
@@ -73,8 +73,13 @@ static long clk_factors_round_rate(struct clk_hw *hw, unsigned long rate,
 				   unsigned long *parent_rate)
 {
 	struct clk_factors *factors = to_clk_factors(hw);
-	factors->get_factors((u32 *)&rate, (u32)*parent_rate,
-			     NULL, NULL, NULL, NULL);
+	struct factors_request req = {
+		.rate = rate,
+		.parent_rate = *parent_rate,
+	};
+
+	factors->get_factors(&req);
+
 
 	return rate;
 }
@@ -120,13 +125,16 @@ static int clk_factors_determine_rate(struct clk_hw *hw,
 static int clk_factors_set_rate(struct clk_hw *hw, unsigned long rate,
 				unsigned long parent_rate)
 {
-	u8 n = 0, k = 0, m = 0, p = 0;
+	struct factors_request req = {
+		.rate = rate,
+		.parent_rate = parent_rate,
+	};
 	u32 reg;
 	struct clk_factors *factors = to_clk_factors(hw);
 	const struct clk_factors_config *config = factors->config;
 	unsigned long flags = 0;
 
-	factors->get_factors((u32 *)&rate, (u32)parent_rate, &n, &k, &m, &p);
+	factors->get_factors(&req);
 
 	if (factors->lock)
 		spin_lock_irqsave(factors->lock, flags);
@@ -135,10 +143,10 @@ static int clk_factors_set_rate(struct clk_hw *hw, unsigned long rate,
 	reg = readl(factors->reg);
 
 	/* Set up the new factors - macros do not do anything if width is 0 */
-	reg = FACTOR_SET(config->nshift, config->nwidth, reg, n);
-	reg = FACTOR_SET(config->kshift, config->kwidth, reg, k);
-	reg = FACTOR_SET(config->mshift, config->mwidth, reg, m);
-	reg = FACTOR_SET(config->pshift, config->pwidth, reg, p);
+	reg = FACTOR_SET(config->nshift, config->nwidth, reg, req.n);
+	reg = FACTOR_SET(config->kshift, config->kwidth, reg, req.k);
+	reg = FACTOR_SET(config->mshift, config->mwidth, reg, req.m);
+	reg = FACTOR_SET(config->pshift, config->pwidth, reg, req.p);
 
 	/* Apply them now */
 	writel(reg, factors->reg);
diff --git a/drivers/clk/sunxi/clk-factors.h b/drivers/clk/sunxi/clk-factors.h
index 7ea1379a7cda..f09d7c214533 100644
--- a/drivers/clk/sunxi/clk-factors.h
+++ b/drivers/clk/sunxi/clk-factors.h
@@ -19,12 +19,21 @@ struct clk_factors_config {
 	u8 n_start;
 };
 
+struct factors_request {
+	unsigned long rate;
+	unsigned long parent_rate;
+	u8 n;
+	u8 k;
+	u8 m;
+	u8 p;
+};
+
 struct factors_data {
 	int enable;
 	int mux;
 	int muxmask;
 	const struct clk_factors_config *table;
-	void (*getter) (u32 *rate, u32 parent_rate, u8 *n, u8 *k, u8 *m, u8 *p);
+	void (*getter)(struct factors_request *req);
 	const char *name;
 };
 
@@ -32,7 +41,7 @@ struct clk_factors {
 	struct clk_hw hw;
 	void __iomem *reg;
 	const struct clk_factors_config *config;
-	void (*get_factors) (u32 *rate, u32 parent, u8 *n, u8 *k, u8 *m, u8 *p);
+	void (*get_factors)(struct factors_request *req);
 	spinlock_t *lock;
 	/* for cleanup */
 	struct clk_mux *mux;
diff --git a/drivers/clk/sunxi/clk-mod0.c b/drivers/clk/sunxi/clk-mod0.c
index c67fea1a128d..578bff0dd251 100644
--- a/drivers/clk/sunxi/clk-mod0.c
+++ b/drivers/clk/sunxi/clk-mod0.c
@@ -28,17 +28,16 @@
  * rate = (parent_rate >> p) / (m + 1);
  */
 
-static void sun4i_a10_get_mod0_factors(u32 *freq, u32 parent_rate,
-				       u8 *n, u8 *k, u8 *m, u8 *p)
+static void sun4i_a10_get_mod0_factors(struct factors_request *req)
 {
 	u8 div, calcm, calcp;
 
 	/* These clocks can only divide, so we will never be able to achieve
 	 * frequencies higher than the parent frequency */
-	if (*freq > parent_rate)
-		*freq = parent_rate;
+	if (req->rate > req->parent_rate)
+		req->rate = req->parent_rate;
 
-	div = DIV_ROUND_UP(parent_rate, *freq);
+	div = DIV_ROUND_UP(req->parent_rate, req->rate);
 
 	if (div < 16)
 		calcp = 0;
@@ -51,14 +50,9 @@ static void sun4i_a10_get_mod0_factors(u32 *freq, u32 parent_rate,
 
 	calcm = DIV_ROUND_UP(div, 1 << calcp);
 
-	*freq = (parent_rate >> calcp) / calcm;
-
-	/* we were called to round the frequency, we can now return */
-	if (n == NULL)
-		return;
-
-	*m = calcm - 1;
-	*p = calcp;
+	req->rate = (req->parent_rate >> calcp) / calcm;
+	req->m = calcm - 1;
+	req->p = calcp;
 }
 
 /* user manual says "n" but it's really "p" */
diff --git a/drivers/clk/sunxi/clk-sun8i-mbus.c b/drivers/clk/sunxi/clk-sun8i-mbus.c
index bf117a636d23..78683f02a37d 100644
--- a/drivers/clk/sunxi/clk-sun8i-mbus.c
+++ b/drivers/clk/sunxi/clk-sun8i-mbus.c
@@ -26,8 +26,7 @@
  * rate = parent_rate / (m + 1);
  */
 
-static void sun8i_a23_get_mbus_factors(u32 *freq, u32 parent_rate,
-				       u8 *n, u8 *k, u8 *m, u8 *p)
+static void sun8i_a23_get_mbus_factors(struct factors_request *req)
 {
 	u8 div;
 
@@ -35,21 +34,16 @@ static void sun8i_a23_get_mbus_factors(u32 *freq, u32 parent_rate,
 	 * These clocks can only divide, so we will never be able to
 	 * achieve frequencies higher than the parent frequency
 	 */
-	if (*freq > parent_rate)
-		*freq = parent_rate;
+	if (req->rate > req->parent_rate)
+		req->rate = req->parent_rate;
 
-	div = DIV_ROUND_UP(parent_rate, *freq);
+	div = DIV_ROUND_UP(req->parent_rate, req->rate);
 
 	if (div > 8)
 		div = 8;
 
-	*freq = parent_rate / div;
-
-	/* we were called to round the frequency, we can now return */
-	if (m == NULL)
-		return;
-
-	*m = div - 1;
+	req->rate = req->parent_rate / div;
+	req->m = div - 1;
 }
 
 static struct clk_factors_config sun8i_a23_mbus_config = {
diff --git a/drivers/clk/sunxi/clk-sun9i-core.c b/drivers/clk/sunxi/clk-sun9i-core.c
index 37c85caaef88..a81211062ecb 100644
--- a/drivers/clk/sunxi/clk-sun9i-core.c
+++ b/drivers/clk/sunxi/clk-sun9i-core.c
@@ -32,15 +32,14 @@
  * p and m are named div1 and div2 in Allwinner's SDK
  */
 
-static void sun9i_a80_get_pll4_factors(u32 *freq, u32 parent_rate,
-				       u8 *n_ret, u8 *k, u8 *m_ret, u8 *p_ret)
+static void sun9i_a80_get_pll4_factors(struct factors_request *req)
 {
 	int n;
 	int m = 1;
 	int p = 1;
 
 	/* Normalize value to a 6 MHz multiple (24 MHz / 4) */
-	n = DIV_ROUND_UP(*freq, 6000000);
+	n = DIV_ROUND_UP(req->rate, 6000000);
 
 	/* If n is too large switch to steps of 12 MHz */
 	if (n > 255) {
@@ -60,15 +59,10 @@ static void sun9i_a80_get_pll4_factors(u32 *freq, u32 parent_rate,
 	else if (n < 12)
 		n = 12;
 
-	*freq = ((24000000 * n) >> p) / (m + 1);
-
-	/* we were called to round the frequency, we can now return */
-	if (n_ret == NULL)
-		return;
-
-	*n_ret = n;
-	*m_ret = m;
-	*p_ret = p;
+	req->rate = ((24000000 * n) >> p) / (m + 1);
+	req->n = n;
+	req->m = m;
+	req->p = p;
 }
 
 static const struct clk_factors_config sun9i_a80_pll4_config = {
@@ -111,27 +105,21 @@ CLK_OF_DECLARE(sun9i_a80_pll4, "allwinner,sun9i-a80-pll4-clk", sun9i_a80_pll4_se
  * rate = parent_rate / (m + 1);
  */
 
-static void sun9i_a80_get_gt_factors(u32 *freq, u32 parent_rate,
-				     u8 *n, u8 *k, u8 *m, u8 *p)
+static void sun9i_a80_get_gt_factors(struct factors_request *req)
 {
 	u32 div;
 
-	if (parent_rate < *freq)
-		*freq = parent_rate;
+	if (req->parent_rate < req->rate)
+		req->rate = req->parent_rate;
 
-	div = DIV_ROUND_UP(parent_rate, *freq);
+	div = DIV_ROUND_UP(req->parent_rate, req->rate);
 
 	/* maximum divider is 4 */
 	if (div > 4)
 		div = 4;
 
-	*freq = parent_rate / div;
-
-	/* we were called to round the frequency, we can now return */
-	if (!m)
-		return;
-
-	*m = div;
+	req->rate = req->parent_rate / div;
+	req->m = div;
 }
 
 static const struct clk_factors_config sun9i_a80_gt_config = {
@@ -176,27 +164,21 @@ CLK_OF_DECLARE(sun9i_a80_gt, "allwinner,sun9i-a80-gt-clk", sun9i_a80_gt_setup);
  * rate = parent_rate >> p;
  */
 
-static void sun9i_a80_get_ahb_factors(u32 *freq, u32 parent_rate,
-				      u8 *n, u8 *k, u8 *m, u8 *p)
+static void sun9i_a80_get_ahb_factors(struct factors_request *req)
 {
 	u32 _p;
 
-	if (parent_rate < *freq)
-		*freq = parent_rate;
+	if (req->parent_rate < req->rate)
+		req->rate = req->parent_rate;
 
-	_p = order_base_2(DIV_ROUND_UP(parent_rate, *freq));
+	_p = order_base_2(DIV_ROUND_UP(req->parent_rate, req->rate));
 
 	/* maximum p is 3 */
 	if (_p > 3)
 		_p = 3;
 
-	*freq = parent_rate >> _p;
-
-	/* we were called to round the frequency, we can now return */
-	if (!p)
-		return;
-
-	*p = _p;
+	req->rate = req->parent_rate >> _p;
+	req->p = _p;
 }
 
 static const struct clk_factors_config sun9i_a80_ahb_config = {
@@ -262,31 +244,22 @@ CLK_OF_DECLARE(sun9i_a80_apb0, "allwinner,sun9i-a80-apb0-clk", sun9i_a80_apb0_se
  * rate = (parent_rate >> p) / (m + 1);
  */
 
-static void sun9i_a80_get_apb1_factors(u32 *freq, u32 parent_rate,
-				       u8 *n, u8 *k, u8 *m, u8 *p)
+static void sun9i_a80_get_apb1_factors(struct factors_request *req)
 {
 	u32 div;
-	u8 calcm, calcp;
 
-	if (parent_rate < *freq)
-		*freq = parent_rate;
+	if (req->parent_rate < req->rate)
+		req->rate = req->parent_rate;
 
-	div = DIV_ROUND_UP(parent_rate, *freq);
+	div = DIV_ROUND_UP(req->parent_rate, req->rate);
 
 	/* Highest possible divider is 256 (p = 3, m = 31) */
 	if (div > 256)
 		div = 256;
 
-	calcp = order_base_2(div);
-	calcm = (parent_rate >> calcp) - 1;
-	*freq = (parent_rate >> calcp) / (calcm + 1);
-
-	/* we were called to round the frequency, we can now return */
-	if (n == NULL)
-		return;
-
-	*m = calcm;
-	*p = calcp;
+	req->p = order_base_2(div);
+	req->m = (req->parent_rate >> req->p) - 1;
+	req->rate = (req->parent_rate >> req->p) / (req->m + 1);
 }
 
 static const struct clk_factors_config sun9i_a80_apb1_config = {
diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index 5dd927859bc2..56d4fdcf9c89 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -246,49 +246,45 @@ CLK_OF_DECLARE(sun6i_a31_ahb1, "allwinner,sun6i-a31-ahb1-clk", sun6i_ahb1_clk_se
  * parent_rate is always 24Mhz
  */
 
-static void sun4i_get_pll1_factors(u32 *freq, u32 parent_rate,
-				   u8 *n, u8 *k, u8 *m, u8 *p)
+static void sun4i_get_pll1_factors(struct factors_request *req)
 {
 	u8 div;
 
 	/* Normalize value to a 6M multiple */
-	div = *freq / 6000000;
-	*freq = 6000000 * div;
-
-	/* we were called to round the frequency, we can now return */
-	if (n == NULL)
-		return;
+	div = req->rate / 6000000;
+	req->rate = 6000000 * div;
 
 	/* m is always zero for pll1 */
-	*m = 0;
+	req->m = 0;
 
 	/* k is 1 only on these cases */
-	if (*freq >= 768000000 || *freq == 42000000 || *freq == 54000000)
-		*k = 1;
+	if (req->rate >= 768000000 || req->rate == 42000000 ||
+			req->rate == 54000000)
+		req->k = 1;
 	else
-		*k = 0;
+		req->k = 0;
 
 	/* p will be 3 for divs under 10 */
 	if (div < 10)
-		*p = 3;
+		req->p = 3;
 
 	/* p will be 2 for divs between 10 - 20 and odd divs under 32 */
 	else if (div < 20 || (div < 32 && (div & 1)))
-		*p = 2;
+		req->p = 2;
 
 	/* p will be 1 for even divs under 32, divs under 40 and odd pairs
 	 * of divs between 40-62 */
 	else if (div < 40 || (div < 64 && (div & 2)))
-		*p = 1;
+		req->p = 1;
 
 	/* any other entries have p = 0 */
 	else
-		*p = 0;
+		req->p = 0;
 
 	/* calculate a suitable n based on k and p */
-	div <<= *p;
-	div /= (*k + 1);
-	*n = div / 4;
+	div <<= req->p;
+	div /= (req->k + 1);
+	req->n = div / 4;
 }
 
 /**
@@ -297,15 +293,14 @@ static void sun4i_get_pll1_factors(u32 *freq, u32 parent_rate,
  * rate = parent_rate * (n + 1) * (k + 1) / (m + 1);
  * parent_rate should always be 24MHz
  */
-static void sun6i_a31_get_pll1_factors(u32 *freq, u32 parent_rate,
-				       u8 *n, u8 *k, u8 *m, u8 *p)
+static void sun6i_a31_get_pll1_factors(struct factors_request *req)
 {
 	/*
 	 * We can operate only on MHz, this will make our life easier
 	 * later.
 	 */
-	u32 freq_mhz = *freq / 1000000;
-	u32 parent_freq_mhz = parent_rate / 1000000;
+	u32 freq_mhz = req->rate / 1000000;
+	u32 parent_freq_mhz = req->parent_rate / 1000000;
 
 	/*
 	 * Round down the frequency to the closest multiple of either
@@ -319,28 +314,20 @@ static void sun6i_a31_get_pll1_factors(u32 *freq, u32 parent_rate,
 	else
 		freq_mhz = round_freq_16;
 
-	*freq = freq_mhz * 1000000;
-
-	/*
-	 * If the factors pointer are null, we were just called to
-	 * round down the frequency.
-	 * Exit.
-	 */
-	if (n == NULL)
-		return;
+	req->rate = freq_mhz * 1000000;
 
 	/* If the frequency is a multiple of 32 MHz, k is always 3 */
 	if (!(freq_mhz % 32))
-		*k = 3;
+		req->k = 3;
 	/* If the frequency is a multiple of 9 MHz, k is always 2 */
 	else if (!(freq_mhz % 9))
-		*k = 2;
+		req->k = 2;
 	/* If the frequency is a multiple of 8 MHz, k is always 1 */
 	else if (!(freq_mhz % 8))
-		*k = 1;
+		req->k = 1;
 	/* Otherwise, we don't use the k factor */
 	else
-		*k = 0;
+		req->k = 0;
 
 	/*
 	 * If the frequency is a multiple of 2 but not a multiple of
@@ -351,27 +338,28 @@ static void sun6i_a31_get_pll1_factors(u32 *freq, u32 parent_rate,
 	 * somehow relates to this frequency.
 	 */
 	if ((freq_mhz % 6) == 2 || (freq_mhz % 6) == 4)
-		*m = 2;
+		req->m = 2;
 	/*
 	 * If the frequency is a multiple of 6MHz, but the factor is
 	 * odd, m will be 3
 	 */
 	else if ((freq_mhz / 6) & 1)
-		*m = 3;
+		req->m = 3;
 	/* Otherwise, we end up with m = 1 */
 	else
-		*m = 1;
+		req->m = 1;
 
 	/* Calculate n thanks to the above factors we already got */
-	*n = freq_mhz * (*m + 1) / ((*k + 1) * parent_freq_mhz) - 1;
+	req->n = freq_mhz * (req->m + 1) / ((req->k + 1) * parent_freq_mhz)
+		 - 1;
 
 	/*
 	 * If n end up being outbound, and that we can still decrease
 	 * m, do it.
 	 */
-	if ((*n + 1) > 31 && (*m + 1) > 1) {
-		*n = (*n + 1) / 2 - 1;
-		*m = (*m + 1) / 2 - 1;
+	if ((req->n + 1) > 31 && (req->m + 1) > 1) {
+		req->n = (req->n + 1) / 2 - 1;
+		req->m = (req->m + 1) / 2 - 1;
 	}
 }
 
@@ -382,45 +370,41 @@ static void sun6i_a31_get_pll1_factors(u32 *freq, u32 parent_rate,
  * parent_rate is always 24Mhz
  */
 
-static void sun8i_a23_get_pll1_factors(u32 *freq, u32 parent_rate,
-				   u8 *n, u8 *k, u8 *m, u8 *p)
+static void sun8i_a23_get_pll1_factors(struct factors_request *req)
 {
 	u8 div;
 
 	/* Normalize value to a 6M multiple */
-	div = *freq / 6000000;
-	*freq = 6000000 * div;
-
-	/* we were called to round the frequency, we can now return */
-	if (n == NULL)
-		return;
+	div = req->rate / 6000000;
+	req->rate = 6000000 * div;
 
 	/* m is always zero for pll1 */
-	*m = 0;
+	req->m = 0;
 
 	/* k is 1 only on these cases */
-	if (*freq >= 768000000 || *freq == 42000000 || *freq == 54000000)
-		*k = 1;
+	if (req->rate >= 768000000 || req->rate == 42000000 ||
+			req->rate == 54000000)
+		req->k = 1;
 	else
-		*k = 0;
+		req->k = 0;
 
 	/* p will be 2 for divs under 20 and odd divs under 32 */
 	if (div < 20 || (div < 32 && (div & 1)))
-		*p = 2;
+		req->p = 2;
 
 	/* p will be 1 for even divs under 32, divs under 40 and odd pairs
 	 * of divs between 40-62 */
 	else if (div < 40 || (div < 64 && (div & 2)))
-		*p = 1;
+		req->p = 1;
 
 	/* any other entries have p = 0 */
 	else
-		*p = 0;
+		req->p = 0;
 
 	/* calculate a suitable n based on k and p */
-	div <<= *p;
-	div /= (*k + 1);
-	*n = div / 4 - 1;
+	div <<= req->p;
+	div /= (req->k + 1);
+	req->n = div / 4 - 1;
 }
 
 /**
@@ -430,29 +414,24 @@ static void sun8i_a23_get_pll1_factors(u32 *freq, u32 parent_rate,
  * parent_rate is always 24Mhz
  */
 
-static void sun4i_get_pll5_factors(u32 *freq, u32 parent_rate,
-				   u8 *n, u8 *k, u8 *m, u8 *p)
+static void sun4i_get_pll5_factors(struct factors_request *req)
 {
 	u8 div;
 
 	/* Normalize value to a parent_rate multiple (24M) */
-	div = *freq / parent_rate;
-	*freq = parent_rate * div;
-
-	/* we were called to round the frequency, we can now return */
-	if (n == NULL)
-		return;
+	div = req->rate / req->parent_rate;
+	req->rate = req->parent_rate * div;
 
 	if (div < 31)
-		*k = 0;
+		req->k = 0;
 	else if (div / 2 < 31)
-		*k = 1;
+		req->k = 1;
 	else if (div / 3 < 31)
-		*k = 2;
+		req->k = 2;
 	else
-		*k = 3;
+		req->k = 3;
 
-	*n = DIV_ROUND_UP(div, (*k+1));
+	req->n = DIV_ROUND_UP(div, (req->k + 1));
 }
 
 /**
@@ -462,24 +441,19 @@ static void sun4i_get_pll5_factors(u32 *freq, u32 parent_rate,
  * parent_rate is always 24Mhz
  */
 
-static void sun6i_a31_get_pll6_factors(u32 *freq, u32 parent_rate,
-				       u8 *n, u8 *k, u8 *m, u8 *p)
+static void sun6i_a31_get_pll6_factors(struct factors_request *req)
 {
 	u8 div;
 
 	/* Normalize value to a parent_rate multiple (24M) */
-	div = *freq / parent_rate;
-	*freq = parent_rate * div;
+	div = req->rate / req->parent_rate;
+	req->rate = req->parent_rate * div;
 
-	/* we were called to round the frequency, we can now return */
-	if (n == NULL)
-		return;
-
-	*k = div / 32;
-	if (*k > 3)
-		*k = 3;
+	req->k = div / 32;
+	if (req->k > 3)
+		req->k = 3;
 
-	*n = DIV_ROUND_UP(div, (*k+1)) - 1;
+	req->n = DIV_ROUND_UP(div, (req->k + 1)) - 1;
 }
 
 /**
@@ -488,37 +462,32 @@ static void sun6i_a31_get_pll6_factors(u32 *freq, u32 parent_rate,
  * rate = parent_rate >> p
  */
 
-static void sun5i_a13_get_ahb_factors(u32 *freq, u32 parent_rate,
-				       u8 *n, u8 *k, u8 *m, u8 *p)
+static void sun5i_a13_get_ahb_factors(struct factors_request *req)
 {
 	u32 div;
 
 	/* divide only */
-	if (parent_rate < *freq)
-		*freq = parent_rate;
+	if (req->parent_rate < req->rate)
+		req->rate = req->parent_rate;
 
 	/*
 	 * user manual says valid speed is 8k ~ 276M, but tests show it
 	 * can work at speeds up to 300M, just after reparenting to pll6
 	 */
-	if (*freq < 8000)
-		*freq = 8000;
-	if (*freq > 300000000)
-		*freq = 300000000;
+	if (req->rate < 8000)
+		req->rate = 8000;
+	if (req->rate > 300000000)
+		req->rate = 300000000;
 
-	div = order_base_2(DIV_ROUND_UP(parent_rate, *freq));
+	div = order_base_2(DIV_ROUND_UP(req->parent_rate, req->rate));
 
 	/* p = 0 ~ 3 */
 	if (div > 3)
 		div = 3;
 
-	*freq = parent_rate >> div;
+	req->rate = req->parent_rate >> div;
 
-	/* we were called to round the frequency, we can now return */
-	if (p == NULL)
-		return;
-
-	*p = div;
+	req->p = div;
 }
 
 /**
@@ -527,39 +496,34 @@ static void sun5i_a13_get_ahb_factors(u32 *freq, u32 parent_rate,
  * rate = (parent_rate >> p) / (m + 1);
  */
 
-static void sun4i_get_apb1_factors(u32 *freq, u32 parent_rate,
-				   u8 *n, u8 *k, u8 *m, u8 *p)
+static void sun4i_get_apb1_factors(struct factors_request *req)
 {
 	u8 calcm, calcp;
+	int div;
 
-	if (parent_rate < *freq)
-		*freq = parent_rate;
+	if (req->parent_rate < req->rate)
+		req->rate = req->parent_rate;
 
-	parent_rate = DIV_ROUND_UP(parent_rate, *freq);
+	div = DIV_ROUND_UP(req->parent_rate, req->rate);
 
 	/* Invalid rate! */
-	if (parent_rate > 32)
+	if (div > 32)
 		return;
 
-	if (parent_rate <= 4)
+	if (div <= 4)
 		calcp = 0;
-	else if (parent_rate <= 8)
+	else if (div <= 8)
 		calcp = 1;
-	else if (parent_rate <= 16)
+	else if (div <= 16)
 		calcp = 2;
 	else
 		calcp = 3;
 
-	calcm = (parent_rate >> calcp) - 1;
-
-	*freq = (parent_rate >> calcp) / (calcm + 1);
+	calcm = (req->parent_rate >> calcp) - 1;
 
-	/* we were called to round the frequency, we can now return */
-	if (n == NULL)
-		return;
-
-	*m = calcm;
-	*p = calcp;
+	req->rate = (req->parent_rate >> calcp) / (calcm + 1);
+	req->m = calcm;
+	req->p = calcp;
 }
 
 
@@ -571,17 +535,16 @@ static void sun4i_get_apb1_factors(u32 *freq, u32 parent_rate,
  * rate = (parent_rate >> p) / (m + 1);
  */
 
-static void sun7i_a20_get_out_factors(u32 *freq, u32 parent_rate,
-				      u8 *n, u8 *k, u8 *m, u8 *p)
+static void sun7i_a20_get_out_factors(struct factors_request *req)
 {
 	u8 div, calcm, calcp;
 
 	/* These clocks can only divide, so we will never be able to achieve
 	 * frequencies higher than the parent frequency */
-	if (*freq > parent_rate)
-		*freq = parent_rate;
+	if (req->rate > req->parent_rate)
+		req->rate = req->parent_rate;
 
-	div = DIV_ROUND_UP(parent_rate, *freq);
+	div = DIV_ROUND_UP(req->parent_rate, req->rate);
 
 	if (div < 32)
 		calcp = 0;
@@ -594,14 +557,9 @@ static void sun7i_a20_get_out_factors(u32 *freq, u32 parent_rate,
 
 	calcm = DIV_ROUND_UP(div, 1 << calcp);
 
-	*freq = (parent_rate >> calcp) / calcm;
-
-	/* we were called to round the frequency, we can now return */
-	if (n == NULL)
-		return;
-
-	*m = calcm - 1;
-	*p = calcp;
+	req->rate = (req->parent_rate >> calcp) / calcm;
+	req->m = calcm - 1;
+	req->p = calcp;
 }
 
 /**
-- 
2.7.0
