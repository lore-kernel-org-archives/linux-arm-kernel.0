From: broonie@kernel.org (Mark Brown)
Date: Wed, 08 Jun 2016 11:56:12 +0100
Subject: Applied "spi: rockchip: Signal unfinished DMA transfers" to the spi
 tree
In-Reply-To: <1465371171-20810-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <E1bAb9g-0001Bn-Ta@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: rockchip: Signal unfinished DMA transfers

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

>From 4f69b8188871c589a5e382f16a018850ec0146ce Mon Sep 17 00:00:00 2001
From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Date: Wed, 8 Jun 2016 09:32:51 +0200
Subject: [PATCH] spi: rockchip: Signal unfinished DMA transfers

When using DMA, the transfer_one callback should return 1 because the
transfer hasn't finished yet.

A previous commit changed the function to return 0 when the DMA channels
were correctly prepared.

This manifested in Veyron boards with this message:

[ 1.983605] cros-ec-spi spi0.0: EC failed to respond in time

Fixes: ea9849113343 ("spi: rockchip: check return value of dmaengine_prep_slave_sg")
Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-rockchip.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index cd89682065b9..1026e180eed7 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -578,7 +578,7 @@ static int rockchip_spi_transfer_one(
 		struct spi_device *spi,
 		struct spi_transfer *xfer)
 {
-	int ret = 1;
+	int ret = 0;
 	struct rockchip_spi *rs = spi_master_get_devdata(master);
 
 	WARN_ON(readl_relaxed(rs->regs + ROCKCHIP_SPI_SSIENR) &&
@@ -627,6 +627,8 @@ static int rockchip_spi_transfer_one(
 			spi_enable_chip(rs, 1);
 			ret = rockchip_spi_prepare_dma(rs);
 		}
+		/* successful DMA prepare means the transfer is in progress */
+		ret = ret ? ret : 1;
 	} else {
 		spi_enable_chip(rs, 1);
 		ret = rockchip_spi_pio_transfer(rs);
-- 
2.8.1
