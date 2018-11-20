From: andrea.merello@gmail.com (Andrea Merello)
Date: Tue, 20 Nov 2018 16:31:49 +0100
Subject: [PATCH v6 5/7] dmaengine: xilinx_dma: autodetect whether the HW
 supports scatter-gather
In-Reply-To: <20181120153151.18024-1-andrea.merello@gmail.com>
References: <20181120153151.18024-1-andrea.merello@gmail.com>
Message-ID: <20181120153151.18024-5-andrea.merello@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The AXIDMA and CDMA HW can be either direct-access or scatter-gather
version. These are SW incompatible.

The driver can handle both versions: a DT property was used to
tell the driver whether to assume the HW is in scatter-gather mode.

This patch makes the driver to autodetect this information. The DT
property is not required anymore.

No changes for VDMA.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree at vger.kernel.org
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
---
Changes in v2:
	- autodetect only in !VDMA case
Changes in v3:
	- cc DT maintainers/ML
Changes in v4:
	- fix typos in commit message
Changes in v5:
	None
Changes in v6:
	None
---
 drivers/dma/xilinx/xilinx_dma.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 0716db61f1d0..41bd8caca09e 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -86,6 +86,7 @@
 #define XILINX_DMA_DMASR_DMA_DEC_ERR		BIT(6)
 #define XILINX_DMA_DMASR_DMA_SLAVE_ERR		BIT(5)
 #define XILINX_DMA_DMASR_DMA_INT_ERR		BIT(4)
+#define XILINX_DMA_DMASR_SG_MASK		BIT(3)
 #define XILINX_DMA_DMASR_IDLE			BIT(1)
 #define XILINX_DMA_DMASR_HALTED		BIT(0)
 #define XILINX_DMA_DMASR_DELAY_MASK		GENMASK(31, 24)
@@ -412,7 +413,6 @@ struct xilinx_dma_config {
  * @dev: Device Structure
  * @common: DMA device structure
  * @chan: Driver specific DMA channel
- * @has_sg: Specifies whether Scatter-Gather is present or not
  * @mcdma: Specifies whether Multi-Channel is present or not
  * @flush_on_fsync: Flush on frame sync
  * @ext_addr: Indicates 64 bit addressing is supported by dma device
@@ -432,7 +432,6 @@ struct xilinx_dma_device {
 	struct device *dev;
 	struct dma_device common;
 	struct xilinx_dma_chan *chan[XILINX_DMA_MAX_CHANS_PER_DEVICE];
-	bool has_sg;
 	bool mcdma;
 	u32 flush_on_fsync;
 	bool ext_addr;
@@ -2417,7 +2416,6 @@ static int xilinx_dma_chan_probe(struct xilinx_dma_device *xdev,
 
 	chan->dev = xdev->dev;
 	chan->xdev = xdev;
-	chan->has_sg = xdev->has_sg;
 	chan->desc_pendingcount = 0x0;
 	chan->ext_addr = xdev->ext_addr;
 	/* This variable ensures that descriptors are not
@@ -2517,6 +2515,15 @@ static int xilinx_dma_chan_probe(struct xilinx_dma_device *xdev,
 		chan->stop_transfer = xilinx_dma_stop_transfer;
 	}
 
+	/* check if SG is enabled (only for AXIDMA and CDMA) */
+	if (xdev->dma_config->dmatype != XDMA_TYPE_VDMA) {
+		if (dma_ctrl_read(chan, XILINX_DMA_REG_DMASR) &
+		    XILINX_DMA_DMASR_SG_MASK)
+			chan->has_sg = true;
+		dev_dbg(chan->dev, "ch %d: SG %s\n", chan->id,
+			chan->has_sg ? "enabled" : "disabled");
+	}
+
 	/* Initialize the tasklet */
 	tasklet_init(&chan->tasklet, xilinx_dma_do_tasklet,
 			(unsigned long)chan);
@@ -2655,7 +2662,6 @@ static int xilinx_dma_probe(struct platform_device *pdev)
 		return PTR_ERR(xdev->regs);
 
 	/* Retrieve the DMA engine properties from the device tree */
-	xdev->has_sg = of_property_read_bool(node, "xlnx,include-sg");
 	xdev->max_buffer_len = GENMASK(XILINX_DMA_MAX_TRANS_LEN_MAX - 1, 0);
 
 	if (xdev->dma_config->dmatype == XDMA_TYPE_AXIDMA) {
-- 
2.17.1
