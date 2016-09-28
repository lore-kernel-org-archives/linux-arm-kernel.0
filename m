From: noralf@tronnes.org (=?UTF-8?q?Noralf=20Tr=C3=B8nnes?=)
Date: Wed, 28 Sep 2016 19:50:56 +0200
Subject: [PATCH v3 7/7] i2c: bcm2835: Add support for dynamic clock
In-Reply-To: <1475085056-5205-1-git-send-email-noralf@tronnes.org>
References: <1475085056-5205-1-git-send-email-noralf@tronnes.org>
Message-ID: <1475085056-5205-8-git-send-email-noralf@tronnes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support a dynamic clock by reading the frequency and setting the
divisor in the transfer function instead of during probe.

Signed-off-by: Noralf Tr?nnes <noralf@tronnes.org>
---
 drivers/i2c/busses/i2c-bcm2835.c | 51 +++++++++++++++++++++++++---------------
 1 file changed, 32 insertions(+), 19 deletions(-)

diff --git a/drivers/i2c/busses/i2c-bcm2835.c b/drivers/i2c/busses/i2c-bcm2835.c
index 6a3e753..2b6b682 100644
--- a/drivers/i2c/busses/i2c-bcm2835.c
+++ b/drivers/i2c/busses/i2c-bcm2835.c
@@ -58,6 +58,7 @@ struct bcm2835_i2c_dev {
 	void __iomem *regs;
 	struct clk *clk;
 	int irq;
+	u32 bus_clk_rate;
 	struct i2c_adapter adapter;
 	struct completion completion;
 	struct i2c_msg *curr_msg;
@@ -78,6 +79,30 @@ static inline u32 bcm2835_i2c_readl(struct bcm2835_i2c_dev *i2c_dev, u32 reg)
 	return readl(i2c_dev->regs + reg);
 }
 
+static int bcm2835_i2c_set_divider(struct bcm2835_i2c_dev *i2c_dev)
+{
+	u32 divider;
+
+	divider = DIV_ROUND_UP(clk_get_rate(i2c_dev->clk),
+			       i2c_dev->bus_clk_rate);
+	/*
+	 * Per the datasheet, the register is always interpreted as an even
+	 * number, by rounding down. In other words, the LSB is ignored. So,
+	 * if the LSB is set, increment the divider to avoid any issue.
+	 */
+	if (divider & 1)
+		divider++;
+	if ((divider < BCM2835_I2C_CDIV_MIN) ||
+	    (divider > BCM2835_I2C_CDIV_MAX)) {
+		dev_err_ratelimited(i2c_dev->dev, "Invalid clock-frequency\n");
+		return -EINVAL;
+	}
+
+	bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_DIV, divider);
+
+	return 0;
+}
+
 static void bcm2835_fill_txfifo(struct bcm2835_i2c_dev *i2c_dev)
 {
 	u32 val;
@@ -215,7 +240,7 @@ static int bcm2835_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[],
 {
 	struct bcm2835_i2c_dev *i2c_dev = i2c_get_adapdata(adap);
 	unsigned long time_left;
-	int i;
+	int i, ret;
 
 	for (i = 0; i < (num - 1); i++)
 		if (msgs[i].flags & I2C_M_RD) {
@@ -224,6 +249,10 @@ static int bcm2835_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[],
 			return -EOPNOTSUPP;
 		}
 
+	ret = bcm2835_i2c_set_divider(i2c_dev);
+	if (ret)
+		return ret;
+
 	i2c_dev->curr_msg = msgs;
 	i2c_dev->num_msgs = num;
 	reinit_completion(&i2c_dev->completion);
@@ -273,7 +302,6 @@ static int bcm2835_i2c_probe(struct platform_device *pdev)
 {
 	struct bcm2835_i2c_dev *i2c_dev;
 	struct resource *mem, *irq;
-	u32 bus_clk_rate, divider;
 	int ret;
 	struct i2c_adapter *adap;
 
@@ -297,27 +325,12 @@ static int bcm2835_i2c_probe(struct platform_device *pdev)
 	}
 
 	ret = of_property_read_u32(pdev->dev.of_node, "clock-frequency",
-				   &bus_clk_rate);
+				   &i2c_dev->bus_clk_rate);
 	if (ret < 0) {
 		dev_warn(&pdev->dev,
 			 "Could not read clock-frequency property\n");
-		bus_clk_rate = 100000;
-	}
-
-	divider = DIV_ROUND_UP(clk_get_rate(i2c_dev->clk), bus_clk_rate);
-	/*
-	 * Per the datasheet, the register is always interpreted as an even
-	 * number, by rounding down. In other words, the LSB is ignored. So,
-	 * if the LSB is set, increment the divider to avoid any issue.
-	 */
-	if (divider & 1)
-		divider++;
-	if ((divider < BCM2835_I2C_CDIV_MIN) ||
-	    (divider > BCM2835_I2C_CDIV_MAX)) {
-		dev_err(&pdev->dev, "Invalid clock-frequency\n");
-		return -ENODEV;
+		i2c_dev->bus_clk_rate = 100000;
 	}
-	bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_DIV, divider);
 
 	irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
 	if (!irq) {
-- 
2.8.2
