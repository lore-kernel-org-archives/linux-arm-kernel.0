From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Tue, 6 Jan 2015 17:36:26 +0100
Subject: [PATCH] dmaengine: at_hdmac: declare slave capabilities
Message-ID: <1420562186-22386-1-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Declare slave capabilities to suppress "this driver doesn't support generic
slave capabilities reporting" warning.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 drivers/dma/at_hdmac.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index 86450b3..1e1a4c5 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -42,6 +42,11 @@
 #define	ATC_DEFAULT_CFG		(ATC_FIFOCFG_HALFFIFO)
 #define	ATC_DEFAULT_CTRLB	(ATC_SIF(AT_DMA_MEM_IF) \
 				|ATC_DIF(AT_DMA_MEM_IF))
+#define ATC_DMA_BUSWIDTHS\
+	(BIT(DMA_SLAVE_BUSWIDTH_UNDEFINED) |\
+	BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |\
+	BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |\
+	BIT(DMA_SLAVE_BUSWIDTH_4_BYTES))
 
 /*
  * Initial number of descriptors to allocate for each channel. This could
@@ -1531,6 +1536,10 @@ static int __init at_dma_probe(struct platform_device *pdev)
 		atdma->dma_common.device_pause = atc_pause;
 		atdma->dma_common.device_resume = atc_resume;
 		atdma->dma_common.device_terminate_all = atc_terminate_all;
+		atdma->dma_common.src_addr_widths = ATC_DMA_BUSWIDTHS;
+		atdma->dma_common.dst_addr_widths = ATC_DMA_BUSWIDTHS;
+		atdma->dma_common.directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
+		atdma->dma_common.residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
 	}
 
 	dma_writel(atdma, EN, AT_DMA_ENABLE);
-- 
2.2.0
