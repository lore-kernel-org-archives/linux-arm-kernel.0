From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 23 May 2014 15:51:10 +0800
Subject: [PATCH 07/22] clk: sunxi: Fix PLL6 calculation on sun6i
In-Reply-To: <1400831485-28576-1-git-send-email-wens@csie.org>
References: <1400831485-28576-1-git-send-email-wens@csie.org>
Message-ID: <1400831485-28576-8-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The N factor for PLL6 counts from 1 to 32, as specified in the A23
manual, and shown in Allwinner's original code.

This patch fixes the N factor in the clock driver, as well as the
comment describing it.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/clk/sunxi/clk-sunxi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index b2c6d12..6500a1b 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -198,7 +198,7 @@ static void sun4i_get_pll5_factors(u32 *freq, u32 parent_rate,
 /**
  * sun6i_a31_get_pll6_factors() - calculates n, k factors for A31 PLL6
  * PLL6 rate is calculated as follows
- * rate = parent_rate * n * (k + 1) / 2
+ * rate = parent_rate * (n + 1) * (k + 1) / 2
  * parent_rate is always 24Mhz
  */
 
@@ -225,7 +225,7 @@ static void sun6i_a31_get_pll6_factors(u32 *freq, u32 parent_rate,
 	if (*k > 3)
 		*k = 3;
 
-	*n = DIV_ROUND_UP(div, (*k+1));
+	*n = DIV_ROUND_UP(div, (*k+1)) - 1;
 }
 
 /**
@@ -434,6 +434,7 @@ static struct clk_factors_config sun6i_a31_pll6_config = {
 	.nwidth = 5,
 	.kshift = 4,
 	.kwidth = 2,
+	.n_from_one = 1,
 };
 
 static struct clk_factors_config sun4i_apb1_config = {
-- 
2.0.0.rc2
