From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu,  4 Sep 2014 18:23:28 -0700
Subject: [PATCH 1/2] clk: Make __clk_lookup() use a list instead of tree search
In-Reply-To: <CAF6AEGtk=KhW+m-jc6VzH=pHGgnE1Uzq0tYiqqnX0sPHV1rbPQ@mail.gmail.com>
References: <CAF6AEGtk=KhW+m-jc6VzH=pHGgnE1Uzq0tYiqqnX0sPHV1rbPQ@mail.gmail.com>
Message-ID: <1409880209-25094-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the near future we're going to move the prepare lock to be a
per-clock ww_mutex. __clk_lookup() is called very deep in the
set-rate path and we would like to avoid having to take all the
locks in the clock tree to search for a clock (basically
defeating the purpose of introducing per-clock locks). Introduce
a new list that contains all clocks registered in the system and
walk this list until the clock is found.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---

Yeah this commit text could be updated and/or this could be squashed
into the next patch.

 drivers/clk/clk.c           | 52 +++++++++++++++++----------------------------
 include/linux/clk-private.h |  1 +
 2 files changed, 21 insertions(+), 32 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index b76fa69b44cb..cf5df744cb21 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -33,8 +33,10 @@ static struct task_struct *enable_owner;
 static int prepare_refcnt;
 static int enable_refcnt;
 
+static DEFINE_MUTEX(clk_lookup_lock);
 static HLIST_HEAD(clk_root_list);
 static HLIST_HEAD(clk_orphan_list);
+static HLIST_HEAD(clk_lookup_list);
 static LIST_HEAD(clk_notifier_list);
 
 /***           locking             ***/
@@ -670,46 +672,23 @@ out:
 }
 EXPORT_SYMBOL_GPL(__clk_is_enabled);
 
-static struct clk *__clk_lookup_subtree(const char *name, struct clk *clk)
-{
-	struct clk *child;
-	struct clk *ret;
-
-	if (!strcmp(clk->name, name))
-		return clk;
-
-	hlist_for_each_entry(child, &clk->children, child_node) {
-		ret = __clk_lookup_subtree(name, child);
-		if (ret)
-			return ret;
-	}
-
-	return NULL;
-}
-
 struct clk *__clk_lookup(const char *name)
 {
-	struct clk *root_clk;
-	struct clk *ret;
+	struct clk *clk;
 
 	if (!name)
 		return NULL;
 
-	/* search the 'proper' clk tree first */
-	hlist_for_each_entry(root_clk, &clk_root_list, child_node) {
-		ret = __clk_lookup_subtree(name, root_clk);
-		if (ret)
-			return ret;
+	mutex_lock(&clk_lookup_lock);
+	hlist_for_each_entry(clk, &clk_lookup_list, lookup_node) {
+		if (!strcmp(clk->name, name))
+			goto found;
 	}
+	clk = NULL;
+found:
+	mutex_unlock(&clk_lookup_lock);
 
-	/* if not found, then search the orphan tree */
-	hlist_for_each_entry(root_clk, &clk_orphan_list, child_node) {
-		ret = __clk_lookup_subtree(name, root_clk);
-		if (ret)
-			return ret;
-	}
-
-	return NULL;
+	return clk;
 }
 
 /*
@@ -1823,6 +1802,11 @@ int __clk_init(struct device *dev, struct clk *clk)
 
 	clk->parent = __clk_init_parent(clk);
 
+	/* Insert into clock lookup list */
+	mutex_lock(&clk_lookup_lock);
+	hlist_add_head(&clk->lookup_node, &clk_lookup_list);
+	mutex_unlock(&clk_lookup_lock);
+
 	/*
 	 * Populate clk->parent if parent has already been __clk_init'd.  If
 	 * parent has not yet been __clk_init'd then place clk in the orphan
@@ -2117,6 +2101,10 @@ void clk_unregister(struct clk *clk)
 
 	hlist_del_init(&clk->child_node);
 
+	mutex_lock(&clk_lookup_lock);
+	hlist_del_init(&clk->lookup_node);
+	mutex_unlock(&clk_lookup_lock);
+
 	if (clk->prepare_count)
 		pr_warn("%s: unregistering prepared clock: %s\n",
 					__func__, clk->name);
diff --git a/include/linux/clk-private.h b/include/linux/clk-private.h
index efbf70b9fd84..3cd98a930006 100644
--- a/include/linux/clk-private.h
+++ b/include/linux/clk-private.h
@@ -48,6 +48,7 @@ struct clk {
 	unsigned long		accuracy;
 	struct hlist_head	children;
 	struct hlist_node	child_node;
+	struct hlist_node	lookup_node;
 	unsigned int		notifier_count;
 #ifdef CONFIG_DEBUG_FS
 	struct dentry		*dentry;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
