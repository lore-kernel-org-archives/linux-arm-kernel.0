From: anurag.kumar.vulisha@xilinx.com (Anurag Kumar Vulisha)
Date: Wed, 5 Aug 2015 17:17:37 +0530
Subject: [PATCH] dmaengine: vdma: Add 64 bit addressing support to the driver
Message-ID: <1438775257-3511-1-git-send-email-anuragku@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the 64 bit addressing support to the vdma driver.

Signed-off-by: Anurag Kumar Vulisha <anuragku@xilinx.com>
---
 drivers/dma/Kconfig              |    2 +-
 drivers/dma/xilinx/xilinx_vdma.c |   36 ++++++++++++++++++++++++++++++------
 2 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index bda2cb0..a7cd0a8 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -398,7 +398,7 @@ config FSL_EDMA
 
 config XILINX_VDMA
 	tristate "Xilinx AXI VDMA Engine"
-	depends on (ARCH_ZYNQ || MICROBLAZE)
+	depends on (ARCH_ZYNQ || MICROBLAZE || ARM64)
 	select DMA_ENGINE
 	help
 	  Enable support for Xilinx AXI VDMA Soft IP.
diff --git a/drivers/dma/xilinx/xilinx_vdma.c b/drivers/dma/xilinx/xilinx_vdma.c
index d8434d4..3dcbd29 100644
--- a/drivers/dma/xilinx/xilinx_vdma.c
+++ b/drivers/dma/xilinx/xilinx_vdma.c
@@ -98,7 +98,11 @@
 #define XILINX_VDMA_FRMDLY_STRIDE_FRMDLY_SHIFT	24
 #define XILINX_VDMA_FRMDLY_STRIDE_STRIDE_SHIFT	0
 
+#if defined(CONFIG_PHYS_ADDR_T_64BIT)
+#define XILINX_VDMA_REG_START_ADDRESS(n)	(0x000c + 8 * (n))
+#else
 #define XILINX_VDMA_REG_START_ADDRESS(n)	(0x000c + 4 * (n))
+#endif
 
 /* HW specific definitions */
 #define XILINX_VDMA_MAX_CHANS_PER_DEVICE	0x2
@@ -143,16 +147,16 @@
  * @next_desc: Next Descriptor Pointer @0x00
  * @pad1: Reserved @0x04
  * @buf_addr: Buffer address @0x08
- * @pad2: Reserved @0x0C
- * @vsize: Vertical Size @0x10
- * @hsize: Horizontal Size @0x14
+ * @pad2: Reserved @0x10
+ * @vsize: Vertical Size @0x14
+ * @hsize: Horizontal Size @0x18
  * @stride: Number of bytes between the first
- *	    pixels of each horizontal line @0x18
+ *	    pixels of each horizontal line @0x1C
  */
 struct xilinx_vdma_desc_hw {
 	u32 next_desc;
 	u32 pad1;
-	u32 buf_addr;
+	u64 buf_addr;
 	u32 pad2;
 	u32 vsize;
 	u32 hsize;
@@ -272,6 +276,20 @@ static inline void vdma_desc_write(struct xilinx_vdma_chan *chan, u32 reg,
 	vdma_write(chan, chan->desc_offset + reg, value);
 }
 
+#if defined(CONFIG_PHYS_ADDR_T_64BIT)
+static inline void vdma_desc_write_64(struct xilinx_vdma_chan *chan, u32 reg,
+				 u64 value)
+{
+	/* Write the lsb 32 bits*/
+	writel(lower_32_bits(value),
+			chan->xdev->regs + chan->desc_offset + reg);
+
+	/* Write the msb 32 bits */
+	writel(upper_32_bits(value),
+			chan->xdev->regs + chan->desc_offset + reg + 4);
+}
+#endif
+
 static inline u32 vdma_ctrl_read(struct xilinx_vdma_chan *chan, u32 reg)
 {
 	return vdma_read(chan, chan->ctrl_offset + reg);
@@ -700,9 +718,15 @@ static void xilinx_vdma_start_transfer(struct xilinx_vdma_chan *chan)
 		int i = 0;
 
 		list_for_each_entry(segment, &desc->segments, node) {
-			vdma_desc_write(chan,
+#if defined(CONFIG_PHYS_ADDR_T_64BIT)
+			vdma_desc_write_64(chan,
 					XILINX_VDMA_REG_START_ADDRESS(i++),
 					segment->hw.buf_addr);
+#else
+			vdma_desc_write(chan,
+					XILINX_VDMA_REG_START_ADDRESS(i++),
+					(u32)segment->hw.buf_addr);
+#endif
 			last = segment;
 		}
 
-- 
1.7.4
