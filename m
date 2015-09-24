From: cyrille.pitchen@atmel.com (Cyrille Pitchen)
Date: Thu, 24 Sep 2015 11:35:58 +0200
Subject: [PATCH linux-next v10 3/3] mfd: atmel-flexcom: add a driver for Atmel
 Flexible Serial Communication Unit
In-Reply-To: <cover.1443087121.git.cyrille.pitchen@atmel.com>
References: <cover.1443087121.git.cyrille.pitchen@atmel.com>
Message-ID: <9e56620924e3f0485561215f9631bbd1c36379fc.1443087121.git.cyrille.pitchen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver supports the new Atmel Flexcom. The Flexcom is a wrapper which
integrates one SPI controller, one I2C controller and one USART. Only one
function can be enabled at a time. This driver selects the function once
for all, when the Flexcom is probed, according to the value of the new
"atmel,flexcom-mode" device tree property.

This driver has chosen to present the Flexcom to the system as a MFD so
the implementation is seamless for the existing Atmel SPI, I2C and USART
drivers.

Also the Flexcom embeds FIFOs: the latest patches of the SPI, I2C and
USART drivers take advantage of this new feature.

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/mfd/Kconfig         |  11 +++++
 drivers/mfd/Makefile        |   1 +
 drivers/mfd/atmel-flexcom.c | 104 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 116 insertions(+)
 create mode 100644 drivers/mfd/atmel-flexcom.c

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 99d63675f073..87e84e7c71da 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -60,6 +60,17 @@ config MFD_AAT2870_CORE
 	  additional drivers must be enabled in order to use the
 	  functionality of the device.
 
+config MFD_ATMEL_FLEXCOM
+	tristate "Atmel Flexcom (Flexible Serial Communication Unit)"
+	select MFD_CORE
+	depends on OF
+	help
+	  Select this to get support for Atmel Flexcom. This is a wrapper
+	  which embeds a SPI controller, a I2C controller and a USART. Only
+	  one function can be used at a time. The choice is done at boot time
+	  by the probe function of this MFD driver according to a device tree
+	  property.
+
 config MFD_ATMEL_HLCDC
 	tristate "Atmel HLCDC (High-end LCD Controller)"
 	select MFD_CORE
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index d6c21e3c409f..a8b76b81b467 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -164,6 +164,7 @@ obj-$(CONFIG_MFD_SPMI_PMIC)	+= qcom-spmi-pmic.o
 obj-$(CONFIG_TPS65911_COMPARATOR)	+= tps65911-comparator.o
 obj-$(CONFIG_MFD_TPS65090)	+= tps65090.o
 obj-$(CONFIG_MFD_AAT2870_CORE)	+= aat2870-core.o
+obj-$(CONFIG_MFD_ATMEL_FLEXCOM)	+= atmel-flexcom.o
 obj-$(CONFIG_MFD_ATMEL_HLCDC)	+= atmel-hlcdc.o
 obj-$(CONFIG_MFD_INTEL_LPSS)	+= intel-lpss.o
 obj-$(CONFIG_MFD_INTEL_LPSS_PCI)	+= intel-lpss-pci.o
diff --git a/drivers/mfd/atmel-flexcom.c b/drivers/mfd/atmel-flexcom.c
new file mode 100644
index 000000000000..e8e67be6b493
--- /dev/null
+++ b/drivers/mfd/atmel-flexcom.c
@@ -0,0 +1,104 @@
+/*
+ * Driver for Atmel Flexcom
+ *
+ * Copyright (C) 2015 Atmel Corporation
+ *
+ * Author: Cyrille Pitchen <cyrille.pitchen@atmel.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/clk.h>
+#include <dt-bindings/mfd/atmel-flexcom.h>
+
+/* I/O register offsets */
+#define FLEX_MR		0x0	/* Mode Register */
+#define FLEX_VERSION	0xfc	/* Version Register */
+
+/* Mode Register bit fields */
+#define FLEX_MR_OPMODE_OFFSET	(0)  /* Operating Mode */
+#define FLEX_MR_OPMODE_MASK	(0x3 << FLEX_MR_OPMODE_OFFSET)
+#define FLEX_MR_OPMODE(opmode)	(((opmode) << FLEX_MR_OPMODE_OFFSET) &	\
+				 FLEX_MR_OPMODE_MASK)
+
+
+static int atmel_flexcom_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct clk *clk;
+	struct resource *res;
+	void __iomem *base;
+	u32 opmode;
+	int err;
+
+	err = of_property_read_u32(np, "atmel,flexcom-mode", &opmode);
+	if (err)
+		return err;
+
+	if (opmode < ATMEL_FLEXCOM_MODE_USART ||
+	    opmode > ATMEL_FLEXCOM_MODE_TWI)
+		return -EINVAL;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	err = clk_prepare_enable(clk);
+	if (err)
+		return err;
+
+	/*
+	 * Set the Operating Mode in the Mode Register: only the selected device
+	 * is clocked. Hence, registers of the other serial devices remain
+	 * inaccessible and are read as zero. Also the external I/O lines of the
+	 * Flexcom are muxed to reach the selected device.
+	 */
+	writel(FLEX_MR_OPMODE(opmode), base + FLEX_MR);
+
+	clk_disable_unprepare(clk);
+
+	return of_platform_populate(np, NULL, NULL, &pdev->dev);
+}
+
+static const struct of_device_id atmel_flexcom_of_match[] = {
+	{ .compatible = "atmel,sama5d2-flexcom" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, atmel_flexcom_of_match);
+
+static struct platform_driver atmel_flexcom_driver = {
+	.probe	= atmel_flexcom_probe,
+	.driver	= {
+		.name		= "atmel_flexcom",
+		.of_match_table	= atmel_flexcom_of_match,
+	},
+};
+
+module_platform_driver(atmel_flexcom_driver);
+
+MODULE_AUTHOR("Cyrille Pitchen <cyrille.pitchen@atmel.com>");
+MODULE_DESCRIPTION("Atmel Flexcom MFD driver");
+MODULE_LICENSE("GPL v2");
-- 
1.8.2.2
