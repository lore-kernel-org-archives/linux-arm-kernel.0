From: tpiepho@gmail.com (Trent Piepho)
Date: Tue,  2 Apr 2013 05:19:46 -0700
Subject: [PATCH V2 03/12] spi/mxs: Change flag arguments in txrx functions to
 bit flags
In-Reply-To: <1364905195-24286-1-git-send-email-tpiepho@gmail.com>
References: <1364905195-24286-1-git-send-email-tpiepho@gmail.com>
Message-ID: <1364905195-24286-3-git-send-email-tpiepho@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are three flag arguments to the PIO and DMA txrx functions.  Two
are passed as pointers to integers, even though they are input only
and not modified, which makes no sense to do.  The third is passed as
an integer.

The compiler must use an argument register or stack variable for each
flag this way.  By using bitflags in a single flag argument more
efficient and smaller code is produced since all the flags can fit in
a single register.  And all the flag arguments get cumbersome,
especially when more are added for things like GPIO chipselects.

The "first" flag is never used, so can just be deleted.

The "last" flag is renamed to DEASSERT_CS, since that's really what it
does.  The spi_transfer cs_change flag means that CS might be
de-asserted on a transfer which is not last and not de-assert on the
last transfer, so it is not which transfer is the last we need to know
but rather the transfers which after which CS should be de-asserted.

This also extends the driver to not ignore cs_change when setting the
DEASSERT_CS nee "last" flag.

Signed-off-by: Trent Piepho <tpiepho@gmail.com>
Cc: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/spi/spi-mxs.c |   55 ++++++++++++++++++++++++++++---------------------
 1 file changed, 31 insertions(+), 24 deletions(-)

diff --git a/drivers/spi/spi-mxs.c b/drivers/spi/spi-mxs.c
index 7eb4bc9..3064304 100644
--- a/drivers/spi/spi-mxs.c
+++ b/drivers/spi/spi-mxs.c
@@ -58,6 +58,13 @@
 
 #define SG_MAXLEN		0xff00
 
+/*
+ * Flags for txrx functions.  More efficient that using an argument register for
+ * each one.
+ */
+#define TXRX_WRITE		1	/* This is a write */
+#define TXRX_DEASSERT_CS	2	/* De-assert CS at end of txrx */
+
 struct mxs_spi {
 	struct mxs_ssp		ssp;
 	struct completion	c;
@@ -196,7 +203,7 @@ static irqreturn_t mxs_ssp_irq_handler(int irq, void *dev_id)
 
 static int mxs_spi_txrx_dma(struct mxs_spi *spi, int cs,
 			    unsigned char *buf, int len,
-			    int *first, int *last, int write)
+			    unsigned int flags)
 {
 	struct mxs_ssp *ssp = &spi->ssp;
 	struct dma_async_tx_descriptor *desc = NULL;
@@ -226,15 +233,19 @@ static int mxs_spi_txrx_dma(struct mxs_spi *spi, int cs,
 	ctrl0 &= ~BM_SSP_CTRL0_XFER_COUNT;
 	ctrl0 |= BM_SSP_CTRL0_DATA_XFER | mxs_spi_cs_to_reg(cs);
 
-	if (!write)
+	if (!(flags & TXRX_WRITE))
 		ctrl0 |= BM_SSP_CTRL0_READ;
 
 	/* Queue the DMA data transfer. */
 	for (sg_count = 0; sg_count < sgs; sg_count++) {
+		/* Prepare the transfer descriptor. */
 		min = min(len, desc_len);
 
-		/* Prepare the transfer descriptor. */
-		if ((sg_count + 1 == sgs) && *last)
+		/*
+		 * De-assert CS on last segment if flag is set (i.e., no more
+		 * transfers will follow)
+		 */
+		if ((sg_count + 1 == sgs) && (flags & TXRX_DEASSERT_CS))
 			ctrl0 |= BM_SSP_CTRL0_IGNORE_CRC;
 
 		if (ssp->devid == IMX23_SSP) {
@@ -259,7 +270,7 @@ static int mxs_spi_txrx_dma(struct mxs_spi *spi, int cs,
 
 		sg_init_one(&dma_xfer[sg_count].sg, sg_buf, min);
 		ret = dma_map_sg(ssp->dev, &dma_xfer[sg_count].sg, 1,
-			write ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
+			(flags & TXRX_WRITE) ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
 
 		len -= min;
 		buf += min;
@@ -279,7 +290,7 @@ static int mxs_spi_txrx_dma(struct mxs_spi *spi, int cs,
 
 		desc = dmaengine_prep_slave_sg(ssp->dmach,
 				&dma_xfer[sg_count].sg, 1,
-				write ? DMA_MEM_TO_DEV : DMA_DEV_TO_MEM,
+				(flags & TXRX_WRITE) ? DMA_MEM_TO_DEV : DMA_DEV_TO_MEM,
 				DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 
 		if (!desc) {
@@ -316,7 +327,7 @@ err_vmalloc:
 	while (--sg_count >= 0) {
 err_mapped:
 		dma_unmap_sg(ssp->dev, &dma_xfer[sg_count].sg, 1,
-			write ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
+			(flags & TXRX_WRITE) ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
 	}
 
 	kfree(dma_xfer);
@@ -326,7 +337,7 @@ err_mapped:
 
 static int mxs_spi_txrx_pio(struct mxs_spi *spi, int cs,
 			    unsigned char *buf, int len,
-			    int *first, int *last, int write)
+			    unsigned int flags)
 {
 	struct mxs_ssp *ssp = &spi->ssp;
 
@@ -337,7 +348,7 @@ static int mxs_spi_txrx_pio(struct mxs_spi *spi, int cs,
 	mxs_spi_set_cs(spi, cs);
 
 	while (len--) {
-		if (*last && len == 0)
+		if (len == 0 && (flags & TXRX_DEASSERT_CS))
 			writel(BM_SSP_CTRL0_IGNORE_CRC,
 			       ssp->base + HW_SSP_CTRL0 + STMP_OFFSET_REG_SET);
 
@@ -350,7 +361,7 @@ static int mxs_spi_txrx_pio(struct mxs_spi *spi, int cs,
 			writel(1, ssp->base + HW_SSP_XFER_SIZE);
 		}
 
-		if (write)
+		if (flags & TXRX_WRITE)
 			writel(BM_SSP_CTRL0_READ,
 				ssp->base + HW_SSP_CTRL0 + STMP_OFFSET_REG_CLR);
 		else
@@ -363,13 +374,13 @@ static int mxs_spi_txrx_pio(struct mxs_spi *spi, int cs,
 		if (mxs_ssp_wait(spi, HW_SSP_CTRL0, BM_SSP_CTRL0_RUN, 1))
 			return -ETIMEDOUT;
 
-		if (write)
+		if (flags & TXRX_WRITE)
 			writel(*buf, ssp->base + HW_SSP_DATA(ssp));
 
 		writel(BM_SSP_CTRL0_DATA_XFER,
 			     ssp->base + HW_SSP_CTRL0 + STMP_OFFSET_REG_SET);
 
-		if (!write) {
+		if (!(flags & TXRX_WRITE)) {
 			if (mxs_ssp_wait(spi, HW_SSP_STATUS(ssp),
 						BM_SSP_STATUS_FIFO_EMPTY, 0))
 				return -ETIMEDOUT;
@@ -394,13 +405,11 @@ static int mxs_spi_transfer_one(struct spi_master *master,
 {
 	struct mxs_spi *spi = spi_master_get_devdata(master);
 	struct mxs_ssp *ssp = &spi->ssp;
-	int first, last;
 	struct spi_transfer *t, *tmp_t;
+	unsigned int flag;
 	int status = 0;
 	int cs;
 
-	first = last = 0;
-
 	cs = m->spi->chip_select;
 
 	list_for_each_entry_safe(t, tmp_t, &m->transfers, transfer_list) {
@@ -409,10 +418,9 @@ static int mxs_spi_transfer_one(struct spi_master *master,
 		if (status)
 			break;
 
-		if (&t->transfer_list == m->transfers.next)
-			first = 1;
-		if (&t->transfer_list == m->transfers.prev)
-			last = 1;
+		/* De-assert on last transfer, inverted by cs_change flag */
+		flag = (&t->transfer_list == m->transfers.prev) ^ t->cs_change ?
+		       TXRX_DEASSERT_CS : 0;
 		if ((t->rx_buf && t->tx_buf) || (t->rx_dma && t->tx_dma)) {
 			dev_err(ssp->dev,
 				"Cannot send and receive simultaneously\n");
@@ -437,11 +445,11 @@ static int mxs_spi_transfer_one(struct spi_master *master,
 			if (t->tx_buf)
 				status = mxs_spi_txrx_pio(spi, cs,
 						(void *)t->tx_buf,
-						t->len, &first, &last, 1);
+						t->len, flag | TXRX_WRITE);
 			if (t->rx_buf)
 				status = mxs_spi_txrx_pio(spi, cs,
 						t->rx_buf, t->len,
-						&first, &last, 0);
+						flag);
 		} else {
 			writel(BM_SSP_CTRL1_DMA_ENABLE,
 				ssp->base + HW_SSP_CTRL1(ssp) +
@@ -450,11 +458,11 @@ static int mxs_spi_transfer_one(struct spi_master *master,
 			if (t->tx_buf)
 				status = mxs_spi_txrx_dma(spi, cs,
 						(void *)t->tx_buf, t->len,
-						&first, &last, 1);
+						flag | TXRX_WRITE);
 			if (t->rx_buf)
 				status = mxs_spi_txrx_dma(spi, cs,
 						t->rx_buf, t->len,
-						&first, &last, 0);
+						flag);
 		}
 
 		if (status) {
@@ -463,7 +471,6 @@ static int mxs_spi_transfer_one(struct spi_master *master,
 		}
 
 		m->actual_length += t->len;
-		first = last = 0;
 	}
 
 	m->status = status;
-- 
1.7.10.4
