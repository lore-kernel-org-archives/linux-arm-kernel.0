From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 16 Oct 2014 12:17:50 +0200
Subject: [PATCH v2 51/53] dmaengine: sirf: Declare slave capabilities for the
 generic code
In-Reply-To: <1413454672-27400-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1413454672-27400-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1413454672-27400-52-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the generic slave caps code can make use of the device assigned
capabilities, instead of relying on a callback to be implemented.

Make use of this code.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/dma/sirf-dma.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/dma/sirf-dma.c b/drivers/dma/sirf-dma.c
index 711c2bae9003..87294f9b8094 100644
--- a/drivers/dma/sirf-dma.c
+++ b/drivers/dma/sirf-dma.c
@@ -628,18 +628,6 @@ EXPORT_SYMBOL(sirfsoc_dma_filter_id);
 	BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) | \
 	BIT(DMA_SLAVE_BUSWIDTH_8_BYTES))
 
-static int sirfsoc_dma_device_slave_caps(struct dma_chan *dchan,
-	struct dma_slave_caps *caps)
-{
-	caps->src_addr_widths = SIRFSOC_DMA_BUSWIDTHS;
-	caps->dst_addr_widths = SIRFSOC_DMA_BUSWIDTHS;
-	caps->directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
-	caps->cmd_pause = true;
-	caps->cmd_terminate = true;
-
-	return 0;
-}
-
 static struct dma_chan *of_dma_sirfsoc_xlate(struct of_phandle_args *dma_spec,
 	struct of_dma *ofdma)
 {
@@ -727,7 +715,10 @@ static int sirfsoc_dma_probe(struct platform_device *op)
 	dma->device_tx_status = sirfsoc_dma_tx_status;
 	dma->device_prep_interleaved_dma = sirfsoc_dma_prep_interleaved;
 	dma->device_prep_dma_cyclic = sirfsoc_dma_prep_cyclic;
-	dma->device_slave_caps = sirfsoc_dma_device_slave_caps;
+	dma->src_addr_widths = SIRFSOC_DMA_BUSWIDTHS;
+	dma->dst_addr_widths = SIRFSOC_DMA_BUSWIDTHS;
+	dma->directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
+	dma->generic_slave_caps = true;
 
 	INIT_LIST_HEAD(&dma->channels);
 	dma_cap_set(DMA_SLAVE, dma->cap_mask);
-- 
2.1.1
