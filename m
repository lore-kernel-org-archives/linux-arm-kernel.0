From: l.stach@pengutronix.de (Lucas Stach)
Date: Wed, 17 Jan 2018 16:02:56 +0100
Subject: [PATCH] clk: imx: pllv2: avoid using uninitialized values
Message-ID: <20180117150256.7430-1-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Forward the errors returned by __clk_pllv2_set_rate() in the recalc rate
function, to avoid using uninitialized values for the rate calculation.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/clk/imx/clk-pllv2.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-pllv2.c b/drivers/clk/imx/clk-pllv2.c
index 85b5cbe9744c..eeba3cb14e2d 100644
--- a/drivers/clk/imx/clk-pllv2.c
+++ b/drivers/clk/imx/clk-pllv2.c
@@ -182,8 +182,12 @@ static long clk_pllv2_round_rate(struct clk_hw *hw, unsigned long rate,
 		unsigned long *prate)
 {
 	u32 dp_op, dp_mfd, dp_mfn;
+	int ret;
+
+	ret = __clk_pllv2_set_rate(rate, *prate, &dp_op, &dp_mfd, &dp_mfn);
+	if (ret)
+		return ret;
 
-	__clk_pllv2_set_rate(rate, *prate, &dp_op, &dp_mfd, &dp_mfn);
 	return __clk_pllv2_recalc_rate(*prate, MXC_PLL_DP_CTL_DPDCK0_2_EN,
 			dp_op, dp_mfd, dp_mfn);
 }
-- 
2.11.0
