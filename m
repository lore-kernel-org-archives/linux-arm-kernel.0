From: abhijitpagare@ti.com (Abhijit Pagare)
Date: Fri, 11 Dec 2009 16:40:25 +0530
Subject: [PATCH 2/5] ARM: OMAP4: PM: Modify Clock-domain interfaces for OMAP4
	compatibility.
In-Reply-To: <1260529828-14862-1-git-send-email-abhijitpagare@ti.com>
References: <1260529828-14862-1-git-send-email-abhijitpagare@ti.com>
Message-ID: <1260529828-14862-2-git-send-email-abhijitpagare@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here the APIs are modified to use absolute addresses instead of module offsets.

Signed-off-by: Abhijit Pagare <abhijitpagare@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/clockdomain.c |   44 +++++++++++++++++++++----------------
 1 files changed, 25 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index 5c695b4..d51350c 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -147,25 +147,29 @@ static void _clkdm_del_autodeps(struct clockdomain *clkdm)
  */
 static void _omap2_clkdm_set_hwsup(struct clockdomain *clkdm, int enable)
 {
-	u32 v;
+	u32 bits, v;
 
 	if (cpu_is_omap24xx()) {
 		if (enable)
-			v = OMAP24XX_CLKSTCTRL_ENABLE_AUTO;
+			bits = OMAP24XX_CLKSTCTRL_ENABLE_AUTO;
 		else
-			v = OMAP24XX_CLKSTCTRL_DISABLE_AUTO;
+			bits = OMAP24XX_CLKSTCTRL_DISABLE_AUTO;
 	} else if (cpu_is_omap34xx()) {
 		if (enable)
-			v = OMAP34XX_CLKSTCTRL_ENABLE_AUTO;
+			bits = OMAP34XX_CLKSTCTRL_ENABLE_AUTO;
 		else
-			v = OMAP34XX_CLKSTCTRL_DISABLE_AUTO;
+			bits = OMAP34XX_CLKSTCTRL_DISABLE_AUTO;
 	} else {
 		BUG();
 	}
 
-	cm_rmw_mod_reg_bits(clkdm->clktrctrl_mask,
-			    v << __ffs(clkdm->clktrctrl_mask),
-			    clkdm->pwrdm.ptr->prcm_offs, OMAP2_CM_CLKSTCTRL);
+	bits = bits << __ffs(clkdm->clktrctrl_mask);
+
+	v = __raw_readl(clkdm->clkstctrl_reg);
+	v &= ~(clkdm->clktrctrl_mask);
+	v |= bits;
+	__raw_writel(v, clkdm->clkstctrl_reg);
+
 }
 
 static struct clockdomain *_clkdm_lookup(const char *name)
@@ -383,7 +387,7 @@ static int omap2_clkdm_clktrctrl_read(struct clockdomain *clkdm)
 	if (!clkdm)
 		return -EINVAL;
 
-	v = cm_read_mod_reg(clkdm->pwrdm.ptr->prcm_offs, OMAP2_CM_CLKSTCTRL);
+	v = __raw_readl(clkdm->clkstctrl_reg);
 	v &= clkdm->clktrctrl_mask;
 	v >>= __ffs(clkdm->clktrctrl_mask);
 
@@ -419,12 +423,13 @@ int omap2_clkdm_sleep(struct clockdomain *clkdm)
 
 	} else if (cpu_is_omap34xx()) {
 
-		u32 v = (OMAP34XX_CLKSTCTRL_FORCE_SLEEP <<
+		u32 bits = (OMAP34XX_CLKSTCTRL_FORCE_SLEEP <<
 			 __ffs(clkdm->clktrctrl_mask));
 
-		cm_rmw_mod_reg_bits(clkdm->clktrctrl_mask, v,
-				    clkdm->pwrdm.ptr->prcm_offs,
-							 OMAP2_CM_CLKSTCTRL);
+		u32 v = __raw_readl(clkdm->clkstctrl_reg);
+		v &= ~(clkdm->clktrctrl_mask);
+		v |= bits;
+		__raw_writel(v, clkdm->clkstctrl_reg);
 
 	} else {
 		BUG();
@@ -462,12 +467,13 @@ int omap2_clkdm_wakeup(struct clockdomain *clkdm)
 
 	} else if (cpu_is_omap34xx()) {
 
-		u32 v = (OMAP34XX_CLKSTCTRL_FORCE_WAKEUP <<
+		u32 bits = (OMAP34XX_CLKSTCTRL_FORCE_WAKEUP <<
 			 __ffs(clkdm->clktrctrl_mask));
 
-		cm_rmw_mod_reg_bits(clkdm->clktrctrl_mask, v,
-				    clkdm->pwrdm.ptr->prcm_offs,
-						 OMAP2_CM_CLKSTCTRL);
+		u32 v = __raw_readl(clkdm->clkstctrl_reg);
+		v &= ~(clkdm->clktrctrl_mask);
+		v |= bits;
+		__raw_writel(v, clkdm->clkstctrl_reg);
 
 	} else {
 		BUG();
@@ -563,7 +569,7 @@ int omap2_clkdm_clk_enable(struct clockdomain *clkdm, struct clk *clk)
 	 * downstream clocks for debugging purposes?
 	 */
 
-	if (!clkdm || !clk || !clkdm->clktrctrl_mask)
+	if (!clkdm || !clk || !clkdm->clkstctrl_reg)
 		return -EINVAL;
 
 	if (atomic_inc_return(&clkdm->usecount) > 1)
@@ -614,7 +620,7 @@ int omap2_clkdm_clk_disable(struct clockdomain *clkdm, struct clk *clk)
 	 * downstream clocks for debugging purposes?
 	 */
 
-	if (!clkdm || !clk || !clkdm->clktrctrl_mask)
+	if (!clkdm || !clk || !clkdm->clkstctrl_reg)
 		return -EINVAL;
 
 #ifdef DEBUG
-- 
1.5.4.7
