From: addy.ke@rock-chips.com (Addy Ke)
Date: Fri, 11 Jul 2014 10:08:24 +0800
Subject: [PATCH 2/4] spi/rockchip: call wait_for_idle() for the transfer to
 complete
In-Reply-To: <1405044389-6800-1-git-send-email-addy.ke@rock-chips.com>
References: <1405044389-6800-1-git-send-email-addy.ke@rock-chips.com>
Message-ID: <1405044504-6917-1-git-send-email-addy.ke@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Addy Ke <addy.ke@rockchip.com>

Suggested-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Addy Ke <addy.ke@rockchip.com>
---
 drivers/spi/spi-rockchip.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 8c24708..09c690c 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -214,6 +214,18 @@ static inline void flush_fifo(struct rockchip_spi *rs)
 		readl_relaxed(rs->regs + ROCKCHIP_SPI_RXDR);
 }
 
+static inline void wait_for_idle(struct rockchip_spi *rs)
+{
+	unsigned long timeout = jiffies + msecs_to_jiffies(5);
+
+	do {
+		if (!(readl_relaxed(rs->regs + ROCKCHIP_SPI_SR) & SR_BUSY))
+			return;
+	} while (time_before(jiffies, timeout));
+
+	dev_warn(rs->dev, "spi controller is in busy state!\n");
+}
+
 static u32 get_fifo_len(struct rockchip_spi *rs)
 {
 	u32 fifo;
@@ -371,6 +383,10 @@ static int rockchip_spi_pio_transfer(struct rockchip_spi *rs)
 		cpu_relax();
 	} while (remain);
 
+	/* If tx, wait until the FIFO data completely. */
+	if (rs->tx)
+		wait_for_idle(rs);
+
 	return 0;
 }
 
@@ -393,6 +409,9 @@ static void rockchip_spi_dma_txcb(void *data)
 	unsigned long flags;
 	struct rockchip_spi *rs = data;
 
+	/* Wait until the FIFO data completely. */
+	wait_for_idle(rs);
+
 	spin_lock_irqsave(&rs->lock, flags);
 
 	rs->state &= ~TXBUSY;
@@ -536,11 +555,6 @@ static int rockchip_spi_transfer_one(
 	rs->tx_sg = xfer->tx_sg;
 	rs->rx_sg = xfer->rx_sg;
 
-	/* Delay until the FIFO data completely */
-	if (xfer->tx_buf)
-		xfer->delay_usecs
-			= rs->fifo_len * rs->bpw * 1000000 / rs->speed;
-
 	if (rs->tx && rs->rx)
 		rs->tmode = CR0_XFM_TR;
 	else if (rs->tx)
-- 
1.8.3.2
