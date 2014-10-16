From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 16 Oct 2014 12:17:49 +0200
Subject: [PATCH v2 50/53] dmaengine: pl330: Declare slave capabilities for the
 generic code
In-Reply-To: <1413454672-27400-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1413454672-27400-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1413454672-27400-51-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the generic slave caps code can make use of the device assigned
capabilities, instead of relying on a callback to be implemented.

Make use of this code.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/dma/pl330.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 1e3d3459e62c..f31f54df09f3 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -2576,19 +2576,6 @@ static irqreturn_t pl330_irq_handler(int irq, void *data)
 	BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) | \
 	BIT(DMA_SLAVE_BUSWIDTH_8_BYTES)
 
-static int pl330_dma_device_slave_caps(struct dma_chan *dchan,
-	struct dma_slave_caps *caps)
-{
-	caps->src_addr_widths = PL330_DMA_BUSWIDTHS;
-	caps->dst_addr_widths = PL330_DMA_BUSWIDTHS;
-	caps->directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
-	caps->cmd_pause = false;
-	caps->cmd_terminate = true;
-	caps->residue_granularity = DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
-
-	return 0;
-}
-
 static int
 pl330_probe(struct amba_device *adev, const struct amba_id *id)
 {
@@ -2708,7 +2695,11 @@ pl330_probe(struct amba_device *adev, const struct amba_id *id)
 	pd->device_config = pl330_config;
 	pd->device_terminate_all = pl330_terminate_all;
 	pd->device_issue_pending = pl330_issue_pending;
-	pd->device_slave_caps = pl330_dma_device_slave_caps;
+	pd->src_addr_widths = PL330_DMA_BUSWIDTHS;
+	pd->dst_addr_widths = PL330_DMA_BUSWIDTHS;
+	pd->directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
+	pd->residue_granularity = DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
+	pd->generic_slave_caps = true;
 
 	ret = dma_async_device_register(pd);
 	if (ret) {
-- 
2.1.1
