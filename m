From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 21 Jan 2017 23:50:53 +0100
Subject: [PATCH v4 4/8] clk: sunxi-ng: Implement multiplier maximum
In-Reply-To: <cover.04f797fe015b05f19b1d69d0650680baffb27055.1485039043.git-series.maxime.ripard@free-electrons.com>
References: <cover.04f797fe015b05f19b1d69d0650680baffb27055.1485039043.git-series.maxime.ripard@free-electrons.com>
Message-ID: <7a5f5e18402332c89e83a9aad634991a6baa89d5.1485039043.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some multipliers have a maximum rate that is lower than what the register
width allows to. Add a field in the multiplier structure to allow CCU
driver to set that maximum.

Acked-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/clk/sunxi-ng/ccu_mult.c | 14 ++++++++++++--
 drivers/clk/sunxi-ng/ccu_mult.h | 10 ++++++----
 drivers/clk/sunxi-ng/ccu_nk.c   |  8 ++++----
 drivers/clk/sunxi-ng/ccu_nkm.c  |  8 ++++----
 drivers/clk/sunxi-ng/ccu_nkmp.c |  8 ++++----
 drivers/clk/sunxi-ng/ccu_nm.c   |  4 ++--
 6 files changed, 32 insertions(+), 20 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu_mult.c b/drivers/clk/sunxi-ng/ccu_mult.c
index a52162195e07..8724c01171b1 100644
--- a/drivers/clk/sunxi-ng/ccu_mult.c
+++ b/drivers/clk/sunxi-ng/ccu_mult.c
@@ -41,7 +41,12 @@ static unsigned long ccu_mult_round_rate(struct ccu_mux_internal *mux,
 	struct _ccu_mult _cm;
 
 	_cm.min = cm->mult.min;
-	_cm.max = 1 << cm->mult.width;
+
+	if (cm->mult.max)
+		_cm.max = cm->mult.max;
+	else
+		_cm.max = (1 << cm->mult.width) + cm->mult.offset - 1;
+
 	ccu_mult_find_best(parent_rate, rate, &_cm);
 
 	return parent_rate * _cm.mult;
@@ -114,7 +119,12 @@ static int ccu_mult_set_rate(struct clk_hw *hw, unsigned long rate,
 						&parent_rate);
 
 	_cm.min = cm->mult.min;
-	_cm.max = 1 << cm->mult.width;
+
+	if (cm->mult.max)
+		_cm.max = cm->mult.max;
+	else
+		_cm.max = (1 << cm->mult.width) + cm->mult.offset - 1;
+
 	ccu_mult_find_best(parent_rate, rate, &_cm);
 
 	spin_lock_irqsave(cm->common.lock, flags);
diff --git a/drivers/clk/sunxi-ng/ccu_mult.h b/drivers/clk/sunxi-ng/ccu_mult.h
index 84839641dfdf..524acddfcb2e 100644
--- a/drivers/clk/sunxi-ng/ccu_mult.h
+++ b/drivers/clk/sunxi-ng/ccu_mult.h
@@ -10,24 +10,26 @@ struct ccu_mult_internal {
 	u8	shift;
 	u8	width;
 	u8	min;
+	u8	max;
 };
 
-#define _SUNXI_CCU_MULT_OFFSET_MIN(_shift, _width, _offset, _min)	\
+#define _SUNXI_CCU_MULT_OFFSET_MIN_MAX(_shift, _width, _offset, _min, _max) \
 	{								\
 		.min	= _min,						\
+		.max	= _max,						\
 		.offset	= _offset,					\
 		.shift	= _shift,					\
 		.width	= _width,					\
 	}
 
 #define _SUNXI_CCU_MULT_MIN(_shift, _width, _min)	\
-	_SUNXI_CCU_MULT_OFFSET_MIN(_shift, _width, 1, _min)
+	_SUNXI_CCU_MULT_OFFSET_MIN_MAX(_shift, _width, 1, _min, 0)
 
 #define _SUNXI_CCU_MULT_OFFSET(_shift, _width, _offset)	\
-	_SUNXI_CCU_MULT_OFFSET_MIN(_shift, _width, _offset, 1)
+	_SUNXI_CCU_MULT_OFFSET_MIN_MAX(_shift, _width, _offset, 1, 0)
 
 #define _SUNXI_CCU_MULT(_shift, _width)		\
-	_SUNXI_CCU_MULT_OFFSET_MIN(_shift, _width, 1, 1)
+	_SUNXI_CCU_MULT_OFFSET_MIN_MAX(_shift, _width, 1, 1, 0)
 
 struct ccu_mult {
 	u32			enable;
diff --git a/drivers/clk/sunxi-ng/ccu_nk.c b/drivers/clk/sunxi-ng/ccu_nk.c
index 90117d3ead8c..b9e9b8a9d1b4 100644
--- a/drivers/clk/sunxi-ng/ccu_nk.c
+++ b/drivers/clk/sunxi-ng/ccu_nk.c
@@ -103,9 +103,9 @@ static long ccu_nk_round_rate(struct clk_hw *hw, unsigned long rate,
 		rate *= nk->fixed_post_div;
 
 	_nk.min_n = nk->n.min;
-	_nk.max_n = 1 << nk->n.width;
+	_nk.max_n = nk->n.max ?: 1 << nk->n.width;
 	_nk.min_k = nk->k.min;
-	_nk.max_k = 1 << nk->k.width;
+	_nk.max_k = nk->k.max ?: 1 << nk->k.width;
 
 	ccu_nk_find_best(*parent_rate, rate, &_nk);
 	rate = *parent_rate * _nk.n * _nk.k;
@@ -128,9 +128,9 @@ static int ccu_nk_set_rate(struct clk_hw *hw, unsigned long rate,
 		rate = rate * nk->fixed_post_div;
 
 	_nk.min_n = nk->n.min;
-	_nk.max_n = 1 << nk->n.width;
+	_nk.max_n = nk->n.max ?: 1 << nk->n.width;
 	_nk.min_k = nk->k.min;
-	_nk.max_k = 1 << nk->k.width;
+	_nk.max_k = nk->k.max ?: 1 << nk->k.width;
 
 	ccu_nk_find_best(parent_rate, rate, &_nk);
 
diff --git a/drivers/clk/sunxi-ng/ccu_nkm.c b/drivers/clk/sunxi-ng/ccu_nkm.c
index 3caaf9d603e2..71f81e95a061 100644
--- a/drivers/clk/sunxi-ng/ccu_nkm.c
+++ b/drivers/clk/sunxi-ng/ccu_nkm.c
@@ -110,9 +110,9 @@ static unsigned long ccu_nkm_round_rate(struct ccu_mux_internal *mux,
 	struct _ccu_nkm _nkm;
 
 	_nkm.min_n = nkm->n.min;
-	_nkm.max_n = 1 << nkm->n.width;
+	_nkm.max_n = nkm->n.max ?: 1 << nkm->n.width;
 	_nkm.min_k = nkm->k.min;
-	_nkm.max_k = 1 << nkm->k.width;
+	_nkm.max_k = nkm->k.max ?: 1 << nkm->k.width;
 	_nkm.min_m = 1;
 	_nkm.max_m = nkm->m.max ?: 1 << nkm->m.width;
 
@@ -139,9 +139,9 @@ static int ccu_nkm_set_rate(struct clk_hw *hw, unsigned long rate,
 	u32 reg;
 
 	_nkm.min_n = nkm->n.min;
-	_nkm.max_n = 1 << nkm->n.width;
+	_nkm.max_n = nkm->n.max ?: 1 << nkm->n.width;
 	_nkm.min_k = nkm->k.min;
-	_nkm.max_k = 1 << nkm->k.width;
+	_nkm.max_k = nkm->k.max ?: 1 << nkm->k.width;
 	_nkm.min_m = 1;
 	_nkm.max_m = nkm->m.max ?: 1 << nkm->m.width;
 
diff --git a/drivers/clk/sunxi-ng/ccu_nkmp.c b/drivers/clk/sunxi-ng/ccu_nkmp.c
index da2bba02b845..a2b40a000157 100644
--- a/drivers/clk/sunxi-ng/ccu_nkmp.c
+++ b/drivers/clk/sunxi-ng/ccu_nkmp.c
@@ -117,9 +117,9 @@ static long ccu_nkmp_round_rate(struct clk_hw *hw, unsigned long rate,
 	struct _ccu_nkmp _nkmp;
 
 	_nkmp.min_n = nkmp->n.min;
-	_nkmp.max_n = 1 << nkmp->n.width;
+	_nkmp.max_n = nkmp->n.max ?: 1 << nkmp->n.width;
 	_nkmp.min_k = nkmp->k.min;
-	_nkmp.max_k = 1 << nkmp->k.width;
+	_nkmp.max_k = nkmp->k.max ?: 1 << nkmp->k.width;
 	_nkmp.min_m = 1;
 	_nkmp.max_m = nkmp->m.max ?: 1 << nkmp->m.width;
 	_nkmp.min_p = 1;
@@ -139,9 +139,9 @@ static int ccu_nkmp_set_rate(struct clk_hw *hw, unsigned long rate,
 	u32 reg;
 
 	_nkmp.min_n = 1;
-	_nkmp.max_n = 1 << nkmp->n.width;
+	_nkmp.max_n = nkmp->n.max ?: 1 << nkmp->n.width;
 	_nkmp.min_k = 1;
-	_nkmp.max_k = 1 << nkmp->k.width;
+	_nkmp.max_k = nkmp->k.max ?: 1 << nkmp->k.width;
 	_nkmp.min_m = 1;
 	_nkmp.max_m = nkmp->m.max ?: 1 << nkmp->m.width;
 	_nkmp.min_p = 1;
diff --git a/drivers/clk/sunxi-ng/ccu_nm.c b/drivers/clk/sunxi-ng/ccu_nm.c
index 158d74e0215f..af71b1909cd9 100644
--- a/drivers/clk/sunxi-ng/ccu_nm.c
+++ b/drivers/clk/sunxi-ng/ccu_nm.c
@@ -100,7 +100,7 @@ static long ccu_nm_round_rate(struct clk_hw *hw, unsigned long rate,
 	struct _ccu_nm _nm;
 
 	_nm.min_n = nm->n.min;
-	_nm.max_n = 1 << nm->n.width;
+	_nm.max_n = nm->n.max ?: 1 << nm->n.width;
 	_nm.min_m = 1;
 	_nm.max_m = nm->m.max ?: 1 << nm->m.width;
 
@@ -123,7 +123,7 @@ static int ccu_nm_set_rate(struct clk_hw *hw, unsigned long rate,
 		ccu_frac_helper_disable(&nm->common, &nm->frac);
 
 	_nm.min_n = 1;
-	_nm.max_n = 1 << nm->n.width;
+	_nm.max_n = nm->n.max ?: 1 << nm->n.width;
 	_nm.min_m = 1;
 	_nm.max_m = nm->m.max ?: 1 << nm->m.width;
 
-- 
git-series 0.8.11
