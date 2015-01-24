From: hdegoede@redhat.com (Hans de Goede)
Date: Sat, 24 Jan 2015 12:56:31 +0100
Subject: [PATCH 1/2] clk: sunxi: rewrite sun9i_a80_get_pll4_factors()
Message-ID: <1422100592-19981-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The old implementation of sun9i_a80_get_pll4_factors() has several issues,
it checks against 256 / 512 in various places where it should use 255 / 511,
it does the wrong thing for low frequencies which are an even multiple of
6 MHz, e.g. if you ask it for 72 MHz it will result in 144 Mhz, and it does
not take into account that n must be at least 12. Moreover it is quite hard
to read / follow it.

This commit rewrites it to be correct in all cases, and makes it much easier
to follow the code / to read.

Cc: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/clk/sunxi/clk-sun9i-core.c | 57 +++++++++++++++++++-------------------
 1 file changed, 29 insertions(+), 28 deletions(-)

diff --git a/drivers/clk/sunxi/clk-sun9i-core.c b/drivers/clk/sunxi/clk-sun9i-core.c
index 9b5e7a1..d8da77d 100644
--- a/drivers/clk/sunxi/clk-sun9i-core.c
+++ b/drivers/clk/sunxi/clk-sun9i-core.c
@@ -24,50 +24,51 @@
 
 
 /**
- * sun9i_a80_get_pll4_factors() - calculates n, p, m factors for PLL1
+ * sun9i_a80_get_pll4_factors() - calculates n, p, m factors for PLL4
  * PLL4 rate is calculated as follows
  * rate = (parent_rate * n >> p) / (m + 1);
- * parent_rate is always 24Mhz
+ * parent_rate is always 24MHz
  *
  * p and m are named div1 and div2 in Allwinner's SDK
  */
 
 static void sun9i_a80_get_pll4_factors(u32 *freq, u32 parent_rate,
-				       u8 *n, u8 *k, u8 *m, u8 *p)
+				       u8 *n_ret, u8 *k, u8 *m_ret, u8 *p_ret)
 {
-	int div;
+	int n;
+	int m = 1;
+	int p = 1;
 
-	/* Normalize value to a 6M multiple */
-	div = DIV_ROUND_UP(*freq, 6000000);
+	/* Normalize value to a 6 MHz multiple (24 MHz / 4) */
+	n = DIV_ROUND_UP(*freq, 6000000);
 
-	/* divs above 256 cannot be odd */
-	if (div > 256)
-		div = round_up(div, 2);
+	/* If n is too large switch to steps of 12 MHz */
+	if (n > 255) {
+		m = 0;
+		n = (n + 1) / 2;
+	}
+
+	/* If n is still too large switch to steps of 24 MHz */
+	if (n > 255) {
+		p = 0;
+		n = (n + 1) / 2;
+	}
 
-	/* divs above 512 must be a multiple of 4 */
-	if (div > 512)
-		div = round_up(div, 4);
+	/* n must be between 12 and 255 */
+	if (n > 255)
+		n = 255;
+	else if (n < 12)
+		n = 12;
 
-	*freq = 6000000 * div;
+	*freq = ((24000000 * n) >> p) / (m + 1);
 
 	/* we were called to round the frequency, we can now return */
-	if (n == NULL)
+	if (n_ret == NULL)
 		return;
 
-	/* p will be 1 for divs under 512 */
-	if (div < 512)
-		*p = 1;
-	else
-		*p = 0;
-
-	/* m will be 1 if div is odd */
-	if (div & 1)
-		*m = 1;
-	else
-		*m = 0;
-
-	/* calculate a suitable n based on m and p */
-	*n = div / (*p + 1) / (*m + 1);
+	*n_ret = n;
+	*m_ret = m;
+	*p_ret = p;
 }
 
 static struct clk_factors_config sun9i_a80_pll4_config = {
-- 
2.1.0
