From: moinejf@free.fr (Jean-Francois Moine)
Date: Wed, 24 Aug 2016 08:32:51 +0200
Subject: [PATCH RESEND] clk: core: Force setting the phase delay when no change
Message-ID: <mailman.42.1472030557.1636.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch reverts the commit 023bd7166be0595d18220dfd5c9765b3970f6ef3
(clk: skip unnecessary set_phase if nothing to do), fixing two
problems:
- in some SoCs, the hardware phase delay depends on the rate ratio of
  the clock and its parent. So, changing this ratio may imply to set
  new hardware values, even if the logical delay is the same.
- when the delay was the same as previously, an error was returned.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
resend:
- send to the clock maintainers (asked by Maxime Ripard)
- change the comment adding the reference to the reverted commit
---
 drivers/clk/clk.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 71cc567..7e8576e 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1908,10 +1908,6 @@ int clk_set_phase(struct clk *clk, int degrees)
 
 	clk_prepare_lock();
 
-	/* bail early if nothing to do */
-	if (degrees == clk->core->phase)
-		goto out;
-
 	trace_clk_set_phase(clk->core, degrees);
 
 	if (clk->core->ops->set_phase)
@@ -1922,7 +1918,6 @@ int clk_set_phase(struct clk *clk, int degrees)
 	if (!ret)
 		clk->core->phase = degrees;
 
-out:
 	clk_prepare_unlock();
 
 	return ret;
-- 
2.9.3
