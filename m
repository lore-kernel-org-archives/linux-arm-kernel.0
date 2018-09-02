From: jernej.skrabec@siol.net (Jernej Skrabec)
Date: Sun,  2 Sep 2018 09:26:21 +0200
Subject: [PATCH 05/27] clk: sunxi-ng: Use u64 for calculation of NM rate
In-Reply-To: <20180902072643.4917-1-jernej.skrabec@siol.net>
References: <20180902072643.4917-1-jernej.skrabec@siol.net>
Message-ID: <20180902072643.4917-6-jernej.skrabec@siol.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner H6 SoC has multiplier N range between 1 and 254. Since parent
rate is 24MHz, intermediate result when calculating final rate easily
overflows 32 bit variable.

Because of that, introduce function for calculating clock rate which
uses 64 bit variable for intermediate result.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/clk/sunxi-ng/ccu_nm.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu_nm.c b/drivers/clk/sunxi-ng/ccu_nm.c
index 6fe3c14f7b2d..424d8635b053 100644
--- a/drivers/clk/sunxi-ng/ccu_nm.c
+++ b/drivers/clk/sunxi-ng/ccu_nm.c
@@ -19,6 +19,17 @@ struct _ccu_nm {
 	unsigned long	m, min_m, max_m;
 };
 
+static unsigned long ccu_nm_calc_rate(unsigned long parent,
+				      unsigned long n, unsigned long m)
+{
+	u64 rate = parent;
+
+	rate *= n;
+	do_div(rate, m);
+
+	return rate;
+}
+
 static void ccu_nm_find_best(unsigned long parent, unsigned long rate,
 			     struct _ccu_nm *nm)
 {
@@ -28,7 +39,8 @@ static void ccu_nm_find_best(unsigned long parent, unsigned long rate,
 
 	for (_n = nm->min_n; _n <= nm->max_n; _n++) {
 		for (_m = nm->min_m; _m <= nm->max_m; _m++) {
-			unsigned long tmp_rate = parent * _n  / _m;
+			unsigned long tmp_rate = ccu_nm_calc_rate(parent,
+								  _n, _m);
 
 			if (tmp_rate > rate)
 				continue;
@@ -100,7 +112,7 @@ static unsigned long ccu_nm_recalc_rate(struct clk_hw *hw,
 	if (ccu_sdm_helper_is_enabled(&nm->common, &nm->sdm))
 		rate = ccu_sdm_helper_read_rate(&nm->common, &nm->sdm, m, n);
 	else
-		rate = parent_rate * n / m;
+		rate = ccu_nm_calc_rate(parent_rate, n, m);
 
 	if (nm->common.features & CCU_FEATURE_FIXED_POSTDIV)
 		rate /= nm->fixed_post_div;
@@ -149,7 +161,7 @@ static long ccu_nm_round_rate(struct clk_hw *hw, unsigned long rate,
 	_nm.max_m = nm->m.max ?: 1 << nm->m.width;
 
 	ccu_nm_find_best(*parent_rate, rate, &_nm);
-	rate = *parent_rate * _nm.n / _nm.m;
+	rate = ccu_nm_calc_rate(*parent_rate, _nm.n, _nm.m);
 
 	if (nm->common.features & CCU_FEATURE_FIXED_POSTDIV)
 		rate /= nm->fixed_post_div;
-- 
2.18.0
