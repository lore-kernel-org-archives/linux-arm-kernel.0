From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Fri, 16 Oct 2015 14:17:19 +0000
Subject: [PATCH] spi: bcm2835aux: fixed bad data on longer transfers
Message-ID: <1445005040-7230-1-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

There are strange issues with the auxiliary spi device that result
in "lost" data in the RX path if the fifo is filled by too much
(even though the status register is checked if new data can get filled
in).

This has been observed primarily for the interrupt case.
Polling works fine, probably because the RX fifo is pulled immediately
when in the tight polling loop.

For that reason we have to limit the pending bytes to less than 15
when filling the fifo in interrupt mode.

There also was an issue returning the "wrong" last 1/2 bytes
of a transfer when the transfer is not a multiple of 3 bytes.
(this impacted polling and interrupt modes)

Also fixed an overflow in the estimation of the transfer time used
to decide if we run in interrupt or polling mode (found with the
spi-bcm2835.c driver originally).

Reported-by: Georgii Staroselskii <georgii.staroselskii@emlid.com>
Signed-off-by: Martin Sperl <kernel@martin.sperl.org>

---
 drivers/spi/spi-bcm2835aux.c |   43 ++++++++++++++++++++++++++++++------------
 1 file changed, 31 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-bcm2835aux.c b/drivers/spi/spi-bcm2835aux.c
index 1a1b58c..7de6f84 100644
--- a/drivers/spi/spi-bcm2835aux.c
+++ b/drivers/spi/spi-bcm2835aux.c
@@ -104,6 +104,7 @@ struct bcm2835aux_spi {
 	u8 *rx_buf;
 	int tx_len;
 	int rx_len;
+	int pending;
 };
 
 static inline u32 bcm2835aux_rd(struct bcm2835aux_spi *bs, unsigned reg)
@@ -120,15 +121,27 @@ static inline void bcm2835aux_wr(struct bcm2835aux_spi *bs, unsigned reg,
 static inline void bcm2835aux_rd_fifo(struct bcm2835aux_spi *bs)
 {
 	u32 data;
-	int i;
 	int count = min(bs->rx_len, 3);
 
 	data = bcm2835aux_rd(bs, BCM2835_AUX_SPI_IO);
 	if (bs->rx_buf) {
-		for (i = 0; i < count; i++)
-			*bs->rx_buf++ = (data >> (8 * (2 - i))) & 0xff;
+		switch (count) {
+		case 4:
+			*bs->rx_buf++ = (data >> 24) & 0xff;
+			/* fallthrough */
+		case 3:
+			*bs->rx_buf++ = (data >> 16) & 0xff;
+			/* fallthrough */
+		case 2:
+			*bs->rx_buf++ = (data >> 8) & 0xff;
+			/* fallthrough */
+		case 1:
+			*bs->rx_buf++ = (data >> 0) & 0xff;
+			/* fallthrough - no default */
+		}
 	}
 	bs->rx_len -= count;
+	bs->pending -= count;
 }
 
 static inline void bcm2835aux_wr_fifo(struct bcm2835aux_spi *bs)
@@ -151,6 +164,7 @@ static inline void bcm2835aux_wr_fifo(struct bcm2835aux_spi *bs)
 
 	/* and decrement length */
 	bs->tx_len -= count;
+	bs->pending += count;
 
 	/* write to the correct TX-register */
 	if (bs->tx_len)
@@ -183,6 +197,7 @@ static irqreturn_t bcm2835aux_spi_interrupt(int irq, void *dev_id)
 
 	/* check if we have data to write */
 	while (bs->tx_len &&
+	       (bs->pending < 12) &&
 	       (!(bcm2835aux_rd(bs, BCM2835_AUX_SPI_STAT) &
 		  BCM2835_AUX_SPI_STAT_TX_FULL))) {
 		bcm2835aux_wr_fifo(bs);
@@ -234,6 +249,7 @@ static int bcm2835aux_spi_transfer_one_irq(struct spi_master *master,
 
 	/* fill in tx fifo with data before enabling interrupts */
 	while ((bs->tx_len) &&
+	       (bs->pending < 12) &&
 	       (!(bcm2835aux_rd(bs, BCM2835_AUX_SPI_STAT) &
 		  BCM2835_AUX_SPI_STAT_TX_FULL))) {
 		bcm2835aux_wr_fifo(bs);
@@ -245,8 +261,7 @@ static int bcm2835aux_spi_transfer_one_irq(struct spi_master *master,
 
 static int bcm2835aux_spi_transfer_one_poll(struct spi_master *master,
 					    struct spi_device *spi,
-					    struct spi_transfer *tfr,
-					    unsigned long xfer_time_us)
+					struct spi_transfer *tfr)
 {
 	struct bcm2835aux_spi *bs = spi_master_get_devdata(master);
 	unsigned long timeout;
@@ -305,7 +320,8 @@ static int bcm2835aux_spi_transfer_one(struct spi_master *master,
 {
 	struct bcm2835aux_spi *bs = spi_master_get_devdata(master);
 	unsigned long spi_hz, clk_hz, speed;
-	unsigned long spi_used_hz, xfer_time_us;
+	unsigned long spi_used_hz;
+	unsigned long long xfer_time_us;
 
 	/* calculate the registers to handle
 	 *
@@ -348,16 +364,19 @@ static int bcm2835aux_spi_transfer_one(struct spi_master *master,
 	bs->rx_buf = tfr->rx_buf;
 	bs->tx_len = tfr->len;
 	bs->rx_len = tfr->len;
+	bs->pending = 0;
 
-	/* calculate the estimated time in us the transfer runs */
-	xfer_time_us = tfr->len
-		* 9 /* clocks/byte - SPI-HW waits 1 clock after each byte */
-		* 1000000 / spi_used_hz;
+	/* calculate the estimated time in us the transfer runs
+	 * note that there are are 2 idle clocks after each
+	 * chunk getting transferred - in our case the chunk size
+	 * is 3 bytes, so we approximate this by 9 bits/byte
+	 */
+	xfer_time_us = tfr->len * 9 * 1000000;
+	do_div(xfer_time_us, spi_used_hz);
 
 	/* run in polling mode for short transfers */
 	if (xfer_time_us < BCM2835_AUX_SPI_POLLING_LIMIT_US)
-		return bcm2835aux_spi_transfer_one_poll(master, spi, tfr,
-							xfer_time_us);
+		return bcm2835aux_spi_transfer_one_poll(master, spi, tfr);
 
 	/* run in interrupt mode for all others */
 	return bcm2835aux_spi_transfer_one_irq(master, spi, tfr);
-- 
1.7.10.4
