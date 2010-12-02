From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Thu,  2 Dec 2010 18:47:36 +0100
Subject: [PATCH 8/9] spi/pxa2xx: Modify RX-Tresh instead of busy-loop for the
	remaining RX bytes.
In-Reply-To: <1291312057-7933-1-git-send-email-bigeasy@linutronix.de>
References: <1291312057-7933-1-git-send-email-bigeasy@linutronix.de>
Message-ID: <1291312057-7933-9-git-send-email-bigeasy@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After all TX bytes are sent, the driver spins while the SPI core is busy
and then it spins for a "short" period of time until RX bytes are
available.
On Sodavile the busy flag disappears pretty quick and after that it
takes approx ~130ms (sometimes less but not much) until there are bytes
available in the RX FIFO.
This patch removes the busy loop and modifies the RX threshould so we
get woken up once the remainings bytes arrived.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Dirk Brandewie <dirk.brandewie@gmail.com>
---
 drivers/spi/pxa2xx_spi.c |   56 ++++++++++++++++++++++++++++++++--------------
 1 files changed, 39 insertions(+), 17 deletions(-)

diff --git a/drivers/spi/pxa2xx_spi.c b/drivers/spi/pxa2xx_spi.c
index a54685b..9ca6454 100644
--- a/drivers/spi/pxa2xx_spi.c
+++ b/drivers/spi/pxa2xx_spi.c
@@ -660,13 +660,25 @@ static irqreturn_t dma_transfer(struct driver_data *drv_data)
 	return IRQ_NONE;
 }
 
+static void reset_sccr1(struct driver_data *drv_data)
+{
+	void __iomem *reg = drv_data->ioaddr;
+	struct chip_data *chip = drv_data->cur_chip;
+	u32 sccr1_reg;
+
+	sccr1_reg = read_SSCR1(reg) & ~drv_data->int_cr1;
+	sccr1_reg &= ~SSCR1_RFT;
+	sccr1_reg |= chip->threshold;
+	write_SSCR1(sccr1_reg, reg);
+}
+
 static void int_error_stop(struct driver_data *drv_data, const char* msg)
 {
 	void __iomem *reg = drv_data->ioaddr;
 
 	/* Stop and reset SSP */
 	write_SSSR_CS(drv_data, drv_data->clear_sr);
-	write_SSCR1(read_SSCR1(reg) & ~drv_data->int_cr1, reg);
+	reset_sccr1(drv_data);
 	if (!pxa25x_ssp_comp(drv_data))
 		write_SSTO(0, reg);
 	flush(drv_data);
@@ -684,7 +696,7 @@ static void int_transfer_complete(struct driver_data *drv_data)
 
 	/* Stop SSP */
 	write_SSSR_CS(drv_data, drv_data->clear_sr);
-	write_SSCR1(read_SSCR1(reg) & ~drv_data->int_cr1, reg);
+	reset_sccr1(drv_data);
 	if (!pxa25x_ssp_comp(drv_data))
 		write_SSTO(0, reg);
 
@@ -739,24 +751,34 @@ static irqreturn_t interrupt_transfer(struct driver_data *drv_data)
 	}
 
 	if (drv_data->tx == drv_data->tx_end) {
-		write_SSCR1(read_SSCR1(reg) & ~SSCR1_TIE, reg);
-		/* PXA25x_SSP has no timeout, read trailing bytes */
+		u32 bytes_left;
+		u32 sccr1_reg;
+
+		sccr1_reg = read_SSCR1(reg);
+		sccr1_reg &= ~SSCR1_TIE;
+
+		/*
+		 * PXA25x_SSP has no timeout, set up rx threshould for the
+		 * remaing RX bytes.
+		 */
 		if (pxa25x_ssp_comp(drv_data)) {
-			if (!wait_ssp_rx_stall(reg))
-			{
-				int_error_stop(drv_data, "interrupt_transfer: "
-						"rx stall failed");
-				return IRQ_HANDLED;
-			}
-			if (!drv_data->read(drv_data))
-			{
-				int_error_stop(drv_data,
-						"interrupt_transfer: "
-						"trailing byte read failed");
-				return IRQ_HANDLED;
+
+			sccr1_reg &= ~SSCR1_RFT;
+
+			bytes_left = drv_data->rx_end - drv_data->rx;
+			switch (drv_data->n_bytes) {
+			case 4:
+				bytes_left >>= 1;
+			case 2:
+				bytes_left >>= 1;
 			}
-			int_transfer_complete(drv_data);
+
+			if (bytes_left > RX_THRESH_DFLT)
+				bytes_left = RX_THRESH_DFLT;
+
+			sccr1_reg |= SSCR1_RxTresh(bytes_left);
 		}
+		write_SSCR1(sccr1_reg, reg);
 	}
 
 	/* We did something */
-- 
1.7.3.2
