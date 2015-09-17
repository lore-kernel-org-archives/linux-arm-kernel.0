From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Thu, 17 Sep 2015 14:56:56 +0200
Subject: [PATCH v5 02/23] ARM: amba: Move reading of periphid to pre_probe()
In-Reply-To: <1442494637-3674-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1442494637-3674-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1442494637-3674-3-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reading the periphid when the Primecell device is registered means that
the apb pclk must be available by then or the device won't be registered
at all.

By moving this code to pre_probe (to be called by the device-driver core
before the device is matched to a driver) we remove any order
requirements.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

Changes in v5: None
Changes in v4:
- Added bus.pre_probe callback so the probes of Primecell devices can be
  deferred if their device IDs cannot be yet read because of the clock
  driver not having probed when they are registered. Maybe this goes
  overboard and the matching information should be in the DT if there is
  one.

Changes in v3: None
Changes in v2: None

 drivers/amba/bus.c | 78 ++++++++++++++++++++++++++----------------------------
 1 file changed, 38 insertions(+), 40 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index f0099360039e..1cbe43b4acd3 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -24,6 +24,8 @@
 
 #define to_amba_driver(d)	container_of(d, struct amba_driver, drv)
 
+static int amba_pre_probe(struct device *dev);
+
 static const struct amba_id *
 amba_lookup(const struct amba_id *table, struct amba_device *dev)
 {
@@ -193,6 +195,7 @@ struct bus_type amba_bustype = {
 	.name		= "amba",
 	.dev_attrs	= amba_dev_attrs,
 	.match		= amba_match,
+	.pre_probe	= amba_pre_probe,
 	.uevent		= amba_uevent,
 	.pm		= &amba_pm,
 };
@@ -336,44 +339,26 @@ static void amba_device_release(struct device *dev)
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
+static int amba_pre_probe(struct device *dev)
 {
+	struct amba_device *d = to_amba_device(dev);
 	u32 size;
 	void __iomem *tmp;
 	int i, ret;
 
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
+	if (d->periphid != 0)
+		return 0;
 
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
 
@@ -388,37 +373,50 @@ int amba_device_add(struct amba_device *dev, struct resource *parent)
 			cid |= (readl(tmp + size - 0x10 + 4 * i) & 255) <<
 				(i * 8);
 
-		amba_put_disable_pclk(dev);
+		amba_put_disable_pclk(d);
 
 		if (cid == AMBA_CID || cid == CORESIGHT_CID)
-			dev->periphid = pid;
+			d->periphid = pid;
 
-		if (!dev->periphid)
+		if (!d->periphid)
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
