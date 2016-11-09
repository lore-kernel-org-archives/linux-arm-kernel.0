From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed,  9 Nov 2016 15:58:21 -0700
Subject: [PATCH fpga 7/9] fpga zynq: Use the scatterlist interface
In-Reply-To: <1478732303-13718-1-git-send-email-jgunthorpe@obsidianresearch.com>
References: <1478732303-13718-1-git-send-email-jgunthorpe@obsidianresearch.com>
Message-ID: <1478732303-13718-8-git-send-email-jgunthorpe@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This allows the driver to avoid a high order coherent DMA allocation
and memory copy. With this patch it can DMA directly from the kernel
pages that the bitfile is stored in.

Since this is now a gather DMA operation the driver uses the ISR
to feed the chips DMA queue with each entry from the SGL.

Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
---
 drivers/fpga/zynq-fpga.c | 194 +++++++++++++++++++++++++++++++++++------------
 1 file changed, 146 insertions(+), 48 deletions(-)

diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
index ac2deae92dbd..559b4f2ab9f6 100644
--- a/drivers/fpga/zynq-fpga.c
+++ b/drivers/fpga/zynq-fpga.c
@@ -30,6 +30,7 @@
 #include <linux/pm.h>
 #include <linux/regmap.h>
 #include <linux/string.h>
+#include <linux/scatterlist.h>
 
 /* Offsets into SLCR regmap */
 
@@ -80,6 +81,7 @@
 
 /* FPGA init status */
 #define STATUS_DMA_Q_F			BIT(31)
+#define STATUS_DMA_Q_E			BIT(30)
 #define STATUS_PCFG_INIT_MASK		BIT(4)
 
 /* Interrupt Status/Mask Register Bit definitions */
@@ -98,12 +100,14 @@
 #define DMA_INVALID_ADDRESS		GENMASK(31, 0)
 /* Used to unlock the dev */
 #define UNLOCK_MASK			0x757bdf0d
-/* Timeout for DMA to complete */
-#define DMA_DONE_TIMEOUT		msecs_to_jiffies(1000)
 /* Timeout for polling reset bits */
 #define INIT_POLL_TIMEOUT		2500000
 /* Delay for polling reset bits */
 #define INIT_POLL_DELAY			20
+/* Signal this is the last DMA transfer, wait for the AXI and PCAP before
+ * interrupting
+ */
+#define DMA_SRC_LAST_TRANSFER		1
 
 /* Masks for controlling stuff in SLCR */
 /* Disable all Level shifters */
@@ -124,6 +128,11 @@ struct zynq_fpga_priv {
 	void __iomem *io_base;
 	struct regmap *slcr;
 
+	spinlock_t dma_lock;
+	unsigned int dma_elm;
+	unsigned int dma_nelms;
+	struct scatterlist *cur_sg;
+
 	struct completion dma_done;
 };
 
@@ -149,15 +158,81 @@ static inline void zynq_fpga_set_irq_mask(struct zynq_fpga_priv *priv,
 	zynq_fpga_write(priv, INT_MASK_OFFSET, ~enable);
 }
 
+/* Must be called with dma_lock held */
+static void zynq_step_dma(struct zynq_fpga_priv *priv)
+{
+	u32 addr;
+	u32 len;
+	bool first;
+
+	first = priv->dma_elm == 0;
+	while (priv->cur_sg) {
+		/* Feed the DMA queue until it is full. */
+		if (zynq_fpga_read(priv, STATUS_OFFSET) & STATUS_DMA_Q_F)
+			break;
+
+		addr = sg_dma_address(priv->cur_sg);
+		len = sg_dma_len(priv->cur_sg);
+		if (priv->dma_elm + 1 == priv->dma_nelms) {
+			/* The last transfer waits for the PCAP to finish too,
+			 * notice this also changes the irq_mask to ignore
+			 * IXR_DMA_DONE_MASK which ensures we do not trigger
+			 * the completion too early.
+			 */
+			addr |= DMA_SRC_LAST_TRANSFER;
+			priv->cur_sg = NULL;
+		} else {
+			priv->cur_sg = sg_next(priv->cur_sg);
+			priv->dma_elm++;
+		}
+
+		zynq_fpga_write(priv, DMA_SRC_ADDR_OFFSET, addr);
+		zynq_fpga_write(priv, DMA_DST_ADDR_OFFSET, DMA_INVALID_ADDRESS);
+		zynq_fpga_write(priv, DMA_SRC_LEN_OFFSET, len / 4);
+		zynq_fpga_write(priv, DMA_DEST_LEN_OFFSET, 0);
+	}
+
+	/* Once the first transfer is queued we can turn on the ISR, future
+	 * calls to zynq_step_dma will happen from the ISR context. The
+	 * dma_lock spinlock guarentees this handover is done coherently, the
+	 * ISR enable is put at the end to avoid another CPU spinning in the
+	 * ISR on this lock.
+	 */
+	if (first && priv->cur_sg) {
+		zynq_fpga_set_irq_mask(priv, IXR_DMA_DONE_MASK |
+						 IXR_ERROR_FLAGS_MASK);
+	} else if (!priv->cur_sg) {
+		/* The last transfer changes to DMA & PCAP mode since we do
+		 * not want to continue until everything has bee flushed into
+		 * the PCAP.
+		 */
+		zynq_fpga_set_irq_mask(priv, IXR_D_P_DONE_MASK |
+						 IXR_ERROR_FLAGS_MASK);
+	}
+}
+
 static irqreturn_t zynq_fpga_isr(int irq, void *data)
 {
 	struct zynq_fpga_priv *priv = data;
+	u32 intr_status;
 
-	/* disable DMA and error IRQs */
-	zynq_fpga_set_irq_mask(priv, 0);
+	/* If anything other than DMA completion is reported stop and hand
+	 * control back to zynq_fpga_ops_write, something went wrong,
+	 * otherwise progress the DMA.
+	 */
+	spin_lock(&priv->dma_lock);
+	intr_status = zynq_fpga_read(priv, INT_STS_OFFSET);
+	if ((intr_status & IXR_ERROR_FLAGS_MASK) == 0 &&
+	    (intr_status & IXR_DMA_DONE_MASK) && priv->cur_sg) {
+		zynq_fpga_write(priv, INT_STS_OFFSET, IXR_DMA_DONE_MASK);
+		zynq_step_dma(priv);
+		spin_unlock(&priv->dma_lock);
+		return IRQ_HANDLED;
+	}
+	spin_unlock(&priv->dma_lock);
 
+	zynq_fpga_set_irq_mask(priv, 0);
 	complete(&priv->dma_done);
-
 	return IRQ_HANDLED;
 }
 
@@ -165,31 +240,47 @@ static irqreturn_t zynq_fpga_isr(int irq, void *data)
  * the correct byte order. The input is a Xilinx .bin file with every 32 bit
  * quantity swapped.
  */
-static bool zynq_fpga_has_sync(const char *buf, size_t count)
+static bool zynq_fpga_has_sync(struct sg_table *sgt)
 {
-	for (; count > 4; buf += 4, count -= 4)
-		if (buf[0] == 0x66 && buf[1] == 0x55 && buf[2] == 0x99 &&
-		    buf[3] == 0xaa)
-			return true;
+	struct sg_mapping_iter miter;
+	const u8 *buf, *end;
+
+	sg_miter_start(&miter, sgt->sgl, sgt->nents, SG_MITER_FROM_SG);
+
+	while (sg_miter_next(&miter)) {
+		end = miter.addr + miter.length;
+		for (buf = miter.addr; buf < end; buf += 4) {
+			if (buf[0] == 0x66 && buf[1] == 0x55 &&
+			    buf[2] == 0x99 && buf[3] == 0xaa) {
+				sg_miter_stop(&miter);
+				return true;
+			}
+		}
+	}
+
+	sg_miter_stop(&miter);
 	return false;
 }
 
 static int zynq_fpga_ops_write_init(struct fpga_manager *mgr, u32 flags,
-				    const char *buf, size_t count)
+				    struct sg_table *sgt)
 {
 	struct zynq_fpga_priv *priv;
+	struct scatterlist *sg;
 	u32 ctrl, status;
-	int err;
+	int err, i;
 
 	priv = mgr->priv;
 
-	/* The hardware can only DMA multiples of 4 bytes, and we need at
-	 * least the sync word and something else to do anything.
+	/* The hardware can only DMA multiples of 4 bytes, and it requires the
+	 * starting address to be aligned to 64 bits (UG585 pg 212).
 	 */
-	if (count <= 4 || (count % 4) != 0) {
-		dev_err(&mgr->dev,
-			"Invalid bitstream size, must be multiples of 4 bytes\n");
-		return -EINVAL;
+	for_each_sg(sgt->sgl, sg, sgt->nents, i) {
+		if ((sg->offset % 8) != 0 || (sg->length % 4) != 0) {
+			dev_err(&mgr->dev,
+			    "Invalid bitstream size, chunks must be aligned\n");
+			return -EINVAL;
+		}
 	}
 
 	err = clk_enable(priv->clk);
@@ -198,7 +289,7 @@ static int zynq_fpga_ops_write_init(struct fpga_manager *mgr, u32 flags,
 
 	/* don't globally reset PL if we're doing partial reconfig */
 	if (!(flags & FPGA_MGR_PARTIAL_RECONFIG)) {
-		if (!zynq_fpga_has_sync(buf, count)) {
+		if (!zynq_fpga_has_sync(sgt)) {
 			dev_err(&mgr->dev,
 				"Invalid bitstream, could not find a sync word. Bitstream must be a byte swaped .bin file\n");
 			err = -EINVAL;
@@ -274,10 +365,11 @@ static int zynq_fpga_ops_write_init(struct fpga_manager *mgr, u32 flags,
 	zynq_fpga_write(priv, CTRL_OFFSET,
 			(CTRL_PCAP_PR_MASK | CTRL_PCAP_MODE_MASK | ctrl));
 
-	/* check that we have room in the command queue */
+	/* We expect that the command queue is empty right now. */
 	status = zynq_fpga_read(priv, STATUS_OFFSET);
-	if (status & STATUS_DMA_Q_F) {
-		dev_err(&mgr->dev, "DMA command queue full\n");
+	if ((status & STATUS_DMA_Q_F) ||
+	    (status & STATUS_DMA_Q_E) != STATUS_DMA_Q_E) {
+		dev_err(&mgr->dev, "DMA command queue not right\n");
 		err = -EBUSY;
 		goto out_err;
 	}
@@ -296,49 +388,50 @@ out_err:
 	return err;
 }
 
-static int zynq_fpga_ops_write(struct fpga_manager *mgr,
-			       const char *buf, size_t count)
+static int zynq_fpga_ops_write(struct fpga_manager *mgr, struct sg_table *sgt)
 {
 	struct zynq_fpga_priv *priv;
 	const char *why;
 	int err;
-	char *kbuf;
-	dma_addr_t dma_addr;
 	u32 intr_status;
+	unsigned long timeout;
+	unsigned long flags;
 
 	priv = mgr->priv;
 
-	kbuf =
-	    dma_alloc_coherent(mgr->dev.parent, count, &dma_addr, GFP_KERNEL);
-	if (!kbuf)
+	priv->dma_nelms =
+	    dma_map_sg(mgr->dev.parent, sgt->sgl, sgt->nents, DMA_TO_DEVICE);
+	if (priv->dma_nelms == 0)
 		return -ENOMEM;
 
-	memcpy(kbuf, buf, count);
-
 	/* enable clock */
 	err = clk_enable(priv->clk);
 	if (err)
 		goto out_free;
 
 	zynq_fpga_write(priv, INT_STS_OFFSET, IXR_ALL_MASK);
-
 	reinit_completion(&priv->dma_done);
 
-	/* enable DMA and error IRQs */
-	zynq_fpga_set_irq_mask(priv, IXR_D_P_DONE_MASK | IXR_ERROR_FLAGS_MASK);
+	/* zynq_step_dma will turn on interrupts */
+	spin_lock_irqsave(&priv->dma_lock, flags);
+	priv->dma_elm = 0;
+	priv->cur_sg = sgt->sgl;
+	zynq_step_dma(priv);
+	spin_unlock_irqrestore(&priv->dma_lock, flags);
 
-	/* the +1 in the src addr is used to hold off on DMA_DONE IRQ
-	 * until both AXI and PCAP are done ...
-	 */
-	zynq_fpga_write(priv, DMA_SRC_ADDR_OFFSET, (u32)(dma_addr) + 1);
-	zynq_fpga_write(priv, DMA_DST_ADDR_OFFSET, (u32)DMA_INVALID_ADDRESS);
-	zynq_fpga_write(priv, DMA_SRC_LEN_OFFSET, count / 4);
-	zynq_fpga_write(priv, DMA_DEST_LEN_OFFSET, 0);
+	timeout = wait_for_completion_timeout(&priv->dma_done,
+					      msecs_to_jiffies(5 * 1000));
 
-	wait_for_completion(&priv->dma_done);
+	zynq_fpga_set_irq_mask(priv, 0);
 
 	intr_status = zynq_fpga_read(priv, INT_STS_OFFSET);
-	zynq_fpga_write(priv, INT_STS_OFFSET, intr_status);
+	zynq_fpga_write(priv, INT_STS_OFFSET, IXR_ALL_MASK);
+
+	/* There doesn't seem to be a way to force cancel any DMA, so if
+	 * something went wrong we are relying on the hardware to have halted
+	 * the DMA before we get here, if there was we could use
+	 * wait_for_completion_interruptible too.
+	 */
 
 	if (intr_status & IXR_ERROR_FLAGS_MASK) {
 		why = "DMA reported error";
@@ -346,8 +439,12 @@ static int zynq_fpga_ops_write(struct fpga_manager *mgr,
 		goto out_report;
 	}
 
-	if (!((intr_status & IXR_D_P_DONE_MASK) == IXR_D_P_DONE_MASK)) {
-		why = "DMA did not complete";
+	if (priv->cur_sg ||
+	    !((intr_status & IXR_D_P_DONE_MASK) == IXR_D_P_DONE_MASK)) {
+		if (timeout == 0)
+			why = "DMA timed out";
+		else
+			why = "DMA did not complete";
 		err = -EIO;
 		goto out_report;
 	}
@@ -368,7 +465,7 @@ out_report:
 out_clk:
 	clk_disable(priv->clk);
 out_free:
-	dma_free_coherent(mgr->dev.parent, count, kbuf, dma_addr);
+	dma_unmap_sg(mgr->dev.parent, sgt->sgl, sgt->nents, DMA_TO_DEVICE);
 	return err;
 }
 
@@ -429,8 +526,8 @@ static enum fpga_mgr_states zynq_fpga_ops_state(struct fpga_manager *mgr)
 
 static const struct fpga_manager_ops zynq_fpga_ops = {
 	.state = zynq_fpga_ops_state,
-	.write_init = zynq_fpga_ops_write_init,
-	.write = zynq_fpga_ops_write,
+	.write_init_sg = zynq_fpga_ops_write_init,
+	.write_sg = zynq_fpga_ops_write,
 	.write_complete = zynq_fpga_ops_write_complete,
 };
 
@@ -444,6 +541,7 @@ static int zynq_fpga_probe(struct platform_device *pdev)
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
+	spin_lock_init(&priv->dma_lock);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	priv->io_base = devm_ioremap_resource(dev, res);
-- 
2.1.4
