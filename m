From: broonie@kernel.org (Mark Brown)
Date: Thu, 11 Oct 2018 15:55:56 +0100 (BST)
Subject: Applied "spi: rockchip: directly use direction constants" to the spi
 tree
In-Reply-To: <20181010090038.20834-7-kernel@esmil.dk>
Message-ID: <20181011145556.B71F911223ED@debutante.sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: rockchip: directly use direction constants

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

>From d9071b7e9fc474e474e3b865428a8d30d88daaf4 Mon Sep 17 00:00:00 2001
From: Emil Renner Berthing <kernel@esmil.dk>
Date: Wed, 10 Oct 2018 11:00:37 +0200
Subject: [PATCH] spi: rockchip: directly use direction constants

The dma direction for the tx and rx dma channels never
change, so just use the constants directly rather
than storing them in device data.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-rockchip.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 99943aa71bc1..6fa809da61dd 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -164,7 +164,6 @@ enum rockchip_ssi_type {
 
 struct rockchip_spi_dma_data {
 	struct dma_chan *ch;
-	enum dma_transfer_direction direction;
 	dma_addr_t addr;
 };
 
@@ -451,7 +450,7 @@ static int rockchip_spi_prepare_dma(struct rockchip_spi *rs)
 
 	rxdesc = NULL;
 	if (rs->rx) {
-		rxconf.direction = rs->dma_rx.direction;
+		rxconf.direction = DMA_DEV_TO_MEM;
 		rxconf.src_addr = rs->dma_rx.addr;
 		rxconf.src_addr_width = rs->n_bytes;
 		rxconf.src_maxburst = 1;
@@ -460,7 +459,7 @@ static int rockchip_spi_prepare_dma(struct rockchip_spi *rs)
 		rxdesc = dmaengine_prep_slave_sg(
 				rs->dma_rx.ch,
 				rs->rx_sg.sgl, rs->rx_sg.nents,
-				rs->dma_rx.direction, DMA_PREP_INTERRUPT);
+				DMA_DEV_TO_MEM, DMA_PREP_INTERRUPT);
 		if (!rxdesc)
 			return -EINVAL;
 
@@ -470,7 +469,7 @@ static int rockchip_spi_prepare_dma(struct rockchip_spi *rs)
 
 	txdesc = NULL;
 	if (rs->tx) {
-		txconf.direction = rs->dma_tx.direction;
+		txconf.direction = DMA_MEM_TO_DEV;
 		txconf.dst_addr = rs->dma_tx.addr;
 		txconf.dst_addr_width = rs->n_bytes;
 		txconf.dst_maxburst = rs->fifo_len / 2;
@@ -479,7 +478,7 @@ static int rockchip_spi_prepare_dma(struct rockchip_spi *rs)
 		txdesc = dmaengine_prep_slave_sg(
 				rs->dma_tx.ch,
 				rs->tx_sg.sgl, rs->tx_sg.nents,
-				rs->dma_tx.direction, DMA_PREP_INTERRUPT);
+				DMA_MEM_TO_DEV, DMA_PREP_INTERRUPT);
 		if (!txdesc) {
 			if (rxdesc)
 				dmaengine_terminate_sync(rs->dma_rx.ch);
@@ -775,8 +774,6 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 	if (rs->dma_tx.ch && rs->dma_rx.ch) {
 		rs->dma_tx.addr = (dma_addr_t)(mem->start + ROCKCHIP_SPI_TXDR);
 		rs->dma_rx.addr = (dma_addr_t)(mem->start + ROCKCHIP_SPI_RXDR);
-		rs->dma_tx.direction = DMA_MEM_TO_DEV;
-		rs->dma_rx.direction = DMA_DEV_TO_MEM;
 
 		master->can_dma = rockchip_spi_can_dma;
 		master->dma_tx = rs->dma_tx.ch;
-- 
2.19.0.rc2
