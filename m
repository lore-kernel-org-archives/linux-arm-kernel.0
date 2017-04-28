From: jon.mason@broadcom.com (Jon Mason)
Date: Fri, 28 Apr 2017 16:29:40 -0400
Subject: [PATCH 2/3] phy: Add USB3 PHY support for Broadcom NS2 SoC
In-Reply-To: <1493411381-16833-1-git-send-email-jon.mason@broadcom.com>
References: <1493411381-16833-1-git-send-email-jon.mason@broadcom.com>
Message-ID: <1493411381-16833-3-git-send-email-jon.mason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>

This patch adds support for Broadcom NS2 USB3 PHY

Signed-off-by: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>
Signed-off-by: Jon Mason <jon.mason@broadcom.com>
---
 drivers/phy/Kconfig            |   9 +
 drivers/phy/Makefile           |   1 +
 drivers/phy/phy-bcm-ns2-usb3.c | 596 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 606 insertions(+)
 create mode 100644 drivers/phy/phy-bcm-ns2-usb3.c

diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index dc5277a..c86f47c 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -498,6 +498,15 @@ config PHY_NS2_PCIE
 	  Enable this to support the Broadcom Northstar2 PCIe PHY.
 	  If unsure, say N.
 
+config PHY_NS2_USB3
+	tristate "Broadcom NorthStar2 USB3 PHY driver"
+	depends on OF && (ARCH_BCM_IPROC || COMPILE_TEST)
+	select GENERIC_PHY
+	default ARCH_BCM_IPROC
+	help
+	  Enable this to support the Broadcom Northstar2 USB3 PHY.
+	  If unsure, say N.
+
 config PHY_MESON8B_USB2
 	tristate "Meson8b and GXBB USB2 PHY driver"
 	default ARCH_MESON
diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
index e7b0feb..8ad8920 100644
--- a/drivers/phy/Makefile
+++ b/drivers/phy/Makefile
@@ -61,5 +61,6 @@ obj-$(CONFIG_PHY_PISTACHIO_USB)		+= phy-pistachio-usb.o
 obj-$(CONFIG_PHY_CYGNUS_PCIE)		+= phy-bcm-cygnus-pcie.o
 obj-$(CONFIG_ARCH_TEGRA) += tegra/
 obj-$(CONFIG_PHY_NS2_PCIE)		+= phy-bcm-ns2-pcie.o
+obj-$(CONFIG_PHY_NS2_USB3)		+= phy-bcm-ns2-usb3.o
 obj-$(CONFIG_PHY_MESON8B_USB2)		+= phy-meson8b-usb2.o
 obj-$(CONFIG_PHY_NSP_USB3)		+= phy-bcm-nsp-usb3.o
diff --git a/drivers/phy/phy-bcm-ns2-usb3.c b/drivers/phy/phy-bcm-ns2-usb3.c
new file mode 100644
index 0000000..203f509
--- /dev/null
+++ b/drivers/phy/phy-bcm-ns2-usb3.c
@@ -0,0 +1,596 @@
+/*
+ * Copyright (C) 2016 Broadcom
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/mfd/syscon.h>
+#include <linux/mdio.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/phy/phy.h>
+#include <linux/regmap.h>
+
+#define NS2_USB3_PHY_MAX			0x02
+
+#define NS2_USB3_PHY_CONFIG_CTRL_REG		0x00
+#define NS2_USB3_PHY_CONFIG_CTRL_MASK		(BIT(3) | BIT(4) | BIT(5))
+#define NS2_USB3_PHY_CONFIG_CTRL_PLL_SEQ_START	BIT(6)
+
+#define NS2_USB3_PHY_P0CTL_REG			0x04
+#define NS2_USB3_PHY_P1CTL_REG			0x08
+#define NS2_USB3_PHY_PXCTL_I_BIT		BIT(1)
+
+#define NS2_USB3_PHY_MISC_STATUS_REG		0x10
+
+#define NS2_IDM_RST_CTRL_P0_OFFSET		0x3f8
+#define NS2_IDM_RST_CTRL_P1_OFFSET		0x13f8
+#define NS2_IDM_RESET_CONTROL_BIT		BIT(0)
+
+#define NS2_IDM_IO_CTRL_P0_OFFSET		0x0
+#define NS2_IDM_IO_CTRL_P1_OFFSET		0x1000
+/* Bit 23 for PPC Polarity, Bit 24 for PPC NANDNOR select */
+#define NS2_IDM_IO_CTRL_PPC_CFG			(BIT(23) | BIT(24))
+
+#define NS2_PHY_RESET_BIT			BIT(5)
+#define NS2_PHY_PLL_RESET_BIT			BIT(6)
+
+/* NS2 USB3 MDIO */
+#define NS2_USB3_MDIO_PLL30_ADDR		0x8000
+#define NS2_USB3_MDIO_BLK_ACCESS		0x1F
+#define NS2_USB3_MDIO_PLL30_ANAPLL_CTRL		0x14
+#define NS2_USB3_MDIO_PLL30_ANAPLL_CTRL_VAL	0x23
+#define NS2_USB3_MDIO_PLL30_GEN_PLL		0xF
+#define NS2_USB3_MDIO_PLL30_GEN_PLL_PCLK_SEL	BIT(11)
+#define NS2_USB3_MDIO_P0_AFE30_ADDR		0x8080
+#define NS2_USB3_MDIO_P1_AFE30_ADDR		0x9080
+#define NS2_USB3_MDIO_AFE30_RX_SIG_DETECT	0x5
+#define NS2_USB3_MDIO_AFE30_RX_SIG_DETECT_VAL	0xAC0D
+
+#define NS2_USB3_MDIO_P0_PIPE_BLK_ADDR		0x8060
+#define NS2_USB3_MDIO_P1_PIPE_BLK_ADDR		0x9060
+#define NS2_USB3_MDIO_PIPE_BLK_REG_1_OFFSET	0x1
+#define NS2_USB3_MDIO_PIPE_BLK_REG_1_VAL	0x207
+
+#define NS2_USB3_MDIO_P0_AEQ_BLK_ADDR		0x80E0
+#define NS2_USB3_MDIO_P1_AEQ_BLK_ADDR		0x90E0
+#define NS2_USB3_MDIO_AEQ_BLK_REG_1_OFFSET	0x1
+#define NS2_USB3_MDIO_AEQ_BLK_REG_1_VAL		0x3000
+
+/* USB3 Histogram Programming */
+#define NS2_USB3_IRAADR_OFFSET			0x198
+#define NS2_USB3_IRADAT_OFFSET			0x19c
+#define USB3_HISTOGRAM_OFFSET_VAL		0xA200
+#define USB3_BYPASS_VBUS_INPUTS			BIT(2)
+#define USB3_OVERRIDE_VBU_PRESENT		BIT(3)
+#define USB3_OVERRIDE_CURRENT_MASK		(~(BIT(4)))
+#define NS2_USB3_MDIO_RESET_BIT			(BIT(12))
+
+enum ns2_phy_block {
+	PHY_RESET,
+	PHY_PLL_RESET,
+	PHY_SOFT_RESET,
+	PHY_PIPE_RESET,
+	PHY_REF_CLOCK,
+	PHY_PLL_SEQ_START,
+	PHY_PLL_STATUS,
+	PHY_VBUS_PPC,
+};
+
+enum ns2_reg_base {
+	NS2_USB3_CTRL = 1,
+	NS2_USB3_PHY_CFG,
+	NS2_USB3_RST_CTRL,
+	NS2_USB3_REG_BASE_MAX
+};
+
+struct ns2_usb3_phy {
+	void __iomem *reg_base[NS2_USB3_REG_BASE_MAX];
+	struct ns2_usb3_phy_master *mphy;
+	struct phy *phy;
+	int port_no;
+};
+
+struct ns2_usb3_phy_master {
+	struct ns2_usb3_phy iphys[NS2_USB3_PHY_MAX];
+	struct mdio_device *mdiodev;
+	struct mutex phy_mutex;
+	int init_count; /* PHY is dual port phy, so init once*/
+};
+
+static int iproc_ns2_phy_action(struct ns2_usb3_phy *iphy,
+				enum ns2_phy_block block, bool assert)
+{
+	void __iomem *addr;
+	u32  data, count;
+	u32 offset = 0;
+	int ret = 0;
+
+	switch (block) {
+	case PHY_RESET:
+		addr = iphy->reg_base[NS2_USB3_CTRL];
+
+		ret = regmap_read(addr, offset, &data);
+		if (ret != 0)
+			return ret;
+
+		if (assert)
+			data &= ~NS2_PHY_RESET_BIT;
+		else
+			data |= NS2_PHY_RESET_BIT;
+
+		ret = regmap_write(addr, offset, data);
+		break;
+
+	case PHY_PLL_RESET:
+		addr = iphy->reg_base[NS2_USB3_CTRL];
+
+		ret = regmap_read(addr, offset, &data);
+		if (ret != 0)
+			return ret;
+
+		if (assert)
+			data &= ~NS2_PHY_PLL_RESET_BIT;
+		else
+			data |= NS2_PHY_PLL_RESET_BIT;
+
+		ret = regmap_write(addr, offset, data);
+		break;
+
+	case PHY_SOFT_RESET:
+		addr = iphy->reg_base[NS2_USB3_PHY_CFG];
+		offset = NS2_USB3_PHY_P0CTL_REG;
+
+		ret = regmap_read(addr, offset, &data);
+		if (ret != 0)
+			return ret;
+
+		if (assert)
+			data &= ~NS2_USB3_PHY_PXCTL_I_BIT;
+		else
+			data |= NS2_USB3_PHY_PXCTL_I_BIT;
+
+		ret = regmap_write(addr, offset, data);
+		if (ret != 0)
+			return ret;
+
+		offset = NS2_USB3_PHY_P1CTL_REG;
+
+		ret = regmap_read(addr, offset, &data);
+		if (ret != 0)
+			return ret;
+
+		if (assert)
+			data &= ~NS2_USB3_PHY_PXCTL_I_BIT;
+		else
+			data |= NS2_USB3_PHY_PXCTL_I_BIT;
+
+		ret = regmap_write(addr, offset, data);
+		break;
+
+	case PHY_PIPE_RESET:
+		addr = iphy->reg_base[NS2_USB3_RST_CTRL];
+		offset = NS2_IDM_RST_CTRL_P0_OFFSET;
+
+		ret = regmap_read(addr, offset, &data);
+		if (ret != 0)
+			return ret;
+
+		if (assert)
+			data |= NS2_IDM_RESET_CONTROL_BIT;
+		else
+			data &= ~NS2_IDM_RESET_CONTROL_BIT;
+
+		ret = regmap_write(addr, offset, data);
+		if (ret != 0)
+			return ret;
+
+		offset = NS2_IDM_RST_CTRL_P1_OFFSET;
+		ret = regmap_read(addr, offset, &data);
+		if (ret != 0)
+			return ret;
+
+		if (assert)
+			data |= NS2_IDM_RESET_CONTROL_BIT;
+		else
+			data &= ~NS2_IDM_RESET_CONTROL_BIT;
+
+		ret = regmap_write(addr, offset, data);
+		break;
+
+	case PHY_VBUS_PPC:
+		addr = iphy->reg_base[NS2_USB3_RST_CTRL];
+		offset = NS2_IDM_IO_CTRL_P0_OFFSET;
+
+		ret = regmap_read(addr, offset, &data);
+		if (ret != 0)
+			return ret;
+
+		if (assert)
+			data |= NS2_IDM_IO_CTRL_PPC_CFG;
+		else
+			data &= ~NS2_IDM_IO_CTRL_PPC_CFG;
+
+		ret = regmap_write(addr, offset, data);
+		if (ret != 0)
+			return ret;
+
+		offset = NS2_IDM_IO_CTRL_P1_OFFSET;
+		ret = regmap_read(addr, offset, &data);
+		if (ret != 0)
+			return ret;
+
+		if (assert)
+			data |= NS2_IDM_IO_CTRL_PPC_CFG;
+		else
+			data &= ~NS2_IDM_IO_CTRL_PPC_CFG;
+
+		ret = regmap_write(addr, offset, data);
+		break;
+
+	case PHY_REF_CLOCK:
+		addr = iphy->reg_base[NS2_USB3_PHY_CFG];
+		offset = NS2_USB3_PHY_CONFIG_CTRL_REG;
+
+		ret = regmap_read(addr, offset, &data);
+		if (ret != 0)
+			return ret;
+
+		data &= ~NS2_USB3_PHY_CONFIG_CTRL_MASK;
+
+		ret = regmap_write(addr, offset, data);
+		break;
+
+	case PHY_PLL_SEQ_START:
+		addr = iphy->reg_base[NS2_USB3_PHY_CFG];
+		offset = NS2_USB3_PHY_CONFIG_CTRL_REG;
+
+		ret = regmap_read(addr, offset, &data);
+		if (ret != 0)
+			return ret;
+
+		data |= NS2_USB3_PHY_CONFIG_CTRL_PLL_SEQ_START;
+
+		ret = regmap_write(addr, offset, data);
+		break;
+
+	case PHY_PLL_STATUS:
+		count = 2000;
+		addr = iphy->reg_base[NS2_USB3_PHY_CFG];
+		offset = NS2_USB3_PHY_MISC_STATUS_REG;
+
+		do {
+			udelay(1);
+			ret = regmap_read(addr, offset, &data);
+			if (ret != 0)
+				return ret;
+
+			if (data == 1)
+				break;
+		} while (--count);
+
+		if (!count)
+			ret = -ETIMEDOUT;
+		break;
+
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static int ns2_usb3_phy_exit(struct phy *phy)
+{
+	struct ns2_usb3_phy *iphy = phy_get_drvdata(phy);
+	int rc = 0;
+
+	mutex_lock(&iphy->mphy->phy_mutex);
+
+	if (iphy->mphy->init_count <= 0) {
+		mutex_unlock(&iphy->mphy->phy_mutex);
+		return 0;
+	} else if (iphy->mphy->init_count == 1) {
+		/* Only put in to reset for last port to exit */
+		rc = iproc_ns2_phy_action(iphy, PHY_PLL_RESET, true);
+		if (rc)
+			goto out;
+
+		rc = iproc_ns2_phy_action(iphy, PHY_SOFT_RESET, true);
+		if (rc)
+			goto out;
+
+		rc = iproc_ns2_phy_action(iphy, PHY_RESET, true);
+		if (rc)
+			goto out;
+
+		rc = iproc_ns2_phy_action(iphy, PHY_PIPE_RESET, true);
+		if (rc)
+			goto out;
+	}
+
+out:
+	iphy->mphy->init_count--;
+	mutex_unlock(&iphy->mphy->phy_mutex);
+
+	return rc;
+}
+
+static int ns2_usb3_phy_init(struct phy *phy)
+{
+	struct ns2_usb3_phy *iphy = phy_get_drvdata(phy);
+	u16 addr;
+	u16 reg_val;
+	int rc;
+
+	mutex_lock(&iphy->mphy->phy_mutex);
+
+	if (iphy->mphy->init_count) {
+		/* Use count to identify last port to call phy_exit. */
+		iphy->mphy->init_count++;
+		mutex_unlock(&iphy->mphy->phy_mutex);
+		return 0;
+	}
+
+	rc = iproc_ns2_phy_action(iphy, PHY_RESET, false);
+	if (rc)
+		goto out;
+
+	rc = iproc_ns2_phy_action(iphy, PHY_SOFT_RESET, true);
+	if (rc)
+		goto out;
+
+	rc = iproc_ns2_phy_action(iphy, PHY_PIPE_RESET, true);
+	if (rc)
+		goto out;
+
+	rc = iproc_ns2_phy_action(iphy, PHY_REF_CLOCK, true);
+	if (rc)
+		goto out;
+
+	rc = iproc_ns2_phy_action(iphy, PHY_PLL_RESET, true);
+	if (rc)
+		goto out;
+
+	rc = iproc_ns2_phy_action(iphy, PHY_RESET, true);
+	if (rc)
+		goto out;
+
+	rc = iproc_ns2_phy_action(iphy, PHY_RESET, false);
+	if (rc)
+		goto out;
+
+	/* PLL programming */
+	/* PHY PLL30 Block */
+	rc = mdiobus_write(iphy->mphy->mdiodev->bus, iphy->mphy->mdiodev->addr,
+				NS2_USB3_MDIO_BLK_ACCESS,
+				NS2_USB3_MDIO_PLL30_ADDR);
+	if (rc)
+		goto out;
+
+	rc = mdiobus_write(iphy->mphy->mdiodev->bus, iphy->mphy->mdiodev->addr,
+				NS2_USB3_MDIO_PLL30_ANAPLL_CTRL,
+				NS2_USB3_MDIO_PLL30_ANAPLL_CTRL_VAL);
+	if (rc)
+		goto out;
+
+	reg_val = (u16) mdiobus_read(iphy->mphy->mdiodev->bus,
+				iphy->mphy->mdiodev->addr,
+				NS2_USB3_MDIO_PLL30_GEN_PLL);
+	reg_val |= NS2_USB3_MDIO_PLL30_GEN_PLL_PCLK_SEL;
+
+	rc = mdiobus_write(iphy->mphy->mdiodev->bus, iphy->mphy->mdiodev->addr,
+				NS2_USB3_MDIO_PLL30_GEN_PLL, reg_val);
+	if (rc)
+		goto out;
+
+	/* PHY AFE30 Block */
+	addr = NS2_USB3_MDIO_P0_AFE30_ADDR;
+	rc = mdiobus_write(iphy->mphy->mdiodev->bus, iphy->mphy->mdiodev->addr,
+				NS2_USB3_MDIO_BLK_ACCESS, addr);
+	if (rc)
+		goto out;
+
+	rc = mdiobus_write(iphy->mphy->mdiodev->bus, iphy->mphy->mdiodev->addr,
+				NS2_USB3_MDIO_AFE30_RX_SIG_DETECT,
+				NS2_USB3_MDIO_AFE30_RX_SIG_DETECT_VAL);
+	if (rc)
+		goto out;
+
+	addr = NS2_USB3_MDIO_P1_AFE30_ADDR;
+	rc = mdiobus_write(iphy->mphy->mdiodev->bus, iphy->mphy->mdiodev->addr,
+				NS2_USB3_MDIO_BLK_ACCESS, addr);
+	if (rc)
+		goto out;
+
+	rc = mdiobus_write(iphy->mphy->mdiodev->bus, iphy->mphy->mdiodev->addr,
+				NS2_USB3_MDIO_AFE30_RX_SIG_DETECT,
+				NS2_USB3_MDIO_AFE30_RX_SIG_DETECT_VAL);
+	if (rc)
+		goto out;
+
+	/* PHY PIPE Block */
+	addr = NS2_USB3_MDIO_P0_PIPE_BLK_ADDR;
+	rc = mdiobus_write(iphy->mphy->mdiodev->bus, iphy->mphy->mdiodev->addr,
+				NS2_USB3_MDIO_BLK_ACCESS, addr);
+	if (rc)
+		goto out;
+
+	rc = mdiobus_write(iphy->mphy->mdiodev->bus, iphy->mphy->mdiodev->addr,
+				NS2_USB3_MDIO_PIPE_BLK_REG_1_OFFSET,
+				NS2_USB3_MDIO_PIPE_BLK_REG_1_VAL);
+	if (rc)
+		goto out;
+
+	addr = NS2_USB3_MDIO_P1_PIPE_BLK_ADDR;
+	rc = mdiobus_write(iphy->mphy->mdiodev->bus, iphy->mphy->mdiodev->addr,
+				NS2_USB3_MDIO_BLK_ACCESS, addr);
+	if (rc)
+		goto out;
+
+	rc = mdiobus_write(iphy->mphy->mdiodev->bus, iphy->mphy->mdiodev->addr,
+				NS2_USB3_MDIO_PIPE_BLK_REG_1_OFFSET,
+				NS2_USB3_MDIO_PIPE_BLK_REG_1_VAL);
+	if (rc)
+		goto out;
+
+	/* AEQ Block */
+	addr = NS2_USB3_MDIO_P0_AEQ_BLK_ADDR;
+	rc = mdiobus_write(iphy->mphy->mdiodev->bus, iphy->mphy->mdiodev->addr,
+				NS2_USB3_MDIO_BLK_ACCESS, addr);
+	if (rc)
+		goto out;
+
+	rc = mdiobus_write(iphy->mphy->mdiodev->bus, iphy->mphy->mdiodev->addr,
+				NS2_USB3_MDIO_AEQ_BLK_REG_1_OFFSET,
+				NS2_USB3_MDIO_AEQ_BLK_REG_1_VAL);
+	if (rc)
+		goto out;
+
+	/* PHY PORT_1 */
+	addr = NS2_USB3_MDIO_P1_AEQ_BLK_ADDR;
+	rc = mdiobus_write(iphy->mphy->mdiodev->bus, iphy->mphy->mdiodev->addr,
+				NS2_USB3_MDIO_BLK_ACCESS, addr);
+	if (rc)
+		goto out;
+
+	rc = mdiobus_write(iphy->mphy->mdiodev->bus, iphy->mphy->mdiodev->addr,
+				NS2_USB3_MDIO_AEQ_BLK_REG_1_OFFSET,
+				NS2_USB3_MDIO_AEQ_BLK_REG_1_VAL);
+	if (rc)
+		goto out;
+
+	rc = iproc_ns2_phy_action(iphy, PHY_PLL_SEQ_START, true);
+	if (rc)
+		goto out;
+
+	rc = iproc_ns2_phy_action(iphy, PHY_PIPE_RESET, false);
+	if (rc)
+		goto out;
+
+	rc = iproc_ns2_phy_action(iphy, PHY_SOFT_RESET, false);
+	if (rc)
+		goto out;
+
+	rc = iproc_ns2_phy_action(iphy, PHY_PLL_RESET, false);
+	if (rc)
+		goto out;
+
+	rc = iproc_ns2_phy_action(iphy, PHY_PLL_STATUS, true);
+	if (rc)
+		goto out;
+
+	/* Set USB3H VBUS PPC Polarity and NandNor select */
+	rc = iproc_ns2_phy_action(iphy, PHY_VBUS_PPC, true);
+
+out:
+	iphy->mphy->init_count++;
+	mutex_unlock(&iphy->mphy->phy_mutex);
+
+	return rc;
+}
+
+static struct phy_ops ns2_usb3_phy_ops = {
+	.init = ns2_usb3_phy_init,
+	.exit = ns2_usb3_phy_exit,
+	.owner = THIS_MODULE,
+};
+
+static int ns2_usb3_phy_probe(struct mdio_device *mdiodev)
+{
+	struct device *dev = &mdiodev->dev;
+	struct device_node *dn = dev->of_node, *child;
+	struct ns2_usb3_phy_master *mphy;
+	struct phy_provider *provider;
+	int cnt;
+
+	mphy = devm_kzalloc(dev, sizeof(*mphy), GFP_KERNEL);
+	if (!mphy)
+		return -ENOMEM;
+	mphy->mdiodev = mdiodev;
+	mutex_init(&mphy->phy_mutex);
+	mphy->init_count = 0;
+
+	cnt = 0;
+	for_each_available_child_of_node(dn, child) {
+		struct ns2_usb3_phy *iphy;
+		unsigned int val;
+		struct regmap *io;
+
+		iphy = &mphy->iphys[cnt];
+		if (of_property_read_u32(child, "reg", &val)) {
+			dev_err(dev, "missing reg property in node %s\n",
+					child->name);
+			return -EINVAL;
+		}
+		iphy->port_no = val;
+		iphy->mphy = mphy;
+
+		io = syscon_regmap_lookup_by_phandle(dn, "usb3-ctrl-syscon");
+		if (IS_ERR(io))
+			return PTR_ERR(io);
+		iphy->reg_base[NS2_USB3_CTRL] = io;
+
+		io = syscon_regmap_lookup_by_phandle(dn, "usb3-phy-cfg-syscon");
+		if (IS_ERR(io))
+			return PTR_ERR(io);
+		iphy->reg_base[NS2_USB3_PHY_CFG] = io;
+
+		io = syscon_regmap_lookup_by_phandle(dn,
+						"usb3-rst-ctrl-syscon");
+		if (IS_ERR(io))
+			return PTR_ERR(io);
+		iphy->reg_base[NS2_USB3_RST_CTRL] = io;
+
+		iphy->phy = devm_phy_create(dev, child, &ns2_usb3_phy_ops);
+		if (IS_ERR(iphy->phy)) {
+			dev_err(dev, "failed to create PHY\n");
+			return PTR_ERR(iphy->phy);
+		}
+
+		phy_set_drvdata(iphy->phy, iphy);
+		cnt++;
+	}
+
+	dev_set_drvdata(dev, mphy);
+	provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+	if (IS_ERR(provider)) {
+		dev_err(dev, "could not register PHY provider\n");
+		return PTR_ERR(provider);
+	}
+
+	dev_info(dev, "registered %d phy(s)\n", cnt);
+	return 0;
+}
+
+static const struct of_device_id ns2_usb3_phy_of_match[] = {
+	{.compatible = "brcm,ns2-usb3-phy",},
+	{ /* sentinel */ }
+};
+
+static struct mdio_driver ns2_usb3_phy_driver = {
+	.mdiodrv = {
+		.driver = {
+			.name = "ns2-usb3-phy",
+			.of_match_table = ns2_usb3_phy_of_match,
+		},
+	},
+	.probe = ns2_usb3_phy_probe,
+};
+mdio_module_driver(ns2_usb3_phy_driver);
+
+MODULE_DESCRIPTION("Broadcom NS2 USB3 PHY driver");
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Broadcom");
-- 
2.7.4
