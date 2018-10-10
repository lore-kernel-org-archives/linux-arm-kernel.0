From: kernel@esmil.dk (Emil Renner Berthing)
Date: Wed, 10 Oct 2018 11:00:38 +0200
Subject: [PATCH 7/7] spi: rockchip: simplify spi enable logic
In-Reply-To: <20181010090038.20834-1-kernel@esmil.dk>
References: <20181010090038.20834-1-kernel@esmil.dk>
Message-ID: <20181010090038.20834-8-kernel@esmil.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Let the dma/non-dma code paths handle the spi enable
flag themselves. This removes some logic to determine
if the flag should be turned on before or after dma
and also don't leave the spi enabled if the dma path
fails.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
---
 drivers/spi/spi-rockchip.c | 28 +++++++++-------------------
 1 file changed, 9 insertions(+), 19 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 1044849a352d..51ef632bca52 100644
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
@@ -501,6 +503,8 @@ static int rockchip_spi_prepare_dma(struct rockchip_spi *rs)
 		dma_async_issue_pending(rs->dma_rx.ch);
 	}
 
+	spi_enable_chip(rs, 1);
+
 	if (txdesc) {
 		spin_lock_irqsave(&rs->lock, flags);
 		rs->state |= TXBUSY;
@@ -509,7 +513,8 @@ static int rockchip_spi_prepare_dma(struct rockchip_spi *rs)
 		dma_async_issue_pending(rs->dma_tx.ch);
 	}
 
-	return 0;
+	/* 1 means the transfer is in progress */
+	return 1;
 }
 
 static void rockchip_spi_config(struct rockchip_spi *rs)
@@ -592,7 +597,6 @@ static int rockchip_spi_transfer_one(
 		struct spi_device *spi,
 		struct spi_transfer *xfer)
 {
-	int ret = 0;
 	struct rockchip_spi *rs = spi_master_get_devdata(master);
 
 	WARN_ON(readl_relaxed(rs->regs + ROCKCHIP_SPI_SSIENR) &&
@@ -636,24 +640,10 @@ static int rockchip_spi_transfer_one(
 
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
2.19.1
