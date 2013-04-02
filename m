From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  2 Apr 2013 14:07:13 +0900
Subject: [PATCH 17/30] ARM: shmobile: sh73a0: use fixed ratio clock
In-Reply-To: <1364879246-9470-1-git-send-email-horms+renesas@verge.net.au>
References: <1364879246-9470-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1364879246-9470-18-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Current clock-sh73a0 is using own implement
for each divX clocks.
This patch switches to use fixed ratio clock,
and was tesed on kzm9g board.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/clock-sh73a0.c |   72 ++++++---------------------------
 1 file changed, 12 insertions(+), 60 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-sh73a0.c b/arch/arm/mach-shmobile/clock-sh73a0.c
index 26a5803..784fbaa 100644
--- a/arch/arm/mach-shmobile/clock-sh73a0.c
+++ b/arch/arm/mach-shmobile/clock-sh73a0.c
@@ -22,6 +22,7 @@
 #include <linux/sh_clk.h>
 #include <linux/clkdev.h>
 #include <asm/processor.h>
+#include <mach/clock.h>
 #include <mach/common.h>
 
 #define FRQCRA		IOMEM(0xe6150000)
@@ -83,61 +84,16 @@ struct clk sh73a0_extal2_clk = {
 	.rate		= 48000000,
 };
 
-/* A fixed divide-by-2 block */
-static unsigned long div2_recalc(struct clk *clk)
-{
-	return clk->parent->rate / 2;
-}
-
-static struct sh_clk_ops div2_clk_ops = {
-	.recalc		= div2_recalc,
-};
-
-static unsigned long div7_recalc(struct clk *clk)
-{
-	return clk->parent->rate / 7;
-}
-
-static struct sh_clk_ops div7_clk_ops = {
-	.recalc		= div7_recalc,
-};
-
-static unsigned long div13_recalc(struct clk *clk)
-{
-	return clk->parent->rate / 13;
-}
-
-static struct sh_clk_ops div13_clk_ops = {
-	.recalc		= div13_recalc,
-};
-
-/* Divide extal1 by two */
-static struct clk extal1_div2_clk = {
-	.ops		= &div2_clk_ops,
-	.parent		= &sh73a0_extal1_clk,
-};
-
-/* Divide extal2 by two */
-static struct clk extal2_div2_clk = {
-	.ops		= &div2_clk_ops,
-	.parent		= &sh73a0_extal2_clk,
-};
-
 static struct sh_clk_ops main_clk_ops = {
 	.recalc		= followparent_recalc,
 };
 
 /* Main clock */
 static struct clk main_clk = {
+	/* .parent wll be set on sh73a0_clock_init() */
 	.ops		= &main_clk_ops,
 };
 
-/* Divide Main clock by two */
-static struct clk main_div2_clk = {
-	.ops		= &div2_clk_ops,
-	.parent		= &main_clk,
-};
-
 /* PLL0, PLL1, PLL2, PLL3 */
 static unsigned long pll_recalc(struct clk *clk)
 {
@@ -193,21 +149,17 @@ static struct clk pll3_clk = {
 	.enable_bit	= 3,
 };
 
-/* Divide PLL */
-static struct clk pll1_div2_clk = {
-	.ops		= &div2_clk_ops,
-	.parent		= &pll1_clk,
-};
-
-static struct clk pll1_div7_clk = {
-	.ops		= &div7_clk_ops,
-	.parent		= &pll1_clk,
-};
+/* A fixed divide block */
+SH_CLK_RATIO(div2,  1, 2);
+SH_CLK_RATIO(div7,  1, 7);
+SH_CLK_RATIO(div13, 1, 13);
 
-static struct clk pll1_div13_clk = {
-	.ops		= &div13_clk_ops,
-	.parent		= &pll1_clk,
-};
+SH_FIXED_RATIO_CLK(extal1_div2_clk,	sh73a0_extal1_clk,	div2);
+SH_FIXED_RATIO_CLK(extal2_div2_clk,	sh73a0_extal2_clk,	div2);
+SH_FIXED_RATIO_CLK(main_div2_clk,	main_clk,		div2);
+SH_FIXED_RATIO_CLK(pll1_div2_clk,	pll1_clk,		div2);
+SH_FIXED_RATIO_CLK(pll1_div7_clk,	pll1_clk,		div7);
+SH_FIXED_RATIO_CLK(pll1_div13_clk,	pll1_clk,		div13);
 
 /* External input clock */
 struct clk sh73a0_extcki_clk = {
-- 
1.7.10.4
