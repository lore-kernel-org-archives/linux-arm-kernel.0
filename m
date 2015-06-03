From: cyrille.pitchen@atmel.com (Cyrille Pitchen)
Date: Wed, 3 Jun 2015 18:25:20 +0200
Subject: [PATCH v5 4/6] i2c: at91: add support for new alternative command mode
In-Reply-To: <cover.1433348016.git.cyrille.pitchen@atmel.com>
References: <cover.1433348016.git.cyrille.pitchen@atmel.com>
Message-ID: <ad5348072752e523b4c677a1a986c142af716b19.1433348016.git.cyrille.pitchen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The alternative command mode was introduced to simplify the transmission
of STOP conditions and to solve timing and latency issues around them.

This mode relies on a new register, the Alternative Command Register,
which must be set at the same time as the Master Mode Register. This new
register was designed to allow simple setup of basic combined transactions
built from up to two unitary transactions.

Indeed, the ACR is split into two areas, which describe one unitary
transaction each. Each area is filled with Data Length 8bit counter, a
Direction and a PEC Request bit. The PEC bit is only used in SMBus mode
and is not supported by this driver yet. Also when using alternative
command mode, the MREAD bit from the Master Mode Register is ignored.
Instead the Direction bits from ACR are used to setup the direction, read
or write, of each unitary transaction. Finally the 8bit counters must
filled with the data length of their respective transaction. Then if only
one transaction is to be used, the data length of the second one must be
set to zero. At the moment, this driver uses only the first transaction.

In addition to MMR and ACR, the Control Register also need to be written
to enable the alternative command mode. That's the purpose of its ACMEN
bit, which stands for Alternative Command Mode Enable.

Note that the alternative command mode is compatible with the use of the
Internal Address Register. So combined transactions for eeprom read are
actually implemented with the Internal Address Register. This register is
written with up to 3 bytes, which are the internal address sent to the
slave through the first write transaction. Then the first area of the ACR
describe the write transaction to follow, which carries the data to be
read from the eeprom. The second area of the ACR is not used so its Data
Length 8bit counter is cleared.

For each byte sent or received by the device, the Data Length 8bit counter
is decremented. When it reaches 0, a STOP condition is automatically sent.

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
---
 drivers/i2c/busses/i2c-at91.c | 121 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 101 insertions(+), 20 deletions(-)

diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
index 0e88b68..67b4f15 100644
--- a/drivers/i2c/busses/i2c-at91.c
+++ b/drivers/i2c/busses/i2c-at91.c
@@ -49,6 +49,11 @@
 #define	AT91_TWI_SVDIS		BIT(5)	/* Slave Transfer Disable */
 #define	AT91_TWI_QUICK		BIT(6)	/* SMBus quick command */
 #define	AT91_TWI_SWRST		BIT(7)	/* Software Reset */
+#define	AT91_TWI_ACMEN		BIT(16) /* Alternative Command Mode Enable */
+#define	AT91_TWI_ACMDIS		BIT(17) /* Alternative Command Mode Disable */
+#define	AT91_TWI_THRCLR		BIT(24) /* Transmit Holding Register Clear */
+#define	AT91_TWI_RHRCLR		BIT(25) /* Receive Holding Register Clear */
+#define	AT91_TWI_LOCKCLR	BIT(26) /* Lock Clear */
 
 #define	AT91_TWI_MMR		0x0004	/* Master Mode Register */
 #define	AT91_TWI_IADRSZ_1	0x0100	/* Internal Device Address Size */
@@ -65,6 +70,7 @@
 #define	AT91_TWI_OVRE		BIT(6)	/* Overrun Error */
 #define	AT91_TWI_UNRE		BIT(7)	/* Underrun Error */
 #define	AT91_TWI_NACK		BIT(8)	/* Not Acknowledged */
+#define	AT91_TWI_LOCK		BIT(23) /* TWI Lock due to Frame Errors */
 
 #define	AT91_TWI_INT_MASK \
 	(AT91_TWI_TXCOMP | AT91_TWI_RXRDY | AT91_TWI_TXRDY | AT91_TWI_NACK)
@@ -75,10 +81,15 @@
 #define	AT91_TWI_RHR		0x0030	/* Receive Holding Register */
 #define	AT91_TWI_THR		0x0034	/* Transmit Holding Register */
 
+#define	AT91_TWI_ACR		0x0040	/* Alternative Command Register */
+#define	AT91_TWI_ACR_DATAL(len)	((len) & 0xff)
+#define	AT91_TWI_ACR_DIR	BIT(8)
+
 struct at91_twi_pdata {
 	unsigned clk_max_div;
 	unsigned clk_offset;
 	bool has_unre_flag;
+	bool has_alt_cmd;
 	struct at_dma_slave dma_slave;
 };
 
@@ -204,7 +215,8 @@ static void at91_twi_write_next_byte(struct at91_twi_dev *dev)
 
 	/* send stop when last byte has been written */
 	if (--dev->buf_len == 0)
-		at91_twi_write(dev, AT91_TWI_CR, AT91_TWI_STOP);
+		if (!dev->pdata->has_alt_cmd)
+			at91_twi_write(dev, AT91_TWI_CR, AT91_TWI_STOP);
 
 	dev_dbg(dev->dev, "wrote 0x%x, to go %d\n", *dev->buf, dev->buf_len);
 
@@ -226,7 +238,8 @@ static void at91_twi_write_data_dma_callback(void *data)
 	 * we just have to enable TXCOMP one.
 	 */
 	at91_twi_write(dev, AT91_TWI_IER, AT91_TWI_TXCOMP);
-	at91_twi_write(dev, AT91_TWI_CR, AT91_TWI_STOP);
+	if (!dev->pdata->has_alt_cmd)
+		at91_twi_write(dev, AT91_TWI_CR, AT91_TWI_STOP);
 }
 
 static void at91_twi_write_data_dma(struct at91_twi_dev *dev)
@@ -302,7 +315,7 @@ static void at91_twi_read_next_byte(struct at91_twi_dev *dev)
 	}
 
 	/* send stop if second but last byte has been read */
-	if (dev->buf_len == 1)
+	if (!dev->pdata->has_alt_cmd && dev->buf_len == 1)
 		at91_twi_write(dev, AT91_TWI_CR, AT91_TWI_STOP);
 
 	dev_dbg(dev->dev, "read 0x%x, to go %d\n", *dev->buf, dev->buf_len);
@@ -313,14 +326,18 @@ static void at91_twi_read_next_byte(struct at91_twi_dev *dev)
 static void at91_twi_read_data_dma_callback(void *data)
 {
 	struct at91_twi_dev *dev = (struct at91_twi_dev *)data;
+	unsigned ier = AT91_TWI_TXCOMP;
 
 	dma_unmap_single(dev->dev, sg_dma_address(&dev->dma.sg),
 			 dev->buf_len, DMA_FROM_DEVICE);
 
-	/* The last two bytes have to be read without using dma */
-	dev->buf += dev->buf_len - 2;
-	dev->buf_len = 2;
-	at91_twi_write(dev, AT91_TWI_IER, AT91_TWI_RXRDY | AT91_TWI_TXCOMP);
+	if (!dev->pdata->has_alt_cmd) {
+		/* The last two bytes have to be read without using dma */
+		dev->buf += dev->buf_len - 2;
+		dev->buf_len = 2;
+		ier |= AT91_TWI_RXRDY;
+	}
+	at91_twi_write(dev, AT91_TWI_IER, ier);
 }
 
 static void at91_twi_read_data_dma(struct at91_twi_dev *dev)
@@ -329,13 +346,14 @@ static void at91_twi_read_data_dma(struct at91_twi_dev *dev)
 	struct dma_async_tx_descriptor *rxdesc;
 	struct at91_twi_dma *dma = &dev->dma;
 	struct dma_chan *chan_rx = dma->chan_rx;
+	size_t buf_len;
 
+	buf_len = (dev->pdata->has_alt_cmd) ? dev->buf_len : dev->buf_len - 2;
 	dma->direction = DMA_FROM_DEVICE;
 
 	/* Keep in mind that we won't use dma to read the last two bytes */
 	at91_twi_irq_save(dev);
-	dma_addr = dma_map_single(dev->dev, dev->buf, dev->buf_len - 2,
-				  DMA_FROM_DEVICE);
+	dma_addr = dma_map_single(dev->dev, dev->buf, buf_len, DMA_FROM_DEVICE);
 	if (dma_mapping_error(dev->dev, dma_addr)) {
 		dev_err(dev->dev, "dma map failed\n");
 		return;
@@ -343,7 +361,7 @@ static void at91_twi_read_data_dma(struct at91_twi_dev *dev)
 	dma->buf_mapped = true;
 	at91_twi_irq_restore(dev);
 	dma->sg.dma_address = dma_addr;
-	sg_dma_len(&dma->sg) = dev->buf_len - 2;
+	sg_dma_len(&dma->sg) = buf_len;
 
 	rxdesc = dmaengine_prep_slave_sg(chan_rx, &dma->sg, 1, DMA_DEV_TO_MEM,
 					 DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
@@ -394,6 +412,7 @@ static int at91_do_twi_transfer(struct at91_twi_dev *dev)
 	int ret;
 	unsigned long time_left;
 	bool has_unre_flag = dev->pdata->has_unre_flag;
+	bool has_alt_cmd = dev->pdata->has_alt_cmd;
 
 	/*
 	 * WARNING: the TXCOMP bit in the Status Register is NOT a clear on
@@ -403,6 +422,21 @@ static int at91_do_twi_transfer(struct at91_twi_dev *dev)
 	 * empty and STOP condition has been sent.
 	 * Consequently, we should enable NACK interrupt rather than TXCOMP to
 	 * detect transmission failure.
+	 * Indeed let's take the case of an i2c write command using DMA.
+	 * Whenever the slave doesn't acknowledge a byte, the LOCK, NACK and
+	 * TXCOMP bits are set together into the Status Register.
+	 * LOCK is a clear on write bit, which is set to prevent the DMA
+	 * controller from sending new data on the i2c bus after a NACK
+	 * condition has happened. Once locked, this i2c peripheral stops
+	 * triggering the DMA controller for new data but it is more than
+	 * likely that a new DMA transaction is already in progress, writing
+	 * into the Transmit Holding Register. Since the peripheral is locked,
+	 * these new data won't be sent to the i2c bus but they will remain
+	 * into the Transmit Holding Register, so TXCOMP bit is cleared.
+	 * Then when the interrupt handler is called, the Status Register is
+	 * read: the TXCOMP bit is clear but NACK bit is still set. The driver
+	 * manage the error properly, without waiting for timeout.
+	 * This case can be reproduced easyly when writing into an at24 eeprom.
 	 *
 	 * Besides, the TXCOMP bit is already set before the i2c transaction
 	 * has been started. For read transactions, this bit is cleared when
@@ -418,9 +452,9 @@ static int at91_do_twi_transfer(struct at91_twi_dev *dev)
 	 * condition since we don't know whether the TXCOMP interrupt is enabled
 	 * before or after the DMA has started to write into THR. So the TXCOMP
 	 * interrupt is enabled later by at91_twi_write_data_dma_callback().
-	 * Immediately after in that DMA callback, we still need to send the
-	 * STOP condition manually writing the corresponding bit into the
-	 * Control Register.
+	 * Immediately after in that DMA callback, if the alternative command
+	 * mode is not used, we still need to send the STOP condition manually
+	 * writing the corresponding bit into the Control Register.
 	 */
 
 	dev_dbg(dev->dev, "transfer: %s %d bytes.\n",
@@ -441,14 +475,16 @@ static int at91_do_twi_transfer(struct at91_twi_dev *dev)
 		}
 
 		/* if only one byte is to be read, immediately stop transfer */
-		if (dev->buf_len <= 1 && !(dev->msg->flags & I2C_M_RECV_LEN))
+		if (!has_alt_cmd && dev->buf_len <= 1 &&
+		    !(dev->msg->flags & I2C_M_RECV_LEN))
 			start_flags |= AT91_TWI_STOP;
 		at91_twi_write(dev, AT91_TWI_CR, start_flags);
 		/*
-		 * When using dma, the last byte has to be read manually in
-		 * order to not send the stop command too late and then
-		 * to receive extra data. In practice, there are some issues
-		 * if you use the dma to read n-1 bytes because of latency.
+		 * When using dma without alternative command mode, the last
+		 * byte has to be read manually in order to not send the stop
+		 * command too late and then to receive extra data.
+		 * In practice, there are some issues if you use the dma to
+		 * read n-1 bytes because of latency.
 		 * Reading n-2 bytes with dma and the two last ones manually
 		 * seems to be the best solution.
 		 */
@@ -477,6 +513,7 @@ static int at91_do_twi_transfer(struct at91_twi_dev *dev)
 	time_left = wait_for_completion_timeout(&dev->cmd_complete,
 					      dev->adapter.timeout);
 	if (time_left == 0) {
+		dev->transfer_status |= at91_twi_read(dev, AT91_TWI_SR);
 		dev_err(dev->dev, "controller timed out\n");
 		at91_init_twi_bus(dev);
 		ret = -ETIMEDOUT;
@@ -497,6 +534,11 @@ static int at91_do_twi_transfer(struct at91_twi_dev *dev)
 		ret = -EIO;
 		goto error;
 	}
+	if (has_alt_cmd && (dev->transfer_status & AT91_TWI_LOCK)) {
+		dev_err(dev->dev, "tx locked\n");
+		ret = -EIO;
+		goto error;
+	}
 	if (dev->recv_len_abort) {
 		dev_err(dev->dev, "invalid smbus block length recvd\n");
 		ret = -EPROTO;
@@ -508,7 +550,14 @@ static int at91_do_twi_transfer(struct at91_twi_dev *dev)
 	return 0;
 
 error:
+	/* first stop DMA transfer if still in progress */
 	at91_twi_dma_cleanup(dev);
+	/* then flush THR/FIFO and unlock TX if locked */
+	if (has_alt_cmd && (dev->transfer_status & AT91_TWI_LOCK)) {
+		dev_dbg(dev->dev, "unlock tx\n");
+		at91_twi_write(dev, AT91_TWI_CR,
+			       AT91_TWI_THRCLR | AT91_TWI_LOCKCLR);
+	}
 	return ret;
 }
 
@@ -518,6 +567,7 @@ static int at91_twi_xfer(struct i2c_adapter *adap, struct i2c_msg *msg, int num)
 	int ret;
 	unsigned int_addr_flag = 0;
 	struct i2c_msg *m_start = msg;
+	bool is_read, use_alt_cmd = false;
 
 	dev_dbg(&adap->dev, "at91_xfer: processing %d messages:\n", num);
 
@@ -540,8 +590,23 @@ static int at91_twi_xfer(struct i2c_adapter *adap, struct i2c_msg *msg, int num)
 		at91_twi_write(dev, AT91_TWI_IADR, internal_address);
 	}
 
-	at91_twi_write(dev, AT91_TWI_MMR, (m_start->addr << 16) | int_addr_flag
-		       | ((m_start->flags & I2C_M_RD) ? AT91_TWI_MREAD : 0));
+	is_read = (m_start->flags & I2C_M_RD);
+	if (dev->pdata->has_alt_cmd) {
+		if (m_start->len > 0) {
+			at91_twi_write(dev, AT91_TWI_CR, AT91_TWI_ACMEN);
+			at91_twi_write(dev, AT91_TWI_ACR,
+				       AT91_TWI_ACR_DATAL(m_start->len) |
+				       ((is_read) ? AT91_TWI_ACR_DIR : 0));
+			use_alt_cmd = true;
+		} else {
+			at91_twi_write(dev, AT91_TWI_CR, AT91_TWI_ACMDIS);
+		}
+	}
+
+	at91_twi_write(dev, AT91_TWI_MMR,
+		       (m_start->addr << 16) |
+		       int_addr_flag |
+		       ((!use_alt_cmd && is_read) ? AT91_TWI_MREAD : 0));
 
 	dev->buf_len = m_start->len;
 	dev->buf = m_start->buf;
@@ -582,30 +647,35 @@ static struct at91_twi_pdata at91rm9200_config = {
 	.clk_max_div = 5,
 	.clk_offset = 3,
 	.has_unre_flag = true,
+	.has_alt_cmd = false,
 };
 
 static struct at91_twi_pdata at91sam9261_config = {
 	.clk_max_div = 5,
 	.clk_offset = 4,
 	.has_unre_flag = false,
+	.has_alt_cmd = false,
 };
 
 static struct at91_twi_pdata at91sam9260_config = {
 	.clk_max_div = 7,
 	.clk_offset = 4,
 	.has_unre_flag = false,
+	.has_alt_cmd = false,
 };
 
 static struct at91_twi_pdata at91sam9g20_config = {
 	.clk_max_div = 7,
 	.clk_offset = 4,
 	.has_unre_flag = false,
+	.has_alt_cmd = false,
 };
 
 static struct at91_twi_pdata at91sam9g10_config = {
 	.clk_max_div = 7,
 	.clk_offset = 4,
 	.has_unre_flag = false,
+	.has_alt_cmd = false,
 };
 
 static const struct platform_device_id at91_twi_devtypes[] = {
@@ -634,6 +704,14 @@ static struct at91_twi_pdata at91sam9x5_config = {
 	.clk_max_div = 7,
 	.clk_offset = 4,
 	.has_unre_flag = false,
+	.has_alt_cmd = false,
+};
+
+static struct at91_twi_pdata at91sama5d2_config = {
+	.clk_max_div = 7,
+	.clk_offset = 4,
+	.has_unre_flag = true,
+	.has_alt_cmd = true,
 };
 
 static const struct of_device_id atmel_twi_dt_ids[] = {
@@ -656,6 +734,9 @@ static const struct of_device_id atmel_twi_dt_ids[] = {
 		.compatible = "atmel,at91sam9x5-i2c",
 		.data = &at91sam9x5_config,
 	}, {
+		.compatible = "atmel,at91sama5d2-i2c",
+		.data = &at91sama5d2_config,
+	}, {
 		/* sentinel */
 	}
 };
-- 
1.8.2.2
