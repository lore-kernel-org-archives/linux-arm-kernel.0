From: bengardiner@nanometrics.ca (Ben Gardiner)
Date: Tue,  5 Apr 2011 17:38:06 -0400
Subject: [PATCH 3/6] i2c-davinci: introduce a dev-> function pointer for scl
	pulsing
In-Reply-To: <cover.1302031487.git.bengardiner@nanometrics.ca>
References: <cover.1302031487.git.bengardiner@nanometrics.ca>
Message-ID: <392ee718990c7f0f315d2273a1c74337149a0e1b.1302031487.git.bengardiner@nanometrics.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current implementation of the I2C recovery routine checks whether
platform data ->scl_pin has been assigned and if so, the generic_i2c_clock_pulse
routine is executed.

In preparation for an alternative recovery routine; introduce a pulse_scl
function pointer to the driver private structure and assign it the value of
generic_i2c_clock_pulse on init if the scl_pin is assigned in platform data.

Signed-off-by: Ben Gardiner<bengardiner@nanometrics.ca>
Cc: Sekhar Nori <nsekhar@ti.com>
Cc: Ben Dooks <ben-linux@fluff.org>

---
 drivers/i2c/busses/i2c-davinci.c |   20 +++++++++++++-------
 1 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index 7011222..0a2c697 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -110,6 +110,7 @@ struct davinci_i2c_dev {
 	int			stop;
 	u8			terminate;
 	struct i2c_adapter	adapter;
+	void			(*pulse_scl) (struct davinci_i2c_dev *dev);
 #ifdef CONFIG_CPU_FREQ
 	struct completion	xfr_complete;
 	struct notifier_block	freq_transition;
@@ -165,16 +166,17 @@ static void i2c_davinci_dump_regs(struct davinci_i2c_dev *dev)
 }
 
 /* Generate a pulse on the i2c clock pin. */
-static void generic_i2c_clock_pulse(unsigned int scl_pin)
+static void generic_i2c_clock_pulse(struct davinci_i2c_dev *dev)
 {
+	struct davinci_i2c_platform_data *pdata = dev->dev->platform_data;
 	u16 i;
 
-	if (scl_pin) {
+	if (pdata->scl_pin) {
 		/* Send high and low on the SCL line */
 		for (i = 0; i < 9; i++) {
-			gpio_set_value(scl_pin, 0);
+			gpio_set_value(pdata->scl_pin, 0);
 			udelay(20);
-			gpio_set_value(scl_pin, 1);
+			gpio_set_value(pdata->scl_pin, 1);
 			udelay(20);
 		}
 	}
@@ -186,7 +188,6 @@ static void generic_i2c_clock_pulse(unsigned int scl_pin)
 static void i2c_recover_bus(struct davinci_i2c_dev *dev)
 {
 	u32 flag = 0;
-	struct davinci_i2c_platform_data *pdata = dev->dev->platform_data;
 
 	i2c_davinci_dump_regs(dev);
 	dev_err(dev->dev, "initiating i2c bus recovery\n");
@@ -195,8 +196,8 @@ static void i2c_recover_bus(struct davinci_i2c_dev *dev)
 	flag |=  DAVINCI_I2C_MDR_NACK;
 	/* write the data into mode register */
 	davinci_i2c_write_reg(dev, DAVINCI_I2C_MDR_REG, flag);
-	if (pdata)
-		generic_i2c_clock_pulse(pdata->scl_pin);
+	if (dev->pulse_scl)
+		dev->pulse_scl(dev);
 	/* Send STOP */
 	flag = davinci_i2c_read_reg(dev, DAVINCI_I2C_MDR_REG);
 	flag |= DAVINCI_I2C_MDR_STP;
@@ -669,6 +670,7 @@ static struct i2c_algorithm i2c_davinci_algo = {
 
 static int davinci_i2c_probe(struct platform_device *pdev)
 {
+	struct davinci_i2c_platform_data *pdata;
 	struct davinci_i2c_dev *dev;
 	struct i2c_adapter *adap;
 	struct resource *mem, *irq, *ioarea;
@@ -751,6 +753,10 @@ static int davinci_i2c_probe(struct platform_device *pdev)
 		goto err_free_irq;
 	}
 
+	pdata = dev->dev->platform_data;
+	if (pdata->scl_pin)
+		dev->pulse_scl = generic_i2c_clock_pulse;
+
 	return 0;
 
 err_free_irq:
-- 
1.7.1
