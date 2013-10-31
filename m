From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 31 Oct 2013 13:02:42 +0100
Subject: [PATCH] clk: Properly initialize reference count
Message-ID: <1383220962-26836-1-git-send-email-treding@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit a336ed7 (clk: Implement clk_unregister()) initializes the kref in
clk_set_parent(), which is obviously the wrong place. Further research
shows that the original patches initialized it correctly, so it probably
ended up in clk_set_parent() by mistake during manual application of the
patch.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/clk/clk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 6e3f485..b68a999 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1750,7 +1750,6 @@ int clk_set_parent(struct clk *clk, struct clk *parent)
 	else
 		__clk_recalc_rates(clk, POST_RATE_CHANGE);
 
-	kref_init(&clk->ref);
 out:
 	clk_prepare_unlock();
 
@@ -1906,6 +1905,7 @@ int __clk_init(struct device *dev, struct clk *clk)
 	if (clk->ops->init)
 		clk->ops->init(clk->hw);
 
+	kref_init(&clk->ref);
 out:
 	clk_prepare_unlock();
 
-- 
1.8.4
