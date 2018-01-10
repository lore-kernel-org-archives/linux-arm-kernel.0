From: jernej.skrabec@siol.net (Jernej Skrabec)
Date: Wed, 10 Jan 2018 20:25:02 +0100
Subject: [PATCH v2 02/12] clk: sunxi-ng: Change formula for NKMP PLLs
In-Reply-To: <20180110192512.19684-1-jernej.skrabec@siol.net>
References: <20180110192512.19684-1-jernej.skrabec@siol.net>
Message-ID: <20180110192512.19684-3-jernej.skrabec@siol.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit changes formula from this:

Freq = (parent_freq * N * K) / (M * P)

to this:

Freq = (parent_freq / M) * N * K / P

This improves situation when N is in the range 1-255. PLL parent clock
is almost always 24 MHz, which means that for N >= 180 original formula
overflows and result becomes useless. Situation can be improved if M is
used as predivider as it can be seen in the second formula. That way at
least M > 1 is considered, but it still leaves small gap for wrong result
when M = 1 and N >= 180.

Using M as predivider shouldn't cause any issue, because it is in range
1-4 at most, so there is no or only minimal rounding error.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/clk/sunxi-ng/ccu_nkmp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu_nkmp.c b/drivers/clk/sunxi-ng/ccu_nkmp.c
index a99068a08315..e6c996ad4483 100644
--- a/drivers/clk/sunxi-ng/ccu_nkmp.c
+++ b/drivers/clk/sunxi-ng/ccu_nkmp.c
@@ -33,7 +33,7 @@ static void ccu_nkmp_find_best(unsigned long parent, unsigned long rate,
 				for (_p = nkmp->min_p; _p <= nkmp->max_p; _p <<= 1) {
 					unsigned long tmp_rate;
 
-					tmp_rate = parent * _n * _k / (_m * _p);
+					tmp_rate = (parent / _m) * _n * _k / _p;
 
 					if (tmp_rate > rate)
 						continue;
@@ -107,7 +107,7 @@ static unsigned long ccu_nkmp_recalc_rate(struct clk_hw *hw,
 	p = reg >> nkmp->p.shift;
 	p &= (1 << nkmp->p.width) - 1;
 
-	return (parent_rate * n * k >> p) / m;
+	return (parent_rate / m) * n * k >> p;
 }
 
 static long ccu_nkmp_round_rate(struct clk_hw *hw, unsigned long rate,
@@ -127,7 +127,7 @@ static long ccu_nkmp_round_rate(struct clk_hw *hw, unsigned long rate,
 
 	ccu_nkmp_find_best(*parent_rate, rate, &_nkmp);
 
-	return *parent_rate * _nkmp.n * _nkmp.k / (_nkmp.m * _nkmp.p);
+	return (*parent_rate / _nkmp.m) * _nkmp.n * _nkmp.k / _nkmp.p;
 }
 
 static int ccu_nkmp_set_rate(struct clk_hw *hw, unsigned long rate,
-- 
2.15.1
