From: kernel@esmil.dk (Emil Renner Berthing)
Date: Wed, 10 Oct 2018 11:00:33 +0200
Subject: [PATCH 2/7] spi: rockchip: adjust dma watermark and burstlen
In-Reply-To: <20181010090038.20834-1-kernel@esmil.dk>
References: <20181010090038.20834-1-kernel@esmil.dk>
Message-ID: <20181010090038.20834-3-kernel@esmil.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Huibin Hong <huibin.hong@rock-chips.com>

Signal tx dma when spi fifo is less than half full,
and limit tx bursts to half the fifo length.

Clamp rx burst length to 1 to avoid alignment issues.

Signed-off-by: Huibin Hong <huibin.hong@rock-chips.com>
Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
---
 drivers/spi/spi-rockchip.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 185bbdce62b1..ede3002215cd 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -458,10 +458,7 @@ static int rockchip_spi_prepare_dma(struct rockchip_spi *rs)
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
@@ -480,10 +477,7 @@ static int rockchip_spi_prepare_dma(struct rockchip_spi *rs)
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
@@ -581,7 +575,7 @@ static void rockchip_spi_config(struct rockchip_spi *rs)
 	writel_relaxed(rs->fifo_len / 2 - 1, rs->regs + ROCKCHIP_SPI_TXFTLR);
 	writel_relaxed(rs->fifo_len / 2 - 1, rs->regs + ROCKCHIP_SPI_RXFTLR);
 
-	writel_relaxed(0, rs->regs + ROCKCHIP_SPI_DMATDLR);
+	writel_relaxed(rs->fifo_len / 2 - 1, rs->regs + ROCKCHIP_SPI_DMATDLR);
 	writel_relaxed(0, rs->regs + ROCKCHIP_SPI_DMARDLR);
 	writel_relaxed(dmacr, rs->regs + ROCKCHIP_SPI_DMACR);
 
-- 
2.19.1
