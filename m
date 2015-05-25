From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Mon, 25 May 2015 16:53:05 +0200
Subject: [PATCH 01/21] regulator: core: Reduce critical area in _regulator_get
In-Reply-To: <1432565608-26036-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1432565608-26036-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1432565608-26036-2-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

...by moving the locking to regulator_dev_lookup.

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
(of_platform_device_create_pdata+0x88/0xbc)
(of_platform_device_create_pdata) from [<c095caac>]
(of_platform_bus_create+0xec/0x30c)
(of_platform_bus_create) from [<c095cb08>]
(of_platform_bus_create+0x148/0x30c)
(of_platform_bus_create) from [<c095cf28>]
(of_platform_device_ensure+0xbc/0xe0)
(of_platform_device_ensure) from [<c05ec33c>]
(regulator_dev_lookup+0x80/0x1e8)
(regulator_dev_lookup) from [<c05ee7c0>] (_regulator_get+0x8c/0x26c)
(_regulator_get) from [<c05ee9c0>] (regulator_get+0x20/0x24)
(regulator_get) from [<c05efb1c>] (_devm_regulator_get+0xa4/0xc8)
(_devm_regulator_get) from [<c05efb5c>] (devm_regulator_get+0x1c/0x20)
(devm_regulator_get) from [<c06ba870>] (tegra_hdmi_probe+0xe0/0x278)
(tegra_hdmi_probe) from [<c06cc7fc>] (platform_drv_probe+0x54/0xbc)

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 drivers/regulator/core.c | 43 +++++++++++++++++++------------------------
 1 file changed, 19 insertions(+), 24 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 443eaab..50f4404 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1286,10 +1286,14 @@ static struct regulator_dev *regulator_dev_lookup(struct device *dev,
 	if (dev && dev->of_node) {
 		node = of_get_regulator(dev, supply);
 		if (node) {
+			mutex_lock(&regulator_list_mutex);
 			list_for_each_entry(r, &regulator_list, list)
 				if (r->dev.parent &&
-					node == r->dev.of_node)
+				    node == r->dev.of_node) {
+					mutex_unlock(&regulator_list_mutex);
 					return r;
+				}
+			mutex_unlock(&regulator_list_mutex);
 			*ret = -EPROBE_DEFER;
 			return NULL;
 		} else {
@@ -1307,9 +1311,13 @@ static struct regulator_dev *regulator_dev_lookup(struct device *dev,
 	if (dev)
 		devname = dev_name(dev);
 
+	mutex_lock(&regulator_list_mutex);
 	list_for_each_entry(r, &regulator_list, list)
-		if (strcmp(rdev_get_name(r), supply) == 0)
+		if (strcmp(rdev_get_name(r), supply) == 0) {
+			mutex_unlock(&regulator_list_mutex);
 			return r;
+		}
+	mutex_unlock(&regulator_list_mutex);
 
 	list_for_each_entry(map, &regulator_map_list, list) {
 		/* If the mapping has a device set up it must match */
@@ -1395,8 +1403,6 @@ static struct regulator *_regulator_get(struct device *dev, const char *id,
 	else
 		ret = -EPROBE_DEFER;
 
-	mutex_lock(&regulator_list_mutex);
-
 	rdev = regulator_dev_lookup(dev, id, &ret);
 	if (rdev)
 		goto found;
@@ -1408,7 +1414,7 @@ static struct regulator *_regulator_get(struct device *dev, const char *id,
 	 * succeed, so, quit with appropriate error value
 	 */
 	if (ret && ret != -ENODEV)
-		goto out;
+		return regulator;
 
 	if (!devname)
 		devname = "deviceless";
@@ -1428,34 +1434,26 @@ static struct regulator *_regulator_get(struct device *dev, const char *id,
 		dev_warn(dev, "dummy supplies not allowed\n");
 	}
 
-	mutex_unlock(&regulator_list_mutex);
 	return regulator;
 
 found:
-	if (rdev->exclusive) {
-		regulator = ERR_PTR(-EPERM);
-		goto out;
-	}
+	if (rdev->exclusive)
+		return ERR_PTR(-EPERM);
 
-	if (exclusive && rdev->open_count) {
-		regulator = ERR_PTR(-EBUSY);
-		goto out;
-	}
+	if (exclusive && rdev->open_count)
+		return ERR_PTR(-EBUSY);
 
 	ret = regulator_resolve_supply(rdev);
-	if (ret < 0) {
-		regulator = ERR_PTR(ret);
-		goto out;
-	}
+	if (ret < 0)
+		return ERR_PTR(ret);
 
 	if (!try_module_get(rdev->owner))
-		goto out;
+		return regulator;
 
 	regulator = create_regulator(rdev, dev, id);
 	if (regulator == NULL) {
-		regulator = ERR_PTR(-ENOMEM);
 		module_put(rdev->owner);
-		goto out;
+		return ERR_PTR(-ENOMEM);
 	}
 
 	rdev->open_count++;
@@ -1469,9 +1467,6 @@ found:
 			rdev->use_count = 0;
 	}
 
-out:
-	mutex_unlock(&regulator_list_mutex);
-
 	return regulator;
 }
 
-- 
2.4.1
