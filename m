From: 21cnbao@gmail.com (Barry Song)
Date: Mon, 23 Dec 2013 20:19:21 +0800
Subject: [PATCH] dmaengine: sirf: Add device_slave_caps interface
Message-ID: <1387801161-3126-1-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rongjun Ying <rongjun.ying@csr.com>

this patch adds device_slave_caps() callback as SiRF SoC sound drivers
depend on it.

Signed-off-by: Rongjun Ying <rongjun.ying@csr.com>
Signed-off-by: Barry Song <Barry.Song@csr.com>
---
 drivers/dma/sirf-dma.c |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/drivers/dma/sirf-dma.c b/drivers/dma/sirf-dma.c
index 6aec3ad..d4d3a31 100644
--- a/drivers/dma/sirf-dma.c
+++ b/drivers/dma/sirf-dma.c
@@ -640,6 +640,25 @@ bool sirfsoc_dma_filter_id(struct dma_chan *chan, void *chan_id)
 }
 EXPORT_SYMBOL(sirfsoc_dma_filter_id);
 
+#define SIRFSOC_DMA_BUSWIDTHS \
+	(BIT(DMA_SLAVE_BUSWIDTH_UNDEFINED) | \
+	BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) | \
+	BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) | \
+	BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) | \
+	BIT(DMA_SLAVE_BUSWIDTH_8_BYTES))
+
+static int sirfsoc_dma_device_slave_caps(struct dma_chan *dchan,
+	struct dma_slave_caps *caps)
+{
+	caps->src_addr_widths = SIRFSOC_DMA_BUSWIDTHS;
+	caps->dstn_addr_widths = SIRFSOC_DMA_BUSWIDTHS;
+	caps->directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
+	caps->cmd_pause = true;
+	caps->cmd_terminate = true;
+
+	return 0;
+}
+
 static int sirfsoc_dma_probe(struct platform_device *op)
 {
 	struct device_node *dn = op->dev.of_node;
@@ -712,6 +731,7 @@ static int sirfsoc_dma_probe(struct platform_device *op)
 	dma->device_tx_status = sirfsoc_dma_tx_status;
 	dma->device_prep_interleaved_dma = sirfsoc_dma_prep_interleaved;
 	dma->device_prep_dma_cyclic = sirfsoc_dma_prep_cyclic;
+	dma->device_slave_caps = sirfsoc_dma_device_slave_caps;
 
 	INIT_LIST_HEAD(&dma->channels);
 	dma_cap_set(DMA_SLAVE, dma->cap_mask);
-- 
1.7.5.4
