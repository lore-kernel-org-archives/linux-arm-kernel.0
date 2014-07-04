From: mark.roszko@gmail.com (Marek Roszko)
Date: Fri,  4 Jul 2014 03:03:11 -0400
Subject: [PATCH] i2c:at91: add bound checking on smbus block length bytes
Message-ID: <1404457391-22330-1-git-send-email-mark.roszko@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver was not bound checking the recieved length byte to ensure it was less than
the buffer size that is allocated for smbus blocks. This resulted in buffer overflows
whenever an invalid byte was recieved.
It also failed to ensure the byte count was not zero. If it recieved zero, it would end up
in an infinite loop as the at91_twi_read_next_byte function returned immediately without
allowing RHR to be read to clear the RXRDY interrupt.

Tested agaisnt a smbus battery.

Signed-off-by: Marek Roszko <mark.roszko@gmail.com>
---
 drivers/i2c/busses/i2c-at91.c |   28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
index e95f9ba..ec4ff33 100644
--- a/drivers/i2c/busses/i2c-at91.c
+++ b/drivers/i2c/busses/i2c-at91.c
@@ -101,6 +101,7 @@ struct at91_twi_dev {
 	unsigned twi_cwgr_reg;
 	struct at91_twi_pdata *pdata;
 	bool use_dma;
+	bool recv_len_abort;
 	struct at91_twi_dma dma;
 };
 
@@ -267,12 +268,24 @@ static void at91_twi_read_next_byte(struct at91_twi_dev *dev)
 	*dev->buf = at91_twi_read(dev, AT91_TWI_RHR) & 0xff;
 	--dev->buf_len;
 
+	/* return if aborting, we only needed to read RHR to clear RXRDY*/
+	if (dev->recv_len_abort)
+		return;
+
 	/* handle I2C_SMBUS_BLOCK_DATA */
 	if (unlikely(dev->msg->flags & I2C_M_RECV_LEN)) {
-		dev->msg->flags &= ~I2C_M_RECV_LEN;
-		dev->buf_len += *dev->buf;
-		dev->msg->len = dev->buf_len + 1;
-		dev_dbg(dev->dev, "received block length %d\n", dev->buf_len);
+		/* ensure length byte is a valid value */
+		if (*dev->buf <= I2C_SMBUS_BLOCK_MAX && *dev->buf > 0) {
+			dev->msg->flags &= ~I2C_M_RECV_LEN;
+			dev->buf_len += *dev->buf;
+			dev->msg->len = dev->buf_len + 1;
+			dev_dbg(dev->dev, "received block length %d\n",
+					 dev->buf_len);
+		} else {
+			/* abort and send the stop by reading one more byte */
+			dev->recv_len_abort = true;
+			dev->buf_len = 1;
+		}
 	}
 
 	/* send stop if second but last byte has been read */
@@ -444,6 +457,12 @@ static int at91_do_twi_transfer(struct at91_twi_dev *dev)
 		ret = -EIO;
 		goto error;
 	}
+	if (dev->recv_len_abort) {
+		dev_err(dev->dev, "invalid smbus block length recvd\n");
+		ret = -EPROTO;
+		goto error;
+	}
+
 	dev_dbg(dev->dev, "transfer complete\n");
 
 	return 0;
@@ -500,6 +519,7 @@ static int at91_twi_xfer(struct i2c_adapter *adap, struct i2c_msg *msg, int num)
 	dev->buf_len = m_start->len;
 	dev->buf = m_start->buf;
 	dev->msg = m_start;
+	dev->recv_len_abort = false;
 
 	ret = at91_do_twi_transfer(dev);
 
-- 
1.7.10.4
