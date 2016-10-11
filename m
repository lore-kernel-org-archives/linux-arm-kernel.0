From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 11 Oct 2016 16:28:23 +0200
Subject: [PATCH v4 5/9] clk: sunxi-ng: Implement minimum for multipliers
In-Reply-To: <cover.024e1b023e41efe548dc6a004f7a946408d5c9a2.1476196031.git-series.maxime.ripard@free-electrons.com>
References: <cover.024e1b023e41efe548dc6a004f7a946408d5c9a2.1476196031.git-series.maxime.ripard@free-electrons.com>
Message-ID: <dc2601d4f35d9921ec50ed443cdd413f699fa270.1476196031.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allow the CCU drivers to specify a multiplier for their clocks.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/clk/sunxi-ng/ccu_mult.c |  2 +-
 drivers/clk/sunxi-ng/ccu_mult.h | 13 +++++++++----
 drivers/clk/sunxi-ng/ccu_nk.c   |  8 ++++----
 drivers/clk/sunxi-ng/ccu_nkm.c  |  8 ++++----
 drivers/clk/sunxi-ng/ccu_nkmp.c |  4 ++--
 drivers/clk/sunxi-ng/ccu_nm.c   |  2 +-
 6 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu_mult.c b/drivers/clk/sunxi-ng/ccu_mult.c
index 6a02ffee5386..678b6cb49f01 100644
--- a/drivers/clk/sunxi-ng/ccu_mult.c
+++ b/drivers/clk/sunxi-ng/ccu_mult.c
@@ -105,7 +105,7 @@ static int ccu_mult_set_rate(struct clk_hw *hw, unsigned long rate,
 	ccu_mux_helper_adjust_parent_for_prediv(&cm->common, &cm->mux, -1,
 						&parent_rate);
 
-	_cm.min = 1;
+	_cm.min = cm->mult.min;
 	_cm.max = 1 << cm->mult.width;
 	ccu_mult_find_best(parent_rate, rate, &_cm);
 
diff --git a/drivers/clk/sunxi-ng/ccu_mult.h b/drivers/clk/sunxi-ng/ccu_mult.h
index 113780b7558e..c1a2134bdc71 100644
--- a/drivers/clk/sunxi-ng/ccu_mult.h
+++ b/drivers/clk/sunxi-ng/ccu_mult.h
@@ -7,14 +7,19 @@
 struct ccu_mult_internal {
 	u8	shift;
 	u8	width;
+	u8	min;
 };
 
-#define _SUNXI_CCU_MULT(_shift, _width)		\
-	{					\
-		.shift	= _shift,		\
-		.width	= _width,		\
+#define _SUNXI_CCU_MULT_MIN(_shift, _width, _min)	\
+	{						\
+		.shift	= _shift,			\
+		.width	= _width,			\
+		.min	= _min,				\
 	}
 
+#define _SUNXI_CCU_MULT(_shift, _width)		\
+	_SUNXI_CCU_MULT_MIN(_shift, _width, 1)
+
 struct ccu_mult {
 	u32			enable;
 
diff --git a/drivers/clk/sunxi-ng/ccu_nk.c b/drivers/clk/sunxi-ng/ccu_nk.c
index a42d870ba0ef..eaf0fdf78d2b 100644
--- a/drivers/clk/sunxi-ng/ccu_nk.c
+++ b/drivers/clk/sunxi-ng/ccu_nk.c
@@ -97,9 +97,9 @@ static long ccu_nk_round_rate(struct clk_hw *hw, unsigned long rate,
 	if (nk->common.features & CCU_FEATURE_FIXED_POSTDIV)
 		rate *= nk->fixed_post_div;
 
-	_nk.min_n = 1;
+	_nk.min_n = nk->n.min;
 	_nk.max_n = 1 << nk->n.width;
-	_nk.min_k = 1;
+	_nk.min_k = nk->k.min;
 	_nk.max_k = 1 << nk->k.width;
 
 	ccu_nk_find_best(*parent_rate, rate, &_nk);
@@ -122,9 +122,9 @@ static int ccu_nk_set_rate(struct clk_hw *hw, unsigned long rate,
 	if (nk->common.features & CCU_FEATURE_FIXED_POSTDIV)
 		rate = rate * nk->fixed_post_div;
 
-	_nk.min_n = 1;
+	_nk.min_n = nk->n.min;
 	_nk.max_n = 1 << nk->n.width;
-	_nk.min_k = 1;
+	_nk.min_k = nk->k.min;
 	_nk.max_k = 1 << nk->k.width;
 
 	ccu_nk_find_best(parent_rate, rate, &_nk);
diff --git a/drivers/clk/sunxi-ng/ccu_nkm.c b/drivers/clk/sunxi-ng/ccu_nkm.c
index b2a5fccf2f8c..715b49211ddb 100644
--- a/drivers/clk/sunxi-ng/ccu_nkm.c
+++ b/drivers/clk/sunxi-ng/ccu_nkm.c
@@ -100,9 +100,9 @@ static unsigned long ccu_nkm_round_rate(struct ccu_mux_internal *mux,
 	struct ccu_nkm *nkm = data;
 	struct _ccu_nkm _nkm;
 
-	_nkm.min_n = 1;
+	_nkm.min_n = nkm->n.min;
 	_nkm.max_n = 1 << nkm->n.width;
-	_nkm.min_k = 1;
+	_nkm.min_n = nkm->k.min;
 	_nkm.max_k = 1 << nkm->k.width;
 	_nkm.min_m = 1;
 	_nkm.max_m = nkm->m.max ?: 1 << nkm->m.width;
@@ -129,9 +129,9 @@ static int ccu_nkm_set_rate(struct clk_hw *hw, unsigned long rate,
 	unsigned long flags;
 	u32 reg;
 
-	_nkm.min_n = 1;
+	_nkm.min_n = nkm->n.min;
 	_nkm.max_n = 1 << nkm->n.width;
-	_nkm.min_k = 1;
+	_nkm.min_n = nkm->k.min;
 	_nkm.max_k = 1 << nkm->k.width;
 	_nkm.min_m = 1;
 	_nkm.max_m = nkm->m.max ?: 1 << nkm->m.width;
diff --git a/drivers/clk/sunxi-ng/ccu_nkmp.c b/drivers/clk/sunxi-ng/ccu_nkmp.c
index 2c1398192e48..7968e0bac5db 100644
--- a/drivers/clk/sunxi-ng/ccu_nkmp.c
+++ b/drivers/clk/sunxi-ng/ccu_nkmp.c
@@ -107,9 +107,9 @@ static long ccu_nkmp_round_rate(struct clk_hw *hw, unsigned long rate,
 	struct ccu_nkmp *nkmp = hw_to_ccu_nkmp(hw);
 	struct _ccu_nkmp _nkmp;
 
-	_nkmp.min_n = 1;
+	_nkmp.min_n = nkmp->n.min;
 	_nkmp.max_n = 1 << nkmp->n.width;
-	_nkmp.min_k = 1;
+	_nkmp.min_n = nkmp->k.min;
 	_nkmp.max_k = 1 << nkmp->k.width;
 	_nkmp.min_m = 1;
 	_nkmp.max_m = nkmp->m.max ?: 1 << nkmp->m.width;
diff --git a/drivers/clk/sunxi-ng/ccu_nm.c b/drivers/clk/sunxi-ng/ccu_nm.c
index 2a190bc032a9..b1f3f0e8899d 100644
--- a/drivers/clk/sunxi-ng/ccu_nm.c
+++ b/drivers/clk/sunxi-ng/ccu_nm.c
@@ -93,7 +93,7 @@ static long ccu_nm_round_rate(struct clk_hw *hw, unsigned long rate,
 	struct ccu_nm *nm = hw_to_ccu_nm(hw);
 	struct _ccu_nm _nm;
 
-	_nm.min_n = 1;
+	_nm.min_n = nm->n.min;
 	_nm.max_n = 1 << nm->n.width;
 	_nm.min_m = 1;
 	_nm.max_m = nm->m.max ?: 1 << nm->m.width;
-- 
git-series 0.8.10
