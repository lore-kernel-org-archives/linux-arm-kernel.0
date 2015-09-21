From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Mon, 21 Sep 2015 16:02:47 +0200
Subject: [PATCH v6 07/22] regulator: core: Remove regulator_list
In-Reply-To: <1442844182-27787-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1442844182-27787-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1442844182-27787-8-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As we are already registering a device with regulator_class for each
regulator device, regulator_list is redundant and can be replaced with
calls to class_find_device() and class_for_each_device().

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

Changes in v6:
- Merge changes to the regulator subsystem's locking so no references
  are leaked between commits.

Changes in v5:
- Use regulator_class' klist of devices instead of regulator_list to
  store and lookup regulator devices.

 drivers/regulator/core.c | 255 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 164 insertions(+), 91 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index e5dbbe2f5212..af045e5a83ef 100644
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
@@ -1325,6 +1326,47 @@ static void regulator_supply_alias(struct device **dev, const char **supply)
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
+/**
+ * regulator_dev_lookup - lookup a regulator device.
+ * @dev: device for regulator "consumer".
+ * @supply: Supply name or regulator ID.
+ * @ret: 0 on success, -ENODEV if lookup fails permanently, -EPROBE_DEFER if
+ * lookup could succeed in the future.
+ *
+ * If successful, returns a struct regulator_dev that corresponds to the name
+ * @supply and with the embedded struct device refcount incremented by one,
+ * or NULL on failure. The refcount must be dropped by calling put_device().
+ */
 static struct regulator_dev *regulator_dev_lookup(struct device *dev,
 						  const char *supply,
 						  int *ret)
@@ -1340,10 +1382,9 @@ static struct regulator_dev *regulator_dev_lookup(struct device *dev,
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
@@ -1361,20 +1402,24 @@ static struct regulator_dev *regulator_dev_lookup(struct device *dev,
 	if (dev)
 		devname = dev_name(dev);
 
-	list_for_each_entry(r, &regulator_list, list)
-		if (strcmp(rdev_get_name(r), supply) == 0)
-			return r;
+	r = regulator_lookup_by_name(supply);
+	if (r)
+		return r;
 
+	mutex_lock(&regulator_list_mutex);
 	list_for_each_entry(map, &regulator_map_list, list) {
 		/* If the mapping has a device set up it must match */
 		if (map->dev_name &&
 		    (!devname || strcmp(map->dev_name, devname)))
 			continue;
 
-		if (strcmp(map->supply, supply) == 0)
+		if (strcmp(map->supply, supply) == 0 &&
+		    get_device(&map->regulator->dev)) {
+			mutex_unlock(&regulator_list_mutex);
 			return map->regulator;
+		}
 	}
-
+	mutex_unlock(&regulator_list_mutex);
 
 	return NULL;
 }
@@ -1405,6 +1450,7 @@ static int regulator_resolve_supply(struct regulator_dev *rdev)
 
 		if (have_full_constraints()) {
 			r = dummy_regulator_rdev;
+			get_device(&r->dev);
 		} else {
 			dev_err(dev, "Failed to resolve %s-supply for %s\n",
 				rdev->supply_name, rdev->desc->name);
@@ -1414,12 +1460,16 @@ static int regulator_resolve_supply(struct regulator_dev *rdev)
 
 	/* Recursively resolve the supply of the supply */
 	ret = regulator_resolve_supply(r);
-	if (ret < 0)
+	if (ret < 0) {
+		put_device(&r->dev);
 		return ret;
+	}
 
 	ret = set_supply(rdev, r);
-	if (ret < 0)
+	if (ret < 0) {
+		put_device(&r->dev);
 		return ret;
+	}
 
 	/* Cascade always-on state to supply */
 	if (_regulator_is_enabled(rdev) && rdev->supply) {
@@ -1455,8 +1505,6 @@ static struct regulator *_regulator_get(struct device *dev, const char *id,
 	else
 		ret = -EPROBE_DEFER;
 
-	mutex_lock(&regulator_list_mutex);
-
 	rdev = regulator_dev_lookup(dev, id, &ret);
 	if (rdev)
 		goto found;
@@ -1468,7 +1516,7 @@ static struct regulator *_regulator_get(struct device *dev, const char *id,
 	 * succeed, so, quit with appropriate error value
 	 */
 	if (ret && ret != -ENODEV)
-		goto out;
+		return regulator;
 
 	if (!devname)
 		devname = "deviceless";
@@ -1482,40 +1530,46 @@ static struct regulator *_regulator_get(struct device *dev, const char *id,
 			devname, id);
 
 		rdev = dummy_regulator_rdev;
+		get_device(&rdev->dev);
 		goto found;
 	/* Don't log an error when called from regulator_get_optional() */
 	} else if (!have_full_constraints() || exclusive) {
 		dev_warn(dev, "dummy supplies not allowed\n");
 	}
 
-	mutex_unlock(&regulator_list_mutex);
 	return regulator;
 
 found:
 	if (rdev->exclusive) {
 		regulator = ERR_PTR(-EPERM);
-		goto out;
+		put_device(&rdev->dev);
+		return regulator;
 	}
 
 	if (exclusive && rdev->open_count) {
 		regulator = ERR_PTR(-EBUSY);
-		goto out;
+		put_device(&rdev->dev);
+		return regulator;
 	}
 
 	ret = regulator_resolve_supply(rdev);
 	if (ret < 0) {
 		regulator = ERR_PTR(ret);
-		goto out;
+		put_device(&rdev->dev);
+		return regulator;
 	}
 
-	if (!try_module_get(rdev->owner))
-		goto out;
+	if (!try_module_get(rdev->owner)) {
+		put_device(&rdev->dev);
+		return regulator;
+	}
 
 	regulator = create_regulator(rdev, dev, id);
 	if (regulator == NULL) {
 		regulator = ERR_PTR(-ENOMEM);
+		put_device(&rdev->dev);
 		module_put(rdev->owner);
-		goto out;
+		return regulator;
 	}
 
 	rdev->open_count++;
@@ -1529,9 +1583,6 @@ found:
 			rdev->use_count = 0;
 	}
 
-out:
-	mutex_unlock(&regulator_list_mutex);
-
 	return regulator;
 }
 
@@ -1629,6 +1680,7 @@ static void _regulator_put(struct regulator *regulator)
 
 	rdev->open_count--;
 	rdev->exclusive = 0;
+	put_device(&rdev->dev);
 	mutex_unlock(&rdev->mutex);
 
 	kfree(regulator->supply_name);
@@ -3806,8 +3858,6 @@ regulator_register(const struct regulator_desc *regulator_desc,
 		}
 	}
 
-	list_add(&rdev->list, &regulator_list);
-
 	rdev_init_debugfs(rdev);
 out:
 	mutex_unlock(&regulator_list_mutex);
@@ -3861,6 +3911,19 @@ void regulator_unregister(struct regulator_dev *rdev)
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
@@ -3870,30 +3933,45 @@ EXPORT_SYMBOL_GPL(regulator_unregister);
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
@@ -3903,33 +3981,8 @@ EXPORT_SYMBOL_GPL(regulator_suspend_prepare);
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
 
@@ -4049,14 +4102,35 @@ static const struct file_operations supply_map_fops = {
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
@@ -4106,33 +4180,32 @@ static void regulator_summary_show_subtree(struct seq_file *s,
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
@@ -4166,7 +4239,7 @@ static int __init regulator_init(void)
 			    &supply_map_fops);
 
 	debugfs_create_file("regulator_summary", 0444, debugfs_root,
-			    &regulator_list, &regulator_summary_fops);
+			    NULL, &regulator_summary_fops);
 
 	regulator_dummy_init();
 
-- 
2.4.3
