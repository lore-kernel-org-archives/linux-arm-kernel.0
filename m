From: prasanna.ps@samsung.com (Prasanna Kumar)
Date: Tue, 26 Mar 2013 19:59:56 +0530
Subject: [PATCH] i2c: s3c2410: Add SMBus emulation for block read
Message-ID: <1364308196-10101-1-git-send-email-prasanna.ps@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jaemin Yoo <jmin.yoo@samsung.com>

SMBus read and write are supported by the emulation layer of i2c
framework if the controller doesn't have SMBus features.

I2C_M_RECV_LEN flag is used to let i2c drivers know rx length is not
yet determined but will be read to the first byte in rx buffer.

s3c2410 doesn't handle this flag. So only one byte is read from slave.
There fore following two features are added to the driver code.

1. skip rx length check if I2C_M_RECV_LEN is set and the length is 1.
2. add actual bytes to the rx length after reading first bytes if
   I2C_M_RECV_LEN.

I2C_M_RECV_LEN is only set for SMBus command. So this code does not
affect legacy codes which only use i2c command for s3c2410.

Signed-off-by: Jaemin Yoo <jmin.yoo@samsung.com>
Tested-by: Prasanna Kumar <prasanna.ps@samsung.com>
---
 drivers/i2c/busses/i2c-s3c2410.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
index 17c5c37..e4ab9ea 100644
--- a/drivers/i2c/busses/i2c-s3c2410.c
+++ b/drivers/i2c/busses/i2c-s3c2410.c
@@ -309,6 +309,12 @@ static inline int is_lastmsg(struct s3c24xx_i2c *i2c)
 
 static inline int is_msglast(struct s3c24xx_i2c *i2c)
 {
+	/* msg->len is always 1 for the first byte of smbus block read.
+	 * Actual length will be read from slave. More bytes will be
+	 * read according to the length then. */
+	if (i2c->msg->flags & I2C_M_RECV_LEN && i2c->msg->len == 1)
+		return 0;
+
 	return i2c->msg_ptr == i2c->msg->len-1;
 }
 
@@ -448,6 +454,9 @@ static int i2c_s3c_irq_nextbyte(struct s3c24xx_i2c *i2c, unsigned long iicstat)
 		byte = readb(i2c->regs + S3C2410_IICDS);
 		i2c->msg->buf[i2c->msg_ptr++] = byte;
 
+		/* Add actual length to read for smbus block read */
+		if (i2c->msg->flags & I2C_M_RECV_LEN && i2c->msg->len == 1)
+			i2c->msg->len += byte;
  prepare_read:
 		if (is_msglast(i2c)) {
 			/* last byte of buffer */
-- 
1.7.10.4
