From: addy.ke@rock-chips.com (Addy Ke)
Date: Wed, 15 Oct 2014 19:26:18 +0800
Subject: [PATCH 2/2] spi/rockchip: fix bug that cause spi transfer timed out
 in DMA duplex mode
In-Reply-To: <1413372311-4203-1-git-send-email-addy.ke@rock-chips.com>
References: <1413372311-4203-1-git-send-email-addy.ke@rock-chips.com>
Message-ID: <1413372378-4309-1-git-send-email-addy.ke@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In rx mode, dma must be prepared before spi is enabled.
But in tx and tr mode, spi must be enabled first.

Signed-off-by: Addy Ke <addy.ke@rock-chips.com>
---
 drivers/spi/spi-rockchip.c | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 3044c6c..153269b 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -328,6 +328,8 @@ static int rockchip_spi_unprepare_message(struct spi_master *master,
 
 	spin_unlock_irqrestore(&rs->lock, flags);
 
+	spi_enable_chip(rs, 0);
+
 	return 0;
 }
 
@@ -384,6 +386,8 @@ static int rockchip_spi_pio_transfer(struct rockchip_spi *rs)
 	if (rs->tx)
 		wait_for_idle(rs);
 
+	spi_enable_chip(rs, 0);
+
 	return 0;
 }
 
@@ -395,8 +399,10 @@ static void rockchip_spi_dma_rxcb(void *data)
 	spin_lock_irqsave(&rs->lock, flags);
 
 	rs->state &= ~RXBUSY;
-	if (!(rs->state & TXBUSY))
+	if (!(rs->state & TXBUSY)) {
+		spi_enable_chip(rs, 0);
 		spi_finalize_current_transfer(rs->master);
+	}
 
 	spin_unlock_irqrestore(&rs->lock, flags);
 }
@@ -512,8 +518,6 @@ static void rockchip_spi_config(struct rockchip_spi *rs)
 	div = max_t(u32, rs->max_freq / rs->speed, 1);
 	div = (div + 1) & 0xfffe;
 
-	spi_enable_chip(rs, 0);
-
 	writel_relaxed(cr0, rs->regs + ROCKCHIP_SPI_CTRLR0);
 
 	writel_relaxed(rs->len - 1, rs->regs + ROCKCHIP_SPI_CTRLR1);
@@ -527,8 +531,6 @@ static void rockchip_spi_config(struct rockchip_spi *rs)
 	spi_set_clk(rs, div);
 
 	dev_dbg(rs->dev, "cr0 0x%x, div %d\n", cr0, div);
-
-	spi_enable_chip(rs, 1);
 }
 
 static int rockchip_spi_transfer_one(
@@ -536,7 +538,7 @@ static int rockchip_spi_transfer_one(
 		struct spi_device *spi,
 		struct spi_transfer *xfer)
 {
-	int ret = 0;
+	int ret = 1;
 	struct rockchip_spi *rs = spi_master_get_devdata(master);
 
 	WARN_ON(readl_relaxed(rs->regs + ROCKCHIP_SPI_SSIENR) &&
@@ -568,17 +570,27 @@ static int rockchip_spi_transfer_one(
 		rs->tmode = CR0_XFM_RO;
 
 	/* we need prepare dma before spi was enabled */
-	if (master->can_dma && master->can_dma(master, spi, xfer)) {
+	if (master->can_dma && master->can_dma(master, spi, xfer))
 		rs->use_dma = 1;
-		rockchip_spi_prepare_dma(rs);
-	} else {
+	else
 		rs->use_dma = 0;
-	}
 
 	rockchip_spi_config(rs);
 
-	if (!rs->use_dma)
+	if (rs->use_dma) {
+		if (rs->tmode == CR0_XFM_RO) {
+			/* rx: dma must be prepared first */
+			rockchip_spi_prepare_dma(rs);
+			spi_enable_chip(rs, 1);
+		} else {
+			/* tx or tr: spi must be enabled first */
+			spi_enable_chip(rs, 1);
+			rockchip_spi_prepare_dma(rs);
+		}
+	} else {
+		spi_enable_chip(rs, 1);
 		ret = rockchip_spi_pio_transfer(rs);
+	}
 
 	return ret;
 }
-- 
1.8.3.2
