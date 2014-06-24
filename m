From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Tue, 24 Jun 2014 20:29:23 +0100
Subject: [PATCH RFC v2 6/8] component: remove old add_components method
In-Reply-To: <20140624192830.GC20555@n2100.arm.linux.org.uk>
References: <20140624192830.GC20555@n2100.arm.linux.org.uk>
Message-ID: <E1WzWPD-0007zp-Ds@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that drivers create an array of component matches at probe time, we
can retire the old methods.  This involves removing the add_components
master method, and removing component_master_add_child() from public
view.  We also remove component_add_master() as that interface is no
longer useful.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/base/component.c  | 21 +--------------------
 include/linux/component.h |  5 -----
 2 files changed, 1 insertion(+), 25 deletions(-)

diff --git a/drivers/base/component.c b/drivers/base/component.c
index bd8b4908593b..c0a5b1abc931 100644
--- a/drivers/base/component.c
+++ b/drivers/base/component.c
@@ -84,7 +84,7 @@ static void component_detach_master(struct master *master, struct component *c)
  * function and compare data.  This is safe to call for duplicate matches
  * and will not result in the same component being added multiple times.
  */
-int component_master_add_child(struct master *master,
+static int component_master_add_child(struct master *master,
 	int (*compare)(struct device *, void *), void *compare_data)
 {
 	struct component *c;
@@ -104,7 +104,6 @@ int component_master_add_child(struct master *master,
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(component_master_add_child);
 
 static int find_components(struct master *master)
 {
@@ -112,14 +111,6 @@ static int find_components(struct master *master)
 	size_t i;
 	int ret = 0;
 
-	if (!match) {
-		/*
-		 * Search the list of components, looking for components that
-		 * belong to this master, and attach them to the master.
-		 */
-		return master->ops->add_components(master->dev, master);
-	}
-
 	/*
 	 * Scan the array of match functions and attach
 	 * any components which are found to this master.
@@ -289,9 +280,6 @@ int component_master_add_with_match(struct device *dev,
 	struct master *master;
 	int ret;
 
-	if (ops->add_components && match)
-		return -EINVAL;
-
 	/* Reallocate the match array for its true size */
 	match = component_match_realloc(dev, match, match->num);
 	if (IS_ERR(match))
@@ -323,13 +311,6 @@ int component_master_add_with_match(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(component_master_add_with_match);
 
-int component_master_add(struct device *dev,
-	const struct component_master_ops *ops)
-{
-	return component_master_add_with_match(dev, ops, NULL);
-}
-EXPORT_SYMBOL_GPL(component_master_add);
-
 void component_master_del(struct device *dev,
 	const struct component_master_ops *ops)
 {
diff --git a/include/linux/component.h b/include/linux/component.h
index c00dcc302611..71c434a6a5ee 100644
--- a/include/linux/component.h
+++ b/include/linux/component.h
@@ -17,18 +17,13 @@ void component_unbind_all(struct device *, void *);
 struct master;
 
 struct component_master_ops {
-	int (*add_components)(struct device *, struct master *);
 	int (*bind)(struct device *);
 	void (*unbind)(struct device *);
 };
 
-int component_master_add(struct device *, const struct component_master_ops *);
 void component_master_del(struct device *,
 	const struct component_master_ops *);
 
-int component_master_add_child(struct master *master,
-	int (*compare)(struct device *, void *), void *compare_data);
-
 struct component_match;
 
 int component_master_add_with_match(struct device *,
-- 
1.8.3.1
