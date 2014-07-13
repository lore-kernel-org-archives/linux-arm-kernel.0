From: mollie.wu@linaro.org (Mollie Wu)
Date: Sun, 13 Jul 2014 14:31:07 +0800
Subject: [PATCH 5/8] pinctrl: add driver for MB86S7x
In-Reply-To: <message-id-of-cover-letter>
References: <message-id-of-cover-letter>
Message-ID: <1405233067-4725-1-git-send-email-mollie.wu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mb86s70 and mb86s73 Fujitsu SoCs differ in that the latter provide a pinmux.
GPIOs are supported on top of Pinctrl api.

Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Tetsuya Takinishi <t.takinishi@jp.fujitsu.com>
Signed-off-by: Mollie Wu <mollie.wu@linaro.org>
---
 .../bindings/gpio/fujitsu,mb86s7x-gpio.txt         |   22 +
 .../bindings/pinctrl/fujitsu,mb86s7x-pinctrl.txt   |   30 +
 drivers/pinctrl/Kconfig                            |    5 +
 drivers/pinctrl/Makefile                           |    1 +
 drivers/pinctrl/pinctrl-mb86s7x.c                  | 1281 ++++++++++++++++++++
 5 files changed, 1339 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/fujitsu,mb86s7x-gpio.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/fujitsu,mb86s7x-pinctrl.txt
 create mode 100644 drivers/pinctrl/pinctrl-mb86s7x.c

diff --git a/Documentation/devicetree/bindings/gpio/fujitsu,mb86s7x-gpio.txt b/Documentation/devicetree/bindings/gpio/fujitsu,mb86s7x-gpio.txt
new file mode 100644
index 0000000..c262efa
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/fujitsu,mb86s7x-gpio.txt
@@ -0,0 +1,22 @@
+Fujitsu MB86S7x GPIO Controller
+-------------------------------
+
+Required properties:
+- compatible: Should be "fujitsu,mb86s7x-gpio"
+- gpio-controller: Marks the device node as a gpio controller.
+- #gpio-cells: Should be <2>. The first cell is the pin number and the
+  second cell is used to specify optional parameters:
+   - bit 0 specifies polarity (0 for normal, 1 for inverted).
+
+GPIO ranges are specified as described in
+Documentation/devicetree/bindings/gpio/gpio.txt
+
+Examples:
+	gpio0: mb86s70_gpio0 {
+		compatible = "fujitsu,mb86s7x-gpio";
+		reg = <0 0x31000000 0x10000>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-ranges = <&pinctrl 0 0 32>;
+		clocks = <&clk_alw_2_1>;
+	};
diff --git a/Documentation/devicetree/bindings/pinctrl/fujitsu,mb86s7x-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/fujitsu,mb86s7x-pinctrl.txt
new file mode 100644
index 0000000..ce2011b
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/fujitsu,mb86s7x-pinctrl.txt
@@ -0,0 +1,30 @@
+Fujitsu MB86S7x Pin Controller
+------------------------------
+
+Required properties:
+- compatible: Should be "fujitsu,mb86s70-pinctrl" or "fujitsu,mb86s73-pinctrl"
+- reg: Should contain the register physical address and length for the
+  pin controller.
+- #gpio-range-cells: Should be 3
+
+Optional subnode-properties:
+- mb86s7x,function: String specifying the function name.
+- mb86s7x,drvst: Drive strength needed for pins to operate in that mode.
+    0 (Hi-z), 2mA, 4mA, 6mA or 8mA
+- mb86s7x,pullup: Should be 0 for Pull-Down or non-zero for Pull-Up
+
+Examples:
+	pinctrl: pinctrl at 2a4d0000 {
+		compatible = "fujitsu,mb86s73-pinctrl";
+		reg = <0 0x2a4d0000 0x1000>, <0 0x312e0000 0x1000>;
+		#gpio-range-cells = <3>;
+
+		hsspi0_pins_active: hsspi0_active {
+			mb86s7x,function = "hsspi0";
+			mb86s7x,drvst = <8>; /* in mA */
+		};
+		hsspi0_pins_sleep: hsspi0_sleep {
+			mb86s7x,function = "hsspi0";
+			mb86s7x,drvst = <0>; /* Implies Hi-z */
+		};
+	};
diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index 0042ccb..1f053fc 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -213,6 +213,11 @@ config PINCTRL_FALCON
 	depends on SOC_FALCON
 	depends on PINCTRL_LANTIQ
 
+config PINCTRL_MB86S7X
+	bool
+	select PINMUX
+	select GENERIC_PINCONF
+
 config PINCTRL_MXS
 	bool
 	select PINMUX
diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
index c4b5d40..edcb823 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -34,6 +34,7 @@ obj-$(CONFIG_PINCTRL_IMX6Q)	+= pinctrl-imx6dl.o
 obj-$(CONFIG_PINCTRL_IMX6SL)	+= pinctrl-imx6sl.o
 obj-$(CONFIG_PINCTRL_IMX6SX)	+= pinctrl-imx6sx.o
 obj-$(CONFIG_PINCTRL_FALCON)	+= pinctrl-falcon.o
+obj-$(CONFIG_PINCTRL_MB86S7X)	+= pinctrl-mb86s7x.o
 obj-$(CONFIG_PINCTRL_MXS)	+= pinctrl-mxs.o
 obj-$(CONFIG_PINCTRL_IMX23)	+= pinctrl-imx23.o
 obj-$(CONFIG_PINCTRL_IMX25)	+= pinctrl-imx25.o
diff --git a/drivers/pinctrl/pinctrl-mb86s7x.c b/drivers/pinctrl/pinctrl-mb86s7x.c
new file mode 100644
index 0000000..74c72ec8
--- /dev/null
+++ b/drivers/pinctrl/pinctrl-mb86s7x.c
@@ -0,0 +1,1281 @@
+/*
+ *  linux/drivers/pinctrl/pinctrl-mb86s7x.c
+ *
+ *  Copyright (C) 2014 Fujitsu Semiconductor Limited
+ *
+ *  This program is free software: you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation, version 2 of the License.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ */
+
+#include <linux/io.h>
+#include <linux/init.h>
+#include <linux/clk.h>
+#include <linux/gpio.h>
+#include <linux/module.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/ioport.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/pinctrl/consumer.h>
+#include <linux/pinctrl/machine.h>
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/pinctrl/pinconf.h>
+#include <linux/pinctrl/pinconf-generic.h>
+#include <linux/pinctrl/pinmux.h>
+#include <linux/spinlock.h>
+#include <linux/slab.h>
+
+#define PDR(x)	(0x0 + x)
+#define DDR(x)	(0x10 + x)
+#define PFR(x)	(0x20 + x)
+
+#define CDRV_PDG(x)	(0x0 + ((x) / 16) * 4)
+#define FORCEZ_PDG(x)	(0x100 + ((x) / 16) * 4)
+#define PULL_PDG(x)	(0x200 + ((x) / 16) * 4)
+#define PIN_OFF(x)	(((x) % 16) * 2)
+
+#define PMUX_MB86S70	0
+#define PMUX_MB86S73	1
+
+/* Virtual pin numbers start so that reg offset calculations get simple */
+enum {
+	PINS_VIRT = 128,
+	PINS_PCIE0 = PINS_VIRT,
+	PINS_HOLE1,
+	PINS_USB3H0,
+	PINS_HOLE2,
+	PINS_USB2H0,
+	PINS_USB2D0,
+	PINS_SDH30,
+	PINS_HOLE3,
+	PINS_EMMC0,
+	PINS_HSSPI0,
+	PINS_GMACD0,
+	PINS_GMACM0,
+	PINS_I2S0,
+	PINS_UART0,
+	PINS_OTHER0,
+	PINS_JTAG0,
+	PINS_PCIE1,
+	PINS_HOLE4,
+	PINS_USB3H1,
+	MB86S70_PMUX_PINS,
+};
+
+struct mb86s70_gpio_chip {
+	spinlock_t lock; /* for goio regs */
+	struct clk *clk;
+	void __iomem *base;
+	struct gpio_chip gc;
+};
+
+static int mb86s70_gpio_request(struct gpio_chip *gc, unsigned offset)
+{
+	int ret = pinctrl_request_gpio(gc->base + offset);
+
+	if (!ret) {
+		struct mb86s70_gpio_chip *gchip = container_of(gc,
+						struct mb86s70_gpio_chip, gc);
+		unsigned long flags;
+		u32 val;
+
+		spin_lock_irqsave(&gchip->lock, flags);
+		val = readl(gchip->base + PFR(offset / 8 * 4));
+		val &= ~(1 << (offset % 8)); /* as gpio-port */
+		writel(val, gchip->base + PFR(offset / 8 * 4));
+		spin_unlock_irqrestore(&gchip->lock, flags);
+	}
+
+	return ret;
+}
+
+static void mb86s70_gpio_free(struct gpio_chip *gc, unsigned offset)
+{
+	struct mb86s70_gpio_chip *gchip = container_of(gc,
+					struct mb86s70_gpio_chip, gc);
+	unsigned long flags;
+	u32 val;
+
+	spin_lock_irqsave(&gchip->lock, flags);
+	val = readl(gchip->base + PFR(offset / 8 * 4));
+	val |= (1 << (offset % 8)); /* as peri-port */
+	writel(val, gchip->base + PFR(offset / 8 * 4));
+	spin_unlock_irqrestore(&gchip->lock, flags);
+
+	pinctrl_free_gpio(gc->base + offset);
+}
+
+static int mb86s70_gpio_direction_input(struct gpio_chip *gc, unsigned offset)
+{
+	struct mb86s70_gpio_chip *gchip =
+			container_of(gc, struct mb86s70_gpio_chip, gc);
+	unsigned long flags;
+	unsigned char val;
+
+	spin_lock_irqsave(&gchip->lock, flags);
+	val = readl(gchip->base + DDR(offset / 8 * 4));
+	val &= ~(1 << (offset % 8));
+	writel(val, gchip->base + DDR(offset / 8 * 4));
+	spin_unlock_irqrestore(&gchip->lock, flags);
+
+	return 0;
+}
+
+static int mb86s70_gpio_direction_output(struct gpio_chip *gc,
+					 unsigned offset, int value)
+{
+	struct mb86s70_gpio_chip *gchip =
+			container_of(gc, struct mb86s70_gpio_chip, gc);
+	unsigned long flags;
+	unsigned char val;
+
+	spin_lock_irqsave(&gchip->lock, flags);
+
+	val = readl(gchip->base + PDR(offset / 8 * 4));
+	if (value)
+		val |= (1 << (offset % 8));
+	else
+		val &= ~(1 << (offset % 8));
+	writel(val, gchip->base + PDR(offset / 8 * 4));
+
+	val = readl(gchip->base + DDR(offset / 8 * 4));
+	val |= (1 << (offset % 8));
+	writel(val, gchip->base + DDR(offset / 8 * 4));
+
+	spin_unlock_irqrestore(&gchip->lock, flags);
+
+	return 0;
+}
+
+static int mb86s70_gpio_get(struct gpio_chip *gc, unsigned offset)
+{
+	struct mb86s70_gpio_chip *gchip =
+			container_of(gc, struct mb86s70_gpio_chip, gc);
+	unsigned char val;
+
+	val = readl(gchip->base + PDR(offset / 8 * 4));
+	val &= (1 << (offset % 8));
+	return val ? 1 : 0;
+}
+
+static void mb86s70_gpio_set(struct gpio_chip *gc, unsigned offset, int value)
+{
+	struct mb86s70_gpio_chip *gchip =
+			container_of(gc, struct mb86s70_gpio_chip, gc);
+	unsigned long flags;
+	unsigned char val;
+
+	spin_lock_irqsave(&gchip->lock, flags);
+
+	val = readl(gchip->base + PDR(offset / 8 * 4));
+	if (value)
+		val |= (1 << (offset % 8));
+	else
+		val &= ~(1 << (offset % 8));
+	writel(val, gchip->base + PDR(offset / 8 * 4));
+
+	spin_unlock_irqrestore(&gchip->lock, flags);
+}
+
+static int mb86s70_gpio_probe(struct platform_device *pdev)
+{
+	struct mb86s70_gpio_chip *gchip;
+	struct resource *res;
+	int ret;
+
+	gchip = devm_kzalloc(&pdev->dev, sizeof(*gchip), GFP_KERNEL);
+	if (gchip == NULL)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, gchip);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	gchip->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(gchip->base))
+		return PTR_ERR(gchip->base);
+
+	gchip->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(gchip->clk))
+		return PTR_ERR(gchip->clk);
+
+	clk_prepare_enable(gchip->clk);
+
+	spin_lock_init(&gchip->lock);
+
+	gchip->gc.direction_output = mb86s70_gpio_direction_output;
+	gchip->gc.direction_input = mb86s70_gpio_direction_input;
+	gchip->gc.request = mb86s70_gpio_request;
+	gchip->gc.free = mb86s70_gpio_free;
+	gchip->gc.get = mb86s70_gpio_get;
+	gchip->gc.set = mb86s70_gpio_set;
+	gchip->gc.label = dev_name(&pdev->dev);
+	gchip->gc.ngpio = 32;
+	gchip->gc.owner = THIS_MODULE;
+	gchip->gc.dev = &pdev->dev;
+	gchip->gc.base = -1;
+
+	ret = gpiochip_add(&gchip->gc);
+	if (ret) {
+		dev_err(&pdev->dev, "couldn't register gpio driver\n");
+		clk_disable_unprepare(gchip->clk);
+	}
+
+	return ret;
+}
+
+struct mb86s70_pmux_chip {
+	spinlock_t lock; /* mux regs */
+	struct device *dev;
+	void __iomem *base;
+	void __iomem *conf_base;
+	struct pinctrl_dev *pctl;
+	struct pinctrl_desc desc;
+	bool pin_busy[MB86S70_PMUX_PINS];
+	char pin_names[5 * MB86S70_PMUX_PINS];
+	struct pinctrl_pin_desc pins[MB86S70_PMUX_PINS];
+};
+
+struct mb86s70_pmx_grp {
+	const char *name;
+	const unsigned *pins;
+	const unsigned num_pins;
+};
+
+struct mb86s70_pmx_function {
+	const unsigned num_groups;
+	unsigned prog_val;
+	const char *name;
+
+	const char *const *groups;
+};
+
+static const unsigned extint16_s70[] = {0};
+static const unsigned tsif0_s70[] = {16, 17, 18, 19};
+static const unsigned tsif1_s70[] = {16, 17, 18, 19};
+static const unsigned uart1_s70[] = {56, 57, 58, 59};
+static const unsigned uart2_s70[] = {60, 61, 62, 63};
+static const unsigned pl244_s70[] = {40, 41, 42, 43, 44, 45, 46, 47, 48,
+					49, 50, 51, 52, 53, 54, 55, 56, 57,
+					58, 59, 60, 61, 62};
+static const unsigned trace_s70[] = {24, 25, 26, 27, 28, 29, 30, 31, 32,
+					33, 34, 35, 36, 37, 38, 39, 64, 65};
+static const unsigned memcs_s70[] = {16, 17, 18, 19, 20, 21, 22, 23, 24,
+					25, 26, 27, 28, 29, 30, 31, 32, 33,
+					34, 35, 36, 37, 38, 39, 40, 41, 42,
+					43, 44, 45, 46, 47, 48, 49, 50, 51,
+					52, 53, 54, 55, 56, 57, 58, 59, 60,
+					61, 62, 63, 64, 65};
+static const unsigned cap_s70[] = {16, 17, 18, 19, 20, 21, 22, 23, 24, 25,
+					26, 27, 28, 29, 30, 31, 32, 33, 34,
+					35, 36, 37, 38, 39, 40, 41, 42, 43,
+					44, 45, 46, 47};
+
+static const struct mb86s70_pmx_grp mb86s70_pgrps[] = {
+	{
+		.name = "extint16_grp",
+		.pins = extint16_s70,
+		.num_pins = ARRAY_SIZE(extint16_s70),
+	},
+	{
+		.name = "tsif0_grp",
+		.pins = tsif0_s70,
+		.num_pins = ARRAY_SIZE(tsif0_s70),
+	},
+	{
+		.name = "tsif1_grp",
+		.pins = tsif1_s70,
+		.num_pins = ARRAY_SIZE(tsif1_s70),
+	},
+	{
+		.name = "uart1_grp",
+		.pins = uart1_s70,
+		.num_pins = ARRAY_SIZE(uart1_s70),
+	},
+	{
+		.name = "uart2_grp",
+		.pins = uart2_s70,
+		.num_pins = ARRAY_SIZE(uart2_s70),
+	},
+	{
+		.name = "pl244_grp",
+		.pins = pl244_s70,
+		.num_pins = ARRAY_SIZE(pl244_s70),
+	},
+	{
+		.name = "trace_grp",
+		.pins = trace_s70,
+		.num_pins = ARRAY_SIZE(trace_s70),
+	},
+	{
+		.name = "memcs_grp",
+		.pins = memcs_s70,
+		.num_pins = ARRAY_SIZE(memcs_s70),
+	},
+	{
+		.name = "cap_grp",
+		.pins = cap_s70,
+		.num_pins = ARRAY_SIZE(cap_s70),
+	}
+};
+
+static const unsigned pcie0_s73[] = {PINS_PCIE0};
+static const unsigned usb3h0_s73[] = {PINS_USB3H0};
+static const unsigned usb2h0_s73[] = {PINS_USB2H0};
+static const unsigned usb2d0_s73[] = {PINS_USB2D0};
+static const unsigned sdh30_s73[] = {PINS_SDH30};
+static const unsigned emmc0_s73[] = {PINS_EMMC0};
+static const unsigned hsspi0_s73[] = {PINS_HSSPI0};
+static const unsigned gmacd0_s73[] = {PINS_GMACD0};
+static const unsigned gmacm0_s73[] = {PINS_GMACM0};
+static const unsigned i2s0_s73[] = {PINS_I2S0};
+static const unsigned other0_s73[] = {PINS_OTHER0};
+static const unsigned jtag0_s73[] = {PINS_JTAG0};
+static const unsigned pcie1_s73[] = {PINS_PCIE1};
+static const unsigned usb3h1_s73[] = {PINS_USB3H1};
+static const unsigned extint5_s73[] = {37};
+static const unsigned cfg_s73[] = {56, 57, 58, 59, 60, 61, 62, 63};
+static const unsigned uart0_s73[] = {8, 11, 12, 15};
+static const unsigned uart1_s73[] = {16, 17, 18, 19, 20, 21, 22, 23};
+static const unsigned uart2_s73[] = {24, 25, 26, 27, 28, 29, 30, 31};
+static const unsigned trace_s73[] = {44, 45, 46, 47, 48, 49, 50,
+					51, 52, 53, 54, 55, 56, 57,
+					58, 59, 60, 61};
+static const unsigned smt_s73[] = {56, 57, 58, 59, 60, 61};
+static const unsigned memcs_s73[] = {8, 9, 10, 11, 12, 13, 14, 15,
+					16, 17, 18, 19, 20, 21, 22,
+					23, 24, 25, 26, 27, 28, 29,
+					30, 31, 32, 33, 34, 35, 36,
+					37, 38, 39, 40, 41, 42, 43,
+					44, 45, 46, 47, 48, 49, 50,
+					51, 52, 53, 54, 55};
+static const unsigned pl244_s73[] = {8, 9, 10, 11, 12, 13, 14, 15,
+					16, 17, 18, 19, 20, 21, 22,
+					23, 24, 25, 26, 27, 28, 29,
+					30, 31};
+
+static const struct mb86s70_pmx_grp mb86s73_pgrps[] = {
+	{
+		.name = "extint5_grp",
+		.pins = extint5_s73,
+		.num_pins = ARRAY_SIZE(extint5_s73),
+	},
+	{
+		.name = "pcie0_grp",
+		.pins = pcie0_s73,
+		.num_pins = ARRAY_SIZE(pcie0_s73),
+	},
+	{
+		.name = "usb3h0_grp",
+		.pins = usb3h0_s73,
+		.num_pins = ARRAY_SIZE(usb3h0_s73),
+	},
+	{
+		.name = "usb2h0_grp",
+		.pins = usb2h0_s73,
+		.num_pins = ARRAY_SIZE(usb2h0_s73),
+	},
+	{
+		.name = "usb2d0_grp",
+		.pins = usb2d0_s73,
+		.num_pins = ARRAY_SIZE(usb2d0_s73),
+	},
+	{
+		.name = "sdh30_grp",
+		.pins = sdh30_s73,
+		.num_pins = ARRAY_SIZE(sdh30_s73),
+	},
+	{
+		.name = "emmc0_grp",
+		.pins = emmc0_s73,
+		.num_pins = ARRAY_SIZE(emmc0_s73),
+	},
+	{
+		.name = "hsspi0_grp",
+		.pins = hsspi0_s73,
+		.num_pins = ARRAY_SIZE(hsspi0_s73),
+	},
+	{
+		.name = "gmacd0_grp",
+		.pins = gmacd0_s73,
+		.num_pins = ARRAY_SIZE(gmacd0_s73),
+	},
+	{
+		.name = "gmacm0_grp",
+		.pins = gmacm0_s73,
+		.num_pins = ARRAY_SIZE(gmacm0_s73),
+	},
+	{
+		.name = "i2s0_grp",
+		.pins = i2s0_s73,
+		.num_pins = ARRAY_SIZE(i2s0_s73),
+	},
+	{
+		.name = "other0_grp",
+		.pins = other0_s73,
+		.num_pins = ARRAY_SIZE(other0_s73),
+	},
+	{
+		.name = "jtag0_grp",
+		.pins = jtag0_s73,
+		.num_pins = ARRAY_SIZE(jtag0_s73),
+	},
+	{
+		.name = "pcie1_grp",
+		.pins = pcie1_s73,
+		.num_pins = ARRAY_SIZE(pcie1_s73),
+	},
+	{
+		.name = "usb3h1_grp",
+		.pins = usb3h1_s73,
+		.num_pins = ARRAY_SIZE(usb3h1_s73),
+	},
+	{
+		.name = "cfg_grp",
+		.pins = cfg_s73,
+		.num_pins = ARRAY_SIZE(cfg_s73),
+	},
+	{
+		.name = "uart0_grp",
+		.pins = uart0_s73,
+		.num_pins = ARRAY_SIZE(uart0_s73),
+	},
+	{
+		.name = "uart1_grp",
+		.pins = uart1_s73,
+		.num_pins = ARRAY_SIZE(uart1_s73),
+	},
+	{
+		.name = "uart2_grp",
+		.pins = uart2_s73,
+		.num_pins = ARRAY_SIZE(uart2_s73),
+	},
+	{
+		.name = "trace_grp",
+		.pins = trace_s73,
+		.num_pins = ARRAY_SIZE(trace_s73),
+	},
+	{
+		.name = "smt_grp",
+		.pins = smt_s73,
+		.num_pins = ARRAY_SIZE(smt_s73),
+	},
+	{
+		.name = "memcs_grp",
+		.pins = memcs_s73,
+		.num_pins = ARRAY_SIZE(memcs_s73),
+	},
+	{
+		.name = "pl244_grp",
+		.pins = pl244_s73,
+		.num_pins = ARRAY_SIZE(pl244_s73),
+	},
+};
+
+static int func_count, grp_count;
+static const struct mb86s70_pmx_grp *mb86s7x_pgrps;
+static const struct mb86s70_pmx_function *mb86s7x_pmx_funcs;
+
+static int mb86s70_pctrl_get_groups_count(struct pinctrl_dev *pctl)
+{
+	return grp_count;
+}
+
+static const char *
+mb86s70_pctrl_get_group_name(struct pinctrl_dev *pctl, unsigned selector)
+{
+	return mb86s7x_pgrps[selector].name;
+}
+
+static int
+mb86s70_pctrl_get_group_pins(struct pinctrl_dev *pctl, unsigned selector,
+			     const unsigned **pins, unsigned *num_pins)
+{
+	*pins = mb86s7x_pgrps[selector].pins;
+	*num_pins = mb86s7x_pgrps[selector].num_pins;
+
+	return 0;
+}
+
+static int
+mb86s70_pctrl_dt_node_to_map(struct pinctrl_dev *pctl,
+			     struct device_node *node,
+			     struct pinctrl_map **map, unsigned *num_maps)
+{
+	struct mb86s70_pmux_chip *pchip	= pinctrl_dev_get_drvdata(pctl);
+	int ret, i, configlen = 0;
+	unsigned long *pinconfig;
+	const char *function;
+	const char *group;
+	u32 val;
+
+	*map = NULL;
+	*num_maps = 0;
+
+	ret = of_property_read_string(node, "mb86s7x,function", &function);
+	if (ret) {
+		dev_err(pchip->dev,
+			"missing mb86s7x,function property in node %s\n",
+			node->name);
+		return -EINVAL;
+	}
+
+	*map = devm_kzalloc(pchip->dev,
+			    2 * sizeof(struct pinctrl_map), GFP_KERNEL);
+	if (!*map)
+		return -ENOMEM;
+
+	for (i = 0; i < func_count; i++)
+		if (!strcmp(mb86s7x_pmx_funcs[i].name, function))
+			break;
+
+	if (i == func_count) {
+		dev_err(pchip->dev, "function(%s) not found!\n", function);
+		return -EINVAL;
+	}
+	group = mb86s7x_pmx_funcs[i].groups[0];
+
+	(*map)[0].type = PIN_MAP_TYPE_MUX_GROUP;
+	(*map)[0].data.mux.group = group;
+	(*map)[0].data.mux.function = function;
+	*num_maps = 1;
+
+	if (of_find_property(node, "mb86s7x,drvst", NULL))
+		configlen++;
+	if (of_find_property(node, "mb86s7x,pullup", NULL))
+		configlen++;
+
+	if (configlen == 0) /* For S70 */
+		return 0;
+
+	i = 0;
+	pinconfig = devm_kzalloc(pchip->dev,
+				 configlen * sizeof(*pinconfig), GFP_KERNEL);
+
+	if (!of_property_read_u32(node, "mb86s7x,drvst", &val))
+		pinconfig[i++] =
+			pinconf_to_config_packed(PIN_CONFIG_DRIVE_STRENGTH,
+						 val);
+
+	if (!of_property_read_u32(node, "mb86s7x,pullup", &val)) {
+		enum pin_config_param pull;
+
+		if (val)
+			pull = PIN_CONFIG_BIAS_PULL_UP;
+		else
+			pull = PIN_CONFIG_BIAS_PULL_DOWN;
+		pinconfig[i++] = pinconf_to_config_packed(pull, 0);
+	}
+
+	(*map)[1].type = PIN_MAP_TYPE_CONFIGS_GROUP;
+	(*map)[1].data.configs.group_or_pin = group;
+	(*map)[1].data.configs.configs = pinconfig;
+	(*map)[1].data.configs.num_configs = configlen;
+
+	*num_maps = 2;
+
+	return 0;
+}
+
+static void
+mb86s70_pctrl_dt_free_map(struct pinctrl_dev *pctl,
+			  struct pinctrl_map *map, unsigned num_maps)
+{
+	struct mb86s70_pmux_chip *pchip	= pinctrl_dev_get_drvdata(pctl);
+	int i;
+
+	for (i = 0; i < num_maps; i++)
+		if (map[i].type == PIN_MAP_TYPE_CONFIGS_GROUP)
+			devm_kfree(pchip->dev, map[i].data.configs.configs);
+
+	devm_kfree(pchip->dev, map);
+}
+
+static const struct pinctrl_ops mb86s70_pctrl_ops = {
+	.get_groups_count	= mb86s70_pctrl_get_groups_count,
+	.get_group_name		= mb86s70_pctrl_get_group_name,
+	.get_group_pins		= mb86s70_pctrl_get_group_pins,
+	.dt_node_to_map		= mb86s70_pctrl_dt_node_to_map,
+	.dt_free_map		= mb86s70_pctrl_dt_free_map,
+};
+
+static const char * const pcie0_groups[] = {"pcie0_grp"};
+static const char * const usb3h0_groups[] = {"usb3h0_grp"};
+static const char * const usb2h0_groups[] = {"usb2h0_grp"};
+static const char * const usb2d0_groups[] = {"usb2d0_grp"};
+static const char * const sdh30_groups[] = {"sdh30_grp"};
+static const char * const emmc0_groups[] = {"emmc0_grp"};
+static const char * const hsspi0_groups[] = {"hsspi0_grp"};
+static const char * const gmacd0_groups[] = {"gmacd0_grp"};
+static const char * const gmacm0_groups[] = {"gmacm0_grp"};
+static const char * const i2s0_groups[] = {"i2s0_grp"};
+static const char * const other0_groups[] = {"other0_grp"};
+static const char * const jtag0_groups[] = {"jtag0_grp"};
+static const char * const pcie1_groups[] = {"pcie1_grp"};
+static const char * const usb3h1_groups[] = {"usb3h1_grp"};
+static const char * const extint16_groups[] = {"extint16_grp"};
+static const char * const extint5_groups[] = {"extint5_grp"};
+static const char * const tsif0_groups[] = {"tsif0_grp"};
+static const char * const tsif1_groups[] = {"tsif1_grp"};
+static const char * const cfg_groups[] = {"cfg_grp"};
+static const char * const uart0_groups[] = {"uart0_grp"};
+static const char * const uart1_groups[] = {"uart1_grp"};
+static const char * const uart2_groups[] = {"uart2_grp"};
+static const char * const pl244_groups[] = {"pl244_grp"};
+static const char * const trace_groups[] = {"trace_grp"};
+static const char * const memcs_groups[] = {"memcs_grp"};
+static const char * const cap_groups[] = {"cap_grp"};
+static const char * const smt_groups[] = {"smt_grp"};
+
+static const struct mb86s70_pmx_function mb86s73_pmx_funcs[] = {
+	{
+		.prog_val = 0x1,
+		.name = "extint5",
+		.groups = extint5_groups,
+		.num_groups = ARRAY_SIZE(extint5_groups),
+	},
+	{
+		.prog_val = 0x0,
+		.name = "pcie0",
+		.groups = pcie0_groups,
+		.num_groups = ARRAY_SIZE(pcie0_groups),
+	},
+	{
+		.prog_val = 0x0,
+		.name = "usb3h0",
+		.groups = usb3h0_groups,
+		.num_groups = ARRAY_SIZE(usb3h0_groups),
+	},
+	{
+		.prog_val = 0x0,
+		.name = "usb2h0",
+		.groups = usb2h0_groups,
+		.num_groups = ARRAY_SIZE(usb2h0_groups),
+	},
+	{
+		.prog_val = 0x0,
+		.name = "usb2d0",
+		.groups = usb2d0_groups,
+		.num_groups = ARRAY_SIZE(usb2d0_groups),
+	},
+	{
+		.prog_val = 0x0,
+		.name = "sdh30",
+		.groups = sdh30_groups,
+		.num_groups = ARRAY_SIZE(sdh30_groups),
+	},
+	{
+		.prog_val = 0x0,
+		.name = "emmc0",
+		.groups = emmc0_groups,
+		.num_groups = ARRAY_SIZE(emmc0_groups),
+	},
+	{
+		.prog_val = 0x0,
+		.name = "hsspi0",
+		.groups = hsspi0_groups,
+		.num_groups = ARRAY_SIZE(hsspi0_groups),
+	},
+	{
+		.prog_val = 0x0,
+		.name = "gmacd0",
+		.groups = gmacd0_groups,
+		.num_groups = ARRAY_SIZE(gmacd0_groups),
+	},
+	{
+		.prog_val = 0x0,
+		.name = "gmacm0",
+		.groups = gmacm0_groups,
+		.num_groups = ARRAY_SIZE(gmacm0_groups),
+	},
+	{
+		.prog_val = 0x0,
+		.name = "i2s0",
+		.groups = i2s0_groups,
+		.num_groups = ARRAY_SIZE(i2s0_groups),
+	},
+	{
+		.prog_val = 0x0,
+		.name = "other0",
+		.groups = other0_groups,
+		.num_groups = ARRAY_SIZE(other0_groups),
+	},
+	{
+		.prog_val = 0x0,
+		.name = "jtag0",
+		.groups = jtag0_groups,
+		.num_groups = ARRAY_SIZE(jtag0_groups),
+	},
+	{
+		.prog_val = 0x0,
+		.name = "pcie1",
+		.groups = pcie1_groups,
+		.num_groups = ARRAY_SIZE(pcie1_groups),
+	},
+	{
+		.prog_val = 0x0,
+		.name = "usb3h1",
+		.groups = usb3h1_groups,
+		.num_groups = ARRAY_SIZE(usb3h1_groups),
+	},
+	{
+		.prog_val = 0x1,
+		.name = "cfg",
+		.groups = cfg_groups,
+		.num_groups = ARRAY_SIZE(cfg_groups),
+	},
+	{
+		.prog_val = 0x1,
+		.name = "uart0",
+		.groups = uart0_groups,
+		.num_groups = ARRAY_SIZE(uart0_groups),
+	},
+	{
+		.prog_val = 0x1,
+		.name = "uart1",
+		.groups = uart1_groups,
+		.num_groups = ARRAY_SIZE(uart1_groups),
+	},
+	{
+		.prog_val = 0x1,
+		.name = "uart2",
+		.groups = uart2_groups,
+		.num_groups = ARRAY_SIZE(uart2_groups),
+	},
+	{
+		.prog_val = 0x2,
+		.name = "trace",
+		.groups = trace_groups,
+		.num_groups = ARRAY_SIZE(trace_groups),
+	},
+	{
+		.prog_val = 0x2,
+		.name = "pl244",
+		.groups = pl244_groups,
+		.num_groups = ARRAY_SIZE(pl244_groups),
+	},
+	{
+		.prog_val = 0x3,
+		.name = "smt",
+		.groups = smt_groups,
+		.num_groups = ARRAY_SIZE(smt_groups),
+	},
+	{
+		.prog_val = 0x3,
+		.name = "memcs",
+		.groups = memcs_groups,
+		.num_groups = ARRAY_SIZE(memcs_groups),
+	},
+};
+
+static const struct mb86s70_pmx_function mb86s70_pmx_funcs[] = {
+	{
+		.prog_val = 0x2,
+		.name = "extint16",
+		.groups = extint16_groups,
+		.num_groups = ARRAY_SIZE(extint16_groups),
+	},
+	{
+		.prog_val = 0x3,
+		.name = "tsif0",
+		.groups = tsif0_groups,
+		.num_groups = ARRAY_SIZE(tsif0_groups),
+	},
+	{
+		.prog_val = 0x3,
+		.name = "tsif1",
+		.groups = tsif1_groups,
+		.num_groups = ARRAY_SIZE(tsif1_groups),
+	},
+	{
+		.prog_val = 0x2,
+		.name = "uart1",
+		.groups = uart1_groups,
+		.num_groups = ARRAY_SIZE(uart1_groups),
+	},
+	{
+		.prog_val = 0x2,
+		.name = "uart2",
+		.groups = uart2_groups,
+		.num_groups = ARRAY_SIZE(uart2_groups),
+	},
+	{
+		.prog_val = 0x5,
+		.name = "pl244",
+		.groups = pl244_groups,
+		.num_groups = ARRAY_SIZE(pl244_groups),
+	},
+	{
+		.prog_val = 0x3,
+		.name = "trace",
+		.groups = trace_groups,
+		.num_groups = ARRAY_SIZE(trace_groups),
+	},
+	{
+		.prog_val = 0x4,
+		.name = "memcs",
+		.groups = memcs_groups,
+		.num_groups = ARRAY_SIZE(memcs_groups),
+	},
+	{
+		.prog_val = 0x2,
+		.name = "capture",
+		.groups = cap_groups,
+		.num_groups = ARRAY_SIZE(cap_groups),
+	}
+};
+
+static int
+mb86s70_pmx_get_functions_count(struct pinctrl_dev *pctl)
+{
+	return func_count;
+}
+
+static const char *
+mb86s70_pmx_get_function_name(struct pinctrl_dev *pctl, unsigned selector)
+{
+	return mb86s7x_pmx_funcs[selector].name;
+}
+
+static int
+mb86s70_pmx_get_function_groups(struct pinctrl_dev *pctl,
+				unsigned selector, const char * const **groups,
+				unsigned * const num_groups)
+{
+	*groups = mb86s7x_pmx_funcs[selector].groups;
+	*num_groups = mb86s7x_pmx_funcs[selector].num_groups;
+
+	return 0;
+}
+
+static int
+mb86s70_pmx_enable(struct pinctrl_dev *pctl,
+		   unsigned func_selector, unsigned group_selector)
+{
+	struct mb86s70_pmux_chip *pchip	= pinctrl_dev_get_drvdata(pctl);
+	unsigned long flags;
+	const unsigned *pins;
+	int i, j;
+
+	if (group_selector >= grp_count) {
+		pr_err("%s:%d\n", __func__, __LINE__);
+		return -EINVAL;
+	}
+
+	j = mb86s7x_pgrps[group_selector].num_pins;
+	pins = mb86s7x_pgrps[group_selector].pins;
+
+	spin_lock_irqsave(&pchip->lock, flags);
+
+	/* Busy if any pin in the same 'bunch' is taken */
+	for (i = 0; i < j; i++) {
+		u32 val;
+		int p = pins[i] / 4 * 4;
+
+		if (pins[i] >= PINS_VIRT) /* Not for virtual pins */
+			continue;
+
+		val = readl(pchip->base + p);
+		/* skip if no change needed */
+		if (val == mb86s7x_pmx_funcs[func_selector].prog_val)
+			continue;
+
+		if (pchip->pin_busy[p]) {
+			pr_err("%s:%d:%d %d busy\n",
+			       __func__, __LINE__, pins[i], p);
+			goto busy_exit;
+		}
+
+		if (pchip->pin_busy[p + 1]) {
+			pr_err("%s:%d:%d %d busy\n",
+			       __func__, __LINE__, pins[i], p+1);
+			goto busy_exit;
+		}
+
+		if (p == 64)
+			continue;
+
+		if (pchip->pin_busy[p + 2]) {
+			pr_err("%s:%d:%d %d busy\n",
+			       __func__, __LINE__, pins[i], p+2);
+			goto busy_exit;
+		}
+
+		if (pchip->pin_busy[p + 3]) {
+			pr_err("%s:%d:%d %d busy\n",
+			       __func__, __LINE__, pins[i], p+3);
+			goto busy_exit;
+		}
+
+		continue;
+busy_exit:
+		spin_unlock_irqrestore(&pchip->lock, flags);
+		pr_err("%s:%d Take a look!\n", __func__, __LINE__);
+		return -EBUSY;
+	}
+
+	pr_debug("Going to enable %s on pins -",
+		 mb86s7x_pmx_funcs[func_selector].name);
+	for (i = 0; i < j; i++) {
+		int p = pins[i];
+
+		pr_debug(" %d", p);
+		pchip->pin_busy[p] = true;
+		if (p < PINS_VIRT) /* Not for virtual pins */
+			writel(mb86s7x_pmx_funcs[func_selector].prog_val,
+			       pchip->base + p / 4 * 4);
+	}
+
+	spin_unlock_irqrestore(&pchip->lock, flags);
+	pr_debug("\n");
+
+	return 0;
+}
+
+static void
+mb86s70_pmx_disable(struct pinctrl_dev *pctl,
+		    unsigned func_selector, unsigned group_selector)
+{
+	struct mb86s70_pmux_chip *pchip	= pinctrl_dev_get_drvdata(pctl);
+	unsigned long flags;
+	const unsigned *pins;
+	int i, j;
+
+	if (group_selector >= grp_count) {
+		pr_err("%s:%d\n", __func__, __LINE__);
+		return;
+	}
+
+	j = mb86s7x_pgrps[group_selector].num_pins;
+	pins = mb86s7x_pgrps[group_selector].pins;
+
+	pr_debug("Going to disable %s on pins -",
+		 mb86s7x_pmx_funcs[func_selector].name);
+	spin_lock_irqsave(&pchip->lock, flags);
+	for (i = 0; i < j; i++) {
+		pr_debug(" %d", pins[i]);
+		pchip->pin_busy[pins[i]] = false;
+	}
+	spin_unlock_irqrestore(&pchip->lock, flags);
+	pr_debug("\n");
+}
+
+static int
+mb86s70_pmx_gpio_set_direction(struct pinctrl_dev *pctl,
+			       struct pinctrl_gpio_range *range,
+			       unsigned pin, bool input)
+{
+	struct gpio_chip *gc = range->gc;
+	struct mb86s70_gpio_chip *gchip = container_of(gc,
+						struct mb86s70_gpio_chip, gc);
+	unsigned long flags;
+	u32 off, bit, val;
+
+	if (pin >= 64)
+		return -EINVAL;
+
+	spin_lock_irqsave(&gchip->lock, flags);
+	bit = (pin - gc->base) % 8;
+	off = (pin - gc->base) / 8 * 4;
+	val = readl(gchip->base + DDR(off));
+	if (input)
+		val &= ~(1 << bit);
+	else
+		val |= (1 << bit);
+	writel(val, gchip->base + DDR(off));
+	spin_unlock_irqrestore(&gchip->lock, flags);
+
+	return 0;
+}
+
+static int
+mb86s70_pmx_gpio_request_enable(struct pinctrl_dev *pctl,
+				struct pinctrl_gpio_range *range, unsigned pin)
+{
+	struct mb86s70_pmux_chip *pchip	= pinctrl_dev_get_drvdata(pctl);
+	struct gpio_chip *gc = range->gc;
+	struct mb86s70_gpio_chip *gchip = container_of(gc,
+						 struct mb86s70_gpio_chip, gc);
+	unsigned long flags;
+	int p = pin / 4 * 4;
+	u32 val, off, bit;
+
+	if (p == 64)
+		return -ENODEV;
+
+	spin_lock_irqsave(&pchip->lock, flags);
+	if (pchip->pin_busy[p] || pchip->pin_busy[p + 1] ||
+			pchip->pin_busy[p + 2] || pchip->pin_busy[p + 3]) {
+		val = readl(pchip->base + p);
+		if (val != 0x1) {
+			spin_unlock_irqrestore(&pchip->lock, flags);
+			return -EBUSY;
+		}
+	}
+
+	pchip->pin_busy[pin] = true;
+	writel(0x1, pchip->base + p);
+	spin_unlock_irqrestore(&pchip->lock, flags);
+
+	spin_lock_irqsave(&gchip->lock, flags);
+	bit = (pin - range->pin_base) % 8;
+	off = (pin - range->pin_base) / 8 * 4;
+	val = readl(gchip->base + PFR(off));
+	val &= ~(1 << bit);
+	writel(val, gchip->base + PFR(off));
+	spin_unlock_irqrestore(&gchip->lock, flags);
+
+	return 0;
+}
+
+static void
+mb86s70_pmx_gpio_disable_free(struct pinctrl_dev *pctl,
+			      struct pinctrl_gpio_range *range, unsigned pin)
+{
+	struct mb86s70_pmux_chip *pchip	= pinctrl_dev_get_drvdata(pctl);
+	struct gpio_chip *gc = range->gc;
+	struct mb86s70_gpio_chip *gchip = container_of(gc,
+						struct mb86s70_gpio_chip, gc);
+	unsigned long flags;
+	u32 off, bit, val;
+
+	if (pin >= 64)
+		return;
+
+	spin_lock_irqsave(&pchip->lock, flags);
+	pchip->pin_busy[pin] = false;
+	spin_unlock_irqrestore(&pchip->lock, flags);
+
+	spin_lock_irqsave(&gchip->lock, flags);
+	bit = (pin - range->pin_base) % 8;
+	off = (pin - range->pin_base) / 8 * 4;
+	val = readl(gchip->base + PFR(off));
+	val |= (1 << bit);
+	writel(val, gchip->base + PFR(off));
+	spin_unlock_irqrestore(&gchip->lock, flags);
+}
+
+static const struct pinmux_ops mb86s70_pmx_ops = {
+	.get_functions_count	= mb86s70_pmx_get_functions_count,
+	.get_function_name	= mb86s70_pmx_get_function_name,
+	.get_function_groups	= mb86s70_pmx_get_function_groups,
+	.enable			= mb86s70_pmx_enable,
+	.disable		= mb86s70_pmx_disable,
+	.gpio_set_direction	= mb86s70_pmx_gpio_set_direction,
+	.gpio_request_enable	= mb86s70_pmx_gpio_request_enable,
+	.gpio_disable_free	= mb86s70_pmx_gpio_disable_free,
+};
+
+static int
+mb86s70_pin_config_group_get(struct pinctrl_dev *pctl, unsigned group,
+			     unsigned long *config)
+{
+	return -EINVAL;
+}
+
+static int
+mb86s70_pin_config_group_set(struct pinctrl_dev *pctl, unsigned group,
+			     unsigned long *configs, unsigned num_configs)
+{
+	struct mb86s70_pmux_chip *pchip	= pinctrl_dev_get_drvdata(pctl);
+	unsigned long flags;
+	const unsigned *pin;
+	int i, j, p;
+	u32 val, ds;
+
+	p = mb86s7x_pgrps[group].num_pins;
+	pin = mb86s7x_pgrps[group].pins;
+
+	spin_lock_irqsave(&pchip->lock, flags);
+
+	for (i = 0; i < num_configs; i++) {
+		switch (pinconf_to_config_param(configs[i])) {
+		case PIN_CONFIG_DRIVE_STRENGTH:
+			/* Drive Strength should be 2, 4, 6 or 8 mA */
+			ds = pinconf_to_config_argument(configs[i]);
+			ds = (ds - 2) / 2;
+			for (j = 0; j < p; j++) {
+				/* Clear the Hi-z */
+				val = readl_relaxed(pchip->conf_base +
+							FORCEZ_PDG(pin[j]));
+				val &= ~(0x3 << PIN_OFF(pin[j]));
+				writel_relaxed(val, pchip->conf_base +
+							FORCEZ_PDG(pin[j]));
+				val = readl_relaxed(pchip->conf_base +
+							CDRV_PDG(pin[j]));
+				val &= ~(0x3 << PIN_OFF(pin[j]));
+				val |= (ds << PIN_OFF(pin[j]));
+				writel_relaxed(val, pchip->conf_base +
+							CDRV_PDG(pin[j]));
+			}
+			break;
+		case PIN_CONFIG_BIAS_HIGH_IMPEDANCE:
+			for (j = 0; j < p; j++) {
+				val = readl_relaxed(pchip->conf_base +
+							FORCEZ_PDG(pin[j]));
+				val &= ~(0x3 << PIN_OFF(pin[j]));
+				val |= (0x1 << PIN_OFF(pin[j]));
+				writel_relaxed(val, pchip->conf_base +
+							FORCEZ_PDG(pin[j]));
+			}
+			break;
+		case PIN_CONFIG_BIAS_PULL_DOWN:
+			for (j = 0; j < p; j++) {
+				val = readl_relaxed(pchip->conf_base +
+							PULL_PDG(pin[j]));
+				val &= ~(0x3 << PIN_OFF(pin[j]));
+				writel_relaxed(val, pchip->conf_base +
+							PULL_PDG(pin[j]));
+			}
+			break;
+		case PIN_CONFIG_BIAS_PULL_UP:
+			for (j = 0; j < p; j++) {
+				val = readl_relaxed(pchip->conf_base +
+							PULL_PDG(pin[j]));
+				val &= ~(0x3 << PIN_OFF(pin[j]));
+				val |= (1 << PIN_OFF(pin[j]));
+				writel_relaxed(val, pchip->conf_base +
+							PULL_PDG(pin[j]));
+			}
+			break;
+		default:
+			pr_err("%s:%d!!\n", __func__, __LINE__);
+			break;
+		}
+	}
+
+	spin_unlock_irqrestore(&pchip->lock, flags);
+
+	return 0;
+}
+
+static const struct pinconf_ops mb86s70_conf_ops = {
+	.pin_config_group_get = mb86s70_pin_config_group_get,
+	.pin_config_group_set = mb86s70_pin_config_group_set,
+};
+
+static const struct of_device_id mb86s70_pinmux_dt_ids[] = {
+	{.compatible = "fujitsu,mb86s70-pinctrl", .data = (void *)PMUX_MB86S70},
+	{.compatible = "fujitsu,mb86s73-pinctrl", .data = (void *)PMUX_MB86S73},
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, mb86s70_pinmux_dt_ids);
+
+static int mb86s70_pinmux_probe(struct platform_device *pdev)
+{
+	const struct of_device_id *device;
+	struct mb86s70_pmux_chip *pchip;
+	struct resource *res;
+	int i, type;
+
+	device = of_match_device(mb86s70_pinmux_dt_ids, &pdev->dev);
+	if (!device)
+		return -ENODEV;
+
+	type = (int)device->data;
+
+	/* reserve memory space for pmux chip */
+	pchip = devm_kzalloc(&pdev->dev, sizeof(*pchip), GFP_KERNEL);
+	if (pchip == NULL) {
+		dev_err(&pdev->dev, "can't allocate pinmux chip data.\n");
+		return -ENOMEM;
+	}
+	pchip->dev = &pdev->dev;
+
+	/* initiate pmux chip structure */
+	platform_set_drvdata(pdev, pchip);
+
+	/* IO resource */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	pchip->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(pchip->base))
+		return PTR_ERR(pchip->base);
+
+	/* initiate lock */
+	spin_lock_init(&pchip->lock);
+
+	pchip->desc.name = dev_name(&pdev->dev);
+	pchip->desc.npins = MB86S70_PMUX_PINS;
+	pchip->desc.pins = pchip->pins;
+	pchip->desc.pctlops = &mb86s70_pctrl_ops;
+	pchip->desc.pmxops = &mb86s70_pmx_ops;
+	pchip->desc.owner = THIS_MODULE;
+	if (type == PMUX_MB86S73) {
+		pchip->desc.confops = &mb86s70_conf_ops;
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+		pchip->conf_base = devm_ioremap_resource(&pdev->dev, res);
+		if (IS_ERR(pchip->conf_base))
+			return PTR_ERR(pchip->conf_base);
+		mb86s7x_pmx_funcs = mb86s73_pmx_funcs;
+		func_count = ARRAY_SIZE(mb86s73_pmx_funcs);
+		mb86s7x_pgrps = mb86s73_pgrps;
+		grp_count = ARRAY_SIZE(mb86s73_pgrps);
+	} else {
+		mb86s7x_pmx_funcs = mb86s70_pmx_funcs;
+		func_count = ARRAY_SIZE(mb86s70_pmx_funcs);
+		mb86s7x_pgrps = mb86s70_pgrps;
+		grp_count = ARRAY_SIZE(mb86s70_pgrps);
+	}
+
+	for (i = 0; i < MB86S70_PMUX_PINS; i++) {
+		pchip->pin_busy[i] = false;
+		pchip->pins[i].number = i;
+		pchip->pins[i].name = &pchip->pin_names[5 * i];
+		snprintf(&pchip->pin_names[5 * i], 5, "PD%d", i);
+	}
+
+	pchip->pctl = pinctrl_register(&pchip->desc, &pdev->dev, pchip);
+	if (!pchip->pctl) {
+		dev_err(&pdev->dev, "couldn't register pinctrl driver\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const struct of_device_id mb86s70_gpio_dt_ids[] = {
+	{ .compatible = "fujitsu,mb86s7x-gpio" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, mb86s70_gpio_dt_ids);
+
+static struct platform_driver mb86s70_gpio_driver = {
+	.probe     = mb86s70_gpio_probe,
+	.driver    = {
+		.name  = "mb86s70-gpio",
+		.owner = THIS_MODULE,
+		.of_match_table = mb86s70_gpio_dt_ids,
+	},
+};
+
+static struct platform_driver mb86s70_pinmux_driver = {
+	.probe     = mb86s70_pinmux_probe,
+	.driver    = {
+		.name  = "mb86s70-pinmux",
+		.owner = THIS_MODULE,
+		.of_match_table = mb86s70_pinmux_dt_ids,
+	},
+};
+
+static int __init mb86s70_pins_init(void)
+{
+	int ret;
+
+	ret = platform_driver_register(&mb86s70_pinmux_driver);
+	if (ret)
+		return ret;
+
+	return platform_driver_register(&mb86s70_gpio_driver);
+}
+subsys_initcall(mb86s70_pins_init);
+
+MODULE_DESCRIPTION("MB86S7x PinCtrl Driver");
+MODULE_ALIAS("platform:mb86s70-pinmux");
+MODULE_ALIAS("platform:mb86s70-gpio");
+MODULE_LICENSE("GPL");
-- 
1.8.1.2
