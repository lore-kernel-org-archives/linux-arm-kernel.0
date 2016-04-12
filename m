From: peter.griffin@linaro.org (Peter Griffin)
Date: Tue, 12 Apr 2016 14:29:19 +0100
Subject: [PATCH] i2c: st: Implement i2c_bus_recovery_info callbacks
Message-ID: <1460467759-11737-1-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>From I2C specification:

http://www.nxp.com/documents/user_manual/UM10204.pdf

Rev. 03 section 3.1.16 titled "Bus clear". When the i2c device held the
SDA line low, the master should send 9 clocks pulses to try to recover.

Signed-off-by: Frederic Pillon <frederic.pillon@st.com>
Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 drivers/i2c/busses/i2c-st.c | 56 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 55 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-st.c b/drivers/i2c/busses/i2c-st.c
index 6ee7715..37b0b34 100644
--- a/drivers/i2c/busses/i2c-st.c
+++ b/drivers/i2c/busses/i2c-st.c
@@ -337,10 +337,51 @@ static void st_i2c_hw_config(struct st_i2c_dev *i2c_dev)
 	writel_relaxed(val, i2c_dev->base + SSC_NOISE_SUPP_WIDTH_DATAOUT);
 }
 
+/*
+ * i2c bus recovery routines
+ * get_scl and set_scl must be defined to avoid the recover_bus field of
+ * i2c_bus_recovery_info to be overriden with NULL during the
+ * i2c_add_adapter call
+ */
+
+static int st_i2c_get_scl(struct i2c_adapter *adap)
+{
+	return 0;
+}
+
+static void st_i2c_set_scl(struct i2c_adapter *adap, int val)
+{
+}
+
+static int st_i2c_recover_bus(struct i2c_adapter *i2c_adap)
+{
+	struct st_i2c_dev *i2c_dev = i2c_get_adapdata(i2c_adap);
+	u32 ctl;
+
+	dev_err(i2c_dev->dev, "Trying to recover bus\n");
+
+	/* Disable interrupts */
+	writel_relaxed(0, i2c_dev->base + SSC_IEN);
+
+	st_i2c_hw_config(i2c_dev);
+
+	ctl = SSC_CTL_EN | SSC_CTL_MS |	SSC_CTL_EN_RX_FIFO | SSC_CTL_EN_TX_FIFO;
+	st_i2c_set_bits(i2c_dev->base + SSC_CTL, ctl);
+
+	st_i2c_clr_bits(i2c_dev->base + SSC_I2C, SSC_I2C_I2CM);
+	usleep_range(8000, 10000);
+
+	writel_relaxed(0, i2c_dev->base + SSC_TBUF);
+	usleep_range(2000, 4000);
+	st_i2c_set_bits(i2c_dev->base + SSC_I2C, SSC_I2C_I2CM);
+
+	return 0;
+}
+
 static int st_i2c_wait_free_bus(struct st_i2c_dev *i2c_dev)
 {
 	u32 sta;
-	int i;
+	int i, ret;
 
 	for (i = 0; i < 10; i++) {
 		sta = readl_relaxed(i2c_dev->base + SSC_STA);
@@ -352,6 +393,12 @@ static int st_i2c_wait_free_bus(struct st_i2c_dev *i2c_dev)
 
 	dev_err(i2c_dev->dev, "bus not free (status = 0x%08x)\n", sta);
 
+	ret = i2c_recover_bus(&i2c_dev->adap);
+	if (ret) {
+		dev_err(i2c_dev->dev, "Failed to recover the bus (%d)\n", ret);
+		return ret;
+	}
+
 	return -EBUSY;
 }
 
@@ -744,6 +791,12 @@ static struct i2c_algorithm st_i2c_algo = {
 	.functionality = st_i2c_func,
 };
 
+static struct i2c_bus_recovery_info st_i2c_recovery_info = {
+	.recover_bus = st_i2c_recover_bus,
+	.get_scl =  st_i2c_get_scl,
+	.set_scl =  st_i2c_set_scl,
+};
+
 static int st_i2c_of_get_deglitch(struct device_node *np,
 		struct st_i2c_dev *i2c_dev)
 {
@@ -826,6 +879,7 @@ static int st_i2c_probe(struct platform_device *pdev)
 	adap->timeout = 2 * HZ;
 	adap->retries = 0;
 	adap->algo = &st_i2c_algo;
+	adap->bus_recovery_info = &st_i2c_recovery_info;
 	adap->dev.parent = &pdev->dev;
 	adap->dev.of_node = pdev->dev.of_node;
 
-- 
1.9.1
