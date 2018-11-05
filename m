From: broonie@kernel.org (Mark Brown)
Date: Mon,  5 Nov 2018 12:06:55 +0000 (GMT)
Subject: Applied "spi: rockchip: use designated init for dma config" to the
 spi tree
In-Reply-To: <20181031105711.19575-3-esmil@mailme.dk>
Message-ID: <20181105120655.15DAC1124D98@debutante.sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: rockchip: use designated init for dma config

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

>From 31bcb57be12fd815a9051f07d64334809b8cb472 Mon Sep 17 00:00:00 2001
From: Emil Renner Berthing <kernel@esmil.dk>
Date: Wed, 31 Oct 2018 11:56:59 +0100
Subject: [PATCH] spi: rockchip: use designated init for dma config

Use C99 designated initializers for dma slave config
structures. This also makes sure uninitialized fields
are zeroed so we don't need an explicit memset.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
Tested-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-rockchip.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 7e54e1a69cc8..87d1b9837d94 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -442,12 +442,8 @@ static void rockchip_spi_dma_txcb(void *data)
 static int rockchip_spi_prepare_dma(struct rockchip_spi *rs)
 {
 	unsigned long flags;
-	struct dma_slave_config rxconf, txconf;
 	struct dma_async_tx_descriptor *rxdesc, *txdesc;
 
-	memset(&rxconf, 0, sizeof(rxconf));
-	memset(&txconf, 0, sizeof(txconf));
-
 	spin_lock_irqsave(&rs->lock, flags);
 	rs->state &= ~RXBUSY;
 	rs->state &= ~TXBUSY;
@@ -455,10 +451,13 @@ static int rockchip_spi_prepare_dma(struct rockchip_spi *rs)
 
 	rxdesc = NULL;
 	if (rs->rx) {
-		rxconf.direction = DMA_DEV_TO_MEM;
-		rxconf.src_addr = rs->dma_rx.addr;
-		rxconf.src_addr_width = rs->n_bytes;
-		rxconf.src_maxburst = 1;
+		struct dma_slave_config rxconf = {
+			.direction = DMA_DEV_TO_MEM,
+			.src_addr = rs->dma_rx.addr,
+			.src_addr_width = rs->n_bytes,
+			.src_maxburst = 1,
+		};
+
 		dmaengine_slave_config(rs->dma_rx.ch, &rxconf);
 
 		rxdesc = dmaengine_prep_slave_sg(
@@ -474,10 +473,13 @@ static int rockchip_spi_prepare_dma(struct rockchip_spi *rs)
 
 	txdesc = NULL;
 	if (rs->tx) {
-		txconf.direction = DMA_MEM_TO_DEV;
-		txconf.dst_addr = rs->dma_tx.addr;
-		txconf.dst_addr_width = rs->n_bytes;
-		txconf.dst_maxburst = rs->fifo_len / 2;
+		struct dma_slave_config txconf = {
+			.direction = DMA_MEM_TO_DEV,
+			.dst_addr = rs->dma_tx.addr,
+			.dst_addr_width = rs->n_bytes,
+			.dst_maxburst = rs->fifo_len / 2,
+		};
+
 		dmaengine_slave_config(rs->dma_tx.ch, &txconf);
 
 		txdesc = dmaengine_prep_slave_sg(
-- 
2.19.0.rc2
