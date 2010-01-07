From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Fri, 08 Jan 2010 10:44:12 +1100
Subject: [RFC,PATCH 7/7] arm/icst307: remove icst307_ps_to_vco
In-Reply-To: <1262907852.736281.78480196040.1.gpush@pororo>
Message-ID: <1262907852.738624.359759052540.7.gpush@pororo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

icst307_ps_to_vco isn't used, so remove it.

Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>

---
 arch/arm/common/icst307.c |   62 --------------------------------------
 1 file changed, 62 deletions(-)

diff --git a/arch/arm/common/icst307.c b/arch/arm/common/icst307.c
index 4c6cfb4..b4899c7 100644
--- a/arch/arm/common/icst307.c
+++ b/arch/arm/common/icst307.c
@@ -96,68 +96,6 @@ icst307_khz_to_vco(const struct icst307_params *p, unsigned long freq)
 	return vco;
 }
 
-static struct icst307_vco
-icst307_ps_to_vco(const struct icst307_params *p, unsigned long period)
-{
-	struct icst307_vco vco = { .s = 1, .v = p->vd_max, .r = p->rd_max };
-	unsigned long f, ps;
-	unsigned int i = 0, rd, best = (unsigned int)-1;
-
-	ps = 1000000000UL / p->vco_max;
-
-	/*
-	 * First, find the PLL output divisor such
-	 * that the PLL output is within spec.
-	 */
-	do {
-		f = period / s2div[idx2s[i]];
-
-		/*
-		 * f must be between 6MHz and 200MHz (3.3 or 5V)
-		 */
-		if (f >= ps && f < 1000000000UL / 6000 + 1)
-			break;
-	} while (i < ARRAY_SIZE(idx2s));
-
-	if (i >= ARRAY_SIZE(idx2s))
-		return vco;
-
-	vco.s = idx2s[i];
-
-	ps = 500000000UL / p->ref;
-
-	/*
-	 * Now find the closest divisor combination
-	 * which gives a PLL output of 'f'.
-	 */
-	for (rd = p->rd_min; rd <= p->rd_max; rd++) {
-		unsigned long f_in_div, f_pll;
-		unsigned int vd;
-		int f_diff;
-
-		f_in_div = ps * rd;
-
-		vd = (f_in_div + f / 2) / f;
-		if (vd < p->vd_min || vd > p->vd_max)
-			continue;
-
-		f_pll = (f_in_div + vd / 2) / vd;
-		f_diff = f_pll - f;
-		if (f_diff < 0)
-			f_diff = -f_diff;
-
-		if ((unsigned)f_diff < best) {
-			vco.v = vd - 8;
-			vco.r = rd - 2;
-			if (f_diff == 0)
-				break;
-			best = f_diff;
-		}
-	}
-
-	return vco;
-}
-
 unsigned long clk_icst307_get_rate(struct clk *clk)
 {
 	return to_clk_icst307(clk)->rate;
