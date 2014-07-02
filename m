From: t-kristo@ti.com (Tero Kristo)
Date: Wed, 2 Jul 2014 11:47:41 +0300
Subject: [PATCH 07/13] ARM: OMAP2+: clock/dpll: add private API for checking
 if DPLL is in bypass
In-Reply-To: <1404290867-6768-1-git-send-email-t-kristo@ti.com>
References: <1404290867-6768-1-git-send-email-t-kristo@ti.com>
Message-ID: <1404290867-6768-8-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, same functionality is copy pasted in two locations. Instead,
add a private API for this and get rid of some duplicated code.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/clkt_dpll.c |   60 +++++++++++++++++++++------------------
 1 file changed, 32 insertions(+), 28 deletions(-)

diff --git a/arch/arm/mach-omap2/clkt_dpll.c b/arch/arm/mach-omap2/clkt_dpll.c
index 5207e84..f1b052a 100644
--- a/arch/arm/mach-omap2/clkt_dpll.c
+++ b/arch/arm/mach-omap2/clkt_dpll.c
@@ -175,6 +175,33 @@ static int _dpll_test_mult(int *m, int n, unsigned long *new_rate,
 	return r;
 }
 
+/**
+ * _omap2_dpll_is_in_bypass - check if DPLL is in bypass mode or not
+ * @v: bitfield value of the DPLL enable
+ *
+ * Checks given DPLL enable bitfield to see whether the DPLL is in bypass
+ * mode or not. Returns 1 if the DPLL is in bypass, 0 otherwise.
+ */
+static int _omap2_dpll_is_in_bypass(u32 v)
+{
+	if (cpu_is_omap24xx()) {
+		if (v == OMAP2XXX_EN_DPLL_LPBYPASS ||
+		    v == OMAP2XXX_EN_DPLL_FRBYPASS)
+			return 1;
+	} else if (cpu_is_omap34xx()) {
+		if (v == OMAP3XXX_EN_DPLL_LPBYPASS ||
+		    v == OMAP3XXX_EN_DPLL_FRBYPASS)
+			return 1;
+	} else if (soc_is_am33xx() || cpu_is_omap44xx() || soc_is_am43xx()) {
+		if (v == OMAP4XXX_EN_DPLL_LPBYPASS ||
+		    v == OMAP4XXX_EN_DPLL_FRBYPASS ||
+		    v == OMAP4XXX_EN_DPLL_MNBYPASS)
+			return 1;
+	}
+
+	return 0;
+}
+
 /* Public functions */
 u8 omap2_init_dpll_parent(struct clk_hw *hw)
 {
@@ -191,20 +218,9 @@ u8 omap2_init_dpll_parent(struct clk_hw *hw)
 	v >>= __ffs(dd->enable_mask);
 
 	/* Reparent the struct clk in case the dpll is in bypass */
-	if (cpu_is_omap24xx()) {
-		if (v == OMAP2XXX_EN_DPLL_LPBYPASS ||
-		    v == OMAP2XXX_EN_DPLL_FRBYPASS)
-			return 1;
-	} else if (cpu_is_omap34xx()) {
-		if (v == OMAP3XXX_EN_DPLL_LPBYPASS ||
-		    v == OMAP3XXX_EN_DPLL_FRBYPASS)
-			return 1;
-	} else if (soc_is_am33xx() || cpu_is_omap44xx() || soc_is_am43xx()) {
-		if (v == OMAP4XXX_EN_DPLL_LPBYPASS ||
-		    v == OMAP4XXX_EN_DPLL_FRBYPASS ||
-		    v == OMAP4XXX_EN_DPLL_MNBYPASS)
-			return 1;
-	}
+	if (_omap2_dpll_is_in_bypass(v))
+		return 1;
+
 	return 0;
 }
 
@@ -237,20 +253,8 @@ unsigned long omap2_get_dpll_rate(struct clk_hw_omap *clk)
 	v &= dd->enable_mask;
 	v >>= __ffs(dd->enable_mask);
 
-	if (cpu_is_omap24xx()) {
-		if (v == OMAP2XXX_EN_DPLL_LPBYPASS ||
-		    v == OMAP2XXX_EN_DPLL_FRBYPASS)
-			return __clk_get_rate(dd->clk_bypass);
-	} else if (cpu_is_omap34xx()) {
-		if (v == OMAP3XXX_EN_DPLL_LPBYPASS ||
-		    v == OMAP3XXX_EN_DPLL_FRBYPASS)
-			return __clk_get_rate(dd->clk_bypass);
-	} else if (soc_is_am33xx() || cpu_is_omap44xx() || soc_is_am43xx()) {
-		if (v == OMAP4XXX_EN_DPLL_LPBYPASS ||
-		    v == OMAP4XXX_EN_DPLL_FRBYPASS ||
-		    v == OMAP4XXX_EN_DPLL_MNBYPASS)
-			return __clk_get_rate(dd->clk_bypass);
-	}
+	if (_omap2_dpll_is_in_bypass(v))
+		return __clk_get_rate(dd->clk_bypass);
 
 	v = omap2_clk_readl(clk, dd->mult_div1_reg);
 	dpll_mult = v & dd->mult_mask;
-- 
1.7.9.5
