From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 21 Apr 2016 09:04:51 +0200
Subject: [PATCH v2 3/3] i2c: s3c2410: Cleanup indentation and comment style
In-Reply-To: <1461222291-5642-1-git-send-email-k.kozlowski@samsung.com>
References: <1461222291-5642-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1461222291-5642-3-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Improve the readability by:
 - fixing indentation,
 - switching to proper block comments,
 - removing spurious blank lines,
 - checkpatch: void function return statements are not generally useful,
 - checkpatch: braces {} are not necessary for any arm of this
   statement,
 - checkpatch: missing a blank line after declarations.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

Changes since v1:
1. Add Javier's reviewed-by.
---
 drivers/i2c/busses/i2c-s3c2410.c | 113 ++++++++++++++++++++-------------------
 1 file changed, 57 insertions(+), 56 deletions(-)

diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
index fd3695a921f1..70a9f0c1ebca 100644
--- a/drivers/i2c/busses/i2c-s3c2410.c
+++ b/drivers/i2c/busses/i2c-s3c2410.c
@@ -170,6 +170,7 @@ static inline kernel_ulong_t s3c24xx_get_device_quirks(struct platform_device *p
 {
 	if (pdev->dev.of_node) {
 		const struct of_device_id *match;
+
 		match = of_match_node(s3c24xx_i2c_match, pdev->dev.of_node);
 		return (kernel_ulong_t)match->data;
 	}
@@ -277,9 +278,10 @@ static void s3c24xx_i2c_message_start(struct s3c24xx_i2c *i2c,
 	dev_dbg(i2c->dev, "START: %08lx to IICSTAT, %02x to DS\n", stat, addr);
 	writeb(addr, i2c->regs + S3C2410_IICDS);
 
-	/* delay here to ensure the data byte has gotten onto the bus
-	 * before the transaction is started */
-
+	/*
+	 * delay here to ensure the data byte has gotten onto the bus
+	 * before the transaction is started
+	 */
 	ndelay(i2c->tx_setup);
 
 	dev_dbg(i2c->dev, "iiccon, %08lx\n", iiccon);
@@ -354,8 +356,10 @@ static inline void s3c24xx_i2c_stop(struct s3c24xx_i2c *i2c, int ret)
 	s3c24xx_i2c_disable_irq(i2c);
 }
 
-/* helper functions to determine the current state in the set of
- * messages we are sending */
+/*
+ * helper functions to determine the current state in the set of
+ * messages we are sending
+ */
 
 /*
  * returns TRUE if the current message is the last in the set
@@ -370,9 +374,11 @@ static inline int is_lastmsg(struct s3c24xx_i2c *i2c)
  */
 static inline int is_msglast(struct s3c24xx_i2c *i2c)
 {
-	/* msg->len is always 1 for the first byte of smbus block read.
+	/*
+	 * msg->len is always 1 for the first byte of smbus block read.
 	 * Actual length will be read from slave. More bytes will be
-	 * read according to the length then. */
+	 * read according to the length then.
+	 */
 	if (i2c->msg->flags & I2C_M_RECV_LEN && i2c->msg->len == 1)
 		return 0;
 
@@ -408,14 +414,13 @@ static int i2c_s3c_irq_nextbyte(struct s3c24xx_i2c *i2c, unsigned long iicstat)
 		goto out_ack;
 
 	case STATE_START:
-		/* last thing we did was send a start condition on the
+		/*
+		 * last thing we did was send a start condition on the
 		 * bus, or started a new i2c message
 		 */
-
 		if (iicstat & S3C2410_IICSTAT_LASTBIT &&
 		    !(i2c->msg->flags & I2C_M_IGNORE_NAK)) {
 			/* ack was not received... */
-
 			dev_dbg(i2c->dev, "ack was not received\n");
 			s3c24xx_i2c_stop(i2c, -ENXIO);
 			goto out_ack;
@@ -426,9 +431,10 @@ static int i2c_s3c_irq_nextbyte(struct s3c24xx_i2c *i2c, unsigned long iicstat)
 		else
 			i2c->state = STATE_WRITE;
 
-		/* terminate the transfer if there is nothing to do
-		 * as this is used by the i2c probe to find devices. */
-
+		/*
+		 * Terminate the transfer if there is nothing to do
+		 * as this is used by the i2c probe to find devices.
+		 */
 		if (is_lastmsg(i2c) && i2c->msg->len == 0) {
 			s3c24xx_i2c_stop(i2c, 0);
 			goto out_ack;
@@ -437,14 +443,16 @@ static int i2c_s3c_irq_nextbyte(struct s3c24xx_i2c *i2c, unsigned long iicstat)
 		if (i2c->state == STATE_READ)
 			goto prepare_read;
 
-		/* fall through to the write state, as we will need to
-		 * send a byte as well */
+		/*
+		 * fall through to the write state, as we will need to
+		 * send a byte as well
+		 */
 
 	case STATE_WRITE:
-		/* we are writing data to the device... check for the
+		/*
+		 * we are writing data to the device... check for the
 		 * end of the message, and if so, work out what to do
 		 */
-
 		if (!(i2c->msg->flags & I2C_M_IGNORE_NAK)) {
 			if (iicstat & S3C2410_IICSTAT_LASTBIT) {
 				dev_dbg(i2c->dev, "WRITE: No Ack\n");
@@ -460,12 +468,13 @@ static int i2c_s3c_irq_nextbyte(struct s3c24xx_i2c *i2c, unsigned long iicstat)
 			byte = i2c->msg->buf[i2c->msg_ptr++];
 			writeb(byte, i2c->regs + S3C2410_IICDS);
 
-			/* delay after writing the byte to allow the
+			/*
+			 * delay after writing the byte to allow the
 			 * data setup time on the bus, as writing the
 			 * data to the register causes the first bit
 			 * to appear on SDA, and SCL will change as
-			 * soon as the interrupt is acknowledged */
-
+			 * soon as the interrupt is acknowledged
+			 */
 			ndelay(i2c->tx_setup);
 
 		} else if (!is_lastmsg(i2c)) {
@@ -481,10 +490,11 @@ static int i2c_s3c_irq_nextbyte(struct s3c24xx_i2c *i2c, unsigned long iicstat)
 			if (i2c->msg->flags & I2C_M_NOSTART) {
 
 				if (i2c->msg->flags & I2C_M_RD) {
-					/* cannot do this, the controller
+					/*
+					 * cannot do this, the controller
 					 * forces us to send a new START
-					 * when we change direction */
-
+					 * when we change direction
+					 */
 					s3c24xx_i2c_stop(i2c, -EINVAL);
 				}
 
@@ -497,17 +507,16 @@ static int i2c_s3c_irq_nextbyte(struct s3c24xx_i2c *i2c, unsigned long iicstat)
 
 		} else {
 			/* send stop */
-
 			s3c24xx_i2c_stop(i2c, 0);
 		}
 		break;
 
 	case STATE_READ:
-		/* we have a byte of data in the data register, do
+		/*
+		 * we have a byte of data in the data register, do
 		 * something with it, and then work out whether we are
 		 * going to do any more read/write
 		 */
-
 		byte = readb(i2c->regs + S3C2410_IICDS);
 		i2c->msg->buf[i2c->msg_ptr++] = byte;
 
@@ -522,9 +531,10 @@ static int i2c_s3c_irq_nextbyte(struct s3c24xx_i2c *i2c, unsigned long iicstat)
 				s3c24xx_i2c_disable_ack(i2c);
 
 		} else if (is_msgend(i2c)) {
-			/* ok, we've read the entire buffer, see if there
-			 * is anything else we need to do */
-
+			/*
+			 * ok, we've read the entire buffer, see if there
+			 * is anything else we need to do
+			 */
 			if (is_lastmsg(i2c)) {
 				/* last message, send stop and complete */
 				dev_dbg(i2c->dev, "READ: Send Stop\n");
@@ -578,9 +588,10 @@ static irqreturn_t s3c24xx_i2c_irq(int irqno, void *dev_id)
 		goto out;
 	}
 
-	/* pretty much this leaves us with the fact that we've
-	 * transmitted or received whatever byte we last sent */
-
+	/*
+	 * pretty much this leaves us with the fact that we've
+	 * transmitted or received whatever byte we last sent
+	 */
 	i2c_s3c_irq_nextbyte(i2c, status);
 
  out:
@@ -726,9 +737,10 @@ static int s3c24xx_i2c_doxfer(struct s3c24xx_i2c *i2c,
 
 	ret = i2c->msg_idx;
 
-	/* having these next two as dev_err() makes life very
-	 * noisy when doing an i2cdetect */
-
+	/*
+	 * Having these next two as dev_err() makes life very
+	 * noisy when doing an i2cdetect
+	 */
 	if (timeout == 0)
 		dev_dbg(i2c->dev, "timeout\n");
 	else if (ret != num)
@@ -1071,10 +1083,7 @@ s3c24xx_i2c_parse_dt(struct device_node *np, struct s3c24xx_i2c *i2c)
 }
 #else
 static void
-s3c24xx_i2c_parse_dt(struct device_node *np, struct s3c24xx_i2c *i2c)
-{
-	return;
-}
+s3c24xx_i2c_parse_dt(struct device_node *np, struct s3c24xx_i2c *i2c) { }
 #endif
 
 static int s3c24xx_i2c_probe(struct platform_device *pdev)
@@ -1117,7 +1126,6 @@ static int s3c24xx_i2c_probe(struct platform_device *pdev)
 	init_waitqueue_head(&i2c->wait);
 
 	/* find the clock and enable it */
-
 	i2c->dev = &pdev->dev;
 	i2c->clk = devm_clk_get(&pdev->dev, "i2c");
 	if (IS_ERR(i2c->clk)) {
@@ -1127,9 +1135,7 @@ static int s3c24xx_i2c_probe(struct platform_device *pdev)
 
 	dev_dbg(&pdev->dev, "clock source %p\n", i2c->clk);
 
-
 	/* map the registers */
-
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	i2c->regs = devm_ioremap_resource(&pdev->dev, res);
 
@@ -1140,22 +1146,17 @@ static int s3c24xx_i2c_probe(struct platform_device *pdev)
 		i2c->regs, res);
 
 	/* setup info block for the i2c core */
-
 	i2c->adap.algo_data = i2c;
 	i2c->adap.dev.parent = &pdev->dev;
-
 	i2c->pctrl = devm_pinctrl_get_select_default(i2c->dev);
 
 	/* inititalise the i2c gpio lines */
-
-	if (i2c->pdata->cfg_gpio) {
+	if (i2c->pdata->cfg_gpio)
 		i2c->pdata->cfg_gpio(to_platform_device(i2c->dev));
-	} else if (IS_ERR(i2c->pctrl) && s3c24xx_i2c_parse_dt_gpio(i2c)) {
+	else if (IS_ERR(i2c->pctrl) && s3c24xx_i2c_parse_dt_gpio(i2c))
 		return -EINVAL;
-	}
 
 	/* initialise the i2c controller */
-
 	clk_prepare_enable(i2c->clk);
 	ret = s3c24xx_i2c_init(i2c);
 	clk_disable(i2c->clk);
@@ -1164,10 +1165,11 @@ static int s3c24xx_i2c_probe(struct platform_device *pdev)
 		clk_unprepare(i2c->clk);
 		return ret;
 	}
-	/* find the IRQ for this unit (note, this relies on the init call to
+
+	/*
+	 * find the IRQ for this unit (note, this relies on the init call to
 	 * ensure no current IRQs pending
 	 */
-
 	if (!(i2c->quirks & QUIRK_POLL)) {
 		i2c->irq = ret = platform_get_irq(pdev, 0);
 		if (ret <= 0) {
@@ -1176,9 +1178,8 @@ static int s3c24xx_i2c_probe(struct platform_device *pdev)
 			return ret;
 		}
 
-	ret = devm_request_irq(&pdev->dev, i2c->irq, s3c24xx_i2c_irq, 0,
-				dev_name(&pdev->dev), i2c);
-
+		ret = devm_request_irq(&pdev->dev, i2c->irq, s3c24xx_i2c_irq,
+				       0, dev_name(&pdev->dev), i2c);
 		if (ret != 0) {
 			dev_err(&pdev->dev, "cannot claim IRQ %d\n", i2c->irq);
 			clk_unprepare(i2c->clk);
@@ -1193,12 +1194,12 @@ static int s3c24xx_i2c_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	/* Note, previous versions of the driver used i2c_add_adapter()
+	/*
+	 * Note, previous versions of the driver used i2c_add_adapter()
 	 * to add the bus at any number. We now pass the bus number via
 	 * the platform data, so if unset it will now default to always
 	 * being bus 0.
 	 */
-
 	i2c->adap.nr = i2c->pdata->bus_num;
 	i2c->adap.dev.of_node = pdev->dev.of_node;
 
-- 
1.9.1
