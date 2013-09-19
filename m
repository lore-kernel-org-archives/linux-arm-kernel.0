From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 19 Sep 2013 22:42:00 +0100
Subject: [PATCH 17/51] DMA-API: block: nvme-core: replace
 dma_set_mask()+dma_set_coherent_mask() with new helper
In-Reply-To: <20130919212235.GD12758@n2100.arm.linux.org.uk>
References: <20130919212235.GD12758@n2100.arm.linux.org.uk>
Message-ID: <E1VMlz6-0007h9-WF@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace the following sequence:

	dma_set_mask(dev, mask);
	dma_set_coherent_mask(dev, mask);

with a call to the new helper dma_set_mask_and_coherent().

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/block/nvme-core.c |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index da52092..26d03fa 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -1949,12 +1949,9 @@ static int nvme_dev_map(struct nvme_dev *dev)
 	if (pci_request_selected_regions(pdev, bars, "nvme"))
 		goto disable_pci;
 
-	if (!dma_set_mask(&pdev->dev, DMA_BIT_MASK(64)))
-		dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(64));
-	else if (!dma_set_mask(&pdev->dev, DMA_BIT_MASK(32)))
-		dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
-	else
-		goto disable_pci;
+	if (dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64)) &&
+	    dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32)))
+		goto disable;
 
 	pci_set_drvdata(pdev, dev);
 	dev->bar = ioremap(pci_resource_start(pdev, 0), 8192);
@@ -2168,6 +2165,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	INIT_LIST_HEAD(&dev->namespaces);
 	dev->pci_dev = pdev;
+
 	result = nvme_set_instance(dev);
 	if (result)
 		goto free;
-- 
1.7.4.4
