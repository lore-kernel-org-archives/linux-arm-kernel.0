From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue,  6 Sep 2016 14:18:32 +0200
Subject: [PATCH v2 2/7] clk: sunxi-ng: div: Allow to set a maximum
In-Reply-To: <20160906121837.7517-1-maxime.ripard@free-electrons.com>
References: <20160906121837.7517-1-maxime.ripard@free-electrons.com>
Message-ID: <20160906121837.7517-3-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some dividers might have a maximum value that is lower than the width of
the register.

Add a field to _ccu_div to handle those case properly. If the field is set
to 0, the code will assume that the maximum value is the maximum one that
can be used with the field register width.

Otherwise, we'll use whatever value has been set.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/clk/sunxi-ng/ccu_div.h  | 21 +++++++++++++++++----
 drivers/clk/sunxi-ng/ccu_mp.c   | 23 +++++++++++++----------
 drivers/clk/sunxi-ng/ccu_nkm.c  |  4 ++--
 drivers/clk/sunxi-ng/ccu_nkmp.c | 21 ++++++++++-----------
 drivers/clk/sunxi-ng/ccu_nm.c   | 16 ++++++++++------
 5 files changed, 52 insertions(+), 33 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu_div.h b/drivers/clk/sunxi-ng/ccu_div.h
index a5c9eaf90e84..ea693d00be81 100644
--- a/drivers/clk/sunxi-ng/ccu_div.h
+++ b/drivers/clk/sunxi-ng/ccu_div.h
@@ -23,6 +23,8 @@ struct _ccu_div {
 	u8			shift;
 	u8			width;
 
+	u32			max;
+
 	u32			flags;
 
 	struct clk_div_table	*table;
@@ -36,14 +38,25 @@ struct _ccu_div {
 		.table	= _table,					\
 	}
 
-#define _SUNXI_CCU_DIV_FLAGS(_shift, _width, _flags)			\
-	_SUNXI_CCU_DIV_TABLE_FLAGS(_shift, _width, NULL, _flags)
-
 #define _SUNXI_CCU_DIV_TABLE(_shift, _width, _table)			\
 	_SUNXI_CCU_DIV_TABLE_FLAGS(_shift, _width, _table, 0)
 
+#define _SUNXI_CCU_DIV_MAX_FLAGS(_shift, _width, _max, _flags) \
+	{								\
+		.shift	= _shift,					\
+		.width	= _width,					\
+		.flags	= _flags,					\
+		.max	= _max,						\
+	}
+
+#define _SUNXI_CCU_DIV_FLAGS(_shift, _width, _flags)			\
+	_SUNXI_CCU_DIV_MAX_FLAGS(_shift, _width, 0, _flags)
+
+#define _SUNXI_CCU_DIV_MAX(_shift, _width, _max)			\
+	_SUNXI_CCU_DIV_MAX_FLAGS(_shift, _width, _max, 0)
+
 #define _SUNXI_CCU_DIV(_shift, _width)					\
-	_SUNXI_CCU_DIV_TABLE_FLAGS(_shift, _width, NULL, 0)
+	_SUNXI_CCU_DIV_FLAGS(_shift, _width, 0)
 
 struct ccu_div {
 	u32			enable;
diff --git a/drivers/clk/sunxi-ng/ccu_mp.c b/drivers/clk/sunxi-ng/ccu_mp.c
index cbf33ef5faa9..ebb1b31568a5 100644
--- a/drivers/clk/sunxi-ng/ccu_mp.c
+++ b/drivers/clk/sunxi-ng/ccu_mp.c
@@ -21,9 +21,9 @@ static void ccu_mp_find_best(unsigned long parent, unsigned long rate,
 	unsigned int best_m = 0, best_p = 0;
 	unsigned int _m, _p;
 
-	for (_p = 0; _p <= max_p; _p++) {
+	for (_p = 1; _p <= max_p; _p <<= 1) {
 		for (_m = 1; _m <= max_m; _m++) {
-			unsigned long tmp_rate = (parent >> _p) / _m;
+			unsigned long tmp_rate = parent / _p / _m;
 
 			if (tmp_rate > rate)
 				continue;
@@ -46,13 +46,15 @@ static unsigned long ccu_mp_round_rate(struct ccu_mux_internal *mux,
 				       void *data)
 {
 	struct ccu_mp *cmp = data;
+	unsigned int max_m, max_p;
 	unsigned int m, p;
 
-	ccu_mp_find_best(parent_rate, rate,
-			 1 << cmp->m.width, (1 << cmp->p.width) - 1,
-			 &m, &p);
+	max_m = cmp->m.max ?: 1 << cmp->m.width;
+	max_p = cmp->p.max ?: 1 << ((1 << cmp->p.width) - 1);
 
-	return (parent_rate >> p) / m;
+	ccu_mp_find_best(parent_rate, rate, max_m, max_p, &m, &p);
+
+	return parent_rate / p / m;
 }
 
 static void ccu_mp_disable(struct clk_hw *hw)
@@ -108,13 +110,14 @@ static int ccu_mp_set_rate(struct clk_hw *hw, unsigned long rate,
 {
 	struct ccu_mp *cmp = hw_to_ccu_mp(hw);
 	unsigned long flags;
+	unsigned int max_m, max_p;
 	unsigned int m, p;
 	u32 reg;
 
-	ccu_mp_find_best(parent_rate, rate,
-			 1 << cmp->m.width, (1 << cmp->p.width) - 1,
-			 &m, &p);
+	max_m = cmp->m.max ?: 1 << cmp->m.width;
+	max_p = cmp->p.max ?: 1 << ((1 << cmp->p.width) - 1);
 
+	ccu_mp_find_best(parent_rate, rate, max_m, max_p, &m, &p);
 
 	spin_lock_irqsave(cmp->common.lock, flags);
 
@@ -122,7 +125,7 @@ static int ccu_mp_set_rate(struct clk_hw *hw, unsigned long rate,
 	reg &= ~GENMASK(cmp->m.width + cmp->m.shift - 1, cmp->m.shift);
 	reg &= ~GENMASK(cmp->p.width + cmp->p.shift - 1, cmp->p.shift);
 
-	writel(reg | (p << cmp->p.shift) | ((m - 1) << cmp->m.shift),
+	writel(reg | (ilog2(p) << cmp->p.shift) | ((m - 1) << cmp->m.shift),
 	       cmp->common.base + cmp->common.reg);
 
 	spin_unlock_irqrestore(cmp->common.lock, flags);
diff --git a/drivers/clk/sunxi-ng/ccu_nkm.c b/drivers/clk/sunxi-ng/ccu_nkm.c
index 182452919ede..059fdc3b4f96 100644
--- a/drivers/clk/sunxi-ng/ccu_nkm.c
+++ b/drivers/clk/sunxi-ng/ccu_nkm.c
@@ -103,7 +103,7 @@ static unsigned long ccu_nkm_round_rate(struct ccu_mux_internal *mux,
 
 	_nkm.max_n = 1 << nkm->n.width;
 	_nkm.max_k = 1 << nkm->k.width;
-	_nkm.max_m = 1 << nkm->m.width;
+	_nkm.max_m = nkm->m.max ?: 1 << nkm->m.width;
 
 	ccu_nkm_find_best(parent_rate, rate, &_nkm);
 
@@ -129,7 +129,7 @@ static int ccu_nkm_set_rate(struct clk_hw *hw, unsigned long rate,
 
 	_nkm.max_n = 1 << nkm->n.width;
 	_nkm.max_k = 1 << nkm->k.width;
-	_nkm.max_m = 1 << nkm->m.width;
+	_nkm.max_m = nkm->m.max ?: 1 << nkm->m.width;
 
 	ccu_nkm_find_best(parent_rate, rate, &_nkm);
 
diff --git a/drivers/clk/sunxi-ng/ccu_nkmp.c b/drivers/clk/sunxi-ng/ccu_nkmp.c
index 9f2b98e19dc9..9769dee99511 100644
--- a/drivers/clk/sunxi-ng/ccu_nkmp.c
+++ b/drivers/clk/sunxi-ng/ccu_nkmp.c
@@ -29,14 +29,14 @@ static void ccu_nkmp_find_best(unsigned long parent, unsigned long rate,
 	unsigned long _n, _k, _m, _p;
 
 	for (_k = 1; _k <= nkmp->max_k; _k++) {
-		for (_p = 0; _p <= nkmp->max_p; _p++) {
+		for (_p = 1; _p <= nkmp->max_p; _p <<= 1) {
 			unsigned long tmp_rate;
 
-			rational_best_approximation(rate / _k, parent >> _p,
+			rational_best_approximation(rate / _k, parent / _p,
 						    nkmp->max_n, nkmp->max_m,
 						    &_n, &_m);
 
-			tmp_rate = (parent * _n * _k >> _p) / _m;
+			tmp_rate = parent * _n * _k / (_m * _p);
 
 			if (tmp_rate > rate)
 				continue;
@@ -110,13 +110,12 @@ static long ccu_nkmp_round_rate(struct clk_hw *hw, unsigned long rate,
 
 	_nkmp.max_n = 1 << nkmp->n.width;
 	_nkmp.max_k = 1 << nkmp->k.width;
-	_nkmp.max_m = 1 << nkmp->m.width;
-	_nkmp.max_p = (1 << nkmp->p.width) - 1;
+	_nkmp.max_m = nkmp->m.max ?: 1 << nkmp->m.width;
+	_nkmp.max_p = nkmp->p.max ?: 1 << ((1 << nkmp->p.width) - 1);
 
-	ccu_nkmp_find_best(*parent_rate, rate,
-			   &_nkmp);
+	ccu_nkmp_find_best(*parent_rate, rate, &_nkmp);
 
-	return (*parent_rate * _nkmp.n * _nkmp.k >> _nkmp.p) / _nkmp.m;
+	return *parent_rate * _nkmp.n * _nkmp.k / (_nkmp.m * _nkmp.p);
 }
 
 static int ccu_nkmp_set_rate(struct clk_hw *hw, unsigned long rate,
@@ -129,8 +128,8 @@ static int ccu_nkmp_set_rate(struct clk_hw *hw, unsigned long rate,
 
 	_nkmp.max_n = 1 << nkmp->n.width;
 	_nkmp.max_k = 1 << nkmp->k.width;
-	_nkmp.max_m = 1 << nkmp->m.width;
-	_nkmp.max_p = (1 << nkmp->p.width) - 1;
+	_nkmp.max_m = nkmp->m.max ?: 1 << nkmp->m.width;
+	_nkmp.max_p = nkmp->p.max ?: 1 << ((1 << nkmp->p.width) - 1);
 
 	ccu_nkmp_find_best(parent_rate, rate, &_nkmp);
 
@@ -145,7 +144,7 @@ static int ccu_nkmp_set_rate(struct clk_hw *hw, unsigned long rate,
 	reg |= (_nkmp.n - 1) << nkmp->n.shift;
 	reg |= (_nkmp.k - 1) << nkmp->k.shift;
 	reg |= (_nkmp.m - 1) << nkmp->m.shift;
-	reg |= _nkmp.p << nkmp->p.shift;
+	reg |= ilog2(_nkmp.p) << nkmp->p.shift;
 
 	writel(reg, nkmp->common.base + nkmp->common.reg);
 
diff --git a/drivers/clk/sunxi-ng/ccu_nm.c b/drivers/clk/sunxi-ng/ccu_nm.c
index e35ddd8eec8b..b61bdd8c7a7f 100644
--- a/drivers/clk/sunxi-ng/ccu_nm.c
+++ b/drivers/clk/sunxi-ng/ccu_nm.c
@@ -61,11 +61,13 @@ static long ccu_nm_round_rate(struct clk_hw *hw, unsigned long rate,
 			      unsigned long *parent_rate)
 {
 	struct ccu_nm *nm = hw_to_ccu_nm(hw);
+	unsigned long max_n, max_m;
 	unsigned long n, m;
 
-	rational_best_approximation(rate, *parent_rate,
-				    1 << nm->n.width, 1 << nm->m.width,
-				    &n, &m);
+	max_n = 1 << nm->n.width;
+	max_m = nm->m.max ?: 1 << nm->m.width;
+
+	rational_best_approximation(rate, *parent_rate, max_n, max_m, &n, &m);
 
 	return *parent_rate * n / m;
 }
@@ -75,6 +77,7 @@ static int ccu_nm_set_rate(struct clk_hw *hw, unsigned long rate,
 {
 	struct ccu_nm *nm = hw_to_ccu_nm(hw);
 	unsigned long flags;
+	unsigned long max_n, max_m;
 	unsigned long n, m;
 	u32 reg;
 
@@ -83,9 +86,10 @@ static int ccu_nm_set_rate(struct clk_hw *hw, unsigned long rate,
 	else
 		ccu_frac_helper_disable(&nm->common, &nm->frac);
 
-	rational_best_approximation(rate, parent_rate,
-				    1 << nm->n.width, 1 << nm->m.width,
-				    &n, &m);
+	max_n = 1 << nm->n.width;
+	max_m = nm->m.max ?: 1 << nm->m.width;
+
+	rational_best_approximation(rate, parent_rate, max_n, max_m, &n, &m);
 
 	spin_lock_irqsave(nm->common.lock, flags);
 
-- 
2.9.3
