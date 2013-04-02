From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  2 Apr 2013 14:07:12 +0900
Subject: [PATCH 16/30] ARM: shmobile: sh7372: use fixed ratio clock
In-Reply-To: <1364879246-9470-1-git-send-email-horms+renesas@verge.net.au>
References: <1364879246-9470-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1364879246-9470-17-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Current clock-sh7372 is using own implement
for each divX clocks.
This patch switches to use fixed ratio clock,
and was tesed on mackerel board.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/clock-sh7372.c |   44 ++++++---------------------------
 1 file changed, 7 insertions(+), 37 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-sh7372.c b/arch/arm/mach-shmobile/clock-sh7372.c
index 6c23e3f..7e10593 100644
--- a/arch/arm/mach-shmobile/clock-sh7372.c
+++ b/arch/arm/mach-shmobile/clock-sh7372.c
@@ -21,6 +21,7 @@
 #include <linux/io.h>
 #include <linux/sh_clk.h>
 #include <linux/clkdev.h>
+#include <mach/clock.h>
 #include <mach/common.h>
 
 /* SH7372 registers */
@@ -83,39 +84,12 @@ struct clk sh7372_extal2_clk = {
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
+SH_CLK_RATIO(div2, 1, 2);
 
-/* Divide dv_clki by two */
-struct clk sh7372_dv_clki_div2_clk = {
-	.ops		= &div2_clk_ops,
-	.parent		= &sh7372_dv_clki_clk,
-};
-
-/* Divide extal1 by two */
-static struct clk extal1_div2_clk = {
-	.ops		= &div2_clk_ops,
-	.parent		= &sh7372_extal1_clk,
-};
-
-/* Divide extal2 by two */
-static struct clk extal2_div2_clk = {
-	.ops		= &div2_clk_ops,
-	.parent		= &sh7372_extal2_clk,
-};
-
-/* Divide extal2 by four */
-static struct clk extal2_div4_clk = {
-	.ops		= &div2_clk_ops,
-	.parent		= &extal2_div2_clk,
-};
+SH_FIXED_RATIO_CLKg(sh7372_dv_clki_div2_clk,	sh7372_dv_clki_clk,	div2);
+SH_FIXED_RATIO_CLK(extal1_div2_clk,		sh7372_extal1_clk,	div2);
+SH_FIXED_RATIO_CLK(extal2_div2_clk,		sh7372_extal2_clk,	div2);
+SH_FIXED_RATIO_CLK(extal2_div4_clk,		extal2_div2_clk,	div2);
 
 /* PLLC0 and PLLC1 */
 static unsigned long pllc01_recalc(struct clk *clk)
@@ -147,10 +121,7 @@ static struct clk pllc1_clk = {
 };
 
 /* Divide PLLC1 by two */
-static struct clk pllc1_div2_clk = {
-	.ops		= &div2_clk_ops,
-	.parent		= &pllc1_clk,
-};
+SH_FIXED_RATIO_CLK(pllc1_div2_clk,	pllc1_clk,	div2);
 
 /* PLLC2 */
 
@@ -650,5 +621,4 @@ void __init sh7372_clock_init(void)
 		shmobile_clk_init();
 	else
 		panic("failed to setup sh7372 clocks\n");
-
 }
-- 
1.7.10.4
