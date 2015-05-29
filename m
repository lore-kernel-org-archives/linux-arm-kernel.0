From: cyrille.pitchen@atmel.com (Cyrille Pitchen)
Date: Fri, 29 May 2015 15:50:08 +0200
Subject: [PATCH 1/3] i2c: at91: add support for new alternative command mode
In-Reply-To: <cover.1432907105.git.cyrille.pitchen@atmel.com>
References: <cover.1432907105.git.cyrille.pitchen@atmel.com>
Message-ID: <301d33a22f415a6c235a75bd849869bdd06a2ad0.1432907105.git.cyrille.pitchen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The alternative command mode was introduced to simplify the transmission of
STOP conditions and to solve timing and latency issues around them.

This mode relies on a new register, the Alternative Command Register, which
must be set at the same time as the Master Mode Register. This new register was
designed to allow simple setup of basic combined transactions built from
up to two unitary transactions.

Indeed, the ACR is split into two areas, which describe one unitary
transaction each. Each area is filled with Data Length 8bit counter, a
Direction and a PEC Request bit. The PEC bit is only used in SMBus mode and is
not supported by this driver yet. Also when using alternative command mode, the
MREAD bit from the Master Mode Register is ignored. Instead the Direction bits
from ACR are used to setup the direction, read or write, of each unitary
transaction. Finally the 8bit counters must filled with the data length of
their respective transaction. Then if only one transaction is to be used, the
data length of the second one must be set to zero. At the moment, this driver
uses only the first transaction.

In addition to MMR and ACR, the Control Register also need to be written to
enable the alternative command mode. That's the purpose of its ACMEN bit, which
stands for Alternative Command Mode Enable.

Note that the alternative command mode is compatible with the use of the
Internal Address Register. So combined transactions for eeprom read are
actually implemented with the Internal Address Register. This register is written
with up to 3 bytes, which are the internal address sent to the slave through
the first write transaction. Then the first area of the ACR describe the write
transaction to follow, which carries the data to be read from the eeprom.
The second area of the ACR is not used so its Data Length 8bit counter is
cleared.

For each byte sent or received by the device, the Data Length 8bit counter is
decremented. When it reaches 0, a STOP condition is automatically sent.

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
---
 drivers/i2c/busses/i2c-at91.c | 203 ++++++++++++++++++++++++++++++++----------
 1 file changed, 158 insertions(+), 45 deletions(-)

diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
index ff23d1b..b48be58 100644
--- a/drivers/i2c/busses/i2c-at91.c
+++ b/drivers/i2c/busses/i2c-at91.c
@@ -41,12 +41,19 @@
 
 /* AT91 TWI register definitions */
 #define	AT91_TWI_CR		0x0000	/* Control Register */
-#define	AT91_TWI_START		0x0001	/* Send a Start Condition */
-#define	AT91_TWI_STOP		0x0002	/* Send a Stop Condition */
-#define	AT91_TWI_MSEN		0x0004	/* Master Transfer Enable */
-#define	AT91_TWI_SVDIS		0x0020	/* Slave Transfer Disable */
-#define	AT91_TWI_QUICK		0x0040	/* SMBus quick command */
-#define	AT91_TWI_SWRST		0x0080	/* Software Reset */
+#define	AT91_TWI_START		(1 << 0)  /* Send a Start Condition */
+#define	AT91_TWI_STOP		(1 << 1)  /* Send a Stop Condition */
+#define	AT91_TWI_MSEN		(1 << 2)  /* Master Transfer Enable */
+#define	AT91_TWI_MSDIS		(1 << 3)  /* Master Transfer Disable */
+#define	AT91_TWI_SVEN		(1 << 4)  /* Slave Transfer Disable */
+#define	AT91_TWI_SVDIS		(1 << 5)  /* Slave Transfer Disable */
+#define	AT91_TWI_QUICK		(1 << 6)  /* SMBus quick command */
+#define	AT91_TWI_SWRST		(1 << 7)  /* Software Reset */
+#define	AT91_TWI_ACMEN		(1 << 16) /* Alternative Command Mode Enable */
+#define	AT91_TWI_ACMDIS		(1 << 17) /* Alternative Command Mode Disable */
+#define	AT91_TWI_THRCLR		(1 << 24) /* Transmit Holding Register Clear */
+#define	AT91_TWI_RHRCLR		(1 << 25) /* Receive Holding Register Clear */
+#define	AT91_TWI_LOCKCLR	(1 << 26) /* Lock Clear */
 
 #define	AT91_TWI_MMR		0x0004	/* Master Mode Register */
 #define	AT91_TWI_IADRSZ_1	0x0100	/* Internal Device Address Size */
@@ -57,13 +64,16 @@
 #define	AT91_TWI_CWGR		0x0010	/* Clock Waveform Generator Reg */
 
 #define	AT91_TWI_SR		0x0020	/* Status Register */
-#define	AT91_TWI_TXCOMP		0x0001	/* Transmission Complete */
-#define	AT91_TWI_RXRDY		0x0002	/* Receive Holding Register Ready */
-#define	AT91_TWI_TXRDY		0x0004	/* Transmit Holding Register Ready */
+#define	AT91_TWI_TXCOMP		(1 << 0)  /* Transmission Complete */
+#define	AT91_TWI_RXRDY		(1 << 1)  /* Receive Holding Register Ready */
+#define	AT91_TWI_TXRDY		(1 << 2)  /* Transmit Holding Register Ready */
+#define	AT91_TWI_OVRE		(1 << 6)  /* Overrun Error */
+#define	AT91_TWI_UNRE		(1 << 7)  /* Underrun Error */
+#define	AT91_TWI_NACK		(1 << 8)  /* Not Acknowledged */
+#define	AT91_TWI_LOCK		(1 << 23) /* TWI Lock due to Frame Errors */
 
-#define	AT91_TWI_OVRE		0x0040	/* Overrun Error */
-#define	AT91_TWI_UNRE		0x0080	/* Underrun Error */
-#define	AT91_TWI_NACK		0x0100	/* Not Acknowledged */
+#define	AT91_TWI_INT_MASK \
+	(AT91_TWI_TXCOMP | AT91_TWI_RXRDY | AT91_TWI_TXRDY | AT91_TWI_NACK)
 
 #define	AT91_TWI_IER		0x0024	/* Interrupt Enable Register */
 #define	AT91_TWI_IDR		0x0028	/* Interrupt Disable Register */
@@ -71,10 +81,15 @@
 #define	AT91_TWI_RHR		0x0030	/* Receive Holding Register */
 #define	AT91_TWI_THR		0x0034	/* Transmit Holding Register */
 
+#define	AT91_TWI_ACR		0x0040	/* Alternative Command Register */
+#define	AT91_TWI_ACR_DATAL(len)	((len) & 0xff)
+#define	AT91_TWI_ACR_DIR	(1 << 8)
+
 struct at91_twi_pdata {
 	unsigned clk_max_div;
 	unsigned clk_offset;
 	bool has_unre_flag;
+	bool has_alt_cmd;
 	struct at_dma_slave dma_slave;
 };
 
@@ -119,13 +134,12 @@ static void at91_twi_write(struct at91_twi_dev *dev, unsigned reg, unsigned val)
 
 static void at91_disable_twi_interrupts(struct at91_twi_dev *dev)
 {
-	at91_twi_write(dev, AT91_TWI_IDR,
-		       AT91_TWI_TXCOMP | AT91_TWI_RXRDY | AT91_TWI_TXRDY);
+	at91_twi_write(dev, AT91_TWI_IDR, AT91_TWI_INT_MASK);
 }
 
 static void at91_twi_irq_save(struct at91_twi_dev *dev)
 {
-	dev->imr = at91_twi_read(dev, AT91_TWI_IMR) & 0x7;
+	dev->imr = at91_twi_read(dev, AT91_TWI_IMR) & AT91_TWI_INT_MASK;
 	at91_disable_twi_interrupts(dev);
 }
 
@@ -200,8 +214,11 @@ static void at91_twi_write_next_byte(struct at91_twi_dev *dev)
 	at91_twi_write(dev, AT91_TWI_THR, *dev->buf);
 
 	/* send stop when last byte has been written */
-	if (--dev->buf_len == 0)
-		at91_twi_write(dev, AT91_TWI_CR, AT91_TWI_STOP);
+	if (--dev->buf_len == 0) {
+		at91_twi_write(dev, AT91_TWI_IER, AT91_TWI_TXCOMP);
+		if (!dev->pdata->has_alt_cmd)
+			at91_twi_write(dev, AT91_TWI_CR, AT91_TWI_STOP);
+	}
 
 	dev_dbg(dev->dev, "wrote 0x%x, to go %d\n", *dev->buf, dev->buf_len);
 
@@ -215,7 +232,16 @@ static void at91_twi_write_data_dma_callback(void *data)
 	dma_unmap_single(dev->dev, sg_dma_address(&dev->dma.sg),
 			 dev->buf_len, DMA_TO_DEVICE);
 
-	at91_twi_write(dev, AT91_TWI_CR, AT91_TWI_STOP);
+	/*
+	 * When this callback is called, THR/TX FIFO is likely not to be empty
+	 * yet. So we have to wait for TXCOMP or NACK bits to be set into the
+	 * Status Register to be sure that the STOP bit has been sent and the
+	 * transfer is completed. The NACK interrupt has already been enabled,
+	 * we just have to enable TXCOMP one.
+	 */
+	at91_twi_write(dev, AT91_TWI_IER, AT91_TWI_TXCOMP);
+	if (!dev->pdata->has_alt_cmd)
+		at91_twi_write(dev, AT91_TWI_CR, AT91_TWI_STOP);
 }
 
 static void at91_twi_write_data_dma(struct at91_twi_dev *dev)
@@ -291,7 +317,7 @@ static void at91_twi_read_next_byte(struct at91_twi_dev *dev)
 	}
 
 	/* send stop if second but last byte has been read */
-	if (dev->buf_len == 1)
+	if (!dev->pdata->has_alt_cmd && dev->buf_len == 1)
 		at91_twi_write(dev, AT91_TWI_CR, AT91_TWI_STOP);
 
 	dev_dbg(dev->dev, "read 0x%x, to go %d\n", *dev->buf, dev->buf_len);
@@ -302,14 +328,18 @@ static void at91_twi_read_next_byte(struct at91_twi_dev *dev)
 static void at91_twi_read_data_dma_callback(void *data)
 {
 	struct at91_twi_dev *dev = (struct at91_twi_dev *)data;
+	unsigned ier = AT91_TWI_TXCOMP;
 
 	dma_unmap_single(dev->dev, sg_dma_address(&dev->dma.sg),
 			 dev->buf_len, DMA_FROM_DEVICE);
 
-	/* The last two bytes have to be read without using dma */
-	dev->buf += dev->buf_len - 2;
-	dev->buf_len = 2;
-	at91_twi_write(dev, AT91_TWI_IER, AT91_TWI_RXRDY);
+	if (!dev->pdata->has_alt_cmd) {
+		/* The last two bytes have to be read without using dma */
+		dev->buf += dev->buf_len - 2;
+		dev->buf_len = 2;
+		ier |= AT91_TWI_RXRDY;
+	}
+	at91_twi_write(dev, AT91_TWI_IER, ier);
 }
 
 static void at91_twi_read_data_dma(struct at91_twi_dev *dev)
@@ -318,13 +348,14 @@ static void at91_twi_read_data_dma(struct at91_twi_dev *dev)
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
@@ -332,7 +363,7 @@ static void at91_twi_read_data_dma(struct at91_twi_dev *dev)
 	dma->buf_mapped = true;
 	at91_twi_irq_restore(dev);
 	dma->sg.dma_address = dma_addr;
-	sg_dma_len(&dma->sg) = dev->buf_len - 2;
+	sg_dma_len(&dma->sg) = buf_len;
 
 	rxdesc = dmaengine_prep_slave_sg(chan_rx, &dma->sg, 1, DMA_DEV_TO_MEM,
 					 DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
@@ -370,7 +401,7 @@ static irqreturn_t atmel_twi_interrupt(int irq, void *dev_id)
 	/* catch error flags */
 	dev->transfer_status |= status;
 
-	if (irqstatus & AT91_TWI_TXCOMP) {
+	if (irqstatus & (AT91_TWI_TXCOMP | AT91_TWI_NACK)) {
 		at91_disable_twi_interrupts(dev);
 		complete(&dev->cmd_complete);
 	}
@@ -383,6 +414,51 @@ static int at91_do_twi_transfer(struct at91_twi_dev *dev)
 	int ret;
 	unsigned long time_left;
 	bool has_unre_flag = dev->pdata->has_unre_flag;
+	bool has_alt_cmd = dev->pdata->has_alt_cmd;
+
+	/*
+	 * WARNING: the TXCOMP bit in the Status Register is NOT a clear on
+	 * read flag but shows the state of the transmission at the time the
+	 * Status Register is read. According to the programmer datasheet,
+	 * TXCOMP is set when both holding register and internal shifter are
+	 * empty and STOP condition has been sent.
+	 * Consequently, when using alternative command, we should enable NACK
+	 * interrupt rather than TXCOMP to detect transmission failure.
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
+	 *
+	 * Besides, the TXCOMP bit is already set before the i2c transaction
+	 * has been started. For read transactions, this bit is cleared when
+	 * writing the START bit into the Control Register. So the
+	 * corresponding interrupt can safely be enabled just after.
+	 * However for write transactions managed by the CPU, we first write
+	 * into THR, so TXCOMP is cleared. Then we can safely enable TXCOMP
+	 * interrupt. If TXCOMP interrupt were enabled before writing into THR,
+	 * the interrupt handler would be called immediately and the i2c command
+	 * would be reported as completed.
+	 * Also when a write transaction is managed by the DMA controller,
+	 * enabling the TXCOMP interrupt may lead to a race condition since
+	 * we don't know whether the TXCOMP interrupt is enabled before or after
+	 * the DMA has started to write into THR. With alternative command
+	 * mode, we never enable TXCOMP interrupt but use DMA controller
+	 * completion interrupt instead.
+	 * Without alternative command mode, we still need to send the STOP
+	 * condition manually writing the corresponding bit into the Control
+	 * Register. So we enable TXCOMP interrupt at the same time.
+	 */
 
 	dev_dbg(dev->dev, "transfer: %s %d bytes.\n",
 		(dev->msg->flags & I2C_M_RD) ? "read" : "write", dev->buf_len);
@@ -402,44 +478,44 @@ static int at91_do_twi_transfer(struct at91_twi_dev *dev)
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
 		if (dev->use_dma && (dev->buf_len > AT91_I2C_DMA_THRESHOLD)) {
+			at91_twi_write(dev, AT91_TWI_IER, AT91_TWI_NACK);
 			at91_twi_read_data_dma(dev);
-			/*
-			 * It is important to enable TXCOMP irq here because
-			 * doing it only when transferring the last two bytes
-			 * will mask NACK errors since TXCOMP is set when a
-			 * NACK occurs.
-			 */
-			at91_twi_write(dev, AT91_TWI_IER,
-			       AT91_TWI_TXCOMP);
 		} else
 			at91_twi_write(dev, AT91_TWI_IER,
-			       AT91_TWI_TXCOMP | AT91_TWI_RXRDY);
+				       AT91_TWI_TXCOMP |
+				       AT91_TWI_NACK |
+				       AT91_TWI_RXRDY);
 	} else {
 		if (dev->use_dma && (dev->buf_len > AT91_I2C_DMA_THRESHOLD)) {
+			at91_twi_write(dev, AT91_TWI_IER, AT91_TWI_NACK);
 			at91_twi_write_data_dma(dev);
-			at91_twi_write(dev, AT91_TWI_IER, AT91_TWI_TXCOMP);
 		} else {
 			at91_twi_write_next_byte(dev);
 			at91_twi_write(dev, AT91_TWI_IER,
-				AT91_TWI_TXCOMP | AT91_TWI_TXRDY);
+				       AT91_TWI_TXCOMP |
+				       AT91_TWI_NACK |
+				       AT91_TWI_TXRDY);
 		}
 	}
 
 	time_left = wait_for_completion_timeout(&dev->cmd_complete,
 					      dev->adapter.timeout);
 	if (time_left == 0) {
+		dev->transfer_status |= at91_twi_read(dev, AT91_TWI_SR);
 		dev_err(dev->dev, "controller timed out\n");
 		at91_init_twi_bus(dev);
 		ret = -ETIMEDOUT;
@@ -460,6 +536,11 @@ static int at91_do_twi_transfer(struct at91_twi_dev *dev)
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
@@ -471,7 +552,14 @@ static int at91_do_twi_transfer(struct at91_twi_dev *dev)
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
 
@@ -481,6 +569,7 @@ static int at91_twi_xfer(struct i2c_adapter *adap, struct i2c_msg *msg, int num)
 	int ret;
 	unsigned int_addr_flag = 0;
 	struct i2c_msg *m_start = msg;
+	bool is_read, use_alt_cmd = false;
 
 	dev_dbg(&adap->dev, "at91_xfer: processing %d messages:\n", num);
 
@@ -503,8 +592,22 @@ static int at91_twi_xfer(struct i2c_adapter *adap, struct i2c_msg *msg, int num)
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
+		} else
+			at91_twi_write(dev, AT91_TWI_CR, AT91_TWI_ACMDIS);
+	}
+
+	at91_twi_write(dev, AT91_TWI_MMR,
+		       (m_start->addr << 16) |
+		       int_addr_flag |
+		       ((!use_alt_cmd && is_read) ? AT91_TWI_MREAD : 0));
 
 	dev->buf_len = m_start->len;
 	dev->buf = m_start->buf;
@@ -599,6 +702,13 @@ static struct at91_twi_pdata at91sam9x5_config = {
 	.has_unre_flag = false,
 };
 
+static struct at91_twi_pdata at91sama5d2_config = {
+	.clk_max_div = 7,
+	.clk_offset = 4,
+	.has_unre_flag = true,
+	.has_alt_cmd = true,
+};
+
 static const struct of_device_id atmel_twi_dt_ids[] = {
 	{
 		.compatible = "atmel,at91rm9200-i2c",
@@ -619,6 +729,9 @@ static const struct of_device_id atmel_twi_dt_ids[] = {
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
