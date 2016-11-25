From: broonie@kernel.org (Mark Brown)
Date: Fri, 25 Nov 2016 13:10:25 +0000
Subject: Applied "spi: atmel: Use core SPI_MASTER_MUST_[RT]X handling" to the
 spi tree
In-Reply-To: <86f613a36c2e7db07c3ec7d0b8a650cdb9222b32.1479985886.git.nicolas.ferre@atmel.com>
Message-ID: <E1cAGGn-0005G9-Db@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: atmel: Use core SPI_MASTER_MUST_[RT]X handling

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 7910d9af000acc155745e44be55a5d0dc9e26ce7 Mon Sep 17 00:00:00 2001
From: Nicolas Ferre <nicolas.ferre@atmel.com>
Date: Thu, 24 Nov 2016 12:24:58 +0100
Subject: [PATCH] spi: atmel: Use core SPI_MASTER_MUST_[RT]X handling

We need both RX and TX data for each transfer in any case (PIO, PDC, DMA).
So convert the driver to the core dummy buffer handling with the
SPI_MASTER_MUST_RX/SPI_MASTER_MUST_TX infrastructure.

This move changes the maximum PDC/DMA buffer handling to 65535 bytes
instead of a single page and sets master->max_dma_len to this value.

All dummy buffer management is removed from the driver.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-atmel.c | 131 +++++++++++++-----------------------------------
 1 file changed, 35 insertions(+), 96 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index a9ae1836e1e2..8f20d4f75e4a 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -303,10 +303,6 @@ struct atmel_spi {
 
 	struct completion	xfer_completion;
 
-	/* scratch buffer */
-	void			*buffer;
-	dma_addr_t		buffer_dma;
-
 	struct atmel_spi_caps	caps;
 
 	bool			use_dma;
@@ -327,7 +323,7 @@ struct atmel_spi_device {
 	u32			csr;
 };
 
-#define BUFFER_SIZE		PAGE_SIZE
+#define SPI_MAX_DMA_XFER	65535 /* true for both PDC and DMA */
 #define INVALID_DMA_ADDRESS	0xffffffff
 
 /*
@@ -612,14 +608,10 @@ static void atmel_spi_next_xfer_single(struct spi_master *master,
 		cpu_relax();
 	}
 
-	if (xfer->tx_buf) {
-		if (xfer->bits_per_word > 8)
-			spi_writel(as, TDR, *(u16 *)(xfer->tx_buf + xfer_pos));
-		else
-			spi_writel(as, TDR, *(u8 *)(xfer->tx_buf + xfer_pos));
-	} else {
-		spi_writel(as, TDR, 0);
-	}
+	if (xfer->bits_per_word > 8)
+		spi_writel(as, TDR, *(u16 *)(xfer->tx_buf + xfer_pos));
+	else
+		spi_writel(as, TDR, *(u8 *)(xfer->tx_buf + xfer_pos));
 
 	dev_dbg(master->dev.parent,
 		"  start pio xfer %p: len %u tx %p rx %p bitpw %d\n",
@@ -666,17 +658,12 @@ static void atmel_spi_next_xfer_fifo(struct spi_master *master,
 
 	/* Fill TX FIFO */
 	while (num_data >= 2) {
-		if (xfer->tx_buf) {
-			if (xfer->bits_per_word > 8) {
-				td0 = *words++;
-				td1 = *words++;
-			} else {
-				td0 = *bytes++;
-				td1 = *bytes++;
-			}
+		if (xfer->bits_per_word > 8) {
+			td0 = *words++;
+			td1 = *words++;
 		} else {
-			td0 = 0;
-			td1 = 0;
+			td0 = *bytes++;
+			td1 = *bytes++;
 		}
 
 		spi_writel(as, TDR, (td1 << 16) | td0);
@@ -684,14 +671,10 @@ static void atmel_spi_next_xfer_fifo(struct spi_master *master,
 	}
 
 	if (num_data) {
-		if (xfer->tx_buf) {
-			if (xfer->bits_per_word > 8)
-				td0 = *words++;
-			else
-				td0 = *bytes++;
-		} else {
-			td0 = 0;
-		}
+		if (xfer->bits_per_word > 8)
+			td0 = *words++;
+		else
+			td0 = *bytes++;
 
 		spi_writew(as, TDR, td0);
 		num_data--;
@@ -750,24 +733,14 @@ static int atmel_spi_next_xfer_dma_submit(struct spi_master *master,
 
 	/* prepare the RX dma transfer */
 	sg_init_table(&as->dma.sgrx, 1);
-	if (xfer->rx_buf) {
-		as->dma.sgrx.dma_address = xfer->rx_dma + xfer->len - *plen;
-	} else {
-		as->dma.sgrx.dma_address = as->buffer_dma;
-		if (len > BUFFER_SIZE)
-			len = BUFFER_SIZE;
-	}
+	as->dma.sgrx.dma_address = xfer->rx_dma + xfer->len - *plen;
 
 	/* prepare the TX dma transfer */
 	sg_init_table(&as->dma.sgtx, 1);
-	if (xfer->tx_buf) {
-		as->dma.sgtx.dma_address = xfer->tx_dma + xfer->len - *plen;
-	} else {
-		as->dma.sgtx.dma_address = as->buffer_dma;
-		if (len > BUFFER_SIZE)
-			len = BUFFER_SIZE;
-		memset(as->buffer, 0, len);
-	}
+	as->dma.sgtx.dma_address = xfer->tx_dma + xfer->len - *plen;
+
+	if (len > master->max_dma_len)
+		len = master->max_dma_len;
 
 	sg_dma_len(&as->dma.sgtx) = len;
 	sg_dma_len(&as->dma.sgrx) = len;
@@ -834,25 +807,10 @@ static void atmel_spi_next_xfer_data(struct spi_master *master,
 	struct atmel_spi	*as = spi_master_get_devdata(master);
 	u32			len = *plen;
 
-	/* use scratch buffer only when rx or tx data is unspecified */
-	if (xfer->rx_buf)
-		*rx_dma = xfer->rx_dma + xfer->len - *plen;
-	else {
-		*rx_dma = as->buffer_dma;
-		if (len > BUFFER_SIZE)
-			len = BUFFER_SIZE;
-	}
-
-	if (xfer->tx_buf)
-		*tx_dma = xfer->tx_dma + xfer->len - *plen;
-	else {
-		*tx_dma = as->buffer_dma;
-		if (len > BUFFER_SIZE)
-			len = BUFFER_SIZE;
-		memset(as->buffer, 0, len);
-		dma_sync_single_for_device(&as->pdev->dev,
-				as->buffer_dma, len, DMA_TO_DEVICE);
-	}
+	*rx_dma = xfer->rx_dma + xfer->len - *plen;
+	*tx_dma = xfer->tx_dma + xfer->len - *plen;
+	if (len > master->max_dma_len)
+		len = master->max_dma_len;
 
 	*plen = len;
 }
@@ -1026,16 +984,12 @@ atmel_spi_pump_single_data(struct atmel_spi *as, struct spi_transfer *xfer)
 	u16		*rxp16;
 	unsigned long	xfer_pos = xfer->len - as->current_remaining_bytes;
 
-	if (xfer->rx_buf) {
-		if (xfer->bits_per_word > 8) {
-			rxp16 = (u16 *)(((u8 *)xfer->rx_buf) + xfer_pos);
-			*rxp16 = spi_readl(as, RDR);
-		} else {
-			rxp = ((u8 *)xfer->rx_buf) + xfer_pos;
-			*rxp = spi_readl(as, RDR);
-		}
+	if (xfer->bits_per_word > 8) {
+		rxp16 = (u16 *)(((u8 *)xfer->rx_buf) + xfer_pos);
+		*rxp16 = spi_readl(as, RDR);
 	} else {
-		spi_readl(as, RDR);
+		rxp = ((u8 *)xfer->rx_buf) + xfer_pos;
+		*rxp = spi_readl(as, RDR);
 	}
 	if (xfer->bits_per_word > 8) {
 		if (as->current_remaining_bytes > 2)
@@ -1074,12 +1028,10 @@ atmel_spi_pump_fifo_data(struct atmel_spi *as, struct spi_transfer *xfer)
 	/* Read data */
 	while (num_data) {
 		rd = spi_readl(as, RDR);
-		if (xfer->rx_buf) {
-			if (xfer->bits_per_word > 8)
-				*words++ = rd;
-			else
-				*bytes++ = rd;
-		}
+		if (xfer->bits_per_word > 8)
+			*words++ = rd;
+		else
+			*bytes++ = rd;
 		num_data--;
 	}
 }
@@ -1561,29 +1513,22 @@ static int atmel_spi_probe(struct platform_device *pdev)
 	master->bus_num = pdev->id;
 	master->num_chipselect = master->dev.of_node ? 0 : 4;
 	master->setup = atmel_spi_setup;
+	master->flags = (SPI_MASTER_MUST_RX | SPI_MASTER_MUST_TX);
 	master->transfer_one_message = atmel_spi_transfer_one_message;
 	master->cleanup = atmel_spi_cleanup;
 	master->auto_runtime_pm = true;
+	master->max_dma_len = SPI_MAX_DMA_XFER;
 	platform_set_drvdata(pdev, master);
 
 	as = spi_master_get_devdata(master);
 
-	/*
-	 * Scratch buffer is used for throwaway rx and tx data.
-	 * It's coherent to minimize dcache pollution.
-	 */
-	as->buffer = dma_alloc_coherent(&pdev->dev, BUFFER_SIZE,
-					&as->buffer_dma, GFP_KERNEL);
-	if (!as->buffer)
-		goto out_free;
-
 	spin_lock_init(&as->lock);
 
 	as->pdev = pdev;
 	as->regs = devm_ioremap_resource(&pdev->dev, regs);
 	if (IS_ERR(as->regs)) {
 		ret = PTR_ERR(as->regs);
-		goto out_free_buffer;
+		goto out_unmap_regs;
 	}
 	as->phybase = regs->start;
 	as->irq = irq;
@@ -1681,9 +1626,6 @@ static int atmel_spi_probe(struct platform_device *pdev)
 	clk_disable_unprepare(clk);
 out_free_irq:
 out_unmap_regs:
-out_free_buffer:
-	dma_free_coherent(&pdev->dev, BUFFER_SIZE, as->buffer,
-			as->buffer_dma);
 out_free:
 	spi_master_put(master);
 	return ret;
@@ -1708,9 +1650,6 @@ static int atmel_spi_remove(struct platform_device *pdev)
 	spi_readl(as, SR);
 	spin_unlock_irq(&as->lock);
 
-	dma_free_coherent(&pdev->dev, BUFFER_SIZE, as->buffer,
-			as->buffer_dma);
-
 	clk_disable_unprepare(as->clk);
 
 	pm_runtime_put_noidle(&pdev->dev);
-- 
2.10.2
