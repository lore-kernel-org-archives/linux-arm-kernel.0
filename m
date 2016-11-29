From: romain.perier@free-electrons.com (Romain Perier)
Date: Tue, 29 Nov 2016 15:39:36 +0100
Subject: [PATCH 2/5] spi: armada-3700: Add support for the FIFO mode
In-Reply-To: <20161129143939.3191-1-romain.perier@free-electrons.com>
References: <20161129143939.3191-1-romain.perier@free-electrons.com>
Message-ID: <20161129143939.3191-3-romain.perier@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In FIFO mode, dedicated registers are used to store the instruction,
the address, the read mode and the data. Write and Read FIFO are used
to store the outcoming or incoming data. The CPU no longer has to assert
each byte. The data FIFOs are accessible via DMA or by the CPU.

This commit adds support for the FIFO mode with the CPU.

Signed-off-by: Romain Perier <romain.perier@free-electrons.com>
---
 drivers/spi/spi-armada-3700.c | 408 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 398 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-armada-3700.c b/drivers/spi/spi-armada-3700.c
index 1e8298c..c4febe4 100644
--- a/drivers/spi/spi-armada-3700.c
+++ b/drivers/spi/spi-armada-3700.c
@@ -99,19 +99,28 @@
 /* A3700_SPI_IF_TIME_REG */
 #define A3700_SPI_CLK_CAPT_EDGE		BIT(7)
 
+/* Flags and macros for struct a3700_spi */
+#define HAS_FIFO			BIT(0)
+#define A3700_INSTR_CNT			1
+#define A3700_ADDR_CNT			3
+#define A3700_DUMMY_CNT			1
+
 struct a3700_spi {
 	struct spi_master *master;
 	void __iomem *base;
 	struct clk *clk;
 	unsigned int irq;
 	unsigned int flags;
-	bool last_xfer;
+	bool xmit_data;
 	const u8 *tx_buf;
 	u8 *rx_buf;
 	size_t buf_len;
 	u8 byte_len;
 	u32 wait_mask;
 	struct completion done;
+	u32 addr_cnt;
+	u32 instr_cnt;
+	size_t hdr_cnt;
 };
 
 static u32 spireg_read(struct a3700_spi *a3700_spi, u32 offset)
@@ -180,12 +189,15 @@ static int a3700_spi_pin_mode_set(struct a3700_spi *a3700_spi,
 	return 0;
 }
 
-static void a3700_spi_fifo_mode_unset(struct a3700_spi *a3700_spi)
+static void a3700_spi_fifo_mode_set(struct a3700_spi *a3700_spi)
 {
 	u32 val;
 
 	val = spireg_read(a3700_spi, A3700_SPI_IF_CFG_REG);
-	val &= ~A3700_SPI_FIFO_MODE;
+	if (a3700_spi->flags & HAS_FIFO)
+		val |= A3700_SPI_FIFO_MODE;
+	else
+		val &= ~A3700_SPI_FIFO_MODE;
 	spireg_write(a3700_spi, A3700_SPI_IF_CFG_REG, val);
 }
 
@@ -255,11 +267,30 @@ static void a3700_spi_bytelen_set(struct a3700_spi *a3700_spi, unsigned int len)
 	a3700_spi->byte_len = len;
 }
 
+static int a3700_spi_fifo_flush(struct a3700_spi *a3700_spi)
+{
+	int timeout = A3700_SPI_TIMEOUT;
+	u32 val;
+
+	val = spireg_read(a3700_spi, A3700_SPI_IF_CFG_REG);
+	val |= A3700_SPI_FIFO_FLUSH;
+	spireg_write(a3700_spi, A3700_SPI_IF_CFG_REG, val);
+
+	while (--timeout) {
+		val = spireg_read(a3700_spi, A3700_SPI_IF_CFG_REG);
+		if (!(val & A3700_SPI_FIFO_FLUSH))
+			return 0;
+		udelay(1);
+	}
+
+	return -ETIMEDOUT;
+}
+
 static int a3700_spi_init(struct a3700_spi *a3700_spi)
 {
 	struct spi_master *master = a3700_spi->master;
 	u32 val;
-	int i;
+	int i, ret = 0;
 
 	/* Reset SPI unit */
 	val = spireg_read(a3700_spi, A3700_SPI_IF_CFG_REG);
@@ -278,10 +309,8 @@ static int a3700_spi_init(struct a3700_spi *a3700_spi)
 	for (i = 0; i < master->num_chipselect; i++)
 		a3700_spi_deactivate_cs(a3700_spi, i);
 
-	a3700_spi_pin_mode_set(a3700_spi, 0);
-
-	/* Be sure that FIFO mode is disabled */
-	a3700_spi_fifo_mode_unset(a3700_spi);
+	/* Enable FIFO mode */
+	a3700_spi_fifo_mode_set(a3700_spi);
 
 	/* Set SPI mode */
 	a3700_spi_mode_set(a3700_spi, master->mode_bits);
@@ -294,7 +323,7 @@ static int a3700_spi_init(struct a3700_spi *a3700_spi)
 	spireg_write(a3700_spi, A3700_SPI_INT_MASK_REG, 0);
 	spireg_write(a3700_spi, A3700_SPI_INT_STAT_REG, ~0U);
 
-	return 0;
+	return ret;
 }
 
 static irqreturn_t a3700_spi_interrupt(int irq, void *dev_id)
@@ -380,6 +409,21 @@ static bool a3700_spi_transfer_wait(struct spi_device *spi,
 	return a3700_spi_wait_completion(spi);
 }
 
+static void a3700_spi_fifo_thres_set(struct a3700_spi *a3700_spi,
+				     unsigned int bytes)
+{
+	u32 val;
+
+	if (a3700_spi->flags & HAS_FIFO) {
+		val = spireg_read(a3700_spi, A3700_SPI_IF_CFG_REG);
+		val &= ~(A3700_SPI_FIFO_THRS_MASK << A3700_SPI_RFIFO_THRS_BIT);
+		val |= (bytes - 1) << A3700_SPI_RFIFO_THRS_BIT;
+		val &= ~(A3700_SPI_FIFO_THRS_MASK << A3700_SPI_WFIFO_THRS_BIT);
+		val |= (7 - bytes) << A3700_SPI_WFIFO_THRS_BIT;
+		spireg_write(a3700_spi, A3700_SPI_IF_CFG_REG, val);
+	}
+}
+
 static int a3700_spi_transfer_setup(struct spi_device *spi,
 				    struct spi_transfer *xfer)
 {
@@ -396,6 +440,8 @@ static int a3700_spi_transfer_setup(struct spi_device *spi,
 	/* Set byte length */
 	a3700_spi_bytelen_set(a3700_spi, byte_len);
 
+	a3700_spi_fifo_thres_set(a3700_spi, byte_len);
+
 	return ret;
 }
 
@@ -456,6 +502,168 @@ static void a3700_spi_set_cs(struct spi_device *spi, bool enable)
 		a3700_spi_deactivate_cs(a3700_spi, spi->chip_select);
 }
 
+static void a3700_spi_header_set(struct a3700_spi *a3700_spi)
+{
+	u32 instr_cnt = 0, addr_cnt = 0, dummy_cnt = 0;
+	u32 val = 0;
+
+	/* Clear the header registers */
+	spireg_write(a3700_spi, A3700_SPI_IF_INST_REG, 0);
+	spireg_write(a3700_spi, A3700_SPI_IF_ADDR_REG, 0);
+	spireg_write(a3700_spi, A3700_SPI_IF_RMODE_REG, 0);
+
+	/* Set header counters */
+	if (a3700_spi->tx_buf) {
+		if (a3700_spi->buf_len <= a3700_spi->instr_cnt) {
+			instr_cnt = a3700_spi->buf_len;
+		} else if (a3700_spi->buf_len <= (a3700_spi->instr_cnt +
+						  a3700_spi->addr_cnt)) {
+			instr_cnt = a3700_spi->instr_cnt;
+			addr_cnt = a3700_spi->buf_len - instr_cnt;
+		} else if (a3700_spi->buf_len <= a3700_spi->hdr_cnt) {
+			instr_cnt = a3700_spi->instr_cnt;
+			addr_cnt = a3700_spi->addr_cnt;
+			/* Need to handle the normal write case with 1 byte
+			 * data
+			 */
+			if (!a3700_spi->tx_buf[instr_cnt + addr_cnt])
+				dummy_cnt = a3700_spi->buf_len - instr_cnt -
+					    addr_cnt;
+		}
+		val |= ((instr_cnt & A3700_SPI_INSTR_CNT_MASK)
+			<< A3700_SPI_INSTR_CNT_BIT);
+		val |= ((addr_cnt & A3700_SPI_ADDR_CNT_MASK)
+			<< A3700_SPI_ADDR_CNT_BIT);
+		val |= ((dummy_cnt & A3700_SPI_DUMMY_CNT_MASK)
+			<< A3700_SPI_DUMMY_CNT_BIT);
+	}
+	spireg_write(a3700_spi, A3700_SPI_IF_HDR_CNT_REG, val);
+
+	/* Update the buffer length to be transferred */
+	a3700_spi->buf_len -= (instr_cnt + addr_cnt + dummy_cnt);
+
+	/* Set Instruction */
+	val = 0;
+	while (instr_cnt--) {
+		val = (val << 8) | a3700_spi->tx_buf[0];
+		a3700_spi->tx_buf++;
+	}
+	spireg_write(a3700_spi, A3700_SPI_IF_INST_REG, val);
+
+	/* Set Address */
+	val = 0;
+	while (addr_cnt--) {
+		val = (val << 8) | a3700_spi->tx_buf[0];
+		a3700_spi->tx_buf++;
+	}
+	spireg_write(a3700_spi, A3700_SPI_IF_ADDR_REG, val);
+}
+
+static int a3700_is_wfifo_full(struct a3700_spi *a3700_spi)
+{
+	u32 val;
+
+	val = spireg_read(a3700_spi, A3700_SPI_IF_CTRL_REG);
+	return (val & A3700_SPI_WFIFO_FULL);
+}
+
+static int a3700_spi_fifo_write(struct a3700_spi *a3700_spi)
+{
+	u32 val;
+	int i = 0;
+
+	while (!a3700_is_wfifo_full(a3700_spi) && a3700_spi->buf_len) {
+		val = 0;
+		if (a3700_spi->buf_len >= 4) {
+			val = cpu_to_le32(*(u32 *)a3700_spi->tx_buf);
+			spireg_write(a3700_spi, A3700_SPI_DATA_OUT_REG, val);
+
+			a3700_spi->buf_len -= 4;
+			a3700_spi->tx_buf += 4;
+		} else {
+			/*
+			 * If the remained buffer length is less than 4-bytes,
+			 * we should pad the write buffer with all ones. So that
+			 * it avoids overwrite the unexpected bytes following
+			 * the last one.
+			 */
+			val = GENMASK(31, 0);
+			while (a3700_spi->buf_len) {
+				val &= ~(0xff << (8 * i));
+				val |= *a3700_spi->tx_buf++ << (8 * i);
+				i++;
+				a3700_spi->buf_len--;
+
+				spireg_write(a3700_spi, A3700_SPI_DATA_OUT_REG,
+					     val);
+			}
+			break;
+		}
+	}
+
+	return 0;
+}
+
+static int a3700_is_rfifo_empty(struct a3700_spi *a3700_spi)
+{
+	u32 val = spireg_read(a3700_spi, A3700_SPI_IF_CTRL_REG);
+
+	return (val & A3700_SPI_RFIFO_EMPTY);
+}
+
+static int a3700_spi_fifo_read(struct a3700_spi *a3700_spi)
+{
+	u32 val;
+
+	while (!a3700_is_rfifo_empty(a3700_spi) && a3700_spi->buf_len) {
+		val = spireg_read(a3700_spi, A3700_SPI_DATA_IN_REG);
+		if (a3700_spi->buf_len >= 4) {
+			u32 data = le32_to_cpu(val);
+			memcpy(a3700_spi->rx_buf, &data, 4);
+
+			a3700_spi->buf_len -= 4;
+			a3700_spi->rx_buf += 4;
+		} else {
+			/*
+			 * When remain bytes is not larger than 4, we should
+			 * avoid memory overwriting and just write the left rx
+			 * buffer bytes.
+			 */
+			while (a3700_spi->buf_len) {
+				*a3700_spi->rx_buf = val & 0xff;
+				val >>= 8;
+
+				a3700_spi->buf_len--;
+				a3700_spi->rx_buf++;
+			}
+		}
+	}
+
+	return 0;
+}
+
+static void a3700_spi_transfer_abort_fifo(struct a3700_spi *a3700_spi)
+{
+	int timeout = A3700_SPI_TIMEOUT;
+	u32 val;
+
+	val = spireg_read(a3700_spi, A3700_SPI_IF_CFG_REG);
+	val |= A3700_SPI_XFER_STOP;
+	spireg_write(a3700_spi, A3700_SPI_IF_CFG_REG, val);
+
+	while (--timeout) {
+		val = spireg_read(a3700_spi, A3700_SPI_IF_CFG_REG);
+		if (!(val & A3700_SPI_XFER_START))
+			break;
+		udelay(1);
+	}
+
+	a3700_spi_fifo_flush(a3700_spi);
+
+	val &= ~A3700_SPI_XFER_STOP;
+	spireg_write(a3700_spi, A3700_SPI_IF_CFG_REG, val);
+}
+
 static int a3700_spi_prepare_message(struct spi_master *master,
 				     struct spi_message *message)
 {
@@ -469,12 +677,28 @@ static int a3700_spi_prepare_message(struct spi_master *master,
 	return 0;
 }
 
+static int a3700_spi_prepare_fifo_message(struct spi_master *master,
+					  struct spi_message *message)
+{
+	struct a3700_spi *a3700_spi = spi_master_get_devdata(master);
+	int ret;
+
+	/* Flush the FIFOs */
+	ret = a3700_spi_fifo_flush(a3700_spi);
+	if (ret)
+		return ret;
+
+	a3700_spi_bytelen_set(a3700_spi, 4);
+
+	return 0;
+}
+
 static int a3700_spi_transfer_one(struct spi_master *master,
 				  struct spi_device *spi,
 				  struct spi_transfer *xfer)
 {
 	struct a3700_spi *a3700_spi = spi_master_get_devdata(master);
-	int ret = 0;
+	int ret;
 
 	ret = a3700_spi_transfer_setup(spi, xfer);
 	if (ret)
@@ -513,6 +737,153 @@ static int a3700_spi_transfer_one(struct spi_master *master,
 	return ret;
 }
 
+static int a3700_spi_fifo_transfer_one(struct spi_master *master,
+				       struct spi_device *spi,
+				       struct spi_transfer *xfer)
+{
+	struct a3700_spi *a3700_spi = spi_master_get_devdata(master);
+	int ret = 0, timeout = A3700_SPI_TIMEOUT;
+	unsigned int nbits = 0;
+	u32 val;
+
+	ret = a3700_spi_transfer_setup(spi, xfer);
+	if (ret)
+		goto error;
+
+	a3700_spi->tx_buf  = xfer->tx_buf;
+	a3700_spi->rx_buf  = xfer->rx_buf;
+	a3700_spi->buf_len = xfer->len;
+
+	/* SPI transfer headers */
+	a3700_spi_header_set(a3700_spi);
+
+	if (xfer->tx_buf)
+		nbits = xfer->tx_nbits;
+	else if (xfer->rx_buf)
+		nbits = xfer->rx_nbits;
+
+	a3700_spi_pin_mode_set(a3700_spi, nbits);
+
+	if (xfer->rx_buf) {
+		/* Set read data length */
+		spireg_write(a3700_spi, A3700_SPI_IF_DIN_CNT_REG,
+			     a3700_spi->buf_len);
+		/* Start READ transfer */
+		val = spireg_read(a3700_spi, A3700_SPI_IF_CFG_REG);
+		val &= ~A3700_SPI_RW_EN;
+		val |= A3700_SPI_XFER_START;
+		spireg_write(a3700_spi, A3700_SPI_IF_CFG_REG, val);
+	} else if (xfer->tx_buf) {
+		/* Start Write transfer */
+		val = spireg_read(a3700_spi, A3700_SPI_IF_CFG_REG);
+		val |= (A3700_SPI_XFER_START | A3700_SPI_RW_EN);
+		spireg_write(a3700_spi, A3700_SPI_IF_CFG_REG, val);
+
+		/*
+		 * If there are data to be written to the SPI device, xmit_data
+		 * flag is set true; otherwise the instruction in SPI_INSTR does
+		 * not require data to be written to the SPI device, then
+		 * xmit_data flag is set false.
+		 */
+		a3700_spi->xmit_data = (a3700_spi->buf_len != 0);
+	}
+
+	while (a3700_spi->buf_len) {
+		if (a3700_spi->tx_buf) {
+			/* Wait wfifo ready */
+			if (!a3700_spi_transfer_wait(spi,
+						     A3700_SPI_WFIFO_RDY)) {
+				dev_err(&spi->dev,
+					"wait wfifo ready timed out\n");
+				ret = -ETIMEDOUT;
+				goto error;
+			}
+			/* Fill up the wfifo */
+			ret = a3700_spi_fifo_write(a3700_spi);
+			if (ret)
+				goto error;
+		} else if (a3700_spi->rx_buf) {
+			/* Wait rfifo ready */
+			if (!a3700_spi_transfer_wait(spi,
+						     A3700_SPI_RFIFO_RDY)) {
+				dev_err(&spi->dev,
+					"wait rfifo ready timed out\n");
+				ret = -ETIMEDOUT;
+				goto error;
+			}
+			/* Drain out the rfifo */
+			ret = a3700_spi_fifo_read(a3700_spi);
+			if (ret)
+				goto error;
+		}
+	}
+
+	/*
+	 * Stop a write transfer in fifo mode:
+	 *	- wait all the bytes in wfifo to be shifted out
+	 *	 - set XFER_STOP bit
+	 *	- wait XFER_START bit clear
+	 *	- clear XFER_STOP bit
+	 * Stop a read transfer in fifo mode:
+	 *	- the hardware is to reset the XFER_START bit
+	 *	   after the number of bytes indicated in DIN_CNT
+	 *	   register
+	 *	- just wait XFER_START bit clear
+	 */
+	if (a3700_spi->tx_buf) {
+		if (a3700_spi->xmit_data) {
+			/*
+			 * If there are data written to the SPI device, wait
+			 * until SPI_WFIFO_EMPTY is 1 to wait for all data to
+			 * transfer out of write FIFO.
+			 */
+			if (!a3700_spi_transfer_wait(spi,
+						     A3700_SPI_WFIFO_EMPTY)) {
+				dev_err(&spi->dev, "wait wfifo empty timed out\n");
+				return -ETIMEDOUT;
+			}
+		} else {
+			/*
+			 * If the instruction in SPI_INSTR does not require data
+			 * to be written to the SPI device, wait until SPI_RDY
+			 * is 1 for the SPI interface to be in idle.
+			 */
+			if (!a3700_spi_transfer_wait(spi, A3700_SPI_XFER_RDY)) {
+				dev_err(&spi->dev, "wait xfer ready timed out\n");
+				return -ETIMEDOUT;
+			}
+		}
+
+		val = spireg_read(a3700_spi, A3700_SPI_IF_CFG_REG);
+		val |= A3700_SPI_XFER_STOP;
+		spireg_write(a3700_spi, A3700_SPI_IF_CFG_REG, val);
+	}
+
+	while (--timeout) {
+		val = spireg_read(a3700_spi, A3700_SPI_IF_CFG_REG);
+		if (!(val & A3700_SPI_XFER_START))
+			break;
+		udelay(1);
+	}
+
+	if (timeout == 0) {
+		dev_err(&spi->dev, "wait transfer start clear timed out\n");
+		ret = -ETIMEDOUT;
+		goto error;
+	}
+
+	val &= ~A3700_SPI_XFER_STOP;
+	spireg_write(a3700_spi, A3700_SPI_IF_CFG_REG, val);
+	goto out;
+
+error:
+	a3700_spi_transfer_abort_fifo(a3700_spi);
+out:
+	spi_finalize_current_transfer(master);
+
+	return ret;
+}
+
 static int a3700_spi_unprepare_message(struct spi_master *master,
 				       struct spi_message *message)
 {
@@ -600,6 +971,23 @@ static int a3700_spi_probe(struct platform_device *pdev)
 		goto error;
 	}
 
+	if (of_device_is_compatible(of_node, "marvell,armada-3700-spi")) {
+		master->prepare_message =  a3700_spi_prepare_fifo_message;
+		master->transfer_one = a3700_spi_fifo_transfer_one;
+
+		spi->flags |= HAS_FIFO;
+		spi->instr_cnt = A3700_INSTR_CNT;
+		spi->addr_cnt = A3700_ADDR_CNT;
+		spi->hdr_cnt = A3700_INSTR_CNT + A3700_ADDR_CNT +
+			       A3700_DUMMY_CNT;
+		master->mode_bits |= (SPI_RX_DUAL | SPI_RX_DUAL |
+				      SPI_RX_QUAD | SPI_TX_QUAD);
+	} else {
+		master->prepare_message =  a3700_spi_prepare_message;
+		master->transfer_one = a3700_spi_transfer_one;
+		master->unprepare_message = a3700_spi_unprepare_message;
+	}
+
 	ret = a3700_spi_init(spi);
 	if (ret)
 		goto error_clk;
-- 
2.9.3
