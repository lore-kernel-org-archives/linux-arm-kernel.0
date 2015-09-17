From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Thu, 17 Sep 2015 14:56:55 +0200
Subject: [PATCH v5 01/23] driver core: Add pre_probe callback to bus_type
In-Reply-To: <1442494637-3674-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1442494637-3674-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1442494637-3674-2-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some buses (eg. AMBA) need access to some HW resources (it may need a
clock to be enabled so a device ID can be read) before a device can be
matched to a driver.

The pre_probe callback allows the device-driver core to request the bus
to perform this initialization and can defer the probe if any of the
resources needed are missing.

This gives us more flexibility when setting the order in which devices
are probed because the resources needed to get the matching information
don't need to be available by the time that the bus devices are
registered.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

Changes in v5:
- Reduce some code duplication by adding device_pre_probe()
- Print a warning if pre_probe() returns an error

Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/base/dd.c      | 39 +++++++++++++++++++++++++++++++++++++++
 include/linux/device.h |  4 ++++
 2 files changed, 43 insertions(+)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index be0eb4639128..5caa8478404d 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -539,6 +539,37 @@ static void __device_attach_async_helper(void *_dev, async_cookie_t cookie)
 	put_device(dev);
 }
 
+/**
+ * device_pre_probe - perform initializations before a device can be matched
+ * @dev: device.
+ *
+ * Call the pre_probe() callback in the bus, if any, to give it a chance to
+ * perform any initializations needed before the device can be matched to a
+ * driver (for example, read a device id from a register).
+ *
+ * Returns 1 if the operation was successful or there's no pre_probe callback
+ * 0 if an error happened and the device isn't ready to be matched to a driver
+ */
+static int device_pre_probe(struct device *dev)
+{
+	int ret;
+
+	if (!dev->bus || !dev->bus->pre_probe)
+		return 1;
+
+	ret = dev->bus->pre_probe(dev);
+	if (ret) {
+		if (ret == -EPROBE_DEFER)
+			driver_deferred_probe_add(dev);
+		else
+			dev_warn(dev, "pre-probe failed: %d\n", ret);
+
+		return 0;
+	}
+
+	return 1;
+}
+
 static int __device_attach(struct device *dev, bool allow_async)
 {
 	int ret = 0;
@@ -566,6 +597,11 @@ static int __device_attach(struct device *dev, bool allow_async)
 		if (dev->parent)
 			pm_runtime_get_sync(dev->parent);
 
+		if (!device_pre_probe(dev)) {
+			ret = 0;
+			goto out_unlock;
+		}
+
 		ret = bus_for_each_drv(dev->bus, NULL, &data,
 					__device_attach_driver);
 		if (!ret && allow_async && data.have_async) {
@@ -630,6 +666,9 @@ static int __driver_attach(struct device *dev, void *data)
 	 * is an error.
 	 */
 
+	if (!device_pre_probe(dev))
+		return 0;
+
 	if (!driver_match_device(drv, dev))
 		return 0;
 
diff --git a/include/linux/device.h b/include/linux/device.h
index 5d7bc6349930..d8be07bc9c3f 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -74,6 +74,9 @@ extern void bus_remove_file(struct bus_type *, struct bus_attribute *);
  *		given device can be handled by the given driver.
  * @uevent:	Called when a device is added, removed, or a few other things
  *		that generate uevents to add the environment variables.
+ * @pre_probe:	Called when a new device or driver is added to this bus, to
+ *		perform any initializations that are needed so the device can
+ *		be matched to a driver.
  * @probe:	Called when a new device or driver add to this bus, and callback
  *		the specific driver's probe to initial the matched device.
  * @remove:	Called when a device removed from this bus.
@@ -113,6 +116,7 @@ struct bus_type {
 
 	int (*match)(struct device *dev, struct device_driver *drv);
 	int (*uevent)(struct device *dev, struct kobj_uevent_env *env);
+	int (*pre_probe)(struct device *dev);
 	int (*probe)(struct device *dev);
 	int (*remove)(struct device *dev);
 	void (*shutdown)(struct device *dev);
-- 
2.4.3
