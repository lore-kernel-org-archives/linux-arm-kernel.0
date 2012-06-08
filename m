From: pawel.moll@arm.com (Pawel Moll)
Date: Fri,  8 Jun 2012 14:04:06 +0100
Subject: [PATCH] clk: Check parent for NULL in clk_change_rate
Message-ID: <1339160646-32664-1-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

clk_change_rate() is accessing parent's rate without checking
if the parent exists at all. In case of root clocks this will
cause NULL pointer dereference.

This patch follows what clk_calc_new_rates() does in such
situation.

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---

Hi Mike,

This is something I had to workaround to get Versatile Express
working with the common clock framework - my root clocks aren't
are variable (as in: non fixed).

I'm told that this might have been already fixed - if that's the
case simply ignore this patch. Also I'm not saying it's the best
way of solving the issue :-)

Cheers!

Pawel

 drivers/clk/clk.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 687b00d..cf53069 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -850,18 +850,21 @@ static void clk_change_rate(struct clk *clk)
 {
 	struct clk *child;
 	unsigned long old_rate;
+	unsigned long best_parent_rate = 0;
 	struct hlist_node *tmp;
 
 	old_rate = clk->rate;
 
+	if (clk->parent)
+		best_parent_rate = clk->parent->rate;
+
 	if (clk->ops->set_rate)
-		clk->ops->set_rate(clk->hw, clk->new_rate, clk->parent->rate);
+		clk->ops->set_rate(clk->hw, clk->new_rate, best_parent_rate);
 
 	if (clk->ops->recalc_rate)
-		clk->rate = clk->ops->recalc_rate(clk->hw,
-				clk->parent->rate);
+		clk->rate = clk->ops->recalc_rate(clk->hw, best_parent_rate);
 	else
-		clk->rate = clk->parent->rate;
+		clk->rate = best_parent_rate;
 
 	if (clk->notifier_count && old_rate != clk->rate)
 		__clk_notify(clk, POST_RATE_CHANGE, old_rate, clk->rate);
-- 
1.7.9.5
