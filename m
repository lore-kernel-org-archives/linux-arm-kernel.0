From: moinejf@free.fr (Jean-Francois Moine)
Date: Sat, 2 Apr 2016 11:27:57 +0200
Subject: [PATCH v4 2/3] dmaengine: sun6i: Set default maxburst size and bus
 width
In-Reply-To: <cover.1459590553.git.moinejf@free.fr>
References: <cover.1459590553.git.moinejf@free.fr>
Message-ID: <dbffa01a982303114e5ae377189ddfa9fdff4999.1459590553.git.moinejf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some DMA clients, as audio, don't set the maxburst size and bus width
on the memory side when starting DMA transfers.
This patch prevents such transfers to be aborted by providing system
default values to the lacking ones.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 drivers/dma/sun6i-dma.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index b08245e..821fc4f 100644
--- a/drivers/dma/sun6i-dma.c
+++ b/drivers/dma/sun6i-dma.c
@@ -470,10 +470,25 @@ static int set_config(struct sun6i_dma_dev *sdev,
 {
 	s8 src_width, dst_width, src_burst, dst_burst;
 
-	src_burst = convert_burst(sconfig->src_maxburst);
-	src_width = convert_buswidth(sconfig->src_addr_width);
-	dst_burst = convert_burst(sconfig->dst_maxburst);
-	dst_width = convert_buswidth(sconfig->dst_addr_width);
+	if (direction == DMA_MEM_TO_DEV) {
+		src_burst = convert_burst(sconfig->src_maxburst ?
+					sconfig->src_maxburst : 8);
+		src_width = convert_buswidth(sconfig->src_addr_width !=
+						DMA_SLAVE_BUSWIDTH_UNDEFINED ?
+				sconfig->src_addr_width :
+				DMA_SLAVE_BUSWIDTH_4_BYTES);
+		dst_burst = convert_burst(sconfig->dst_maxburst);
+		dst_width = convert_buswidth(sconfig->dst_addr_width);
+	} else {	/* DMA_DEV_TO_MEM */
+		src_burst = convert_burst(sconfig->src_maxburst);
+		src_width = convert_buswidth(sconfig->src_addr_width);
+		dst_burst = convert_burst(sconfig->dst_maxburst ?
+					sconfig->dst_maxburst : 8);
+		dst_width = convert_buswidth(sconfig->dst_addr_width !=
+						DMA_SLAVE_BUSWIDTH_UNDEFINED ?
+				sconfig->dst_addr_width :
+				DMA_SLAVE_BUSWIDTH_4_BYTES);
+	}
 
 	if (src_burst < 0)
 		return src_burst;
-- 
2.8.0
