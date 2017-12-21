From: appana.durga.rao@xilinx.com (Kedareswara rao Appana)
Date: Thu, 21 Dec 2017 15:41:38 +0530
Subject: [LINUX PATCH 4/4] dmaengine: xilinx_dma: Free BD consistent memory
In-Reply-To: <1513851098-15787-1-git-send-email-appanad@xilinx.com>
References: <1513851098-15787-1-git-send-email-appanad@xilinx.com>
Message-ID: <1513851098-15787-5-git-send-email-appanad@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Free BD consistent memory while freeing the channel
i.e in free_chan_resources.

Signed-off-by: Radhey Shyam Pandey <radheys@xilinx.com>
Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
---
 drivers/dma/xilinx/xilinx_dma.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 845e638..a9edbd8 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -764,6 +764,11 @@ static void xilinx_dma_free_chan_resources(struct dma_chan *dchan)
 		INIT_LIST_HEAD(&chan->free_seg_list);
 		spin_unlock_irqrestore(&chan->lock, flags);
 
+		/* Free memory that is allocated for BD */
+		dma_free_coherent(chan->dev, sizeof(*chan->seg_v) *
+				  XILINX_DMA_NUM_DESCS, chan->seg_v,
+				  chan->seg_p);
+
 		/* Free Memory that is allocated for cyclic DMA Mode */
 		dma_free_coherent(chan->dev, sizeof(*chan->cyclic_seg_v),
 				  chan->cyclic_seg_v, chan->cyclic_seg_p);
-- 
2.7.4
