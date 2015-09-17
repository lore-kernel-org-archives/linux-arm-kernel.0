From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Thu, 17 Sep 2015 14:57:01 +0200
Subject: [PATCH v5 07/23] regulator: core: Remove regulator_list
In-Reply-To: <1442494637-3674-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1442494637-3674-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1442494637-3674-8-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As we are already registering a device with regulator_class for each
regulator device, regulator_list is redundant and can be replaced with
calls to class_find_device() and class_for_each_device().

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/regulator/core.c | 199 +++++++++++++++++++++++++++++------------------
 1 file changed, 125 insertions(+), 74 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index b616d34a4afa..b048af9c1ae4 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -51,7 +51,6 @@
 	pr_debug("%s: " fmt, rdev_get_name(rdev), ##__VA_ARGS__)
 
 static DEFINE_MUTEX(regulator_list_mutex);
-static LIST_HEAD(regulator_list);
 static LIST_HEAD(regulator_map_list);
 static LIST_HEAD(regulator_ena_gpio_list);
 static LIST_HEAD(regulator_supply_alias_list);
@@ -59,6 +58,8 @@ static bool has_full_constraints;
 
 static struct dentry *debugfs_root;
 
+static struct class regulator_class;
+
 /*
  * struct regulator_map
  *
@@ -1325,6 +1326,36 @@ static void regulator_supply_alias(struct device **dev, const char **supply)
 	}
 }
 
+static int of_node_match(struct device *dev, const void *data)
+{
+	return dev->of_node == data;
+}
+
+static struct regulator_dev *of_find_regulator_by_node(struct device_node *np)
+{
+	struct device *dev;
+
+	dev = class_find_device(&regulator_class, NULL, np, of_node_match);
+
+	return dev ? dev_to_rdev(dev) : NULL;
+}
+
+static int regulator_match(struct device *dev, const void *data)
+{
+	struct regulator_dev *r = dev_to_rdev(dev);
+
+	return strcmp(rdev_get_name(r), data) == 0;
+}
+
+static struct regulator_dev *regulator_lookup_by_name(const char *name)
+{
+	struct device *dev;
+
+	dev = class_find_device(&regulator_class, NULL, name, regulator_match);
+
+	return dev ? dev_to_rdev(dev) : NULL;
+}
+
 static struct regulator_dev *regulator_dev_lookup(struct device *dev,
 						  const char *supply,
 						  int *ret)
@@ -1340,10 +1371,9 @@ static struct regulator_dev *regulator_dev_lookup(struct device *dev,
 	if (dev && dev->of_node) {
 		node = of_get_regulator(dev, supply);
 		if (node) {
-			list_for_each_entry(r, &regulator_list, list)
-				if (r->dev.parent &&
-					node == r->dev.of_node)
-					return r;
+			r = of_find_regulator_by_node(node);
+			if (r)
+				return r;
 			*ret = -EPROBE_DEFER;
 			return NULL;
 		} else {
@@ -1361,9 +1391,9 @@ static struct regulator_dev *regulator_dev_lookup(struct device *dev,
 	if (dev)
 		devname = dev_name(dev);
 
-	list_for_each_entry(r, &regulator_list, list)
-		if (strcmp(rdev_get_name(r), supply) == 0)
-			return r;
+	r = regulator_lookup_by_name(supply);
+	if (r)
+		return r;
 
 	list_for_each_entry(map, &regulator_map_list, list) {
 		/* If the mapping has a device set up it must match */
@@ -3806,8 +3836,6 @@ regulator_register(const struct regulator_desc *regulator_desc,
 		}
 	}
 
-	list_add(&rdev->list, &regulator_list);
-
 	rdev_init_debugfs(rdev);
 out:
 	mutex_unlock(&regulator_list_mutex);
@@ -3861,6 +3889,19 @@ void regulator_unregister(struct regulator_dev *rdev)
 }
 EXPORT_SYMBOL_GPL(regulator_unregister);
 
+static int _regulator_suspend_prepare(struct device *dev, void *data)
+{
+	struct regulator_dev *rdev = dev_to_rdev(dev);
+	const suspend_state_t *state = data;
+	int ret;
+
+	mutex_lock(&rdev->mutex);
+	ret = suspend_prepare(rdev, *state);
+	mutex_unlock(&rdev->mutex);
+
+	return ret;
+}
+
 /**
  * regulator_suspend_prepare - prepare regulators for system wide suspend
  * @state: system suspend state
@@ -3870,30 +3911,45 @@ EXPORT_SYMBOL_GPL(regulator_unregister);
  */
 int regulator_suspend_prepare(suspend_state_t state)
 {
-	struct regulator_dev *rdev;
-	int ret = 0;
-
 	/* ON is handled by regulator active state */
 	if (state == PM_SUSPEND_ON)
 		return -EINVAL;
 
-	mutex_lock(&regulator_list_mutex);
-	list_for_each_entry(rdev, &regulator_list, list) {
+	return class_for_each_device(&regulator_class, NULL, &state,
+				     _regulator_suspend_prepare);
+}
+EXPORT_SYMBOL_GPL(regulator_suspend_prepare);
 
-		mutex_lock(&rdev->mutex);
-		ret = suspend_prepare(rdev, state);
-		mutex_unlock(&rdev->mutex);
+static int _regulator_suspend_finish(struct device *dev, void *data)
+{
+	struct regulator_dev *rdev = dev_to_rdev(dev);
+	int ret;
 
-		if (ret < 0) {
-			rdev_err(rdev, "failed to prepare\n");
-			goto out;
+	mutex_lock(&rdev->mutex);
+	if (rdev->use_count > 0  || rdev->constraints->always_on) {
+		if (!_regulator_is_enabled(rdev)) {
+			ret = _regulator_do_enable(rdev);
+			if (ret)
+				dev_err(dev,
+					"Failed to resume regulator %d\n",
+					ret);
 		}
+	} else {
+		if (!have_full_constraints())
+			goto unlock;
+		if (!_regulator_is_enabled(rdev))
+			goto unlock;
+
+		ret = _regulator_do_disable(rdev);
+		if (ret)
+			dev_err(dev, "Failed to suspend regulator %d\n", ret);
 	}
-out:
-	mutex_unlock(&regulator_list_mutex);
-	return ret;
+unlock:
+	mutex_unlock(&rdev->mutex);
+
+	/* Keep processing regulators in spite of any errors */
+	return 0;
 }
-EXPORT_SYMBOL_GPL(regulator_suspend_prepare);
 
 /**
  * regulator_suspend_finish - resume regulators from system wide suspend
@@ -3903,33 +3959,8 @@ EXPORT_SYMBOL_GPL(regulator_suspend_prepare);
  */
 int regulator_suspend_finish(void)
 {
-	struct regulator_dev *rdev;
-	int ret = 0, error;
-
-	mutex_lock(&regulator_list_mutex);
-	list_for_each_entry(rdev, &regulator_list, list) {
-		mutex_lock(&rdev->mutex);
-		if (rdev->use_count > 0  || rdev->constraints->always_on) {
-			if (!_regulator_is_enabled(rdev)) {
-				error = _regulator_do_enable(rdev);
-				if (error)
-					ret = error;
-			}
-		} else {
-			if (!have_full_constraints())
-				goto unlock;
-			if (!_regulator_is_enabled(rdev))
-				goto unlock;
-
-			error = _regulator_do_disable(rdev);
-			if (error)
-				ret = error;
-		}
-unlock:
-		mutex_unlock(&rdev->mutex);
-	}
-	mutex_unlock(&regulator_list_mutex);
-	return ret;
+	return class_for_each_device(&regulator_class, NULL, NULL,
+				     _regulator_suspend_finish);
 }
 EXPORT_SYMBOL_GPL(regulator_suspend_finish);
 
@@ -4049,14 +4080,35 @@ static const struct file_operations supply_map_fops = {
 };
 
 #ifdef CONFIG_DEBUG_FS
+struct summary_data {
+	struct seq_file *s;
+	struct regulator_dev *parent;
+	int level;
+};
+
+static void regulator_summary_show_subtree(struct seq_file *s,
+					   struct regulator_dev *rdev,
+					   int level);
+
+static int regulator_summary_show_children(struct device *dev, void *data)
+{
+	struct regulator_dev *rdev = dev_to_rdev(dev);
+	struct summary_data *summary_data = data;
+
+	if (rdev->supply && rdev->supply->rdev == summary_data->parent)
+		regulator_summary_show_subtree(summary_data->s, rdev,
+					       summary_data->level + 1);
+
+	return 0;
+}
+
 static void regulator_summary_show_subtree(struct seq_file *s,
 					   struct regulator_dev *rdev,
 					   int level)
 {
-	struct list_head *list = s->private;
-	struct regulator_dev *child;
 	struct regulation_constraints *c;
 	struct regulator *consumer;
+	struct summary_data summary_data;
 
 	if (!rdev)
 		return;
@@ -4106,33 +4158,32 @@ static void regulator_summary_show_subtree(struct seq_file *s,
 		seq_puts(s, "\n");
 	}
 
-	list_for_each_entry(child, list, list) {
-		/* handle only non-root regulators supplied by current rdev */
-		if (!child->supply || child->supply->rdev != rdev)
-			continue;
+	summary_data.s = s;
+	summary_data.level = level;
+	summary_data.parent = rdev;
 
-		regulator_summary_show_subtree(s, child, level + 1);
-	}
+	class_for_each_device(&regulator_class, NULL, &summary_data,
+			      regulator_summary_show_children);
 }
 
-static int regulator_summary_show(struct seq_file *s, void *data)
+static int regulator_summary_show_roots(struct device *dev, void *data)
 {
-	struct list_head *list = s->private;
-	struct regulator_dev *rdev;
-
-	seq_puts(s, " regulator                      use open bypass voltage current     min     max\n");
-	seq_puts(s, "-------------------------------------------------------------------------------\n");
+	struct regulator_dev *rdev = dev_to_rdev(dev);
+	struct seq_file *s = data;
 
-	mutex_lock(&regulator_list_mutex);
+	if (!rdev->supply)
+		regulator_summary_show_subtree(s, rdev, 0);
 
-	list_for_each_entry(rdev, list, list) {
-		if (rdev->supply)
-			continue;
+	return 0;
+}
 
-		regulator_summary_show_subtree(s, rdev, 0);
-	}
+static int regulator_summary_show(struct seq_file *s, void *data)
+{
+	seq_puts(s, " regulator                      use open bypass voltage current     min     max\n");
+	seq_puts(s, "-------------------------------------------------------------------------------\n");
 
-	mutex_unlock(&regulator_list_mutex);
+	class_for_each_device(&regulator_class, NULL, s,
+			      regulator_summary_show_roots);
 
 	return 0;
 }
@@ -4166,7 +4217,7 @@ static int __init regulator_init(void)
 			    &supply_map_fops);
 
 	debugfs_create_file("regulator_summary", 0444, debugfs_root,
-			    &regulator_list, &regulator_summary_fops);
+			    NULL, &regulator_summary_fops);
 
 	regulator_dummy_init();
 
-- 
2.4.3
