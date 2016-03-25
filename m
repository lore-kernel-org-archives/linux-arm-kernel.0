From: appana.durga.rao@xilinx.com (Kedareswara rao Appana)
Date: Fri, 25 Mar 2016 14:46:18 +0530
Subject: [PATCH v3 1/2] dmaengine: vdma: Add 64 bit addressing support to the
 driver
Message-ID: <1458897378-3852-1-git-send-email-appanad@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This VDMA  is a soft ip, which can be programmed to support
32 bit addressing or greater than 32 bit addressing.

When the VDMA ip is configured for 32 bit address space
the buffer address is specified by a single register
(0x5C for MM2S and 0xAC for S2MM channel).

When the  VDMA core is configured for an address space greater
than 32 then each buffer address is specified by a combination of
two registers.

The first register specifies the LSB 32 bits of address,
while the next register specifies the MSB 32 bits of address.

For example, 5Ch will specify the LSB 32 bits while 60h will
specify the MSB 32 bits of the first start address.
So we need to program two registers at a time.

This patch adds the 64 bit addressing support to the vdma driver.

Signed-off-by: Anurag Kumar Vulisha <anuragku@xilinx.com>
Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
---
Changes for v3:
--> Improved commit message as suggested by vinod.
--> removed unnecessary braces for single line if conditions.
Changes for v2:
---> Added dma-ranges property in device tree as suggested by Arnd Bergmann.
---> Added device tree property(xlnx,addrwidth) for an identification of whether
     the IP block itself is configured in 64-bit or 32-bit mode as suggested by
     Laurent Pinchart.
---> Modified the driver code based on the xlnx,addrwidth.

 .../devicetree/bindings/dma/xilinx/xilinx_vdma.txt |  4 ++
 drivers/dma/Kconfig                                |  2 +-
 drivers/dma/xilinx/xilinx_vdma.c                   | 73 +++++++++++++++++++---
 3 files changed, 70 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt b/Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt
index e4c4d47..a86737c 100644
--- a/Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt
+++ b/Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt
@@ -8,6 +8,8 @@ Required properties:
 - #dma-cells: Should be <1>, see "dmas" property below
 - reg: Should contain VDMA registers location and length.
 - xlnx,num-fstores: Should be the number of framebuffers as configured in h/w.
+- xlnx,addrwidth: Should be the vdma addressing size in bits(ex: 32 bits).
+- dma-ranges: Should be as the following <dma_addr cpu_addr max_len>.
 - dma-channel child node: Should have at least one channel and can have up to
 	two channels per device. This node specifies the properties of each
 	DMA channel (see child node properties below).
@@ -41,8 +43,10 @@ axi_vdma_0: axivdma at 40030000 {
 	compatible = "xlnx,axi-vdma-1.00.a";
 	#dma_cells = <1>;
 	reg = < 0x40030000 0x10000 >;
+	dma-ranges = <0x00000000 0x00000000 0x40000000>;
 	xlnx,num-fstores = <0x8>;
 	xlnx,flush-fsync = <0x1>;
+	xlnx,addrwidth = <0x20>;
 	dma-channel at 40030000 {
 		compatible = "xlnx,axi-vdma-mm2s-channel";
 		interrupts = < 0 54 4 >;
diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index d96d87c..2846753 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -507,7 +507,7 @@ config XGENE_DMA
 
 config XILINX_VDMA
 	tristate "Xilinx AXI VDMA Engine"
-	depends on (ARCH_ZYNQ || MICROBLAZE)
+	depends on (ARCH_ZYNQ || MICROBLAZE || ARM64)
 	select DMA_ENGINE
 	help
 	  Enable support for Xilinx AXI VDMA Soft IP.
diff --git a/drivers/dma/xilinx/xilinx_vdma.c b/drivers/dma/xilinx/xilinx_vdma.c
index 0ee0321..abe915c 100644
--- a/drivers/dma/xilinx/xilinx_vdma.c
+++ b/drivers/dma/xilinx/xilinx_vdma.c
@@ -100,6 +100,7 @@
 #define XILINX_VDMA_FRMDLY_STRIDE_STRIDE_SHIFT	0
 
 #define XILINX_VDMA_REG_START_ADDRESS(n)	(0x000c + 4 * (n))
+#define XILINX_VDMA_REG_START_ADDRESS_64(n)	(0x000c + 8 * (n))
 
 /* HW specific definitions */
 #define XILINX_VDMA_MAX_CHANS_PER_DEVICE	0x2
@@ -144,7 +145,7 @@
  * @next_desc: Next Descriptor Pointer @0x00
  * @pad1: Reserved @0x04
  * @buf_addr: Buffer address @0x08
- * @pad2: Reserved @0x0C
+ * @buf_addr_msb: MSB of Buffer address @0x0C
  * @vsize: Vertical Size @0x10
  * @hsize: Horizontal Size @0x14
  * @stride: Number of bytes between the first
@@ -154,7 +155,7 @@ struct xilinx_vdma_desc_hw {
 	u32 next_desc;
 	u32 pad1;
 	u32 buf_addr;
-	u32 pad2;
+	u32 buf_addr_msb;
 	u32 vsize;
 	u32 hsize;
 	u32 stride;
@@ -207,6 +208,7 @@ struct xilinx_vdma_tx_descriptor {
  * @config: Device configuration info
  * @flush_on_fsync: Flush on Frame sync
  * @desc_pendingcount: Descriptor pending count
+ * @ext_addr: Indicates 64 bit addressing is supported by dma channel
  */
 struct xilinx_vdma_chan {
 	struct xilinx_vdma_device *xdev;
@@ -230,6 +232,7 @@ struct xilinx_vdma_chan {
 	struct xilinx_vdma_config config;
 	bool flush_on_fsync;
 	u32 desc_pendingcount;
+	bool ext_addr;
 };
 
 /**
@@ -240,6 +243,7 @@ struct xilinx_vdma_chan {
  * @chan: Driver specific VDMA channel
  * @has_sg: Specifies whether Scatter-Gather is present or not
  * @flush_on_fsync: Flush on frame sync
+ * @ext_addr: Indicates 64 bit addressing is supported by dma device
  */
 struct xilinx_vdma_device {
 	void __iomem *regs;
@@ -248,6 +252,7 @@ struct xilinx_vdma_device {
 	struct xilinx_vdma_chan *chan[XILINX_VDMA_MAX_CHANS_PER_DEVICE];
 	bool has_sg;
 	u32 flush_on_fsync;
+	bool ext_addr;
 };
 
 /* Macros */
@@ -299,6 +304,27 @@ static inline void vdma_ctrl_set(struct xilinx_vdma_chan *chan, u32 reg,
 	vdma_ctrl_write(chan, reg, vdma_ctrl_read(chan, reg) | set);
 }
 
+/**
+ * vdma_desc_write_64 - 64-bit descriptor write
+ * @chan: Driver specific VDMA channel
+ * @reg: Register to write
+ * @value_lsb: lower address of the descriptor.
+ * @value_msb: upper address of the descriptor.
+ *
+ * Since vdma driver is trying to write to a register offset which is not a
+ * multiple of 64 bits(ex : 0x5c), we are writing as two separate 32 bits
+ * instead of a single 64 bit register write.
+ */
+static inline void vdma_desc_write_64(struct xilinx_vdma_chan *chan, u32 reg,
+				      u32 value_lsb, u32 value_msb)
+{
+	/* Write the lsb 32 bits*/
+	writel(value_lsb, chan->xdev->regs + chan->desc_offset + reg);
+
+	/* Write the msb 32 bits */
+	writel(value_msb, chan->xdev->regs + chan->desc_offset + reg + 4);
+}
+
 /* -----------------------------------------------------------------------------
  * Descriptors and segments alloc and free
  */
@@ -693,9 +719,16 @@ static void xilinx_vdma_start_transfer(struct xilinx_vdma_chan *chan)
 		list_for_each_entry(desc, &chan->pending_list, node) {
 			segment = list_first_entry(&desc->segments,
 					   struct xilinx_vdma_tx_segment, node);
-			vdma_desc_write(chan,
+			if (chan->ext_addr)
+				vdma_desc_write_64(chan,
+					XILINX_VDMA_REG_START_ADDRESS_64(i++),
+					segment->hw.buf_addr,
+					segment->hw.buf_addr_msb);
+			else
+				vdma_desc_write(chan,
 					XILINX_VDMA_REG_START_ADDRESS(i++),
 					segment->hw.buf_addr);
+
 			last = segment;
 		}
 
@@ -987,10 +1020,21 @@ xilinx_vdma_dma_prep_interleaved(struct dma_chan *dchan,
 	hw->stride |= chan->config.frm_dly <<
 			XILINX_VDMA_FRMDLY_STRIDE_FRMDLY_SHIFT;
 
-	if (xt->dir != DMA_MEM_TO_DEV)
-		hw->buf_addr = xt->dst_start;
-	else
-		hw->buf_addr = xt->src_start;
+	if (xt->dir != DMA_MEM_TO_DEV) {
+		if (chan->ext_addr) {
+			hw->buf_addr = lower_32_bits(xt->dst_start);
+			hw->buf_addr_msb = upper_32_bits(xt->dst_start);
+		} else {
+			hw->buf_addr = xt->dst_start;
+		}
+	} else {
+		if (chan->ext_addr) {
+			hw->buf_addr = lower_32_bits(xt->src_start);
+			hw->buf_addr_msb = upper_32_bits(xt->src_start);
+		} else {
+			hw->buf_addr = xt->src_start;
+		}
+	}
 
 	/* Insert the segment into the descriptor segments list. */
 	list_add_tail(&segment->node, &desc->segments);
@@ -1140,6 +1184,7 @@ static int xilinx_vdma_chan_probe(struct xilinx_vdma_device *xdev,
 	chan->xdev = xdev;
 	chan->has_sg = xdev->has_sg;
 	chan->desc_pendingcount = 0x0;
+	chan->ext_addr = xdev->ext_addr;
 
 	spin_lock_init(&chan->lock);
 	INIT_LIST_HEAD(&chan->pending_list);
@@ -1254,7 +1299,7 @@ static int xilinx_vdma_probe(struct platform_device *pdev)
 	struct xilinx_vdma_device *xdev;
 	struct device_node *child;
 	struct resource *io;
-	u32 num_frames;
+	u32 num_frames, addr_width;
 	int i, err;
 
 	/* Allocate and initialize the DMA engine structure */
@@ -1284,6 +1329,18 @@ static int xilinx_vdma_probe(struct platform_device *pdev)
 	if (err < 0)
 		dev_warn(xdev->dev, "missing xlnx,flush-fsync property\n");
 
+	err = of_property_read_u32(node, "xlnx,addrwidth", &addr_width);
+	if (err < 0)
+		dev_warn(xdev->dev, "missing xlnx,addrwidth property\n");
+
+	if (addr_width > 32)
+		xdev->ext_addr = true;
+	else
+		xdev->ext_addr = false;
+
+	/* Set the dma mask bits */
+	dma_set_mask(xdev->dev, DMA_BIT_MASK(addr_width));
+
 	/* Initialize the DMA engine */
 	xdev->common.dev = &pdev->dev;
 
-- 
2.1.2
