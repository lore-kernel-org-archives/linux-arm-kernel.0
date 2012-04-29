From: marex@denx.de (Marek Vasut)
Date: Mon, 30 Apr 2012 00:36:08 +0200
Subject: [PATCH 1/2] I2C: Set I2C timing registers for mxs-i2c
Message-ID: <1335738969-27445-1-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This sets the bus to run at 400kHz, prior to this,
the bus frequency was undefined.

Cc: Linux I2C <linux-i2c@vger.kernel.org>
Cc: Detlev Zundel <dzu@denx.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Stefano Babic <sbabic@denx.de>
Cc: Wolfgang Denk <wd@denx.de>
Cc: Wolfram Sang <w.sang@pengutronix.de>
---
 drivers/i2c/busses/i2c-mxs.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
index 3d471d5..0d8e485 100644
--- a/drivers/i2c/busses/i2c-mxs.c
+++ b/drivers/i2c/busses/i2c-mxs.c
@@ -43,6 +43,10 @@
 #define MXS_I2C_CTRL0_DIRECTION			0x00010000
 #define MXS_I2C_CTRL0_XFER_COUNT(v)		((v) & 0x0000FFFF)
 
+#define MXS_I2C_TIMING0		(0x10)
+#define MXS_I2C_TIMING1		(0x20)
+#define MXS_I2C_TIMING2		(0x30)
+
 #define MXS_I2C_CTRL1		(0x40)
 #define MXS_I2C_CTRL1_SET	(0x44)
 #define MXS_I2C_CTRL1_CLR	(0x48)
@@ -118,6 +122,12 @@ struct mxs_i2c_dev {
 static void mxs_i2c_reset(struct mxs_i2c_dev *i2c)
 {
 	mxs_reset_block(i2c->regs);
+
+	/* I2C is running at 400kHz */
+	writel(0x000f0007, i2c->regs + MXS_I2C_TIMING0);
+	writel(0x001f000f, i2c->regs + MXS_I2C_TIMING1);
+	writel(0x0015000d, i2c->regs + MXS_I2C_TIMING2);
+
 	writel(MXS_I2C_IRQ_MASK << 8, i2c->regs + MXS_I2C_CTRL1_SET);
 	writel(MXS_I2C_QUEUECTRL_PIO_QUEUE_MODE,
 			i2c->regs + MXS_I2C_QUEUECTRL_SET);
-- 
1.7.10
