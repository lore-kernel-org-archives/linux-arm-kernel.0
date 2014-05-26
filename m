From: emilgoode@gmail.com (Emil Goode)
Date: Mon, 26 May 2014 18:41:23 +0200
Subject: [PATCH 3/3] ARM: imx: don't allocate memory for .dma_mask of struct
 device
In-Reply-To: <1401122483-31603-1-git-send-email-emilgoode@gmail.com>
References: <1401122483-31603-1-git-send-email-emilgoode@gmail.com>
Message-ID: <1401122483-31603-3-git-send-email-emilgoode@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The first patch in this series changed the platform_device_alloc
function to assign the u64 .dma_mask pointer of struct device to
the address of a u64 .dma_mask member of struct platform_object.

This means that we no longer should allocate memory for the .dma_mask
pointer of struct device when using platform_device_alloc() and the
u64 .dma_mask of struct platform_object that it points to will be freed
when the release callback function platform_device_release is called.

Signed-off-by: Emil Goode <emilgoode@gmail.com>
---
 arch/arm/mach-imx/devices/platform-ipu-core.c |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/mach-imx/devices/platform-ipu-core.c b/arch/arm/mach-imx/devices/platform-ipu-core.c
index 6bd7c3f..4499a7d 100644
--- a/arch/arm/mach-imx/devices/platform-ipu-core.c
+++ b/arch/arm/mach-imx/devices/platform-ipu-core.c
@@ -79,10 +79,6 @@ struct platform_device *__init imx_alloc_mx3_camera(
 	if (!pdev)
 		return ERR_PTR(-ENOMEM);
 
-	pdev->dev.dma_mask = kmalloc(sizeof(*pdev->dev.dma_mask), GFP_KERNEL);
-	if (!pdev->dev.dma_mask)
-		goto err;
-
 	*pdev->dev.dma_mask = DMA_BIT_MASK(32);
 	pdev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
 
@@ -96,7 +92,6 @@ struct platform_device *__init imx_alloc_mx3_camera(
 		ret = platform_device_add_data(pdev, pdata, sizeof(*pdata));
 		if (ret) {
 err:
-			kfree(pdev->dev.dma_mask);
 			platform_device_put(pdev);
 			return ERR_PTR(-ENODEV);
 		}
-- 
1.7.10.4
