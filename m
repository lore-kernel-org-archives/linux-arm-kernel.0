From: esmil@mailme.dk (Emil Renner Berthing)
Date: Wed, 31 Oct 2018 11:57:09 +0100
Subject: [PATCH v1 12/14] spi: rockchip: use irq rather than polling
In-Reply-To: <20181031105711.19575-1-esmil@mailme.dk>
References: <20181031105711.19575-1-esmil@mailme.dk>
Message-ID: <20181031105711.19575-13-esmil@mailme.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Emil Renner Berthing <kernel@esmil.dk>

Register an interrupt handler to fill/empty the
tx and rx fifos rather than busy-looping.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
---
 drivers/spi/spi-rockchip.c | 155 ++++++++++++++++++++++---------------
 1 file changed, 92 insertions(+), 63 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 5fe6099ff366..1297f081818d 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -172,6 +172,11 @@ struct rockchip_spi {
 	dma_addr_t dma_addr_rx;
 	dma_addr_t dma_addr_tx;
 
+	const void *tx;
+	void *rx;
+	unsigned int tx_left;
+	unsigned int rx_left;
+
 	atomic_t state;
 
 	/*depth of the FIFO buffer */
@@ -182,11 +187,6 @@ struct rockchip_spi {
 	u8 n_bytes;
 	u8 rsd;
 
-	const void *tx;
-	const void *tx_end;
-	void *rx;
-	void *rx_end;
-
 	bool cs_asserted[ROCKCHIP_SPI_MAX_CS_NUM];
 };
 
@@ -222,24 +222,6 @@ static u32 get_fifo_len(struct rockchip_spi *rs)
 	return (fifo == 31) ? 0 : fifo;
 }
 
-static inline u32 tx_max(struct rockchip_spi *rs)
-{
-	u32 tx_left, tx_room;
-
-	tx_left = (rs->tx_end - rs->tx) / rs->n_bytes;
-	tx_room = rs->fifo_len - readl_relaxed(rs->regs + ROCKCHIP_SPI_TXFLR);
-
-	return min(tx_left, tx_room);
-}
-
-static inline u32 rx_max(struct rockchip_spi *rs)
-{
-	u32 rx_left = (rs->rx_end - rs->rx) / rs->n_bytes;
-	u32 rx_room = (u32)readl_relaxed(rs->regs + ROCKCHIP_SPI_RXFLR);
-
-	return min(rx_left, rx_room);
-}
-
 static void rockchip_spi_set_cs(struct spi_device *spi, bool enable)
 {
 	struct spi_master *master = spi->master;
@@ -277,6 +259,9 @@ static void rockchip_spi_handle_err(struct spi_master *master,
 	 */
 	spi_enable_chip(rs, false);
 
+	/* make sure all interrupts are masked */
+	writel_relaxed(0, rs->regs + ROCKCHIP_SPI_IMR);
+
 	if (atomic_read(&rs->state) & TXDMA)
 		dmaengine_terminate_async(master->dma_tx);
 
@@ -286,14 +271,17 @@ static void rockchip_spi_handle_err(struct spi_master *master,
 
 static void rockchip_spi_pio_writer(struct rockchip_spi *rs)
 {
-	u32 max = tx_max(rs);
-	u32 txw = 0;
+	u32 tx_free = rs->fifo_len - readl_relaxed(rs->regs + ROCKCHIP_SPI_TXFLR);
+	u32 words = min(rs->tx_left, tx_free);
+
+	rs->tx_left -= words;
+	for (; words; words--) {
+		u32 txw;
 
-	while (max--) {
 		if (rs->n_bytes == 1)
-			txw = *(u8 *)(rs->tx);
+			txw = *(u8 *)rs->tx;
 		else
-			txw = *(u16 *)(rs->tx);
+			txw = *(u16 *)rs->tx;
 
 		writel_relaxed(txw, rs->regs + ROCKCHIP_SPI_TXDR);
 		rs->tx += rs->n_bytes;
@@ -302,46 +290,72 @@ static void rockchip_spi_pio_writer(struct rockchip_spi *rs)
 
 static void rockchip_spi_pio_reader(struct rockchip_spi *rs)
 {
-	u32 max = rx_max(rs);
-	u32 rxw;
+	u32 words = readl_relaxed(rs->regs + ROCKCHIP_SPI_RXFLR);
+	u32 rx_left = rs->rx_left - words;
+
+	/* the hardware doesn't allow us to change fifo threshold
+	 * level while spi is enabled, so instead make sure to leave
+	 * enough words in the rx fifo to get the last interrupt
+	 * exactly when all words have been received
+	 */
+	if (rx_left) {
+		u32 ftl = readl_relaxed(rs->regs + ROCKCHIP_SPI_RXFTLR) + 1;
+
+		if (rx_left < ftl) {
+			rx_left = ftl;
+			words = rs->rx_left - rx_left;
+		}
+	}
+
+	rs->rx_left = rx_left;
+	for (; words; words--) {
+		u32 rxw = readl_relaxed(rs->regs + ROCKCHIP_SPI_RXDR);
+
+		if (!rs->rx)
+			continue;
 
-	while (max--) {
-		rxw = readl_relaxed(rs->regs + ROCKCHIP_SPI_RXDR);
 		if (rs->n_bytes == 1)
-			*(u8 *)(rs->rx) = (u8)rxw;
+			*(u8 *)rs->rx = (u8)rxw;
 		else
-			*(u16 *)(rs->rx) = (u16)rxw;
+			*(u16 *)rs->rx = (u16)rxw;
 		rs->rx += rs->n_bytes;
 	}
 }
 
-static int rockchip_spi_pio_transfer(struct rockchip_spi *rs)
+static irqreturn_t rockchip_spi_isr(int irq, void *dev_id)
 {
-	int remain = 0;
+	struct spi_master *master = dev_id;
+	struct rockchip_spi *rs = spi_master_get_devdata(master);
 
-	spi_enable_chip(rs, true);
+	if (rs->tx_left)
+		rockchip_spi_pio_writer(rs);
 
-	do {
-		if (rs->tx) {
-			remain = rs->tx_end - rs->tx;
-			rockchip_spi_pio_writer(rs);
-		}
+	rockchip_spi_pio_reader(rs);
+	if (!rs->rx_left) {
+		spi_enable_chip(rs, false);
+		writel_relaxed(0, rs->regs + ROCKCHIP_SPI_IMR);
+		spi_finalize_current_transfer(master);
+	}
 
-		if (rs->rx) {
-			remain = rs->rx_end - rs->rx;
-			rockchip_spi_pio_reader(rs);
-		}
+	return IRQ_HANDLED;
+}
 
-		cpu_relax();
-	} while (remain);
+static int rockchip_spi_prepare_irq(struct rockchip_spi *rs,
+		struct spi_transfer *xfer)
+{
+	rs->tx = xfer->tx_buf;
+	rs->rx = xfer->rx_buf;
+	rs->tx_left = rs->tx ? xfer->len / rs->n_bytes : 0;
+	rs->rx_left = xfer->len / rs->n_bytes;
 
-	/* If tx, wait until the FIFO data completely. */
-	if (rs->tx)
-		wait_for_idle(rs);
+	writel_relaxed(INT_RF_FULL, rs->regs + ROCKCHIP_SPI_IMR);
+	spi_enable_chip(rs, true);
 
-	spi_enable_chip(rs, false);
+	if (rs->tx_left)
+		rockchip_spi_pio_writer(rs);
 
-	return 0;
+	/* 1 means the transfer is in progress */
+	return 1;
 }
 
 static void rockchip_spi_dma_rxcb(void *data)
@@ -465,7 +479,7 @@ static void rockchip_spi_config(struct rockchip_spi *rs,
 		cr0 |= CR0_XFM_TR << CR0_XFM_OFFSET;
 	else if (xfer->rx_buf)
 		cr0 |= CR0_XFM_RO << CR0_XFM_OFFSET;
-	else
+	else if (use_dma)
 		cr0 |= CR0_XFM_TO << CR0_XFM_OFFSET;
 
 	if (use_dma) {
@@ -484,8 +498,14 @@ static void rockchip_spi_config(struct rockchip_spi *rs,
 	else
 		writel_relaxed((xfer->len * 2) - 1, rs->regs + ROCKCHIP_SPI_CTRLR1);
 
-	writel_relaxed(rs->fifo_len / 2 - 1, rs->regs + ROCKCHIP_SPI_TXFTLR);
-	writel_relaxed(rs->fifo_len / 2 - 1, rs->regs + ROCKCHIP_SPI_RXFTLR);
+	/* unfortunately setting the fifo threshold level to generate an
+	 * interrupt exactly when the fifo is full doesn't seem to work,
+	 * so we need the strict inequality here
+	 */
+	if (xfer->len < rs->fifo_len)
+		writel_relaxed(xfer->len - 1, rs->regs + ROCKCHIP_SPI_RXFTLR);
+	else
+		writel_relaxed(rs->fifo_len / 2 - 1, rs->regs + ROCKCHIP_SPI_RXFTLR);
 
 	writel_relaxed(rs->fifo_len / 2 - 1, rs->regs + ROCKCHIP_SPI_DMATDLR);
 	writel_relaxed(0, rs->regs + ROCKCHIP_SPI_DMARDLR);
@@ -527,11 +547,6 @@ static int rockchip_spi_transfer_one(
 
 	rs->n_bytes = xfer->bits_per_word >> 3;
 
-	rs->tx = xfer->tx_buf;
-	rs->tx_end = rs->tx + xfer->len;
-	rs->rx = xfer->rx_buf;
-	rs->rx_end = rs->rx + xfer->len;
-
 	use_dma = master->can_dma ? master->can_dma(master, spi, xfer) : false;
 
 	rockchip_spi_config(rs, spi, xfer, use_dma);
@@ -539,7 +554,7 @@ static int rockchip_spi_transfer_one(
 	if (use_dma)
 		return rockchip_spi_prepare_dma(rs, master, xfer);
 
-	return rockchip_spi_pio_transfer(rs);
+	return rockchip_spi_prepare_irq(rs, xfer);
 }
 
 static bool rockchip_spi_can_dma(struct spi_master *master,
@@ -547,8 +562,13 @@ static bool rockchip_spi_can_dma(struct spi_master *master,
 				 struct spi_transfer *xfer)
 {
 	struct rockchip_spi *rs = spi_master_get_devdata(master);
+	unsigned int bytes_per_word = xfer->bits_per_word <= 8 ? 1 : 2;
 
-	return (xfer->len > rs->fifo_len);
+	/* if the numbor of spi words to transfer is less than the fifo
+	 * length we can just fill the fifo and wait for a single irq,
+	 * so don't bother setting up dma
+	 */
+	return xfer->len / bytes_per_word >= rs->fifo_len;
 }
 
 static int rockchip_spi_probe(struct platform_device *pdev)
@@ -603,6 +623,15 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 
 	spi_enable_chip(rs, false);
 
+	ret = platform_get_irq(pdev, 0);
+	if (ret < 0)
+		goto err_disable_spiclk;
+
+	ret = devm_request_threaded_irq(&pdev->dev, ret, rockchip_spi_isr, NULL,
+			IRQF_ONESHOT, dev_name(&pdev->dev), master);
+	if (ret)
+		goto err_disable_spiclk;
+
 	rs->dev = &pdev->dev;
 	rs->freq = clk_get_rate(rs->spiclk);
 
-- 
2.19.1
