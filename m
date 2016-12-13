From: cedric.madianga@gmail.com (M'boumba Cedric Madianga)
Date: Tue, 13 Dec 2016 14:40:50 +0100
Subject: [PATCH 8/9] dmaengine: stm32-dma: Add synchronization support
In-Reply-To: <1481636451-27863-1-git-send-email-cedric.madianga@gmail.com>
References: <1481636451-27863-1-git-send-email-cedric.madianga@gmail.com>
Message-ID: <1481636451-27863-9-git-send-email-cedric.madianga@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implement the new device_synchronize() callback to allow proper
synchronization when stopping a channel.

Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
---
 drivers/dma/stm32-dma.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/dma/stm32-dma.c b/drivers/dma/stm32-dma.c
index 35639f6..b7be43a 100644
--- a/drivers/dma/stm32-dma.c
+++ b/drivers/dma/stm32-dma.c
@@ -403,6 +403,13 @@ static int stm32_dma_terminate_all(struct dma_chan *c)
 	return 0;
 }
 
+static void stm32_dma_synchronize(struct dma_chan *c)
+{
+	struct stm32_dma_chan *chan = to_stm32_dma_chan(c);
+
+	vchan_synchronize(&chan->vchan);
+}
+
 static void stm32_dma_dump_reg(struct stm32_dma_chan *chan)
 {
 	struct stm32_dma_device *dmadev = stm32_dma_get_dev(chan);
@@ -1068,6 +1075,7 @@ static int stm32_dma_probe(struct platform_device *pdev)
 	dd->device_prep_dma_cyclic = stm32_dma_prep_dma_cyclic;
 	dd->device_config = stm32_dma_slave_config;
 	dd->device_terminate_all = stm32_dma_terminate_all;
+	dd->device_synchronize = stm32_dma_synchronize;
 	dd->src_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
 		BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
 		BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
-- 
1.9.1
