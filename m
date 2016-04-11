From: georgi.djakov@linaro.org (Georgi Djakov)
Date: Mon, 11 Apr 2016 17:58:35 +0300
Subject: [PATCH v1 1/2] amba: Defer device peripheral ID read
Message-ID: <1460386716-23262-1-git-send-email-georgi.djakov@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Ivan T. Ivanov" <ivan.ivanov@linaro.org>

To be able to read peripheral ID during device create time
bus code have turn on device interface clock, but this
clock could be unavailable at this time. Fix this by defer
device ID read until driver match time.

Signed-off-by: Ivan T. Ivanov <ivan.ivanov@linaro.org>
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/amba/bus.c |  138 ++++++++++++++++++++++++++--------------------------
 1 file changed, 69 insertions(+), 69 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index f0099360039e..a32a43dbaccc 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -24,11 +24,79 @@
 
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
+static int amba_read_periphid(struct amba_device *adev)
+{
+	resource_size_t size;
+	void __iomem *tmp;
+	int r, i;
+
+	if (adev->periphid)
+		return 0;
+
+	/*
+	 * Dynamically calculate the size of the resource
+	 * and use this for iomap
+	 */
+	size = resource_size(&adev->res);
+	tmp = ioremap(adev->res.start, size);
+	if (!tmp)
+		return -ENODEV;
+
+	r = amba_get_enable_pclk(adev);
+	if (r == 0) {
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
+		amba_put_disable_pclk(adev);
+
+		if (cid == AMBA_CID || cid == CORESIGHT_CID)
+			adev->periphid = pid;
+	}
+
+	iounmap(tmp);
+
+	return adev->periphid ? 0 : -ENODEV;
+}
+
 static const struct amba_id *
 amba_lookup(const struct amba_id *table, struct amba_device *dev)
 {
 	int ret = 0;
 
+	if (amba_read_periphid(dev))
+		return NULL;
+
 	while (table->mask) {
 		ret = (dev->periphid & table->mask) == table->id;
 		if (ret)
@@ -204,27 +272,6 @@ static int __init amba_init(void)
 
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
@@ -347,9 +394,7 @@ static void amba_device_release(struct device *dev)
  */
 int amba_device_add(struct amba_device *dev, struct resource *parent)
 {
-	u32 size;
-	void __iomem *tmp;
-	int i, ret;
+	int ret;
 
 	WARN_ON(dev->irq[0] == (unsigned int)-1);
 	WARN_ON(dev->irq[1] == (unsigned int)-1);
@@ -358,51 +403,6 @@ int amba_device_add(struct amba_device *dev, struct resource *parent)
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
