From: 21cnbao@gmail.com (Barry Song)
Date: Thu,  4 Dec 2014 20:12:10 +0800
Subject: [PATCH 3/3] gpio: sx150x: add dts support for sx150x driver
In-Reply-To: <1417695130-5712-1-git-send-email-21cnbao@gmail.com>
References: <1417695130-5712-1-git-send-email-21cnbao@gmail.com>
Message-ID: <1417695130-5712-3-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Chen <Wei.Chen@csr.com>

Current sx150x gpio expander driver doesn't support DT. Now we added DT support
for this driver.

Signed-off-by: Wei Chen <Wei.Chen@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 .../devicetree/bindings/gpio/gpio-sx150x.txt       | 69 ++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.txt        |  1 +
 drivers/gpio/gpio-sx150x.c                         | 83 +++++++++++++++++++++-
 3 files changed, 151 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-sx150x.txt

diff --git a/Documentation/devicetree/bindings/gpio/gpio-sx150x.txt b/Documentation/devicetree/bindings/gpio/gpio-sx150x.txt
new file mode 100644
index 0000000..7f8a61b
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/gpio-sx150x.txt
@@ -0,0 +1,69 @@
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
+Optional properties:
+- oscio_is_gpo: Boolean.
+	Whether the HW considers OSCIO as a GPO instead of as an
+	oscillator.
+
+- reset_during_probe: Boolean.
+	Whether the HW supports full reset of the chip at the beginning
+	of the probe.
+
+-pullup_ena:A bit-mask which enables or disables the pull-up resistor
+	for each IO line in the expander. = <0x0>;
+
+-pulldn_ena:A bit-mask which enables-or disables the pull-down resistor
+	for each IO line in the expander.
+
+-open_drain_ena:A bit-mask which enables-or disables open-drain
+	operation for each IO line in the expander.
+
+-polarity: A bit-mask which enables polarity inversion for each IO line
+	in the expander.
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
+
+		oscio_is_gpo;
+		reset_during_probe;
+
+		pullup_ena = <0x01>;
+		pulldn_ena = <0x10>;
+		open_drain_ena = <0x40>;
+		polarity = <0x02>;
+	};
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index c177cd7..6968148 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -140,6 +140,7 @@ sandisk	Sandisk Corporation
 sbs	Smart Battery System
 schindler	Schindler
 seagate	Seagate Technology PLC
+semtech	Semtech Corporation
 sil	Silicon Image
 silabs	Silicon Laboratories
 simtek
diff --git a/drivers/gpio/gpio-sx150x.c b/drivers/gpio/gpio-sx150x.c
index b32fb38..28d2f03 100644
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
+	{ .compatible = "semtech,sx1508q", .data = &sx150x_devices[0]},
+	{ .compatible = "semtech,sx1509q", .data = &sx150x_devices[1]},
+	{ .compatible = "semtech,sx1506q", .data = &sx150x_devices[2]},
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
 
@@ -607,6 +621,66 @@ static int sx150x_install_irq_chip(struct sx150x_chip *chip,
 	return err;
 }
 
+static struct sx150x_platform_data *of_sx150x_get_platdata(
+					struct i2c_client *client)
+{
+	int rc, gpio;
+	struct sx150x_platform_data *pdata;
+	struct device_node *np;
+
+	if (!client->dev.of_node)
+		return NULL;
+
+	np = client->dev.of_node;
+
+	pdata = devm_kzalloc(&client->dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return ERR_PTR(-ENOMEM);
+
+	gpio = of_get_named_gpio(np, "int-gpios", 0);
+	if (gpio_is_valid(gpio)) {
+		rc = devm_gpio_request_one(&client->dev, gpio,
+			GPIOF_DIR_IN, "sx150x_interrupt");
+		if (rc)
+			return ERR_PTR(rc);
+	}
+
+	pdata->irq_summary = irq_of_parse_and_map(np, 0);
+	if (!pdata->irq_summary)
+		return ERR_PTR(-EPROBE_DEFER);
+
+	pdata->oscio_is_gpo = of_property_read_bool(np, "oscio_is_gpo");
+	pdata->reset_during_probe =
+			of_property_read_bool(np, "reset_during_probe");
+
+	rc = of_property_read_u16(np, "pullup_ena",
+				&pdata->io_pullup_ena);
+	if (rc)
+		pdata->io_pullup_ena = 0;
+
+	rc = of_property_read_u16(np, "pulldn_ena",
+				&pdata->io_pulldn_ena);
+	if (rc)
+		pdata->io_pulldn_ena = 0;
+
+	rc = of_property_read_u16(np, "open_drain_ena",
+				&pdata->io_open_drain_ena);
+	if (rc)
+		pdata->io_open_drain_ena = 0;
+
+	rc = of_property_read_u16(np, "polarity",
+				&pdata->io_polarity);
+	if (rc)
+		pdata->io_polarity = 0;
+
+	/* Let OF gpiochip_add to detect dynamical gpio_base & irq_base */
+	pdata->gpio_base = -1;
+	/* We should use the dynamical irq_base */
+	pdata->irq_base = 0;
+
+	return pdata;
+}
+
 static int sx150x_probe(struct i2c_client *client,
 				const struct i2c_device_id *id)
 {
@@ -617,8 +691,13 @@ static int sx150x_probe(struct i2c_client *client,
 	int rc;
 
 	pdata = dev_get_platdata(&client->dev);
-	if (!pdata)
-		return -EINVAL;
+	if (!pdata) {
+		pdata = of_sx150x_get_platdata(client);
+		if (!pdata)
+			return -EINVAL;
+		else if (IS_ERR(pdata))
+			return PTR_ERR(pdata);
+	}
 
 	if (!i2c_check_functionality(client->adapter, i2c_funcs))
 		return -ENOSYS;
-- 
2.2.0
