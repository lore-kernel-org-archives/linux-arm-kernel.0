From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Sun, 11 Nov 2012 10:09:23 +0530
Subject: [PATCH 01/14] pinctrl: SPEAr: add spi chipselect control driver
In-Reply-To: <cover.1352608333.git.viresh.kumar@linaro.org>
References: <cover.1352608333.git.viresh.kumar@linaro.org>
Message-ID: <4a92290e8a3b1a19c3a5e864edfa7badfc2af5d0.1352608333.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shiraz Hashim <shiraz.hashim@st.com>

SPEAr platform provides a provision to control chipselects of ARM PL022
Prime Cell spi controller through its system registers, which otherwise
remains under PL022 control which some protocols do not want.

This commit intends to provide the spi chipselect control in software
over gpiolib interface. Since it is tied to pinctrl, we place it under
'drivers/pinctrl/spear/' directory.

spi chip drivers can use the exported gpiolib interface to define their
chipselect through DT or platform data.

Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Shiraz Hashim <shiraz.hashim@st.com>
Reviewed-by: Vipin Kumar <vipin.kumar@st.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 .../bindings/pinctrl/pinctrl_spear_spics.txt       |  50 +++++
 drivers/pinctrl/spear/Makefile                     |   4 +-
 drivers/pinctrl/spear/pinctrl-spics.c              | 217 +++++++++++++++++++++
 3 files changed, 269 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/pinctrl_spear_spics.txt
 create mode 100644 drivers/pinctrl/spear/pinctrl-spics.c

diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl_spear_spics.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl_spear_spics.txt
new file mode 100644
index 0000000..1c81280
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/pinctrl_spear_spics.txt
@@ -0,0 +1,50 @@
+=== ST Microelectronics SPEAr SPI CS Driver ===
+
+SPEAr platform provides a provision to control chipselects of ARM PL022 Prime
+Cell spi controller through its system registers, which otherwise remains under
+PL022 control. If chipselect remain under PL022 control then they would be
+released as soon as transfer is over and TxFIFO becomes empty. This is not
+desired by some of the device protocols above spi which expect (multiple)
+transfers without releasing their chipselects.
+
+Chipselects can be controlled by software by turning them as GPIOs. SPEAr
+provides another interface through system registers through which software can
+directly control each PL022 chipselect. Hence, it is natural for SPEAr to export
+the control of this interface as gpio.
+
+Required properties:
+
+  * compatible: should be defined as "st,spear-pinctrl-spics"
+  * reg: mentioning address range of spics controller
+  * st-spics,peripcfg-reg: peripheral configuration register offset
+  * st-spics,sw-enable-bit: bit offset to enable sw control
+  * st-spics,cs-value-bit: bit offset to drive chipselect low or high
+  * st-spics,cs-enable-mask: chip select number bit mask
+  * st-spics,cs-enable-shift: chip select number program offset
+  * gpio-controller: Marks the device node as gpio controller
+  * #gpio-cells: should be 1 and will mention chip select number
+
+All the above bit offsets are within peripcfg register.
+
+Example:
+-------
+spics: spics at e0700000{
+        compatible = "st,spear-spics-gpio";
+        reg = <0xe0700000 0x1000>;
+        st-spics,peripcfg-reg = <0x3b0>;
+        st-spics,sw-enable-bit = <12>;
+        st-spics,cs-value-bit = <11>;
+        st-spics,cs-enable-mask = <3>;
+        st-spics,cs-enable-shift = <8>;
+        gpio-controller;
+        #gpio-cells = <2>;
+};
+
+
+spi0: spi at e0100000 {
+        status = "okay";
+        num-cs = <3>;
+        cs-gpios = <&gpio1 7 0>, <&spics 0>,
+                   <&spics 1>;
+	...
+}
diff --git a/drivers/pinctrl/spear/Makefile b/drivers/pinctrl/spear/Makefile
index b28a7ba..6caec55 100644
--- a/drivers/pinctrl/spear/Makefile
+++ b/drivers/pinctrl/spear/Makefile
@@ -5,5 +5,5 @@ obj-$(CONFIG_PINCTRL_SPEAR3XX)	+= pinctrl-spear3xx.o
 obj-$(CONFIG_PINCTRL_SPEAR300)	+= pinctrl-spear300.o
 obj-$(CONFIG_PINCTRL_SPEAR310)	+= pinctrl-spear310.o
 obj-$(CONFIG_PINCTRL_SPEAR320)	+= pinctrl-spear320.o
-obj-$(CONFIG_PINCTRL_SPEAR1310)	+= pinctrl-spear1310.o
-obj-$(CONFIG_PINCTRL_SPEAR1340)	+= pinctrl-spear1340.o
+obj-$(CONFIG_PINCTRL_SPEAR1310)	+= pinctrl-spear1310.o pinctrl-spics.o
+obj-$(CONFIG_PINCTRL_SPEAR1340)	+= pinctrl-spear1340.o pinctrl-spics.o
diff --git a/drivers/pinctrl/spear/pinctrl-spics.c b/drivers/pinctrl/spear/pinctrl-spics.c
new file mode 100644
index 0000000..5f45fc4
--- /dev/null
+++ b/drivers/pinctrl/spear/pinctrl-spics.c
@@ -0,0 +1,217 @@
+/*
+ * SPEAr platform SPI chipselect abstraction over gpiolib
+ *
+ * Copyright (C) 2012 ST Microelectronics
+ * Shiraz Hashim <shiraz.hashim@st.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/err.h>
+#include <linux/gpio.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/types.h>
+
+/* maximum chipselects */
+#define NUM_OF_GPIO	4
+
+/*
+ * Provision is available on some SPEAr SoCs to control ARM PL022 spi cs
+ * through system registers. This register lies outside spi (pl022)
+ * address space into system registers.
+ *
+ * It provides control for spi chip select lines so that any chipselect
+ * (out of 4 possible chipselects in pl022) can be made low to select
+ * the particular slave.
+ */
+
+/**
+ * struct spear_spics - represents spi chip select control
+ * @base: base address
+ * @perip_cfg: configuration register
+ * @sw_enable_bit: bit to enable s/w control over chipselects
+ * @cs_value_bit: bit to program high or low chipselect
+ * @cs_enable_mask: mask to select bits required to select chipselect
+ * @cs_enable_shift: bit pos of cs_enable_mask
+ * @use_count: use count of a spi controller cs lines
+ * @last_off: stores last offset caller of set_value()
+ * @chip: gpio_chip abstraction
+ */
+struct spear_spics {
+	void __iomem		*base;
+	u32			perip_cfg;
+	u32			sw_enable_bit;
+	u32			cs_value_bit;
+	u32			cs_enable_mask;
+	u32			cs_enable_shift;
+	unsigned long		use_count;
+	int			last_off;
+	struct gpio_chip	chip;
+};
+
+/* gpio framework specific routines */
+static int spics_get_value(struct gpio_chip *chip, unsigned offset)
+{
+	return -ENXIO;
+}
+
+static void spics_set_value(struct gpio_chip *chip, unsigned offset, int value)
+{
+	struct spear_spics *spics = container_of(chip, struct spear_spics,
+			chip);
+	u32 tmp;
+
+	/* select chip select from register */
+	tmp = readl_relaxed(spics->base + spics->perip_cfg);
+	if (spics->last_off != offset) {
+		spics->last_off = offset;
+		tmp &= ~(spics->cs_enable_mask << spics->cs_enable_shift);
+		tmp |= offset << spics->cs_enable_shift;
+	}
+
+	/* toggle chip select line */
+	tmp &= ~(0x1 << spics->cs_value_bit);
+	tmp |= value << spics->cs_value_bit;
+	writel_relaxed(tmp, spics->base + spics->perip_cfg);
+}
+
+static int spics_direction_input(struct gpio_chip *chip, unsigned offset)
+{
+	return -ENXIO;
+}
+
+static int spics_direction_output(struct gpio_chip *chip, unsigned offset,
+		int value)
+{
+	spics_set_value(chip, offset, value);
+	return 0;
+}
+
+static int spics_request(struct gpio_chip *chip, unsigned offset)
+{
+	struct spear_spics *spics = container_of(chip, struct spear_spics,
+			chip);
+	u32 tmp;
+
+	if (!spics->use_count++) {
+		tmp = readl_relaxed(spics->base + spics->perip_cfg);
+		tmp |= 0x1 << spics->sw_enable_bit;
+		tmp |= 0x1 << spics->cs_value_bit;
+		writel_relaxed(tmp, spics->base + spics->perip_cfg);
+	}
+
+	return 0;
+}
+
+static void spics_free(struct gpio_chip *chip, unsigned offset)
+{
+	struct spear_spics *spics = container_of(chip, struct spear_spics,
+			chip);
+	u32 tmp;
+
+	if (!--spics->use_count) {
+		tmp = readl_relaxed(spics->base + spics->perip_cfg);
+		tmp &= ~(0x1 << spics->sw_enable_bit);
+		writel_relaxed(tmp, spics->base + spics->perip_cfg);
+	}
+}
+
+static int spics_gpio_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct spear_spics *spics;
+	struct resource *res;
+	int ret;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "invalid IORESOURCE_MEM\n");
+		return -EBUSY;
+	}
+
+	spics = devm_kzalloc(&pdev->dev, sizeof(*spics), GFP_KERNEL);
+	if (!spics) {
+		dev_err(&pdev->dev, "memory allocation fail\n");
+		return -ENOMEM;
+	}
+
+	spics->base = devm_request_and_ioremap(&pdev->dev, res);
+	if (!spics->base) {
+		dev_err(&pdev->dev, "request and ioremap fail\n");
+		return -ENOMEM;
+	}
+
+	if (of_property_read_u32(np, "st-spics,peripcfg-reg",
+				&spics->perip_cfg))
+		goto err_dt_data;
+	if (of_property_read_u32(np, "st-spics,sw-enable-bit",
+				&spics->sw_enable_bit))
+		goto err_dt_data;
+	if (of_property_read_u32(np, "st-spics,cs-value-bit",
+				&spics->cs_value_bit))
+		goto err_dt_data;
+	if (of_property_read_u32(np, "st-spics,cs-enable-mask",
+				&spics->cs_enable_mask))
+		goto err_dt_data;
+	if (of_property_read_u32(np, "st-spics,cs-enable-shift",
+				&spics->cs_enable_shift))
+		goto err_dt_data;
+
+	platform_set_drvdata(pdev, spics);
+
+	spics->chip.ngpio = NUM_OF_GPIO;
+	spics->chip.base = -1;
+	spics->chip.request = spics_request;
+	spics->chip.free = spics_free;
+	spics->chip.direction_input = spics_direction_input;
+	spics->chip.direction_output = spics_direction_output;
+	spics->chip.get = spics_get_value;
+	spics->chip.set = spics_set_value;
+	spics->chip.label = dev_name(&pdev->dev);
+	spics->chip.dev = &pdev->dev;
+	spics->chip.owner = THIS_MODULE;
+	spics->last_off = -1;
+
+	ret = gpiochip_add(&spics->chip);
+	if (ret) {
+		dev_err(&pdev->dev, "unable to add gpio chip\n");
+		return ret;
+	}
+
+	dev_info(&pdev->dev, "spear spics registered\n");
+	return 0;
+
+err_dt_data:
+	dev_err(&pdev->dev, "DT probe failed\n");
+	return -EINVAL;
+}
+
+static const struct of_device_id spics_gpio_of_match[] = {
+	{ .compatible = "st,spear-spics-gpio" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, spics_gpio_of_match);
+
+static struct platform_driver spics_gpio_driver = {
+	.probe = spics_gpio_probe,
+	.driver = {
+		.owner = THIS_MODULE,
+		.name = "spear-spics-gpio",
+		.of_match_table = spics_gpio_of_match,
+	},
+};
+
+static int __init spics_gpio_init(void)
+{
+	return platform_driver_register(&spics_gpio_driver);
+}
+subsys_initcall(spics_gpio_init);
+
+MODULE_AUTHOR("Shiraz Hashim <shiraz.hashim@st.com>");
+MODULE_DESCRIPTION("ST Microlectronics SPEAr SPI Chip Select Abstraction");
+MODULE_LICENSE("GPL");
-- 
1.7.12.rc2.18.g61b472e
