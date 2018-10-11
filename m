From: broonie@kernel.org (Mark Brown)
Date: Thu, 11 Oct 2018 15:56:08 +0100 (BST)
Subject: Applied "spi: rockchip: adjust dma watermark and burstlen" to the spi
 tree
In-Reply-To: <20181010090038.20834-3-kernel@esmil.dk>
Message-ID: <20181011145608.1C92911223ED@debutante.sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: rockchip: adjust dma watermark and burstlen

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

>From dcfc861d24ec19f0d0d3d55bb016646794571fbb Mon Sep 17 00:00:00 2001
From: Huibin Hong <huibin.hong@rock-chips.com>
Date: Wed, 10 Oct 2018 11:00:33 +0200
Subject: [PATCH] spi: rockchip: adjust dma watermark and burstlen

Signal tx dma when spi fifo is less than half full,
and limit tx bursts to half the fifo length.

Clamp rx burst length to 1 to avoid alignment issues.

Signed-off-by: Huibin Hong <huibin.hong@rock-chips.com>
Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-rockchip.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index fdcf3076681b..2f825702cd90 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -455,10 +455,7 @@ static int rockchip_spi_prepare_dma(struct rockchip_spi *rs)
 		rxconf.direction = rs->dma_rx.direction;
 		rxconf.src_addr = rs->dma_rx.addr;
 		rxconf.src_addr_width = rs->n_bytes;
-		if (rs->dma_caps.max_burst > 4)
-			rxconf.src_maxburst = 4;
-		else
-			rxconf.src_maxburst = 1;
+		rxconf.src_maxburst = 1;
 		dmaengine_slave_config(rs->dma_rx.ch, &rxconf);
 
 		rxdesc = dmaengine_prep_slave_sg(
@@ -477,10 +474,7 @@ static int rockchip_spi_prepare_dma(struct rockchip_spi *rs)
 		txconf.direction = rs->dma_tx.direction;
 		txconf.dst_addr = rs->dma_tx.addr;
 		txconf.dst_addr_width = rs->n_bytes;
-		if (rs->dma_caps.max_burst > 4)
-			txconf.dst_maxburst = 4;
-		else
-			txconf.dst_maxburst = 1;
+		txconf.dst_maxburst = rs->fifo_len / 2;
 		dmaengine_slave_config(rs->dma_tx.ch, &txconf);
 
 		txdesc = dmaengine_prep_slave_sg(
@@ -578,7 +572,7 @@ static void rockchip_spi_config(struct rockchip_spi *rs)
 	writel_relaxed(rs->fifo_len / 2 - 1, rs->regs + ROCKCHIP_SPI_TXFTLR);
 	writel_relaxed(rs->fifo_len / 2 - 1, rs->regs + ROCKCHIP_SPI_RXFTLR);
 
-	writel_relaxed(0, rs->regs + ROCKCHIP_SPI_DMATDLR);
+	writel_relaxed(rs->fifo_len / 2 - 1, rs->regs + ROCKCHIP_SPI_DMATDLR);
 	writel_relaxed(0, rs->regs + ROCKCHIP_SPI_DMARDLR);
 	writel_relaxed(dmacr, rs->regs + ROCKCHIP_SPI_DMACR);
 
-- 
2.19.0.rc2
