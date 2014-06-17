From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 17 Jun 2014 22:52:44 +0800
Subject: [PATCH v2 07/20] clk: sunxi: Fix PLL6 calculation on sun6i
In-Reply-To: <1403016777-15121-1-git-send-email-wens@csie.org>
References: <1403016777-15121-1-git-send-email-wens@csie.org>
Message-ID: <1403016777-15121-8-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The N factor for PLL6 counts from 1 to 32, as specified in the A23
manual, and shown in Allwinner's original code.

Also the PLL6 factors calculate the clock rate for PLL6x2, not the
normal halved output for PLL6. This is what the factors clk
.recalc_rate callback expects.

This patch fixes the N factor in the clock driver, calculates the
rate for PLL6x2, and fixes the comment describing it.

A further patch (to the DT) should add a fixed-factor /2 clock as
the normally used PLL6 output.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/clk/sunxi/clk-sunxi.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index dc2176f..eca3c6e 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -196,9 +196,9 @@ static void sun4i_get_pll5_factors(u32 *freq, u32 parent_rate,
 }
 
 /**
- * sun6i_a31_get_pll6_factors() - calculates n, k factors for A31 PLL6
- * PLL6 rate is calculated as follows
- * rate = parent_rate * n * (k + 1) / 2
+ * sun6i_a31_get_pll6_factors() - calculates n, k factors for A31 PLL6 (x2)
+ * PLL6 (x2) rate is calculated as follows
+ * rate = parent_rate * (n + 1) * (k + 1)
  * parent_rate is always 24Mhz
  */
 
@@ -207,13 +207,7 @@ static void sun6i_a31_get_pll6_factors(u32 *freq, u32 parent_rate,
 {
 	u8 div;
 
-	/*
-	 * We always have 24MHz / 2, so we can just say that our
-	 * parent clock is 12MHz.
-	 */
-	parent_rate = parent_rate / 2;
-
-	/* Normalize value to a parent_rate multiple (24M / 2) */
+	/* Normalize value to a parent_rate multiple (24M) */
 	div = *freq / parent_rate;
 	*freq = parent_rate * div;
 
@@ -225,7 +219,7 @@ static void sun6i_a31_get_pll6_factors(u32 *freq, u32 parent_rate,
 	if (*k > 3)
 		*k = 3;
 
-	*n = DIV_ROUND_UP(div, (*k+1));
+	*n = DIV_ROUND_UP(div, (*k+1)) - 1;
 }
 
 /**
@@ -435,6 +429,7 @@ static struct clk_factors_config sun6i_a31_pll6_config = {
 	.nwidth = 5,
 	.kshift = 4,
 	.kwidth = 2,
+	.n_from_one = 1,
 };
 
 static struct clk_factors_config sun4i_apb1_config = {
-- 
2.0.0
