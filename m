From: ykk@rock-chips.com (Yakir Yang)
Date: Thu, 29 Oct 2015 09:58:38 +0800
Subject: [PATCH v9 10/17] phy: Add driver for rockchip Display Port PHY
In-Reply-To: <1446020143-32645-1-git-send-email-ykk@rock-chips.com>
References: <1446020143-32645-1-git-send-email-ykk@rock-chips.com>
Message-ID: <1446083918-30809-1-git-send-email-ykk@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add phy driver for the Rockchip DisplayPort PHY module. This
is required to get DisplayPort working in Rockchip SoCs.

Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Yakir Yang <ykk@rock-chips.com>
---
Changes in v9:
- Removed the unused the variable "res" in probe function. (Heiko)
- Removed the unused head file.

Changes in v8:
- Fix the mixed spacers on macro definitions. (Heiko)
- Remove the unnecessary empty line after clk_prepare_enable. (Heiko)

Changes in v7:
- Simply the commit message. (Kishon)
- Symmetrical enable/disbale the phy clock and power. (Kishon)

Changes in v6: None
Changes in v5:
- Remove "reg" DT property, cause driver could poweron/poweroff phy via
  the exist "grf" syscon already. And rename the example DT node from
  "edp_phy: phy at ff770274" to "edp_phy: edp-phy" directly. (Heiko)
- Add deivce_node at the front of driver, update phy_ops type from "static
  struct" to "static const struct". And correct the input paramters of
  devm_phy_create() interfaces. (Heiko)

Changes in v4:
- Add commit message, and remove the redundant rockchip_dp_phy_init()
  function, move those code to probe() method. And remove driver .owner
  number. (Kishon)

Changes in v3:
- Suggest, add rockchip dp phy driver, collect the phy clocks and
  power control. (Heiko)

Changes in v2: None

 drivers/phy/Kconfig           |   7 ++
 drivers/phy/Makefile          |   1 +
 drivers/phy/phy-rockchip-dp.c | 151 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 159 insertions(+)
 create mode 100644 drivers/phy/phy-rockchip-dp.c

diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index 7eb5859d..7355819 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -319,6 +319,13 @@ config PHY_ROCKCHIP_USB
 	help
 	  Enable this to support the Rockchip USB 2.0 PHY.
 
+config PHY_ROCKCHIP_DP
+	tristate "Rockchip Display Port PHY Driver"
+	depends on ARCH_ROCKCHIP && OF
+	select GENERIC_PHY
+	help
+	  Enable this to support the Rockchip Display Port PHY.
+
 config PHY_ST_SPEAR1310_MIPHY
 	tristate "ST SPEAR1310-MIPHY driver"
 	select GENERIC_PHY
diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
index 075db1a..b1700cd 100644
--- a/drivers/phy/Makefile
+++ b/drivers/phy/Makefile
@@ -35,6 +35,7 @@ phy-exynos-usb2-$(CONFIG_PHY_S5PV210_USB2)	+= phy-s5pv210-usb2.o
 obj-$(CONFIG_PHY_EXYNOS5_USBDRD)	+= phy-exynos5-usbdrd.o
 obj-$(CONFIG_PHY_QCOM_APQ8064_SATA)	+= phy-qcom-apq8064-sata.o
 obj-$(CONFIG_PHY_ROCKCHIP_USB) += phy-rockchip-usb.o
+obj-$(CONFIG_PHY_ROCKCHIP_DP)		+= phy-rockchip-dp.o
 obj-$(CONFIG_PHY_QCOM_IPQ806X_SATA)	+= phy-qcom-ipq806x-sata.o
 obj-$(CONFIG_PHY_ST_SPEAR1310_MIPHY)	+= phy-spear1310-miphy.o
 obj-$(CONFIG_PHY_ST_SPEAR1340_MIPHY)	+= phy-spear1340-miphy.o
diff --git a/drivers/phy/phy-rockchip-dp.c b/drivers/phy/phy-rockchip-dp.c
new file mode 100644
index 0000000..f3e0058
--- /dev/null
+++ b/drivers/phy/phy-rockchip-dp.c
@@ -0,0 +1,151 @@
+/*
+ * Rockchip DP PHY driver
+ *
+ * Copyright (C) 2015 FuZhou Rockchip Co., Ltd.
+ * Author: Yakir Yang <ykk@@rock-chips.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License.
+ */
+
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/clk.h>
+#include <linux/phy/phy.h>
+#include <linux/regmap.h>
+#include <linux/mfd/syscon.h>
+#include <linux/platform_device.h>
+
+#define GRF_SOC_CON12                           0x0274
+
+#define GRF_EDP_REF_CLK_SEL_INTER_HIWORD_MASK   BIT(4)
+#define GRF_EDP_REF_CLK_SEL_INTER               BIT(4)
+
+#define GRF_EDP_PHY_SIDDQ_HIWORD_MASK           BIT(21)
+#define GRF_EDP_PHY_SIDDQ_ON                    0
+#define GRF_EDP_PHY_SIDDQ_OFF                   BIT(5)
+
+struct rockchip_dp_phy {
+	struct device  *dev;
+	struct regmap  *grf;
+	struct clk     *phy_24m;
+};
+
+static int rockchip_set_phy_state(struct phy *phy, bool enable)
+{
+	struct rockchip_dp_phy *dp = phy_get_drvdata(phy);
+	int ret;
+
+	if (enable) {
+		ret = regmap_write(dp->grf, GRF_SOC_CON12,
+				   GRF_EDP_PHY_SIDDQ_HIWORD_MASK |
+				   GRF_EDP_PHY_SIDDQ_ON);
+		if (ret < 0) {
+			dev_err(dp->dev, "Can't enable PHY power %d\n", ret);
+			return ret;
+		}
+
+		ret = clk_prepare_enable(dp->phy_24m);
+	} else {
+		clk_disable_unprepare(dp->phy_24m);
+
+		ret = regmap_write(dp->grf, GRF_SOC_CON12,
+				   GRF_EDP_PHY_SIDDQ_HIWORD_MASK |
+				   GRF_EDP_PHY_SIDDQ_OFF);
+	}
+
+	return ret;
+}
+
+static int rockchip_dp_phy_power_on(struct phy *phy)
+{
+	return rockchip_set_phy_state(phy, true);
+}
+
+static int rockchip_dp_phy_power_off(struct phy *phy)
+{
+	return rockchip_set_phy_state(phy, false);
+}
+
+static const struct phy_ops rockchip_dp_phy_ops = {
+	.power_on	= rockchip_dp_phy_power_on,
+	.power_off	= rockchip_dp_phy_power_off,
+	.owner		= THIS_MODULE,
+};
+
+static int rockchip_dp_phy_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct phy_provider *phy_provider;
+	struct rockchip_dp_phy *dp;
+	struct phy *phy;
+	int ret;
+
+	if (!np)
+		return -ENODEV;
+
+	dp = devm_kzalloc(dev, sizeof(*dp), GFP_KERNEL);
+	if (IS_ERR(dp))
+		return -ENOMEM;
+
+	dp->dev = dev;
+
+	dp->phy_24m = devm_clk_get(dev, "24m");
+	if (IS_ERR(dp->phy_24m)) {
+		dev_err(dev, "cannot get clock 24m\n");
+		return PTR_ERR(dp->phy_24m);
+	}
+
+	ret = clk_set_rate(dp->phy_24m, 24000000);
+	if (ret < 0) {
+		dev_err(dp->dev, "cannot set clock phy_24m %d\n", ret);
+		return ret;
+	}
+
+	dp->grf = syscon_regmap_lookup_by_phandle(np, "rockchip,grf");
+	if (IS_ERR(dp->grf)) {
+		dev_err(dev, "rk3288-dp needs rockchip,grf property\n");
+		return PTR_ERR(dp->grf);
+	}
+
+	ret = regmap_write(dp->grf, GRF_SOC_CON12, GRF_EDP_REF_CLK_SEL_INTER |
+			   GRF_EDP_REF_CLK_SEL_INTER_HIWORD_MASK);
+	if (ret != 0) {
+		dev_err(dp->dev, "Could not config GRF edp ref clk: %d\n", ret);
+		return ret;
+	}
+
+	phy = devm_phy_create(dev, np, &rockchip_dp_phy_ops);
+	if (IS_ERR(phy)) {
+		dev_err(dev, "failed to create phy\n");
+		return PTR_ERR(phy);
+	}
+	phy_set_drvdata(phy, dp);
+
+	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+
+	return PTR_ERR_OR_ZERO(phy_provider);
+}
+
+static const struct of_device_id rockchip_dp_phy_dt_ids[] = {
+	{ .compatible = "rockchip,rk3288-dp-phy" },
+	{}
+};
+
+MODULE_DEVICE_TABLE(of, rockchip_dp_phy_dt_ids);
+
+static struct platform_driver rockchip_dp_phy_driver = {
+	.probe		= rockchip_dp_phy_probe,
+	.driver		= {
+		.name	= "rockchip-dp-phy",
+		.of_match_table = rockchip_dp_phy_dt_ids,
+	},
+};
+
+module_platform_driver(rockchip_dp_phy_driver);
+
+MODULE_AUTHOR("Yakir Yang <ykk@rock-chips.com>");
+MODULE_DESCRIPTION("Rockchip DP PHY driver");
+MODULE_LICENSE("GPL v2");
-- 
1.9.1
