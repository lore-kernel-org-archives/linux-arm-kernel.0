From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 27 May 2013 18:00:51 +0900
Subject: [PATCH 7/8] ARM: shmobile: sh73a0: do not overwrite all div4 clock
 operations
In-Reply-To: <1369645252-3847-1-git-send-email-horms+renesas@verge.net.au>
References: <1369645252-3847-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1369645252-3847-8-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

An earlier commit "ARM: shmobile: sh73a0: add support for adjusting CPU
frequency" intended to replace some clock operations only for the Z-clock,
instead it replaced them for all div4 clocks, since all div4 clocks share
the same copy of clock operations. Fix this by using a separate clock
operations structure for Z-clock.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/clock-sh73a0.c |   28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-sh73a0.c b/arch/arm/mach-shmobile/clock-sh73a0.c
index acb9e09..d05cf90 100644
--- a/arch/arm/mach-shmobile/clock-sh73a0.c
+++ b/arch/arm/mach-shmobile/clock-sh73a0.c
@@ -257,9 +257,8 @@ static struct clk twd_clk = {
 	.ops = &twd_clk_ops,
 };
 
-static int (*div4_set_rate)(struct clk *clk, unsigned long rate);
-static unsigned long (*div4_recalc)(struct clk *clk);
-static long (*div4_round_rate)(struct clk *clk, unsigned long rate);
+static struct sh_clk_ops zclk_ops;
+static const struct sh_clk_ops *div4_clk_ops;
 
 static int zclk_set_rate(struct clk *clk, unsigned long rate)
 {
@@ -275,7 +274,7 @@ static int zclk_set_rate(struct clk *clk, unsigned long rate)
 		/* 1:1 - switch off divider */
 		__raw_writel(__raw_readl(FRQCRB) & ~(1 << 28), FRQCRB);
 		/* nullify the divider to prepare for the next time */
-		ret = div4_set_rate(clk, rate / 2);
+		ret = div4_clk_ops->set_rate(clk, rate / 2);
 		if (!ret)
 			ret = frqcr_kick();
 		if (ret > 0)
@@ -290,7 +289,7 @@ static int zclk_set_rate(struct clk *clk, unsigned long rate)
 			 * set the divider - call the DIV4 method, it will kick
 			 * FRQCRB too
 			 */
-			ret = div4_set_rate(clk, rate);
+			ret = div4_clk_ops->set_rate(clk, rate);
 		if (ret < 0)
 			goto esetrate;
 	}
@@ -302,7 +301,7 @@ esetrate:
 
 static long zclk_round_rate(struct clk *clk, unsigned long rate)
 {
-	unsigned long div_freq = div4_round_rate(clk, rate),
+	unsigned long div_freq = div4_clk_ops->round_rate(clk, rate),
 		parent_freq = clk_get_rate(clk->parent);
 
 	if (rate > div_freq && abs(parent_freq - rate) < rate - div_freq)
@@ -317,7 +316,7 @@ static unsigned long zclk_recalc(struct clk *clk)
 	 * Must recalculate frequencies in case PLL0 has been changed, even if
 	 * the divisor is unused ATM!
 	 */
-	unsigned long div_freq = div4_recalc(clk);
+	unsigned long div_freq = div4_clk_ops->recalc(clk);
 
 	if (__raw_readl(FRQCRB) & (1 << 28))
 		return div_freq;
@@ -327,13 +326,16 @@ static unsigned long zclk_recalc(struct clk *clk)
 
 static void zclk_extend(void)
 {
+	div4_clk_ops = div4_clks[DIV4_Z].ops;
+
 	/* We extend the DIV4 clock with a 1:1 pass-through case */
-	div4_set_rate = div4_clks[DIV4_Z].ops->set_rate;
-	div4_round_rate = div4_clks[DIV4_Z].ops->round_rate;
-	div4_recalc = div4_clks[DIV4_Z].ops->recalc;
-	div4_clks[DIV4_Z].ops->set_rate = zclk_set_rate;
-	div4_clks[DIV4_Z].ops->round_rate = zclk_round_rate;
-	div4_clks[DIV4_Z].ops->recalc = zclk_recalc;
+	zclk_ops = *div4_clk_ops;
+
+	zclk_ops.set_rate = zclk_set_rate;
+	zclk_ops.round_rate = zclk_round_rate;
+	zclk_ops.recalc = zclk_recalc;
+
+	div4_clks[DIV4_Z].ops = &zclk_ops;
 }
 
 enum { DIV6_VCK1, DIV6_VCK2, DIV6_VCK3, DIV6_ZB1,
-- 
1.7.10.4
