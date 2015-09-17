From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Thu, 17 Sep 2015 14:57:02 +0200
Subject: [PATCH v5 08/23] regulator: core: Drop redundant locking
In-Reply-To: <1442494637-3674-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1442494637-3674-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1442494637-3674-9-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we use a klist when looking up regulator devices, we can avoid
locking regulator_list_mutex if we take a reference on the regulator
device, if one is found.

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

Changes in v5:
- Use regulator_class' klist of devices instead of regulator_list to
  store and lookup regulator devices.

Changes in v4:
- Take a reference to the regulator's device to prevent dangling
  pointers

Changes in v3:
- Avoid unlocking the regulator device's mutex if we don't have a device

Changes in v2:
- Acquire regulator device lock before returning from
  regulator_dev_lookup()

 drivers/regulator/core.c | 49 +++++++++++++++++++++++++++++-------------------
 1 file changed, 30 insertions(+), 19 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index b048af9c1ae4..24245c78b58c 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1328,7 +1328,7 @@ static void regulator_supply_alias(struct device **dev, const char **supply)
 
 static int of_node_match(struct device *dev, const void *data)
 {
-	return dev->of_node == data;
+	return dev->of_node == data && get_device(dev);
 }
 
 static struct regulator_dev *of_find_regulator_by_node(struct device_node *np)
@@ -1344,7 +1344,7 @@ static int regulator_match(struct device *dev, const void *data)
 {
 	struct regulator_dev *r = dev_to_rdev(dev);
 
-	return strcmp(rdev_get_name(r), data) == 0;
+	return strcmp(rdev_get_name(r), data) == 0 && get_device(dev);
 }
 
 static struct regulator_dev *regulator_lookup_by_name(const char *name)
@@ -1395,16 +1395,20 @@ static struct regulator_dev *regulator_dev_lookup(struct device *dev,
 	if (r)
 		return r;
 
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
@@ -1435,6 +1439,7 @@ static int regulator_resolve_supply(struct regulator_dev *rdev)
 	if (!r) {
 		if (have_full_constraints()) {
 			r = dummy_regulator_rdev;
+			get_device(&r->dev);
 		} else {
 			dev_err(dev, "Failed to resolve %s-supply for %s\n",
 				rdev->supply_name, rdev->desc->name);
@@ -1444,12 +1449,16 @@ static int regulator_resolve_supply(struct regulator_dev *rdev)
 
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
@@ -1485,8 +1494,6 @@ static struct regulator *_regulator_get(struct device *dev, const char *id,
 	else
 		ret = -EPROBE_DEFER;
 
-	mutex_lock(&regulator_list_mutex);
-
 	rdev = regulator_dev_lookup(dev, id, &ret);
 	if (rdev)
 		goto found;
@@ -1498,7 +1505,7 @@ static struct regulator *_regulator_get(struct device *dev, const char *id,
 	 * succeed, so, quit with appropriate error value
 	 */
 	if (ret && ret != -ENODEV)
-		goto out;
+		return regulator;
 
 	if (!devname)
 		devname = "deviceless";
@@ -1512,40 +1519,46 @@ static struct regulator *_regulator_get(struct device *dev, const char *id,
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
@@ -1559,9 +1572,6 @@ found:
 			rdev->use_count = 0;
 	}
 
-out:
-	mutex_unlock(&regulator_list_mutex);
-
 	return regulator;
 }
 
@@ -1659,6 +1669,7 @@ static void _regulator_put(struct regulator *regulator)
 
 	rdev->open_count--;
 	rdev->exclusive = 0;
+	put_device(&rdev->dev);
 	mutex_unlock(&rdev->mutex);
 
 	kfree(regulator->supply_name);
-- 
2.4.3
