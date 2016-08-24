From: mirza.krak@gmail.com (Mirza Krak)
Date: Wed, 24 Aug 2016 15:37:18 +0200
Subject: [PATCH v2 6/6] bus: Add support for Tegra Generic Memory Interface
In-Reply-To: <1472045838-22628-1-git-send-email-mirza.krak@gmail.com>
References: <1472045838-22628-1-git-send-email-mirza.krak@gmail.com>
Message-ID: <1472045838-22628-7-git-send-email-mirza.krak@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mirza Krak <mirza.krak@gmail.com>

The Generic Memory Interface bus can be used to connect high-speed
devices such as NOR flash, FPGAs, DSPs...

Signed-off-by: Mirza Krak <mirza.krak@gmail.com>
---
Changes in v2:
- Fixed some checkpatch errors
- Re-ordered probe to get rid of local variables
- Moved of_platform_default_populate call to the end of probe
- Use the timing and configuration properties from the child device
- Added warning if more then 1 child device exist


 drivers/bus/Kconfig     |   8 ++
 drivers/bus/Makefile    |   1 +
 drivers/bus/tegra-gmi.c | 231 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 240 insertions(+)
 create mode 100644 drivers/bus/tegra-gmi.c

diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
index 4ed7d26..2e75a7f 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -141,6 +141,14 @@ config TEGRA_ACONNECT
 	  Driver for the Tegra ACONNECT bus which is used to interface with
 	  the devices inside the Audio Processing Engine (APE) for Tegra210.

+config TEGRA_GMI
+	tristate "Tegra Generic Memory Interface bus driver"
+	depends on ARCH_TEGRA
+	help
+	  Driver for the Tegra Generic Memory Interface bus which can be used
+	  to attach devices such as NOR, UART, FPGA and more.
+
+
 config UNIPHIER_SYSTEM_BUS
 	tristate "UniPhier System Bus driver"
 	depends on ARCH_UNIPHIER && OF
diff --git a/drivers/bus/Makefile b/drivers/bus/Makefile
index ac84cc4..34e2bab 100644
--- a/drivers/bus/Makefile
+++ b/drivers/bus/Makefile
@@ -18,5 +18,6 @@ obj-$(CONFIG_OMAP_OCP2SCP)	+= omap-ocp2scp.o
 obj-$(CONFIG_SUNXI_RSB)		+= sunxi-rsb.o
 obj-$(CONFIG_SIMPLE_PM_BUS)	+= simple-pm-bus.o
 obj-$(CONFIG_TEGRA_ACONNECT)	+= tegra-aconnect.o
+obj-$(CONFIG_TEGRA_GMI)		+= tegra-gmi.o
 obj-$(CONFIG_UNIPHIER_SYSTEM_BUS)	+= uniphier-system-bus.o
 obj-$(CONFIG_VEXPRESS_CONFIG)	+= vexpress-config.o
diff --git a/drivers/bus/tegra-gmi.c b/drivers/bus/tegra-gmi.c
new file mode 100644
index 0000000..b068ef9
--- /dev/null
+++ b/drivers/bus/tegra-gmi.c
@@ -0,0 +1,231 @@
+/*
+ * Driver for NVIDIA Generic Memory Interface
+ *
+ * Copyright (C) 2016 Host Mobility AB. All rights reserved.
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/reset.h>
+
+#define TEGRA_GMI_CONFIG		0x00
+#define TEGRA_GMI_CONFIG_GO		BIT(31)
+#define TEGRA_GMI_BUS_WIDTH_32BIT	BIT(30)
+#define TEGRA_GMI_MUX_MODE		BIT(28)
+#define TEGRA_GMI_RDY_BEFORE_DATA	BIT(24)
+#define TEGRA_GMI_RDY_ACTIVE_HIGH	BIT(23)
+#define TEGRA_GMI_ADV_ACTIVE_HIGH	BIT(22)
+#define TEGRA_GMI_OE_ACTIVE_HIGH	BIT(21)
+#define TEGRA_GMI_CS_ACTIVE_HIGH	BIT(20)
+#define TEGRA_GMI_CS_SELECT(x)		((x & 0x7) << 4)
+
+#define TEGRA_GMI_TIMING0		0x10
+#define TEGRA_GMI_MUXED_WIDTH(x)	((x & 0xf) << 12)
+#define TEGRA_GMI_HOLD_WIDTH(x)		((x & 0xf) << 8)
+#define TEGRA_GMI_ADV_WIDTH(x)		((x & 0xf) << 4)
+#define TEGRA_GMI_CE_WIDTH(x)		(x & 0xf)
+
+#define TEGRA_GMI_TIMING1		0x14
+#define TEGRA_GMI_WE_WIDTH(x)		((x & 0xff) << 16)
+#define TEGRA_GMI_OE_WIDTH(x)		((x & 0xff) << 8)
+#define TEGRA_GMI_WAIT_WIDTH(x)		(x & 0xff)
+
+struct tegra_gmi_priv {
+	void __iomem *base;
+	struct reset_control *rst;
+	struct clk *clk;
+
+	u32 snor_config;
+	u32 snor_timing0;
+	u32 snor_timing1;
+};
+
+static void tegra_gmi_init(struct device *dev, struct tegra_gmi_priv *priv)
+{
+	writel(priv->snor_timing0, priv->base + TEGRA_GMI_TIMING0);
+	writel(priv->snor_timing1, priv->base + TEGRA_GMI_TIMING1);
+
+	priv->snor_config |= TEGRA_GMI_CONFIG_GO;
+	writel(priv->snor_config, priv->base + TEGRA_GMI_CONFIG);
+}
+
+static void tegra_gmi_parse_dt(struct device *dev, struct tegra_gmi_priv *priv)
+{
+	struct device_node *child = of_get_next_available_child(dev->of_node,
+		NULL);
+	u32 property;
+
+	if (!child) {
+		dev_warn(dev, "no child nodes found\n");
+		return;
+	}
+
+	/*
+	 * We currently only support one child device due to lack of
+	 * chip-select address decoding. Which means that we only have one
+	 * chip-select line from the GMI controller.
+	 */
+	if (of_get_child_count(dev->of_node) > 1)
+		dev_warn(dev, "only one child device is supported.");
+
+	if (of_property_read_bool(child, "nvidia,snor-data-width-32bit"))
+		priv->snor_config |= TEGRA_GMI_BUS_WIDTH_32BIT;
+
+	if (of_property_read_bool(child, "nvidia,snor-mux-mode"))
+		priv->snor_config |= TEGRA_GMI_MUX_MODE;
+
+	if (of_property_read_bool(child, "nvidia,snor-rdy-active-before-data"))
+		priv->snor_config |= TEGRA_GMI_RDY_BEFORE_DATA;
+
+	if (of_property_read_bool(child, "nvidia,snor-rdy-inv"))
+		priv->snor_config |= TEGRA_GMI_RDY_ACTIVE_HIGH;
+
+	if (of_property_read_bool(child, "nvidia,snor-adv-inv"))
+		priv->snor_config |= TEGRA_GMI_ADV_ACTIVE_HIGH;
+
+	if (of_property_read_bool(child, "nvidia,snor-oe-inv"))
+		priv->snor_config |= TEGRA_GMI_OE_ACTIVE_HIGH;
+
+	if (of_property_read_bool(child, "nvidia,snor-cs-inv"))
+		priv->snor_config |= TEGRA_GMI_CS_ACTIVE_HIGH;
+
+	/* Use the reg property to determine which CS is to be used. */
+	if (!of_property_read_u32(child, "reg", &property))
+		priv->snor_config |= TEGRA_GMI_CS_SELECT(property);
+
+	/* The default values that are provided below are reset values */
+	if (!of_property_read_u32(child, "nvidia,snor-muxed-width", &property))
+		priv->snor_timing0 |= TEGRA_GMI_MUXED_WIDTH(property);
+	else
+		priv->snor_timing0 |= TEGRA_GMI_MUXED_WIDTH(1);
+
+	if (!of_property_read_u32(child, "nvidia,snor-hold-width", &property))
+		priv->snor_timing0 |= TEGRA_GMI_HOLD_WIDTH(property);
+	else
+		priv->snor_timing0 |= TEGRA_GMI_HOLD_WIDTH(1);
+
+	if (!of_property_read_u32(child, "nvidia,snor-adv-width", &property))
+		priv->snor_timing0 |= TEGRA_GMI_ADV_WIDTH(property);
+	else
+		priv->snor_timing0 |= TEGRA_GMI_ADV_WIDTH(1);
+
+	if (!of_property_read_u32(child, "nvidia,snor-ce-width", &property))
+		priv->snor_timing0 |= TEGRA_GMI_CE_WIDTH(property);
+	else
+		priv->snor_timing0 |= TEGRA_GMI_CE_WIDTH(4);
+
+	if (!of_property_read_u32(child, "nvidia,snor-we-width", &property))
+		priv->snor_timing1 |= TEGRA_GMI_WE_WIDTH(property);
+	else
+		priv->snor_timing1 |= TEGRA_GMI_WE_WIDTH(1);
+
+	if (!of_property_read_u32(child, "nvidia,snor-oe-width", &property))
+		priv->snor_timing1 |= TEGRA_GMI_OE_WIDTH(property);
+	else
+		priv->snor_timing1 |= TEGRA_GMI_OE_WIDTH(1);
+
+	if (!of_property_read_u32(child, "nvidia,snor-wait-width", &property))
+		priv->snor_timing1 |= TEGRA_GMI_WAIT_WIDTH(property);
+	else
+		priv->snor_timing1 |= TEGRA_GMI_WAIT_WIDTH(3);
+
+	of_node_put(child);
+}
+
+static int tegra_gmi_probe(struct platform_device *pdev)
+{
+	struct resource *res;
+	struct device *dev = &pdev->dev;
+	struct tegra_gmi_priv *priv;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	priv->base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+
+	priv->clk = devm_clk_get(dev, "gmi");
+	if (IS_ERR(priv->clk)) {
+		dev_err(dev, "can not get clock\n");
+		return PTR_ERR(priv->clk);
+	}
+
+	priv->rst = devm_reset_control_get(dev, "gmi");
+	if (IS_ERR(priv->rst)) {
+		dev_err(dev, "can not get reset\n");
+		return PTR_ERR(priv->rst);
+	}
+
+	ret = clk_prepare_enable(priv->clk);
+	if (ret) {
+		dev_err(dev, "fail to enable clock.\n");
+		return ret;
+	}
+
+	reset_control_assert(priv->rst);
+	udelay(2);
+	reset_control_deassert(priv->rst);
+
+	tegra_gmi_parse_dt(dev, priv);
+	tegra_gmi_init(dev, priv);
+
+	ret = of_platform_default_populate(dev->of_node, NULL, dev);
+	if (ret < 0) {
+		dev_err(dev, "fail to create devices.\n");
+		clk_disable_unprepare(priv->clk);
+		reset_control_assert(priv->rst);
+		return ret;
+	}
+
+	dev_set_drvdata(dev, priv);
+
+	return 0;
+}
+
+static int tegra_gmi_remove(struct platform_device *pdev)
+{
+	struct tegra_gmi_priv *priv = dev_get_drvdata(&pdev->dev);
+	u32 config;
+
+	of_platform_depopulate(&pdev->dev);
+
+	config = readl(priv->base + TEGRA_GMI_CONFIG);
+	config &= ~TEGRA_GMI_CONFIG_GO;
+	writel(config, priv->base + TEGRA_GMI_CONFIG);
+
+	clk_disable_unprepare(priv->clk);
+	reset_control_assert(priv->rst);
+
+	return 0;
+}
+
+static const struct of_device_id tegra_gmi_id_table[] = {
+	{ .compatible = "nvidia,tegra20-gmi", },
+	{ .compatible = "nvidia,tegra30-gmi", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, tegra_gmi_id_table);
+
+static struct platform_driver tegra_gmi_driver = {
+	.probe = tegra_gmi_probe,
+	.remove = tegra_gmi_remove,
+	.driver = {
+		.name		= "tegra-gmi",
+		.of_match_table	= tegra_gmi_id_table,
+	},
+};
+module_platform_driver(tegra_gmi_driver);
+
+MODULE_AUTHOR("Mirza Krak <mirza.krak@gmail.com");
+MODULE_DESCRIPTION("NVIDIA Tegra GMI Bus Driver");
+MODULE_LICENSE("GPL v2");
--
2.1.4
