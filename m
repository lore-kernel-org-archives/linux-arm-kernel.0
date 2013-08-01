From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 01 Aug 2013 22:51:07 +0100
Subject: [PATCH RFC 17/51] DMA-API: block: nvme-core: replace
 dma_set_mask()+dma_set_coherent_mask() with new helper
In-Reply-To: <20130801213420.GL23006@n2100.arm.linux.org.uk>
References: <20130801213420.GL23006@n2100.arm.linux.org.uk>
Message-ID: <E1V50m3-0006r5-12@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace the following sequence:

	dma_set_mask(dev, mask);
	dma_set_coherent_mask(dev, mask);

with a call to the new helper dma_set_mask_and_coherent().

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/block/nvme-core.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index ce79a59..ac38edd 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -1949,11 +1949,8 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	dev->pci_dev = pdev;
 	pci_set_drvdata(pdev, dev);
 
-	if (!dma_set_mask(&pdev->dev, DMA_BIT_MASK(64)))
-		dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(64));
-	else if (!dma_set_mask(&pdev->dev, DMA_BIT_MASK(32)))
-		dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
-	else
+	if (dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64)) &&
+	    dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32)))
 		goto disable;
 
 	result = nvme_set_instance(dev);
-- 
1.7.4.4
