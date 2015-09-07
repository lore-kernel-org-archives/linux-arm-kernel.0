From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Mon,  7 Sep 2015 14:23:32 +0200
Subject: [PATCH v4 07/22] regulator: core: Reduce critical area in
 _regulator_get
In-Reply-To: <1441628627-5143-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1441628627-5143-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1441628627-5143-8-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

By moving the locking of regulator_list_mutex into regulator_dev_lookup,
where it is iterated over. The reference count of the regulator's device
is increased in case it's unregistered while in use.

In _regulator_get() the regulator_list_mutex mutex was held for most of
the function, but that is only strictly needed to protect the list
lookups.

This change would be useful if for example regulator devices could be
registered on demand when a driver requests them. regulator_register()
could end up being called from within _regulator_get while the lock on
regulator_list_mutex is being held, causing a deadlock.

This sequence illustrates the situation described above:

tegra_hdmi_probe
	_regulator_get
		regulator_dev_lookup
			of_device_probe
				reg_fixed_voltage_probe
					regulator_register

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

Changes in v4:
- Take a reference to the regulator's device to prevent dangling
  pointers

Changes in v3:
- Avoid unlocking the regulator device's mutex if we don't have a device

Changes in v2:
- Acquire regulator device lock before returning from regulator_dev_lookup()

 drivers/regulator/core.c | 56 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 38 insertions(+), 18 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 7150ff6ef46b..f4aa6cae76d5 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1340,10 +1340,15 @@ static struct regulator_dev *regulator_dev_lookup(struct device *dev,
 	if (dev && dev->of_node) {
 		node = of_get_regulator(dev, supply);
 		if (node) {
+			mutex_lock(&regulator_list_mutex);
 			list_for_each_entry(r, &regulator_list, list)
 				if (r->dev.parent &&
-					node == r->dev.of_node)
+				    node == r->dev.of_node &&
+				    get_device(&r->dev)) {
+					mutex_unlock(&regulator_list_mutex);
 					return r;
+				}
+			mutex_unlock(&regulator_list_mutex);
 			*ret = -EPROBE_DEFER;
 			return NULL;
 		} else {
@@ -1361,9 +1366,13 @@ static struct regulator_dev *regulator_dev_lookup(struct device *dev,
 	if (dev)
 		devname = dev_name(dev);
 
+	mutex_lock(&regulator_list_mutex);
 	list_for_each_entry(r, &regulator_list, list)
-		if (strcmp(rdev_get_name(r), supply) == 0)
+		if (strcmp(rdev_get_name(r), supply) == 0 &&
+		    get_device(&r->dev)) {
+			mutex_unlock(&regulator_list_mutex);
 			return r;
+		}
 
 	list_for_each_entry(map, &regulator_map_list, list) {
 		/* If the mapping has a device set up it must match */
@@ -1371,9 +1380,13 @@ static struct regulator_dev *regulator_dev_lookup(struct device *dev,
 		    (!devname || strcmp(map->dev_name, devname)))
 			continue;
 
-		if (strcmp(map->supply, supply) == 0)
+		if (strcmp(map->supply, supply) == 0 &&
+		    get_device(&map->regulator->dev)) {
+			mutex_unlock(&regulator_list_mutex);
 			return map->regulator;
+		}
 	}
+	mutex_unlock(&regulator_list_mutex);
 
 
 	return NULL;
@@ -1405,6 +1418,7 @@ static int regulator_resolve_supply(struct regulator_dev *rdev)
 	if (!r) {
 		if (have_full_constraints()) {
 			r = dummy_regulator_rdev;
+			get_device(&r->dev);
 		} else {
 			dev_err(dev, "Failed to resolve %s-supply for %s\n",
 				rdev->supply_name, rdev->desc->name);
@@ -1414,12 +1428,16 @@ static int regulator_resolve_supply(struct regulator_dev *rdev)
 
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
@@ -1455,8 +1473,6 @@ static struct regulator *_regulator_get(struct device *dev, const char *id,
 	else
 		ret = -EPROBE_DEFER;
 
-	mutex_lock(&regulator_list_mutex);
-
 	rdev = regulator_dev_lookup(dev, id, &ret);
 	if (rdev)
 		goto found;
@@ -1468,7 +1484,7 @@ static struct regulator *_regulator_get(struct device *dev, const char *id,
 	 * succeed, so, quit with appropriate error value
 	 */
 	if (ret && ret != -ENODEV)
-		goto out;
+		return regulator;
 
 	if (!devname)
 		devname = "deviceless";
@@ -1482,40 +1498,46 @@ static struct regulator *_regulator_get(struct device *dev, const char *id,
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
@@ -1529,9 +1551,6 @@ found:
 			rdev->use_count = 0;
 	}
 
-out:
-	mutex_unlock(&regulator_list_mutex);
-
 	return regulator;
 }
 
@@ -1629,6 +1648,7 @@ static void _regulator_put(struct regulator *regulator)
 
 	rdev->open_count--;
 	rdev->exclusive = 0;
+	put_device(&rdev->dev);
 	mutex_unlock(&rdev->mutex);
 
 	kfree(regulator->supply_name);
-- 
2.4.3
