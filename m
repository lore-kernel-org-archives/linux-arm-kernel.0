From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 17 May 2017 09:40:31 +0200
Subject: [PATCH v3 02/21] clk: sunxi-ng: Pass the parent and a pointer to the
 clocks round rate
In-Reply-To: <cover.463df61c38224ecbfb5bf1cf192deeb63718b693.1495006350.git-series.maxime.ripard@free-electrons.com>
References: <cover.463df61c38224ecbfb5bf1cf192deeb63718b693.1495006350.git-series.maxime.ripard@free-electrons.com>
Message-ID: <a5c349636d52f73ede2fe439730880393b38cd09.1495006350.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clocks might need to modify their parent clocks. In order to make that
possible, give them access to the parent clock being evaluated, and to a
pointer to the parent rate so that they can modify it if needed.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Acked-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/clk/sunxi-ng/ccu_div.c  |  7 ++++---
 drivers/clk/sunxi-ng/ccu_mp.c   |  7 ++++---
 drivers/clk/sunxi-ng/ccu_mult.c | 11 ++++++-----
 drivers/clk/sunxi-ng/ccu_mux.c  |  8 +++++---
 drivers/clk/sunxi-ng/ccu_mux.h  |  3 ++-
 drivers/clk/sunxi-ng/ccu_nkm.c  |  7 ++++---
 6 files changed, 25 insertions(+), 18 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu_div.c b/drivers/clk/sunxi-ng/ccu_div.c
index 4057e6021aa9..a489f18a3c01 100644
--- a/drivers/clk/sunxi-ng/ccu_div.c
+++ b/drivers/clk/sunxi-ng/ccu_div.c
@@ -14,7 +14,8 @@
 #include "ccu_div.h"
 
 static unsigned long ccu_div_round_rate(struct ccu_mux_internal *mux,
-					unsigned long parent_rate,
+					struct clk_hw *parent,
+					unsigned long *parent_rate,
 					unsigned long rate,
 					void *data)
 {
@@ -26,10 +27,10 @@ static unsigned long ccu_div_round_rate(struct ccu_mux_internal *mux,
 	 * several parents, while we might be called to evaluate
 	 * several different parents.
 	 */
-	val = divider_get_val(rate, parent_rate, cd->div.table, cd->div.width,
+	val = divider_get_val(rate, *parent_rate, cd->div.table, cd->div.width,
 			      cd->div.flags);
 
-	return divider_recalc_rate(&cd->common.hw, parent_rate, val,
+	return divider_recalc_rate(&cd->common.hw, *parent_rate, val,
 				   cd->div.table, cd->div.flags);
 }
 
diff --git a/drivers/clk/sunxi-ng/ccu_mp.c b/drivers/clk/sunxi-ng/ccu_mp.c
index b583f186a804..de02e6c386d8 100644
--- a/drivers/clk/sunxi-ng/ccu_mp.c
+++ b/drivers/clk/sunxi-ng/ccu_mp.c
@@ -41,7 +41,8 @@ static void ccu_mp_find_best(unsigned long parent, unsigned long rate,
 }
 
 static unsigned long ccu_mp_round_rate(struct ccu_mux_internal *mux,
-				       unsigned long parent_rate,
+				       struct clk_hw *hw,
+				       unsigned long *parent_rate,
 				       unsigned long rate,
 				       void *data)
 {
@@ -52,9 +53,9 @@ static unsigned long ccu_mp_round_rate(struct ccu_mux_internal *mux,
 	max_m = cmp->m.max ?: 1 << cmp->m.width;
 	max_p = cmp->p.max ?: 1 << ((1 << cmp->p.width) - 1);
 
-	ccu_mp_find_best(parent_rate, rate, max_m, max_p, &m, &p);
+	ccu_mp_find_best(*parent_rate, rate, max_m, max_p, &m, &p);
 
-	return parent_rate / p / m;
+	return *parent_rate / p / m;
 }
 
 static void ccu_mp_disable(struct clk_hw *hw)
diff --git a/drivers/clk/sunxi-ng/ccu_mult.c b/drivers/clk/sunxi-ng/ccu_mult.c
index 671141359895..6ee7ba0738fb 100644
--- a/drivers/clk/sunxi-ng/ccu_mult.c
+++ b/drivers/clk/sunxi-ng/ccu_mult.c
@@ -33,9 +33,10 @@ static void ccu_mult_find_best(unsigned long parent, unsigned long rate,
 }
 
 static unsigned long ccu_mult_round_rate(struct ccu_mux_internal *mux,
-					unsigned long parent_rate,
-					unsigned long rate,
-					void *data)
+					 struct clk_hw *parent,
+					 unsigned long *parent_rate,
+					 unsigned long rate,
+					 void *data)
 {
 	struct ccu_mult *cm = data;
 	struct _ccu_mult _cm;
@@ -47,9 +48,9 @@ static unsigned long ccu_mult_round_rate(struct ccu_mux_internal *mux,
 	else
 		_cm.max = (1 << cm->mult.width) + cm->mult.offset - 1;
 
-	ccu_mult_find_best(parent_rate, rate, &_cm);
+	ccu_mult_find_best(*parent_rate, rate, &_cm);
 
-	return parent_rate * _cm.mult;
+	return *parent_rate * _cm.mult;
 }
 
 static void ccu_mult_disable(struct clk_hw *hw)
diff --git a/drivers/clk/sunxi-ng/ccu_mux.c b/drivers/clk/sunxi-ng/ccu_mux.c
index c6bb1f523232..bae735e252b6 100644
--- a/drivers/clk/sunxi-ng/ccu_mux.c
+++ b/drivers/clk/sunxi-ng/ccu_mux.c
@@ -61,7 +61,8 @@ int ccu_mux_helper_determine_rate(struct ccu_common *common,
 				  struct ccu_mux_internal *cm,
 				  struct clk_rate_request *req,
 				  unsigned long (*round)(struct ccu_mux_internal *,
-							 unsigned long,
+							 struct clk_hw *,
+							 unsigned long *,
 							 unsigned long,
 							 void *),
 				  void *data)
@@ -80,7 +81,8 @@ int ccu_mux_helper_determine_rate(struct ccu_common *common,
 		ccu_mux_helper_adjust_parent_for_prediv(common, cm, -1,
 							&adj_parent_rate);
 
-		best_rate = round(cm, adj_parent_rate, req->rate, data);
+		best_rate = round(cm, best_parent, &adj_parent_rate,
+				  req->rate, data);
 
 		goto out;
 	}
@@ -109,7 +111,7 @@ int ccu_mux_helper_determine_rate(struct ccu_common *common,
 		ccu_mux_helper_adjust_parent_for_prediv(common, cm, i,
 							&adj_parent_rate);
 
-		tmp_rate = round(cm, adj_parent_rate, req->rate, data);
+		tmp_rate = round(cm, parent, &adj_parent_rate, req->rate, data);
 		if (tmp_rate == req->rate) {
 			best_parent = parent;
 			best_parent_rate = parent_rate;
diff --git a/drivers/clk/sunxi-ng/ccu_mux.h b/drivers/clk/sunxi-ng/ccu_mux.h
index 47aba3a48245..4be56eee2bfd 100644
--- a/drivers/clk/sunxi-ng/ccu_mux.h
+++ b/drivers/clk/sunxi-ng/ccu_mux.h
@@ -86,7 +86,8 @@ int ccu_mux_helper_determine_rate(struct ccu_common *common,
 				  struct ccu_mux_internal *cm,
 				  struct clk_rate_request *req,
 				  unsigned long (*round)(struct ccu_mux_internal *,
-							 unsigned long,
+							 struct clk_hw *,
+							 unsigned long *,
 							 unsigned long,
 							 void *),
 				  void *data);
diff --git a/drivers/clk/sunxi-ng/ccu_nkm.c b/drivers/clk/sunxi-ng/ccu_nkm.c
index cba84afe1cf1..44b16dc8fea6 100644
--- a/drivers/clk/sunxi-ng/ccu_nkm.c
+++ b/drivers/clk/sunxi-ng/ccu_nkm.c
@@ -102,7 +102,8 @@ static unsigned long ccu_nkm_recalc_rate(struct clk_hw *hw,
 }
 
 static unsigned long ccu_nkm_round_rate(struct ccu_mux_internal *mux,
-					unsigned long parent_rate,
+					struct clk_hw *hw,
+					unsigned long *parent_rate,
 					unsigned long rate,
 					void *data)
 {
@@ -116,9 +117,9 @@ static unsigned long ccu_nkm_round_rate(struct ccu_mux_internal *mux,
 	_nkm.min_m = 1;
 	_nkm.max_m = nkm->m.max ?: 1 << nkm->m.width;
 
-	ccu_nkm_find_best(parent_rate, rate, &_nkm);
+	ccu_nkm_find_best(*parent_rate, rate, &_nkm);
 
-	return parent_rate * _nkm.n * _nkm.k / _nkm.m;
+	return *parent_rate * _nkm.n * _nkm.k / _nkm.m;
 }
 
 static int ccu_nkm_determine_rate(struct clk_hw *hw,
-- 
git-series 0.9.1
