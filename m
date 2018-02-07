From: jernej.skrabec@siol.net (Jernej Skrabec)
Date: Wed,  7 Feb 2018 22:17:03 +0100
Subject: [PATCH v4 02/12] clk: sunxi-ng: Use u64 for calculation of nkmp rate
In-Reply-To: <20180207211713.3638-1-jernej.skrabec@siol.net>
References: <20180207211713.3638-1-jernej.skrabec@siol.net>
Message-ID: <20180207211713.3638-3-jernej.skrabec@siol.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When parent rate is 24MHz and multiplier N >= 180, intermediate clock
rate doesn't fit in 32 bit variable anymore.

Because of that, introduce function for calculating clock rate which
uses 64 bit variable for intermediate result.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/clk/sunxi-ng/ccu_nkmp.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu_nkmp.c b/drivers/clk/sunxi-ng/ccu_nkmp.c
index a99068a08315..c3f6fe7be565 100644
--- a/drivers/clk/sunxi-ng/ccu_nkmp.c
+++ b/drivers/clk/sunxi-ng/ccu_nkmp.c
@@ -20,6 +20,18 @@ struct _ccu_nkmp {
 	unsigned long	p, min_p, max_p;
 };
 
+static unsigned long ccu_nkmp_calc_rate(unsigned long parent,
+					unsigned long n, unsigned long k,
+					unsigned long m, unsigned long p)
+{
+	u64 rate = parent;
+
+	rate *= n * k;
+	do_div(rate, m * p);
+
+	return rate;
+}
+
 static void ccu_nkmp_find_best(unsigned long parent, unsigned long rate,
 			       struct _ccu_nkmp *nkmp)
 {
@@ -33,7 +45,9 @@ static void ccu_nkmp_find_best(unsigned long parent, unsigned long rate,
 				for (_p = nkmp->min_p; _p <= nkmp->max_p; _p <<= 1) {
 					unsigned long tmp_rate;
 
-					tmp_rate = parent * _n * _k / (_m * _p);
+					tmp_rate = ccu_nkmp_calc_rate(parent,
+								      _n, _k,
+								      _m, _p);
 
 					if (tmp_rate > rate)
 						continue;
@@ -107,7 +121,7 @@ static unsigned long ccu_nkmp_recalc_rate(struct clk_hw *hw,
 	p = reg >> nkmp->p.shift;
 	p &= (1 << nkmp->p.width) - 1;
 
-	return (parent_rate * n * k >> p) / m;
+	return ccu_nkmp_calc_rate(parent_rate, n, k, m, 1 << p);
 }
 
 static long ccu_nkmp_round_rate(struct clk_hw *hw, unsigned long rate,
@@ -127,7 +141,8 @@ static long ccu_nkmp_round_rate(struct clk_hw *hw, unsigned long rate,
 
 	ccu_nkmp_find_best(*parent_rate, rate, &_nkmp);
 
-	return *parent_rate * _nkmp.n * _nkmp.k / (_nkmp.m * _nkmp.p);
+	return ccu_nkmp_calc_rate(*parent_rate, _nkmp.n, _nkmp.k,
+				  _nkmp.m, _nkmp.p);
 }
 
 static int ccu_nkmp_set_rate(struct clk_hw *hw, unsigned long rate,
-- 
2.16.1
