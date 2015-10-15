From: shawn.lin@rock-chips.com (Shawn Lin)
Date: Thu, 15 Oct 2015 09:36:26 +0800
Subject: [PATCH v6 08/10] spi: rockchip: modify DMA max burst to 1
In-Reply-To: <1444872865-2169-1-git-send-email-shawn.lin@rock-chips.com>
References: <1444872865-2169-1-git-send-email-shawn.lin@rock-chips.com>
Message-ID: <1444872986-2507-1-git-send-email-shawn.lin@rock-chips.com>
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

Changes in v6:
- remove quirks and get dma caps in order to limit burst

Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None
Changes in v1: None

 drivers/spi/spi-rockchip.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 79a8bc4..aa9561f 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -199,6 +199,7 @@ struct rockchip_spi {
 	struct sg_table rx_sg;
 	struct rockchip_spi_dma_data dma_rx;
 	struct rockchip_spi_dma_data dma_tx;
+	struct dma_slave_caps dma_caps;
 };
 
 static inline void spi_enable_chip(struct rockchip_spi *rs, int enable)
@@ -449,7 +450,10 @@ static void rockchip_spi_prepare_dma(struct rockchip_spi *rs)
 		rxconf.direction = rs->dma_rx.direction;
 		rxconf.src_addr = rs->dma_rx.addr;
 		rxconf.src_addr_width = rs->n_bytes;
-		rxconf.src_maxburst = rs->n_bytes;
+		if (rs->dma_caps.max_burst > 4)
+			rxconf.src_maxburst = 4;
+		else
+			rxconf.src_maxburst = 1;
 		dmaengine_slave_config(rs->dma_rx.ch, &rxconf);
 
 		rxdesc = dmaengine_prep_slave_sg(
@@ -466,7 +470,10 @@ static void rockchip_spi_prepare_dma(struct rockchip_spi *rs)
 		txconf.direction = rs->dma_tx.direction;
 		txconf.dst_addr = rs->dma_tx.addr;
 		txconf.dst_addr_width = rs->n_bytes;
-		txconf.dst_maxburst = rs->n_bytes;
+		if (rs->dma_caps.max_burst > 4)
+			txconf.dst_maxburst = 4;
+		else
+			txconf.dst_maxburst = 1;
 		dmaengine_slave_config(rs->dma_tx.ch, &txconf);
 
 		txdesc = dmaengine_prep_slave_sg(
@@ -730,6 +737,7 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 	}
 
 	if (rs->dma_tx.ch && rs->dma_rx.ch) {
+		dma_get_slave_caps(rs->dma_rx.ch, &(rs->dma_caps));
 		rs->dma_tx.addr = (dma_addr_t)(mem->start + ROCKCHIP_SPI_TXDR);
 		rs->dma_rx.addr = (dma_addr_t)(mem->start + ROCKCHIP_SPI_RXDR);
 		rs->dma_tx.direction = DMA_MEM_TO_DEV;
-- 
2.3.7
