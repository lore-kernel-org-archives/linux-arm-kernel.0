From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 20 Jan 2017 08:29:42 +0100
Subject: [PATCH v3 2/7] clk: sunxi-ng: Implement factors offsets
In-Reply-To: <cover.5df5469d9c7a6233e225a875dca513a03b05e871.1484897383.git-series.maxime.ripard@free-electrons.com>
References: <cover.5df5469d9c7a6233e225a875dca513a03b05e871.1484897383.git-series.maxime.ripard@free-electrons.com>
Message-ID: <b9898625b5a71d5d9e1ae00e5c8ce97219359849.1484897383.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The factors we've seen so far all had an offset of one. However, on the
earlier Allwinner SoCs, some factors could have no offset at all, meaning
that the value computed to reach the rate we want to use was the one we had
to program in the registers.

Implement an additional field for the factors that can have such an offset
(linears, not based on a power of two) to specify that offset.

This offset is not linked to the extremums that can be specified in those
structures too. The minimum and maximum are representing the range of
values we can use to try to compute the best rate. The offset comes later
on when we want to set the best value in the registers.

Acked-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/clk/sunxi-ng/ccu_div.h  | 10 +++++++++-
 drivers/clk/sunxi-ng/ccu_mp.c   | 10 +++++++---
 drivers/clk/sunxi-ng/ccu_mult.c |  6 +++---
 drivers/clk/sunxi-ng/ccu_mult.h | 20 ++++++++++++++------
 drivers/clk/sunxi-ng/ccu_nk.c   | 14 ++++++++++----
 drivers/clk/sunxi-ng/ccu_nkm.c  | 18 +++++++++++++-----
 drivers/clk/sunxi-ng/ccu_nkmp.c | 17 +++++++++++++----
 drivers/clk/sunxi-ng/ccu_nm.c   | 13 ++++++++++---
 8 files changed, 79 insertions(+), 29 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu_div.h b/drivers/clk/sunxi-ng/ccu_div.h
index 06540f7cf41c..08d074451204 100644
--- a/drivers/clk/sunxi-ng/ccu_div.h
+++ b/drivers/clk/sunxi-ng/ccu_div.h
@@ -41,6 +41,7 @@ struct ccu_div_internal {
 	u8			width;
 
 	u32			max;
+	u32			offset;
 
 	u32			flags;
 
@@ -58,20 +59,27 @@ struct ccu_div_internal {
 #define _SUNXI_CCU_DIV_TABLE(_shift, _width, _table)			\
 	_SUNXI_CCU_DIV_TABLE_FLAGS(_shift, _width, _table, 0)
 
-#define _SUNXI_CCU_DIV_MAX_FLAGS(_shift, _width, _max, _flags) \
+#define _SUNXI_CCU_DIV_OFFSET_MAX_FLAGS(_shift, _width, _off, _max, _flags) \
 	{								\
 		.shift	= _shift,					\
 		.width	= _width,					\
 		.flags	= _flags,					\
 		.max	= _max,						\
+		.offset	= _off,						\
 	}
 
+#define _SUNXI_CCU_DIV_MAX_FLAGS(_shift, _width, _max, _flags)		\
+	_SUNXI_CCU_DIV_OFFSET_MAX_FLAGS(_shift, _width, 1, _max, _flags)
+
 #define _SUNXI_CCU_DIV_FLAGS(_shift, _width, _flags)			\
 	_SUNXI_CCU_DIV_MAX_FLAGS(_shift, _width, 0, _flags)
 
 #define _SUNXI_CCU_DIV_MAX(_shift, _width, _max)			\
 	_SUNXI_CCU_DIV_MAX_FLAGS(_shift, _width, _max, 0)
 
+#define _SUNXI_CCU_DIV_OFFSET(_shift, _width, _offset)			\
+	_SUNXI_CCU_DIV_OFFSET_MAX_FLAGS(_shift, _width, _offset, 0, 0)
+
 #define _SUNXI_CCU_DIV(_shift, _width)					\
 	_SUNXI_CCU_DIV_FLAGS(_shift, _width, 0)
 
diff --git a/drivers/clk/sunxi-ng/ccu_mp.c b/drivers/clk/sunxi-ng/ccu_mp.c
index ebb1b31568a5..22c2ca7a2a22 100644
--- a/drivers/clk/sunxi-ng/ccu_mp.c
+++ b/drivers/clk/sunxi-ng/ccu_mp.c
@@ -89,11 +89,14 @@ static unsigned long ccu_mp_recalc_rate(struct clk_hw *hw,
 
 	m = reg >> cmp->m.shift;
 	m &= (1 << cmp->m.width) - 1;
+	m += cmp->m.offset;
+	if (!m)
+		m++;
 
 	p = reg >> cmp->p.shift;
 	p &= (1 << cmp->p.width) - 1;
 
-	return (parent_rate >> p) / (m + 1);
+	return (parent_rate >> p) / m;
 }
 
 static int ccu_mp_determine_rate(struct clk_hw *hw,
@@ -124,9 +127,10 @@ static int ccu_mp_set_rate(struct clk_hw *hw, unsigned long rate,
 	reg = readl(cmp->common.base + cmp->common.reg);
 	reg &= ~GENMASK(cmp->m.width + cmp->m.shift - 1, cmp->m.shift);
 	reg &= ~GENMASK(cmp->p.width + cmp->p.shift - 1, cmp->p.shift);
+	reg |= (m - cmp->m.offset) << cmp->m.shift;
+	reg |= ilog2(p) << cmp->p.shift;
 
-	writel(reg | (ilog2(p) << cmp->p.shift) | ((m - 1) << cmp->m.shift),
-	       cmp->common.base + cmp->common.reg);
+	writel(reg, cmp->common.base + cmp->common.reg);
 
 	spin_unlock_irqrestore(cmp->common.lock, flags);
 
diff --git a/drivers/clk/sunxi-ng/ccu_mult.c b/drivers/clk/sunxi-ng/ccu_mult.c
index 826302464650..8b7ee7baa85b 100644
--- a/drivers/clk/sunxi-ng/ccu_mult.c
+++ b/drivers/clk/sunxi-ng/ccu_mult.c
@@ -85,7 +85,7 @@ static unsigned long ccu_mult_recalc_rate(struct clk_hw *hw,
 	ccu_mux_helper_adjust_parent_for_prediv(&cm->common, &cm->mux, -1,
 						&parent_rate);
 
-	return parent_rate * (val + 1);
+	return parent_rate * (val + cm->mult.offset);
 }
 
 static int ccu_mult_determine_rate(struct clk_hw *hw,
@@ -121,9 +121,9 @@ static int ccu_mult_set_rate(struct clk_hw *hw, unsigned long rate,
 
 	reg = readl(cm->common.base + cm->common.reg);
 	reg &= ~GENMASK(cm->mult.width + cm->mult.shift - 1, cm->mult.shift);
+	reg |= ((_cm.mult - cm->mult.offset) << cm->mult.shift);
 
-	writel(reg | ((_cm.mult - 1) << cm->mult.shift),
-	       cm->common.base + cm->common.reg);
+	writel(reg, cm->common.base + cm->common.reg);
 
 	spin_unlock_irqrestore(cm->common.lock, flags);
 
diff --git a/drivers/clk/sunxi-ng/ccu_mult.h b/drivers/clk/sunxi-ng/ccu_mult.h
index bd2e38b5a32a..84839641dfdf 100644
--- a/drivers/clk/sunxi-ng/ccu_mult.h
+++ b/drivers/clk/sunxi-ng/ccu_mult.h
@@ -6,20 +6,28 @@
 #include "ccu_mux.h"
 
 struct ccu_mult_internal {
+	u8	offset;
 	u8	shift;
 	u8	width;
 	u8	min;
 };
 
-#define _SUNXI_CCU_MULT_MIN(_shift, _width, _min)	\
-	{						\
-		.shift	= _shift,			\
-		.width	= _width,			\
-		.min	= _min,				\
+#define _SUNXI_CCU_MULT_OFFSET_MIN(_shift, _width, _offset, _min)	\
+	{								\
+		.min	= _min,						\
+		.offset	= _offset,					\
+		.shift	= _shift,					\
+		.width	= _width,					\
 	}
 
+#define _SUNXI_CCU_MULT_MIN(_shift, _width, _min)	\
+	_SUNXI_CCU_MULT_OFFSET_MIN(_shift, _width, 1, _min)
+
+#define _SUNXI_CCU_MULT_OFFSET(_shift, _width, _offset)	\
+	_SUNXI_CCU_MULT_OFFSET_MIN(_shift, _width, _offset, 1)
+
 #define _SUNXI_CCU_MULT(_shift, _width)		\
-	_SUNXI_CCU_MULT_MIN(_shift, _width, 1)
+	_SUNXI_CCU_MULT_OFFSET_MIN(_shift, _width, 1, 1)
 
 struct ccu_mult {
 	u32			enable;
diff --git a/drivers/clk/sunxi-ng/ccu_nk.c b/drivers/clk/sunxi-ng/ccu_nk.c
index eaf0fdf78d2b..90117d3ead8c 100644
--- a/drivers/clk/sunxi-ng/ccu_nk.c
+++ b/drivers/clk/sunxi-ng/ccu_nk.c
@@ -76,12 +76,17 @@ static unsigned long ccu_nk_recalc_rate(struct clk_hw *hw,
 
 	n = reg >> nk->n.shift;
 	n &= (1 << nk->n.width) - 1;
+	n += nk->n.offset;
+	if (!n)
+		n++;
 
 	k = reg >> nk->k.shift;
 	k &= (1 << nk->k.width) - 1;
+	k += nk->k.offset;
+	if (!k)
+		k++;
 
-	rate = parent_rate * (n + 1) * (k + 1);
-
+	rate = parent_rate * n * k;
 	if (nk->common.features & CCU_FEATURE_FIXED_POSTDIV)
 		rate /= nk->fixed_post_div;
 
@@ -135,8 +140,9 @@ static int ccu_nk_set_rate(struct clk_hw *hw, unsigned long rate,
 	reg &= ~GENMASK(nk->n.width + nk->n.shift - 1, nk->n.shift);
 	reg &= ~GENMASK(nk->k.width + nk->k.shift - 1, nk->k.shift);
 
-	writel(reg | ((_nk.k - 1) << nk->k.shift) | ((_nk.n - 1) << nk->n.shift),
-	       nk->common.base + nk->common.reg);
+	reg |= (_nk.k - nk->k.offset) << nk->k.shift;
+	reg |= (_nk.n - nk->n.offset) << nk->n.shift;
+	writel(reg, nk->common.base + nk->common.reg);
 
 	spin_unlock_irqrestore(nk->common.lock, flags);
 
diff --git a/drivers/clk/sunxi-ng/ccu_nkm.c b/drivers/clk/sunxi-ng/ccu_nkm.c
index 9b840a47a94d..3caaf9d603e2 100644
--- a/drivers/clk/sunxi-ng/ccu_nkm.c
+++ b/drivers/clk/sunxi-ng/ccu_nkm.c
@@ -82,14 +82,23 @@ static unsigned long ccu_nkm_recalc_rate(struct clk_hw *hw,
 
 	n = reg >> nkm->n.shift;
 	n &= (1 << nkm->n.width) - 1;
+	n += nkm->n.offset;
+	if (!n)
+		n++;
 
 	k = reg >> nkm->k.shift;
 	k &= (1 << nkm->k.width) - 1;
+	k += nkm->k.offset;
+	if (!k)
+		k++;
 
 	m = reg >> nkm->m.shift;
 	m &= (1 << nkm->m.width) - 1;
+	m += nkm->m.offset;
+	if (!m)
+		m++;
 
-	return parent_rate * (n + 1) * (k + 1) / (m + 1);
+	return parent_rate * n  * k / m;
 }
 
 static unsigned long ccu_nkm_round_rate(struct ccu_mux_internal *mux,
@@ -145,10 +154,9 @@ static int ccu_nkm_set_rate(struct clk_hw *hw, unsigned long rate,
 	reg &= ~GENMASK(nkm->k.width + nkm->k.shift - 1, nkm->k.shift);
 	reg &= ~GENMASK(nkm->m.width + nkm->m.shift - 1, nkm->m.shift);
 
-	reg |= (_nkm.n - 1) << nkm->n.shift;
-	reg |= (_nkm.k - 1) << nkm->k.shift;
-	reg |= (_nkm.m - 1) << nkm->m.shift;
-
+	reg |= (_nkm.n - nkm->n.offset) << nkm->n.shift;
+	reg |= (_nkm.k - nkm->k.offset) << nkm->k.shift;
+	reg |= (_nkm.m - nkm->m.offset) << nkm->m.shift;
 	writel(reg, nkm->common.base + nkm->common.reg);
 
 	spin_unlock_irqrestore(nkm->common.lock, flags);
diff --git a/drivers/clk/sunxi-ng/ccu_nkmp.c b/drivers/clk/sunxi-ng/ccu_nkmp.c
index 684c42da3ebb..da2bba02b845 100644
--- a/drivers/clk/sunxi-ng/ccu_nkmp.c
+++ b/drivers/clk/sunxi-ng/ccu_nkmp.c
@@ -88,17 +88,26 @@ static unsigned long ccu_nkmp_recalc_rate(struct clk_hw *hw,
 
 	n = reg >> nkmp->n.shift;
 	n &= (1 << nkmp->n.width) - 1;
+	n += nkmp->n.offset;
+	if (!n)
+		n++;
 
 	k = reg >> nkmp->k.shift;
 	k &= (1 << nkmp->k.width) - 1;
+	k += nkmp->k.offset;
+	if (!k)
+		k++;
 
 	m = reg >> nkmp->m.shift;
 	m &= (1 << nkmp->m.width) - 1;
+	m += nkmp->m.offset;
+	if (!m)
+		m++;
 
 	p = reg >> nkmp->p.shift;
 	p &= (1 << nkmp->p.width) - 1;
 
-	return (parent_rate * (n + 1) * (k + 1) >> p) / (m + 1);
+	return parent_rate * n * k >> p / m;
 }
 
 static long ccu_nkmp_round_rate(struct clk_hw *hw, unsigned long rate,
@@ -148,9 +157,9 @@ static int ccu_nkmp_set_rate(struct clk_hw *hw, unsigned long rate,
 	reg &= ~GENMASK(nkmp->m.width + nkmp->m.shift - 1, nkmp->m.shift);
 	reg &= ~GENMASK(nkmp->p.width + nkmp->p.shift - 1, nkmp->p.shift);
 
-	reg |= (_nkmp.n - 1) << nkmp->n.shift;
-	reg |= (_nkmp.k - 1) << nkmp->k.shift;
-	reg |= (_nkmp.m - 1) << nkmp->m.shift;
+	reg |= (_nkmp.n - nkmp->n.offset) << nkmp->n.shift;
+	reg |= (_nkmp.k - nkmp->k.offset) << nkmp->k.shift;
+	reg |= (_nkmp.m - nkmp->m.offset) << nkmp->m.shift;
 	reg |= ilog2(_nkmp.p) << nkmp->p.shift;
 
 	writel(reg, nkmp->common.base + nkmp->common.reg);
diff --git a/drivers/clk/sunxi-ng/ccu_nm.c b/drivers/clk/sunxi-ng/ccu_nm.c
index c9f3b6c982f0..158d74e0215f 100644
--- a/drivers/clk/sunxi-ng/ccu_nm.c
+++ b/drivers/clk/sunxi-ng/ccu_nm.c
@@ -80,11 +80,17 @@ static unsigned long ccu_nm_recalc_rate(struct clk_hw *hw,
 
 	n = reg >> nm->n.shift;
 	n &= (1 << nm->n.width) - 1;
+	n += nm->n.offset;
+	if (!n)
+		n++;
 
 	m = reg >> nm->m.shift;
 	m &= (1 << nm->m.width) - 1;
+	m += nm->m.offset;
+	if (!m)
+		m++;
 
-	return parent_rate * (n + 1) / (m + 1);
+	return parent_rate * n / m;
 }
 
 static long ccu_nm_round_rate(struct clk_hw *hw, unsigned long rate,
@@ -129,8 +135,9 @@ static int ccu_nm_set_rate(struct clk_hw *hw, unsigned long rate,
 	reg &= ~GENMASK(nm->n.width + nm->n.shift - 1, nm->n.shift);
 	reg &= ~GENMASK(nm->m.width + nm->m.shift - 1, nm->m.shift);
 
-	writel(reg | ((_nm.m - 1) << nm->m.shift) | ((_nm.n - 1) << nm->n.shift),
-	       nm->common.base + nm->common.reg);
+	reg |= (_nm.n - nm->n.offset) << nm->n.shift;
+	reg |= (_nm.m - nm->m.offset) << nm->m.shift;
+	writel(reg, nm->common.base + nm->common.reg);
 
 	spin_unlock_irqrestore(nm->common.lock, flags);
 
-- 
git-series 0.8.11
