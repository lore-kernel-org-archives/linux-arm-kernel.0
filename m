From: cyrille.pitchen@atmel.com (Cyrille Pitchen)
Date: Tue, 2 Jun 2015 18:57:19 +0200
Subject: [PATCH v2 2/2] clk: at91: add Flexcom clock
In-Reply-To: <cover.1433264017.git.cyrille.pitchen@atmel.com>
References: <cover.1433264017.git.cyrille.pitchen@atmel.com>
Message-ID: <62cb26952d0688c6f37ad84d253d5302818a20ae.1433264017.git.cyrille.pitchen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver supports the new Atmel Flexcom. The Flexcom is a wrapper which
integrates one SPI controller, one I2C controller and one USART. Only one
function can be enabled at a time. This driver selects the function once for
all, when the Flexcom is probed, according to the value of the new
"atmel,flexcom-mode" device tree property.

This driver has chosen to present the Flexcom to the system as a clock so the
implementation is seamless for the existing Atmel SPI, I2C and USART drivers.

Also the Flexcom embeds FIFOs: the latest patches of the SPI, I2C and USART
drivers take advantage of this new feature.

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
---
 arch/arm/mach-at91/Kconfig     |   3 +
 drivers/clk/at91/Makefile      |   1 +
 drivers/clk/at91/clk-flexcom.c | 160 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 164 insertions(+)
 create mode 100644 drivers/clk/at91/clk-flexcom.c

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index fd95f34..8ce9b73 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -90,6 +90,9 @@ config HAVE_AT91_SMD
 config HAVE_AT91_H32MX
 	bool
 
+config HAVE_AT91_FLEXCOM
+	bool
+
 config SOC_SAM_V4_V5
 	bool
 
diff --git a/drivers/clk/at91/Makefile b/drivers/clk/at91/Makefile
index 89a48a7..74711b8 100644
--- a/drivers/clk/at91/Makefile
+++ b/drivers/clk/at91/Makefile
@@ -10,3 +10,4 @@ obj-$(CONFIG_HAVE_AT91_UTMI)		+= clk-utmi.o
 obj-$(CONFIG_HAVE_AT91_USB_CLK)		+= clk-usb.o
 obj-$(CONFIG_HAVE_AT91_SMD)		+= clk-smd.o
 obj-$(CONFIG_HAVE_AT91_H32MX)		+= clk-h32mx.o
+obj-$(CONFIG_HAVE_AT91_FLEXCOM)		+= clk-flexcom.o
diff --git a/drivers/clk/at91/clk-flexcom.c b/drivers/clk/at91/clk-flexcom.c
new file mode 100644
index 0000000..ce39093
--- /dev/null
+++ b/drivers/clk/at91/clk-flexcom.c
@@ -0,0 +1,160 @@
+/*
+ * Driver for Atmel AT91 Flexcom
+ *
+ * Copyright (C) 2014 Atmel Corporation
+ *
+ * Author: Cyrille Pitchen <cyrille.pitchen@atmel.com>
+ *
+ * Based on drivers/clk/clk-axi-clkgen.c
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ */
+
+#include <linux/platform_device.h>
+#include <linux/clk-provider.h>
+#include <linux/of.h>
+#include <linux/module.h>
+
+
+#define FX_MR		0x0
+#define FX_RHR		0x10
+#define FX_THR		0x20
+#define FX_VERSION	0xfc
+
+#define FX_MR_NO_COM	0
+#define FX_MR_USART	1
+#define FX_MR_SPI	2
+#define FX_MR_TWI	3
+
+struct clk_flexcom {
+	struct clk_hw	hw;
+	struct device	*dev;
+	u8 __iomem	*base;
+	u32		mr;
+	bool		show_once;
+};
+
+#define to_clk_flexcom(_hw)	container_of(_hw, struct clk_flexcom, hw)
+
+
+static int at91_flexcom_enable(struct clk_hw *hw)
+{
+	struct clk_flexcom *dev = to_clk_flexcom(hw);
+	u32 version;
+
+	if (!dev->show_once) {
+		dev->show_once = true;
+		version = __raw_readl(dev->base + FX_VERSION);
+		dev_info(dev->dev, "version: %#x\n", version);
+	}
+
+	__raw_writel(dev->mr, dev->base + FX_MR);
+	return 0;
+}
+
+static void at91_flexcom_disable(struct clk_hw *hw)
+{
+	struct clk_flexcom *dev = to_clk_flexcom(hw);
+
+	__raw_writel(FX_MR_NO_COM, dev->base + FX_MR);
+}
+
+static const struct clk_ops at91_flexcom_ops = {
+	.enable = at91_flexcom_enable,
+	.disable = at91_flexcom_disable,
+};
+
+static int at91_flexcom_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct clk_flexcom *dev;
+	struct resource *mem;
+	const char *parent_name, *clk_name, *mode;
+	struct clk *clk;
+	struct clk_init_data init;
+	u32 mr = FX_MR_NO_COM;
+	int err;
+
+	if (!np)
+		return -ENODEV;
+
+	err = of_property_read_string(np, "atmel,flexcom-mode", &mode);
+	if (err)
+		return err;
+
+	if (!strcmp(mode, "usart"))
+		mr = FX_MR_USART;
+	else if (!strcmp(mode, "spi"))
+		mr = FX_MR_SPI;
+	else if (!strcmp(mode, "twi") || !strcmp(mode, "i2c"))
+		mr = FX_MR_TWI;
+	else
+		return -EINVAL;
+
+	dev = devm_kzalloc(&pdev->dev, sizeof(*dev), GFP_KERNEL);
+	if (!dev)
+		return -ENOMEM;
+
+	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	dev->base = devm_ioremap_resource(&pdev->dev, mem);
+	if (IS_ERR(dev->base))
+		return PTR_ERR(dev->base);
+
+	parent_name = of_clk_get_parent_name(np, 0);
+	if (!parent_name)
+		return -EINVAL;
+
+	clk_name = np->name;
+	of_property_read_string(np, "clock-output-names", &clk_name);
+
+	init.name = clk_name;
+	init.ops = &at91_flexcom_ops;
+	init.flags = 0;
+	init.parent_names = &parent_name;
+	init.num_parents = 1;
+
+	dev->hw.init = &init;
+	dev->dev = &pdev->dev;
+	dev->mr = mr;
+	platform_set_drvdata(pdev, dev);
+
+	clk = devm_clk_register(&pdev->dev, &dev->hw);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	return of_clk_add_provider(np, of_clk_src_simple_get, clk);
+}
+
+static int at91_flexcom_remove(struct platform_device *pdev)
+{
+	of_clk_del_provider(pdev->dev.of_node);
+
+	return 0;
+}
+
+static const struct of_device_id at91_flexcom_dt_ids[] = {
+	{ .compatible = "atmel,sama5d2-flexcom" },
+	{ /* sentinel */ }
+};
+
+MODULE_DEVICE_TABLE(of, at91_flexcom_dt_ids);
+
+static struct platform_driver at91_flexcom_driver = {
+	.driver		= {
+		.name	= "at91_flexcom",
+		.of_match_table = of_match_ptr(at91_flexcom_dt_ids),
+	},
+	.probe		= at91_flexcom_probe,
+	.remove		= at91_flexcom_remove,
+};
+module_platform_driver(at91_flexcom_driver);
+
+MODULE_ALIAS("platform:at91_flexcom");
+MODULE_DESCRIPTION("Atmel AT91 Flexcom driver");
+MODULE_AUTHOR("Cyrille Pitchen <cyrille.pitchen@atmel.com>");
+MODULE_LICENSE("GPL v2");
+
-- 
1.8.2.2
