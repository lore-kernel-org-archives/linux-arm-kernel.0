From: tpiepho@impinj.com (Trent Piepho)
Date: Mon, 12 Feb 2018 11:38:14 -0800
Subject: [PATCH] spi: bcm2835aux: Avoid 64-bit arithmetic in xfer len calc
In-Reply-To: <1518463905.25398.281.camel@impinj.com>
References: <1518463905.25398.281.camel@impinj.com>
Message-ID: <20180212193814.17644-1-tpiepho@impinj.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We want to check for xfers that are over 30 microseconds.  Rather than
find how many ?s a xfer will take, instead find how many bytes can be
transferred in 30 ?s.  The latter must be less than 32 bits (since our
clock speed is limited to 32 bits), while the former involves 64 bit
quantities and more arithmetic operations.

Signed-off-by: Trent Piepho <tpiepho@impinj.com>
---
 drivers/spi/spi-bcm2835aux.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-bcm2835aux.c b/drivers/spi/spi-bcm2835aux.c
index 7428091d3f5b..1431cb98fe40 100644
--- a/drivers/spi/spi-bcm2835aux.c
+++ b/drivers/spi/spi-bcm2835aux.c
@@ -321,7 +321,6 @@ static int bcm2835aux_spi_transfer_one(struct spi_master *master,
 	struct bcm2835aux_spi *bs = spi_master_get_devdata(master);
 	unsigned long spi_hz, clk_hz, speed;
 	unsigned long spi_used_hz;
-	unsigned long long xfer_time_us;
 
 	/* calculate the registers to handle
 	 *
@@ -358,20 +357,21 @@ static int bcm2835aux_spi_transfer_one(struct spi_master *master,
 	bs->rx_len = tfr->len;
 	bs->pending = 0;
 
-	/* calculate the estimated time in us the transfer runs
-	 * note that there are are 2 idle clocks after each
-	 * chunk getting transferred - in our case the chunk size
-	 * is 3 bytes, so we approximate this by 9 bits/byte
+	/* Calculate the estimated time in us the transfer runs.  Note that
+	 * there are are 2 idle clocks cycles after each chunk getting
+	 * transferred - in our case the chunk size is 3 bytes, so we
+	 * approximate this by 9 cycles/byte.  This is used to find the number
+	 * of Hz per byte per polling limit.  E.g., we can transfer 1 byte in
+	 * 30 ?s per 300,000 Hz of bus clock.
 	 */
-	xfer_time_us = tfr->len * 9 * 1000000;
-	do_div(xfer_time_us, spi_used_hz);
-
+#define HZ_PER_BYTE ((9 * 1000000) / BCM2835_AUX_SPI_POLLING_LIMIT_US)
 	/* run in polling mode for short transfers */
-	if (xfer_time_us < BCM2835_AUX_SPI_POLLING_LIMIT_US)
+	if (tfr->len < spi_used_hz / HZ_PER_BYTE)
 		return bcm2835aux_spi_transfer_one_poll(master, spi, tfr);
 
 	/* run in interrupt mode for all others */
 	return bcm2835aux_spi_transfer_one_irq(master, spi, tfr);
+#undef HZ_PER_BYTE
 }
 
 static int bcm2835aux_spi_prepare_message(struct spi_master *master,
-- 
2.14.3
