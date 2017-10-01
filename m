From: jonas.gorski@gmail.com (Jonas Gorski)
Date: Sun,  1 Oct 2017 13:02:16 +0200
Subject: [PATCH 2/6] bcm63xx_enet: do not write to random DMA channel on
 BCM6345
In-Reply-To: <20171001110220.27668-1-jonas.gorski@gmail.com>
References: <20171001110220.27668-1-jonas.gorski@gmail.com>
Message-ID: <20171001110220.27668-3-jonas.gorski@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DMA controller regs actually point to DMA channel 0, so the write to
ENETDMA_CFG_REG will actually modify a random DMA channel.

Since DMA controller registers do not exist on BCM6345, guard the write
with the usual check for dma_has_sram.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 drivers/net/ethernet/broadcom/bcm63xx_enet.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bcm63xx_enet.c b/drivers/net/ethernet/broadcom/bcm63xx_enet.c
index a45ec97b5b1e..a1e1e12e187a 100644
--- a/drivers/net/ethernet/broadcom/bcm63xx_enet.c
+++ b/drivers/net/ethernet/broadcom/bcm63xx_enet.c
@@ -1062,7 +1062,8 @@ static int bcm_enet_open(struct net_device *dev)
 	val = enet_readl(priv, ENET_CTL_REG);
 	val |= ENET_CTL_ENABLE_MASK;
 	enet_writel(priv, val, ENET_CTL_REG);
-	enet_dma_writel(priv, ENETDMA_CFG_EN_MASK, ENETDMA_CFG_REG);
+	if (priv->dma_has_sram)
+		enet_dma_writel(priv, ENETDMA_CFG_EN_MASK, ENETDMA_CFG_REG);
 	enet_dmac_writel(priv, priv->dma_chan_en_mask,
 			 ENETDMAC_CHANCFG, priv->rx_chan);
 
-- 
2.13.2
