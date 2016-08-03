From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Wed, 3 Aug 2016 16:58:26 +0200
Subject: [PATCH] i2c: at91: fix support of the "alternative command" feature
Message-ID: <20160803145826.11927-1-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Cyrille Pitchen <cyrille.pitchen@atmel.com>

The "alternative command" feature was introduced with sama5d2 SoCs.

Its purpose is to let the hardware i2c controller automatically send the
STOP condition on the i2c bus at the end of a data transfer.
Without this feature, the i2c driver has to write the 'STOP' bit into the
Control Register so the hardware i2c controller is triggered to send the
STOP condition on the bus.

Using the "alternative command" feature requires to set the transfer data
length into the 8bit DATAL field of the Alternative Command Register.
Hence only data transfers up to 255 bytes can take advantage of the
"alternative command" feature. For greater data transfer sizes, the driver
should use the previous implementation, when the "alternative command"
support was not implemented yet.

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 drivers/i2c/busses/i2c-at91.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
index f233726..1bb97f6 100644
--- a/drivers/i2c/busses/i2c-at91.c
+++ b/drivers/i2c/busses/i2c-at91.c
@@ -38,6 +38,7 @@
 #define AT91_I2C_TIMEOUT	msecs_to_jiffies(100)	/* transfer timeout */
 #define AT91_I2C_DMA_THRESHOLD	8			/* enable DMA if transfer size is bigger than this threshold */
 #define AUTOSUSPEND_TIMEOUT		2000
+#define AT91_I2C_MAX_ALT_CMD_DATA_SIZE	256
 
 /* AT91 TWI register definitions */
 #define	AT91_TWI_CR		0x0000	/* Control Register */
@@ -141,6 +142,7 @@ struct at91_twi_dev {
 	unsigned twi_cwgr_reg;
 	struct at91_twi_pdata *pdata;
 	bool use_dma;
+	bool use_alt_cmd;
 	bool recv_len_abort;
 	u32 fifo_size;
 	struct at91_twi_dma dma;
@@ -269,7 +271,7 @@ static void at91_twi_write_next_byte(struct at91_twi_dev *dev)
 
 	/* send stop when last byte has been written */
 	if (--dev->buf_len == 0)
-		if (!dev->pdata->has_alt_cmd)
+		if (!dev->use_alt_cmd)
 			at91_twi_write(dev, AT91_TWI_CR, AT91_TWI_STOP);
 
 	dev_dbg(dev->dev, "wrote 0x%x, to go %d\n", *dev->buf, dev->buf_len);
@@ -292,7 +294,7 @@ static void at91_twi_write_data_dma_callback(void *data)
 	 * we just have to enable TXCOMP one.
 	 */
 	at91_twi_write(dev, AT91_TWI_IER, AT91_TWI_TXCOMP);
-	if (!dev->pdata->has_alt_cmd)
+	if (!dev->use_alt_cmd)
 		at91_twi_write(dev, AT91_TWI_CR, AT91_TWI_STOP);
 }
 
@@ -410,7 +412,7 @@ static void at91_twi_read_next_byte(struct at91_twi_dev *dev)
 	}
 
 	/* send stop if second but last byte has been read */
-	if (!dev->pdata->has_alt_cmd && dev->buf_len == 1)
+	if (!dev->use_alt_cmd && dev->buf_len == 1)
 		at91_twi_write(dev, AT91_TWI_CR, AT91_TWI_STOP);
 
 	dev_dbg(dev->dev, "read 0x%x, to go %d\n", *dev->buf, dev->buf_len);
@@ -426,7 +428,7 @@ static void at91_twi_read_data_dma_callback(void *data)
 	dma_unmap_single(dev->dev, sg_dma_address(&dev->dma.sg[0]),
 			 dev->buf_len, DMA_FROM_DEVICE);
 
-	if (!dev->pdata->has_alt_cmd) {
+	if (!dev->use_alt_cmd) {
 		/* The last two bytes have to be read without using dma */
 		dev->buf += dev->buf_len - 2;
 		dev->buf_len = 2;
@@ -443,7 +445,7 @@ static void at91_twi_read_data_dma(struct at91_twi_dev *dev)
 	struct dma_chan *chan_rx = dma->chan_rx;
 	size_t buf_len;
 
-	buf_len = (dev->pdata->has_alt_cmd) ? dev->buf_len : dev->buf_len - 2;
+	buf_len = (dev->use_alt_cmd) ? dev->buf_len : dev->buf_len - 2;
 	dma->direction = DMA_FROM_DEVICE;
 
 	/* Keep in mind that we won't use dma to read the last two bytes */
@@ -651,7 +653,7 @@ static int at91_do_twi_transfer(struct at91_twi_dev *dev)
 		unsigned start_flags = AT91_TWI_START;
 
 		/* if only one byte is to be read, immediately stop transfer */
-		if (!has_alt_cmd && dev->buf_len <= 1 &&
+		if (!dev->use_alt_cmd && dev->buf_len <= 1 &&
 		    !(dev->msg->flags & I2C_M_RECV_LEN))
 			start_flags |= AT91_TWI_STOP;
 		at91_twi_write(dev, AT91_TWI_CR, start_flags);
@@ -745,7 +747,7 @@ static int at91_twi_xfer(struct i2c_adapter *adap, struct i2c_msg *msg, int num)
 	int ret;
 	unsigned int_addr_flag = 0;
 	struct i2c_msg *m_start = msg;
-	bool is_read, use_alt_cmd = false;
+	bool is_read;
 
 	dev_dbg(&adap->dev, "at91_xfer: processing %d messages:\n", num);
 
@@ -768,14 +770,16 @@ static int at91_twi_xfer(struct i2c_adapter *adap, struct i2c_msg *msg, int num)
 		at91_twi_write(dev, AT91_TWI_IADR, internal_address);
 	}
 
+	dev->use_alt_cmd = false;
 	is_read = (m_start->flags & I2C_M_RD);
 	if (dev->pdata->has_alt_cmd) {
-		if (m_start->len > 0) {
+		if (m_start->len > 0 &&
+		    m_start->len < AT91_I2C_MAX_ALT_CMD_DATA_SIZE) {
 			at91_twi_write(dev, AT91_TWI_CR, AT91_TWI_ACMEN);
 			at91_twi_write(dev, AT91_TWI_ACR,
 				       AT91_TWI_ACR_DATAL(m_start->len) |
 				       ((is_read) ? AT91_TWI_ACR_DIR : 0));
-			use_alt_cmd = true;
+			dev->use_alt_cmd = true;
 		} else {
 			at91_twi_write(dev, AT91_TWI_CR, AT91_TWI_ACMDIS);
 		}
@@ -784,7 +788,7 @@ static int at91_twi_xfer(struct i2c_adapter *adap, struct i2c_msg *msg, int num)
 	at91_twi_write(dev, AT91_TWI_MMR,
 		       (m_start->addr << 16) |
 		       int_addr_flag |
-		       ((!use_alt_cmd && is_read) ? AT91_TWI_MREAD : 0));
+		       ((!dev->use_alt_cmd && is_read) ? AT91_TWI_MREAD : 0));
 
 	dev->buf_len = m_start->len;
 	dev->buf = m_start->buf;
-- 
2.9.0
