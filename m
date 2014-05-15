From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Thu, 15 May 2014 10:55:09 +0200
Subject: [PATCH v5 1/5] mfd: add support for sun6i PRCM (Power/Reset/Clock
 Management) unit
In-Reply-To: <1400144113-27659-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1400144113-27659-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1400144113-27659-2-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PRCM (Power/Reset/Clock Management) block exposes several subdevices
in different subsystems (clk, reset ...)

Add basic support for the PRCM unit with clk (AR100, AHB0, and APB0 clks)
and reset controller subdevices.

Other subdevices might be added later (if needed).

Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Acked-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/Kconfig      |   8 +++
 drivers/mfd/Makefile     |   1 +
 drivers/mfd/sun6i-prcm.c | 134 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 143 insertions(+)
 create mode 100644 drivers/mfd/sun6i-prcm.c

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 6c2a920..34d246f 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -731,6 +731,14 @@ config MFD_STA2X11
 	select MFD_CORE
 	select REGMAP_MMIO
 
+config MFD_SUN6I_PRCM
+	bool "Allwinner A31 PRCM controller"
+	depends on ARCH_SUNXI
+	select MFD_CORE
+	help
+	  Support for the PRCM (Power/Reset/Clock Management) unit available
+	  in A31 SoC.
+
 config MFD_SYSCON
 	bool "System Controller Register R/W Based on Regmap"
 	select REGMAP_MMIO
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 1efecf2..df7823c 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -29,6 +29,7 @@ obj-$(CONFIG_MFD_STA2X11)	+= sta2x11-mfd.o
 obj-$(CONFIG_MFD_STMPE)		+= stmpe.o
 obj-$(CONFIG_STMPE_I2C)		+= stmpe-i2c.o
 obj-$(CONFIG_STMPE_SPI)		+= stmpe-spi.o
+obj-$(CONFIG_MFD_SUN6I_PRCM)	+= sun6i-prcm.o
 obj-$(CONFIG_MFD_TC3589X)	+= tc3589x.o
 obj-$(CONFIG_MFD_T7L66XB)	+= t7l66xb.o tmio_core.o
 obj-$(CONFIG_MFD_TC6387XB)	+= tc6387xb.o tmio_core.o
diff --git a/drivers/mfd/sun6i-prcm.c b/drivers/mfd/sun6i-prcm.c
new file mode 100644
index 0000000..718fc4d
--- /dev/null
+++ b/drivers/mfd/sun6i-prcm.c
@@ -0,0 +1,134 @@
+/*
+ * Copyright (C) 2014 Free Electrons
+ *
+ * License Terms: GNU General Public License v2
+ * Author: Boris BREZILLON <boris.brezillon@free-electrons.com>
+ *
+ * Allwinner PRCM (Power/Reset/Clock Management) driver
+ *
+ */
+
+#include <linux/mfd/core.h>
+#include <linux/module.h>
+#include <linux/of.h>
+
+struct prcm_data {
+	int nsubdevs;
+	const struct mfd_cell *subdevs;
+};
+
+static const struct resource sun6i_a31_ar100_clk_res[] = {
+	{
+		.start = 0x0,
+		.end = 0x3,
+		.flags = IORESOURCE_MEM,
+	},
+};
+
+static const struct resource sun6i_a31_apb0_clk_res[] = {
+	{
+		.start = 0xc,
+		.end = 0xf,
+		.flags = IORESOURCE_MEM,
+	},
+};
+
+static const struct resource sun6i_a31_apb0_gates_clk_res[] = {
+	{
+		.start = 0x28,
+		.end = 0x2b,
+		.flags = IORESOURCE_MEM,
+	},
+};
+
+static const struct resource sun6i_a31_apb0_rstc_res[] = {
+	{
+		.start = 0xb0,
+		.end = 0xb3,
+		.flags = IORESOURCE_MEM,
+	},
+};
+
+static const struct mfd_cell sun6i_a31_prcm_subdevs[] = {
+	{
+		.name = "sun6i-a31-ar100-clk",
+		.of_compatible = "allwinner,sun6i-a31-ar100-clk",
+		.num_resources = ARRAY_SIZE(sun6i_a31_ar100_clk_res),
+		.resources = sun6i_a31_ar100_clk_res,
+	},
+	{
+		.name = "sun6i-a31-apb0-clk",
+		.of_compatible = "allwinner,sun6i-a31-apb0-clk",
+		.num_resources = ARRAY_SIZE(sun6i_a31_apb0_clk_res),
+		.resources = sun6i_a31_apb0_clk_res,
+	},
+	{
+		.name = "sun6i-a31-apb0-gates-clk",
+		.of_compatible = "allwinner,sun6i-a31-apb0-gates-clk",
+		.num_resources = ARRAY_SIZE(sun6i_a31_apb0_gates_clk_res),
+		.resources = sun6i_a31_apb0_gates_clk_res,
+	},
+	{
+		.name = "sun6i-a31-apb0-clock-reset",
+		.of_compatible = "allwinner,sun6i-a31-clock-reset",
+		.num_resources = ARRAY_SIZE(sun6i_a31_apb0_rstc_res),
+		.resources = sun6i_a31_apb0_rstc_res,
+	},
+};
+
+static const struct prcm_data sun6i_a31_prcm_data = {
+	.nsubdevs = ARRAY_SIZE(sun6i_a31_prcm_subdevs),
+	.subdevs = sun6i_a31_prcm_subdevs,
+};
+
+static const struct of_device_id sun6i_prcm_dt_ids[] = {
+	{
+		.compatible = "allwinner,sun6i-a31-prcm",
+		.data = &sun6i_a31_prcm_data,
+	},
+	{ /* sentinel */ },
+};
+
+static int sun6i_prcm_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	const struct of_device_id *match;
+	const struct prcm_data *data;
+	struct resource *res;
+	int ret;
+
+	match = of_match_node(sun6i_prcm_dt_ids, np);
+	if (!match)
+		return -EINVAL;
+
+	data = match->data;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "no prcm memory region provided\n");
+		return -ENOENT;
+	}
+
+	ret = mfd_add_devices(&pdev->dev, 0, data->subdevs, data->nsubdevs,
+			      res, -1, NULL);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to add subdevices\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static struct platform_driver sun6i_prcm_driver = {
+	.driver = {
+		.name = "sun6i-prcm",
+		.owner = THIS_MODULE,
+		.of_match_table = sun6i_prcm_dt_ids,
+	},
+	.probe = sun6i_prcm_probe,
+};
+module_platform_driver(sun6i_prcm_driver);
+
+MODULE_AUTHOR("Boris BREZILLON <boris.brezillon@free-electrons.com>");
+MODULE_DESCRIPTION("Allwinner sun6i PRCM driver");
+MODULE_LICENSE("GPL v2");
-- 
1.8.3.2
