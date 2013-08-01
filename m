From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 01 Aug 2013 22:47:05 +0100
Subject: [PATCH RFC 13/51] DMA-API: net: sfc/efx.c: replace
 dma_set_mask()+dma_set_coherent_mask() with new helper
In-Reply-To: <20130801213420.GL23006@n2100.arm.linux.org.uk>
References: <20130801213420.GL23006@n2100.arm.linux.org.uk>
Message-ID: <E1V50i9-0006qf-Ed@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace the following sequence:

	dma_set_mask(dev, mask);
	dma_set_coherent_mask(dev, mask);

with a call to the new helper dma_set_mask_and_coherent().

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/net/ethernet/sfc/efx.c |   12 +-----------
 1 files changed, 1 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/sfc/efx.c b/drivers/net/ethernet/sfc/efx.c
index c729688..37c3f7e 100644
--- a/drivers/net/ethernet/sfc/efx.c
+++ b/drivers/net/ethernet/sfc/efx.c
@@ -1164,7 +1164,7 @@ static int efx_init_io(struct efx_nic *efx)
 	 */
 	while (dma_mask > 0x7fffffffUL) {
 		if (dma_supported(&pci_dev->dev, dma_mask)) {
-			rc = dma_set_mask(&pci_dev->dev, dma_mask);
+			rc = dma_set_mask_and_coherent(&pci_dev->dev, dma_mask);
 			if (rc == 0)
 				break;
 		}
@@ -1177,16 +1177,6 @@ static int efx_init_io(struct efx_nic *efx)
 	}
 	netif_dbg(efx, probe, efx->net_dev,
 		  "using DMA mask %llx\n", (unsigned long long) dma_mask);
-	rc = dma_set_coherent_mask(&pci_dev->dev, dma_mask);
-	if (rc) {
-		/* dma_set_coherent_mask() is not *allowed* to
-		 * fail with a mask that dma_set_mask() accepted,
-		 * but just in case...
-		 */
-		netif_err(efx, probe, efx->net_dev,
-			  "failed to set consistent DMA mask\n");
-		goto fail2;
-	}
 
 	efx->membase_phys = pci_resource_start(efx->pci_dev, EFX_MEM_BAR);
 	rc = pci_request_region(pci_dev, EFX_MEM_BAR, "sfc");
-- 
1.7.4.4
