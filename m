From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 11 Oct 2016 16:28:22 +0200
Subject: [PATCH v4 4/9] clk: sunxi-ng: Add minimums for all the relevant
 structures and clocks
In-Reply-To: <cover.024e1b023e41efe548dc6a004f7a946408d5c9a2.1476196031.git-series.maxime.ripard@free-electrons.com>
References: <cover.024e1b023e41efe548dc6a004f7a946408d5c9a2.1476196031.git-series.maxime.ripard@free-electrons.com>
Message-ID: <a96b56fb7bda849e087b63a04ff76d1396c44d72.1476196031.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Modify the current clocks we have to be able to specify the minimum for
each clocks we support, just like we support the max.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/clk/sunxi-ng/ccu_mult.c |  7 ++++++-
 drivers/clk/sunxi-ng/ccu_nk.c   | 12 ++++++++----
 drivers/clk/sunxi-ng/ccu_nkm.c  | 18 ++++++++++++------
 drivers/clk/sunxi-ng/ccu_nkmp.c | 16 ++++++++++++----
 drivers/clk/sunxi-ng/ccu_nm.c   | 12 ++++++++----
 5 files changed, 46 insertions(+), 19 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu_mult.c b/drivers/clk/sunxi-ng/ccu_mult.c
index 32a1964439a2..6a02ffee5386 100644
--- a/drivers/clk/sunxi-ng/ccu_mult.c
+++ b/drivers/clk/sunxi-ng/ccu_mult.c
@@ -14,7 +14,7 @@
 #include "ccu_mult.h"
 
 struct _ccu_mult {
-	unsigned long	mult, max;
+	unsigned long	mult, min, max;
 };
 
 static void ccu_mult_find_best(unsigned long parent, unsigned long rate,
@@ -23,6 +23,9 @@ static void ccu_mult_find_best(unsigned long parent, unsigned long rate,
 	int _mult;
 
 	_mult = rate / parent;
+	if (_mult < mult->min)
+		_mult = mult->min;
+
 	if (_mult > mult->max)
 		_mult = mult->max;
 
@@ -37,6 +40,7 @@ static unsigned long ccu_mult_round_rate(struct ccu_mux_internal *mux,
 	struct ccu_mult *cm = data;
 	struct _ccu_mult _cm;
 
+	_cm.min = 1;
 	_cm.max = 1 << cm->mult.width;
 	ccu_mult_find_best(parent_rate, rate, &_cm);
 
@@ -101,6 +105,7 @@ static int ccu_mult_set_rate(struct clk_hw *hw, unsigned long rate,
 	ccu_mux_helper_adjust_parent_for_prediv(&cm->common, &cm->mux, -1,
 						&parent_rate);
 
+	_cm.min = 1;
 	_cm.max = 1 << cm->mult.width;
 	ccu_mult_find_best(parent_rate, rate, &_cm);
 
diff --git a/drivers/clk/sunxi-ng/ccu_nk.c b/drivers/clk/sunxi-ng/ccu_nk.c
index e7e2e75618ef..a42d870ba0ef 100644
--- a/drivers/clk/sunxi-ng/ccu_nk.c
+++ b/drivers/clk/sunxi-ng/ccu_nk.c
@@ -14,8 +14,8 @@
 #include "ccu_nk.h"
 
 struct _ccu_nk {
-	unsigned long	n, max_n;
-	unsigned long	k, max_k;
+	unsigned long	n, min_n, max_n;
+	unsigned long	k, min_k, max_k;
 };
 
 static void ccu_nk_find_best(unsigned long parent, unsigned long rate,
@@ -25,8 +25,8 @@ static void ccu_nk_find_best(unsigned long parent, unsigned long rate,
 	unsigned int best_k = 0, best_n = 0;
 	unsigned int _k, _n;
 
-	for (_k = 1; _k <= nk->max_k; _k++) {
-		for (_n = 1; _n <= nk->max_n; _n++) {
+	for (_k = nk->min_k; _k <= nk->max_k; _k++) {
+		for (_n = nk->min_n; _n <= nk->max_n; _n++) {
 			unsigned long tmp_rate = parent * _n * _k;
 
 			if (tmp_rate > rate)
@@ -97,7 +97,9 @@ static long ccu_nk_round_rate(struct clk_hw *hw, unsigned long rate,
 	if (nk->common.features & CCU_FEATURE_FIXED_POSTDIV)
 		rate *= nk->fixed_post_div;
 
+	_nk.min_n = 1;
 	_nk.max_n = 1 << nk->n.width;
+	_nk.min_k = 1;
 	_nk.max_k = 1 << nk->k.width;
 
 	ccu_nk_find_best(*parent_rate, rate, &_nk);
@@ -120,7 +122,9 @@ static int ccu_nk_set_rate(struct clk_hw *hw, unsigned long rate,
 	if (nk->common.features & CCU_FEATURE_FIXED_POSTDIV)
 		rate = rate * nk->fixed_post_div;
 
+	_nk.min_n = 1;
 	_nk.max_n = 1 << nk->n.width;
+	_nk.min_k = 1;
 	_nk.max_k = 1 << nk->k.width;
 
 	ccu_nk_find_best(parent_rate, rate, &_nk);
diff --git a/drivers/clk/sunxi-ng/ccu_nkm.c b/drivers/clk/sunxi-ng/ccu_nkm.c
index 0b08d000eb38..b2a5fccf2f8c 100644
--- a/drivers/clk/sunxi-ng/ccu_nkm.c
+++ b/drivers/clk/sunxi-ng/ccu_nkm.c
@@ -14,9 +14,9 @@
 #include "ccu_nkm.h"
 
 struct _ccu_nkm {
-	unsigned long	n, max_n;
-	unsigned long	k, max_k;
-	unsigned long	m, max_m;
+	unsigned long	n, min_n, max_n;
+	unsigned long	k, min_k, max_k;
+	unsigned long	m, min_m, max_m;
 };
 
 static void ccu_nkm_find_best(unsigned long parent, unsigned long rate,
@@ -26,9 +26,9 @@ static void ccu_nkm_find_best(unsigned long parent, unsigned long rate,
 	unsigned long best_n = 0, best_k = 0, best_m = 0;
 	unsigned long _n, _k, _m;
 
-	for (_k = 1; _k <= nkm->max_k; _k++) {
-		for (_n = 1; _n <= nkm->max_n; _n++) {
-			for (_m = 1; _n <= nkm->max_m; _m++) {
+	for (_k = nkm->min_k; _k <= nkm->max_k; _k++) {
+		for (_n = nkm->min_n; _n <= nkm->max_n; _n++) {
+			for (_m = nkm->min_m; _n <= nkm->max_m; _m++) {
 				unsigned long tmp_rate;
 
 				tmp_rate = parent * _n * _k / _m;
@@ -100,8 +100,11 @@ static unsigned long ccu_nkm_round_rate(struct ccu_mux_internal *mux,
 	struct ccu_nkm *nkm = data;
 	struct _ccu_nkm _nkm;
 
+	_nkm.min_n = 1;
 	_nkm.max_n = 1 << nkm->n.width;
+	_nkm.min_k = 1;
 	_nkm.max_k = 1 << nkm->k.width;
+	_nkm.min_m = 1;
 	_nkm.max_m = nkm->m.max ?: 1 << nkm->m.width;
 
 	ccu_nkm_find_best(parent_rate, rate, &_nkm);
@@ -126,8 +129,11 @@ static int ccu_nkm_set_rate(struct clk_hw *hw, unsigned long rate,
 	unsigned long flags;
 	u32 reg;
 
+	_nkm.min_n = 1;
 	_nkm.max_n = 1 << nkm->n.width;
+	_nkm.min_k = 1;
 	_nkm.max_k = 1 << nkm->k.width;
+	_nkm.min_m = 1;
 	_nkm.max_m = nkm->m.max ?: 1 << nkm->m.width;
 
 	ccu_nkm_find_best(parent_rate, rate, &_nkm);
diff --git a/drivers/clk/sunxi-ng/ccu_nkmp.c b/drivers/clk/sunxi-ng/ccu_nkmp.c
index 4b457d8cce11..2c1398192e48 100644
--- a/drivers/clk/sunxi-ng/ccu_nkmp.c
+++ b/drivers/clk/sunxi-ng/ccu_nkmp.c
@@ -27,10 +27,10 @@ static void ccu_nkmp_find_best(unsigned long parent, unsigned long rate,
 	unsigned long best_n = 0, best_k = 0, best_m = 0, best_p = 0;
 	unsigned long _n, _k, _m, _p;
 
-	for (_k = 1; _k <= nkmp->max_k; _k++) {
-		for (_n = 1; _n <= nkm->max_n; _n++) {
-			for (_m = 1; _n <= nkm->max_m; _m++) {
-				for (_p = 1; _p <= nkmp->max_p; _p <<= 1) {
+	for (_k = nkmp->min_k; _k <= nkmp->max_k; _k++) {
+		for (_n = nkmp->min_n; _n <= nkmp->max_n; _n++) {
+			for (_m = nkmp->min_m; _n <= nkmp->max_m; _m++) {
+				for (_p = nkmp->min_p; _p <= nkmp->max_p; _p <<= 1) {
 					unsigned long tmp_rate;
 
 					tmp_rate = parent * _n * _k / (_m * _p);
@@ -107,9 +107,13 @@ static long ccu_nkmp_round_rate(struct clk_hw *hw, unsigned long rate,
 	struct ccu_nkmp *nkmp = hw_to_ccu_nkmp(hw);
 	struct _ccu_nkmp _nkmp;
 
+	_nkmp.min_n = 1;
 	_nkmp.max_n = 1 << nkmp->n.width;
+	_nkmp.min_k = 1;
 	_nkmp.max_k = 1 << nkmp->k.width;
+	_nkmp.min_m = 1;
 	_nkmp.max_m = nkmp->m.max ?: 1 << nkmp->m.width;
+	_nkmp.min_p = 1;
 	_nkmp.max_p = nkmp->p.max ?: 1 << ((1 << nkmp->p.width) - 1);
 
 	ccu_nkmp_find_best(*parent_rate, rate, &_nkmp);
@@ -125,9 +129,13 @@ static int ccu_nkmp_set_rate(struct clk_hw *hw, unsigned long rate,
 	unsigned long flags;
 	u32 reg;
 
+	_nkmp.min_n = 1;
 	_nkmp.max_n = 1 << nkmp->n.width;
+	_nkmp.min_k = 1;
 	_nkmp.max_k = 1 << nkmp->k.width;
+	_nkmp.min_m = 1;
 	_nkmp.max_m = nkmp->m.max ?: 1 << nkmp->m.width;
+	_nkmp.min_p = 1;
 	_nkmp.max_p = nkmp->p.max ?: 1 << ((1 << nkmp->p.width) - 1);
 
 	ccu_nkmp_find_best(parent_rate, rate, &_nkmp);
diff --git a/drivers/clk/sunxi-ng/ccu_nm.c b/drivers/clk/sunxi-ng/ccu_nm.c
index c6d652289320..2a190bc032a9 100644
--- a/drivers/clk/sunxi-ng/ccu_nm.c
+++ b/drivers/clk/sunxi-ng/ccu_nm.c
@@ -15,8 +15,8 @@
 #include "ccu_nm.h"
 
 struct _ccu_nm {
-	unsigned long	n, max_n;
-	unsigned long	m, max_m;
+	unsigned long	n, min_n, max_n;
+	unsigned long	m, min_m, max_m;
 };
 
 static void ccu_nm_find_best(unsigned long parent, unsigned long rate,
@@ -26,8 +26,8 @@ static void ccu_nm_find_best(unsigned long parent, unsigned long rate,
 	unsigned long best_n = 0, best_m = 0;
 	unsigned long _n, _m;
 
-	for (_n = 1; _n <= nm->max_n; _n++) {
-		for (_m = 1; _n <= nm->max_m; _m++) {
+	for (_n = nm->min_n; _n <= nm->max_n; _n++) {
+		for (_m = nm->min_m; _n <= nm->max_m; _m++) {
 			unsigned long tmp_rate = parent * _n  / _m;
 
 			if (tmp_rate > rate)
@@ -93,7 +93,9 @@ static long ccu_nm_round_rate(struct clk_hw *hw, unsigned long rate,
 	struct ccu_nm *nm = hw_to_ccu_nm(hw);
 	struct _ccu_nm _nm;
 
+	_nm.min_n = 1;
 	_nm.max_n = 1 << nm->n.width;
+	_nm.min_m = 1;
 	_nm.max_m = nm->m.max ?: 1 << nm->m.width;
 
 	ccu_nm_find_best(*parent_rate, rate, &_nm);
@@ -114,7 +116,9 @@ static int ccu_nm_set_rate(struct clk_hw *hw, unsigned long rate,
 	else
 		ccu_frac_helper_disable(&nm->common, &nm->frac);
 
+	_nm.min_n = 1;
 	_nm.max_n = 1 << nm->n.width;
+	_nm.min_m = 1;
 	_nm.max_m = nm->m.max ?: 1 << nm->m.width;
 
 	ccu_nm_find_best(parent_rate, rate, &_nm);
-- 
git-series 0.8.10
