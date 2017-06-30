From: garsilva@embeddedor.com (Gustavo A. R. Silva)
Date: Fri, 30 Jun 2017 02:42:47 -0500
Subject: [PATCH] dmaengine: zynqmp_dma: fix error return code in
 zynqmp_dma_chan_probe()
Message-ID: <20170630074247.GA26153@embeddedgus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Print error message and propagate the return value of
platform_get_irq on failure.

Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 drivers/dma/xilinx/zynqmp_dma.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_dma.c
index 6d221e5..5fa6d0d 100644
--- a/drivers/dma/xilinx/zynqmp_dma.c
+++ b/drivers/dma/xilinx/zynqmp_dma.c
@@ -996,8 +996,11 @@ static int zynqmp_dma_chan_probe(struct zynqmp_dma_device *zdev,
 
 	zynqmp_dma_init(chan);
 	chan->irq = platform_get_irq(pdev, 0);
-	if (chan->irq < 0)
-		return -ENXIO;
+	if (chan->irq < 0) {
+		dev_err(&pdev->dev, "failed to get IRQ: %d\n", chan->irq);
+		return chan->irq;
+	}
+
 	err = devm_request_irq(&pdev->dev, chan->irq, zynqmp_dma_irq_handler, 0,
 			       "zynqmp-dma", chan);
 	if (err)
-- 
2.5.0
