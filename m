From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 11 Oct 2016 16:28:20 +0200
Subject: [PATCH v4 2/9] clk: sunxi-ng: Remove the use of rational computations
In-Reply-To: <cover.024e1b023e41efe548dc6a004f7a946408d5c9a2.1476196031.git-series.maxime.ripard@free-electrons.com>
References: <cover.024e1b023e41efe548dc6a004f7a946408d5c9a2.1476196031.git-series.maxime.ripard@free-electrons.com>
Message-ID: <50a2c9fe665c794dc97f524cacb63dc83d3efaa2.1476196031.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While the rational library works great, it doesn't really allow us to add
more constraints, like the minimum.

Remove that in order to be able to deal with the constraints we'll need.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/clk/sunxi-ng/Kconfig    |  3 +--
 drivers/clk/sunxi-ng/ccu_nkm.c  | 31 +++++++++-----------
 drivers/clk/sunxi-ng/ccu_nkmp.c | 45 +++++++++++++---------------
 drivers/clk/sunxi-ng/ccu_nm.c   | 54 +++++++++++++++++++++++++---------
 4 files changed, 78 insertions(+), 55 deletions(-)

diff --git a/drivers/clk/sunxi-ng/Kconfig b/drivers/clk/sunxi-ng/Kconfig
index 254d9526c018..1b4c55a53d7a 100644
--- a/drivers/clk/sunxi-ng/Kconfig
+++ b/drivers/clk/sunxi-ng/Kconfig
@@ -35,17 +35,14 @@ config SUNXI_CCU_NK
 
 config SUNXI_CCU_NKM
 	bool
-	select RATIONAL
 	select SUNXI_CCU_GATE
 
 config SUNXI_CCU_NKMP
 	bool
-	select RATIONAL
 	select SUNXI_CCU_GATE
 
 config SUNXI_CCU_NM
 	bool
-	select RATIONAL
 	select SUNXI_CCU_FRAC
 	select SUNXI_CCU_GATE
 
diff --git a/drivers/clk/sunxi-ng/ccu_nkm.c b/drivers/clk/sunxi-ng/ccu_nkm.c
index 059fdc3b4f96..0b08d000eb38 100644
--- a/drivers/clk/sunxi-ng/ccu_nkm.c
+++ b/drivers/clk/sunxi-ng/ccu_nkm.c
@@ -9,7 +9,6 @@
  */
 
 #include <linux/clk-provider.h>
-#include <linux/rational.h>
 
 #include "ccu_gate.h"
 #include "ccu_nkm.h"
@@ -28,21 +27,21 @@ static void ccu_nkm_find_best(unsigned long parent, unsigned long rate,
 	unsigned long _n, _k, _m;
 
 	for (_k = 1; _k <= nkm->max_k; _k++) {
-		unsigned long tmp_rate;
-
-		rational_best_approximation(rate / _k, parent,
-					    nkm->max_n, nkm->max_m, &_n, &_m);
-
-		tmp_rate = parent * _n * _k / _m;
-
-		if (tmp_rate > rate)
-			continue;
-
-		if ((rate - tmp_rate) < (rate - best_rate)) {
-			best_rate = tmp_rate;
-			best_n = _n;
-			best_k = _k;
-			best_m = _m;
+		for (_n = 1; _n <= nkm->max_n; _n++) {
+			for (_m = 1; _n <= nkm->max_m; _m++) {
+				unsigned long tmp_rate;
+
+				tmp_rate = parent * _n * _k / _m;
+
+				if (tmp_rate > rate)
+					continue;
+				if ((rate - tmp_rate) < (rate - best_rate)) {
+					best_rate = tmp_rate;
+					best_n = _n;
+					best_k = _k;
+					best_m = _m;
+				}
+			}
 		}
 	}
 
diff --git a/drivers/clk/sunxi-ng/ccu_nkmp.c b/drivers/clk/sunxi-ng/ccu_nkmp.c
index 9769dee99511..4b457d8cce11 100644
--- a/drivers/clk/sunxi-ng/ccu_nkmp.c
+++ b/drivers/clk/sunxi-ng/ccu_nkmp.c
@@ -9,16 +9,15 @@
  */
 
 #include <linux/clk-provider.h>
-#include <linux/rational.h>
 
 #include "ccu_gate.h"
 #include "ccu_nkmp.h"
 
 struct _ccu_nkmp {
-	unsigned long	n, max_n;
-	unsigned long	k, max_k;
-	unsigned long	m, max_m;
-	unsigned long	p, max_p;
+	unsigned long	n, min_n, max_n;
+	unsigned long	k, min_k, max_k;
+	unsigned long	m, min_m, max_m;
+	unsigned long	p, min_p, max_p;
 };
 
 static void ccu_nkmp_find_best(unsigned long parent, unsigned long rate,
@@ -29,24 +28,24 @@ static void ccu_nkmp_find_best(unsigned long parent, unsigned long rate,
 	unsigned long _n, _k, _m, _p;
 
 	for (_k = 1; _k <= nkmp->max_k; _k++) {
-		for (_p = 1; _p <= nkmp->max_p; _p <<= 1) {
-			unsigned long tmp_rate;
-
-			rational_best_approximation(rate / _k, parent / _p,
-						    nkmp->max_n, nkmp->max_m,
-						    &_n, &_m);
-
-			tmp_rate = parent * _n * _k / (_m * _p);
-
-			if (tmp_rate > rate)
-				continue;
-
-			if ((rate - tmp_rate) < (rate - best_rate)) {
-				best_rate = tmp_rate;
-				best_n = _n;
-				best_k = _k;
-				best_m = _m;
-				best_p = _p;
+		for (_n = 1; _n <= nkm->max_n; _n++) {
+			for (_m = 1; _n <= nkm->max_m; _m++) {
+				for (_p = 1; _p <= nkmp->max_p; _p <<= 1) {
+					unsigned long tmp_rate;
+
+					tmp_rate = parent * _n * _k / (_m * _p);
+
+					if (tmp_rate > rate)
+						continue;
+
+					if ((rate - tmp_rate) < (rate - best_rate)) {
+						best_rate = tmp_rate;
+						best_n = _n;
+						best_k = _k;
+						best_m = _m;
+						best_p = _p;
+					}
+				}
 			}
 		}
 	}
diff --git a/drivers/clk/sunxi-ng/ccu_nm.c b/drivers/clk/sunxi-ng/ccu_nm.c
index b61bdd8c7a7f..c6d652289320 100644
--- a/drivers/clk/sunxi-ng/ccu_nm.c
+++ b/drivers/clk/sunxi-ng/ccu_nm.c
@@ -9,12 +9,42 @@
  */
 
 #include <linux/clk-provider.h>
-#include <linux/rational.h>
 
 #include "ccu_frac.h"
 #include "ccu_gate.h"
 #include "ccu_nm.h"
 
+struct _ccu_nm {
+	unsigned long	n, max_n;
+	unsigned long	m, max_m;
+};
+
+static void ccu_nm_find_best(unsigned long parent, unsigned long rate,
+			     struct _ccu_nm *nm)
+{
+	unsigned long best_rate = 0;
+	unsigned long best_n = 0, best_m = 0;
+	unsigned long _n, _m;
+
+	for (_n = 1; _n <= nm->max_n; _n++) {
+		for (_m = 1; _n <= nm->max_m; _m++) {
+			unsigned long tmp_rate = parent * _n  / _m;
+
+			if (tmp_rate > rate)
+				continue;
+
+			if ((rate - tmp_rate) < (rate - best_rate)) {
+				best_rate = tmp_rate;
+				best_n = _n;
+				best_m = _m;
+			}
+		}
+	}
+
+	nm->n = best_n;
+	nm->m = best_m;
+}
+
 static void ccu_nm_disable(struct clk_hw *hw)
 {
 	struct ccu_nm *nm = hw_to_ccu_nm(hw);
@@ -61,24 +91,22 @@ static long ccu_nm_round_rate(struct clk_hw *hw, unsigned long rate,
 			      unsigned long *parent_rate)
 {
 	struct ccu_nm *nm = hw_to_ccu_nm(hw);
-	unsigned long max_n, max_m;
-	unsigned long n, m;
+	struct _ccu_nm _nm;
 
-	max_n = 1 << nm->n.width;
-	max_m = nm->m.max ?: 1 << nm->m.width;
+	_nm.max_n = 1 << nm->n.width;
+	_nm.max_m = nm->m.max ?: 1 << nm->m.width;
 
-	rational_best_approximation(rate, *parent_rate, max_n, max_m, &n, &m);
+	ccu_nm_find_best(*parent_rate, rate, &_nm);
 
-	return *parent_rate * n / m;
+	return *parent_rate * _nm.n / _nm.m;
 }
 
 static int ccu_nm_set_rate(struct clk_hw *hw, unsigned long rate,
 			   unsigned long parent_rate)
 {
 	struct ccu_nm *nm = hw_to_ccu_nm(hw);
+	struct _ccu_nm _nm;
 	unsigned long flags;
-	unsigned long max_n, max_m;
-	unsigned long n, m;
 	u32 reg;
 
 	if (ccu_frac_helper_has_rate(&nm->common, &nm->frac, rate))
@@ -86,10 +114,10 @@ static int ccu_nm_set_rate(struct clk_hw *hw, unsigned long rate,
 	else
 		ccu_frac_helper_disable(&nm->common, &nm->frac);
 
-	max_n = 1 << nm->n.width;
-	max_m = nm->m.max ?: 1 << nm->m.width;
+	_nm.max_n = 1 << nm->n.width;
+	_nm.max_m = nm->m.max ?: 1 << nm->m.width;
 
-	rational_best_approximation(rate, parent_rate, max_n, max_m, &n, &m);
+	ccu_nm_find_best(parent_rate, rate, &_nm);
 
 	spin_lock_irqsave(nm->common.lock, flags);
 
@@ -97,7 +125,7 @@ static int ccu_nm_set_rate(struct clk_hw *hw, unsigned long rate,
 	reg &= ~GENMASK(nm->n.width + nm->n.shift - 1, nm->n.shift);
 	reg &= ~GENMASK(nm->m.width + nm->m.shift - 1, nm->m.shift);
 
-	writel(reg | ((m - 1) << nm->m.shift) | ((n - 1) << nm->n.shift),
+	writel(reg | ((_nm.m - 1) << nm->m.shift) | ((_nm.n - 1) << nm->n.shift),
 	       nm->common.base + nm->common.reg);
 
 	spin_unlock_irqrestore(nm->common.lock, flags);
-- 
git-series 0.8.10
