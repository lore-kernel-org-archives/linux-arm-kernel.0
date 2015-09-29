From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Tue, 29 Sep 2015 11:10:40 +0200
Subject: [PATCH v7 02/20] ARM: amba: Move reading of periphid to amba_match()
In-Reply-To: <1443517859-30376-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1443517859-30376-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1443517859-30376-3-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reading the periphid when the Primecell device is registered means that
the apb pclk must be available by then or the device won't be registered
at all.

By reading the periphid in amba_match() we can return -EPROBE_DEFER if
the apb pclk isn't there yet and the device will be retried later.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

Changes in v6:
- Drop bus_type.pre_probe and read the periphid in match() instead as
  suggested by Alan Stern.

Changes in v4:
- Added bus.pre_probe callback so the probes of Primecell devices can be
  deferred if their device IDs cannot be yet read because of the clock
  driver not having probed when they are registered. Maybe this goes
  overboard and the matching information should be in the DT if there is
  one.

 drivers/amba/bus.c | 88 ++++++++++++++++++++++++++++--------------------------
 1 file changed, 46 insertions(+), 42 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index f0099360039e..72ebf9b1c715 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -24,6 +24,8 @@
 
 #define to_amba_driver(d)	container_of(d, struct amba_driver, drv)
 
+static int read_periphid(struct amba_device *d, unsigned int *periphid);
+
 static const struct amba_id *
 amba_lookup(const struct amba_id *table, struct amba_device *dev)
 {
@@ -43,11 +45,22 @@ static int amba_match(struct device *dev, struct device_driver *drv)
 {
 	struct amba_device *pcdev = to_amba_device(dev);
 	struct amba_driver *pcdrv = to_amba_driver(drv);
+	int ret;
 
 	/* When driver_override is set, only bind to the matching driver */
 	if (pcdev->driver_override)
 		return !strcmp(pcdev->driver_override, drv->name);
 
+	if (!pcdev->periphid) {
+		ret = read_periphid(pcdev, &pcdev->periphid);
+		if (ret) {
+			if (ret != -EPROBE_DEFER)
+				dev_err(dev, "Failed to read periphid: %d",
+					ret);
+			return ret;
+		}
+	}
+
 	return amba_lookup(pcdrv->id_table, pcdev) != NULL;
 }
 
@@ -336,44 +349,22 @@ static void amba_device_release(struct device *dev)
 	kfree(d);
 }
 
-/**
- *	amba_device_add - add a previously allocated AMBA device structure
- *	@dev: AMBA device allocated by amba_device_alloc
- *	@parent: resource parent for this devices resources
- *
- *	Claim the resource, and read the device cell ID if not already
- *	initialized.  Register the AMBA device with the Linux device
- *	manager.
- */
-int amba_device_add(struct amba_device *dev, struct resource *parent)
+static int read_periphid(struct amba_device *d, unsigned int *periphid)
 {
 	u32 size;
 	void __iomem *tmp;
-	int i, ret;
-
-	WARN_ON(dev->irq[0] == (unsigned int)-1);
-	WARN_ON(dev->irq[1] == (unsigned int)-1);
-
-	ret = request_resource(parent, &dev->res);
-	if (ret)
-		goto err_out;
-
-	/* Hard-coded primecell ID instead of plug-n-play */
-	if (dev->periphid != 0)
-		goto skip_probe;
+	int i, ret = 0;
 
 	/*
 	 * Dynamically calculate the size of the resource
 	 * and use this for iomap
 	 */
-	size = resource_size(&dev->res);
-	tmp = ioremap(dev->res.start, size);
-	if (!tmp) {
-		ret = -ENOMEM;
-		goto err_release;
-	}
+	size = resource_size(&d->res);
+	tmp = ioremap(d->res.start, size);
+	if (!tmp)
+		return -ENOMEM;
 
-	ret = amba_get_enable_pclk(dev);
+	ret = amba_get_enable_pclk(d);
 	if (ret == 0) {
 		u32 pid, cid;
 
@@ -388,37 +379,50 @@ int amba_device_add(struct amba_device *dev, struct resource *parent)
 			cid |= (readl(tmp + size - 0x10 + 4 * i) & 255) <<
 				(i * 8);
 
-		amba_put_disable_pclk(dev);
+		amba_put_disable_pclk(d);
 
 		if (cid == AMBA_CID || cid == CORESIGHT_CID)
-			dev->periphid = pid;
+			*periphid = pid;
 
-		if (!dev->periphid)
+		if (!*periphid)
 			ret = -ENODEV;
 	}
 
 	iounmap(tmp);
 
+	return ret;
+}
+
+/**
+ *	amba_device_add - add a previously allocated AMBA device structure
+ *	@dev: AMBA device allocated by amba_device_alloc
+ *	@parent: resource parent for this devices resources
+ *
+ *	Claim the resource, and register the AMBA device with the Linux device
+ *	manager.
+ */
+int amba_device_add(struct amba_device *dev, struct resource *parent)
+{
+	int ret;
+
+	WARN_ON(dev->irq[0] == (unsigned int)-1);
+	WARN_ON(dev->irq[1] == (unsigned int)-1);
+
+	ret = request_resource(parent, &dev->res);
 	if (ret)
-		goto err_release;
+		return ret;
 
- skip_probe:
 	ret = device_add(&dev->dev);
 	if (ret)
-		goto err_release;
+		return ret;
 
 	if (dev->irq[0])
 		ret = device_create_file(&dev->dev, &dev_attr_irq0);
 	if (ret == 0 && dev->irq[1])
 		ret = device_create_file(&dev->dev, &dev_attr_irq1);
-	if (ret == 0)
-		return ret;
-
-	device_unregister(&dev->dev);
+	if (ret)
+		device_unregister(&dev->dev);
 
- err_release:
-	release_resource(&dev->res);
- err_out:
 	return ret;
 }
 EXPORT_SYMBOL_GPL(amba_device_add);
-- 
2.4.3
