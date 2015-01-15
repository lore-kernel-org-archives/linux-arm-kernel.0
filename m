From: 21cnbao@gmail.com (Barry Song)
Date: Thu, 15 Jan 2015 08:16:10 +0800
Subject: [PATCH v2] gpio: sx150x: add dts support for sx150x driver
Message-ID: <1421280970-5740-1-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Chen <Wei.Chen@csr.com>

Current sx150x gpio expander driver doesn't support
DTS. Now we added dts support for this driver.

Signed-off-by: Wei Chen <Wei.Chen@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 .../devicetree/bindings/gpio/gpio-sx150x.txt       | 40 ++++++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.txt        |  1 +
 drivers/gpio/gpio-sx150x.c                         | 17 ++++++++-
 3 files changed, 57 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-sx150x.txt

diff --git a/Documentation/devicetree/bindings/gpio/gpio-sx150x.txt b/Documentation/devicetree/bindings/gpio/gpio-sx150x.txt
new file mode 100644
index 0000000..ba2bb84
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/gpio-sx150x.txt
@@ -0,0 +1,40 @@
+SEMTECH SX150x GPIO expander bindings
+
+
+Required properties:
+
+- compatible: should be "semtech,sx1506q",
+			"semtech,sx1508q",
+			"semtech,sx1509q".
+
+- reg: The I2C slave address for this device.
+
+- interrupt-parent: phandle of the parent interrupt controller.
+
+- interrupts: Interrupt specifier for the controllers interrupt.
+
+- #gpio-cells: Should be 2. The first cell is the GPIO number and the
+		second cell is used to specify optional parameters:
+		bit 0: polarity (0: normal, 1: inverted)
+
+- gpio-controller: Marks the device as a GPIO controller.
+
+- interrupt-controller: Marks the device as a interrupt controller.
+
+The GPIO expander can optionally be used as an interrupt controller, in
+which case it uses the default two cell specifier as described in
+Documentation/devicetree/bindings/interrupt-controller/interrupts.txt.
+
+Example:
+
+	i2c_gpio_expander at 20{
+		#gpio-cells = <2>;
+		#interrupt-cells = <2>;
+		compatible = "semtech,sx1506q";
+		reg = <0x20>;
+		interrupt-parent = <&gpio_1>;
+		interrupts = <16 0>;
+
+		gpio-controller;
+		interrupt-controller;
+	};
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index b1df0ad..ce751cb 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -141,6 +141,7 @@ sandisk	Sandisk Corporation
 sbs	Smart Battery System
 schindler	Schindler
 seagate	Seagate Technology PLC
+semtech	Semtech Corporation
 sil	Silicon Image
 silabs	Silicon Laboratories
 simtek
diff --git a/drivers/gpio/gpio-sx150x.c b/drivers/gpio/gpio-sx150x.c
index b32fb38..1343745 100644
--- a/drivers/gpio/gpio-sx150x.c
+++ b/drivers/gpio/gpio-sx150x.c
@@ -23,6 +23,11 @@
 #include <linux/mutex.h>
 #include <linux/slab.h>
 #include <linux/i2c/sx150x.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/of_gpio.h>
+#include <linux/of_device.h>
 
 #define NO_UPDATE_PENDING	-1
 
@@ -147,6 +152,13 @@ static const struct i2c_device_id sx150x_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, sx150x_id);
 
+static const struct of_device_id sx150x_dt_id[] = {
+	{ .compatible = "semtech,sx1508q" },
+	{ .compatible = "semtech,sx1509q" },
+	{ .compatible = "semtech,sx1506q" },
+	{},
+};
+
 static s32 sx150x_i2c_write(struct i2c_client *client, u8 reg, u8 val)
 {
 	s32 err = i2c_smbus_write_byte_data(client, reg, val);
@@ -472,6 +484,8 @@ static void sx150x_init_chip(struct sx150x_chip *chip,
 	chip->gpio_chip.base             = pdata->gpio_base;
 	chip->gpio_chip.can_sleep        = true;
 	chip->gpio_chip.ngpio            = chip->dev_cfg->ngpios;
+	chip->gpio_chip.of_node          = client->dev.of_node;
+	chip->gpio_chip.of_gpio_n_cells  = 2;
 	if (pdata->oscio_is_gpo)
 		++chip->gpio_chip.ngpio;
 
@@ -666,7 +680,8 @@ static int sx150x_remove(struct i2c_client *client)
 static struct i2c_driver sx150x_driver = {
 	.driver = {
 		.name = "sx150x",
-		.owner = THIS_MODULE
+		.owner = THIS_MODULE,
+		.of_match_table = of_match_ptr(sx150x_dt_id),
 	},
 	.probe    = sx150x_probe,
 	.remove   = sx150x_remove,
-- 
1.9.1
