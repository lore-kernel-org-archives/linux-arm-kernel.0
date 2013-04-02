From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  2 Apr 2013 14:07:15 +0900
Subject: [PATCH 19/30] ARM: shmobile: r8a7740: use fixed ratio clock
In-Reply-To: <1364879246-9470-1-git-send-email-horms+renesas@verge.net.au>
References: <1364879246-9470-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1364879246-9470-20-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Current clock-r8a7740 is using own implement
for each divX clocks.
This patch switches to use fixed ratio clock,
and was tesed on armadillo board.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/clock-r8a7740.c |   54 ++++++--------------------------
 1 file changed, 9 insertions(+), 45 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-r8a7740.c b/arch/arm/mach-shmobile/clock-r8a7740.c
index 161e128..c0d39aa 100644
--- a/arch/arm/mach-shmobile/clock-r8a7740.c
+++ b/arch/arm/mach-shmobile/clock-r8a7740.c
@@ -22,6 +22,7 @@
 #include <linux/io.h>
 #include <linux/sh_clk.h>
 #include <linux/clkdev.h>
+#include <mach/clock.h>
 #include <mach/common.h>
 #include <mach/r8a7740.h>
 
@@ -97,42 +98,13 @@ static struct clk dv_clk = {
 	.rate	= 27000000,
 };
 
-static unsigned long div_recalc(struct clk *clk)
-{
-	return clk->parent->rate / (int)(clk->priv);
-}
-
-static struct sh_clk_ops div_clk_ops = {
-	.recalc	= div_recalc,
-};
+SH_CLK_RATIO(div2,	1, 2);
+SH_CLK_RATIO(div1k,	1, 1024);
 
-/* extal1 / 2 */
-static struct clk extal1_div2_clk = {
-	.ops	= &div_clk_ops,
-	.priv	= (void *)2,
-	.parent	= &extal1_clk,
-};
-
-/* extal1 / 1024 */
-static struct clk extal1_div1024_clk = {
-	.ops	= &div_clk_ops,
-	.priv	= (void *)1024,
-	.parent	= &extal1_clk,
-};
-
-/* extal1 / 2 / 1024 */
-static struct clk extal1_div2048_clk = {
-	.ops	= &div_clk_ops,
-	.priv	= (void *)1024,
-	.parent	= &extal1_div2_clk,
-};
-
-/* extal2 / 2 */
-static struct clk extal2_div2_clk = {
-	.ops	= &div_clk_ops,
-	.priv	= (void *)2,
-	.parent	= &extal2_clk,
-};
+SH_FIXED_RATIO_CLK(extal1_div2_clk,	extal1_clk,		div2);
+SH_FIXED_RATIO_CLK(extal1_div1024_clk,	extal1_clk,		div1k);
+SH_FIXED_RATIO_CLK(extal1_div2048_clk,	extal1_div2_clk,	div1k);
+SH_FIXED_RATIO_CLK(extal2_div2_clk,	extal2_clk,		div2);
 
 static struct sh_clk_ops followparent_clk_ops = {
 	.recalc	= followparent_recalc,
@@ -143,11 +115,7 @@ static struct clk system_clk = {
 	.ops	= &followparent_clk_ops,
 };
 
-static struct clk system_div2_clk = {
-	.ops	= &div_clk_ops,
-	.priv	= (void *)2,
-	.parent	= &system_clk,
-};
+SH_FIXED_RATIO_CLK(system_div2_clk, system_clk,	div2);
 
 /* r_clk */
 static struct clk r_clk = {
@@ -184,11 +152,7 @@ static struct clk pllc1_clk = {
 };
 
 /* PLLC1 / 2 */
-static struct clk pllc1_div2_clk = {
-	.ops		= &div_clk_ops,
-	.priv		= (void *)2,
-	.parent		= &pllc1_clk,
-};
+SH_FIXED_RATIO_CLK(pllc1_div2_clk, pllc1_clk, div2);
 
 /* USB clock */
 /*
-- 
1.7.10.4
