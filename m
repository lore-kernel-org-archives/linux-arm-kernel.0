From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 01 Aug 2013 22:40:03 +0100
Subject: [PATCH RFC 06/51] DMA-API: net: intel/ixgb: fix 32-bit DMA mask
 handling
In-Reply-To: <20130801213420.GL23006@n2100.arm.linux.org.uk>
References: <20130801213420.GL23006@n2100.arm.linux.org.uk>
Message-ID: <E1V50bL-0006pv-HU@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The fallback to 32-bit DMA mask is rather odd:
	err = dma_set_mask(&pdev->dev, DMA_BIT_MASK(64));
	if (!err) {
		err = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(64));
		if (!err)
			pci_using_dac = 1;
	} else {
		err = dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
		if (err) {
			err = dma_set_coherent_mask(&pdev->dev,
						    DMA_BIT_MASK(32));
			if (err) {
				pr_err("No usable DMA configuration, aborting\n");
				goto err_dma_mask;
			}
		}
	}
This means we only set the coherent DMA mask in the fallback path if
the DMA mask set failed, which is silly.  This fixes it to set the
coherent DMA mask only if dma_set_mask() succeeded, and to error out
if either fails.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/net/ethernet/intel/ixgb/ixgb_main.c |   16 +++++-----------
 1 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgb/ixgb_main.c b/drivers/net/ethernet/intel/ixgb/ixgb_main.c
index fce3e92..cf7358c 100644
--- a/drivers/net/ethernet/intel/ixgb/ixgb_main.c
+++ b/drivers/net/ethernet/intel/ixgb/ixgb_main.c
@@ -408,20 +408,14 @@ ixgb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		return err;
 
 	pci_using_dac = 0;
-	err = dma_set_mask(&pdev->dev, DMA_BIT_MASK(64));
+	err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
 	if (!err) {
-		err = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(64));
-		if (!err)
-			pci_using_dac = 1;
+		pci_using_dac = 1;
 	} else {
-		err = dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
+		err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
 		if (err) {
-			err = dma_set_coherent_mask(&pdev->dev,
-						    DMA_BIT_MASK(32));
-			if (err) {
-				pr_err("No usable DMA configuration, aborting\n");
-				goto err_dma_mask;
-			}
+			pr_err("No usable DMA configuration, aborting\n");
+			goto err_dma_mask;
 		}
 	}
 
-- 
1.7.4.4
