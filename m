From: hs@denx.de (Heiko Schocher)
Date: Wed, 30 May 2012 12:19:01 +0200
Subject: [PATCH v5 5/7] ARM: davinci: i2c: add OF support
In-Reply-To: <1338373143-7467-1-git-send-email-hs@denx.de>
References: <1338373143-7467-1-git-send-email-hs@denx.de>
Message-ID: <1338373143-7467-6-git-send-email-hs@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add of support for the davinci i2c driver.

Signed-off-by: Heiko Schocher <hs@denx.de>
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

 .../devicetree/bindings/arm/davinci/i2c.txt        |   31 ++++++++++++
 drivers/i2c/busses/i2c-davinci.c                   |   49 ++++++++++++++++++--
 2 files changed, 76 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/davinci/i2c.txt

diff --git a/Documentation/devicetree/bindings/arm/davinci/i2c.txt b/Documentation/devicetree/bindings/arm/davinci/i2c.txt
new file mode 100644
index 0000000..e98a025
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/davinci/i2c.txt
@@ -0,0 +1,31 @@
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
+Optional properties:
+- bus-delay: bus delay in usec
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
index a76d85f..4e7a966 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -38,9 +38,12 @@
 #include <linux/slab.h>
 #include <linux/cpufreq.h>
 #include <linux/gpio.h>
+#include <linux/of_i2c.h>
+#include <linux/of_device.h>
 
 #include <mach/hardware.h>
 #include <mach/i2c.h>
+#include <mach/mux.h>
 
 /* ----- global defines ----------------------------------------------- */
 
@@ -114,6 +117,7 @@ struct davinci_i2c_dev {
 	struct completion	xfr_complete;
 	struct notifier_block	freq_transition;
 #endif
+	struct davinci_i2c_platform_data *pdata;
 };
 
 /* default platform data to use if not supplied in the platform_device */
@@ -149,13 +153,22 @@ static void generic_i2c_clock_pulse(unsigned int scl_pin)
 	}
 }
 
+static struct davinci_i2c_platform_data
+		*i2c_get_plattformdata(struct davinci_i2c_dev *dev)
+{
+	if (dev->dev->platform_data == NULL)
+		return dev->pdata;
+
+	return dev->dev->platform_data;
+}
+
 /* This routine does i2c bus recovery as specified in the
  * i2c protocol Rev. 03 section 3.16 titled "Bus clear"
  */
 static void i2c_recover_bus(struct davinci_i2c_dev *dev)
 {
 	u32 flag = 0;
-	struct davinci_i2c_platform_data *pdata = dev->dev->platform_data;
+	struct davinci_i2c_platform_data *pdata = i2c_get_plattformdata(dev);
 
 	dev_err(dev->dev, "initiating i2c bus recovery\n");
 	/* Send NACK to the slave */
@@ -187,7 +200,7 @@ static inline void davinci_i2c_reset_ctrl(struct davinci_i2c_dev *i2c_dev,
 
 static void i2c_davinci_calc_clk_dividers(struct davinci_i2c_dev *dev)
 {
-	struct davinci_i2c_platform_data *pdata = dev->dev->platform_data;
+	struct davinci_i2c_platform_data *pdata = i2c_get_plattformdata(dev);
 	u16 psc;
 	u32 clk;
 	u32 d;
@@ -235,7 +248,7 @@ static void i2c_davinci_calc_clk_dividers(struct davinci_i2c_dev *dev)
  */
 static int i2c_davinci_init(struct davinci_i2c_dev *dev)
 {
-	struct davinci_i2c_platform_data *pdata = dev->dev->platform_data;
+	struct davinci_i2c_platform_data *pdata = i2c_get_plattformdata(dev);
 
 	if (!pdata)
 		pdata = &davinci_i2c_platform_data_default;
@@ -308,7 +321,7 @@ static int
 i2c_davinci_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg, int stop)
 {
 	struct davinci_i2c_dev *dev = i2c_get_adapdata(adap);
-	struct davinci_i2c_platform_data *pdata = dev->dev->platform_data;
+	struct davinci_i2c_platform_data *pdata = i2c_get_plattformdata(dev);
 	u32 flag;
 	u16 w;
 	int r;
@@ -635,6 +648,12 @@ static struct i2c_algorithm i2c_davinci_algo = {
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
@@ -676,6 +695,25 @@ static int davinci_i2c_probe(struct platform_device *pdev)
 	dev->irq = irq->start;
 	platform_set_drvdata(pdev, dev);
 
+	if ((dev->dev->platform_data == NULL) &&
+		(pdev->dev.of_node)) {
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
+		if (!of_property_read_u32(pdev->dev.of_node, "bus-delay",
+			&prop))
+			dev->pdata->bus_delay = prop;
+	}
 	dev->clk = clk_get(&pdev->dev, NULL);
 	if (IS_ERR(dev->clk)) {
 		r = -ENODEV;
@@ -711,6 +749,7 @@ static int davinci_i2c_probe(struct platform_device *pdev)
 	adap->algo = &i2c_davinci_algo;
 	adap->dev.parent = &pdev->dev;
 	adap->timeout = DAVINCI_I2C_TIMEOUT;
+	adap->dev.of_node = pdev->dev.of_node;
 
 	adap->nr = pdev->id;
 	r = i2c_add_numbered_adapter(adap);
@@ -718,6 +757,7 @@ static int davinci_i2c_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "failure adding adapter\n");
 		goto err_free_irq;
 	}
+	of_i2c_register_devices(adap);
 
 	return 0;
 
@@ -809,6 +849,7 @@ static struct platform_driver davinci_i2c_driver = {
 		.name	= "i2c_davinci",
 		.owner	= THIS_MODULE,
 		.pm	= davinci_i2c_pm_ops,
+		.of_match_table = of_match_ptr(davinci_i2c_of_match),
 	},
 };
 
-- 
1.7.7.6
