From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Fri, 25 Jan 2013 12:40:56 +0100
Subject: [PATCH 2/3] clk: Improve errorhandling for clk_set_parent
In-Reply-To: <1359114057-11681-1-git-send-email-ulf.hansson@stericsson.com>
References: <1359114057-11681-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <1359114057-11681-3-git-send-email-ulf.hansson@stericsson.com>
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
index 2e10cc1..a61cf6d 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1227,15 +1227,10 @@ static void clk_reparent(struct clk *clk, struct clk *new_parent)
 	clk->parent = new_parent;
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
@@ -1255,11 +1250,14 @@ static int __clk_set_parent(struct clk *clk, struct clk *parent)
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
@@ -1272,7 +1270,7 @@ static int __clk_set_parent(struct clk *clk, struct clk *parent)
 	spin_unlock_irqrestore(&enable_lock, flags);
 
 	/* change clock input source */
-	ret = clk->ops->set_parent(clk->hw, i);
+	ret = clk->ops->set_parent(clk->hw, p_index);
 
 	/* clean up old prepare and enable */
 	spin_lock_irqsave(&enable_lock, flags);
@@ -1283,7 +1281,6 @@ static int __clk_set_parent(struct clk *clk, struct clk *parent)
 	if (clk->prepare_count)
 		__clk_unprepare(old_parent);
 
-out:
 	return ret;
 }
 
@@ -1302,8 +1299,9 @@ out:
 int clk_set_parent(struct clk *clk, struct clk *parent)
 {
 	int ret = 0;
+	u8 p_index;
 
-	if (!clk || !clk->ops)
+	if (!clk || !clk->ops || !parent)
 		return -EINVAL;
 
 	if (!clk->ops->set_parent)
@@ -1315,6 +1313,21 @@ int clk_set_parent(struct clk *clk, struct clk *parent)
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
@@ -1323,11 +1336,8 @@ int clk_set_parent(struct clk *clk, struct clk *parent)
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
