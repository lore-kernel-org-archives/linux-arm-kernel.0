From: jp.francois@cynove.com (Jean-Philippe Francois)
Date: Thu, 30 May 2013 10:50:27 +0200
Subject: [PATCH v2 1/1] ARM : omap3 : fix wrong container_of in clock36xx.c
Message-ID: <1369903827-2025-1-git-send-email-jp.francois@cynove.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

omap36xx_pwrdn_clk_enable_with_hsdiv_restore expects the parent hw of the clock
to be a clk_hw_omap. However, looking at cclock3xxx_data.c, all concerned clock
have parent defined as clk_divider. Instead of using container_of to eventually get
to the register and directly mess with the divider, change freq via clk_set_rate, 
and let the clock framework toggle the divider value.
Tested with  3.9 on dm3730.

Signed-off-by: Jean-Philippe Fran??ois <jp.francois@cynove.com>

Index: b/arch/arm/mach-omap2/clock36xx.c
===================================================================
--- a/arch/arm/mach-omap2/clock36xx.c
+++ b/arch/arm/mach-omap2/clock36xx.c
@@ -39,30 +39,25 @@
  */
 int omap36xx_pwrdn_clk_enable_with_hsdiv_restore(struct clk_hw *clk)
 {
-	struct clk_hw_omap *parent;
-	struct clk_hw *parent_hw;
-	u32 dummy_v, orig_v, clksel_shift;
 	int ret;
 
 	/* Clear PWRDN bit of HSDIVIDER */
 	ret = omap2_dflt_clk_enable(clk);
 
-	parent_hw = __clk_get_hw(__clk_get_parent(clk->clk));
-	parent = to_clk_hw_omap(parent_hw);
-
-	/* Restore the dividers */
+	/* kick parent's clksel register after toggling PWRDN bit */
 	if (!ret) {
-		clksel_shift = __ffs(parent->clksel_mask);
-		orig_v = __raw_readl(parent->clksel_reg);
-		dummy_v = orig_v;
-
-		/* Write any other value different from the Read value */
-		dummy_v ^= (1 << clksel_shift);
-		__raw_writel(dummy_v, parent->clksel_reg);
-
-		/* Write the original divider */
-		__raw_writel(orig_v, parent->clksel_reg);
+		struct clk *parent = clk_get_parent(clk->clk);
+		unsigned long parent_rate = clk_get_rate(parent);
+		ret = clk_set_rate(parent, parent_rate/2);
+		if(ret)
+			goto badfreq;
+		ret = clk_set_rate(parent, parent_rate);
+		if(ret)
+			goto badfreq;
 	}
+	return ret;
 
+ badfreq :
+	omap2_dflt_clk_disable(clk);
 	return ret;
 }
