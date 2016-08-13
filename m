From: moinejf@free.fr (Jean-Francois Moine)
Date: Sat, 13 Aug 2016 18:23:49 +0200
Subject: [PATCH] clk: core: Force setting the phase delay when no change
Message-ID: <mailman.37.1471106674.1636.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The hardware phase delay may depend on some other settings as clock
reparenting, so, it has to be set each time.
Also, when the delay was the same as previously, an error was returned.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 drivers/clk/clk.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 820a939..2e6b91e 100644
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
-- 
2.9.2
