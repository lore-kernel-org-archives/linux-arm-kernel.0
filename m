From: hs@denx.de (Heiko Schocher)
Date: Mon, 30 Jul 2012 09:21:12 +0200
Subject: [PATCH v7] ARM: davinci: i2c: add OF support
Message-ID: <1343632872-25896-1-git-send-email-hs@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add of support for the davinci i2c driver.

Signed-off-by: Heiko Schocher <hs@denx.de>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Cc: davinci-linux-open-source at linux.davincidsp.com
Cc: linux-arm-kernel at lists.infradead.org
Cc: devicetree-discuss at lists.ozlabs.org
Cc: linux-i2c at vger.kernel.org
Cc: Ben Dooks <ben-linux@fluff.org>
Cc: Wolfram Sang <w.sang@pengutronix.de>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Sekhar Nori <nsekhar@ti.com>
Cc: Wolfgang Denk <wd@denx.de>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>

---
- changes for v2:
- add comments from Sylwester Nawrocki <s.nawrocki@samsung.com>:
  - use "cell-index" instead "id"
  - OF_DEV_AUXDATA in the machine code, instead pre-define platform
    device name
- add comment from Grant Likely:
  - removed "id" resp. "cell-index" completely
  - fixed documentation
  - use of_match_ptr()
  - use devm_kzalloc() for allocating plattform data mem
  - fixed a whitespace issue
- no changes for v3
- changes for v4
  remove "pinmux-handle" property as discussed here:
  http://www.spinics.net/lists/arm-kernel/msg175701.html
  with Nori Sekhar

- changes for v5
  add comments from Grant Likely:
  - do not change value of dev->dev->platform_data, instead
    hold a copy in davinci_i2c_dev.

- changes for v6:
  add comments from Sekhar Nori:
  - removed unneccessary include
  - merge patch from Sekhar Nori:
    setup the newly introduced dev->pdata member correctly once in
    probe -> i2c_get_plattformdata(() not needed, remove a lot of
    checks for pdata in code
  - add Signed-off-by: Sekhar Nori <nsekhar@ti.com>
  - patch no longer in patchserie, as it has no dependencies.

- changes for v7:
  add comments from Wolfram Sang:
  - move Documentation/devicetree/bindings/arm/davinci/i2c.txt
    to Documentation/devicetree/bindings/i2c/davinci.txt
  - remove bus-delay property

 Documentation/devicetree/bindings/i2c/davinci.txt |   28 ++++++++++++
 drivers/i2c/busses/i2c-davinci.c                  |   48 ++++++++++++++++-----
 2 files changed, 65 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i2c/davinci.txt

diff --git a/Documentation/devicetree/bindings/i2c/davinci.txt b/Documentation/devicetree/bindings/i2c/davinci.txt
new file mode 100644
index 0000000..c79078e
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/davinci.txt
@@ -0,0 +1,28 @@
+* Texas Instruments Davinci I2C
+
+This file provides information, what the device node for the
+davinci i2c interface contain.
+
+Required properties:
+- compatible: "ti,davinci-i2c";
+- reg : Offset and length of the register set for the device
+
+Recommended properties :
+- interrupts : <a> standard interrupt property.
+- clock-frequency : desired I2C bus clock frequency in Hz.
+
+Example (enbw_cmc board):
+	i2c at 1c22000 {
+		compatible = "ti,davinci-i2c";
+		reg = <0x22000 0x1000>;
+		clock-frequency = <100000>;
+		interrupts = <15>;
+		interrupt-parent = <&intc>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		dtt at 48 {
+				compatible = "national,lm75";
+				reg = <0x48>;
+			};
+	};
diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index 79b4bcb..b6185dc 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -38,6 +38,8 @@
 #include <linux/slab.h>
 #include <linux/cpufreq.h>
 #include <linux/gpio.h>
+#include <linux/of_i2c.h>
+#include <linux/of_device.h>
 
 #include <mach/hardware.h>
 #include <mach/i2c.h>
@@ -114,6 +116,7 @@ struct davinci_i2c_dev {
 	struct completion	xfr_complete;
 	struct notifier_block	freq_transition;
 #endif
+	struct davinci_i2c_platform_data *pdata;
 };
 
 /* default platform data to use if not supplied in the platform_device */
@@ -155,7 +158,7 @@ static void generic_i2c_clock_pulse(unsigned int scl_pin)
 static void i2c_recover_bus(struct davinci_i2c_dev *dev)
 {
 	u32 flag = 0;
-	struct davinci_i2c_platform_data *pdata = dev->dev->platform_data;
+	struct davinci_i2c_platform_data *pdata = dev->pdata;
 
 	dev_err(dev->dev, "initiating i2c bus recovery\n");
 	/* Send NACK to the slave */
@@ -163,8 +166,7 @@ static void i2c_recover_bus(struct davinci_i2c_dev *dev)
 	flag |=  DAVINCI_I2C_MDR_NACK;
 	/* write the data into mode register */
 	davinci_i2c_write_reg(dev, DAVINCI_I2C_MDR_REG, flag);
-	if (pdata)
-		generic_i2c_clock_pulse(pdata->scl_pin);
+	generic_i2c_clock_pulse(pdata->scl_pin);
 	/* Send STOP */
 	flag = davinci_i2c_read_reg(dev, DAVINCI_I2C_MDR_REG);
 	flag |= DAVINCI_I2C_MDR_STP;
@@ -187,7 +189,7 @@ static inline void davinci_i2c_reset_ctrl(struct davinci_i2c_dev *i2c_dev,
 
 static void i2c_davinci_calc_clk_dividers(struct davinci_i2c_dev *dev)
 {
-	struct davinci_i2c_platform_data *pdata = dev->dev->platform_data;
+	struct davinci_i2c_platform_data *pdata = dev->pdata;
 	u16 psc;
 	u32 clk;
 	u32 d;
@@ -235,10 +237,7 @@ static void i2c_davinci_calc_clk_dividers(struct davinci_i2c_dev *dev)
  */
 static int i2c_davinci_init(struct davinci_i2c_dev *dev)
 {
-	struct davinci_i2c_platform_data *pdata = dev->dev->platform_data;
-
-	if (!pdata)
-		pdata = &davinci_i2c_platform_data_default;
+	struct davinci_i2c_platform_data *pdata = dev->pdata;
 
 	/* put I2C into reset */
 	davinci_i2c_reset_ctrl(dev, 0);
@@ -260,6 +259,7 @@ static int i2c_davinci_init(struct davinci_i2c_dev *dev)
 	dev_dbg(dev->dev, "bus_freq = %dkHz, bus_delay = %d\n",
 		pdata->bus_freq, pdata->bus_delay);
 
+
 	/* Take the I2C module out of reset: */
 	davinci_i2c_reset_ctrl(dev, 1);
 
@@ -308,13 +308,11 @@ static int
 i2c_davinci_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg, int stop)
 {
 	struct davinci_i2c_dev *dev = i2c_get_adapdata(adap);
-	struct davinci_i2c_platform_data *pdata = dev->dev->platform_data;
+	struct davinci_i2c_platform_data *pdata = dev->pdata;
 	u32 flag;
 	u16 w;
 	int r;
 
-	if (!pdata)
-		pdata = &davinci_i2c_platform_data_default;
 	/* Introduce a delay, required for some boards (e.g Davinci EVM) */
 	if (pdata->bus_delay)
 		udelay(pdata->bus_delay);
@@ -635,6 +633,12 @@ static struct i2c_algorithm i2c_davinci_algo = {
 	.functionality	= i2c_davinci_func,
 };
 
+static const struct of_device_id davinci_i2c_of_match[] = {
+	{.compatible = "ti,davinci-i2c", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, davinci_i2c_of_match);
+
 static int davinci_i2c_probe(struct platform_device *pdev)
 {
 	struct davinci_i2c_dev *dev;
@@ -674,8 +678,27 @@ static int davinci_i2c_probe(struct platform_device *pdev)
 #endif
 	dev->dev = get_device(&pdev->dev);
 	dev->irq = irq->start;
+	dev->pdata = dev->dev->platform_data;
 	platform_set_drvdata(pdev, dev);
 
+	if (!dev->pdata && pdev->dev.of_node) {
+		u32 prop;
+
+		dev->pdata = devm_kzalloc(&pdev->dev,
+			sizeof(struct davinci_i2c_platform_data), GFP_KERNEL);
+		if (!dev->pdata) {
+			r = -ENOMEM;
+			goto err_free_mem;
+		}
+		memcpy(dev->pdata, &davinci_i2c_platform_data_default,
+			sizeof(struct davinci_i2c_platform_data));
+		if (!of_property_read_u32(pdev->dev.of_node, "clock-frequency",
+			&prop))
+			dev->pdata->bus_freq = prop / 1000;
+	} else if (!dev->pdata) {
+		dev->pdata = &davinci_i2c_platform_data_default;
+	}
+
 	dev->clk = clk_get(&pdev->dev, NULL);
 	if (IS_ERR(dev->clk)) {
 		r = -ENODEV;
@@ -711,6 +734,7 @@ static int davinci_i2c_probe(struct platform_device *pdev)
 	adap->algo = &i2c_davinci_algo;
 	adap->dev.parent = &pdev->dev;
 	adap->timeout = DAVINCI_I2C_TIMEOUT;
+	adap->dev.of_node = pdev->dev.of_node;
 
 	adap->nr = pdev->id;
 	r = i2c_add_numbered_adapter(adap);
@@ -718,6 +742,7 @@ static int davinci_i2c_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "failure adding adapter\n");
 		goto err_free_irq;
 	}
+	of_i2c_register_devices(adap);
 
 	return 0;
 
@@ -809,6 +834,7 @@ static struct platform_driver davinci_i2c_driver = {
 		.name	= "i2c_davinci",
 		.owner	= THIS_MODULE,
 		.pm	= davinci_i2c_pm_ops,
+		.of_match_table = of_match_ptr(davinci_i2c_of_match),
 	},
 };
 
-- 
1.7.7.6
