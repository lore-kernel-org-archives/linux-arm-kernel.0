From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 03 Feb 2012 20:00:37 +0000
Subject: [PATCH 18/20] ARM: sa1111: cleanup sub-device registration and
 unregistration
In-Reply-To: <20120203195419.GH14129@n2100.arm.linux.org.uk>
References: <20120203195419.GH14129@n2100.arm.linux.org.uk>
Message-ID: <E1RtPJF-00044q-Py@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the releasing of resources out of the release function - this
allows a cleaner and more conventional arrangement of the registration
failure paths and a saner unregistration process for these devices.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/common/sa1111.c |   27 ++++++++++++++++-----------
 1 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/arch/arm/common/sa1111.c b/arch/arm/common/sa1111.c
index d78499f..8d86338 100644
--- a/arch/arm/common/sa1111.c
+++ b/arch/arm/common/sa1111.c
@@ -610,7 +610,6 @@ static void sa1111_dev_release(struct device *_dev)
 {
 	struct sa1111_dev *dev = SA1111_DEV(_dev);
 
-	release_resource(&dev->res);
 	kfree(dev);
 }
 
@@ -625,9 +624,10 @@ sa1111_init_one_child(struct sa1111 *sachip, struct resource *parent,
 	dev = kzalloc(sizeof(struct sa1111_dev), GFP_KERNEL);
 	if (!dev) {
 		ret = -ENOMEM;
-		goto out;
+		goto err_alloc;
 	}
 
+	device_initialize(&dev->dev);
 	dev_set_name(&dev->dev, "%4.4lx", info->offset);
 	dev->devid	 = info->devid;
 	dev->dev.parent  = sachip->dev;
@@ -657,17 +657,19 @@ sa1111_init_one_child(struct sa1111 *sachip, struct resource *parent,
 	if (ret) {
 		printk("SA1111: failed to allocate resource for %s\n",
 			dev->res.name);
-		dev_set_name(&dev->dev, NULL);
-		kfree(dev);
-		goto out;
+		goto err_resource;
 	}
 
-	ret = device_register(&dev->dev);
-	if (ret) {
-		release_resource(&dev->res);
-		kfree(dev);
-	}
+	ret = device_add(&dev->dev);
+	if (ret)
+		goto err_add;
+	return 0;
 
+ err_add:
+	release_resource(&dev->res);
+ err_resource:
+	put_device(&dev->dev);
+ err_alloc:
 	return ret;
 }
 
@@ -813,7 +815,10 @@ __sa1111_probe(struct device *me, struct resource *mem, int irq)
 
 static int sa1111_remove_one(struct device *dev, void *data)
 {
-	device_unregister(dev);
+	struct sa1111_dev *sadev = SA1111_DEV(dev);
+	device_del(&sadev->dev);
+	release_resource(&sadev->res);
+	put_device(&sadev->dev);
 	return 0;
 }
 
-- 
1.7.4.4
