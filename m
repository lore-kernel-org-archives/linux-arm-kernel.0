From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 01 Aug 2013 23:08:11 +0100
Subject: [PATCH RFC 34/51] DMA-API: net: octeon: use
 dma_coerce_mask_and_coherent()
In-Reply-To: <20130801213420.GL23006@n2100.arm.linux.org.uk>
References: <20130801213420.GL23006@n2100.arm.linux.org.uk>
Message-ID: <E1V512Z-0006t1-Eu@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The code sequence:
	pdev->dev.coherent_dma_mask = DMA_BIT_MASK(64);
	pdev->dev.dma_mask = &pdev->dev.coherent_dma_mask;
bypasses the architectures check on the DMA mask.  It can be replaced
with dma_coerce_mask_and_coherent(), avoiding the direct initialization
of this mask.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/net/ethernet/octeon/octeon_mgmt.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/octeon/octeon_mgmt.c b/drivers/net/ethernet/octeon/octeon_mgmt.c
index 622aa75..2006a07 100644
--- a/drivers/net/ethernet/octeon/octeon_mgmt.c
+++ b/drivers/net/ethernet/octeon/octeon_mgmt.c
@@ -1552,8 +1552,9 @@ static int octeon_mgmt_probe(struct platform_device *pdev)
 
 	p->phy_np = of_parse_phandle(pdev->dev.of_node, "phy-handle", 0);
 
-	pdev->dev.coherent_dma_mask = DMA_BIT_MASK(64);
-	pdev->dev.dma_mask = &pdev->dev.coherent_dma_mask;
+	result = dma_coerce_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
+	if (result)
+		goto err;
 
 	netif_carrier_off(netdev);
 	result = register_netdev(netdev);
-- 
1.7.4.4
