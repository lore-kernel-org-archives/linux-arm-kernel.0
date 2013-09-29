From: marex@denx.de (Marek Vasut)
Date: Mon, 30 Sep 2013 01:23:55 +0200
Subject: [PATCH 3/3 V3] i2c: mxs: Fix PIO mode on i.MX23
In-Reply-To: <1380497035-7457-1-git-send-email-marex@denx.de>
References: <1380497035-7457-1-git-send-email-marex@denx.de>
Message-ID: <1380497035-7457-3-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The i.MX23 I2C controller is also capable of PIO, but needs a little harder
push to behave. The controller needs to be reset after every PIO/DMA operation
for some reason, otherwise in rare cases, the controller can hang or emit
bytes onto the bus.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Christoph Baumann <cb@sgoc.de>
Cc: Fabio Estevam <r49496@freescale.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Torsten Fleischer <to-fleischer@t-online.de>
Cc: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/i2c/busses/i2c-mxs.c | 40 +++++++++++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 11 deletions(-)

V3: No change

diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
index f986ff8..0e297e4 100644
--- a/drivers/i2c/busses/i2c-mxs.c
+++ b/drivers/i2c/busses/i2c-mxs.c
@@ -35,10 +35,12 @@
 
 #define MXS_I2C_CTRL0		(0x00)
 #define MXS_I2C_CTRL0_SET	(0x04)
+#define MXS_I2C_CTRL0_CLR	(0x08)
 
 #define MXS_I2C_CTRL0_SFTRST			0x80000000
 #define MXS_I2C_CTRL0_RUN			0x20000000
 #define MXS_I2C_CTRL0_SEND_NAK_ON_LAST		0x02000000
+#define MXS_I2C_CTRL0_PIO_MODE			0x01000000
 #define MXS_I2C_CTRL0_RETAIN_CLOCK		0x00200000
 #define MXS_I2C_CTRL0_POST_SEND_STOP		0x00100000
 #define MXS_I2C_CTRL0_PRE_SEND_START		0x00080000
@@ -69,10 +71,9 @@
 #define MXS_I2C_STAT_BUS_BUSY			0x00000800
 #define MXS_I2C_STAT_CLK_GEN_BUSY		0x00000400
 
-#define MXS_I2C_DATA		(0xa0)
+#define MXS_I2C_DATA(i2c)	((i2c->dev_type == MXS_I2C_V1) ? 0x60 : 0xa0)
 
-#define MXS_I2C_DEBUG0		(0xb0)
-#define MXS_I2C_DEBUG0_CLR	(0xb8)
+#define MXS_I2C_DEBUG0_CLR(i2c)	((i2c->dev_type == MXS_I2C_V1) ? 0x78 : 0xb8)
 
 #define MXS_I2C_DEBUG0_DMAREQ	0x80000000
 
@@ -355,7 +356,11 @@ static void mxs_i2c_pio_trigger_write_cmd(struct mxs_i2c_dev *i2c, u32 cmd,
 					  u32 data)
 {
 	writel(cmd, i2c->regs + MXS_I2C_CTRL0);
-	writel(data, i2c->regs + MXS_I2C_DATA);
+
+	if (i2c->dev_type == MXS_I2C_V1)
+		writel(MXS_I2C_CTRL0_PIO_MODE, i2c->regs + MXS_I2C_CTRL0_SET);
+
+	writel(data, i2c->regs + MXS_I2C_DATA(i2c));
 	writel(MXS_I2C_CTRL0_RUN, i2c->regs + MXS_I2C_CTRL0_SET);
 }
 
@@ -388,7 +393,6 @@ static int mxs_i2c_pio_setup_xfer(struct i2c_adapter *adap,
 	 * NOTE: The CTRL0::PIO_MODE description is important, since
 	 * it outlines how the PIO mode is really supposed to work.
 	 */
-
 	if (msg->flags & I2C_M_RD) {
 		/*
 		 * PIO READ transfer:
@@ -428,7 +432,7 @@ static int mxs_i2c_pio_setup_xfer(struct i2c_adapter *adap,
 			goto cleanup;
 		}
 
-		data = readl(i2c->regs + MXS_I2C_DATA);
+		data = readl(i2c->regs + MXS_I2C_DATA(i2c));
 		for (i = 0; i < msg->len; i++) {
 			msg->buf[i] = data & 0xff;
 			data >>= 8;
@@ -507,7 +511,7 @@ static int mxs_i2c_pio_setup_xfer(struct i2c_adapter *adap,
 				start & MXS_I2C_CTRL0_RETAIN_CLOCK ? "C": "");
 
 			writel(MXS_I2C_DEBUG0_DMAREQ,
-			       i2c->regs + MXS_I2C_DEBUG0_CLR);
+			       i2c->regs + MXS_I2C_DEBUG0_CLR(i2c));
 
 			mxs_i2c_pio_trigger_write_cmd(i2c,
 				start | MXS_I2C_CTRL0_MASTER_MODE |
@@ -543,6 +547,10 @@ cleanup:
 	writel(MXS_I2C_IRQ_MASK, i2c->regs + MXS_I2C_CTRL1_CLR);
 	writel(MXS_I2C_IRQ_MASK << 8, i2c->regs + MXS_I2C_CTRL1_SET);
 
+	/* Clear the PIO_MODE on i.MX23 */
+	if (i2c->dev_type == MXS_I2C_V1)
+		writel(MXS_I2C_CTRL0_PIO_MODE, i2c->regs + MXS_I2C_CTRL0_CLR);
+
 	return ret;
 }
 
@@ -575,10 +583,6 @@ static int mxs_i2c_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg,
 	if (!(msg->flags & I2C_M_RD) && (msg->len < 7))
 		use_pio = 1;
 
-	/* Disable PIO on MX23. */
-	if (i2c->dev_type == MXS_I2C_V1)
-		use_pio = 0;
-
 	i2c->cmd_err = 0;
 	if (use_pio) {
 		ret = mxs_i2c_pio_setup_xfer(adap, msg, flags);
@@ -608,6 +612,20 @@ static int mxs_i2c_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg,
 		       i2c->regs + MXS_I2C_CTRL1_SET);
 	}
 
+	/*
+	 * WARNING!
+	 * The i.MX23 is strange. After each and every operation, it's I2C IP
+	 * block must be reset, otherwise the IP block will misbehave. This can
+	 * be observed on the bus by the block sending out one single byte onto
+	 * the bus. In case such an error happens, bit 27 will be set in the
+	 * DEBUG0 register. This bit is not documented in the i.MX23 datasheet
+	 * and is marked as "TBD" instead. To reset this bit to a correct state,
+	 * reset the whole block. Since the block reset does not take long, do
+	 * reset the block after every transfer to play safe.
+	 */
+	if (i2c->dev_type == MXS_I2C_V1)
+		mxs_i2c_reset(i2c);
+
 	dev_dbg(i2c->dev, "Done with err=%d\n", ret);
 
 	return ret;
-- 
1.8.4.rc3
