From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Mon, 21 Sep 2015 16:02:41 +0200
Subject: [PATCH v6 01/22] driver core: handle -EPROBE_DEFER from
 bus_type.match()
In-Reply-To: <1442844182-27787-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1442844182-27787-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1442844182-27787-2-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lets implementations of the match() callback in struct bus_type to
return errors and if it's -EPROBE_DEFER then queue the device for
deferred probing.

This is useful to buses such as AMBA in which devices are registered
before their matching information can be retrieved from the HW
(typically because a clock driver hasn't probed yet).

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---


 drivers/base/dd.c      | 24 ++++++++++++++++++++++--
 include/linux/device.h |  2 +-
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index be0eb4639128..7dc04ee81c8b 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -488,6 +488,7 @@ static int __device_attach_driver(struct device_driver *drv, void *_data)
 	struct device_attach_data *data = _data;
 	struct device *dev = data->dev;
 	bool async_allowed;
+	int ret;
 
 	/*
 	 * Check if device has already been claimed. This may
@@ -498,8 +499,17 @@ static int __device_attach_driver(struct device_driver *drv, void *_data)
 	if (dev->driver)
 		return -EBUSY;
 
-	if (!driver_match_device(drv, dev))
+	ret = driver_match_device(drv, dev);
+	if (!ret)
 		return 0;
+	else if (ret < 0) {
+		if (ret == -EPROBE_DEFER) {
+			dev_dbg(dev, "Device match requests probe deferral\n");
+			driver_deferred_probe_add(dev);
+		} else
+			dev_warn(dev, "Bus failed to match device: %d", ret);
+		return ret;
+	}
 
 	async_allowed = driver_allows_async_probing(drv);
 
@@ -619,6 +629,7 @@ void device_initial_probe(struct device *dev)
 static int __driver_attach(struct device *dev, void *data)
 {
 	struct device_driver *drv = data;
+	int ret;
 
 	/*
 	 * Lock device and try to bind to it. We drop the error
@@ -630,8 +641,17 @@ static int __driver_attach(struct device *dev, void *data)
 	 * is an error.
 	 */
 
-	if (!driver_match_device(drv, dev))
+	ret = driver_match_device(drv, dev);
+	if (!ret)
+		return 0;
+	else if (ret < 0) {
+		if (ret == -EPROBE_DEFER) {
+			dev_dbg(dev, "Device match requests probe deferral\n");
+			driver_deferred_probe_add(dev);
+		} else
+			dev_warn(dev, "Bus failed to match device: %d", ret);
 		return 0;
+	}
 
 	if (dev->parent)	/* Needed for USB */
 		device_lock(dev->parent);
diff --git a/include/linux/device.h b/include/linux/device.h
index 5d7bc6349930..8e7b806f0744 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -70,7 +70,7 @@ extern void bus_remove_file(struct bus_type *, struct bus_attribute *);
  * @dev_groups:	Default attributes of the devices on the bus.
  * @drv_groups: Default attributes of the device drivers on the bus.
  * @match:	Called, perhaps multiple times, whenever a new device or driver
- *		is added for this bus. It should return a nonzero value if the
+ *		is added for this bus. It should return a positive value if the
  *		given device can be handled by the given driver.
  * @uevent:	Called when a device is added, removed, or a few other things
  *		that generate uevents to add the environment variables.
-- 
2.4.3
