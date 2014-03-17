From: simon.kagstrom@netinsight.net (Simon =?UTF-8?B?S8OlZ3N0csO2bQ==?=)
Date: Mon, 17 Mar 2014 10:57:03 +0100
Subject: [PATCH RESEND 2/2] ixp4xx_eth: Setup coherent_dma_mask
In-Reply-To: <20140317105448.14bcb617@marrow.netinsight.se>
References: <20140317105448.14bcb617@marrow.netinsight.se>
Message-ID: <20140317105703.090c258d@marrow.netinsight.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver has been broken since commit 1a4901177574083c35fafc24c4d151c2a7c7647c

  ixp4xx_eth: avoid calling dma_pool_create() with NULL dev

in 3.7 and would fail with

[   33.055473] net eth1: coherent DMA mask is unset
[   33.055523] net eth1: coherent allocation too big (requested 0x1000 mask 0x0)

Fix by setting up the DMA mask to the entire 32-bit range.

Signed-off-by: Simon Kagstrom <simon.kagstrom@netinsight.net>
---
 drivers/net/ethernet/xscale/ixp4xx_eth.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/xscale/ixp4xx_eth.c b/drivers/net/ethernet/xscale/ixp4xx_eth.c
index 25283f1..e540e51 100644
--- a/drivers/net/ethernet/xscale/ixp4xx_eth.c
+++ b/drivers/net/ethernet/xscale/ixp4xx_eth.c
@@ -1426,6 +1426,10 @@ static int eth_init_one(struct platform_device *pdev)
 	port->netdev = dev;
 	port->id = pdev->id;
 
+	err = dma_set_coherent_mask(&dev->dev, DMA_BIT_MASK(32));
+	if (err < 0)
+		goto err_free;
+
 	switch (port->id) {
 	case IXP4XX_ETH_NPEA:
 		port->regs = (struct eth_regs __iomem *)IXP4XX_EthA_BASE_VIRT;
-- 
1.7.9.6
