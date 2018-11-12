From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Mon, 12 Nov 2018 12:30:52 +0000
Subject: [RFC PATCH 2/6] phy: armada38x: add common phy support
In-Reply-To: <20181112122933.GD30658@n2100.armlinux.org.uk>
References: <20181112122933.GD30658@n2100.armlinux.org.uk>
Message-ID: <E1gMBMi-00089Q-7S@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the Armada 38x common phy to allow us to change the
speed of the Ethernet serdes lane.  This driver only supports
manipulation of the speed, it does not support configuration of the
common phy.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/phy/marvell/Kconfig                |  10 ++
 drivers/phy/marvell/Makefile               |   1 +
 drivers/phy/marvell/phy-armada38x-comphy.c | 236 +++++++++++++++++++++++++++++
 3 files changed, 247 insertions(+)
 create mode 100644 drivers/phy/marvell/phy-armada38x-comphy.c

diff --git a/drivers/phy/marvell/Kconfig b/drivers/phy/marvell/Kconfig
index 6fb4b56e4c14..224ea4e6a46d 100644
--- a/drivers/phy/marvell/Kconfig
+++ b/drivers/phy/marvell/Kconfig
@@ -21,6 +21,16 @@ config PHY_BERLIN_USB
 	help
 	  Enable this to support the USB PHY on Marvell Berlin SoCs.
 
+config PHY_MVEBU_A38X_COMPHY
+	tristate "Marvell Armada 38x comphy driver"
+	depends on ARCH_MVEBU || COMPILE_TEST
+	depends on OF
+	select GENERIC_PHY
+	help
+	  This driver allows to control the comphy, an hardware block providing
+	  shared serdes PHYs on Marvell Armada 38x. Its serdes lanes can be
+	  used by various controllers (Ethernet, sata, usb, PCIe...).
+
 config PHY_MVEBU_CP110_COMPHY
 	tristate "Marvell CP110 comphy driver"
 	depends on ARCH_MVEBU || COMPILE_TEST
diff --git a/drivers/phy/marvell/Makefile b/drivers/phy/marvell/Makefile
index 3975b144f8ec..59b6c03ef756 100644
--- a/drivers/phy/marvell/Makefile
+++ b/drivers/phy/marvell/Makefile
@@ -2,6 +2,7 @@
 obj-$(CONFIG_ARMADA375_USBCLUSTER_PHY)	+= phy-armada375-usb2.o
 obj-$(CONFIG_PHY_BERLIN_SATA)		+= phy-berlin-sata.o
 obj-$(CONFIG_PHY_BERLIN_USB)		+= phy-berlin-usb.o
+obj-$(CONFIG_PHY_MVEBU_A38X_COMPHY)	+= phy-armada38x-comphy.o
 obj-$(CONFIG_PHY_MVEBU_CP110_COMPHY)	+= phy-mvebu-cp110-comphy.o
 obj-$(CONFIG_PHY_MVEBU_SATA)		+= phy-mvebu-sata.o
 obj-$(CONFIG_PHY_PXA_28NM_HSIC)		+= phy-pxa-28nm-hsic.o
diff --git a/drivers/phy/marvell/phy-armada38x-comphy.c b/drivers/phy/marvell/phy-armada38x-comphy.c
new file mode 100644
index 000000000000..61d1965e1cf6
--- /dev/null
+++ b/drivers/phy/marvell/phy-armada38x-comphy.c
@@ -0,0 +1,236 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2018 Russell King, Deep Blue Solutions Ltd.
+ *
+ * Partly derived from CP110 comphy driver by Antoine Tenart
+ * <antoine.tenart@bootlin.com>
+ */
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+
+#define MAX_A38X_COMPHY	6
+#define MAX_A38X_PORTS	3
+
+#define COMPHY_CFG1		0x00
+#define  COMPHY_CFG1_GEN_TX(x)		((x) << 26)
+#define  COMPHY_CFG1_GEN_TX_MSK		COMPHY_CFG1_GEN_TX(15)
+#define  COMPHY_CFG1_GEN_RX(x)		((x) << 22)
+#define  COMPHY_CFG1_GEN_RX_MSK		COMPHY_CFG1_GEN_RX(15)
+#define  GEN_SGMII_1_25GBPS		6
+#define  GEN_SGMII_3_125GBPS		8
+
+#define COMPHY_STAT1		0x18
+#define  COMPHY_STAT1_PLL_RDY_TX	BIT(3)
+#define  COMPHY_STAT1_PLL_RDY_RX	BIT(2)
+
+#define COMPHY_SELECTOR		0xfc
+
+struct a38x_comphy;
+
+struct a38x_comphy_lane {
+	void __iomem *base;
+	struct a38x_comphy *priv;
+	unsigned int n;
+
+	int port;
+};
+
+struct a38x_comphy {
+	void __iomem *base;
+	struct device *dev;
+	struct a38x_comphy_lane lane[MAX_A38X_COMPHY];
+};
+
+static const u8 gbe_mux[MAX_A38X_COMPHY][MAX_A38X_PORTS] = {
+	{ 0, 0, 0 },
+	{ 4, 5, 0 },
+	{ 0, 4, 0 },
+	{ 0, 0, 4 },
+	{ 0, 3, 0 },
+	{ 0, 0, 3 },
+};
+
+static void a38x_comphy_set_reg(struct a38x_comphy_lane *lane,
+				unsigned int offset, u32 mask, u32 value)
+{
+	u32 val;
+
+	val = readl_relaxed(lane->base + offset) & ~mask;
+	writel(val | value, lane->base + offset);
+}
+
+static void a38x_comphy_set_speed(struct a38x_comphy_lane *lane,
+				  unsigned int gen_tx, unsigned int gen_rx)
+{
+	a38x_comphy_set_reg(lane, COMPHY_CFG1,
+			    COMPHY_CFG1_GEN_TX_MSK | COMPHY_CFG1_GEN_RX_MSK,
+			    COMPHY_CFG1_GEN_TX(gen_tx) |
+		            COMPHY_CFG1_GEN_RX(gen_rx));
+}
+
+static int a38x_comphy_poll(struct a38x_comphy_lane *lane,
+			    unsigned int offset, u32 mask, u32 value)
+{
+	unsigned int timeout = 10;
+	u32 val;
+
+	while (1) {
+		val = readl_relaxed(lane->base + offset);
+		if ((val & mask) == value)
+			return 0;
+		if (!timeout--)
+			break;
+		udelay(10);
+	}
+
+	dev_err(lane->priv->dev, "comphy%u: timed out waiting for status\n",
+		lane->n);
+
+	return -ETIMEDOUT;
+}
+
+/*
+ * We only support changing the speed for comphys configured for GBE.
+ * Since that is all we do, we only poll for PLL ready status.
+ */
+static int a38x_comphy_set_mode(struct phy *phy, enum phy_mode mode)
+{
+	struct a38x_comphy_lane *lane = phy_get_drvdata(phy);
+	unsigned int gen;
+	u32 val;
+
+	val = readl_relaxed(lane->priv->base + COMPHY_SELECTOR);
+	val = (val >> (4 * lane->n)) & 0xf;
+
+	if (!gbe_mux[lane->n][lane->port] ||
+	    val != gbe_mux[lane->n][lane->port]) {
+		dev_warn(lane->priv->dev,
+			 "comphy%u: not configured for GBE\n", lane->n);
+		return -EINVAL;
+	}
+
+	switch (mode) {
+	case PHY_MODE_SGMII:
+		gen = GEN_SGMII_1_25GBPS;
+		break;
+
+	case PHY_MODE_2500SGMII:
+		gen = GEN_SGMII_3_125GBPS;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	a38x_comphy_set_speed(lane, gen, gen);
+
+	return a38x_comphy_poll(lane, COMPHY_STAT1,
+				COMPHY_STAT1_PLL_RDY_TX |
+				COMPHY_STAT1_PLL_RDY_RX,
+				COMPHY_STAT1_PLL_RDY_TX |
+				COMPHY_STAT1_PLL_RDY_RX);
+}
+
+static const struct phy_ops a38x_comphy_ops = {
+	.set_mode	= a38x_comphy_set_mode,
+	.owner		= THIS_MODULE,
+};
+
+static struct phy *a38x_comphy_xlate(struct device *dev,
+				     struct of_phandle_args *args)
+{
+	struct a38x_comphy_lane *lane;
+	struct phy *phy;
+
+	if (WARN_ON(args->args[0] >= MAX_A38X_PORTS))
+		return ERR_PTR(-EINVAL);
+
+	phy = of_phy_simple_xlate(dev, args);
+	if (IS_ERR(phy))
+		return phy;
+
+	lane = phy_get_drvdata(phy);
+	if (lane->port >= 0)
+		return ERR_PTR(-EBUSY);
+
+	lane->port = args->args[0];
+
+	return phy;
+}
+
+static int a38x_comphy_probe(struct platform_device *pdev)
+{
+	struct a38x_comphy *priv;
+	struct phy_provider *provider;
+	struct device_node *child;
+	struct resource *res;
+	void __iomem *base;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	priv->dev = &pdev->dev;
+	priv->base = base;
+
+	for_each_available_child_of_node(pdev->dev.of_node, child) {
+		struct phy *phy;
+		int ret;
+		u32 val;
+
+		ret = of_property_read_u32(child, "reg", &val);
+		if (ret < 0) {
+			dev_err(&pdev->dev, "missing 'reg' property (%d)\n",
+				ret);
+			continue;
+		}
+
+		if (val >= MAX_A38X_COMPHY || priv->lane[val].base) {
+			dev_err(&pdev->dev, "invalid 'reg' property\n");
+			continue;
+		}
+
+		phy = devm_phy_create(&pdev->dev, child, &a38x_comphy_ops);
+		if (IS_ERR(phy))
+			return PTR_ERR(phy);
+
+		priv->lane[val].base = base + 0x28 * val;
+		priv->lane[val].priv = priv;
+		priv->lane[val].n = val;
+		priv->lane[val].port = -1;
+		phy_set_drvdata(phy, &priv->lane[val]);
+	}
+
+	dev_set_drvdata(&pdev->dev, priv);
+
+	provider = devm_of_phy_provider_register(&pdev->dev, a38x_comphy_xlate);
+
+	return PTR_ERR_OR_ZERO(provider);
+}
+
+static const struct of_device_id a38x_comphy_of_match_table[] = {
+	{ .compatible = "marvell,armada-380-comphy" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, a38x_comphy_of_match_table);
+
+static struct platform_driver a38x_comphy_driver = {
+	.probe	= a38x_comphy_probe,
+	.driver	= {
+		.name = "armada-38x-comphy",
+		.of_match_table = a38x_comphy_of_match_table,
+	},
+};
+module_platform_driver(a38x_comphy_driver);
+
+MODULE_AUTHOR("Russell King <rmk+kernel@armlinux.org.uk>");
+MODULE_DESCRIPTION("Common PHY driver for Armada 38x SoCs");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4
