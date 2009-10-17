From: linuxzsc@gmail.com (Richard Zhao)
Date: Sat, 17 Oct 2009 17:46:22 +0800
Subject: [PATCH V1 1/3] i2c: imx: check busy bit when START/STOP
Message-ID: <1255772784-11387-1-git-send-email-linuxzsc@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The controller can't do anything else before it actually generates START/STOP.
So we check busy bit to make sure START/STOP is successfully finished.

If we don't check busy bit, START/STOP may fail on some fast CPUs.

Signed-off-by: Richard Zhao <linuxzsc@gmail.com>

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 4afba3e..6055e92 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -120,19 +120,25 @@ struct imx_i2c_struct {
 	wait_queue_head_t	queue;
 	unsigned long		i2csr;
 	unsigned int 		disable_delay;
+	int			stopped;
 };
 
 /** Functions for IMX I2C adapter driver ***************************************
 *******************************************************************************/
 
-static int i2c_imx_bus_busy(struct imx_i2c_struct *i2c_imx)
+static int i2c_imx_bus_busy(struct imx_i2c_struct *i2c_imx, int for_busy)
 {
 	unsigned long orig_jiffies = jiffies;
+	unsigned int temp;
 
 	dev_dbg(&i2c_imx->adapter.dev, "<%s>\n", __func__);
 
-	/* wait for bus not busy */
-	while (readb(i2c_imx->base + IMX_I2C_I2SR) & I2SR_IBB) {
+	while (1) {
+		temp = readb(i2c_imx->base + IMX_I2C_I2SR);
+		if (for_busy && (temp & I2SR_IBB))
+			break;
+		if (!for_busy && !(temp & I2SR_IBB))
+			break;
 		if (signal_pending(current)) {
 			dev_dbg(&i2c_imx->adapter.dev,
 				"<%s> I2C Interrupted\n", __func__);
@@ -179,39 +185,55 @@ static int i2c_imx_acked(struct imx_i2c_struct *i2c_imx)
 	return 0;
 }
 
-static void i2c_imx_start(struct imx_i2c_struct *i2c_imx)
+static int i2c_imx_start(struct imx_i2c_struct *i2c_imx)
 {
 	unsigned int temp = 0;
+	int result;
 
 	dev_dbg(&i2c_imx->adapter.dev, "<%s>\n", __func__);
 
 	/* Enable I2C controller */
+	writeb(0, i2c_imx->base + IMX_I2C_I2SR);
 	writeb(I2CR_IEN, i2c_imx->base + IMX_I2C_I2CR);
+
+	/* Wait controller to be stable */
+	udelay(50);
+
 	/* Start I2C transaction */
 	temp = readb(i2c_imx->base + IMX_I2C_I2CR);
 	temp |= I2CR_MSTA;
 	writeb(temp, i2c_imx->base + IMX_I2C_I2CR);
+	result = i2c_imx_bus_busy(i2c_imx, 1);
+	if (result)
+		return result;
+	i2c_imx->stopped = 0;
+
 	temp |= I2CR_IIEN | I2CR_MTX | I2CR_TXAK;
 	writeb(temp, i2c_imx->base + IMX_I2C_I2CR);
+	return result;
 }
 
 static void i2c_imx_stop(struct imx_i2c_struct *i2c_imx)
 {
 	unsigned int temp = 0;
 
-	/* Stop I2C transaction */
-	dev_dbg(&i2c_imx->adapter.dev, "<%s>\n", __func__);
-	temp = readb(i2c_imx->base + IMX_I2C_I2CR);
-	temp &= ~I2CR_MSTA;
-	writeb(temp, i2c_imx->base + IMX_I2C_I2CR);
-	/* setup chip registers to defaults */
-	writeb(I2CR_IEN, i2c_imx->base + IMX_I2C_I2CR);
-	writeb(0, i2c_imx->base + IMX_I2C_I2SR);
+	if (!i2c_imx->stopped) {
+		/* Stop I2C transaction */
+		dev_dbg(&i2c_imx->adapter.dev, "<%s>\n", __func__);
+		temp = readb(i2c_imx->base + IMX_I2C_I2CR);
+		temp &= ~(I2CR_MSTA | I2CR_MTX);
+		writeb(temp, i2c_imx->base + IMX_I2C_I2CR);
+		i2c_imx->stopped = 1;
+	}
 	/*
 	 * This delay caused by an i.MXL hardware bug.
 	 * If no (or too short) delay, no "STOP" bit will be generated.
 	 */
 	udelay(i2c_imx->disable_delay);
+
+	if (!i2c_imx->stopped)
+		i2c_imx_bus_busy(i2c_imx, 0);
+
 	/* Disable I2C controller */
 	writeb(0, i2c_imx->base + IMX_I2C_I2CR);
 }
@@ -341,11 +363,15 @@ static int i2c_imx_read(struct imx_i2c_struct *i2c_imx, struct i2c_msg *msgs)
 		if (result)
 			return result;
 		if (i == (msgs->len - 1)) {
+			/* It must generate STOP before read I2DR to prevent
+			   controller from generating another clock cycle */
 			dev_dbg(&i2c_imx->adapter.dev,
 				"<%s> clear MSTA\n", __func__);
 			temp = readb(i2c_imx->base + IMX_I2C_I2CR);
-			temp &= ~I2CR_MSTA;
+			temp &= ~(I2CR_MSTA | I2CR_MTX);
 			writeb(temp, i2c_imx->base + IMX_I2C_I2CR);
+			i2c_imx_bus_busy(i2c_imx, 0);
+			i2c_imx->stopped = 1;
 		} else if (i == (msgs->len - 2)) {
 			dev_dbg(&i2c_imx->adapter.dev,
 				"<%s> set TXAK\n", __func__);
@@ -370,14 +396,11 @@ static int i2c_imx_xfer(struct i2c_adapter *adapter,
 
 	dev_dbg(&i2c_imx->adapter.dev, "<%s>\n", __func__);
 
-	/* Check if i2c bus is not busy */
-	result = i2c_imx_bus_busy(i2c_imx);
+	/* Start I2C transfer */
+	result = i2c_imx_start(i2c_imx);
 	if (result)
 		goto fail0;
 
-	/* Start I2C transfer */
-	i2c_imx_start(i2c_imx);
-
 	/* read/write data */
 	for (i = 0; i < num; i++) {
 		if (i) {
@@ -386,6 +409,9 @@ static int i2c_imx_xfer(struct i2c_adapter *adapter,
 			temp = readb(i2c_imx->base + IMX_I2C_I2CR);
 			temp |= I2CR_RSTA;
 			writeb(temp, i2c_imx->base + IMX_I2C_I2CR);
+			result =  i2c_imx_bus_busy(i2c_imx, 1);
+			if (result)
+				goto fail0;
 		}
 		dev_dbg(&i2c_imx->adapter.dev,
 			"<%s> transfer message: %d\n", __func__, i);
-- 
1.6.0.4
