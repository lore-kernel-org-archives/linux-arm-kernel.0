From: broonie@kernel.org (Mark Brown)
Date: Thu, 11 Oct 2018 15:55:53 +0100 (BST)
Subject: Applied "spi: rockchip: simplify spi enable logic" to the spi tree
In-Reply-To: <20181010090038.20834-8-kernel@esmil.dk>
Message-ID: <20181011145553.07C8111223ED@debutante.sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: rockchip: simplify spi enable logic

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

>From a3c174021ce780f5d2e9b2105e2cb4903a37226d Mon Sep 17 00:00:00 2001
From: Emil Renner Berthing <kernel@esmil.dk>
Date: Wed, 10 Oct 2018 11:00:38 +0200
Subject: [PATCH] spi: rockchip: simplify spi enable logic

Let the dma/non-dma code paths handle the spi enable
flag themselves. This removes some logic to determine
if the flag should be turned on before or after dma
and also don't leave the spi enabled if the dma path
fails.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-rockchip.c | 28 +++++++++-------------------
 1 file changed, 9 insertions(+), 19 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 6fa809da61dd..ffa564fbf970 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -379,6 +379,8 @@ static int rockchip_spi_pio_transfer(struct rockchip_spi *rs)
 {
 	int remain = 0;
 
+	spi_enable_chip(rs, 1);
+
 	do {
 		if (rs->tx) {
 			remain = rs->tx_end - rs->tx;
@@ -498,6 +500,8 @@ static int rockchip_spi_prepare_dma(struct rockchip_spi *rs)
 		dma_async_issue_pending(rs->dma_rx.ch);
 	}
 
+	spi_enable_chip(rs, 1);
+
 	if (txdesc) {
 		spin_lock_irqsave(&rs->lock, flags);
 		rs->state |= TXBUSY;
@@ -506,7 +510,8 @@ static int rockchip_spi_prepare_dma(struct rockchip_spi *rs)
 		dma_async_issue_pending(rs->dma_tx.ch);
 	}
 
-	return 0;
+	/* 1 means the transfer is in progress */
+	return 1;
 }
 
 static void rockchip_spi_config(struct rockchip_spi *rs)
@@ -589,7 +594,6 @@ static int rockchip_spi_transfer_one(
 		struct spi_device *spi,
 		struct spi_transfer *xfer)
 {
-	int ret = 0;
 	struct rockchip_spi *rs = spi_master_get_devdata(master);
 
 	WARN_ON(readl_relaxed(rs->regs + ROCKCHIP_SPI_SSIENR) &&
@@ -633,24 +637,10 @@ static int rockchip_spi_transfer_one(
 
 	rockchip_spi_config(rs);
 
-	if (rs->use_dma) {
-		if (rs->tmode == CR0_XFM_RO) {
-			/* rx: dma must be prepared first */
-			ret = rockchip_spi_prepare_dma(rs);
-			spi_enable_chip(rs, 1);
-		} else {
-			/* tx or tr: spi must be enabled first */
-			spi_enable_chip(rs, 1);
-			ret = rockchip_spi_prepare_dma(rs);
-		}
-		/* successful DMA prepare means the transfer is in progress */
-		ret = ret ? ret : 1;
-	} else {
-		spi_enable_chip(rs, 1);
-		ret = rockchip_spi_pio_transfer(rs);
-	}
+	if (rs->use_dma)
+		return rockchip_spi_prepare_dma(rs);
 
-	return ret;
+	return rockchip_spi_pio_transfer(rs);
 }
 
 static bool rockchip_spi_can_dma(struct spi_master *master,
-- 
2.19.0.rc2
