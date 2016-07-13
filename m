From: appana.durga.rao@xilinx.com (Kedareswara rao Appana)
Date: Wed, 13 Jul 2016 16:12:16 +0530
Subject: [PATCH] dmaengine: zynqmp_dma: Fix static checker warning
Message-ID: <1468406536-6350-1-git-send-email-appanad@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the below static checker warning
drivers/dma/xilinx/zynqmp_dma.c:973 zynqmp_dma_chan_probe()
	warn: was && intended here instead of ||?

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
---
 drivers/dma/xilinx/zynqmp_dma.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_dma.c
index f777a5b..2248704 100644
--- a/drivers/dma/xilinx/zynqmp_dma.c
+++ b/drivers/dma/xilinx/zynqmp_dma.c
@@ -970,8 +970,13 @@ static int zynqmp_dma_chan_probe(struct zynqmp_dma_device *zdev,
 	chan->dst_burst_len = ZYNQMP_DMA_AWLEN_RST_VAL;
 	chan->src_burst_len = ZYNQMP_DMA_ARLEN_RST_VAL;
 	err = of_property_read_u32(node, "xlnx,bus-width", &chan->bus_width);
-	if ((err < 0) && ((chan->bus_width != ZYNQMP_DMA_BUS_WIDTH_64) ||
-			  (chan->bus_width != ZYNQMP_DMA_BUS_WIDTH_128))) {
+	if (err < 0) {
+		dev_err(&pdev->dev, "missing xlnx,bus-width property\n");
+		return err;
+	}
+
+	if ((chan->bus_width != ZYNQMP_DMA_BUS_WIDTH_64) ||
+	    (chan->bus_width != ZYNQMP_DMA_BUS_WIDTH_128)) {
 		dev_err(zdev->dev, "invalid bus-width value");
 		return err;
 	}
-- 
1.7.1
