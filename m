From: appana.durga.rao@xilinx.com (Kedareswara rao Appana)
Date: Thu, 21 Dec 2017 15:41:35 +0530
Subject: [LINUX PATCH 1/4] dmaengine: xilinx_dma: Fix dma_get_slave_caps() API
 failures
In-Reply-To: <1513851098-15787-1-git-send-email-appanad@xilinx.com>
References: <1513851098-15787-1-git-send-email-appanad@xilinx.com>
Message-ID: <1513851098-15787-2-git-send-email-appanad@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When client driver uses dma_get_slave_caps() api,
it checks for certain fields of dma_device struct
currently driver is not settings few fields resulting
dma_get_slave_caps() returning failure.

This patch fixes this issue by populating proper values
to the struct dma_device fields.

Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
---
 drivers/dma/xilinx/xilinx_dma.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 88d317d..21ac954 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -2398,6 +2398,7 @@ static int xilinx_dma_chan_probe(struct xilinx_dma_device *xdev,
 		chan->direction = DMA_MEM_TO_DEV;
 		chan->id = chan_id;
 		chan->tdest = chan_id;
+		xdev->common.directions = BIT(DMA_MEM_TO_DEV);
 
 		chan->ctrl_offset = XILINX_DMA_MM2S_CTRL_OFFSET;
 		if (xdev->dma_config->dmatype == XDMA_TYPE_VDMA) {
@@ -2415,6 +2416,7 @@ static int xilinx_dma_chan_probe(struct xilinx_dma_device *xdev,
 		chan->direction = DMA_DEV_TO_MEM;
 		chan->id = chan_id;
 		chan->tdest = chan_id - xdev->nr_channels;
+		xdev->common.directions |= BIT(DMA_DEV_TO_MEM);
 
 		chan->ctrl_offset = XILINX_DMA_S2MM_CTRL_OFFSET;
 		if (xdev->dma_config->dmatype == XDMA_TYPE_VDMA) {
@@ -2629,6 +2631,8 @@ static int xilinx_dma_probe(struct platform_device *pdev)
 		dma_cap_set(DMA_PRIVATE, xdev->common.cap_mask);
 	}
 
+	xdev->common.dst_addr_widths = BIT(addr_width / 8);
+	xdev->common.src_addr_widths = BIT(addr_width / 8);
 	xdev->common.device_alloc_chan_resources =
 				xilinx_dma_alloc_chan_resources;
 	xdev->common.device_free_chan_resources =
-- 
2.7.4
