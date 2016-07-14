From: appana.durga.rao@xilinx.com (Kedareswara rao Appana)
Date: Thu, 14 Jul 2016 19:00:55 +0530
Subject: [PATCH v2] dmaengine: zynqmp_dma: Fix static checker warning
Message-ID: <1468503055-20197-1-git-send-email-appanad@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the below static checker warning
drivers/dma/xilinx/zynqmp_dma.c:973 zynqmp_dma_chan_probe()
        warn: was && intended here instead of ||?

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
---
Changes for v2:
---> Return EINVAL instead of err as suggested by Dan.

 drivers/dma/xilinx/zynqmp_dma.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_dma.c
index f777a5b..b18d51f 100644
--- a/drivers/dma/xilinx/zynqmp_dma.c
+++ b/drivers/dma/xilinx/zynqmp_dma.c
@@ -970,12 +970,17 @@ static int zynqmp_dma_chan_probe(struct zynqmp_dma_device *zdev,
 	chan->dst_burst_len = ZYNQMP_DMA_AWLEN_RST_VAL;
 	chan->src_burst_len = ZYNQMP_DMA_ARLEN_RST_VAL;
 	err = of_property_read_u32(node, "xlnx,bus-width", &chan->bus_width);
-	if ((err < 0) && ((chan->bus_width != ZYNQMP_DMA_BUS_WIDTH_64) ||
-			  (chan->bus_width != ZYNQMP_DMA_BUS_WIDTH_128))) {
-		dev_err(zdev->dev, "invalid bus-width value");
+	if (err < 0) {
+		dev_err(&pdev->dev, "missing xlnx,bus-width property\n");
 		return err;
 	}
 
+	if (chan->bus_width != ZYNQMP_DMA_BUS_WIDTH_64 &&
+	    chan->bus_width != ZYNQMP_DMA_BUS_WIDTH_128) {
+		dev_err(zdev->dev, "invalid bus-width value");
+		return -EINVAL;
+	}
+
 	chan->is_dmacoherent =  of_property_read_bool(node, "dma-coherent");
 	zdev->chan = chan;
 	tasklet_init(&chan->tasklet, zynqmp_dma_do_tasklet, (ulong)chan);
-- 
1.7.1
