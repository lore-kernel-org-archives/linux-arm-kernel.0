From: shawn.lin@rock-chips.com (Shawn Lin)
Date: Thu, 15 Oct 2015 09:36:04 +0800
Subject: [PATCH v6 06/10] DMA: dmaengine: expose max burst capability to
 clients
In-Reply-To: <1444872865-2169-1-git-send-email-shawn.lin@rock-chips.com>
References: <1444872865-2169-1-git-send-email-shawn.lin@rock-chips.com>
Message-ID: <1444872964-2425-1-git-send-email-shawn.lin@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add max_burst to dma_get_slave_caps for clients
to get the burst capability of slave dma controller.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

Changes in v6:
- remove expose quirk and add dma max_burst caps for clients

Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None
Changes in v1: None

 drivers/dma/dmaengine.c   | 1 +
 include/linux/dmaengine.h | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 3ecec14..1ccf64b 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -492,6 +492,7 @@ int dma_get_slave_caps(struct dma_chan *chan, struct dma_slave_caps *caps)
 	caps->src_addr_widths = device->src_addr_widths;
 	caps->dst_addr_widths = device->dst_addr_widths;
 	caps->directions = device->directions;
+	caps->max_burst = device->max_burst;
 	caps->residue_granularity = device->residue_granularity;
 
 	/*
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 7ea9184..b6bc79e 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -401,6 +401,7 @@ enum dma_residue_granularity {
  * 	since the enum dma_transfer_direction is not defined as bits for each
  * 	type of direction, the dma controller should fill (1 << <TYPE>) and same
  * 	should be checked by controller as well
+ * @max_burst: max burst capability per-transfer
  * @cmd_pause: true, if pause and thereby resume is supported
  * @cmd_terminate: true, if terminate cmd is supported
  * @residue_granularity: granularity of the reported transfer residue
@@ -411,6 +412,7 @@ struct dma_slave_caps {
 	u32 src_addr_widths;
 	u32 dst_addr_widths;
 	u32 directions;
+	u32 max_burst;
 	bool cmd_pause;
 	bool cmd_terminate;
 	enum dma_residue_granularity residue_granularity;
@@ -627,6 +629,7 @@ enum dmaengine_alignment {
  * 	the enum dma_transfer_direction is not defined as bits for
  * 	each type of direction, the dma controller should fill (1 <<
  * 	<TYPE>) and same should be checked by controller as well
+ * @max_burst: max burst capability per-transfer
  * @residue_granularity: granularity of the transfer residue reported
  *	by tx_status
  * @device_alloc_chan_resources: allocate resources and return the
@@ -680,6 +683,7 @@ struct dma_device {
 	u32 src_addr_widths;
 	u32 dst_addr_widths;
 	u32 directions;
+	u32 max_burst;
 	enum dma_residue_granularity residue_granularity;
 
 	int (*device_alloc_chan_resources)(struct dma_chan *chan);
-- 
2.3.7
