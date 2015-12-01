From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 01 Dec 2015 14:34:25 +0100
Subject: [PATCH v3 2/3] ARM: amba: Move reading of periphid to amba_match()
In-Reply-To: <1448976866-7892-1-git-send-email-m.szyprowski@samsung.com>
References: <1448976866-7892-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1448976866-7892-3-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tomeu Vizoso <tomeu.vizoso@collabora.com>

Reading the periphid when the Primecell device is registered means that
the apb pclk must be available by then or the device won't be registered
at all.

By reading the periphid in amba_match() we can return -EPROBE_DEFER if
the apb pclk isn't there yet and the device will be retried later.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
[minor code adjustments, added missing comment]
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/amba/bus.c | 77 +++++++++++++++++++++++++++++-------------------------
 1 file changed, 41 insertions(+), 36 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index f009936..879a421 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -24,6 +24,8 @@
 
 #define to_amba_driver(d)	container_of(d, struct amba_driver, drv)
 
+static int amba_read_periphid(struct amba_device *dev);
+
 static const struct amba_id *
 amba_lookup(const struct amba_id *table, struct amba_device *dev)
 {
@@ -43,11 +45,23 @@ static int amba_match(struct device *dev, struct device_driver *drv)
 {
 	struct amba_device *pcdev = to_amba_device(dev);
 	struct amba_driver *pcdrv = to_amba_driver(drv);
+	int ret;
 
 	/* When driver_override is set, only bind to the matching driver */
 	if (pcdev->driver_override)
 		return !strcmp(pcdev->driver_override, drv->name);
 
+	/* Do plug-n-play if no hard-coded primecell ID has been provided */
+	if (!pcdev->periphid) {
+		ret = amba_read_periphid(pcdev);
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
 
@@ -336,31 +350,11 @@ static void amba_device_release(struct device *dev)
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
+static int amba_read_periphid(struct amba_device *dev)
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
@@ -368,10 +362,8 @@ int amba_device_add(struct amba_device *dev, struct resource *parent)
 	 */
 	size = resource_size(&dev->res);
 	tmp = ioremap(dev->res.start, size);
-	if (!tmp) {
-		ret = -ENOMEM;
-		goto err_release;
-	}
+	if (!tmp)
+		return -ENOMEM;
 
 	ret = amba_get_enable_pclk(dev);
 	if (ret == 0) {
@@ -399,26 +391,39 @@ int amba_device_add(struct amba_device *dev, struct resource *parent)
 
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
1.9.2
