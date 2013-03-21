From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Thu, 21 Mar 2013 14:48:12 +0100
Subject: [PATCH V2 2/3] clk: Improve errorhandling for clk_set_parent
In-Reply-To: <1363873693-30902-1-git-send-email-ulf.hansson@stericsson.com>
References: <1363873693-30902-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <1363873693-30902-3-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulf Hansson <ulf.hansson@linaro.org>

By verifying all the needed static information before doing the clk
notifications, we minimize number of unwanted rollback notifications
with ABORT_RATE_CHANGE message to occur.

Additionally make sure the parent are valid pointer before using it.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/clk/clk.c |   48 +++++++++++++++++++++++++++++-------------------
 1 file changed, 29 insertions(+), 19 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index d73fb0f..c7eb0d7 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1269,15 +1269,10 @@ void __clk_reparent(struct clk *clk, struct clk *new_parent)
 	__clk_recalc_rates(clk, POST_RATE_CHANGE);
 }
 
-static int __clk_set_parent(struct clk *clk, struct clk *parent)
+static u8 clk_fetch_parent_index(struct clk *clk, struct clk *parent)
 {
-	struct clk *old_parent;
-	unsigned long flags;
-	int ret = -EINVAL;
 	u8 i;
 
-	old_parent = clk->parent;
-
 	if (!clk->parents)
 		clk->parents = kzalloc((sizeof(struct clk*) * clk->num_parents),
 								GFP_KERNEL);
@@ -1297,11 +1292,14 @@ static int __clk_set_parent(struct clk *clk, struct clk *parent)
 		}
 	}
 
-	if (i == clk->num_parents) {
-		pr_debug("%s: clock %s is not a possible parent of clock %s\n",
-				__func__, parent->name, clk->name);
-		goto out;
-	}
+	return i;
+}
+
+static int __clk_set_parent(struct clk *clk, struct clk *parent, u8 p_index)
+{
+	unsigned long flags;
+	int ret;
+	struct clk *old_parent = clk->parent;
 
 	/* migrate prepare and enable */
 	if (clk->prepare_count)
@@ -1314,7 +1312,7 @@ static int __clk_set_parent(struct clk *clk, struct clk *parent)
 	spin_unlock_irqrestore(&enable_lock, flags);
 
 	/* change clock input source */
-	ret = clk->ops->set_parent(clk->hw, i);
+	ret = clk->ops->set_parent(clk->hw, p_index);
 
 	/* clean up old prepare and enable */
 	spin_lock_irqsave(&enable_lock, flags);
@@ -1325,7 +1323,6 @@ static int __clk_set_parent(struct clk *clk, struct clk *parent)
 	if (clk->prepare_count)
 		__clk_unprepare(old_parent);
 
-out:
 	return ret;
 }
 
@@ -1344,8 +1341,9 @@ out:
 int clk_set_parent(struct clk *clk, struct clk *parent)
 {
 	int ret = 0;
+	u8 p_index;
 
-	if (!clk || !clk->ops)
+	if (!clk || !clk->ops || !parent)
 		return -EINVAL;
 
 	if (!clk->ops->set_parent)
@@ -1357,6 +1355,21 @@ int clk_set_parent(struct clk *clk, struct clk *parent)
 	if (clk->parent == parent)
 		goto out;
 
+	/* check that we are allowed to re-parent if the clock is in use */
+	if ((clk->flags & CLK_SET_PARENT_GATE) && clk->prepare_count) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	/* try finding the new parent index */
+	p_index = clk_fetch_parent_index(clk, parent);
+	if (p_index == clk->num_parents) {
+		pr_debug("%s: clock %s is not a possible parent of clock %s\n",
+				__func__, parent->name, clk->name);
+		ret = -EINVAL;
+		goto out;
+	}
+
 	/* propagate PRE_RATE_CHANGE notifications */
 	if (clk->notifier_count)
 		ret = __clk_speculate_rates(clk, parent->rate);
@@ -1365,11 +1378,8 @@ int clk_set_parent(struct clk *clk, struct clk *parent)
 	if (ret == NOTIFY_STOP)
 		goto out;
 
-	/* only re-parent if the clock is not in use */
-	if ((clk->flags & CLK_SET_PARENT_GATE) && clk->prepare_count)
-		ret = -EBUSY;
-	else
-		ret = __clk_set_parent(clk, parent);
+	/* do the re-parent */
+	ret = __clk_set_parent(clk, parent, p_index);
 
 	/* propagate ABORT_RATE_CHANGE if .set_parent failed */
 	if (ret) {
-- 
1.7.10
