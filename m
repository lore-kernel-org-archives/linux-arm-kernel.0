From: mirza.krak@gmail.com (Mirza Krak)
Date: Tue, 19 Jul 2016 15:36:37 +0200
Subject: [RFC 6/6] bus: Add support for Tegra NOR controller
In-Reply-To: <1468935397-11926-1-git-send-email-mirza.krak@gmail.com>
References: <1468935397-11926-1-git-send-email-mirza.krak@gmail.com>
Message-ID: <1468935397-11926-7-git-send-email-mirza.krak@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mirza Krak <mirza.krak@gmail.com>

The NOR bus can be used to connect high-speed devices such as NOR flash,
FPGAs, DSPs, CAN chips, Wi-Fi chips etc.

Signed-off-by: Mirza Krak <mirza.krak@gmail.com>
---
 drivers/bus/Kconfig     |   7 +++
 drivers/bus/Makefile    |   1 +
 drivers/bus/tegra-nor.c | 118 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 126 insertions(+)
 create mode 100644 drivers/bus/tegra-nor.c

diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
index 3b205e2..b74be7d8 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -145,6 +145,13 @@ config TEGRA_ACONNECT
 	  Driver for the Tegra ACONNECT bus which is used to interface with
 	  the devices inside the Audio Processing Engine (APE) for Tegra210.

+config TEGRA_NOR
+	tristate "Nvidia Tegra NOR flash bus driver a.k.a GMI/SNOR"
+		depends on ARCH_TEGRA_2x_SOC || ARCH_TEGRA_3x_SOC
+		depends on OF
+		help
+			Driver for NOR flash bus found on Tegra30/20 SOC`s.
+
 config UNIPHIER_SYSTEM_BUS
 	tristate "UniPhier System Bus driver"
 	depends on ARCH_UNIPHIER && OF
diff --git a/drivers/bus/Makefile b/drivers/bus/Makefile
index ac84cc4..46d0129 100644
--- a/drivers/bus/Makefile
+++ b/drivers/bus/Makefile
@@ -18,5 +18,6 @@ obj-$(CONFIG_OMAP_OCP2SCP)	+= omap-ocp2scp.o
 obj-$(CONFIG_SUNXI_RSB)		+= sunxi-rsb.o
 obj-$(CONFIG_SIMPLE_PM_BUS)	+= simple-pm-bus.o
 obj-$(CONFIG_TEGRA_ACONNECT)	+= tegra-aconnect.o
+obj-$(CONFIG_TEGRA_NOR)		+= tegra-nor.o
 obj-$(CONFIG_UNIPHIER_SYSTEM_BUS)	+= uniphier-system-bus.o
 obj-$(CONFIG_VEXPRESS_CONFIG)	+= vexpress-config.o
diff --git a/drivers/bus/tegra-nor.c b/drivers/bus/tegra-nor.c
new file mode 100644
index 0000000..1e48113
--- /dev/null
+++ b/drivers/bus/tegra-nor.c
@@ -0,0 +1,118 @@
+/*
+ * Driver for Nvidia NOR Flash bus a.k.a SNOR/GMI.
+ *
+ * Copyright (C) 2016 Host Mobility AB. All rights reserved.
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/regmap.h>
+
+#define TEGRA_NOR_TIMING_REG_COUNT	2
+
+#define TEGRA_NOR_CONFIG			0x00
+#define TEGRA_NOR_STATUS			0x04
+#define TEGRA_NOR_ADDR_PTR			0x08
+#define TEGRA_NOR_AHB_ADDR_PTR		0x0c
+#define TEGRA_NOR_TIMING0			0x10
+#define TEGRA_NOR_TIMING1			0x14
+#define TEGRA_NOR_MIO_CONFIG		0x18
+#define TEGRA_NOR_MIO_TIMING		0x1c
+#define TEGRA_NOR_DMA_CONFIG		0x20
+#define TEGRA_NOR_CS_MUX_CONFIG		0x24
+
+#define TEGRA_NOR_CONFIG_GO				BIT(31)
+
+static const struct of_device_id nor_id_table[] = {
+	/* Tegra30 */
+	{ .compatible = "nvidia,tegra30-nor", .data = NULL, },
+	/* Tegra20 */
+	{ .compatible = "nvidia,tegra20-nor", .data = NULL, },
+
+	{ }
+};
+MODULE_DEVICE_TABLE(of, nor_id_table);
+
+
+static int __init nor_parse_dt(struct platform_device *pdev,
+				void __iomem *base)
+{
+	struct device_node *of_node = pdev->dev.of_node;
+	u32 config, timing[TEGRA_NOR_TIMING_REG_COUNT];
+	int ret;
+
+	ret = of_property_read_u32_array(of_node, "nvidia,cs-timing",
+					 timing, TEGRA_NOR_TIMING_REG_COUNT);
+	if (!ret) {
+		writel(timing[0], base + TEGRA_NOR_TIMING0);
+		writel(timing[1], base + TEGRA_NOR_TIMING1);
+	}
+
+	ret = of_property_read_u32(of_node, "nvidia,config", &config);
+	if (ret)
+		return ret;
+
+	config |= TEGRA_NOR_CONFIG_GO;
+	writel(config, base + TEGRA_NOR_CONFIG);
+
+	if (of_get_child_count(of_node))
+		ret = of_platform_populate(of_node,
+				   of_default_bus_match_table,
+				   NULL, &pdev->dev);
+
+	return ret;
+}
+
+static int __init nor_probe(struct platform_device *pdev)
+{
+	struct resource *res;
+	struct clk *clk;
+	void __iomem *base;
+	int ret;
+
+	/* get the resource */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	/* get the clock */
+	clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	ret = clk_prepare_enable(clk);
+	if (ret)
+		return ret;
+
+	/* parse the device node */
+	ret = nor_parse_dt(pdev, base);
+	if (ret) {
+		dev_err(&pdev->dev, "%s fail to create devices.\n",
+			pdev->dev.of_node->full_name);
+		clk_disable_unprepare(clk);
+		return ret;
+	}
+
+	dev_info(&pdev->dev, "Driver registered.\n");
+	return 0;
+}
+
+static struct platform_driver nor_driver = {
+	.driver = {
+		.name		= "tegra-nor",
+		.of_match_table	= nor_id_table,
+	},
+};
+module_platform_driver_probe(nor_driver, nor_probe);
+
+MODULE_AUTHOR("Mirza Krak <mirza.krak@gmail.com");
+MODULE_DESCRIPTION("NVIDIA Tegra NOR Bus Driver");
+MODULE_LICENSE("GPL");
--
2.1.4
