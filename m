From: appana.durga.rao@xilinx.com (Kedareswara rao Appana)
Date: Wed, 18 May 2016 13:17:32 +0530
Subject: [PATCH v2 3/4] dmaengine: vdma: Add 64 bit addressing support for the
 axi dma
In-Reply-To: <1463557653-1687-1-git-send-email-appanad@xilinx.com>
References: <1463557653-1687-1-git-send-email-appanad@xilinx.com>
Message-ID: <1463557653-1687-4-git-send-email-appanad@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The AXI DMA is a soft ip, which can be programmed to support
32 bit addressing or greater than 32 bit addressing.

When the AXI DMA ip is configured for 32 bit address space
in simple dma mode the buffer address is specified by a single register
(18h for MM2S channel and 48h for S2MM channel). When configured in SG mode
The current descriptor and tail descriptor are specified by a single
Register(08h for curdesc 10h for tail desc for MM2S channel and 38h for
Curdesc and 40h for tail desc for S2MM).

When the  AXI DMA core is configured for an address space greater
than 32 then each buffer address or descriptor address is specified by
a combination of two registers.

The first register specifies the LSB 32 bits of address,
while the next register specifies the MSB 32 bits of address.

For example, 48h will specify the LSB 32 bits while 4Ch will
specify the MSB 32 bits of the first start address.
So we need to program two registers at a time.

This patch adds the 64 bit addressing support for the axidma
IP in the driver.

Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
---
Changes for v2:
--> New patch.

 drivers/dma/xilinx/xilinx_vdma.c | 79 ++++++++++++++++++++++++++++++----------
 1 file changed, 60 insertions(+), 19 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_vdma.c b/drivers/dma/xilinx/xilinx_vdma.c
index 0f5b38a..9c15451 100644
--- a/drivers/dma/xilinx/xilinx_vdma.c
+++ b/drivers/dma/xilinx/xilinx_vdma.c
@@ -45,6 +45,7 @@
 #include <linux/of_irq.h>
 #include <linux/slab.h>
 #include <linux/clk.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
 
 #include "../dmaengine.h"
 
@@ -195,22 +196,22 @@ struct xilinx_vdma_desc_hw {
 /**
  * struct xilinx_axidma_desc_hw - Hardware Descriptor for AXI DMA
  * @next_desc: Next Descriptor Pointer @0x00
- * @pad1: Reserved @0x04
+ * @next_desc_msb: MSB of Next Descriptor Pointer @0x04
  * @buf_addr: Buffer address @0x08
- * @pad2: Reserved @0x0C
- * @pad3: Reserved @0x10
- * @pad4: Reserved @0x14
+ * @buf_addr_msb: MSB of Buffer address @0x0C
+ * @pad1: Reserved @0x10
+ * @pad2: Reserved @0x14
  * @control: Control field @0x18
  * @status: Status field @0x1C
  * @app: APP Fields @0x20 - 0x30
  */
 struct xilinx_axidma_desc_hw {
 	u32 next_desc;
-	u32 pad1;
+	u32 next_desc_msb;
 	u32 buf_addr;
+	u32 buf_addr_msb;
+	u32 pad1;
 	u32 pad2;
-	u32 pad3;
-	u32 pad4;
 	u32 control;
 	u32 status;
 	u32 app[XILINX_DMA_NUM_APP_WORDS];
@@ -461,6 +462,11 @@ static inline void vdma_desc_write_64(struct xilinx_dma_chan *chan, u32 reg,
 	writel(value_msb, chan->xdev->regs + chan->desc_offset + reg + 4);
 }
 
+static inline void dma_writeq(struct xilinx_dma_chan *chan, u32 reg, u64 value)
+{
+	lo_hi_writeq(value, chan->xdev->regs + chan->ctrl_offset + reg);
+}
+
 /* -----------------------------------------------------------------------------
  * Descriptors and segments alloc and free
  */
@@ -1189,9 +1195,14 @@ static void xilinx_dma_start_transfer(struct xilinx_dma_chan *chan)
 		dma_ctrl_write(chan, XILINX_DMA_REG_DMACR, reg);
 	}
 
-	if (chan->has_sg)
-		dma_ctrl_write(chan, XILINX_DMA_REG_CURDESC,
-			       head_desc->async_tx.phys);
+	if (chan->has_sg) {
+		if (chan->ext_addr)
+			dma_writeq(chan, XILINX_DMA_REG_CURDESC,
+				   head_desc->async_tx.phys);
+		else
+			dma_ctrl_write(chan, XILINX_DMA_REG_CURDESC,
+				       head_desc->async_tx.phys);
+	}
 
 	xilinx_dma_start(chan);
 
@@ -1200,12 +1211,21 @@ static void xilinx_dma_start_transfer(struct xilinx_dma_chan *chan)
 
 	/* Start the transfer */
 	if (chan->has_sg) {
-		if (chan->cyclic)
-			dma_ctrl_write(chan, XILINX_DMA_REG_TAILDESC,
-				       chan->cyclic_seg_v->phys);
-		else
-			dma_ctrl_write(chan, XILINX_DMA_REG_TAILDESC,
-				       tail_segment->phys);
+		if (chan->cyclic) {
+			if (chan->ext_addr)
+				dma_writeq(chan, XILINX_DMA_REG_TAILDESC,
+					   chan->cyclic_seg_v->phys);
+			else
+				dma_ctrl_write(chan, XILINX_DMA_REG_TAILDESC,
+					       chan->cyclic_seg_v->phys);
+		} else {
+			if (chan->ext_addr)
+				dma_writeq(chan, XILINX_DMA_REG_TAILDESC,
+					   tail_segment->phys);
+			else
+				dma_ctrl_write(chan, XILINX_DMA_REG_TAILDESC,
+					       tail_segment->phys);
+		}
 	} else {
 		struct xilinx_axidma_tx_segment *segment;
 		struct xilinx_axidma_desc_hw *hw;
@@ -1215,7 +1235,12 @@ static void xilinx_dma_start_transfer(struct xilinx_dma_chan *chan)
 					   node);
 		hw = &segment->hw;
 
-		dma_ctrl_write(chan, XILINX_DMA_REG_SRCDSTADDR, hw->buf_addr);
+		if (chan->ext_addr)
+			dma_writeq(chan, XILINX_DMA_REG_SRCDSTADDR,
+				   hw->buf_addr);
+		else
+			dma_ctrl_write(chan, XILINX_DMA_REG_SRCDSTADDR,
+				       hw->buf_addr);
 
 		/* Start the transfer */
 		dma_ctrl_write(chan, XILINX_DMA_REG_BTT,
@@ -1679,7 +1704,15 @@ static struct dma_async_tx_descriptor *xilinx_dma_prep_slave_sg(
 			hw = &segment->hw;
 
 			/* Fill in the descriptor */
-			hw->buf_addr = sg_dma_address(sg) + sg_used;
+			if (chan->ext_addr) {
+				hw->buf_addr = lower_32_bits(sg_dma_address(sg)
+					       + sg_used);
+				hw->buf_addr_msb =
+						upper_32_bits(sg_dma_address(sg)
+						+ sg_used);
+			} else {
+				hw->buf_addr = sg_dma_address(sg) + sg_used;
+			}
 
 			hw->control = copy;
 
@@ -1777,7 +1810,15 @@ static struct dma_async_tx_descriptor *xilinx_dma_prep_dma_cyclic(
 			copy = min_t(size_t, period_len - sg_used,
 				     XILINX_DMA_MAX_TRANS_LEN);
 			hw = &segment->hw;
-			hw->buf_addr = buf_addr + sg_used + (period_len * i);
+			if (chan->ext_addr) {
+				hw->buf_addr = lower_32_bits(buf_addr +
+						sg_used + (period_len * i));
+				hw->buf_addr_msb = upper_32_bits(buf_addr +
+						sg_used + (period_len * i));
+			} else {
+				hw->buf_addr = buf_addr + sg_used +
+					       (period_len * i);
+			}
 			hw->control = copy;
 
 			if (prev)
-- 
2.1.2
