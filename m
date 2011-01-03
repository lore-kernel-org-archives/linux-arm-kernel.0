From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 03 Jan 2011 22:32:46 +0000
Subject: [PATCH 08/48] ARM: PL08x: fix sparse warnings
In-Reply-To: <20110103222943.GB4572@n2100.arm.linux.org.uk>
References: <20110103222943.GB4572@n2100.arm.linux.org.uk>
Message-ID: <E1PZsxK-0001OO-3y@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

drivers/dma/amba-pl08x.c:1895:40: warning: Unknown escape '%'
drivers/dma/amba-pl08x.c:1903:40: warning: Unknown escape '%'
drivers/dma/amba-pl08x.c:513:6: warning: symbol 'pl08x_choose_master_bus' was not declared. Should it be static?
drivers/dma/amba-pl08x.c:604:5: warning: symbol 'pl08x_fill_llis_for_desc' was not declared. Should it be static?
drivers/dma/amba-pl08x.c:1442:32: warning: symbol 'pl08x_prep_slave_sg' was not declared. Should it be static?

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 4ca1eb1..74fa5a0 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -510,7 +510,7 @@ static inline u32 pl08x_cctl_bits(u32 cctl, u8 srcwidth, u8 dstwidth,
  * this prefers the destination bus if both available
  * if fixed address on one bus the other will be chosen
  */
-void pl08x_choose_master_bus(struct pl08x_bus_data *src_bus,
+static void pl08x_choose_master_bus(struct pl08x_bus_data *src_bus,
 	struct pl08x_bus_data *dst_bus, struct pl08x_bus_data **mbus,
 	struct pl08x_bus_data **sbus, u32 cctl)
 {
@@ -545,7 +545,7 @@ void pl08x_choose_master_bus(struct pl08x_bus_data *src_bus,
  * Fills in one LLI for a certain transfer descriptor
  * and advance the counter
  */
-int pl08x_fill_lli_for_desc(struct pl08x_driver_data *pl08x,
+static int pl08x_fill_lli_for_desc(struct pl08x_driver_data *pl08x,
 			    struct pl08x_txd *txd, int num_llis, int len,
 			    u32 cctl, u32 *remainder)
 {
@@ -1439,7 +1439,7 @@ static struct dma_async_tx_descriptor *pl08x_prep_dma_memcpy(
 	return &txd->tx;
 }
 
-struct dma_async_tx_descriptor *pl08x_prep_slave_sg(
+static struct dma_async_tx_descriptor *pl08x_prep_slave_sg(
 		struct dma_chan *chan, struct scatterlist *sgl,
 		unsigned int sg_len, enum dma_data_direction direction,
 		unsigned long flags)
@@ -1890,7 +1890,7 @@ static int pl08x_debugfs_show(struct seq_file *s, void *data)
 	seq_printf(s, "CHANNEL:\tSTATE:\n");
 	seq_printf(s, "--------\t------\n");
 	list_for_each_entry(chan, &pl08x->memcpy.channels, chan.device_node) {
-		seq_printf(s, "%s\t\t\%s\n", chan->name,
+		seq_printf(s, "%s\t\t%s\n", chan->name,
 			   pl08x_state_str(chan->state));
 	}
 
@@ -1898,7 +1898,7 @@ static int pl08x_debugfs_show(struct seq_file *s, void *data)
 	seq_printf(s, "CHANNEL:\tSTATE:\n");
 	seq_printf(s, "--------\t------\n");
 	list_for_each_entry(chan, &pl08x->slave.channels, chan.device_node) {
-		seq_printf(s, "%s\t\t\%s\n", chan->name,
+		seq_printf(s, "%s\t\t%s\n", chan->name,
 			   pl08x_state_str(chan->state));
 	}
 
-- 
1.6.2.5
