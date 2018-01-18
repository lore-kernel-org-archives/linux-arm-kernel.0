From: broonie@kernel.org (Mark Brown)
Date: Thu, 18 Jan 2018 11:23:21 +0000
Subject: Applied "spi: a3700: Add full-duplex support" to the spi tree
In-Reply-To: <1516205728-3256-5-git-send-email-maxime.chevallier@smile.fr>
Message-ID: <E1ec8Hx-0003sc-Ms@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: a3700: Add full-duplex support

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From f68a7dcb91b7957c5bb1c3e347775332af719519 Mon Sep 17 00:00:00 2001
From: Maxime Chevallier <maxime.chevallier@smile.fr>
Date: Wed, 17 Jan 2018 17:15:28 +0100
Subject: [PATCH] spi: a3700: Add full-duplex support

The armada 3700 SPI controller has support for full-duplex transfers,
but it can only be done without using the hardware FIFOs.

A full duplex transfer is done by shifting 4 bytes at a time, or even
one byte at a time for transfers less than 4 bytes long.

While this method is perfectly suitable for small transfers, it is still
slower than using the FIFOs.

This commit implement full-duplex support, making sure that half-duplex
transfers are still done using the FIFOs with the existing method.

Some setup functions were moved around to make sure the controller is
properly configured before beginning each transfer.

This was tested on EspressoBin with a logical analyser, and a simple
setup where MISO is connected on MOSI. Transfers were made from
userspace using spidev and spi-pipe from the spi-tools project

Signed-off-by: Maxime Chevallier <maxime.chevallier@smile.fr>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-armada-3700.c | 85 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 73 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-armada-3700.c b/drivers/spi/spi-armada-3700.c
index 97938c6d6267..fdc35dabcda2 100644
--- a/drivers/spi/spi-armada-3700.c
+++ b/drivers/spi/spi-armada-3700.c
@@ -413,15 +413,20 @@ static void a3700_spi_transfer_setup(struct spi_device *spi,
 				     struct spi_transfer *xfer)
 {
 	struct a3700_spi *a3700_spi;
-	unsigned int byte_len;
 
 	a3700_spi = spi_master_get_devdata(spi->master);
 
 	a3700_spi_clock_set(a3700_spi, xfer->speed_hz);
 
-	byte_len = xfer->bits_per_word >> 3;
+	/* Use 4 bytes long transfers. Each transfer method has its way to deal
+	 * with the remaining bytes for non 4-bytes aligned transfers.
+	 */
+	a3700_spi_bytelen_set(a3700_spi, 4);
 
-	a3700_spi_fifo_thres_set(a3700_spi, byte_len);
+	/* Initialize the working buffers */
+	a3700_spi->tx_buf  = xfer->tx_buf;
+	a3700_spi->rx_buf  = xfer->rx_buf;
+	a3700_spi->buf_len = xfer->len;
 }
 
 static void a3700_spi_set_cs(struct spi_device *spi, bool enable)
@@ -576,27 +581,26 @@ static int a3700_spi_prepare_message(struct spi_master *master,
 	if (ret)
 		return ret;
 
-	a3700_spi_bytelen_set(a3700_spi, 4);
-
 	a3700_spi_mode_set(a3700_spi, spi->mode);
 
 	return 0;
 }
 
-static int a3700_spi_transfer_one(struct spi_master *master,
+static int a3700_spi_transfer_one_fifo(struct spi_master *master,
 				  struct spi_device *spi,
 				  struct spi_transfer *xfer)
 {
 	struct a3700_spi *a3700_spi = spi_master_get_devdata(master);
 	int ret = 0, timeout = A3700_SPI_TIMEOUT;
-	unsigned int nbits = 0;
+	unsigned int nbits = 0, byte_len;
 	u32 val;
 
-	a3700_spi_transfer_setup(spi, xfer);
+	/* Make sure we use FIFO mode */
+	a3700_spi_fifo_mode_set(a3700_spi, true);
 
-	a3700_spi->tx_buf  = xfer->tx_buf;
-	a3700_spi->rx_buf  = xfer->rx_buf;
-	a3700_spi->buf_len = xfer->len;
+	/* Configure FIFO thresholds */
+	byte_len = xfer->bits_per_word >> 3;
+	a3700_spi_fifo_thres_set(a3700_spi, byte_len);
 
 	if (xfer->tx_buf)
 		nbits = xfer->tx_nbits;
@@ -731,6 +735,64 @@ static int a3700_spi_transfer_one(struct spi_master *master,
 	return ret;
 }
 
+static int a3700_spi_transfer_one_full_duplex(struct spi_master *master,
+				  struct spi_device *spi,
+				  struct spi_transfer *xfer)
+{
+	struct a3700_spi *a3700_spi = spi_master_get_devdata(master);
+	u32 val_in, val_out;
+
+	/* Disable FIFO mode */
+	a3700_spi_fifo_mode_set(a3700_spi, false);
+
+	while (a3700_spi->buf_len) {
+
+		/* When we have less than 4 bytes to transfer, switch to 1 byte
+		 * mode. This is reset after each transfer
+		 */
+		if (a3700_spi->buf_len < 4)
+			a3700_spi_bytelen_set(a3700_spi, 1);
+
+		if (a3700_spi->byte_len == 1)
+			val_out = *a3700_spi->tx_buf;
+		else
+			val_out = cpu_to_le32(*(u32 *)a3700_spi->tx_buf);
+
+		spireg_write(a3700_spi, A3700_SPI_DATA_OUT_REG, val_out);
+
+		/* Wait for all the data to be shifted in / out */
+		while (!(spireg_read(a3700_spi, A3700_SPI_IF_CTRL_REG) &
+				A3700_SPI_XFER_DONE))
+			cpu_relax();
+
+		val_in = le32_to_cpu(spireg_read(a3700_spi,
+						 A3700_SPI_DATA_IN_REG));
+
+		memcpy(a3700_spi->rx_buf, &val_in, a3700_spi->byte_len);
+
+		a3700_spi->buf_len -= a3700_spi->byte_len;
+		a3700_spi->tx_buf += a3700_spi->byte_len;
+		a3700_spi->rx_buf += a3700_spi->byte_len;
+
+	}
+
+	spi_finalize_current_transfer(master);
+
+	return 0;
+}
+
+static int a3700_spi_transfer_one(struct spi_master *master,
+				  struct spi_device *spi,
+				  struct spi_transfer *xfer)
+{
+	a3700_spi_transfer_setup(spi, xfer);
+
+	if (xfer->tx_buf && xfer->rx_buf)
+		return a3700_spi_transfer_one_full_duplex(master, spi, xfer);
+
+	return a3700_spi_transfer_one_fifo(master, spi, xfer);
+}
+
 static int a3700_spi_unprepare_message(struct spi_master *master,
 				       struct spi_message *message)
 {
@@ -780,7 +842,6 @@ static int a3700_spi_probe(struct platform_device *pdev)
 	master->transfer_one = a3700_spi_transfer_one;
 	master->unprepare_message = a3700_spi_unprepare_message;
 	master->set_cs = a3700_spi_set_cs;
-	master->flags = SPI_MASTER_HALF_DUPLEX;
 	master->mode_bits |= (SPI_RX_DUAL | SPI_TX_DUAL |
 			      SPI_RX_QUAD | SPI_TX_QUAD);
 
-- 
2.15.1
