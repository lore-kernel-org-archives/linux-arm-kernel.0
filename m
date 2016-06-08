From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Wed,  8 Jun 2016 09:32:51 +0200
Subject: [PATCH] spi: rockchip: Signal unfinished DMA transfers
Message-ID: <1465371171-20810-1-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When using DMA, the transfer_one callback should return 1 because the
transfer hasn't finished yet.

A previous commit changed the function to return 0 when the DMA channels
were correctly prepared.

This manifested in Veyron boards with this message:

[ 1.983605] cros-ec-spi spi0.0: EC failed to respond in time

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Fixes: ea9849113343 ("spi: rockchip: check return value of
dmaengine_prep_slave_sg")
Cc: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Javier Martinez Canillas <javier@osg.samsung.com>
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
2.5.5
