From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 01 Aug 2013 22:52:07 +0100
Subject: [PATCH RFC 18/51] DMA-API: staging: et131x: replace
 dma_set_mask()+dma_set_coherent_mask() with new helper
In-Reply-To: <20130801213420.GL23006@n2100.arm.linux.org.uk>
References: <20130801213420.GL23006@n2100.arm.linux.org.uk>
Message-ID: <E1V50n1-0006rA-FE@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace the following sequence:

	dma_set_mask(dev, mask);
	dma_set_coherent_mask(dev, mask);

with a call to the new helper dma_set_mask_and_coherent().

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/staging/et131x/et131x.c |   17 ++---------------
 1 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/et131x/et131x.c b/drivers/staging/et131x/et131x.c
index f73e58f..98edfa8 100644
--- a/drivers/staging/et131x/et131x.c
+++ b/drivers/staging/et131x/et131x.c
@@ -4797,21 +4797,8 @@ static int et131x_pci_setup(struct pci_dev *pdev,
 	pci_set_master(pdev);
 
 	/* Check the DMA addressing support of this device */
-	if (!dma_set_mask(&pdev->dev, DMA_BIT_MASK(64))) {
-		rc = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(64));
-		if (rc < 0) {
-			dev_err(&pdev->dev,
-			  "Unable to obtain 64 bit DMA for consistent allocations\n");
-			goto err_release_res;
-		}
-	} else if (!dma_set_mask(&pdev->dev, DMA_BIT_MASK(32))) {
-		rc = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
-		if (rc < 0) {
-			dev_err(&pdev->dev,
-			  "Unable to obtain 32 bit DMA for consistent allocations\n");
-			goto err_release_res;
-		}
-	} else {
+	if (dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64)) ||
+	    dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32))) {
 		dev_err(&pdev->dev, "No usable DMA addressing method\n");
 		rc = -EIO;
 		goto err_release_res;
-- 
1.7.4.4
