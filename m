From: shawnguo@kernel.org (Shawn Guo)
Date: Sun, 15 Oct 2017 12:48:02 +0800
Subject: [PATCH] phy: add combo phy driver for HiSilicon STB SoCs
Message-ID: <1508042882-20922-1-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jianguo Sun <sunjianguo1@huawei.com>

Add combo phy driver for HiSilicon STB SoCs. This phy can be
used as pcie-phy, sata-phy or usb-phy.

Signed-off-by: Jianguo Sun <sunjianguo1@huawei.com>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 .../bindings/phy/phy-hi3798cv200-combphy.txt       |  21 ++
 drivers/phy/Makefile                               |   1 +
 drivers/phy/hisilicon/Kconfig                      |   9 +
 drivers/phy/hisilicon/Makefile                     |   1 +
 drivers/phy/hisilicon/phy-histb-combphy.c          | 236 +++++++++++++++++++++
 5 files changed, 268 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-hi3798cv200-combphy.txt
 create mode 100644 drivers/phy/hisilicon/phy-histb-combphy.c

diff --git a/Documentation/devicetree/bindings/phy/phy-hi3798cv200-combphy.txt b/Documentation/devicetree/bindings/phy/phy-hi3798cv200-combphy.txt
new file mode 100644
index 000000000000..c7121cdcaed9
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/phy-hi3798cv200-combphy.txt
@@ -0,0 +1,21 @@
+HiSilicon STB PCIE/SATA/USB3 PHY
+
+Properties:
+- compatible: Should be "hisilicon,hi3798cv200-combphy"
+- #phy-cells: Should be 1.  The cell number is used to select the phy mode:
+	0: PCIe mode
+	1: USB 3.0 mode
+	2: SATA mode
+- clocks: The phandle to clock provider and clock specifier pair.
+- resets: The phandle to reset controller and reset specifier pair.
+- hisilicon,peripheral-syscon: The phandle to the peripheral controller.
+
+Example:
+
+combphy1: phy {
+	compatible = "hisilicon,hi3798cv200-combphy";
+	#phy-cells = <1>;
+	clocks = <&crg HISTB_COMBPHY1_CLK>;
+	resets = <&crg 0x188 12>;
+	hisilicon,peripheral-syscon = <&peri_ctrl>;
+};
diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
index 3a52dcb09566..11754b293fb4 100644
--- a/drivers/phy/Makefile
+++ b/drivers/phy/Makefile
@@ -6,6 +6,7 @@ obj-$(CONFIG_GENERIC_PHY)		+= phy-core.o
 obj-$(CONFIG_PHY_LPC18XX_USB_OTG)	+= phy-lpc18xx-usb-otg.o
 obj-$(CONFIG_PHY_XGENE)			+= phy-xgene.o
 obj-$(CONFIG_PHY_PISTACHIO_USB)		+= phy-pistachio-usb.o
+
 obj-$(CONFIG_ARCH_SUNXI)		+= allwinner/
 obj-$(CONFIG_ARCH_MESON)		+= amlogic/
 obj-$(CONFIG_LANTIQ)			+= lantiq/
diff --git a/drivers/phy/hisilicon/Kconfig b/drivers/phy/hisilicon/Kconfig
index 6164c4cd0f65..d9afe2b12827 100644
--- a/drivers/phy/hisilicon/Kconfig
+++ b/drivers/phy/hisilicon/Kconfig
@@ -11,6 +11,15 @@ config PHY_HI6220_USB
 
 	  To compile this driver as a module, choose M here.
 
+config PHY_HISTB_COMBPHY
+	tristate "HiSilicon STB SoCs COMBPHY support"
+	depends on (ARCH_HISI && ARM64) || COMPILE_TEST
+	select GENERIC_PHY
+	select MFD_SYSCON
+	help
+	  Enable this to support the HISILICON STB SoCs COMBPHY.
+	  If unsure, say N.
+
 config PHY_HIX5HD2_SATA
 	tristate "HIX5HD2 SATA PHY Driver"
 	depends on ARCH_HIX5HD2 && OF && HAS_IOMEM
diff --git a/drivers/phy/hisilicon/Makefile b/drivers/phy/hisilicon/Makefile
index 541b348187a8..5e8e2dfa8c37 100644
--- a/drivers/phy/hisilicon/Makefile
+++ b/drivers/phy/hisilicon/Makefile
@@ -1,2 +1,3 @@
 obj-$(CONFIG_PHY_HI6220_USB)		+= phy-hi6220-usb.o
+obj-$(CONFIG_PHY_HISTB_COMBPHY)		+= phy-histb-combphy.o
 obj-$(CONFIG_PHY_HIX5HD2_SATA)		+= phy-hix5hd2-sata.o
diff --git a/drivers/phy/hisilicon/phy-histb-combphy.c b/drivers/phy/hisilicon/phy-histb-combphy.c
new file mode 100644
index 000000000000..976338d1874b
--- /dev/null
+++ b/drivers/phy/hisilicon/phy-histb-combphy.c
@@ -0,0 +1,236 @@
+/*
+ * COMBPHY driver for HiSilicon STB SoCs
+ *
+ * Copyright (C) 2016-2017 HiSilicon Co., Ltd. http://www.hisilicon.com
+ *
+ * Authors: Jianguo Sun <sunjianguo1@huawei.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/phy/phy.h>
+#include <linux/regmap.h>
+#include <linux/reset.h>
+
+#define PERI_CTRL			0x0008
+#define PERI_COMBPHY1_CFG		0x0858
+
+#define COMBPHY1_MODE_MASK		GENMASK(12, 11)
+#define COMBPHY_MODE_SHIFT		11
+#define COMBPHY_MODE_PCIE		0
+#define COMBPHY_MODE_USB		1
+#define COMBPHY_MODE_SATA		2
+
+#define COMBPHY1_BYPASS_CODEC_MASK	BIT(31)
+#define COMBPHY1_BYPASS_CODEC_VAL	(1 << 31)
+
+#define COMBPHY1_SRST_REQ_MASK		BIT(12)
+#define COMBPHY1_SRST_REQ_VAL		(1 << 12)
+
+#define COMBPHY1_REFCLK_SEL_MASK	GENMASK(11, 10)
+#define COMBPHY1_REFCLK_SEL_VAL		(2 << 10)
+
+#define COMBPHY1_CLKREF_OUT_OEN_MASK	BIT(0)
+#define COMBPHY1_CLKREF_OUT_OEN_VAL	(1 << 0)
+
+#define NANO_TEST_WRITE			GENMASK(24, 24)
+#define NANO_TEST_DATA			GENMASK(23, 20)
+#define NANO_TEST_ADDR			GENMASK(16, 12)
+
+struct histb_combphy_priv {
+	u32 mode;
+	struct regmap *peri;
+	struct clk *ref;
+	struct phy *phy;
+	struct reset_control *por;
+};
+
+static void nano_register_write(struct regmap *peri, u32 addr,
+				u32 offset, u32 value)
+{
+	u32 val;
+	int ret;
+
+	ret = regmap_read(peri, addr, &val);
+	val &= ~NANO_TEST_ADDR;
+	val &= ~NANO_TEST_DATA;
+	val |= (offset << 12);
+	val |= (value << 20);
+	ret |= regmap_write(peri, addr, val);
+
+	ret = regmap_read(peri, addr, &val);
+	val &= ~NANO_TEST_WRITE;
+	ret |= regmap_write(peri, addr, val);
+
+	ret = regmap_read(peri, addr, &val);
+	val |= NANO_TEST_WRITE;
+	ret |= regmap_write(peri, addr, val);
+}
+
+static int histb_pcie_phy_init(struct histb_combphy_priv *priv)
+{
+	struct regmap *peri = priv->peri;
+	int ret;
+
+	/* set to pcie mode */
+	regmap_update_bits(peri, PERI_CTRL, COMBPHY1_MODE_MASK,
+			    COMBPHY_MODE_PCIE << COMBPHY_MODE_SHIFT);
+
+	regmap_update_bits(peri, PERI_COMBPHY1_CFG,
+			    COMBPHY1_BYPASS_CODEC_MASK,
+			    ~COMBPHY1_BYPASS_CODEC_VAL);
+
+	ret = clk_prepare_enable(priv->ref);
+	if (ret) {
+		dev_err(&priv->phy->dev, "clk_prepare_enable fail!\n");
+		return ret;
+	}
+
+	reset_control_deassert(priv->por);
+
+	regmap_update_bits(peri, PERI_COMBPHY1_CFG,
+			    COMBPHY1_CLKREF_OUT_OEN_MASK,
+			    COMBPHY1_CLKREF_OUT_OEN_VAL);
+
+	/* need to wait for EP clk stable */
+	mdelay(5);
+
+	nano_register_write(peri, PERI_COMBPHY1_CFG, 0x1, 0x8);
+	nano_register_write(peri, PERI_COMBPHY1_CFG, 0xc, 0x9);
+	nano_register_write(peri, PERI_COMBPHY1_CFG, 0x1a, 0x4);
+
+	return 0;
+}
+
+static int histb_pcie_phy_exit(struct histb_combphy_priv *priv)
+{
+	regmap_update_bits(priv->peri, PERI_COMBPHY1_CFG,
+				COMBPHY1_CLKREF_OUT_OEN_MASK,
+				~COMBPHY1_CLKREF_OUT_OEN_VAL);
+	reset_control_deassert(priv->por);
+	clk_disable_unprepare(priv->ref);
+
+	return 0;
+}
+
+static int histb_combphy_init(struct phy *phy)
+{
+	struct histb_combphy_priv *priv = phy_get_drvdata(phy);
+	int ret = -1;
+
+	if (priv->mode == COMBPHY_MODE_PCIE)
+		ret = histb_pcie_phy_init(priv);
+
+	return ret;
+}
+
+static int histb_combphy_exit(struct phy *phy)
+{
+	struct histb_combphy_priv *priv = phy_get_drvdata(phy);
+	int ret = 0;
+
+	if (priv->mode == COMBPHY_MODE_PCIE)
+		ret = histb_pcie_phy_exit(priv);
+
+	return ret;
+}
+
+static const struct phy_ops histb_combphy_ops = {
+	.init = histb_combphy_init,
+	.exit = histb_combphy_exit,
+	.owner = THIS_MODULE,
+};
+
+static struct phy *histb_combphy_xlate(struct device *dev,
+				       struct of_phandle_args *args)
+{
+	struct histb_combphy_priv *priv = dev_get_drvdata(dev);
+
+	if (args->args_count < 1) {
+		dev_err(dev, "DT did not pass correct no of args\n");
+		return ERR_PTR(-ENODEV);
+	}
+
+	priv->mode = args->args[0];
+
+	if (priv->mode > COMBPHY_MODE_SATA) {
+		dev_err(dev, "DT did not pass correct phy mode\n");
+		return ERR_PTR(-ENODEV);
+	}
+
+	return priv->phy;
+}
+
+static int histb_combphy_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct histb_combphy_priv *priv;
+	struct phy_provider *phy_provider;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->peri = syscon_regmap_lookup_by_phandle(dev->of_node,
+				"hisilicon,peripheral-syscon");
+	if (IS_ERR(priv->peri)) {
+		dev_err(dev, "failed to find peri_ctrl regmap\n");
+		return PTR_ERR(priv->peri);
+	}
+
+	priv->ref = devm_clk_get(dev, NULL);
+	if (IS_ERR(priv->ref)) {
+		dev_err(dev, "failed to find ref clk\n");
+		return PTR_ERR(priv->ref);
+	}
+
+	priv->por = devm_reset_control_get(dev, NULL);
+	if (IS_ERR(priv->por)) {
+		dev_err(dev, "failed to por reset\n");
+		return PTR_ERR(priv->por);
+	}
+
+	priv->phy = devm_phy_create(dev, NULL, &histb_combphy_ops);
+	if (IS_ERR(priv->phy)) {
+		dev_err(dev, "failed to create combphy\n");
+		return PTR_ERR(priv->phy);
+	}
+
+	dev_set_drvdata(dev, priv);
+	phy_set_drvdata(priv->phy, priv);
+
+	phy_provider = devm_of_phy_provider_register(dev, histb_combphy_xlate);
+	if (IS_ERR(phy_provider)) {
+		dev_err(dev, "failed to register phy provider\n");
+		return PTR_ERR(phy_provider);
+	}
+
+	return 0;
+}
+
+static const struct of_device_id histb_combphy_of_match[] = {
+	{ .compatible = "hisilicon,hi3798cv200-combphy" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, histb_combphy_of_match);
+
+static struct platform_driver histb_combphy_driver = {
+	.probe	= histb_combphy_probe,
+	.driver = {
+		.name = "combphy",
+		.of_match_table = histb_combphy_of_match,
+	},
+};
+module_platform_driver(histb_combphy_driver);
+
+MODULE_DESCRIPTION("HiSilicon STB COMBPHY driver");
+MODULE_LICENSE("GPL v2");
-- 
1.9.1
