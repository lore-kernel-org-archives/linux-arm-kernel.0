From: b32955@freescale.com (Huang Shijie)
Date: Mon, 8 Aug 2011 18:39:11 +0800
Subject: [PATCH] print_more_log
Message-ID: <mailman.53.1312799632.20020.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

print out the DMA register when timeout occur.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 drivers/dma/mxs-dma.c                  |   37 +++++++++++++++++++++++++++++++-
 drivers/mtd/nand/gpmi-nand/gpmi-nand.c |    2 +
 2 files changed, 38 insertions(+), 1 deletions(-)

diff --git a/drivers/dma/mxs-dma.c b/drivers/dma/mxs-dma.c
index 88aad4f..755cbfc 100644
--- a/drivers/dma/mxs-dma.c
+++ b/drivers/dma/mxs-dma.c
@@ -130,6 +130,7 @@ struct mxs_dma_engine {
 	struct mxs_dma_chan		mxs_chans[MXS_DMA_CHANNELS];
 };
 
+struct mxs_dma_chan *g_mxs_chan;
 static void mxs_dma_reset_chan(struct mxs_dma_chan *mxs_chan)
 {
 	struct mxs_dma_engine *mxs_dma = mxs_chan->mxs_dma;
@@ -239,6 +240,7 @@ static dma_cookie_t mxs_dma_tx_submit(struct dma_async_tx_descriptor *tx)
 	struct mxs_dma_chan *mxs_chan = to_mxs_dma_chan(tx->chan);
 
 	mxs_dma_enable_chan(mxs_chan);
+	g_mxs_chan = mxs_chan;
 
 	return mxs_dma_assign_cookie(mxs_chan);
 }
@@ -370,6 +372,7 @@ static void mxs_dma_free_chan_resources(struct dma_chan *chan)
 	clk_disable(mxs_dma->clk);
 }
 
+static int idx;
 static struct dma_async_tx_descriptor *mxs_dma_prep_slave_sg(
 		struct dma_chan *chan, struct scatterlist *sgl,
 		unsigned int sg_len, enum dma_data_direction direction,
@@ -381,7 +384,6 @@ static struct dma_async_tx_descriptor *mxs_dma_prep_slave_sg(
 	struct scatterlist *sg;
 	int i, j;
 	u32 *pio;
-	static int idx;
 
 	if (mxs_chan->status == DMA_IN_PROGRESS && !append)
 		return NULL;
@@ -606,6 +608,39 @@ err_out:
 	return ret;
 }
 
+
+void dump_dma_reg(void)
+{
+	int i;
+	u32 stat1;
+
+	struct mxs_dma_chan *mxs_chan = g_mxs_chan;
+	struct mxs_dma_engine *g_mxs_dma = mxs_chan->mxs_dma;
+	struct mxs_dma_ccw *ccw;
+
+	printk("------------------------DMA DUMP END ------------\n");
+	for (i = 0; i < 7; i++) {
+		stat1 = readl(g_mxs_dma->base + 0x10 * i);
+		printk("APBH REG :%x : %.8X\n", 0x10 * i, stat1);
+	}
+	for (i = 0; i < 7; i++) {
+		stat1 = readl(g_mxs_dma->base + 0x10 * i + 0x100);
+		printk("APBH REG :%x : %.8X\n", 0x10 * i + 0x100, stat1);
+	}
+
+	for (i = 0; i < idx; i++) {
+		int j;
+
+		ccw = &mxs_chan->ccw[i];
+		printk("[ %d ] : ME : %.8x, next : %.8x, bits : %.8x, bytes : %.8x, buf : %.8x\n",
+			i, mxs_chan->ccw_phys + sizeof(*ccw) * i,
+			ccw->next, ccw->bits, ccw->xfer_bytes, ccw->bufaddr);
+		for (j = 0; j < 3; j++)
+			printk("[ %d ] PIO[%d] : %.8x\n", i, j, ccw->pio_words[j]); 
+	}
+	printk("------------------------DMA DUMP END ------------\n");
+}
+
 static int __init mxs_dma_probe(struct platform_device *pdev)
 {
 	const struct platform_device_id *id_entry =
diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
index 1c2cbc5..3d6895b 100644
--- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
@@ -378,6 +378,7 @@ int start_dma_without_bch_irq(struct gpmi_nand_data *this,
 {
 	struct completion *dma_c = &this->dma_done;
 	int err;
+	extern void dump_dma_reg(void);
 
 	init_completion(dma_c);
 
@@ -391,6 +392,7 @@ int start_dma_without_bch_irq(struct gpmi_nand_data *this,
 	if (err) {
 		pr_info("DMA timeout, last DMA :%d\n", this->last_dma_type);
 		if (gpmi_debug & GPMI_DEBUG_CRAZY) {
+			dump_dma_reg();
 			gpmi_show_regs(this);
 			panic("-----------DMA FAILED------------------");
 		}
-- 
1.7.0.4


--------------030105050108080108040309--
