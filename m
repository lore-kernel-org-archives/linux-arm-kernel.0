From: hayashibara.keiji@socionext.com (Keiji Hayashibara)
Date: Fri,  1 Sep 2017 08:20:19 +0900
Subject: [PATCH v1 2/3] nvmem: uniphier: add UniPhier eFuse driver
In-Reply-To: <1504221620-358-1-git-send-email-hayashibara.keiji@socionext.com>
References: <1504221620-358-1-git-send-email-hayashibara.keiji@socionext.com>
Message-ID: <1504221620-358-3-git-send-email-hayashibara.keiji@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add eFuse driver for Socionext UniPhier series SoC.
Note that eFuse device is under soc-glue and this register
implements as read only.

Signed-off-by: Keiji Hayashibara <hayashibara.keiji@socionext.com>
---
 arch/arm64/configs/defconfig   |  1 +
 drivers/nvmem/Kconfig          | 11 +++++
 drivers/nvmem/Makefile         |  2 +
 drivers/nvmem/uniphier-efuse.c | 98 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 112 insertions(+)
 create mode 100644 drivers/nvmem/uniphier-efuse.c

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 6c7d147..5c38b4a 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -514,6 +514,7 @@ CONFIG_PHY_XGENE=y
 CONFIG_PHY_TEGRA_XUSB=y
 CONFIG_QCOM_L2_PMU=y
 CONFIG_QCOM_L3_PMU=y
+CONFIG_UNIPHIER_EFUSE=y
 CONFIG_ARM_SCPI_PROTOCOL=y
 CONFIG_RASPBERRYPI_FIRMWARE=y
 CONFIG_EFI_CAPSULE_LOADER=y
diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index 101ced4..aaeaebe 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -123,6 +123,17 @@ config NVMEM_SUNXI_SID
 	  This driver can also be built as a module. If so, the module
 	  will be called nvmem_sunxi_sid.
 
+config UNIPHIER_EFUSE
+	tristate "UniPhier SoCs eFuse support"
+	depends on ARCH_UNIPHIER || COMPILE_TEST
+	depends on OF && MFD_SYSCON
+	help
+	  This is a simple drive to dump specified values of UniPhier SoC
+	  from eFuse.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called nvmem_uniphier-efuse.
+
 config NVMEM_VF610_OCOTP
 	tristate "VF610 SoC OCOTP support"
 	depends on SOC_VF610 || COMPILE_TEST
diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
index 1731406..f5277c3 100644
--- a/drivers/nvmem/Makefile
+++ b/drivers/nvmem/Makefile
@@ -26,6 +26,8 @@ obj-$(CONFIG_ROCKCHIP_EFUSE)	+= nvmem_rockchip_efuse.o
 nvmem_rockchip_efuse-y		:= rockchip-efuse.o
 obj-$(CONFIG_NVMEM_SUNXI_SID)	+= nvmem_sunxi_sid.o
 nvmem_sunxi_sid-y		:= sunxi_sid.o
+obj-$(CONFIG_UNIPHIER_EFUSE)	+= nvmem_uniphier-efuse.o
+nvmem_uniphier-efuse-y		:= uniphier-efuse.o
 obj-$(CONFIG_NVMEM_VF610_OCOTP)	+= nvmem-vf610-ocotp.o
 nvmem-vf610-ocotp-y		:= vf610-ocotp.o
 obj-$(CONFIG_MESON_EFUSE)	+= nvmem_meson_efuse.o
diff --git a/drivers/nvmem/uniphier-efuse.c b/drivers/nvmem/uniphier-efuse.c
new file mode 100644
index 0000000..d553fa3
--- /dev/null
+++ b/drivers/nvmem/uniphier-efuse.c
@@ -0,0 +1,98 @@
+/*
+ * UniPhier eFuse driver
+ *
+ * Copyright (C) 2017 Socionext Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/nvmem-provider.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#define UNIPHIER_EFUSE_WORD_SIZE	4
+#define UNIPHIER_EFUSE_STRIDE		4
+
+static int uniphier_reg_read(void *context,
+			     unsigned int offset, void *val, size_t bytes)
+{
+	int words = bytes / UNIPHIER_EFUSE_WORD_SIZE;
+
+	return regmap_bulk_read(context, offset, val, words);
+}
+
+static struct nvmem_config econfig = {
+	.name = "uniphier-efuse",
+	.owner = THIS_MODULE,
+	.read_only = true,
+	.reg_read = uniphier_reg_read,
+	.word_size = UNIPHIER_EFUSE_WORD_SIZE,
+	.stride = UNIPHIER_EFUSE_STRIDE,
+};
+
+static int uniphier_efuse_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct nvmem_device *nvmem;
+	struct regmap *regmap;
+	struct resource res;
+	int ret;
+
+	ret = of_address_to_resource(dev->of_node, 0, &res);
+	if (ret)
+		return ret;
+
+	regmap = syscon_node_to_regmap(dev->of_node);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	econfig.size = resource_size(&res);
+	econfig.priv = regmap;
+	econfig.dev = dev;
+
+	nvmem = nvmem_register(&econfig);
+	if (IS_ERR(nvmem))
+		return PTR_ERR(nvmem);
+
+	platform_set_drvdata(pdev, nvmem);
+
+	return 0;
+}
+
+static int uniphier_efuse_remove(struct platform_device *pdev)
+{
+	struct nvmem_device *nvmem = platform_get_drvdata(pdev);
+
+	return nvmem_unregister(nvmem);
+}
+
+static const struct of_device_id uniphier_efuse_of_match[] = {
+	{ .compatible = "socionext,uniphier-efuse",},
+	{/* sentinel */},
+};
+MODULE_DEVICE_TABLE(of, uniphier_efuse_of_match);
+
+static struct platform_driver uniphier_efuse_driver = {
+	.probe = uniphier_efuse_probe,
+	.remove = uniphier_efuse_remove,
+	.driver = {
+		.name = "uniphier-efuse",
+		.of_match_table = uniphier_efuse_of_match,
+	},
+};
+module_platform_driver(uniphier_efuse_driver);
+
+MODULE_AUTHOR("Keiji Hayashibara <hayashibara.keiji@socionext.com>");
+MODULE_DESCRIPTION("UniPhier eFuse driver");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4
