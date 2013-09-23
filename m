From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 23 Sep 2013 12:37:55 +0100
Subject: [alsa-devel] [PATCH 43/51] DMA-API: dma: edma.c: no need to
 explicitly initialize DMA masks
In-Reply-To: <20130923102533.GI17188@intel.com>
References: <20130919212235.GD12758@n2100.arm.linux.org.uk>
 <E1VMnRj-0007sg-1Z@rmk-PC.arm.linux.org.uk>
 <20130923102533.GI17188@intel.com>
Message-ID: <20130923113755.GT25647@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 23, 2013 at 03:55:33PM +0530, Vinod Koul wrote:
> On Fri, Sep 20, 2013 at 12:15:39AM +0100, Russell King wrote:
> > register_platform_device_full() can setup the DMA mask provided the
> > appropriate member is set in struct platform_device_info.  So lets
> > make that be the case.  This avoids a direct reference to the DMA
> > masks by this driver.
> > 
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> Acked-by: Vinod Koul <vinod.koul@intel.com>
> 
> This also brings me question that should we force the driver to use the
> dma_set_mask_and_coherent() API or they have below flexiblity too?

There's two issues here:
1. dma_set_mask_and_coherent() will only work if dev->dma_mask points at
   some storage for the mask.  This needs to have .dma_mask in the
   platform_device_info initialised.

2. Yes, this driver should also be calling the appropriate DMA mask setting
   functions in addition to having the mask initialized at device creation
   time.

Here's a replacement patch, though maybe it would be better to roll all
the additions of dma_set_mask_and_coherent() in drivers/dma into one
patch?  In other words, combine the addition of this with these two
patches:

	dma: pl330: add dma_set_mask_and_coherent() call
	dma: pl08x: add dma_set_mask_and_coherent() call

8<=====
From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH] DMA-API: dma: edma.c: no need to explicitly initialize DMA
 masks

register_platform_device_full() can setup the DMA mask provided the
appropriate member is set in struct platform_device_info.  So lets
make that be the case.  This avoids a direct reference to the DMA
masks by this driver.

While here, add the dma_set_mask_and_coherent() call which the DMA API
requires DMA-using drivers to call.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/edma.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index ff50ff4..fd5e48c 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -631,6 +631,10 @@ static int edma_probe(struct platform_device *pdev)
 	struct edma_cc *ecc;
 	int ret;
 
+	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
+	if (ret)
+		return ret;
+
 	ecc = devm_kzalloc(&pdev->dev, sizeof(*ecc), GFP_KERNEL);
 	if (!ecc) {
 		dev_err(&pdev->dev, "Can't allocate controller\n");
@@ -702,11 +706,13 @@ static struct platform_device *pdev0, *pdev1;
 static const struct platform_device_info edma_dev_info0 = {
 	.name = "edma-dma-engine",
 	.id = 0,
+	.dma_mask = DMA_BIT_MASK(32),
 };
 
 static const struct platform_device_info edma_dev_info1 = {
 	.name = "edma-dma-engine",
 	.id = 1,
+	.dma_mask = DMA_BIT_MASK(32),
 };
 
 static int edma_init(void)
@@ -720,8 +726,6 @@ static int edma_init(void)
 			ret = PTR_ERR(pdev0);
 			goto out;
 		}
-		pdev0->dev.dma_mask = &pdev0->dev.coherent_dma_mask;
-		pdev0->dev.coherent_dma_mask = DMA_BIT_MASK(32);
 	}
 
 	if (EDMA_CTLRS == 2) {
@@ -731,8 +735,6 @@ static int edma_init(void)
 			platform_device_unregister(pdev0);
 			ret = PTR_ERR(pdev1);
 		}
-		pdev1->dev.dma_mask = &pdev1->dev.coherent_dma_mask;
-		pdev1->dev.coherent_dma_mask = DMA_BIT_MASK(32);
 	}
 
 out:
-- 
1.7.4.4
