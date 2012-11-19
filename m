From: mfuzzey@parkeon.com (Martin Fuzzey)
Date: Mon, 19 Nov 2012 09:54:44 +0100
Subject: [PATCH] Video: Backlight: Add a MMIO backlight driver using DT.
Message-ID: <20121119085443.350.96371.stgit@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some boards have very simple backlight controllers
consisting of a latch on the bus with a bunch of
resistors used as a "poor man's DAC".

Prior to the device tree such boards were supported
using generic-bl with a callback in the board file
to poke the hardware.

This driver allows such hardware to be supported
on device tree based platforms where callbacks
and board files cannot be used.

Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>
---
 .../bindings/video/backlight/mmio_bl.txt           |   50 ++++
 drivers/video/backlight/Kconfig                    |   12 +
 drivers/video/backlight/Makefile                   |    1 
 drivers/video/backlight/mmio_bl.c                  |  225 ++++++++++++++++++++
 4 files changed, 288 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/video/backlight/mmio_bl.txt
 create mode 100644 drivers/video/backlight/mmio_bl.c

diff --git a/Documentation/devicetree/bindings/video/backlight/mmio_bl.txt b/Documentation/devicetree/bindings/video/backlight/mmio_bl.txt
new file mode 100644
index 0000000..39a53d0
--- /dev/null
+++ b/Documentation/devicetree/bindings/video/backlight/mmio_bl.txt
@@ -0,0 +1,50 @@
+Memory mapped IO backlight bindings
+===================================
+
+Required properties:
+ - compatible : mmio-bl
+ - reg : register address and size
+
+Optional properties:
+ - reg-width : Register size in bits (default = 8 * size of reg)
+ - reg-shift : Register shift in bits (default = 0)
+ - max-brightness : Maximum brightness (defaults to all bits 1)
+ - default-brightness : Default brightness (defaults to all bits 1)
+
+The size of reg must be 1,2 or 4 bytes and is used to determine the type
+of bus access.
+
+The brightness values are silently clamped to the maximum supported by
+reg-width.
+
+Examples:
+	backlight at 1,0 {
+		compatible = "mmio-bl";
+		reg = <1 0 2>;
+	};
+	Defines a 16 bit register with max and default brightness 0xFFFF
+
+
+	backlight at 1,0 {
+		compatible = "mmio-bl";
+		reg = <1 0 1>;
+		reg-width = <6>;
+		reg-shift = <1>;
+		max-brightness = <50>;
+		default-brightness = <40>;
+	};
+	Defines a 6 bit register on D1->D7 so that
+		brightness 0 => X000000X
+		brigtness 50 => X110010X
+
+
+	backlight at 1,0 {
+		compatible = "mmio-bl";
+		reg = <1 0 1>;
+		reg-width = <6>;
+		max-brightness = <100>;
+		default-brightness = <100>;
+	};
+	Defines a 6 bit register on D0->D5 with maximum and default
+	brighntesses of 63 (since not enough bits for 100)
+
diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
index 765a945..6482092 100644
--- a/drivers/video/backlight/Kconfig
+++ b/drivers/video/backlight/Kconfig
@@ -185,6 +185,18 @@ config BACKLIGHT_GENERIC
 	  known as the Corgi backlight driver. If you have a Sharp Zaurus
 	  SL-C7xx, SL-Cxx00 or SL-6000x say y.
 
+config BACKLIGHT_MMIO
+	tristate "Memory Mapped IO Backlight Driver"
+	depends on OF
+	default n
+	help
+	  Say Y to enable backlight driver for simple memory mapped latches.
+
+	  Typically this type of backlight interface consists of a latch on
+	  the bus with a bunch of resistors behind it (a poor man's DAC).
+	  A device tree configuration is required, non DT systems can
+	  use BACKLIGHT_GENERIC instead with a board specific callback.
+
 config BACKLIGHT_LM3533
 	tristate "Backlight Driver for LM3533"
 	depends on BACKLIGHT_CLASS_DEVICE
diff --git a/drivers/video/backlight/Makefile b/drivers/video/backlight/Makefile
index e7ce729..9de5aa2 100644
--- a/drivers/video/backlight/Makefile
+++ b/drivers/video/backlight/Makefile
@@ -19,6 +19,7 @@ obj-$(CONFIG_BACKLIGHT_CLASS_DEVICE) += backlight.o
 obj-$(CONFIG_BACKLIGHT_ATMEL_PWM)    += atmel-pwm-bl.o
 obj-$(CONFIG_BACKLIGHT_EP93XX)	+= ep93xx_bl.o
 obj-$(CONFIG_BACKLIGHT_GENERIC)	+= generic_bl.o
+obj-$(CONFIG_BACKLIGHT_MMIO)	+= mmio_bl.o
 obj-$(CONFIG_BACKLIGHT_HP700)	+= jornada720_bl.o
 obj-$(CONFIG_BACKLIGHT_HP680)	+= hp680_bl.o
 obj-$(CONFIG_BACKLIGHT_LM3533)	+= lm3533_bl.o
diff --git a/drivers/video/backlight/mmio_bl.c b/drivers/video/backlight/mmio_bl.c
new file mode 100644
index 0000000..e5442d9
--- /dev/null
+++ b/drivers/video/backlight/mmio_bl.c
@@ -0,0 +1,225 @@
+/*
+ *  Memory mapped IO backlight driver.
+ *
+ *  Copyright (c) 2012 Martin Fuzzey (Parkeon)
+ *
+ *  Supports backlights controlled by simple bus addressed
+ *  latches with a poor man's DAC (a bunch of resistors)
+ *
+ *  This used to be done with generic_bl but it requires
+ *  callbacks in platform_data which are not supported by device tree.
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/mutex.h>
+#include <linux/fb.h>
+#include <linux/backlight.h>
+
+
+struct mmio_bl_data {
+	void __iomem *reg;
+	int brightness;
+	void (*set_brightness)(struct mmio_bl_data *data);
+	u32 mask;
+	u8 shift;
+};
+
+static void mmio_set_brightness_8bit(struct mmio_bl_data *data)
+{
+	u8 value = readb(data->reg);
+
+	value &= ~data->mask;
+	value |= (data->brightness << data->shift) & data->mask;
+	writeb(value, data->reg);
+}
+
+static void mmio_set_brightness_16bit(struct mmio_bl_data *data)
+{
+	u16 value = readw(data->reg);
+
+	value &= ~data->mask;
+	value |= (data->brightness << data->shift) & data->mask;
+	writew(value, data->reg);
+}
+
+static void mmio_set_brightness_32bit(struct mmio_bl_data *data)
+{
+	u32 value = readl(data->reg);
+
+	value &= ~data->mask;
+	value |= (data->brightness << data->shift) & data->mask;
+	writel(value, data->reg);
+}
+
+static int mmio_bl_update_status(struct backlight_device *bd)
+{
+	int brightness = bd->props.brightness;
+	struct mmio_bl_data *data = bl_get_data(bd);
+
+	if (bd->props.power != FB_BLANK_UNBLANK)
+		brightness = 0;
+	if (bd->props.state & BL_CORE_FBBLANK)
+		brightness = 0;
+	if (bd->props.state & BL_CORE_SUSPENDED)
+		brightness = 0;
+
+	pr_info("set brightness %d\n", brightness);
+	data->brightness = brightness;
+	data->set_brightness(data);
+	return 0;
+}
+
+static int mmio_bl_get_brightness(struct backlight_device *bd)
+{
+	struct mmio_bl_data *data = bl_get_data(bd);
+
+	return data->brightness;
+}
+
+static const struct backlight_ops mmio_bl_ops = {
+	.options = BL_CORE_SUSPENDRESUME,
+	.get_brightness = mmio_bl_get_brightness,
+	.update_status  = mmio_bl_update_status,
+};
+
+static void mmio_bl_configure_from_dt(
+	struct device *dev,
+	resource_size_t res_size,
+	struct mmio_bl_data *data,
+	struct backlight_properties *props)
+{
+	struct device_node *of_node = dev->of_node;
+	u32 bits = res_size * 8;
+	u32 shift = 0;
+	u32 max_brightness, brightness;
+
+	of_property_read_u32(of_node, "reg-width", &bits);
+	of_property_read_u32(of_node, "reg-shift", &shift);
+	data->mask = ((1 << bits) - 1)  << shift;
+	data->shift = shift;
+
+	max_brightness =  1 << bits;
+	brightness = max_brightness;
+	of_property_read_u32(of_node, "max-brightness", &max_brightness);
+	of_property_read_u32(of_node, "default-brightness", &brightness);
+	max_brightness = min(max_brightness, 1U << bits);
+	brightness = min(brightness, max_brightness);
+
+	dev_dbg(dev, "brightness: max=%d default=%d mask:%X\n",
+		max_brightness, brightness, data->mask);
+
+	props->max_brightness = max_brightness;
+	props->brightness = brightness;
+}
+
+static int mmio_bl_probe(struct platform_device *pdev)
+{
+	struct backlight_properties props = {0,};
+	struct backlight_device *bd;
+	struct mmio_bl_data *data;
+	struct resource *res;
+	resource_size_t res_size;
+	int ret;
+
+	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		ret = -EINVAL;
+		goto out_err;
+	}
+
+	res_size = resource_size(res);
+	switch (res_size) {
+	case 1:
+		data->set_brightness = mmio_set_brightness_8bit;
+		break;
+	case 2:
+		data->set_brightness = mmio_set_brightness_16bit;
+		break;
+	case 4:
+		data->set_brightness = mmio_set_brightness_32bit;
+		break;
+	default:
+		dev_err(&pdev->dev,
+			"Invalid resource size %d (must be 1/2/4)\n", res_size);
+		ret = -EINVAL;
+		goto out_err;
+	}
+
+	props.type = BACKLIGHT_RAW;
+	mmio_bl_configure_from_dt(&pdev->dev, res_size, data, &props);
+
+	data->reg = devm_request_and_ioremap(&pdev->dev, res);
+	if (!data->reg) {
+		ret = -EADDRNOTAVAIL;
+		goto out_err;
+	}
+
+
+	bd = backlight_device_register(dev_name(&pdev->dev), &pdev->dev,
+					data, &mmio_bl_ops, &props);
+	if (IS_ERR(bd)) {
+		ret = PTR_ERR(bd);
+		goto out_err;
+	}
+
+	platform_set_drvdata(pdev, bd);
+
+	bd->props.power = FB_BLANK_UNBLANK;
+	backlight_update_status(bd);
+
+	pr_info("MMIO Backlight Driver Initialized.\n");
+	return 0;
+
+out_err:
+	kfree(data);
+	return ret;
+}
+
+static int mmio_bl_remove(struct platform_device *pdev)
+{
+	struct backlight_device *bd = platform_get_drvdata(pdev);
+
+	bd->props.power = 0;
+	bd->props.brightness = 0;
+	backlight_update_status(bd);
+
+	backlight_device_unregister(bd);
+
+	pr_info("MMIO Backlight Driver Unloaded\n");
+	return 0;
+}
+
+static const struct of_device_id mmio_bl_of_match[] = {
+	{ .compatible = "mmio-bl" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, platform_lcd_of_match);
+
+static struct platform_driver mmio_bl_driver = {
+	.probe		= mmio_bl_probe,
+	.remove		= mmio_bl_remove,
+	.driver		= {
+		.name	= "mmio-bl",
+		.of_match_table = of_match_ptr(mmio_bl_of_match),
+	},
+};
+
+module_platform_driver(mmio_bl_driver);
+
+MODULE_AUTHOR("Martin Fuzzey <mfuzzey@parkeon.com>");
+MODULE_DESCRIPTION("Memory Mapped IO Backlight Driver");
+MODULE_LICENSE("GPL");
