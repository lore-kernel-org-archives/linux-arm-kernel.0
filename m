From: shawn.lin@rock-chips.com (Shawn Lin)
Date: Thu, 15 Oct 2015 09:36:14 +0800
Subject: [PATCH v6 07/10] DMA: pl330: add max burst for dmaengine
In-Reply-To: <1444872865-2169-1-git-send-email-shawn.lin@rock-chips.com>
References: <1444872865-2169-1-git-send-email-shawn.lin@rock-chips.com>
Message-ID: <1444872974-2466-1-git-send-email-shawn.lin@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add max burst capability for dmaengine and
limit burst capability to one for PL330_QUIRK_BROKEN_NO_FLUSHP

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

Changes in v6:
- remove expose quirks and add max_burst for dmaengine

Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None
Changes in v1: None

 drivers/dma/pl330.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 008408d..1b0453b 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -33,6 +33,7 @@
 #define PL330_MAX_CHAN		8
 #define PL330_MAX_IRQS		32
 #define PL330_MAX_PERI		32
+#define PL330_MAX_BURST         16
 
 #define PL330_QUIRK_BROKEN_NO_FLUSHP BIT(0)
 
@@ -2938,6 +2939,8 @@ pl330_probe(struct amba_device *adev, const struct amba_id *id)
 	pd->dst_addr_widths = PL330_DMA_BUSWIDTHS;
 	pd->directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
 	pd->residue_granularity = DMA_RESIDUE_GRANULARITY_SEGMENT;
+	pd->max_burst = ((pl330->quirks & PL330_QUIRK_BROKEN_NO_FLUSHP) ?
+			 1 : PL330_MAX_BURST);
 
 	ret = dma_async_device_register(pd);
 	if (ret) {
-- 
2.3.7
