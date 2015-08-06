From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Thu,  6 Aug 2015 16:11:42 +0200
Subject: [PATCH v3 05/18] regulator: core: Reduce critical area in
 _regulator_get
In-Reply-To: <1438870315-18689-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1438870315-18689-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1438870315-18689-6-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

...by moving the locking of regulator_list_mutex into
regulator_dev_lookup(), where it is iterated over.

The regulator device lock gets acquired before returning, and the caller
is responsible for releasing it after it's done with the regulator
device.

In _regulator_get() the regulator_list_mutex mutex is held for most of
the function, but is only strictly needed to protect the list lookups.

This change would be useful if for example regulator devices could be
registered on demand when a driver requests them. regulator_register()
could end up being called from within _regulator_get while the lock on
regulator_list_mutex is being held, causing a deadlock.

This backtrace illustrates the situation described above:

(regulator_register) from [<c05efe64>]
(devm_regulator_register+0x48/0x84)
(devm_regulator_register) from [<c05f0b20>]
(reg_fixed_voltage_probe+0x214/0x35c)
(reg_fixed_voltage_probe) from [<c06cc7fc>]
(platform_drv_probe+0x54/0xbc)
(platform_drv_probe) from [<c06caac8>] (driver_probe_device+0x184/0x2c4)
(driver_probe_device) from [<c06cac58>] (__device_attach+0x50/0x54)
(__device_attach) from [<c06c8eac>] (bus_for_each_drv+0x70/0xa4)
(bus_for_each_drv) from [<c06ca900>] (device_attach+0x90/0xa4)
(device_attach) from [<c06c9eb4>] (bus_probe_device+0x94/0xb8)
(bus_probe_device) from [<c06c7de8>] (device_add+0x384/0x580)
(device_add) from [<c095c104>] (of_device_add+0x44/0x4c)
(of_device_add) from [<c095c968>]
...
(regulator_dev_lookup) from [<c05ee7c0>] (_regulator_get+0x8c/0x26c)
(_regulator_get) from [<c05ee9c0>] (regulator_get+0x20/0x24)
(regulator_get) from [<c05efb1c>] (_devm_regulator_get+0xa4/0xc8)
(_devm_regulator_get) from [<c05efb5c>] (devm_regulator_get+0x1c/0x20)
(devm_regulator_get) from [<c06ba870>] (tegra_hdmi_probe+0xe0/0x278)
(tegra_hdmi_probe) from [<c06cc7fc>] (platform_drv_probe+0x54/0xbc)

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

Changes in v3:
- Avoid unlocking the regulator device's mutex if we don't have a device

Changes in v2:
- Acquire regulator device lock before returning from regulator_dev_lookup()

 drivers/regulator/core.c | 104 +++++++++++++++++++++++++++--------------------
 1 file changed, 59 insertions(+), 45 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 613034667b93..5f6c76142b08 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -110,6 +110,7 @@ static struct regulator *create_regulator(struct regulator_dev *rdev,
 					  struct device *dev,
 					  const char *supply_name);
 static void _regulator_put(struct regulator *regulator);
+static int _regulator_enable(struct regulator *regulator, bool do_lock);
 
 static const char *rdev_get_name(struct regulator_dev *rdev)
 {
@@ -1212,6 +1213,7 @@ static void unset_regulator_supplies(struct regulator_dev *rdev)
 
 #define REG_STR_SIZE	64
 
+/* rdev->mutex held by caller */
 static struct regulator *create_regulator(struct regulator_dev *rdev,
 					  struct device *dev,
 					  const char *supply_name)
@@ -1224,7 +1226,7 @@ static struct regulator *create_regulator(struct regulator_dev *rdev,
 	if (regulator == NULL)
 		return NULL;
 
-	mutex_lock(&rdev->mutex);
+	lockdep_assert_held_once(&rdev->mutex);
 	regulator->rdev = rdev;
 	list_add(&regulator->list, &rdev->consumer_list);
 
@@ -1276,12 +1278,10 @@ static struct regulator *create_regulator(struct regulator_dev *rdev,
 	    _regulator_is_enabled(rdev))
 		regulator->always_on = true;
 
-	mutex_unlock(&rdev->mutex);
 	return regulator;
 overflow_err:
 	list_del(&regulator->list);
 	kfree(regulator);
-	mutex_unlock(&rdev->mutex);
 	return NULL;
 }
 
@@ -1320,6 +1320,7 @@ static void regulator_supply_alias(struct device **dev, const char **supply)
 	}
 }
 
+/* Caller has to release r->mutex once done with r */
 static struct regulator_dev *regulator_dev_lookup(struct device *dev,
 						  const char *supply,
 						  int *ret)
@@ -1335,10 +1336,15 @@ static struct regulator_dev *regulator_dev_lookup(struct device *dev,
 	if (dev && dev->of_node) {
 		node = of_get_regulator(dev, supply);
 		if (node) {
+			mutex_lock(&regulator_list_mutex);
 			list_for_each_entry(r, &regulator_list, list)
 				if (r->dev.parent &&
-					node == r->dev.of_node)
+					node == r->dev.of_node) {
+					mutex_lock(&r->mutex);
+					mutex_unlock(&regulator_list_mutex);
 					return r;
+				}
+			mutex_unlock(&regulator_list_mutex);
 			*ret = -EPROBE_DEFER;
 			return NULL;
 		} else {
@@ -1356,9 +1362,14 @@ static struct regulator_dev *regulator_dev_lookup(struct device *dev,
 	if (dev)
 		devname = dev_name(dev);
 
+	mutex_lock(&regulator_list_mutex);
 	list_for_each_entry(r, &regulator_list, list)
-		if (strcmp(rdev_get_name(r), supply) == 0)
+		if (strcmp(rdev_get_name(r), supply) == 0) {
+			mutex_lock(&r->mutex);
+			mutex_unlock(&regulator_list_mutex);
 			return r;
+		}
+	mutex_unlock(&regulator_list_mutex);
 
 	list_for_each_entry(map, &regulator_map_list, list) {
 		/* If the mapping has a device set up it must match */
@@ -1400,6 +1411,7 @@ static int regulator_resolve_supply(struct regulator_dev *rdev)
 	if (!r) {
 		if (have_full_constraints()) {
 			r = dummy_regulator_rdev;
+			mutex_lock(&r->mutex);
 		} else {
 			dev_err(dev, "Failed to resolve %s-supply for %s\n",
 				rdev->supply_name, rdev->desc->name);
@@ -1410,23 +1422,25 @@ static int regulator_resolve_supply(struct regulator_dev *rdev)
 	/* Recursively resolve the supply of the supply */
 	ret = regulator_resolve_supply(r);
 	if (ret < 0)
-		return ret;
+		goto out;
 
 	ret = set_supply(rdev, r);
 	if (ret < 0)
-		return ret;
+		goto out;
 
 	/* Cascade always-on state to supply */
 	if (_regulator_is_enabled(rdev)) {
-		ret = regulator_enable(rdev->supply);
+		ret = _regulator_enable(rdev->supply, false);
 		if (ret < 0) {
 			if (rdev->supply)
 				_regulator_put(rdev->supply);
-			return ret;
+			goto out;
 		}
 	}
 
-	return 0;
+out:
+	mutex_unlock(&r->mutex);
+	return ret;
 }
 
 /* Internal regulator request function */
@@ -1451,8 +1465,6 @@ static struct regulator *_regulator_get(struct device *dev, const char *id,
 	else
 		ret = -EPROBE_DEFER;
 
-	mutex_lock(&regulator_list_mutex);
-
 	rdev = regulator_dev_lookup(dev, id, &ret);
 	if (rdev)
 		goto found;
@@ -1464,7 +1476,7 @@ static struct regulator *_regulator_get(struct device *dev, const char *id,
 	 * succeed, so, quit with appropriate error value
 	 */
 	if (ret && ret != -ENODEV)
-		goto out;
+		return regulator;
 
 	if (!devname)
 		devname = "deviceless";
@@ -1478,13 +1490,13 @@ static struct regulator *_regulator_get(struct device *dev, const char *id,
 			devname, id);
 
 		rdev = dummy_regulator_rdev;
+		mutex_lock(&rdev->mutex);
 		goto found;
 	/* Don't log an error when called from regulator_get_optional() */
 	} else if (!have_full_constraints() || exclusive) {
 		dev_warn(dev, "dummy supplies not allowed\n");
 	}
 
-	mutex_unlock(&regulator_list_mutex);
 	return regulator;
 
 found:
@@ -1526,8 +1538,7 @@ found:
 	}
 
 out:
-	mutex_unlock(&regulator_list_mutex);
-
+	mutex_unlock(&rdev->mutex);
 	return regulator;
 }
 
@@ -1986,12 +1997,24 @@ static int _regulator_do_enable(struct regulator_dev *rdev)
 	return 0;
 }
 
-/* locks held by regulator_enable() */
-static int _regulator_enable(struct regulator_dev *rdev)
+static int _regulator_enable(struct regulator *regulator, bool do_lock)
 {
-	int ret;
+	struct regulator_dev *rdev = regulator->rdev;
+	int ret = 0;
 
-	lockdep_assert_held_once(&rdev->mutex);
+	if (regulator->always_on)
+		return 0;
+
+	if (rdev->supply) {
+		ret = regulator_enable(rdev->supply);
+		if (ret != 0)
+			return ret;
+	}
+
+	if (do_lock)
+		mutex_lock(&rdev->mutex);
+	else
+		lockdep_assert_held_once(&rdev->mutex);
 
 	/* check voltage and requested load before enabling */
 	if (rdev->constraints &&
@@ -2002,23 +2025,33 @@ static int _regulator_enable(struct regulator_dev *rdev)
 		/* The regulator may on if it's not switchable or left on */
 		ret = _regulator_is_enabled(rdev);
 		if (ret == -EINVAL || ret == 0) {
-			if (!_regulator_can_change_status(rdev))
-				return -EPERM;
+			if (!_regulator_can_change_status(rdev)) {
+				ret = -EPERM;
+				goto out;
+			}
 
 			ret = _regulator_do_enable(rdev);
 			if (ret < 0)
-				return ret;
+				goto out;
 
 		} else if (ret < 0) {
 			rdev_err(rdev, "is_enabled() failed: %d\n", ret);
-			return ret;
+			goto out;
 		}
 		/* Fallthrough on positive return values - already enabled */
+		ret = 0;
 	}
 
 	rdev->use_count++;
 
-	return 0;
+out:
+	if (do_lock)
+		mutex_unlock(&rdev->mutex);
+
+	if (ret != 0 && rdev->supply)
+		regulator_disable(rdev->supply);
+
+	return ret;
 }
 
 /**
@@ -2034,26 +2067,7 @@ static int _regulator_enable(struct regulator_dev *rdev)
  */
 int regulator_enable(struct regulator *regulator)
 {
-	struct regulator_dev *rdev = regulator->rdev;
-	int ret = 0;
-
-	if (regulator->always_on)
-		return 0;
-
-	if (rdev->supply) {
-		ret = regulator_enable(rdev->supply);
-		if (ret != 0)
-			return ret;
-	}
-
-	mutex_lock(&rdev->mutex);
-	ret = _regulator_enable(rdev);
-	mutex_unlock(&rdev->mutex);
-
-	if (ret != 0 && rdev->supply)
-		regulator_disable(rdev->supply);
-
-	return ret;
+	return _regulator_enable(regulator, true);
 }
 EXPORT_SYMBOL_GPL(regulator_enable);
 
-- 
2.4.3
