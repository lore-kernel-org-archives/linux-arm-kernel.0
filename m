From: broonie@kernel.org (Mark Brown)
Date: Mon,  5 Nov 2018 12:06:42 +0000 (GMT)
Subject: Applied "spi: rockchip: disable spi on error" to the spi tree
In-Reply-To: <20181031105711.19575-6-esmil@mailme.dk>
Message-ID: <20181105120642.F26821124D99@debutante.sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: rockchip: disable spi on error

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

>From ce386100d99976442093ff57b5b24a9562c6cc27 Mon Sep 17 00:00:00 2001
From: Emil Renner Berthing <kernel@esmil.dk>
Date: Wed, 31 Oct 2018 11:57:02 +0100
Subject: [PATCH] spi: rockchip: disable spi on error

Successful transfers leave the spi disabled, so if
we just make sure to disable the spi on error
there should be no need to disable the spi from
master->unprepare_message.

This also flushes the tx and rx fifos,
so no need to do that manually.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
Tested-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.19.0.rc2
