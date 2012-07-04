From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu,  5 Jul 2012 00:09:32 +0200
Subject: [PATCH] clk: allow clocks without parents to change rate
Message-ID: <1341439772-649-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clk_change_rate() code would dereference clk->parent
to get clk->parent->rate without first checking that clk->parent
was valid. This doesn't work if the clock is (A) a root clock
and (B) can change rate. Such is the case with a VCO clock
like the ICST which consequently crash like this without
this patch:

Unable to handle kernel NULL pointer dereference at virtual address 0000001c
pgd = c0004000
[0000001c] *pgd=00000000
Internal error: Oops: 5 [#1] PREEMPT ARM
Modules linked in:
CPU: 0    Not tainted  (3.5.0-rc3-00003-g8156866-dirty #193)
PC is at clk_change_rate+0x34/0xd8
LR is at clk_change_rate+0x18/0xd8

Cc: stable at kernel.org
Cc: Mike Turquette <mturquette@linaro.org>
Cc: Ulf Hansson <ulf.hansson@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/clk/clk.c |   22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 687b00d..032d79c 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -854,14 +854,22 @@ static void clk_change_rate(struct clk *clk)
 
 	old_rate = clk->rate;
 
-	if (clk->ops->set_rate)
-		clk->ops->set_rate(clk->hw, clk->new_rate, clk->parent->rate);
+	if (clk->ops->set_rate) {
+		if (clk->parent)
+			clk->ops->set_rate(clk->hw, clk->new_rate,
+					clk->parent->rate);
+		else
+			clk->ops->set_rate(clk->hw, clk->new_rate, 0);
+	}
 
-	if (clk->ops->recalc_rate)
-		clk->rate = clk->ops->recalc_rate(clk->hw,
-				clk->parent->rate);
-	else
-		clk->rate = clk->parent->rate;
+	if (clk->ops->recalc_rate) {
+		if (clk->parent)
+			clk->rate = clk->ops->recalc_rate(clk->hw,
+							clk->parent->rate);
+		else
+			clk->rate = clk->ops->recalc_rate(clk->hw, 0);
+	} else
+		clk->rate = clk->parent ? clk->parent->rate : 0;
 
 	if (clk->notifier_count && old_rate != clk->rate)
 		__clk_notify(clk, POST_RATE_CHANGE, old_rate, clk->rate);
-- 
1.7.10.4
