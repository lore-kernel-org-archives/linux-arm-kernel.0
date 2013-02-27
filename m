From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 27 Feb 2013 23:25:38 +0800
Subject: [PATCH 02/12] dma: mxs-dma: use devm_* managed functions
In-Reply-To: <1361978748-25281-1-git-send-email-shawn.guo@linaro.org>
References: <1361978748-25281-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1361978748-25281-3-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm_* managed functions to simplify probe() error handling.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/dma/mxs-dma.c |   39 +++++++++------------------------------
 1 file changed, 9 insertions(+), 30 deletions(-)

diff --git a/drivers/dma/mxs-dma.c b/drivers/dma/mxs-dma.c
index 8f6d30d..bb86f7f 100644
--- a/drivers/dma/mxs-dma.c
+++ b/drivers/dma/mxs-dma.c
@@ -674,7 +674,7 @@ static int __init mxs_dma_probe(struct platform_device *pdev)
 	struct resource *iores;
 	int ret, i;
 
-	mxs_dma = kzalloc(sizeof(*mxs_dma), GFP_KERNEL);
+	mxs_dma = devm_kzalloc(&pdev->dev, sizeof(*mxs_dma), GFP_KERNEL);
 	if (!mxs_dma)
 		return -ENOMEM;
 
@@ -689,24 +689,13 @@ static int __init mxs_dma_probe(struct platform_device *pdev)
 	mxs_dma->dev_id = dma_type->id;
 
 	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	mxs_dma->base = devm_ioremap_resource(&pdev->dev, iores);
+	if (IS_ERR(mxs_dma->base))
+		return PTR_ERR(mxs_dma->base);
 
-	if (!request_mem_region(iores->start, resource_size(iores),
-				pdev->name)) {
-		ret = -EBUSY;
-		goto err_request_region;
-	}
-
-	mxs_dma->base = ioremap(iores->start, resource_size(iores));
-	if (!mxs_dma->base) {
-		ret = -ENOMEM;
-		goto err_ioremap;
-	}
-
-	mxs_dma->clk = clk_get(&pdev->dev, NULL);
-	if (IS_ERR(mxs_dma->clk)) {
-		ret = PTR_ERR(mxs_dma->clk);
-		goto err_clk;
-	}
+	mxs_dma->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(mxs_dma->clk))
+		return PTR_ERR(mxs_dma->clk);
 
 	dma_cap_set(DMA_SLAVE, mxs_dma->dma_device.cap_mask);
 	dma_cap_set(DMA_CYCLIC, mxs_dma->dma_device.cap_mask);
@@ -732,7 +721,7 @@ static int __init mxs_dma_probe(struct platform_device *pdev)
 
 	ret = mxs_dma_init(mxs_dma);
 	if (ret)
-		goto err_init;
+		return ret;
 
 	mxs_dma->dma_device.dev = &pdev->dev;
 
@@ -751,22 +740,12 @@ static int __init mxs_dma_probe(struct platform_device *pdev)
 	ret = dma_async_device_register(&mxs_dma->dma_device);
 	if (ret) {
 		dev_err(mxs_dma->dma_device.dev, "unable to register\n");
-		goto err_init;
+		return ret;
 	}
 
 	dev_info(mxs_dma->dma_device.dev, "initialized\n");
 
 	return 0;
-
-err_init:
-	clk_put(mxs_dma->clk);
-err_clk:
-	iounmap(mxs_dma->base);
-err_ioremap:
-	release_mem_region(iores->start, resource_size(iores));
-err_request_region:
-	kfree(mxs_dma);
-	return ret;
 }
 
 static struct platform_driver mxs_dma_driver = {
-- 
1.7.9.5
