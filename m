From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Wed, 27 Mar 2013 10:50:24 +0100
Subject: [PATCH V3 2/3] clk: Fixup errorhandling for clk_set_parent
In-Reply-To: <1364377825-6171-1-git-send-email-ulf.hansson@stericsson.com>
References: <1364377825-6171-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <1364377825-6171-3-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulf Hansson <ulf.hansson@linaro.org>

Fixup the broken feature of allowing reparent of a clk to the
orhpan list and vice verse. When operating on a single-parent
clk, the .set_parent callback for the clk hw is optional to
implement, but for a multi-parent clk it is mandatory.

Moreover improve the errorhandling by verifying the prerequisites
before triggering clk notifiers. This will prevent unnecessary
rollback with ABORT_RATE_CHANGE.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rajagopal Venkat <rajagopal.venkat@linaro.org>
---
 drivers/clk/clk.c |   56 ++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 36 insertions(+), 20 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 97d681b..6fa301b 100644
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
+	int ret = 0;
+	struct clk *old_parent = clk->parent;
 
 	/* migrate prepare and enable */
 	if (clk->prepare_count)
@@ -1314,7 +1312,8 @@ static int __clk_set_parent(struct clk *clk, struct clk *parent)
 	spin_unlock_irqrestore(&enable_lock, flags);
 
 	/* change clock input source */
-	ret = clk->ops->set_parent(clk->hw, i);
+	if (parent && clk->ops->set_parent)
+		ret = clk->ops->set_parent(clk->hw, p_index);
 
 	/* clean up old prepare and enable */
 	spin_lock_irqsave(&enable_lock, flags);
@@ -1325,7 +1324,6 @@ static int __clk_set_parent(struct clk *clk, struct clk *parent)
 	if (clk->prepare_count)
 		__clk_unprepare(old_parent);
 
-out:
 	return ret;
 }
 
@@ -1344,11 +1342,14 @@ out:
 int clk_set_parent(struct clk *clk, struct clk *parent)
 {
 	int ret = 0;
+	u8 p_index = 0;
+	unsigned long p_rate = 0;
 
 	if (!clk || !clk->ops)
 		return -EINVAL;
 
-	if (!clk->ops->set_parent)
+	/* verify ops for for multi-parent clks */
+	if ((clk->num_parents > 1) && (!clk->ops->set_parent))
 		return -ENOSYS;
 
 	/* prevent racing with updates to the clock topology */
@@ -1357,19 +1358,34 @@ int clk_set_parent(struct clk *clk, struct clk *parent)
 	if (clk->parent == parent)
 		goto out;
 
+	/* check that we are allowed to re-parent if the clock is in use */
+	if ((clk->flags & CLK_SET_PARENT_GATE) && clk->prepare_count) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	/* try finding the new parent index */
+	if (parent) {
+		p_index = clk_fetch_parent_index(clk, parent);
+		p_rate = parent->rate;
+		if (p_index == clk->num_parents) {
+			pr_debug("%s: clk %s can not be parent of clk %s\n",
+					__func__, parent->name, clk->name);
+			ret = -EINVAL;
+			goto out;
+		}
+	}
+
 	/* propagate PRE_RATE_CHANGE notifications */
 	if (clk->notifier_count)
-		ret = __clk_speculate_rates(clk, parent->rate);
+		ret = __clk_speculate_rates(clk, p_rate);
 
 	/* abort if a driver objects */
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
