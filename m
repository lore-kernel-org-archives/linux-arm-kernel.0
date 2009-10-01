From: linuxzsc@gmail.com (Richard Zhao)
Date: Thu,  1 Oct 2009 09:13:32 +0800
Subject: [PATCH 3/4] i2c: imx: add macros and printk to make debug easy
In-Reply-To: <1254359613-21210-2-git-send-email-linuxzsc@gmail.com>
References: <1254359613-21210-1-git-send-email-linuxzsc@gmail.com>
	<1254359613-21210-2-git-send-email-linuxzsc@gmail.com>
Message-ID: <1254359613-21210-3-git-send-email-linuxzsc@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When CONFIG_I2C_DEBUG_BUS is enabled, it helps dump registers at operation
fail condition, and print i2c_msg to xfer.

Signed-off-by: Richard Zhao <linuxzsc@gmail.com>

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index c1e541c..87faea4 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -125,6 +125,20 @@ struct imx_i2c_struct {
 /** Functions for IMX I2C adapter driver ***************************************
 *******************************************************************************/
 
+#ifdef CONFIG_I2C_DEBUG_BUS
+#define reg_dump(i2c_imx) \
+{ \
+	printk(KERN_DEBUG "fun %s:%d ", __func__, __LINE__); \
+	printk(KERN_DEBUG "IADR %02x IFDR %02x I2CR %02x I2SR %02x\n", \
+		readb(i2c_imx->base + IMX_I2C_IADR), \
+		readb(i2c_imx->base + IMX_I2C_IFDR), \
+		readb(i2c_imx->base + IMX_I2C_I2CR), \
+		readb(i2c_imx->base + IMX_I2C_I2SR)); \
+}
+#else
+#define reg_dump(i2c_imx)
+#endif
+
 static int i2c_imx_bus_busy(struct imx_i2c_struct *i2c_imx, int for_busy)
 {
 	unsigned long orig_jiffies = jiffies;
@@ -146,6 +160,7 @@ static int i2c_imx_bus_busy(struct imx_i2c_struct *i2c_imx, int for_busy)
 		if (time_after(jiffies, orig_jiffies + HZ / 1000)) {
 			dev_dbg(&i2c_imx->adapter.dev,
 				"<%s> I2C bus is busy\n", __func__);
+			reg_dump(i2c_imx);
 			return -EIO;
 		}
 		schedule();
@@ -164,9 +179,11 @@ static int i2c_imx_trx_complete(struct imx_i2c_struct *i2c_imx)
 
 	if (unlikely(result < 0)) {
 		dev_dbg(&i2c_imx->adapter.dev, "<%s> result < 0\n", __func__);
+		reg_dump(i2c_imx);
 		return result;
 	} else if (unlikely(!(i2c_imx->i2csr & I2SR_IIF))) {
 		dev_dbg(&i2c_imx->adapter.dev, "<%s> Timeout\n", __func__);
+		reg_dump(i2c_imx);
 		return -ETIMEDOUT;
 	}
 	dev_dbg(&i2c_imx->adapter.dev, "<%s> TRX complete\n", __func__);
@@ -178,6 +195,7 @@ static int i2c_imx_acked(struct imx_i2c_struct *i2c_imx)
 {
 	if (readb(i2c_imx->base + IMX_I2C_I2SR) & I2SR_RXAK) {
 		dev_dbg(&i2c_imx->adapter.dev, "<%s> No ACK\n", __func__);
+		reg_dump(i2c_imx);
 		return -EIO;  /* No ACK */
 	}
 
@@ -197,17 +215,20 @@ static int i2c_imx_start(struct imx_i2c_struct *i2c_imx)
 	writeb(I2CR_IEN, i2c_imx->base + IMX_I2C_I2CR);
 
 	result = i2c_imx_bus_busy(i2c_imx, 0);
-	if (result)
+	if (result) {
+		reg_dump(i2c_imx);
 		return result;
+	}
 
 	/* Start I2C transaction */
 	temp = readb(i2c_imx->base + IMX_I2C_I2CR);
 	temp |= I2CR_MSTA;
 	writeb(temp, i2c_imx->base + IMX_I2C_I2CR);
 	result = i2c_imx_bus_busy(i2c_imx, 1);
-	if (result)
+	if (result) {
+		reg_dump(i2c_imx);
 		return result;
-
+	}
 	temp |= I2CR_IIEN | I2CR_MTX | I2CR_TXAK;
 	writeb(temp, i2c_imx->base + IMX_I2C_I2CR);
 	return result;
@@ -228,7 +249,8 @@ static void i2c_imx_stop(struct imx_i2c_struct *i2c_imx)
 	 */
 	udelay(i2c_imx->disable_delay);
 
-	i2c_imx_bus_busy(i2c_imx, 0);
+	if (i2c_imx_bus_busy(i2c_imx, 0))
+		reg_dump(i2c_imx);
 
 	/* Disable I2C controller */
 	writeb(0, i2c_imx->base + IMX_I2C_I2CR);
@@ -389,7 +411,18 @@ static int i2c_imx_xfer(struct i2c_adapter *adapter,
 	struct imx_i2c_struct *i2c_imx = i2c_get_adapdata(adapter);
 
 	dev_dbg(&i2c_imx->adapter.dev, "<%s>\n", __func__);
-
+#ifdef CONFIG_I2C_DEBUG_BUS
+	for (i = 0; i < num; i++) {
+		printk(KERN_DEBUG "msg%d addr %02x RD %d cnt %d d:", i,
+			msgs[i].addr, msgs[i].flags & I2C_M_RD, msgs[i].len);
+		if (!(msgs[i].flags & I2C_M_RD)) {
+			int j;
+			for (j = 0; j < msgs[i].len; j++)
+				printk("%02x ", msgs[i].buf[j]);
+		}
+		printk("\n");
+	}
+#endif
 	/* Start I2C transfer */
 	result = i2c_imx_start(i2c_imx);
 	if (result)
@@ -404,8 +437,10 @@ static int i2c_imx_xfer(struct i2c_adapter *adapter,
 			temp |= I2CR_RSTA;
 			writeb(temp, i2c_imx->base + IMX_I2C_I2CR);
 			result =  i2c_imx_bus_busy(i2c_imx, 1);
-			if (result)
+			if (result) {
+				reg_dump(i2c_imx);
 				goto fail0;
+			}
 		}
 		dev_dbg(&i2c_imx->adapter.dev,
 			"<%s> transfer message: %d\n", __func__, i);
@@ -562,7 +597,7 @@ static int __init i2c_imx_probe(struct platform_device *pdev)
 		res_size, i2c_imx->res->start);
 	dev_dbg(&i2c_imx->adapter.dev, "adapter name: \"%s\"\n",
 		i2c_imx->adapter.name);
-	dev_dbg(&i2c_imx->adapter.dev, "IMX I2C adapter registered\n");
+	dev_info(&i2c_imx->adapter.dev, "IMX I2C adapter registered\n");
 
 	return 0;   /* Return OK */
 
-- 
1.6.0.4
