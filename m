From: christophe.jaillet@wanadoo.fr (Christophe JAILLET)
Date: Sat, 18 Feb 2017 09:06:14 +0100
Subject: [PATCH] soc: ti: knav_dma: Fix some error handling
Message-ID: <20170218080614.1828-1-christophe.jaillet@wanadoo.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

'pktdma_get_regs()' never returns NULL. It returns an error pointer or a
valid pointer.
So test its return value with IS_ERR.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
After checking with IS_ERR, it could be better to propagate the error code
instead of returning -ENODEV uncondionnaly
---
 drivers/soc/ti/knav_dma.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/ti/knav_dma.c b/drivers/soc/ti/knav_dma.c
index ecebe2eecc3a..3272b379bfcd 100644
--- a/drivers/soc/ti/knav_dma.c
+++ b/drivers/soc/ti/knav_dma.c
@@ -649,7 +649,7 @@ static int dma_init(struct device_node *cloud, struct device_node *dma_node)
 	}
 
 	dma->reg_global	 = pktdma_get_regs(dma, node, 0, &size);
-	if (!dma->reg_global)
+	if (IS_ERR(dma->reg_global))
 		return -ENODEV;
 	if (size < sizeof(struct reg_global)) {
 		dev_err(kdev->dev, "bad size %pa for global regs\n", &size);
@@ -657,22 +657,22 @@ static int dma_init(struct device_node *cloud, struct device_node *dma_node)
 	}
 
 	dma->reg_tx_chan = pktdma_get_regs(dma, node, 1, &size);
-	if (!dma->reg_tx_chan)
+	if (IS_ERR(dma->reg_tx_chan))
 		return -ENODEV;
 
 	max_tx_chan = size / sizeof(struct reg_chan);
 	dma->reg_rx_chan = pktdma_get_regs(dma, node, 2, &size);
-	if (!dma->reg_rx_chan)
+	if (IS_ERR(dma->reg_rx_chan))
 		return -ENODEV;
 
 	max_rx_chan = size / sizeof(struct reg_chan);
 	dma->reg_tx_sched = pktdma_get_regs(dma, node, 3, &size);
-	if (!dma->reg_tx_sched)
+	if (IS_ERR(dma->reg_tx_sched))
 		return -ENODEV;
 
 	max_tx_sched = size / sizeof(struct reg_tx_sched);
 	dma->reg_rx_flow = pktdma_get_regs(dma, node, 4, &size);
-	if (!dma->reg_rx_flow)
+	if (IS_ERR(ma->reg_rx_flow))
 		return -ENODEV;
 
 	max_rx_flow = size / sizeof(struct reg_rx_flow);
-- 
2.9.3
