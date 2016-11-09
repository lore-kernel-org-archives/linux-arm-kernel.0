From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed,  9 Nov 2016 15:58:16 -0700
Subject: [PATCH fpga 2/9] fpga zynq: Check the bitstream for validity
In-Reply-To: <1478732303-13718-1-git-send-email-jgunthorpe@obsidianresearch.com>
References: <1478732303-13718-1-git-send-email-jgunthorpe@obsidianresearch.com>
Message-ID: <1478732303-13718-3-git-send-email-jgunthorpe@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no sense in sending a bitstream we know will not work, and
with the variety of options for bitstream generation in Xilinx tools
it is not terribly clear or very well documented what the correct
input should be, especially since auto-detection was removed from this
driver.

All Zynq full configuration bitstreams must start with the sync word in
the correct byte order.

Zynq is also only able to DMA dword quantities, so bitstreams must be
a multiple of 4 bytes. This also fixes a DMA-past the end bug.

Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
---
 drivers/fpga/zynq-fpga.c | 40 +++++++++++++++++++++++++++++++---------
 1 file changed, 31 insertions(+), 9 deletions(-)

diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
index e72340ea7323..86f4377e2b52 100644
--- a/drivers/fpga/zynq-fpga.c
+++ b/drivers/fpga/zynq-fpga.c
@@ -175,6 +175,19 @@ static irqreturn_t zynq_fpga_isr(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+/* Sanity check the proposed bitstream. It must start with the sync word in
+ * the correct byte order. The input is a Xilinx .bin file with every 32 bit
+ * quantity swapped.
+ */
+static bool zynq_fpga_has_sync(const char *buf, size_t count)
+{
+	for (; count > 4; buf += 4, count -= 4)
+		if (buf[0] == 0x66 && buf[1] == 0x55 && buf[2] == 0x99 &&
+		    buf[3] == 0xaa)
+			return true;
+	return false;
+}
+
 static int zynq_fpga_ops_write_init(struct fpga_manager *mgr, u32 flags,
 				    const char *buf, size_t count)
 {
@@ -184,12 +197,28 @@ static int zynq_fpga_ops_write_init(struct fpga_manager *mgr, u32 flags,
 
 	priv = mgr->priv;
 
+	/* The hardware can only DMA multiples of 4 bytes, and we need at
+	 * least the sync word and something else to do anything.
+	 */
+	if (count <= 4 || (count % 4) != 0) {
+		dev_err(priv->dev,
+			"Invalid bitstream size, must be multiples of 4 bytes\n");
+		return -EINVAL;
+	}
+
 	err = clk_enable(priv->clk);
 	if (err)
 		return err;
 
 	/* don't globally reset PL if we're doing partial reconfig */
 	if (!(flags & FPGA_MGR_PARTIAL_RECONFIG)) {
+		if (!zynq_fpga_has_sync(buf, count)) {
+			dev_err(priv->dev,
+				"Invalid bitstream, could not find a sync word. Bitstream must be a byte swaped .bin file\n");
+			err = -EINVAL;
+			goto out_err;
+		}
+
 		/* assert AXI interface resets */
 		regmap_write(priv->slcr, SLCR_FPGA_RST_CTRL_OFFSET,
 			     FPGA_RST_ALL_MASK);
@@ -287,12 +316,9 @@ static int zynq_fpga_ops_write(struct fpga_manager *mgr,
 	struct zynq_fpga_priv *priv;
 	int err;
 	char *kbuf;
-	size_t in_count;
 	dma_addr_t dma_addr;
-	u32 transfer_length;
 	u32 intr_status;
 
-	in_count = count;
 	priv = mgr->priv;
 
 	kbuf = dma_alloc_coherent(priv->dev, count, &dma_addr, GFP_KERNEL);
@@ -318,11 +344,7 @@ static int zynq_fpga_ops_write(struct fpga_manager *mgr,
 	 */
 	zynq_fpga_write(priv, DMA_SRC_ADDR_OFFSET, (u32)(dma_addr) + 1);
 	zynq_fpga_write(priv, DMA_DST_ADDR_OFFSET, (u32)DMA_INVALID_ADDRESS);
-
-	/* convert #bytes to #words */
-	transfer_length = (count + 3) / 4;
-
-	zynq_fpga_write(priv, DMA_SRC_LEN_OFFSET, transfer_length);
+	zynq_fpga_write(priv, DMA_SRC_LEN_OFFSET, count / 4);
 	zynq_fpga_write(priv, DMA_DEST_LEN_OFFSET, 0);
 
 	wait_for_completion(&priv->dma_done);
@@ -338,7 +360,7 @@ static int zynq_fpga_ops_write(struct fpga_manager *mgr,
 	clk_disable(priv->clk);
 
 out_free:
-	dma_free_coherent(priv->dev, in_count, kbuf, dma_addr);
+	dma_free_coherent(priv->dev, count, kbuf, dma_addr);
 
 	return err;
 }
-- 
2.1.4
