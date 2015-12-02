From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 02 Dec 2015 08:21:42 +0100
Subject: [PATCH v4 2/3] ARM: amba: Move reading of periphid to amba_match()
In-Reply-To: <1449040903-26674-1-git-send-email-m.szyprowski@samsung.com>
References: <1449040903-26674-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1449040903-26674-3-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tomeu Vizoso <tomeu.vizoso@collabora.com>

Reading the periphid when the Primecell device is registered means that
the apb pclk must be available by then or the device won't be registered
at all.

By reading the periphid in amba_match() we can return -EPROBE_DEFER if
the apb pclk isn't there yet and the device will be retried later.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
[minor code adjustments, removed forward declaration, added missing
comment]
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/amba/bus.c | 146 +++++++++++++++++++++++++++--------------------------
 1 file changed, 75 insertions(+), 71 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index f009936..643127f 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -24,6 +24,71 @@
 
 #define to_amba_driver(d)	container_of(d, struct amba_driver, drv)
 
+static int amba_get_enable_pclk(struct amba_device *pcdev)
+{
+	int ret;
+
+	pcdev->pclk = clk_get(&pcdev->dev, "apb_pclk");
+	if (IS_ERR(pcdev->pclk))
+		return PTR_ERR(pcdev->pclk);
+
+	ret = clk_prepare_enable(pcdev->pclk);
+	if (ret)
+		clk_put(pcdev->pclk);
+
+	return ret;
+}
+
+static void amba_put_disable_pclk(struct amba_device *pcdev)
+{
+	clk_disable_unprepare(pcdev->pclk);
+	clk_put(pcdev->pclk);
+}
+
+static int amba_read_periphid(struct amba_device *dev)
+{
+	u32 size;
+	void __iomem *tmp;
+	int i, ret = 0;
+
+	/*
+	 * Dynamically calculate the size of the resource
+	 * and use this for iomap
+	 */
+	size = resource_size(&dev->res);
+	tmp = ioremap(dev->res.start, size);
+	if (!tmp)
+		return -ENOMEM;
+
+	ret = amba_get_enable_pclk(dev);
+	if (ret == 0) {
+		u32 pid, cid;
+
+		/*
+		 * Read pid and cid based on size of resource
+		 * they are located at end of region
+		 */
+		for (pid = 0, i = 0; i < 4; i++)
+			pid |= (readl(tmp + size - 0x20 + 4 * i) & 255) <<
+				(i * 8);
+		for (cid = 0, i = 0; i < 4; i++)
+			cid |= (readl(tmp + size - 0x10 + 4 * i) & 255) <<
+				(i * 8);
+
+		amba_put_disable_pclk(dev);
+
+		if (cid == AMBA_CID || cid == CORESIGHT_CID)
+			dev->periphid = pid;
+
+		if (!dev->periphid)
+			ret = -ENODEV;
+	}
+
+	iounmap(tmp);
+
+	return ret;
+}
+
 static const struct amba_id *
 amba_lookup(const struct amba_id *table, struct amba_device *dev)
 {
@@ -43,11 +108,19 @@ static int amba_match(struct device *dev, struct device_driver *drv)
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
+		if (ret)
+			return ret;
+	}
+
 	return amba_lookup(pcdrv->id_table, pcdev) != NULL;
 }
 
@@ -204,27 +277,6 @@ static int __init amba_init(void)
 
 postcore_initcall(amba_init);
 
-static int amba_get_enable_pclk(struct amba_device *pcdev)
-{
-	int ret;
-
-	pcdev->pclk = clk_get(&pcdev->dev, "apb_pclk");
-	if (IS_ERR(pcdev->pclk))
-		return PTR_ERR(pcdev->pclk);
-
-	ret = clk_prepare_enable(pcdev->pclk);
-	if (ret)
-		clk_put(pcdev->pclk);
-
-	return ret;
-}
-
-static void amba_put_disable_pclk(struct amba_device *pcdev)
-{
-	clk_disable_unprepare(pcdev->pclk);
-	clk_put(pcdev->pclk);
-}
-
 /*
  * These are the device model conversion veneers; they convert the
  * device model structures to our more specific structures.
@@ -341,15 +393,12 @@ static void amba_device_release(struct device *dev)
  *	@dev: AMBA device allocated by amba_device_alloc
  *	@parent: resource parent for this devices resources
  *
- *	Claim the resource, and read the device cell ID if not already
- *	initialized.  Register the AMBA device with the Linux device
+ *	Claim the resource, and register the AMBA device with the Linux device
  *	manager.
  */
 int amba_device_add(struct amba_device *dev, struct resource *parent)
 {
-	u32 size;
-	void __iomem *tmp;
-	int i, ret;
+	int ret;
 
 	WARN_ON(dev->irq[0] == (unsigned int)-1);
 	WARN_ON(dev->irq[1] == (unsigned int)-1);
@@ -358,51 +407,6 @@ int amba_device_add(struct amba_device *dev, struct resource *parent)
 	if (ret)
 		goto err_out;
 
-	/* Hard-coded primecell ID instead of plug-n-play */
-	if (dev->periphid != 0)
-		goto skip_probe;
-
-	/*
-	 * Dynamically calculate the size of the resource
-	 * and use this for iomap
-	 */
-	size = resource_size(&dev->res);
-	tmp = ioremap(dev->res.start, size);
-	if (!tmp) {
-		ret = -ENOMEM;
-		goto err_release;
-	}
-
-	ret = amba_get_enable_pclk(dev);
-	if (ret == 0) {
-		u32 pid, cid;
-
-		/*
-		 * Read pid and cid based on size of resource
-		 * they are located at end of region
-		 */
-		for (pid = 0, i = 0; i < 4; i++)
-			pid |= (readl(tmp + size - 0x20 + 4 * i) & 255) <<
-				(i * 8);
-		for (cid = 0, i = 0; i < 4; i++)
-			cid |= (readl(tmp + size - 0x10 + 4 * i) & 255) <<
-				(i * 8);
-
-		amba_put_disable_pclk(dev);
-
-		if (cid == AMBA_CID || cid == CORESIGHT_CID)
-			dev->periphid = pid;
-
-		if (!dev->periphid)
-			ret = -ENODEV;
-	}
-
-	iounmap(tmp);
-
-	if (ret)
-		goto err_release;
-
- skip_probe:
 	ret = device_add(&dev->dev);
 	if (ret)
 		goto err_release;
-- 
1.9.2
