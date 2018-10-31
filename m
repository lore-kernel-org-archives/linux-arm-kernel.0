From: esmil@mailme.dk (Emil Renner Berthing)
Date: Wed, 31 Oct 2018 11:57:02 +0100
Subject: [PATCH v1 05/14] spi: rockchip: disable spi on error
In-Reply-To: <20181031105711.19575-1-esmil@mailme.dk>
References: <20181031105711.19575-1-esmil@mailme.dk>
Message-ID: <20181031105711.19575-6-esmil@mailme.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Emil Renner Berthing <kernel@esmil.dk>

Successful transfers leave the spi disabled, so if
we just make sure to disable the spi on error
there should be no need to disable the spi from
master->unprepare_message.

This also flushes the tx and rx fifos,
so no need to do that manually.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
---
 drivers/spi/spi-rockchip.c | 30 +++++-------------------------
 1 file changed, 5 insertions(+), 25 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 1c813797f963..5729e6071729 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -210,12 +210,6 @@ static inline void spi_set_clk(struct rockchip_spi *rs, u16 div)
 	writel_relaxed(div, rs->regs + ROCKCHIP_SPI_BAUDR);
 }
 
-static inline void flush_fifo(struct rockchip_spi *rs)
-{
-	while (readl_relaxed(rs->regs + ROCKCHIP_SPI_RXFLR))
-		readl_relaxed(rs->regs + ROCKCHIP_SPI_RXDR);
-}
-
 static inline void wait_for_idle(struct rockchip_spi *rs)
 {
 	unsigned long timeout = jiffies + msecs_to_jiffies(5);
@@ -304,29 +298,16 @@ static void rockchip_spi_handle_err(struct spi_master *master,
 {
 	struct rockchip_spi *rs = spi_master_get_devdata(master);
 
-	/*
-	 * For DMA mode, we need terminate DMA channel and flush
-	 * fifo for the next transfer if DMA thansfer timeout.
-	 * handle_err() was called by core if transfer failed.
-	 * Maybe it is reasonable for error handling here.
+	/* stop running spi transfer
+	 * this also flushes both rx and tx fifos
 	 */
+	spi_enable_chip(rs, false);
+
 	if (atomic_read(&rs->state) & TXDMA)
 		dmaengine_terminate_async(rs->dma_tx.ch);
 
-	if (atomic_read(&rs->state) & RXDMA) {
+	if (atomic_read(&rs->state) & RXDMA)
 		dmaengine_terminate_async(rs->dma_rx.ch);
-		flush_fifo(rs);
-	}
-}
-
-static int rockchip_spi_unprepare_message(struct spi_master *master,
-					  struct spi_message *msg)
-{
-	struct rockchip_spi *rs = spi_master_get_devdata(master);
-
-	spi_enable_chip(rs, false);
-
-	return 0;
 }
 
 static void rockchip_spi_pio_writer(struct rockchip_spi *rs)
@@ -705,7 +686,6 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 
 	master->set_cs = rockchip_spi_set_cs;
 	master->prepare_message = rockchip_spi_prepare_message;
-	master->unprepare_message = rockchip_spi_unprepare_message;
 	master->transfer_one = rockchip_spi_transfer_one;
 	master->max_transfer_size = rockchip_spi_max_transfer_size;
 	master->handle_err = rockchip_spi_handle_err;
-- 
2.19.1
