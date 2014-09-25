From: addy.ke@rock-chips.com (Addy Ke)
Date: Thu, 25 Sep 2014 14:59:41 +0800
Subject: [PATCH] spi/rockchip: fix bug that cause the failture to read data in
 DMA mode
Message-ID: <1411628381-4029-1-git-send-email-addy.ke@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In my test on RK3288-pinky board, if spi is enabled, it will begin to
read data from slave regardless of whether the DMA is ready. So we
need prepare DMA before spi is enable.

Signed-off-by: Addy Ke <addy.ke@rock-chips.com>
---
 drivers/spi/spi-rockchip.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 3afc266..f96ea8a 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -415,7 +415,7 @@ static void rockchip_spi_dma_txcb(void *data)
 	spin_unlock_irqrestore(&rs->lock, flags);
 }
 
-static int rockchip_spi_dma_transfer(struct rockchip_spi *rs)
+static void rockchip_spi_prepare_dma(struct rockchip_spi *rs)
 {
 	unsigned long flags;
 	struct dma_slave_config rxconf, txconf;
@@ -474,8 +474,6 @@ static int rockchip_spi_dma_transfer(struct rockchip_spi *rs)
 		dmaengine_submit(txdesc);
 		dma_async_issue_pending(rs->dma_tx.ch);
 	}
-
-	return 1;
 }
 
 static void rockchip_spi_config(struct rockchip_spi *rs)
@@ -557,16 +555,17 @@ static int rockchip_spi_transfer_one(
 	else if (rs->rx)
 		rs->tmode = CR0_XFM_RO;
 
-	if (master->can_dma && master->can_dma(master, spi, xfer))
+	/* we need prepare dma before spi was enabled */
+	if (master->can_dma && master->can_dma(master, spi, xfer)) {
 		rs->use_dma = 1;
-	else
+		rockchip_spi_prepare_dma(rs);
+	} else {
 		rs->use_dma = 0;
+	}
 
 	rockchip_spi_config(rs);
 
-	if (rs->use_dma)
-		ret = rockchip_spi_dma_transfer(rs);
-	else
+	if (!rs->use_dma)
 		ret = rockchip_spi_pio_transfer(rs);
 
 	return ret;
-- 
1.8.3.2
