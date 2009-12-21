From: kevin.wells@nxp.com (Kevin Wells)
Date: Tue, 22 Dec 2009 00:23:16 +0100
Subject: [PATCH 10/10] ARM: PNX4008: get i2c clock rate from clk API
Message-ID: <083DF309106F364B939360100EC290F804F592E90A@eu1rdcrdc1wx030.exi.nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Kevin Wells <kevin.wells@nxp.com>
---
 arch/arm/mach-pnx4008/clock.c |    9 ++++++---
 arch/arm/mach-pnx4008/i2c.c   |    9 ---------
 drivers/i2c/busses/i2c-pnx.c  |   15 ++++-----------
 include/linux/i2c-pnx.h       |    1 -
 4 files changed, 10 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-pnx4008/clock.c b/arch/arm/mach-pnx4008/clock.c
index 3f6b681..4448fb9 100644
--- a/arch/arm/mach-pnx4008/clock.c
+++ b/arch/arm/mach-pnx4008/clock.c
@@ -639,9 +639,10 @@ static struct clk flash_ck = {
 static struct clk i2c0_ck = {
 	.name = "i2c0_ck",
 	.parent = &per_ck,
-	.flags = NEEDS_INITIALIZATION,
+	.flags = NEEDS_INITIALIZATION | FIXED_RATE,
 	.enable_shift = 0,
 	.enable_reg = I2CCLKCTRL_REG,
+	.rate = 13000000,
 	.enable = clk_reg_enable,
 	.disable = clk_reg_disable,
 };
@@ -649,9 +650,10 @@ static struct clk i2c0_ck = {
 static struct clk i2c1_ck = {
 	.name = "i2c1_ck",
 	.parent = &per_ck,
-	.flags = NEEDS_INITIALIZATION,
+	.flags = NEEDS_INITIALIZATION | FIXED_RATE,
 	.enable_shift = 1,
 	.enable_reg = I2CCLKCTRL_REG,
+	.rate = 13000000,
 	.enable = clk_reg_enable,
 	.disable = clk_reg_disable,
 };
@@ -659,9 +661,10 @@ static struct clk i2c1_ck = {
 static struct clk i2c2_ck = {
 	.name = "i2c2_ck",
 	.parent = &per_ck,
-	.flags = NEEDS_INITIALIZATION,
+	.flags = NEEDS_INITIALIZATION | FIXED_RATE,
 	.enable_shift = 2,
 	.enable_reg = USB_OTG_CLKCTRL_REG,
+	.rate = 13000000,
 	.enable = clk_reg_enable,
 	.disable = clk_reg_disable,
 };
diff --git a/arch/arm/mach-pnx4008/i2c.c b/arch/arm/mach-pnx4008/i2c.c
index 14b4906..23ec335 100644
--- a/arch/arm/mach-pnx4008/i2c.c
+++ b/arch/arm/mach-pnx4008/i2c.c
@@ -18,12 +18,6 @@
 #include <mach/irqs.h>
 #include <mach/i2c.h>
 
-static u32 calculate_input_freq(struct platform_device *pdev)
-{
-	return HCLK_MHZ;
-}
-
-
 static struct i2c_pnx_algo_data pnx_algo_data0 = {
 	.base = PNX4008_I2C1_BASE,
 	.irq = I2C_1_INT,
@@ -54,17 +48,14 @@ static struct i2c_adapter pnx_adapter2 = {
 };
 
 static struct i2c_pnx_data i2c0_data = {
-	.calculate_input_freq = calculate_input_freq,
 	.adapter = &pnx_adapter0,
 };
 
 static struct i2c_pnx_data i2c1_data = {
-	.calculate_input_freq = calculate_input_freq,
 	.adapter = &pnx_adapter1,
 };
 
 static struct i2c_pnx_data i2c2_data = {
-	.calculate_input_freq = calculate_input_freq,
 	.adapter = &pnx_adapter2,
 };
 
diff --git a/drivers/i2c/busses/i2c-pnx.c b/drivers/i2c/busses/i2c-pnx.c
index 7ed425a..531074e 100644
--- a/drivers/i2c/busses/i2c-pnx.c
+++ b/drivers/i2c/busses/i2c-pnx.c
@@ -31,7 +31,6 @@
 #define I2C_PNX_TIMEOUT		10 /* msec */
 #define I2C_PNX_SPEED_KHZ	100
 #define I2C_PNX_REGION_SIZE	0x100
-#define PNX_DEFAULT_FREQ	13 /* MHz */
 
 static inline int wait_timeout(long timeout, struct i2c_pnx_algo_data *data)
 {
@@ -578,7 +577,7 @@ static int __devinit i2c_pnx_probe(struct platform_device *pdev)
 	unsigned long tmp;
 	int ret = 0;
 	struct i2c_pnx_algo_data *alg_data;
-	int freq_mhz;
+	unsigned long freq;
 	struct i2c_pnx_data *i2c_pnx = pdev->dev.platform_data;
 
 	if (!i2c_pnx || !i2c_pnx->adapter) {
@@ -599,14 +598,6 @@ static int __devinit i2c_pnx_probe(struct platform_device *pdev)
 		goto out_drvdata;
 	}
 
-	if (i2c_pnx->calculate_input_freq)
-		freq_mhz = i2c_pnx->calculate_input_freq(pdev);
-	else {
-		freq_mhz = PNX_DEFAULT_FREQ;
-		dev_info(&pdev->dev, "Setting bus frequency to default value: "
-		       "%d MHz\n", freq_mhz);
-	}
-
 	init_timer(&alg_data->mif.timer);
 	alg_data->mif.timer.function = i2c_pnx_timeout;
 	alg_data->mif.timer.data = (unsigned long)i2c_pnx->adapter;
@@ -632,6 +623,8 @@ static int __devinit i2c_pnx_probe(struct platform_device *pdev)
 	if (ret)
 		goto out_unmap;
 
+	freq = clk_get_rate(alg_data->clk);
+
 	/*
 	 * Clock Divisor High This value is the number of system clocks
 	 * the serial clock (SCL) will be high.
@@ -643,7 +636,7 @@ static int __devinit i2c_pnx_probe(struct platform_device *pdev)
 	 * the deglitching filter length.
 	 */
 
-	tmp = ((freq_mhz * 1000) / I2C_PNX_SPEED_KHZ) / 2 - 2;
+	tmp = ((freq / 1000) / I2C_PNX_SPEED_KHZ) / 2 - 2;
 	iowrite32(tmp, I2C_REG_CKH(alg_data));
 	iowrite32(tmp, I2C_REG_CKL(alg_data));
 
diff --git a/include/linux/i2c-pnx.h b/include/linux/i2c-pnx.h
index 3a69306..d7942c5 100644
--- a/include/linux/i2c-pnx.h
+++ b/include/linux/i2c-pnx.h
@@ -34,7 +34,6 @@ struct i2c_pnx_algo_data {
 };
 
 struct i2c_pnx_data {
-	u32 (*calculate_input_freq) (struct platform_device *pdev);
 	struct i2c_adapter *adapter;
 };
 
-- 
1.6.0.6
