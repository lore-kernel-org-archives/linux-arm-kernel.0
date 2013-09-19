From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 19 Sep 2013 22:34:59 +0100
Subject: [PATCH 10/51] DMA-API: net: broadcom/bnx2x: replace
 dma_set_mask()+dma_set_coherent_mask() with new helper
In-Reply-To: <20130919212235.GD12758@n2100.arm.linux.org.uk>
References: <20130919212235.GD12758@n2100.arm.linux.org.uk>
Message-ID: <E1VMlsJ-0007g8-UO@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace the following sequence:

	dma_set_mask(dev, mask);
	dma_set_coherent_mask(dev, mask);

with a call to the new helper dma_set_mask_and_coherent().

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
index 2f8dbbb..e6c3e66 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
@@ -12072,13 +12072,9 @@ static int bnx2x_set_coherency_mask(struct bnx2x *bp)
 {
 	struct device *dev = &bp->pdev->dev;
 
-	if (dma_set_mask(dev, DMA_BIT_MASK(64)) == 0) {
+	if (dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64)) == 0) {
 		bp->flags |= USING_DAC_FLAG;
-		if (dma_set_coherent_mask(dev, DMA_BIT_MASK(64)) != 0) {
-			dev_err(dev, "dma_set_coherent_mask failed, aborting\n");
-			return -EIO;
-		}
-	} else if (dma_set_mask(dev, DMA_BIT_MASK(32)) != 0) {
+	} else if (dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32)) != 0) {
 		dev_err(dev, "System does not support DMA, aborting\n");
 		return -EIO;
 	}
-- 
1.7.4.4
