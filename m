From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 01 Aug 2013 22:45:04 +0100
Subject: [PATCH RFC 11/51] DMA-API: net: emulex/benet: replace
 dma_set_mask()+dma_set_coherent_mask() with new helper
In-Reply-To: <20130801213420.GL23006@n2100.arm.linux.org.uk>
References: <20130801213420.GL23006@n2100.arm.linux.org.uk>
Message-ID: <E1V50gC-0006qU-Rl@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace the following sequence:

	dma_set_mask(dev, mask);
	dma_set_coherent_mask(dev, mask);

with a call to the new helper dma_set_mask_and_coherent().

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/net/ethernet/emulex/benet/be_main.c |   12 ++----------
 1 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/emulex/benet/be_main.c b/drivers/net/ethernet/emulex/benet/be_main.c
index 181edb5..808d1ac 100644
--- a/drivers/net/ethernet/emulex/benet/be_main.c
+++ b/drivers/net/ethernet/emulex/benet/be_main.c
@@ -4232,19 +4232,11 @@ static int be_probe(struct pci_dev *pdev, const struct pci_device_id *pdev_id)
 	adapter->netdev = netdev;
 	SET_NETDEV_DEV(netdev, &pdev->dev);
 
-	status = dma_set_mask(&pdev->dev, DMA_BIT_MASK(64));
+	status = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
 	if (!status) {
-		status = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(64));
-		if (status < 0) {
-			dev_err(&pdev->dev, "dma_set_coherent_mask failed\n");
-			goto free_netdev;
-		}
 		netdev->features |= NETIF_F_HIGHDMA;
 	} else {
-		status = dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
-		if (!status)
-			status = dma_set_coherent_mask(&pdev->dev,
-						       DMA_BIT_MASK(32));
+		status = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
 		if (status) {
 			dev_err(&pdev->dev, "Could not set PCI DMA Mask\n");
 			goto free_netdev;
-- 
1.7.4.4
