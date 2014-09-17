From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 17 Sep 2014 12:56:07 +0100
Subject: [PATCH] of: amba: use of_dma_configure for AMBA devices
Message-ID: <90bd1ff3c93b827c12e1b3dc9ad3f227632d0f6e.1410954967.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 591c1e ("of: configure the platform device dma parameters)
introduced a common mechanism to configure DMA from DT properties.
AMBA devices created from DT can take advantage of this, too.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/of/platform.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 0197725..3b64d0b 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -160,11 +160,10 @@ EXPORT_SYMBOL(of_device_alloc);
  * can use Platform bus notifier and handle BUS_NOTIFY_ADD_DEVICE event
  * to fix up DMA configuration.
  */
-static void of_dma_configure(struct platform_device *pdev)
+static void of_dma_configure(struct device *dev)
 {
 	u64 dma_addr, paddr, size;
 	int ret;
-	struct device *dev = &pdev->dev;
 
 	/*
 	 * Set default dma-mask to 32 bit. Drivers are expected to setup
@@ -229,7 +228,7 @@ static struct platform_device *of_platform_device_create_pdata(
 	if (!dev)
 		goto err_clear_flag;
 
-	of_dma_configure(dev);
+	of_dma_configure(&dev->dev);
 	dev->dev.bus = &platform_bus_type;
 	dev->dev.platform_data = platform_data;
 
@@ -291,7 +290,6 @@ static struct amba_device *of_amba_device_create(struct device_node *node,
 	}
 
 	/* setup generic device info */
-	dev->dev.coherent_dma_mask = ~0;
 	dev->dev.of_node = of_node_get(node);
 	dev->dev.parent = parent;
 	dev->dev.platform_data = platform_data;
@@ -299,6 +297,7 @@ static struct amba_device *of_amba_device_create(struct device_node *node,
 		dev_set_name(&dev->dev, "%s", bus_id);
 	else
 		of_device_make_bus_id(&dev->dev);
+	of_dma_configure(&dev->dev);
 
 	/* Allow the HW Peripheral ID to be overridden */
 	prop = of_get_property(node, "arm,primecell-periphid", NULL);
-- 
1.9.1
