From: stefan.bruens@rwth-aachen.de (=?UTF-8?q?Stefan=20Br=C3=BCns?=)
Date: Mon, 4 Sep 2017 00:40:55 +0200
Subject: [PATCH 04/10] dmaengine: sun6i: Enable additional burst
 lengths/widths on H3
In-Reply-To: <20170903224100.17893-1-stefan.bruens@rwth-aachen.de>
References: <20170903224100.17893-1-stefan.bruens@rwth-aachen.de>
Message-ID: <20170903224100.17893-5-stefan.bruens@rwth-aachen.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The H3 supports bursts lengths of 1, 4, 8 and 16 transfers, each with
a width of 1, 2, 4 or 8 bytes.

The register value for the the width is log2-encoded, change the
conversion function to provide the correct value for width == 8.

Signed-off-by: Stefan Br?ns <stefan.bruens@rwth-aachen.de>
---
 drivers/dma/sun6i-dma.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index c5644bd0f91a..335a8ec88b0b 100644
--- a/drivers/dma/sun6i-dma.c
+++ b/drivers/dma/sun6i-dma.c
@@ -263,8 +263,12 @@ static inline s8 convert_burst(u32 maxburst)
 	switch (maxburst) {
 	case 1:
 		return 0;
+	case 4:
+		return 1;
 	case 8:
 		return 2;
+	case 16:
+		return 3;
 	default:
 		return -EINVAL;
 	}
@@ -272,7 +276,7 @@ static inline s8 convert_burst(u32 maxburst)
 
 static inline s8 convert_buswidth(enum dma_slave_buswidth addr_width)
 {
-	return addr_width >> 1;
+	return ilog2(addr_width);
 }
 
 static size_t sun6i_get_chan_size(struct sun6i_pchan *pchan)
@@ -1152,6 +1156,12 @@ static int sun6i_dma_probe(struct platform_device *pdev)
 						  BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
 	sdc->src_burst_lengths			= BIT(1) | BIT(8);
 	sdc->dst_burst_lengths			= BIT(1) | BIT(8);
+	if (sdc->cfg->dmac_variant == DMAC_VARIANT_H3) {
+		sdc->slave.src_addr_widths |= BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
+		sdc->slave.dst_addr_widths |= BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
+		sdc->src_burst_lengths     |= BIT(4) | BIT(16);
+		sdc->dst_burst_lengths     |= BIT(4) | BIT(16);
+	}
 	sdc->slave.directions			= BIT(DMA_DEV_TO_MEM) |
 						  BIT(DMA_MEM_TO_DEV);
 	sdc->slave.residue_granularity		= DMA_RESIDUE_GRANULARITY_BURST;
-- 
2.14.1
