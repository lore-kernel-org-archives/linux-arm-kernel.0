From: appana.durga.rao@xilinx.com (Kedareswara rao Appana)
Date: Thu, 7 Dec 2017 10:51:05 +0530
Subject: [PATCH v7 4/6] dmaengine: xilinx_dma: Fix kernel doc warnings
In-Reply-To: <1512624067-13554-1-git-send-email-appanad@xilinx.com>
References: <1512624067-13554-1-git-send-email-appanad@xilinx.com>
Message-ID: <1512624067-13554-5-git-send-email-appanad@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the kernel doc warnings
in the driver.

Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
---
Changes for v7:
--> New patch.

 drivers/dma/xilinx/xilinx_dma.c | 37 ++++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index ab01306..eaa93fe 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -214,8 +214,8 @@ struct xilinx_vdma_desc_hw {
  * @next_desc_msb: MSB of Next Descriptor Pointer @0x04
  * @buf_addr: Buffer address @0x08
  * @buf_addr_msb: MSB of Buffer address @0x0C
- * @pad1: Reserved @0x10
- * @pad2: Reserved @0x14
+ * @mcdma_control: Control field for mcdma @0x10
+ * @vsize_stride: Vsize and Stride field for mcdma @0x14
  * @control: Control field @0x18
  * @status: Status field @0x1C
  * @app: APP Fields @0x20 - 0x30
@@ -235,11 +235,11 @@ struct xilinx_axidma_desc_hw {
 /**
  * struct xilinx_cdma_desc_hw - Hardware Descriptor
  * @next_desc: Next Descriptor Pointer @0x00
- * @next_descmsb: Next Descriptor Pointer MSB @0x04
+ * @next_desc_msb: Next Descriptor Pointer MSB @0x04
  * @src_addr: Source address @0x08
- * @src_addrmsb: Source address MSB @0x0C
+ * @src_addr_msb: Source address MSB @0x0C
  * @dest_addr: Destination address @0x10
- * @dest_addrmsb: Destination address MSB @0x14
+ * @dest_addr_msb: Destination address MSB @0x14
  * @control: Control field @0x18
  * @status: Status field @0x1C
  */
@@ -339,6 +339,7 @@ struct xilinx_dma_tx_descriptor {
  * @cyclic_seg_p: Physical allocated segments base for cyclic dma
  * @start_transfer: Differentiate b/w DMA IP's transfer
  * @stop_transfer: Differentiate b/w DMA IP's quiesce
+ * @tdest: TDEST value for mcdma
  */
 struct xilinx_dma_chan {
 	struct xilinx_dma_device *xdev;
@@ -378,11 +379,11 @@ struct xilinx_dma_chan {
 };
 
 /**
- * enum xdma_ip_type: DMA IP type.
+ * enum xdma_ip_type - DMA IP type.
  *
- * XDMA_TYPE_AXIDMA: Axi dma ip.
- * XDMA_TYPE_CDMA: Axi cdma ip.
- * XDMA_TYPE_VDMA: Axi vdma ip.
+ * @XDMA_TYPE_AXIDMA: Axi dma ip.
+ * @XDMA_TYPE_CDMA: Axi cdma ip.
+ * @XDMA_TYPE_VDMA: Axi vdma ip.
  *
  */
 enum xdma_ip_type {
@@ -994,6 +995,8 @@ static enum dma_status xilinx_dma_tx_status(struct dma_chan *dchan,
 /**
  * xilinx_dma_stop_transfer - Halt DMA channel
  * @chan: Driver specific DMA channel
+ *
+ * Return: '0' on success and failure value on error
  */
 static int xilinx_dma_stop_transfer(struct xilinx_dma_chan *chan)
 {
@@ -1010,6 +1013,8 @@ static int xilinx_dma_stop_transfer(struct xilinx_dma_chan *chan)
 /**
  * xilinx_cdma_stop_transfer - Wait for the current transfer to complete
  * @chan: Driver specific DMA channel
+ *
+ * Return: '0' on success and failure value on error
  */
 static int xilinx_cdma_stop_transfer(struct xilinx_dma_chan *chan)
 {
@@ -1825,11 +1830,14 @@ static struct dma_async_tx_descriptor *xilinx_dma_prep_slave_sg(
 
 /**
  * xilinx_dma_prep_dma_cyclic - prepare descriptors for a DMA_SLAVE transaction
- * @chan: DMA channel
- * @sgl: scatterlist to transfer to/from
- * @sg_len: number of entries in @scatterlist
+ * @dchan: DMA channel
+ * @buf_addr: Physical address of the buffer
+ * @buf_len: Total length of the cyclic buffers
+ * @period_len: length of individual cyclic buffer
  * @direction: DMA direction
  * @flags: transfer ack flags
+ *
+ * Return: Async transaction descriptor on success and NULL on failure
  */
 static struct dma_async_tx_descriptor *xilinx_dma_prep_dma_cyclic(
 	struct dma_chan *dchan, dma_addr_t buf_addr, size_t buf_len,
@@ -2013,7 +2021,9 @@ xilinx_dma_prep_interleaved(struct dma_chan *dchan,
 
 /**
  * xilinx_dma_terminate_all - Halt the channel and free descriptors
- * @chan: Driver specific DMA Channel pointer
+ * @dchan: Driver specific DMA Channel pointer
+ *
+ * Return: '0' always.
  */
 static int xilinx_dma_terminate_all(struct dma_chan *dchan)
 {
@@ -2328,6 +2338,7 @@ static void xdma_disable_allclks(struct xilinx_dma_device *xdev)
  *
  * @xdev: Driver specific device structure
  * @node: Device node
+ * @chan_id: DMA Channel id
  *
  * Return: '0' on success and failure value on error
  */
-- 
2.7.4
