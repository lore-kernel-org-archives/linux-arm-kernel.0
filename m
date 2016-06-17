From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 17 Jun 2016 08:26:51 +0200
Subject: [PATCH v2 01/10] driver core: Add a wrapper around
 __device_release_driver()
In-Reply-To: <1466144820-6286-1-git-send-email-m.szyprowski@samsung.com>
References: <1466144820-6286-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1466144820-6286-2-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Add an internal wrapper around __device_release_driver() that will
acquire device locks and do the necessary checks before calling it.

The next patch will make use of it.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/base/dd.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 16688f50729c..d9e76e9205c7 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -796,6 +796,22 @@ static void __device_release_driver(struct device *dev)
 	}
 }
 
+static void device_release_driver_internal(struct device *dev,
+					   struct device_driver *drv,
+					   struct device *parent)
+{
+	if (parent)
+		device_lock(parent);
+
+	device_lock(dev);
+	if (!drv || drv == dev->driver)
+		__device_release_driver(dev);
+
+	device_unlock(dev);
+	if (parent)
+		device_unlock(parent);
+}
+
 /**
  * device_release_driver - manually detach device from driver.
  * @dev: device.
@@ -810,9 +826,7 @@ void device_release_driver(struct device *dev)
 	 * within their ->remove callback for the same device, they
 	 * will deadlock right here.
 	 */
-	device_lock(dev);
-	__device_release_driver(dev);
-	device_unlock(dev);
+	device_release_driver_internal(dev, NULL, NULL);
 }
 EXPORT_SYMBOL_GPL(device_release_driver);
 
@@ -837,15 +851,7 @@ void driver_detach(struct device_driver *drv)
 		dev = dev_prv->device;
 		get_device(dev);
 		spin_unlock(&drv->p->klist_devices.k_lock);
-
-		if (dev->parent)	/* Needed for USB */
-			device_lock(dev->parent);
-		device_lock(dev);
-		if (dev->driver == drv)
-			__device_release_driver(dev);
-		device_unlock(dev);
-		if (dev->parent)
-			device_unlock(dev->parent);
+		device_release_driver_internal(dev, drv, dev->parent);
 		put_device(dev);
 	}
 }
-- 
1.9.1
