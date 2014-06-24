From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Tue, 24 Jun 2014 20:29:08 +0100
Subject: [PATCH RFC v2 3/8] component: add support for component match array
In-Reply-To: <20140624192830.GC20555@n2100.arm.linux.org.uk>
References: <20140624192830.GC20555@n2100.arm.linux.org.uk>
Message-ID: <E1WzWOy-0007zc-36@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for generating a set of component matches at master probe
time, and submitting them to the component layer.  This allows the
component layer to perform the matches internally without needing to
call into the master driver, and allows for further restructuring of
the component helper.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/base/component.c  | 119 ++++++++++++++++++++++++++++++++++++++++++++--
 include/linux/component.h |   7 +++
 2 files changed, 123 insertions(+), 3 deletions(-)

diff --git a/drivers/base/component.c b/drivers/base/component.c
index 55813e91bf0d..bd8b4908593b 100644
--- a/drivers/base/component.c
+++ b/drivers/base/component.c
@@ -18,6 +18,15 @@
 #include <linux/mutex.h>
 #include <linux/slab.h>
 
+struct component_match {
+	size_t alloc;
+	size_t num;
+	struct {
+		void *data;
+		int (*fn)(struct device *, void *);
+	} compare[0];
+};
+
 struct master {
 	struct list_head node;
 	struct list_head components;
@@ -25,6 +34,7 @@ struct master {
 
 	const struct component_master_ops *ops;
 	struct device *dev;
+	struct component_match *match;
 };
 
 struct component {
@@ -96,6 +106,34 @@ int component_master_add_child(struct master *master,
 }
 EXPORT_SYMBOL_GPL(component_master_add_child);
 
+static int find_components(struct master *master)
+{
+	struct component_match *match = master->match;
+	size_t i;
+	int ret = 0;
+
+	if (!match) {
+		/*
+		 * Search the list of components, looking for components that
+		 * belong to this master, and attach them to the master.
+		 */
+		return master->ops->add_components(master->dev, master);
+	}
+
+	/*
+	 * Scan the array of match functions and attach
+	 * any components which are found to this master.
+	 */
+	for (i = 0; i < match->num; i++) {
+		ret = component_master_add_child(master,
+						 match->compare[i].fn,
+						 match->compare[i].data);
+		if (ret)
+			break;
+	}
+	return ret;
+}
+
 /* Detach all attached components from this master */
 static void master_remove_components(struct master *master)
 {
@@ -128,7 +166,7 @@ static int try_to_bring_up_master(struct master *master,
 	 * Search the list of components, looking for components that
 	 * belong to this master, and attach them to the master.
 	 */
-	if (master->ops->add_components(master->dev, master)) {
+	if (find_components(master)) {
 		/* Failed to find all components */
 		ret = 0;
 		goto out;
@@ -186,18 +224,86 @@ static void take_down_master(struct master *master)
 	master_remove_components(master);
 }
 
-int component_master_add(struct device *dev,
-	const struct component_master_ops *ops)
+static size_t component_match_size(size_t num)
+{
+	return offsetof(struct component_match, compare[num]);
+}
+
+static struct component_match *component_match_realloc(struct device *dev,
+	struct component_match *match, size_t num)
+{
+	struct component_match *new;
+
+	if (match && match->alloc == num)
+		return match;
+
+	new = devm_kmalloc(dev, component_match_size(num), GFP_KERNEL);
+	if (!new)
+		return ERR_PTR(-ENOMEM);
+
+	if (match) {
+		memcpy(new, match, component_match_size(min(match->num, num)));
+		devm_kfree(dev, match);
+	} else {
+		new->num = 0;
+	}
+
+	new->alloc = num;
+
+	return new;
+}
+
+/*
+ * Add a component to be matched.
+ *
+ * The match array is first created or extended if necessary.
+ */
+void component_match_add(struct device *dev, struct component_match **matchptr,
+	int (*compare)(struct device *, void *), void *compare_data)
+{
+	struct component_match *match = *matchptr;
+
+	if (IS_ERR(match))
+		return;
+
+	if (!match || match->num == match->alloc) {
+		size_t new_size = match ? match->alloc + 16 : 15;
+
+		match = component_match_realloc(dev, match, new_size);
+
+		*matchptr = match;
+
+		if (IS_ERR(match))
+			return;
+	}
+
+	match->compare[match->num].fn = compare;
+	match->compare[match->num].data = compare_data;
+	match->num++;
+}
+
+int component_master_add_with_match(struct device *dev,
+	const struct component_master_ops *ops,
+	struct component_match *match)
 {
 	struct master *master;
 	int ret;
 
+	if (ops->add_components && match)
+		return -EINVAL;
+
+	/* Reallocate the match array for its true size */
+	match = component_match_realloc(dev, match, match->num);
+	if (IS_ERR(match))
+		return PTR_ERR(match);
+
 	master = kzalloc(sizeof(*master), GFP_KERNEL);
 	if (!master)
 		return -ENOMEM;
 
 	master->dev = dev;
 	master->ops = ops;
+	master->match = match;
 	INIT_LIST_HEAD(&master->components);
 
 	/* Add to the list of available masters. */
@@ -215,6 +321,13 @@ int component_master_add(struct device *dev,
 
 	return ret < 0 ? ret : 0;
 }
+EXPORT_SYMBOL_GPL(component_master_add_with_match);
+
+int component_master_add(struct device *dev,
+	const struct component_master_ops *ops)
+{
+	return component_master_add_with_match(dev, ops, NULL);
+}
 EXPORT_SYMBOL_GPL(component_master_add);
 
 void component_master_del(struct device *dev,
diff --git a/include/linux/component.h b/include/linux/component.h
index 68870182ca1e..c00dcc302611 100644
--- a/include/linux/component.h
+++ b/include/linux/component.h
@@ -29,4 +29,11 @@ void component_master_del(struct device *,
 int component_master_add_child(struct master *master,
 	int (*compare)(struct device *, void *), void *compare_data);
 
+struct component_match;
+
+int component_master_add_with_match(struct device *,
+	const struct component_master_ops *, struct component_match *);
+void component_match_add(struct device *, struct component_match **,
+	int (*compare)(struct device *, void *), void *compare_data);
+
 #endif
-- 
1.8.3.1
