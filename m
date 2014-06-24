From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Tue, 24 Jun 2014 20:29:33 +0100
Subject: [PATCH RFC v2 8/8] component: track components via array rather than
 list
In-Reply-To: <20140624192830.GC20555@n2100.arm.linux.org.uk>
References: <20140624192830.GC20555@n2100.arm.linux.org.uk>
Message-ID: <E1WzWPN-0007zx-L6@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since we now have an array which defines each component, maintain the
components to be bound in the array rather than a separate list.  We
also need duplicate tracking so we can eliminate multiple bind calls
for the same component: we preserve the list-based component order in
that the first match which adds the component determines its position.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/base/component.c | 140 +++++++++++++++++++++--------------------------
 1 file changed, 62 insertions(+), 78 deletions(-)

diff --git a/drivers/base/component.c b/drivers/base/component.c
index 0863cfeea769..8a1d784a9759 100644
--- a/drivers/base/component.c
+++ b/drivers/base/component.c
@@ -18,18 +18,21 @@
 #include <linux/mutex.h>
 #include <linux/slab.h>
 
+struct component;
+
 struct component_match {
 	size_t alloc;
 	size_t num;
 	struct {
 		void *data;
 		int (*fn)(struct device *, void *);
+		struct component *component;
+		bool duplicate;
 	} compare[0];
 };
 
 struct master {
 	struct list_head node;
-	struct list_head components;
 	bool bound;
 
 	const struct component_master_ops *ops;
@@ -39,7 +42,6 @@ struct master {
 
 struct component {
 	struct list_head node;
-	struct list_head master_node;
 	struct master *master;
 	bool bound;
 
@@ -63,46 +65,20 @@ static struct master *__master_find(struct device *dev,
 	return NULL;
 }
 
-/* Attach an unattached component to a master. */
-static void component_attach_master(struct master *master, struct component *c)
-{
-	c->master = master;
-
-	list_add_tail(&c->master_node, &master->components);
-}
-
-/* Detach a component from a master. */
-static void component_detach_master(struct master *master, struct component *c)
-{
-	list_del(&c->master_node);
-
-	c->master = NULL;
-}
-
-/*
- * Add a component to a master, finding the component via the compare
- * function and compare data.  This is safe to call for duplicate matches
- * and will not result in the same component being added multiple times.
- */
-static int component_master_add_child(struct master *master,
+static struct component *find_component(struct master *master,
 	int (*compare)(struct device *, void *), void *compare_data)
 {
 	struct component *c;
-	int ret = -ENXIO;
 
 	list_for_each_entry(c, &component_list, node) {
 		if (c->master && c->master != master)
 			continue;
 
-		if (compare(c->dev, compare_data)) {
-			if (!c->master)
-				component_attach_master(master, c);
-			ret = 0;
-			break;
-		}
+		if (compare(c->dev, compare_data))
+			return c;
 	}
 
-	return ret;
+	return NULL;
 }
 
 static int find_components(struct master *master)
@@ -116,26 +92,35 @@ static int find_components(struct master *master)
 	 * any components which are found to this master.
 	 */
 	for (i = 0; i < match->num; i++) {
-		ret = component_master_add_child(master,
-						 match->compare[i].fn,
-						 match->compare[i].data);
-		if (ret)
+		struct component *c;
+
+		if (match->compare[i].component)
+			continue;
+
+		c = find_component(master, match->compare[i].fn,
+				   match->compare[i].data);
+		if (!c) {
+			ret = -ENXIO;
 			break;
+		}
+
+		/* Attach this component to the master */
+		match->compare[i].duplicate = !!c->master;
+		match->compare[i].component = c;
+		c->master = master;
 	}
 	return ret;
 }
 
-/* Detach all attached components from this master */
-static void master_remove_components(struct master *master)
+/* Detach component from associated master */
+static void remove_component(struct master *master, struct component *c)
 {
-	while (!list_empty(&master->components)) {
-		struct component *c = list_first_entry(&master->components,
-					struct component, master_node);
-
-		WARN_ON(c->master != master);
+	size_t i;
 
-		component_detach_master(master, c);
-	}
+	/* Detach the component from this master. */
+	for (i = 0; i < master->match->num; i++)
+		if (master->match->compare[i].component == c)
+			master->match->compare[i].component = NULL;
 }
 
 /*
@@ -150,37 +135,25 @@ static int try_to_bring_up_master(struct master *master,
 {
 	int ret;
 
-	if (find_components(master)) {
-		/* Failed to find all components */
-		ret = 0;
-		goto out;
-	}
+	if (find_components(master))
+		return 0;
 
-	if (component && component->master != master) {
-		ret = 0;
-		goto out;
-	}
+	if (component && component->master != master)
+		return 0;
 
-	if (!devres_open_group(master->dev, NULL, GFP_KERNEL)) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	if (!devres_open_group(master->dev, NULL, GFP_KERNEL))
+		return -ENOMEM;
 
 	/* Found all components */
 	ret = master->ops->bind(master->dev);
 	if (ret < 0) {
 		devres_release_group(master->dev, NULL);
 		dev_info(master->dev, "master bind failed: %d\n", ret);
-		goto out;
+		return ret;
 	}
 
 	master->bound = true;
 	return 1;
-
-out:
-	master_remove_components(master);
-
-	return ret;
 }
 
 static int try_to_bring_up_masters(struct component *component)
@@ -206,8 +179,6 @@ static void take_down_master(struct master *master)
 		devres_release_group(master->dev, NULL);
 		master->bound = false;
 	}
-
-	master_remove_components(master);
 }
 
 static size_t component_match_size(size_t num)
@@ -265,6 +236,7 @@ void component_match_add(struct device *dev, struct component_match **matchptr,
 
 	match->compare[match->num].fn = compare;
 	match->compare[match->num].data = compare_data;
+	match->compare[match->num].component = NULL;
 	match->num++;
 }
 
@@ -287,7 +259,6 @@ int component_master_add_with_match(struct device *dev,
 	master->dev = dev;
 	master->ops = ops;
 	master->match = match;
-	INIT_LIST_HEAD(&master->components);
 
 	/* Add to the list of available masters. */
 	mutex_lock(&component_mutex);
@@ -339,6 +310,7 @@ void component_unbind_all(struct device *master_dev, void *data)
 {
 	struct master *master;
 	struct component *c;
+	size_t i;
 
 	WARN_ON(!mutex_is_locked(&component_mutex));
 
@@ -346,8 +318,12 @@ void component_unbind_all(struct device *master_dev, void *data)
 	if (!master)
 		return;
 
-	list_for_each_entry_reverse(c, &master->components, master_node)
-		component_unbind(c, master, data);
+	/* Unbind components in reverse order */
+	for (i = master->match->num; i--; )
+		if (!master->match->compare[i].duplicate) {
+			c = master->match->compare[i].component;
+			component_unbind(c, master, data);
+		}
 }
 EXPORT_SYMBOL_GPL(component_unbind_all);
 
@@ -407,6 +383,7 @@ int component_bind_all(struct device *master_dev, void *data)
 {
 	struct master *master;
 	struct component *c;
+	size_t i;
 	int ret = 0;
 
 	WARN_ON(!mutex_is_locked(&component_mutex));
@@ -415,16 +392,21 @@ int component_bind_all(struct device *master_dev, void *data)
 	if (!master)
 		return -EINVAL;
 
-	list_for_each_entry(c, &master->components, master_node) {
-		ret = component_bind(c, master, data);
-		if (ret)
-			break;
-	}
+	/* Bind components in match order */
+	for (i = 0; i < master->match->num; i++)
+		if (!master->match->compare[i].duplicate) {
+			c = master->match->compare[i].component;
+			ret = component_bind(c, master, data);
+			if (ret)
+				break;
+		}
 
 	if (ret != 0) {
-		list_for_each_entry_continue_reverse(c, &master->components,
-						     master_node)
-			component_unbind(c, master, data);
+		for (; i--; )
+			if (!master->match->compare[i].duplicate) {
+				c = master->match->compare[i].component;
+				component_unbind(c, master, data);
+			}
 	}
 
 	return ret;
@@ -472,8 +454,10 @@ void component_del(struct device *dev, const struct component_ops *ops)
 			break;
 		}
 
-	if (component && component->master)
+	if (component && component->master) {
 		take_down_master(component->master);
+		remove_component(component->master, component);
+	}
 
 	mutex_unlock(&component_mutex);
 
-- 
1.8.3.1
