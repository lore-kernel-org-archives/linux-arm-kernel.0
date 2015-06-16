From: wxt@rock-chips.com (Caesar Wang)
Date: Tue, 16 Jun 2015 15:27:44 +0800
Subject: [PATCH v2 2/3] soc/rockchip: efuse: Add Rockchip SoC efuse support
In-Reply-To: <1434439665-27781-1-git-send-email-wxt@rock-chips.com>
References: <1434439665-27781-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1434439665-27781-3-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add driver for efuse found on Rockchip RK3066,RK3188,RK3288 and
RK3368 SoCs.

eFuse is organized as 32bits by 8 one-time programmable
electrical fuses with random access interface.

Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
Signed-off-by: Caesar Wang <wxt@rock-chips.com>

---

Changes in v2:
- Move the efuse driver into driver/soc/vendor.
- update the efuse driver.

 drivers/soc/Makefile          |   1 +
 drivers/soc/rockchip/Makefile |   4 +
 drivers/soc/rockchip/efuse.c  | 212 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 217 insertions(+)
 create mode 100644 drivers/soc/rockchip/Makefile
 create mode 100644 drivers/soc/rockchip/efuse.c

diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index 70042b2..91f7f18 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -4,6 +4,7 @@
 
 obj-$(CONFIG_ARCH_MEDIATEK)	+= mediatek/
 obj-$(CONFIG_ARCH_QCOM)		+= qcom/
+obj-$(CONFIG_ARCH_ROCKCHIP)		+= rockchip/
 obj-$(CONFIG_ARCH_TEGRA)	+= tegra/
 obj-$(CONFIG_SOC_TI)		+= ti/
 obj-$(CONFIG_PLAT_VERSATILE)	+= versatile/
diff --git a/drivers/soc/rockchip/Makefile b/drivers/soc/rockchip/Makefile
new file mode 100644
index 0000000..4f5f9bd
--- /dev/null
+++ b/drivers/soc/rockchip/Makefile
@@ -0,0 +1,4 @@
+#
+# Rockchip Soc drivers
+#
+obj-$(CONFIG_ARCH_ROCKCHIP) += efuse.o
diff --git a/drivers/soc/rockchip/efuse.c b/drivers/soc/rockchip/efuse.c
new file mode 100644
index 0000000..1125320
--- /dev/null
+++ b/drivers/soc/rockchip/efuse.c
@@ -0,0 +1,212 @@
+/*
+ * Rockchip eFuse Driver
+ *
+ * Copyright (c) 2015 Rockchip Electronics Co. Ltd.
+ * Author: Jianqun Xu <jay.xu@rock-chips.com>
+ * Author: Caesar Wang <wxt@rock-chips.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ */
+
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+
+#define EFUSE_A_SHIFT			6
+#define EFUSE_A_MASK			0x3ff
+#define EFUSE_PGENB			BIT(3)
+#define EFUSE_LOAD			BIT(2)
+#define EFUSE_STROBE			BIT(1)
+#define EFUSE_CSB			BIT(0)
+
+#define REG_EFUSE_CTRL			0x0000
+#define REG_EFUSE_DOUT			0x0004
+
+#define EFUSE_BUF_SIZE			32
+#define EFUSE_CHIP_VERSION_OFFSET	6
+#define EFUSE_CHIP_VERSION_MASK		0xf
+#define EFUSE_BUF_LKG_CPU		23
+
+struct rockchip_efuse_info {
+	struct device *dev;
+	void __iomem *regs;
+	u32 buf[EFUSE_BUF_SIZE];
+};
+
+static void efuse_writel(struct rockchip_efuse_info *efuse,
+			 unsigned int value,
+			 unsigned int offset)
+{
+	writel_relaxed(value, efuse->regs + offset);
+}
+
+static unsigned int efuse_readl(struct rockchip_efuse_info *efuse,
+				unsigned int offset)
+{
+	return readl_relaxed(efuse->regs + offset);
+}
+
+int rockchip_efuse_get_cpuleakage(struct platform_device *pdev,
+				  unsigned int *value)
+{
+	struct rockchip_efuse_info *efuse;
+
+	efuse = platform_get_drvdata(pdev);
+	if (!efuse)
+		return -EAGAIN;
+
+	*value = efuse->buf[EFUSE_BUF_LKG_CPU];
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(rockchip_efuse_get_cpuleakage);
+
+int rockchip_efuse_get_chip_version(struct platform_device *pdev,
+				    unsigned int *value)
+{
+	struct rockchip_efuse_info *efuse;
+
+	efuse = platform_get_drvdata(pdev);
+	if (!efuse)
+		return -EAGAIN;
+
+	*value = efuse->buf[EFUSE_CHIP_VERSION_OFFSET] &
+			EFUSE_CHIP_VERSION_MASK;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(rockchip_efuse_get_chip_version);
+
+static ssize_t cpu_leakage_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	int leakage;
+	int ret;
+	struct platform_device *pdev = to_platform_device(dev);
+
+	ret = rockchip_efuse_get_cpuleakage(pdev, &leakage);
+	if (ret)
+		return ret;
+
+	return sprintf(buf, "%d\n", leakage);
+}
+
+static ssize_t cpu_version_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	int version;
+	int ret;
+	struct platform_device *pdev = to_platform_device(dev);
+
+	ret = rockchip_efuse_get_chip_version(pdev, &version);
+	if (ret)
+		return ret;
+
+	return sprintf(buf, "%d\n", version);
+}
+
+static void rockchip_efuse_init(struct rockchip_efuse_info *efuse)
+{
+	unsigned int start;
+
+	efuse_writel(efuse, EFUSE_LOAD | EFUSE_PGENB, REG_EFUSE_CTRL);
+	udelay(1);
+
+	for (start = 0; start <= EFUSE_BUF_SIZE; start++) {
+		efuse_writel(efuse, efuse_readl(efuse, REG_EFUSE_CTRL) &
+			     (~(EFUSE_A_MASK << EFUSE_A_SHIFT)),
+			     REG_EFUSE_CTRL);
+		efuse_writel(efuse, efuse_readl(efuse, REG_EFUSE_CTRL) |
+			     ((start & EFUSE_A_MASK) << EFUSE_A_SHIFT),
+			     REG_EFUSE_CTRL);
+		udelay(1);
+		efuse_writel(efuse, efuse_readl(efuse, REG_EFUSE_CTRL) |
+			     EFUSE_STROBE, REG_EFUSE_CTRL);
+		udelay(1);
+
+		efuse->buf[start] = efuse_readl(efuse, REG_EFUSE_DOUT);
+
+		efuse_writel(efuse, efuse_readl(efuse, REG_EFUSE_CTRL) &
+			     (~EFUSE_STROBE), REG_EFUSE_CTRL);
+		udelay(1);
+	}
+
+	/* Switch to standby mode */
+	efuse_writel(efuse, EFUSE_PGENB | EFUSE_CSB, REG_EFUSE_CTRL);
+}
+
+static DEVICE_ATTR(cpu_leakage_show, 0444, cpu_leakage_show, NULL);
+static DEVICE_ATTR(cpu_version_show, 0444, cpu_version_show, NULL);
+
+static struct attribute *efuse_attributes[] = {
+	&dev_attr_cpu_leakage_show.attr,
+	&dev_attr_cpu_version_show.attr,
+	NULL,
+};
+
+static const struct attribute_group efuse_attr_group = {
+	.attrs = efuse_attributes,
+};
+
+static int rockchip_efuse_probe(struct platform_device *pdev)
+{
+	struct rockchip_efuse_info *efuse;
+	struct resource *mem;
+	int ret;
+
+	efuse = devm_kzalloc(&pdev->dev, sizeof(struct rockchip_efuse_info),
+			     GFP_KERNEL);
+	if (!efuse)
+		return -ENOMEM;
+
+	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	efuse->regs = devm_ioremap_resource(&pdev->dev, mem);
+	if (IS_ERR(efuse->regs))
+		return PTR_ERR(efuse->regs);
+
+	efuse->dev = &pdev->dev;
+
+	rockchip_efuse_init(efuse);
+
+	/*
+	 * We set driver data only after fully initializing efuse
+	 * to make sure rockchip_efuse_get_cpuleakage() and
+	 * rockchip_efuse_get_cpu_version do not return garbage.
+	 */
+	platform_set_drvdata(pdev, efuse);
+
+	ret = sysfs_create_group(&efuse->dev->kobj, &efuse_attr_group);
+	if (ret) {
+		dev_err(efuse->dev,
+			"failed to register sysfs. err: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct of_device_id rockchip_efuse_match[] = {
+	{ .compatible = "rockchip,rk3066-efuse", },
+	{ /* sentinel */},
+};
+
+static struct platform_driver rockchip_efuse_driver = {
+	.probe = rockchip_efuse_probe,
+	.driver = {
+		.name = "rockchip-efuse",
+		.of_match_table = of_match_ptr(rockchip_efuse_match),
+		.suppress_bind_attrs = true,
+	},
+};
+
+module_platform_driver(rockchip_efuse_driver);
-- 
1.9.1
