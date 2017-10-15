From: shawnguo@kernel.org (Shawn Guo)
Date: Sun, 15 Oct 2017 22:49:18 +0800
Subject: [PATCH] phy: add inno-usb2-phy driver for hi3798cv200 SoC
Message-ID: <1508078958-16966-1-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Pengcheng Li <lpc.li@hisilicon.com>

It adds inno-usb2-phy driver for hi3798cv200 SoC USB 2.0 support.  One
inno-usb2-phy device can support up to two PHY ports.  While there is
device level reference clock and power reset to be controlled, each PHY
port has its own utmi reset that needs to assert/de-assert as needed.

Hi3798cv200 needs to access PHY port0 register via particular peripheral
syscon controller register to control PHY, like turning on PHY clock.

Signed-off-by: Pengcheng Li <lpc.li@hisilicon.com>
Signed-off-by: Jiancheng Xue <xuejiancheng@hisilicon.com>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 .../devicetree/bindings/phy/phy-hisi-inno-usb2.txt |  31 +++
 drivers/phy/hisilicon/Kconfig                      |  10 +
 drivers/phy/hisilicon/Makefile                     |   1 +
 drivers/phy/hisilicon/phy-hisi-inno-usb2.c         | 223 +++++++++++++++++++++
 4 files changed, 265 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-hisi-inno-usb2.txt
 create mode 100644 drivers/phy/hisilicon/phy-hisi-inno-usb2.c

diff --git a/Documentation/devicetree/bindings/phy/phy-hisi-inno-usb2.txt b/Documentation/devicetree/bindings/phy/phy-hisi-inno-usb2.txt
new file mode 100644
index 000000000000..4ef7af24a703
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/phy-hisi-inno-usb2.txt
@@ -0,0 +1,31 @@
+HiSilicon INNO USB2 PHY
+
+Required properties:
+- compatible: Should be one of the following strings:
+	"hisilicon,inno-usb2-phy",
+	"hisilicon,hi3798cv200-usb2-phy".
+- #phy-cells: Should be 1. The specifier is the index of the PHY port to
+  reference.
+- hisilicon,peripheral-syscon: The phandle of syscon used to control PHY,
+  followed by a integer cell which defines the syscon register offset used
+  to talk to PHY.
+- clocks: The phandle and clock specifier pair for reference clock utmi_refclk.
+- resets: The list of phandle and reset specifier pairs for each reset signal
+  in reset-names.
+- reset-names: Should contain "power_on", "utmi0" and "utmi1". The "utmi1"
+  should exist only if the device has two PHY port.
+
+Refer to phy/phy-bindings.txt for the generic PHY binding properties
+
+Example:
+
+	usb2_phy1: usb2-phy1 {
+		compatible = "hisilicon,hi3798cv200-usb2-phy";
+		#phy-cells = <1>;
+		hisilicon,peripheral-syscon = <&peri_ctrl 0x120>;
+		clocks = <&crg HISTB_USB2_PHY1_REF_CLK>;
+		resets = <&crg 0xbc 4>,
+			 <&crg 0xbc 8>,
+			 <&crg 0xbc 9>;
+		reset-names = "power_on", "utmi0", "utmi1";
+	};
diff --git a/drivers/phy/hisilicon/Kconfig b/drivers/phy/hisilicon/Kconfig
index 6164c4cd0f65..c21470eb7fba 100644
--- a/drivers/phy/hisilicon/Kconfig
+++ b/drivers/phy/hisilicon/Kconfig
@@ -11,6 +11,16 @@ config PHY_HI6220_USB
 
 	  To compile this driver as a module, choose M here.
 
+config PHY_HISI_INNO_USB2
+       tristate "HiSilicon INNO USB2 PHY support"
+       depends on (ARCH_HISI && ARM64) || COMPILE_TEST
+       select GENERIC_PHY
+       select MFD_SYSCON
+       help
+         Support for INNO USB2 PHY on HiSilicon SoCs. This Phy supports
+         USB 1.5Mb/s, USB 12Mb/s, USB 480Mb/s speeds. It supports one
+         USB host port to accept one USB device.
+
 config PHY_HIX5HD2_SATA
 	tristate "HIX5HD2 SATA PHY Driver"
 	depends on ARCH_HIX5HD2 && OF && HAS_IOMEM
diff --git a/drivers/phy/hisilicon/Makefile b/drivers/phy/hisilicon/Makefile
index 541b348187a8..e6c979458d3b 100644
--- a/drivers/phy/hisilicon/Makefile
+++ b/drivers/phy/hisilicon/Makefile
@@ -1,2 +1,3 @@
 obj-$(CONFIG_PHY_HI6220_USB)		+= phy-hi6220-usb.o
+obj-$(CONFIG_PHY_HISI_INNO_USB2)	+= phy-hisi-inno-usb2.o
 obj-$(CONFIG_PHY_HIX5HD2_SATA)		+= phy-hix5hd2-sata.o
diff --git a/drivers/phy/hisilicon/phy-hisi-inno-usb2.c b/drivers/phy/hisilicon/phy-hisi-inno-usb2.c
new file mode 100644
index 000000000000..3772aef23539
--- /dev/null
+++ b/drivers/phy/hisilicon/phy-hisi-inno-usb2.c
@@ -0,0 +1,223 @@
+/*
+ * HiSilicon INNO USB2 PHY Driver.
+ *
+ * Copyright (c) 2016-2017 HiSilicon Technologies Co., Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/phy/phy.h>
+#include <linux/regmap.h>
+#include <linux/reset.h>
+
+#define INNO_PHY_PORT_NUM	2
+#define REF_CLK_STABLE_TIME	100	/* unit:us */
+#define UTMI_CLK_STABLE_TIME	200	/* unit:us */
+#define TEST_CLK_STABLE_TIME	2	/* unit:ms */
+#define PHY_CLK_STABLE_TIME	2	/* unit:ms */
+#define UTMI_RST_COMPLETE_TIME	2	/* unit:ms */
+#define POR_RST_COMPLETE_TIME	300	/* unit:us */
+#define PHY_TEST_DATA		GENMASK(7, 0)
+#define PHY_TEST_ADDR		GENMASK(15, 8)
+#define PHY_TEST_PORT		GENMASK(18, 16)
+#define PHY_TEST_WREN		BIT(21)
+#define PHY_TEST_CLK		BIT(22)	/* rising edge active */
+#define PHY_TEST_RST		BIT(23)	/* low active */
+#define PHY_CLK_ENABLE		BIT(2)
+
+struct hisi_inno_phy_port {
+	struct phy *phy;
+	struct device *dev;
+	struct reset_control *utmi_rst;
+};
+
+struct hisi_inno_phy_priv {
+	struct regmap *syscon;
+	u32 syscon_reg;
+	struct clk *ref_clk;
+	struct reset_control *por_rst;
+	struct hisi_inno_phy_port ports[INNO_PHY_PORT_NUM];
+	u32 port_num;
+};
+
+static void hisi_inno_phy_write_reg(struct regmap *syscon, u32 reg,
+				    u8 port, u32 addr, u32 data)
+{
+	u32 value;
+
+	value = (data & PHY_TEST_DATA)
+		| ((addr << 8) & PHY_TEST_ADDR)
+		| ((port << 16) & PHY_TEST_PORT)
+		| PHY_TEST_WREN | PHY_TEST_RST;
+	regmap_write(syscon, reg, value);
+	value |= PHY_TEST_CLK;
+	regmap_write(syscon, reg, value);
+	value &= ~PHY_TEST_CLK;
+	regmap_write(syscon, reg, value);
+}
+
+static void hisi_inno_phy_setup(struct hisi_inno_phy_priv *priv)
+{
+	/* The phy clk is controlled by the port0 register 0x06. */
+	hisi_inno_phy_write_reg(priv->syscon, priv->syscon_reg, 0, 0x06,
+				PHY_CLK_ENABLE);
+	msleep(PHY_CLK_STABLE_TIME);
+}
+
+static int hisi_inno_phy_start(struct phy *phy)
+{
+	struct hisi_inno_phy_port *port = phy_get_drvdata(phy);
+	struct hisi_inno_phy_priv *priv = dev_get_drvdata(port->dev);
+	int ret;
+
+	ret = clk_prepare_enable(priv->ref_clk);
+	if (ret)
+		return ret;
+	udelay(REF_CLK_STABLE_TIME);
+
+	reset_control_deassert(priv->por_rst);
+	udelay(POR_RST_COMPLETE_TIME);
+
+	/* Set up phy registers via peripheral syscon controller */
+	hisi_inno_phy_setup(priv);
+
+	reset_control_deassert(port->utmi_rst);
+	udelay(UTMI_RST_COMPLETE_TIME);
+
+	return 0;
+}
+
+static int hisi_inno_phy_exit(struct phy *phy)
+{
+	struct hisi_inno_phy_port *port = phy_get_drvdata(phy);
+	struct hisi_inno_phy_priv *priv = dev_get_drvdata(port->dev);
+
+	reset_control_assert(port->utmi_rst);
+	reset_control_assert(priv->por_rst);
+	clk_disable_unprepare(priv->ref_clk);
+
+	return 0;
+}
+
+static const struct phy_ops hisi_inno_phy_ops = {
+	.init = hisi_inno_phy_start,
+	.exit = hisi_inno_phy_exit,
+	.owner = THIS_MODULE,
+};
+
+static struct phy *hisi_inno_phy_xlate(struct device *dev,
+				       struct of_phandle_args *args)
+{
+	struct hisi_inno_phy_priv *priv = dev_get_drvdata(dev);
+	int id = args->args[0];
+
+	if (id >= priv->port_num)
+		return ERR_PTR(-ENODEV);
+
+	return priv->ports[id].phy;
+}
+
+static int hisi_inno_phy_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct hisi_inno_phy_priv *priv;
+	struct of_phandle_args out_args;
+	struct phy_provider *provider;
+	struct regmap *regmap;
+	int ret, i;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	ret = of_parse_phandle_with_fixed_args(np,
+			"hisilicon,peripheral-syscon", 1, 0, &out_args);
+	if (ret)
+		return ret;
+
+	regmap = syscon_node_to_regmap(out_args.np);
+	if (IS_ERR(regmap))
+		ret = PTR_ERR(regmap);
+
+	priv->syscon = regmap;
+	priv->syscon_reg = out_args.args[0];
+
+	priv->ref_clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(priv->ref_clk))
+		return PTR_ERR(priv->ref_clk);
+
+	priv->port_num = of_count_phandle_with_args(np, "resets",
+						    "#reset-cells");
+	/* Do not count power_on reset */
+	priv->port_num--;
+
+	if (priv->port_num <= 0 || priv->port_num > INNO_PHY_PORT_NUM) {
+		dev_err(dev, "Invalid port number %d\n", priv->port_num);
+		return -EINVAL;
+	}
+
+	priv->por_rst = devm_reset_control_get_shared(dev, "power_on");
+	if (IS_ERR(priv->por_rst))
+		return PTR_ERR(priv->por_rst);
+
+	for (i = 0; i < priv->port_num; i++) {
+		struct reset_control *rst;
+		struct phy *phy;
+		char id[6];
+
+		snprintf(id, 6, "utmi%1d\n", i);
+		rst = devm_reset_control_get_exclusive(dev, id);
+		if (IS_ERR(rst))
+			return PTR_ERR(rst);
+		priv->ports[i].utmi_rst = rst;
+
+		phy = devm_phy_create(dev, NULL, &hisi_inno_phy_ops);
+		if (IS_ERR(phy))
+			return PTR_ERR(phy);
+
+		priv->ports[i].phy = phy;
+		priv->ports[i].dev = dev;
+		phy_set_drvdata(phy, &priv->ports[i]);
+	}
+
+	dev_set_drvdata(dev, priv);
+
+	provider = devm_of_phy_provider_register(dev, hisi_inno_phy_xlate);
+	return PTR_ERR_OR_ZERO(provider);
+}
+
+static const struct of_device_id hisi_inno_phy_of_match[] = {
+	{ .compatible = "hisilicon,inno-usb2-phy", },
+	{ .compatible = "hisilicon,hi3798cv200-usb2-phy", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, hisi_inno_phy_of_match);
+
+static struct platform_driver hisi_inno_phy_driver = {
+	.probe	= hisi_inno_phy_probe,
+	.driver = {
+		.name	= "hisi-inno-phy",
+		.of_match_table	= hisi_inno_phy_of_match,
+	}
+};
+module_platform_driver(hisi_inno_phy_driver);
+
+MODULE_DESCRIPTION("HiSilicon INNO USB2 PHY Driver");
+MODULE_LICENSE("GPL v2");
-- 
1.9.1
