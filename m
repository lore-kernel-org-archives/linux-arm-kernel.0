From: ran.wang_1@nxp.com (Ran Wang)
Date: Tue, 7 Nov 2017 15:20:53 +0800
Subject: [PATCH v2 1/3] drivers: usb: phy: Add qoriq usb 3.0 phy driver support
Message-ID: <20171107072055.26945-1-ran.wang_1@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds qoriq usb 3.0 phy driver to implement erratum related workaround
for qoriq SoC.

Signed-off-by: Sriram Dash <sriram.dash@nxp.com>
Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
---
Change in v2:
	- Replace funciont __raw_writel() by iowrite32be()
	- Remove qoriq_usb3_phy_read() and qoriq_usb3_phy_write()
	- Remove USB3PRM1CR_VAL define, use numbers directly
	- Use C-style numeric constants on 32'h27672B2A in annotation
	- Add prefix 'static' to struct qoriq_usb3_phy_erratum

 .../devicetree/bindings/phy/phy-qoriq-usb3.txt     |  36 ++++
 drivers/phy/Kconfig                                |   9 +
 drivers/phy/Makefile                               |   1 +
 drivers/phy/phy-qoriq-usb3.c                       | 191 +++++++++++++++++++++
 4 files changed, 237 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-qoriq-usb3.txt
 create mode 100644 drivers/phy/phy-qoriq-usb3.c

diff --git a/Documentation/devicetree/bindings/phy/phy-qoriq-usb3.txt b/Documentation/devicetree/bindings/phy/phy-qoriq-usb3.txt
new file mode 100644
index 000000000000..d956f9c89fbf
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/phy-qoriq-usb3.txt
@@ -0,0 +1,36 @@
+Driver for Freescale USB 3.0 PHY
+
+Required properties:
+
+- compatible :	fsl,qoriq-usb3-phy
+- reg :		register mappings for Parameter Configuration Register
+		and Phy base offset.
+- reg-names :	"param_ctrl" and "phy_base"
+- phy_type :	For multi port host USB controllers, should be one of
+		"ulpi", or "serial". For dual role USB controllers,
+		should be one of "ulpi", "utmi", "utmi_wide", or "serial".
+
+Example:
+		usbphy0: usb-phy at 084F0000 {
+				compatible = "fsl,qoriq-usb3-phy";
+                reg = <0x0 0x01570070 0x0 0xC>, <0x0 0x084F0000 0x0 0x5000>;
+                reg-names = "param_ctrl", "phy_base";
+                #phy-cells = <0>;
+                phy_type = "utmi";
+		};
+
+        usbphy1: usb-phy at 08500000 {
+                compatible = "fsl,qoriq-usb3-phy";
+                reg = <0x0 0x0157007C 0x0 0xC>, <0x0 0x08500000 0x0 0x5000>;
+                reg-names = "param_ctrl", "phy_base";
+                #phy-cells = <0>;
+                phy_type = "utmi";
+        };
+
+        usbphy2: usb-phy at 08510000 {
+                compatible = "fsl,qoriq-usb3-phy";
+                reg = <0x0 0x01570088 0x0 0xC>, <0x0 0x08510000 0x0 0x5000>;
+                reg-names = "param_ctrl", "phy_base";
+                #phy-cells = <0>;
+                phy_type = "utmi";
+        };
diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index c1807d4a0079..077e6765d2df 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -41,6 +41,15 @@ config PHY_PISTACHIO_USB
 	help
 	  Enable this to support the USB2.0 PHY on the IMG Pistachio SoC.
 
+
+config PHY_QORIQ_USB3
+	tristate "Freescale QorIQ USB 3.0 PHY driver"
+	depends on ARCH_LAYERSCAPE
+	depends on OF
+	select GENERIC_PHY
+	help
+	  Enable this to support the USB3.0 PHY on the QorIQ SoC.
+
 config PHY_XGENE
 	tristate "APM X-Gene 15Gbps PHY support"
 	depends on HAS_IOMEM && OF && (ARM64 || COMPILE_TEST)
diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
index f252201e0ec9..94712e066cde 100644
--- a/drivers/phy/Makefile
+++ b/drivers/phy/Makefile
@@ -21,3 +21,4 @@ obj-y					+= broadcom/	\
 					   samsung/	\
 					   st/		\
 					   ti/
+obj-$(CONFIG_PHY_QORIQ_USB3)            += phy-qoriq-usb3.o
diff --git a/drivers/phy/phy-qoriq-usb3.c b/drivers/phy/phy-qoriq-usb3.c
new file mode 100644
index 000000000000..f9302fc59f05
--- /dev/null
+++ b/drivers/phy/phy-qoriq-usb3.c
@@ -0,0 +1,191 @@
+/*
+ * Freescale QorIQ USB3 phy driver
+ *
+ * Copyright 2016 Freescale Semiconductor, Inc.
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * Author: Sriram Dash <sriram.dash@nxp.com>
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/slab.h>
+#include <linux/phy/phy.h>
+#include <linux/usb/phy.h>
+#include <linux/delay.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/of_address.h>
+#include <linux/usb/of.h>
+#include <linux/regmap.h>
+
+
+/* Parameter control */
+#define USB3PRM1CR		0x000
+
+/*
+ * struct qoriq_usb3_phy - driver data for USB 3.0 PHY
+ * @dev: pointer to device instance of this platform device
+ * @param_ctrl: usb3 phy parameter control register base
+ * @phy_base: usb3 phy register memory base
+ * @has_erratum_flag: keeps track of erratum applicable on device
+ */
+struct qoriq_usb3_phy {
+	struct device *dev;
+	void __iomem *param_ctrl;
+	void __iomem *phy_base;
+	u32 has_erratum_flag;
+};
+
+/*
+ * Erratum A008751
+ * SCFG USB3PRM1CR has incorrect default value
+ * SCFG USB3PRM1CR reset value should be 0x27672B2A instead of 32'h25E72B2A.
+ */
+static void erratum_a008751(struct qoriq_usb3_phy *phy)
+{
+	iowrite32be(0x27672B2A, phy->param_ctrl + USB3PRM1CR);
+}
+
+/*
+ * qoriq_usb3_phy_erratum - List of phy erratum
+ * @qoriq_phy_erratum - erratum application
+ * @prop - string of property name for erratum
+ */
+
+struct qoriq_usb3_phy_erratum {
+	void (*qoriq_phy_erratum)(struct qoriq_usb3_phy *phy);
+	char *prop;
+};
+
+/* Erratum list */
+static struct qoriq_usb3_phy_erratum  phy_erratum_tbl[] = {
+	{erratum_a008751, "fsl,usb-erratum-a008751"},
+	/* Add init time erratum here */
+};
+
+static int qoriq_usb3_phy_init(struct phy *x)
+{
+	struct qoriq_usb3_phy *phy = phy_get_drvdata(x);
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(phy_erratum_tbl); i++)
+		if (phy->has_erratum_flag & 1 << i)
+			phy_erratum_tbl[i].qoriq_phy_erratum(phy);
+
+	return 0;
+}
+
+static const struct phy_ops ops = {
+	.init		= qoriq_usb3_phy_init,
+	.owner		= THIS_MODULE,
+};
+
+static int qoriq_usb3_phy_probe(struct platform_device *pdev)
+{
+	struct qoriq_usb3_phy *phy;
+	struct phy *generic_phy;
+	struct phy_provider *phy_provider;
+	const struct of_device_id *of_id;
+	struct device *dev = &pdev->dev;
+	struct resource *res;
+	int i, ret;
+
+	phy = devm_kzalloc(dev, sizeof(*phy), GFP_KERNEL);
+	if (!phy)
+		return -ENOMEM;
+	phy->dev = dev;
+
+	of_id = of_match_device(dev->driver->of_match_table, dev);
+	if (!of_id) {
+		dev_err(dev, "failed to get device match\n");
+		ret = -EINVAL;
+		goto err_out;
+	}
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "param_ctrl");
+	if (!res) {
+		dev_err(dev, "failed to get param_ctrl memory\n");
+		ret = -ENOENT;
+		goto err_out;
+	}
+
+	phy->param_ctrl = devm_ioremap_resource(dev, res);
+	if (!phy->param_ctrl) {
+		dev_err(dev, "failed to remap param_ctrl memory\n");
+		ret = -ENOMEM;
+		goto err_out;
+	}
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "phy_base");
+	if (!res) {
+		dev_err(dev, "failed to get phy_base memory\n");
+		ret = -ENOENT;
+		goto err_out;
+	}
+
+	phy->phy_base = devm_ioremap_resource(dev, res);
+	if (!phy->phy_base) {
+		dev_err(dev, "failed to remap phy_base memory\n");
+		ret = -ENOMEM;
+		goto err_out;
+	}
+
+	phy->has_erratum_flag = 0;
+	for (i = 0; i < ARRAY_SIZE(phy_erratum_tbl); i++) {
+		phy->has_erratum_flag |= device_property_read_bool(dev,
+						phy_erratum_tbl[i].prop) << i;
+	}
+
+	platform_set_drvdata(pdev, phy);
+
+	generic_phy = devm_phy_create(dev, NULL, &ops);
+	if (IS_ERR(generic_phy))
+		return PTR_ERR(generic_phy);
+
+	phy_set_drvdata(generic_phy, phy);
+
+	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+	if (IS_ERR(phy_provider))
+		return PTR_ERR(phy_provider);
+
+	return 0;
+err_out:
+	return ret;
+}
+
+static const struct of_device_id qoriq_usb3_phy_dt_ids[] = {
+	{
+		.compatible = "fsl,qoriq-usb3-phy"
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(of, qoriq_usb3_phy_dt_ids);
+
+static struct platform_driver qoriq_usb3_phy_driver = {
+	.probe		= qoriq_usb3_phy_probe,
+	.driver		= {
+		.name	= "qoriq_usb3_phy",
+		.of_match_table = qoriq_usb3_phy_dt_ids,
+	},
+};
+
+module_platform_driver(qoriq_usb3_phy_driver);
+
+MODULE_ALIAS("platform:qoriq_usb3_phy");
+MODULE_AUTHOR("Sriram Dash <sriram.dash@nxp.com>");
+MODULE_DESCRIPTION("Freescale QorIQ USB3 phy driver");
+MODULE_LICENSE("GPL v2");
-- 
2.14.1
