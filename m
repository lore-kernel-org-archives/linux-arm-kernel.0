From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 25 Apr 2014 15:44:45 -0700
Subject: [RFC/PATCH 1/4] clk: Recalc rate and accuracy in underscore functions
 if not caching
In-Reply-To: <1398465888-12610-1-git-send-email-sboyd@codeaurora.org>
References: <1398465888-12610-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1398465888-12610-2-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When we move this code to use ww_mutex we'll need to call
__clk_get_rate() and __clk_get_accuracy(), instead of their
non-underscore counterparts, while holding the clock's prepare
mutex. Move the recalculation of these values into the underscore
functions so that we can call __clk_get_rate() and
__clk_get_accuracy() while holding locks.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/clk/clk.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 1bdd561985fc..bebeaeec4aa1 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -617,6 +617,8 @@ unsigned int __clk_get_prepare_count(struct clk *clk)
 	return !clk ? 0 : clk->prepare_count;
 }
 
+static void __clk_recalc_rates(struct clk *clk, unsigned long msg);
+
 unsigned long __clk_get_rate(struct clk *clk)
 {
 	unsigned long ret;
@@ -626,6 +628,9 @@ unsigned long __clk_get_rate(struct clk *clk)
 		goto out;
 	}
 
+	if (clk->flags & CLK_GET_RATE_NOCACHE)
+		__clk_recalc_rates(clk, 0);
+
 	ret = clk->rate;
 
 	if (clk->flags & CLK_IS_ROOT)
@@ -639,11 +644,16 @@ out:
 }
 EXPORT_SYMBOL_GPL(__clk_get_rate);
 
+static void __clk_recalc_accuracies(struct clk *clk);
+
 unsigned long __clk_get_accuracy(struct clk *clk)
 {
 	if (!clk)
 		return 0;
 
+	if (clk->flags & CLK_GET_ACCURACY_NOCACHE)
+		__clk_recalc_accuracies(clk);
+
 	return clk->accuracy;
 }
 
@@ -1108,9 +1118,6 @@ long clk_get_accuracy(struct clk *clk)
 	unsigned long accuracy;
 
 	clk_prepare_lock();
-	if (clk && (clk->flags & CLK_GET_ACCURACY_NOCACHE))
-		__clk_recalc_accuracies(clk);
-
 	accuracy = __clk_get_accuracy(clk);
 	clk_prepare_unlock();
 
@@ -1176,10 +1183,6 @@ unsigned long clk_get_rate(struct clk *clk)
 	unsigned long rate;
 
 	clk_prepare_lock();
-
-	if (clk && (clk->flags & CLK_GET_RATE_NOCACHE))
-		__clk_recalc_rates(clk, 0);
-
 	rate = __clk_get_rate(clk);
 	clk_prepare_unlock();
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
