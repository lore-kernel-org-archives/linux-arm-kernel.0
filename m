From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Mon,  7 Sep 2015 14:23:26 +0200
Subject: [PATCH v4 01/22] driver core: Add pre_probe callback to bus_type
In-Reply-To: <1441628627-5143-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1441628627-5143-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1441628627-5143-2-git-send-email-tomeu.vizoso@collabora.com>
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

Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/base/dd.c      | 24 ++++++++++++++++++++++++
 include/linux/device.h |  4 ++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index be0eb4639128..faf60bfc46b3 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -544,6 +544,17 @@ static int __device_attach(struct device *dev, bool allow_async)
 	int ret = 0;
 
 	device_lock(dev);
+
+	if (dev->bus && dev->bus->pre_probe) {
+		ret = dev->bus->pre_probe(dev);
+		if (ret) {
+			if (ret == -EPROBE_DEFER)
+				driver_deferred_probe_add(dev);
+			ret = 0;
+			goto out_unlock;
+		}
+	}
+
 	if (dev->driver) {
 		if (klist_node_attached(&dev->p->knode_driver)) {
 			ret = 1;
@@ -619,6 +630,7 @@ void device_initial_probe(struct device *dev)
 static int __driver_attach(struct device *dev, void *data)
 {
 	struct device_driver *drv = data;
+	int ret;
 
 	/*
 	 * Lock device and try to bind to it. We drop the error
@@ -636,8 +648,20 @@ static int __driver_attach(struct device *dev, void *data)
 	if (dev->parent)	/* Needed for USB */
 		device_lock(dev->parent);
 	device_lock(dev);
+
+	if (dev->bus && dev->bus->pre_probe) {
+		ret = dev->bus->pre_probe(dev);
+		if (ret) {
+			if (ret == -EPROBE_DEFER)
+				driver_deferred_probe_add(dev);
+			goto out;
+		}
+	}
+
 	if (!dev->driver)
 		driver_probe_device(drv, dev);
+
+out:
 	device_unlock(dev);
 	if (dev->parent)
 		device_unlock(dev->parent);
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
