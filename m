From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 02 Dec 2015 08:21:41 +0100
Subject: [PATCH v4 1/3] driver core: handle -EPROBE_DEFER from bus_type.match()
In-Reply-To: <1449040903-26674-1-git-send-email-m.szyprowski@samsung.com>
References: <1449040903-26674-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1449040903-26674-2-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tomeu Vizoso <tomeu.vizoso@collabora.com>

Allow implementations of the match() callback in struct bus_type to
return errors and if it's -EPROBE_DEFER then queue the device for
deferred probing.

This is useful to buses such as AMBA in which devices are registered
before their matching information can be retrieved from the HW
(typically because a clock driver hasn't probed yet).

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
[changed if-else code structure, adjusted documentation to match the code,
extended comments]
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 Documentation/driver-model/porting.txt |  6 ++++--
 drivers/base/dd.c                      | 24 ++++++++++++++++++++++--
 include/linux/device.h                 |  7 +++++--
 3 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/Documentation/driver-model/porting.txt b/Documentation/driver-model/porting.txt
index 92d86f7..453053f 100644
--- a/Documentation/driver-model/porting.txt
+++ b/Documentation/driver-model/porting.txt
@@ -340,8 +340,10 @@ comparison:
 
   int (*match)(struct device * dev, struct device_driver * drv);
 
-match should return '1' if the driver supports the device, and '0'
-otherwise. 
+match should return positive value if the driver supports the device,
+and zero otherwise. It may also return error code (for example
+-EPROBE_DEFER) if determining that given driver supports the device is
+not possible.
 
 When a device is registered, the bus's list of drivers is iterated
 over. bus->match() is called for each one until a match is found. 
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index a641cf3..793e915 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -490,6 +490,7 @@ static int __device_attach_driver(struct device_driver *drv, void *_data)
 	struct device_attach_data *data = _data;
 	struct device *dev = data->dev;
 	bool async_allowed;
+	int ret;
 
 	/*
 	 * Check if device has already been claimed. This may
@@ -500,8 +501,17 @@ static int __device_attach_driver(struct device_driver *drv, void *_data)
 	if (dev->driver)
 		return -EBUSY;
 
-	if (!driver_match_device(drv, dev))
+	ret = driver_match_device(drv, dev);
+	if (ret == 0) {
+		/* no match */
 		return 0;
+	} else if (ret == -EPROBE_DEFER) {
+		dev_dbg(dev, "Device match requests probe deferral\n");
+		driver_deferred_probe_add(dev);
+	} else if (ret < 0) {
+		dev_dbg(dev, "Bus failed to match device: %d", ret);
+		return ret;
+	} /* ret > 0 means positive match */
 
 	async_allowed = driver_allows_async_probing(drv);
 
@@ -621,6 +631,7 @@ void device_initial_probe(struct device *dev)
 static int __driver_attach(struct device *dev, void *data)
 {
 	struct device_driver *drv = data;
+	int ret;
 
 	/*
 	 * Lock device and try to bind to it. We drop the error
@@ -632,8 +643,17 @@ static int __driver_attach(struct device *dev, void *data)
 	 * is an error.
 	 */
 
-	if (!driver_match_device(drv, dev))
+	ret = driver_match_device(drv, dev);
+	if (ret == 0) {
+		/* no match */
 		return 0;
+	} else if (ret == -EPROBE_DEFER) {
+		dev_dbg(dev, "Device match requests probe deferral\n");
+		driver_deferred_probe_add(dev);
+	} else if (ret < 0) {
+		dev_dbg(dev, "Bus failed to match device: %d", ret);
+		return ret;
+	} /* ret > 0 means positive match */
 
 	if (dev->parent)	/* Needed for USB */
 		device_lock(dev->parent);
diff --git a/include/linux/device.h b/include/linux/device.h
index b8f411b..69bea82 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -70,8 +70,11 @@ extern void bus_remove_file(struct bus_type *, struct bus_attribute *);
  * @dev_groups:	Default attributes of the devices on the bus.
  * @drv_groups: Default attributes of the device drivers on the bus.
  * @match:	Called, perhaps multiple times, whenever a new device or driver
- *		is added for this bus. It should return a nonzero value if the
- *		given device can be handled by the given driver.
+ *		is added for this bus. It should return a positive value if the
+ *		given device can be handled by the given driver and zero
+ *		otherwise. It may also return error code if determining that
+ *		the driver supports the device is not possible. In case of
+ *		-EPROBE_DEFER it will queue the device for deferred probing.
  * @uevent:	Called when a device is added, removed, or a few other things
  *		that generate uevents to add the environment variables.
  * @probe:	Called when a new device or driver add to this bus, and callback
-- 
1.9.2
