From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 20 Sep 2013 00:16:39 +0100
Subject: [PATCH 44/51] DMA-API: dcdbas: update DMA mask handing
In-Reply-To: <20130919212235.GD12758@n2100.arm.linux.org.uk>
References: <20130919212235.GD12758@n2100.arm.linux.org.uk>
Message-ID: <E1VMnSh-0007sm-5t@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dcdbas was explicitly initializing DMA masks thusly:
	dcdbas_pdev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
	dcdbas_pdev->dev.dma_mask = &dcdbas_pdev->dev.coherent_dma_mask;
which bypasses the architecture check.  Moreover, it is creating the
dcdbas_pdev device itself, and using the platform_device_register_full()
avoids some of this explicit initialization.

Convert the driver to use platform_device_register_full(), and as it
makes use of coherent DMA, also call dma_set_coherent_mask() to ensure
that the architecture gets to check the mask.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/firmware/dcdbas.c |   23 ++++++++++++-----------
 1 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/firmware/dcdbas.c b/drivers/firmware/dcdbas.c
index ff080ee..a85fda2 100644
--- a/drivers/firmware/dcdbas.c
+++ b/drivers/firmware/dcdbas.c
@@ -549,8 +549,9 @@ static int dcdbas_probe(struct platform_device *dev)
 	 * BIOS SMI calls require buffer addresses be in 32-bit address space.
 	 * This is done by setting the DMA mask below.
 	 */
-	dcdbas_pdev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
-	dcdbas_pdev->dev.dma_mask = &dcdbas_pdev->dev.coherent_dma_mask;
+	error = dma_set_coherent_mask(&dcdbas_pdev->dev, DMA_BIT_MASK(32));
+	if (error)
+		return error;
 
 	error = sysfs_create_group(&dev->dev.kobj, &dcdbas_attr_group);
 	if (error)
@@ -581,6 +582,12 @@ static struct platform_driver dcdbas_driver = {
 	.remove		= dcdbas_remove,
 };
 
+static const struct platform_device_info dcdbas_dev_info __initdata = {
+	.name		= DRIVER_NAME,
+	.id		= -1,
+	.dma_mask	= DMA_BIT_MASK(32),
+};
+
 /**
  * dcdbas_init: initialize driver
  */
@@ -592,20 +599,14 @@ static int __init dcdbas_init(void)
 	if (error)
 		return error;
 
-	dcdbas_pdev = platform_device_alloc(DRIVER_NAME, -1);
-	if (!dcdbas_pdev) {
-		error = -ENOMEM;
+	dcdbas_pdev = platform_device_register_full(&dcdbas_dev_info);
+	if (IS_ERR(dcdbas_pdev)) {
+		error = PTR_ERR(dcdbas_pdev);
 		goto err_unregister_driver;
 	}
 
-	error = platform_device_add(dcdbas_pdev);
-	if (error)
-		goto err_free_device;
-
 	return 0;
 
- err_free_device:
-	platform_device_put(dcdbas_pdev);
  err_unregister_driver:
 	platform_driver_unregister(&dcdbas_driver);
 	return error;
-- 
1.7.4.4
