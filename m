From: emilgoode@gmail.com (Emil Goode)
Date: Thu, 15 May 2014 21:24:30 +0200
Subject: [PATCH] ARM: imx: clean up error handling
Message-ID: <1400181871-10325-1-git-send-email-emilgoode@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If we fail to allocate struct platform_device pdev we
dereference it after the goto label err.

I have rearranged the error handling a bit to fix the issue
and also make it more clear.

Signed-off-by: Emil Goode <emilgoode@gmail.com>
---
 arch/arm/mach-imx/devices/platform-ipu-core.c |   22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-imx/devices/platform-ipu-core.c b/arch/arm/mach-imx/devices/platform-ipu-core.c
index fc4dd7c..14d61d9 100644
--- a/arch/arm/mach-imx/devices/platform-ipu-core.c
+++ b/arch/arm/mach-imx/devices/platform-ipu-core.c
@@ -77,34 +77,38 @@ struct platform_device *__init imx_alloc_mx3_camera(
 
 	pdev = platform_device_alloc("mx3-camera", 0);
 	if (!pdev)
-		goto err;
+		return ERR_PTR(ret);
 
 	pdev->dev.dma_mask = kmalloc(sizeof(*pdev->dev.dma_mask), GFP_KERNEL);
 	if (!pdev->dev.dma_mask)
-		goto err;
+		goto put_pdev;
 
 	*pdev->dev.dma_mask = DMA_BIT_MASK(32);
 	pdev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
 
 	ret = platform_device_add_resources(pdev, res, ARRAY_SIZE(res));
 	if (ret)
-		goto err;
+		goto free_dma_mask;
 
 	if (pdata) {
 		struct mx3_camera_pdata *copied_pdata;
 
 		ret = platform_device_add_data(pdev, pdata, sizeof(*pdata));
-		if (ret) {
-err:
-			kfree(pdev->dev.dma_mask);
-			platform_device_put(pdev);
-			return ERR_PTR(-ENODEV);
-		}
+		if (ret)
+			goto free_dma_mask;
+
 		copied_pdata = dev_get_platdata(&pdev->dev);
 		copied_pdata->dma_dev = &imx_ipu_coredev->dev;
 	}
 
 	return pdev;
+
+free_dma_mask:
+	kfree(pdev->dev.dma_mask);
+put_pdev:
+	platform_device_put(pdev);
+
+	return ERR_PTR(ret);
 }
 
 struct platform_device *__init imx_add_mx3_sdc_fb(
-- 
1.7.10.4
