From: eric@anholt.net (Eric Anholt)
Date: Fri, 30 Sep 2016 10:07:27 -0700
Subject: [PATCH v2] clk: bcm2835: Clamp the PLL's requested rate to the
 hardware limits.
Message-ID: <20160930170727.32544-1-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixes setting low-resolution video modes on HDMI.  Now the PLLH_PIX
divider adjusts itself until the PLLH is within bounds.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 drivers/clk/bcm/clk-bcm2835.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
index 7a7970865c2d..69a1849d140c 100644
--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -499,8 +499,12 @@ static long bcm2835_pll_rate_from_divisors(unsigned long parent_rate,
 static long bcm2835_pll_round_rate(struct clk_hw *hw, unsigned long rate,
 				   unsigned long *parent_rate)
 {
+	struct bcm2835_pll *pll = container_of(hw, struct bcm2835_pll, hw);
+	const struct bcm2835_pll_data *data = pll->data;
 	u32 ndiv, fdiv;
 
+	rate = clamp(rate, data->min_rate, data->max_rate);
+
 	bcm2835_pll_choose_ndiv_and_fdiv(rate, *parent_rate, &ndiv, &fdiv);
 
 	return bcm2835_pll_rate_from_divisors(*parent_rate, ndiv, fdiv, 1);
@@ -605,13 +609,6 @@ static int bcm2835_pll_set_rate(struct clk_hw *hw,
 	u32 ana[4];
 	int i;
 
-	if (rate < data->min_rate || rate > data->max_rate) {
-		dev_err(cprman->dev, "%s: rate out of spec: %lu vs (%lu, %lu)\n",
-			clk_hw_get_name(hw), rate,
-			data->min_rate, data->max_rate);
-		return -EINVAL;
-	}
-
 	if (rate > data->max_fb_rate) {
 		use_fb_prediv = true;
 		rate /= 2;
-- 
2.9.3
