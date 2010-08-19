From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Thu, 19 Aug 2010 16:40:30 +0200 (CEST)
Subject: [PATCH 5/5] SH: use dma_preallocate_coherent_memory() for platform
	device memory
In-Reply-To: <Pine.LNX.4.64.1008191623580.26145@axis700.grange>
References: <Pine.LNX.4.64.1008191623580.26145@axis700.grange>
Message-ID: <Pine.LNX.4.64.1008191637490.26145@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

platform_resource_setup_memory() is used on SuperH to allocate large chunks
of memory at system initialisation time for platform devices. Many of those
devices are then handled by the UIO subsystem, and only one of them - the CEU
has an in-kernel driver. This patch switches platform_resource_setup_memory()
to use dma_preallocate_coherent_memory() and removes now unneeded call to
dma_declare_coherent_memory() from the CEU driver.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/sh/mm/consistent.c                    |   19 +++++++++----------
 drivers/media/video/sh_mobile_ceu_camera.c |   19 +------------------
 2 files changed, 10 insertions(+), 28 deletions(-)

diff --git a/arch/sh/mm/consistent.c b/arch/sh/mm/consistent.c
index c86a085..c617b99 100644
--- a/arch/sh/mm/consistent.c
+++ b/arch/sh/mm/consistent.c
@@ -127,8 +127,7 @@ int __init platform_resource_setup_memory(struct platform_device *pdev,
 					  char *name, unsigned long memsize)
 {
 	struct resource *r;
-	dma_addr_t dma_handle;
-	void *buf;
+	int ret;
 
 	r = pdev->resource + pdev->num_resources - 1;
 	if (r->flags) {
@@ -141,17 +140,17 @@ int __init platform_resource_setup_memory(struct platform_device *pdev,
 	if (!memsize)
 		return 0;
 
-	buf = dma_alloc_coherent(NULL, memsize, &dma_handle, GFP_KERNEL);
-	if (!buf) {
-		pr_warning("%s: unable to allocate memory\n", name);
-		return -ENOMEM;
+	ret = dma_preallocate_coherent_memory(&pdev->dev, memsize, GFP_KERNEL,
+					      DMA_MEMORY_MAP | DMA_MEMORY_EXCLUSIVE);
+	if (ret < 0) {
+		pr_warning("%s: unable to allocate memory: %d\n", name, ret);
+		return ret;
 	}
 
-	memset(buf, 0, memsize);
-
 	r->flags = IORESOURCE_MEM;
-	r->start = dma_handle;
-	r->end = r->start + memsize - 1;
+	/* Only the size is needed */
+	r->start = 0;
+	r->end = memsize - 1;
 	r->name = name;
 	return 0;
 }
diff --git a/drivers/media/video/sh_mobile_ceu_camera.c b/drivers/media/video/sh_mobile_ceu_camera.c
index bfddad8..325671e 100644
--- a/drivers/media/video/sh_mobile_ceu_camera.c
+++ b/drivers/media/video/sh_mobile_ceu_camera.c
@@ -1951,20 +1951,8 @@ static int __devinit sh_mobile_ceu_probe(struct platform_device *pdev)
 	pcdev->video_limit = 0; /* only enabled if second resource exists */
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	if (res) {
-		err = dma_declare_coherent_memory(&pdev->dev, res->start,
-						  res->start,
-						  resource_size(res),
-						  DMA_MEMORY_MAP |
-						  DMA_MEMORY_EXCLUSIVE);
-		if (!err) {
-			dev_err(&pdev->dev, "Unable to declare CEU memory.\n");
-			err = -ENXIO;
-			goto exit_iounmap;
-		}
-
+	if (res)
 		pcdev->video_limit = resource_size(res);
-	}
 
 	/* request irq */
 	err = request_irq(pcdev->irq, sh_mobile_ceu_irq, IRQF_DISABLED,
@@ -2036,9 +2024,6 @@ exit_free_clk:
 	pm_runtime_disable(&pdev->dev);
 	free_irq(pcdev->irq, pcdev);
 exit_release_mem:
-	if (platform_get_resource(pdev, IORESOURCE_MEM, 1))
-		dma_release_declared_memory(&pdev->dev);
-exit_iounmap:
 	iounmap(base);
 exit_kfree:
 	kfree(pcdev);
@@ -2056,8 +2041,6 @@ static int __devexit sh_mobile_ceu_remove(struct platform_device *pdev)
 	soc_camera_host_unregister(soc_host);
 	pm_runtime_disable(&pdev->dev);
 	free_irq(pcdev->irq, pcdev);
-	if (platform_get_resource(pdev, IORESOURCE_MEM, 1))
-		dma_release_declared_memory(&pdev->dev);
 	iounmap(pcdev->base);
 	if (csi2 && csi2->driver)
 		module_put(csi2->driver->owner);
-- 
1.7.2
