From: mweseloh42@gmail.com (Marcus Weseloh)
Date: Mon, 28 Dec 2015 18:31:32 +0100
Subject: [PATCH] clk: sunxi: Fix mod0 clock calculation to return stable
 results and check divisor size limits
Message-ID: <1451323892-13060-1-git-send-email-mweseloh42@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes some problems in the mod0 clock calculation. It has
the potential to break stuff, as the issues explained below had the
effect that clk_set_rate would always return successfully, sometimes
setting a frequency that is higher than the requested value. Code that
"accidentally worked" because of this might fail after applying
this patch.

The problems in detail:

1. If a very low frequency is requested from a high parent clock, the
divisors "div" and "calcm" might be > 255. This patch changes the type
of both variables to unsigned int, because the silent cast to u8 will
result in invalid frequencies and register values.

2. The width of the "m" divisor in the clock control registers is only
4 bit, but that limitation is not checked when calculating the divisor
and the resulting frequency. This patch adds a check that m never
exceeds the field width.

3. During a call to clk_set_rate, the sun4i_a10_get_mod0_factors
function is called multiple times: first to find the best parent and
frequency, then again to calculate the p and m divisors, passing the
frequencies returned by the previous call(s). In certain cases
those chained calls do not result in the best frequency choice.

An example:
parent_rate = 24Mhz, freq = 1.4Mhz results in p=1, m=9, freq=1333333,3333
(which gets rounded down to 1333333).
Calling the function again with parent_rate = 24Mhz and freq = 1333333
results in p=1, m=10, freq=1200000.

Rounding up the returned frequency removes this problem.

Signed-off-by: Marcus Weseloh <mweseloh42@gmail.com>
---
 drivers/clk/sunxi/clk-mod0.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/sunxi/clk-mod0.c b/drivers/clk/sunxi/clk-mod0.c
index d167e1e..d03f099 100644
--- a/drivers/clk/sunxi/clk-mod0.c
+++ b/drivers/clk/sunxi/clk-mod0.c
@@ -31,7 +31,8 @@
 static void sun4i_a10_get_mod0_factors(u32 *freq, u32 parent_rate,
 				       u8 *n, u8 *k, u8 *m, u8 *p)
 {
-	u8 div, calcm, calcp;
+	unsigned int div, calcm;
+	u8 calcp;
 
 	/* These clocks can only divide, so we will never be able to achieve
 	 * frequencies higher than the parent frequency */
@@ -50,8 +51,10 @@ static void sun4i_a10_get_mod0_factors(u32 *freq, u32 parent_rate,
 		calcp = 3;
 
 	calcm = DIV_ROUND_UP(div, 1 << calcp);
+	if (calcm > 16)
+		calcm = 16;
 
-	*freq = (parent_rate >> calcp) / calcm;
+	*freq = DIV_ROUND_UP(parent_rate >> calcp, calcm);
 
 	/* we were called to round the frequency, we can now return */
 	if (n == NULL)
-- 
1.9.1
