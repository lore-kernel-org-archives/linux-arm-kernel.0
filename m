From: shawn.lin@rock-chips.com (Shawn Lin)
Date: Mon, 14 Sep 2015 07:49:19 +0800
Subject: [PATCH v5 08/10] spi: rockchip: modify DMA max burst to 1
In-Reply-To: <1442187923-5736-1-git-send-email-shawn.lin@rock-chips.com>
References: <1442187923-5736-1-git-send-email-shawn.lin@rock-chips.com>
Message-ID: <1442188159-6099-1-git-send-email-shawn.lin@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Addy Ke <addy.ke@rock-chips.com>

Generic dma controller on Rockchips' platform cannot support
DMAFLUSHP instruction which make dma to flush the req of non-aligned
or non-multiple of what we need. That will cause an unrecoverable
dma bus error. The saftest way is to set dma max burst to 1.

Signed-off-by: Addy ke <addy.ke@rock-chips.com>
Fixes: 64e36824b32b06 ("spi/rockchip: add driver for Rockchip...")
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
cc: Heiko Stuebner <heiko@sntech.de>
cc: Olof Johansson <olof@lixom.net>
cc: Doug Anderson <dianders@chromium.org>
cc: Sonny Rao <sonnyrao@chromium.org>
Acked-by: Mark Brown <broonie@kernel.org>
---

Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None
Changes in v1: None

 drivers/spi/spi-rockchip.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 68e7efe..89dd3d8 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -199,6 +199,8 @@ struct rockchip_spi {
 	struct sg_table rx_sg;
 	struct rockchip_spi_dma_data dma_rx;
 	struct rockchip_spi_dma_data dma_tx;
+	int dma_quirk;
+#define ROCKCHIP_SPI_BROKEN_BURST_LEN (1<<0) /* broken burst len*/
 };
 
 static inline void spi_enable_chip(struct rockchip_spi *rs, int enable)
@@ -449,7 +451,10 @@ static void rockchip_spi_prepare_dma(struct rockchip_spi *rs)
 		rxconf.direction = rs->dma_rx.direction;
 		rxconf.src_addr = rs->dma_rx.addr;
 		rxconf.src_addr_width = rs->n_bytes;
-		rxconf.src_maxburst = rs->n_bytes;
+		if (rs->dma_quirk == ROCKCHIP_SPI_BROKEN_BURST_LEN)
+			rxconf.src_maxburst = 1;
+		else
+			rxconf.src_maxburst = 4;
 		dmaengine_slave_config(rs->dma_rx.ch, &rxconf);
 
 		rxdesc = dmaengine_prep_slave_sg(
@@ -466,7 +471,10 @@ static void rockchip_spi_prepare_dma(struct rockchip_spi *rs)
 		txconf.direction = rs->dma_tx.direction;
 		txconf.dst_addr = rs->dma_tx.addr;
 		txconf.dst_addr_width = rs->n_bytes;
-		txconf.dst_maxburst = rs->n_bytes;
+		if (rs->dma_quirk == ROCKCHIP_SPI_BROKEN_BURST_LEN)
+			txconf.dst_maxburst = 1;
+		else
+			txconf.dst_maxburst = 4;
 		dmaengine_slave_config(rs->dma_tx.ch, &txconf);
 
 		txdesc = dmaengine_prep_slave_sg(
@@ -731,6 +739,7 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 	}
 
 	if (rs->dma_tx.ch && rs->dma_rx.ch) {
+		rs->dma_quirk = dmaengine_get_quirks(rs->dma_rx.ch);
 		rs->dma_tx.addr = (dma_addr_t)(mem->start + ROCKCHIP_SPI_TXDR);
 		rs->dma_rx.addr = (dma_addr_t)(mem->start + ROCKCHIP_SPI_RXDR);
 		rs->dma_tx.direction = DMA_MEM_TO_DEV;
-- 
2.3.7
