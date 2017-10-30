From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 30 Oct 2017 23:15:57 +0800
Subject: [PATCH v5 3/3] phy: add combo phy driver for HiSilicon STB SoCs
In-Reply-To: <1509376557-7187-1-git-send-email-shawnguo@kernel.org>
References: <1509376557-7187-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1509376557-7187-4-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jianguo Sun <sunjianguo1@huawei.com>

Add combo phy driver for HiSilicon STB SoCs. This phy can be
used as pcie-phy, sata-phy or usb-phy.

Signed-off-by: Jianguo Sun <sunjianguo1@huawei.com>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/phy/hisilicon/Kconfig             |   9 +
 drivers/phy/hisilicon/Makefile            |   1 +
 drivers/phy/hisilicon/phy-histb-combphy.c | 289 ++++++++++++++++++++++++++++++
 3 files changed, 299 insertions(+)
 create mode 100644 drivers/phy/hisilicon/phy-histb-combphy.c

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
index 000000000000..5777b3120017
--- /dev/null
+++ b/drivers/phy/hisilicon/phy-histb-combphy.c
@@ -0,0 +1,289 @@
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
+#include <dt-bindings/phy/phy.h>
+
+#define COMBPHY_MODE_PCIE		0
+#define COMBPHY_MODE_USB3		1
+#define COMBPHY_MODE_SATA		2
+
+#define COMBPHY_CFG_REG			0x0
+#define COMBPHY_BYPASS_CODEC		BIT(31)
+#define COMBPHY_TEST_WRITE		BIT(24)
+#define COMBPHY_TEST_DATA_SHIFT		20
+#define COMBPHY_TEST_DATA_MASK		GENMASK(23, 20)
+#define COMBPHY_TEST_ADDR_SHIFT		12
+#define COMBPHY_TEST_ADDR_MASK		GENMASK(16, 12)
+#define COMBPHY_CLKREF_OUT_OEN		BIT(0)
+
+struct histb_combphy_mode {
+	int fixed;
+	int select;
+	u32 reg;
+	u32 shift;
+	u32 mask;
+};
+
+struct histb_combphy_priv {
+	void __iomem *mmio;
+	struct regmap *syscon;
+	struct reset_control *por_rst;
+	struct clk *ref_clk;
+	struct phy *phy;
+	struct histb_combphy_mode mode;
+};
+
+static void nano_register_write(struct histb_combphy_priv *priv,
+				u32 addr, u32 data)
+{
+	void __iomem *reg = priv->mmio + COMBPHY_CFG_REG;
+	u32 val;
+
+	/* Set up address and data for the write */
+	val = readl(reg);
+	val &= ~COMBPHY_TEST_ADDR_MASK;
+	val |= addr << COMBPHY_TEST_ADDR_SHIFT;
+	val &= ~COMBPHY_TEST_DATA_MASK;
+	val |= data << COMBPHY_TEST_DATA_SHIFT;
+	writel(val, reg);
+
+	/* Flip strobe control to trigger the write */
+	val &= ~COMBPHY_TEST_WRITE;
+	writel(val, reg);
+	val |= COMBPHY_TEST_WRITE;
+	writel(val, reg);
+}
+
+static int is_mode_fixed(struct histb_combphy_mode *mode)
+{
+	return (mode->fixed != PHY_NONE) ? true : false;
+}
+
+static int histb_combphy_set_mode(struct histb_combphy_priv *priv)
+{
+	struct histb_combphy_mode *mode = &priv->mode;
+	struct regmap *syscon = priv->syscon;
+	u32 hw_sel;
+
+	if (is_mode_fixed(mode))
+		return 0;
+
+	switch (mode->select) {
+	case PHY_TYPE_SATA:
+		hw_sel = COMBPHY_MODE_SATA;
+		break;
+	case PHY_TYPE_PCIE:
+		hw_sel = COMBPHY_MODE_PCIE;
+		break;
+	case PHY_TYPE_USB3:
+		hw_sel = COMBPHY_MODE_USB3;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return regmap_update_bits(syscon, mode->reg, mode->mask,
+				  hw_sel << mode->shift);
+}
+
+static int histb_combphy_init(struct phy *phy)
+{
+	struct histb_combphy_priv *priv = phy_get_drvdata(phy);
+	u32 val;
+	int ret;
+
+	ret = histb_combphy_set_mode(priv);
+	if (ret)
+		return ret;
+
+	/* Clear bypass bit to enable encoding/decoding */
+	val = readl(priv->mmio + COMBPHY_CFG_REG);
+	val &= ~COMBPHY_BYPASS_CODEC;
+	writel(val, priv->mmio + COMBPHY_CFG_REG);
+
+	ret = clk_prepare_enable(priv->ref_clk);
+	if (ret)
+		return ret;
+
+	reset_control_deassert(priv->por_rst);
+
+	/* Enable EP clock */
+	val = readl(priv->mmio + COMBPHY_CFG_REG);
+	val |= COMBPHY_CLKREF_OUT_OEN;
+	writel(val, priv->mmio + COMBPHY_CFG_REG);
+
+	/* Need to wait for EP clock stable */
+	mdelay(5);
+
+	/* Configure nano phy registers as suggested by vendor */
+	nano_register_write(priv, 0x1, 0x8);
+	nano_register_write(priv, 0xc, 0x9);
+	nano_register_write(priv, 0x1a, 0x4);
+
+	return 0;
+}
+
+static int histb_combphy_exit(struct phy *phy)
+{
+	struct histb_combphy_priv *priv = phy_get_drvdata(phy);
+	u32 val;
+
+	/* Disable EP clock */
+	val = readl(priv->mmio + COMBPHY_CFG_REG);
+	val &= ~COMBPHY_CLKREF_OUT_OEN;
+	writel(val, priv->mmio + COMBPHY_CFG_REG);
+
+	reset_control_assert(priv->por_rst);
+	clk_disable_unprepare(priv->ref_clk);
+
+	return 0;
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
+	struct histb_combphy_mode *mode = &priv->mode;
+
+	if (args->args_count < 1) {
+		dev_err(dev, "invalid number of arguments\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	mode->select = args->args[0];
+
+	if (mode->select < PHY_TYPE_SATA || mode->select > PHY_TYPE_USB3) {
+		dev_err(dev, "invalid phy mode select argument\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	if (is_mode_fixed(mode) && mode->select != mode->fixed) {
+		dev_err(dev, "mode select %d mismatch fixed phy mode %d\n",
+			mode->select, mode->fixed);
+		return ERR_PTR(-EINVAL);
+	}
+
+	return priv->phy;
+}
+
+static int histb_combphy_probe(struct platform_device *pdev)
+{
+	struct phy_provider *phy_provider;
+	struct device *dev = &pdev->dev;
+	struct histb_combphy_priv *priv;
+	struct device_node *np = dev->of_node;
+	struct histb_combphy_mode *mode;
+	struct resource *res;
+	u32 vals[3];
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	priv->mmio = devm_ioremap_resource(dev, res);
+	if (IS_ERR(priv->mmio)) {
+		ret = PTR_ERR(priv->mmio);
+		return ret;
+	}
+
+	priv->syscon = syscon_node_to_regmap(np->parent);
+	if (IS_ERR(priv->syscon)) {
+		dev_err(dev, "failed to find peri_ctrl syscon regmap\n");
+		return PTR_ERR(priv->syscon);
+	}
+
+	mode = &priv->mode;
+	mode->fixed = PHY_NONE;
+
+	ret = of_property_read_u32(np, "hisilicon,fixed-mode", &mode->fixed);
+	if (ret == 0)
+		dev_dbg(dev, "found fixed phy mode %d\n", mode->fixed);
+
+	ret = of_property_read_u32_array(np, "hisilicon,mode-select-bits",
+					 vals, ARRAY_SIZE(vals));
+	if (ret == 0) {
+		if (is_mode_fixed(mode)) {
+			dev_err(dev, "found select bits for fixed mode phy\n");
+			return -EINVAL;
+		}
+
+		mode->reg = vals[0];
+		mode->shift = vals[1];
+		mode->mask = vals[2];
+		dev_dbg(dev, "found mode select bits\n");
+	} else {
+		if (!is_mode_fixed(mode)) {
+			dev_err(dev, "no valid select bits found for non-fixed phy\n");
+			return -ENODEV;
+		}
+	}
+
+	priv->ref_clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(priv->ref_clk)) {
+		dev_err(dev, "failed to find ref clock\n");
+		return PTR_ERR(priv->ref_clk);
+	}
+
+	priv->por_rst = devm_reset_control_get(dev, NULL);
+	if (IS_ERR(priv->por_rst)) {
+		dev_err(dev, "failed to get poweron reset\n");
+		return PTR_ERR(priv->por_rst);
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
+	return PTR_ERR_OR_ZERO(phy_provider);
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
