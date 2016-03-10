From: moinejf@free.fr (Jean-Francois Moine)
Date: Thu, 10 Mar 2016 11:07:53 +0100
Subject: [PATCH 4/5] dmaengine: sun6i: Set default values to burst and bus
 width
In-Reply-To: <cover.1457606136.git.moinejf@free.fr>
References: <cover.1457606136.git.moinejf@free.fr>
Message-ID: <7f5fc4733c8145fe146bd2a7e0d8febfddf2fe6b.1457606136.git.moinejf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When defining the DMA transfer, the sound PCM DMA engine sets only
the burst and bus width values on the DMA side.
This was making the audio transfers to be rejected because of invalid
values on the memory side.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 drivers/dma/sun6i-dma.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index 7c98c0d..c27d572 100644
--- a/drivers/dma/sun6i-dma.c
+++ b/drivers/dma/sun6i-dma.c
@@ -288,19 +288,31 @@ static inline int sun6i_dma_cfg_lli(struct sun6i_dma_lli *lli,
 	if (!config)
 		return -EINVAL;
 
-	src_burst = convert_burst(config->src_maxburst);
+	if (config->src_maxburst == 0)
+		src_burst = convert_burst(config->dst_maxburst);
+	else
+		src_burst = convert_burst(config->src_maxburst);
 	if (src_burst < 0)
 		return src_burst;
 
-	dst_burst = convert_burst(config->dst_maxburst);
+	if (config->dst_maxburst == 0)
+		dst_burst = convert_burst(config->src_maxburst);
+	else
+		dst_burst = convert_burst(config->dst_maxburst);
 	if (dst_burst < 0)
 		return dst_burst;
 
-	src_width = convert_buswidth(config->src_addr_width);
+	if (config->src_addr_width == DMA_SLAVE_BUSWIDTH_UNDEFINED)
+		src_width = convert_buswidth(config->dst_addr_width);
+	else
+		src_width = convert_buswidth(config->src_addr_width);
 	if (src_width < 0)
 		return src_width;
 
-	dst_width = convert_buswidth(config->dst_addr_width);
+	if (config->dst_addr_width == DMA_SLAVE_BUSWIDTH_UNDEFINED)
+		dst_width = convert_buswidth(config->src_addr_width);
+	else
+		dst_width = convert_buswidth(config->dst_addr_width);
 	if (dst_width < 0)
 		return dst_width;
 
-- 
2.7.2
