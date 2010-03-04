From: linux@arm.linux.org.uk (Russell King)
Date: Thu, 04 Mar 2010 19:11:56 +0000
Subject: [PATCH] ARM: ICST: icst.*_ps_to_vco() functions are unused,
	remove them
References: <git-1267729916-d7b7baa36d825d0372850f49532dd8991b625e57@rmk-PC>
Message-ID: <git-1267729916-d9e7099903d7e6aeb982cf23eca37d0d92e92484@rmk-PC>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


These functions were originally implemented for the CLCD driver before
we had clk API support.  Since the CLCD driver does not use these
anymore, we can remove them.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/common/icst307.c               |   64 ------------------------------
 arch/arm/common/icst525.c               |   65 -------------------------------
 arch/arm/include/asm/hardware/icst307.h |    1 -
 arch/arm/include/asm/hardware/icst525.h |    1 -
 4 files changed, 0 insertions(+), 131 deletions(-)

diff --git a/arch/arm/common/icst307.c b/arch/arm/common/icst307.c
index 2eebd96..f78f5b5 100644
--- a/arch/arm/common/icst307.c
+++ b/arch/arm/common/icst307.c
@@ -95,67 +95,3 @@ icst307_khz_to_vco(const struct icst_params *p, unsigned long freq)
 }
 
 EXPORT_SYMBOL(icst307_khz_to_vco);
-
-struct icst_vco
-icst307_ps_to_vco(const struct icst_params *p, unsigned long period)
-{
-	struct icst_vco vco = { .s = 1, .v = p->vd_max, .r = p->rd_max };
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
-EXPORT_SYMBOL(icst307_ps_to_vco);
diff --git a/arch/arm/common/icst525.c b/arch/arm/common/icst525.c
index fd5c2e7..eadf983 100644
--- a/arch/arm/common/icst525.c
+++ b/arch/arm/common/icst525.c
@@ -93,68 +93,3 @@ icst525_khz_to_vco(const struct icst_params *p, unsigned long freq)
 }
 
 EXPORT_SYMBOL(icst525_khz_to_vco);
-
-struct icst_vco
-icst525_ps_to_vco(const struct icst_params *p, unsigned long period)
-{
-	struct icst_vco vco = { .s = 1, .v = p->vd_max, .r = p->rd_max };
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
-		 * f must be between 10MHz and
-		 *  320MHz (5V) or 200MHz (3V)
-		 */
-		if (f >= ps && f < 100000)
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
-EXPORT_SYMBOL(icst525_ps_to_vco);
diff --git a/arch/arm/include/asm/hardware/icst307.h b/arch/arm/include/asm/hardware/icst307.h
index 85932e9..8d0820a 100644
--- a/arch/arm/include/asm/hardware/icst307.h
+++ b/arch/arm/include/asm/hardware/icst307.h
@@ -20,6 +20,5 @@
 
 unsigned long icst307_khz(const struct icst_params *p, struct icst_vco vco);
 struct icst_vco icst307_khz_to_vco(const struct icst_params *p, unsigned long freq);
-struct icst_vco icst307_ps_to_vco(const struct icst_params *p, unsigned long period);
 
 #endif
diff --git a/arch/arm/include/asm/hardware/icst525.h b/arch/arm/include/asm/hardware/icst525.h
index 170deb2..42a274e 100644
--- a/arch/arm/include/asm/hardware/icst525.h
+++ b/arch/arm/include/asm/hardware/icst525.h
@@ -18,6 +18,5 @@
 
 unsigned long icst525_khz(const struct icst_params *p, struct icst_vco vco);
 struct icst_vco icst525_khz_to_vco(const struct icst_params *p, unsigned long freq);
-struct icst_vco icst525_ps_to_vco(const struct icst_params *p, unsigned long period);
 
 #endif
