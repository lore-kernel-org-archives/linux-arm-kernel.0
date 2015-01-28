From: tony@atomide.com (Tony Lindgren)
Date: Wed, 28 Jan 2015 09:00:49 -0800
Subject: [PATCH] clk: ti: Fix FAPLL parent enable bit handling
Message-ID: <20150128170048.GO28663@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 163152cbbe32 ("clk: ti: Add support for FAPLL on dm816x")
added basic support for the FAPLL on dm818x, but has a bug for the
parent PLL enable bit. The FAPLL_MAIN_PLLEN is defined as BIT(3)
but the code is doing a shift on it.

This means the parent PLL won't get disabled even if all it's child
synthesizers are disabled.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Brian Hutchinson <b.hutchman@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/drivers/clk/ti/fapll.c
+++ b/drivers/clk/ti/fapll.c
@@ -84,7 +84,7 @@ static int ti_fapll_enable(struct clk_hw *hw)
 	struct fapll_data *fd = to_fapll(hw);
 	u32 v = readl_relaxed(fd->base);
 
-	v |= (1 << FAPLL_MAIN_PLLEN);
+	v |= FAPLL_MAIN_PLLEN;
 	writel_relaxed(v, fd->base);
 
 	return 0;
@@ -95,7 +95,7 @@ static void ti_fapll_disable(struct clk_hw *hw)
 	struct fapll_data *fd = to_fapll(hw);
 	u32 v = readl_relaxed(fd->base);
 
-	v &= ~(1 << FAPLL_MAIN_PLLEN);
+	v &= ~FAPLL_MAIN_PLLEN;
 	writel_relaxed(v, fd->base);
 }
 
@@ -104,7 +104,7 @@ static int ti_fapll_is_enabled(struct clk_hw *hw)
 	struct fapll_data *fd = to_fapll(hw);
 	u32 v = readl_relaxed(fd->base);
 
-	return v & (1 << FAPLL_MAIN_PLLEN);
+	return v & FAPLL_MAIN_PLLEN;
 }
 
 static unsigned long ti_fapll_recalc_rate(struct clk_hw *hw,
