From: hayashibara.keiji@socionext.com (Keiji Hayashibara)
Date: Fri,  6 Oct 2017 14:02:59 +0900
Subject: [PATCH v2 2/3] nvmem: uniphier: add UniPhier eFuse driver
In-Reply-To: <1507266180-11840-1-git-send-email-hayashibara.keiji@socionext.com>
References: <1507266180-11840-1-git-send-email-hayashibara.keiji@socionext.com>
Message-ID: <1507266180-11840-3-git-send-email-hayashibara.keiji@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add eFuse driver for Socionext UniPhier series SoC.
Note that eFuse device is under soc-glue and this register
implements as read only.

Signed-off-by: Keiji Hayashibara <hayashibara.keiji@socionext.com>
---
 drivers/nvmem/Kconfig          | 11 +++++
 drivers/nvmem/Makefile         |  2 +
 drivers/nvmem/uniphier-efuse.c | 97 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 110 insertions(+)
 create mode 100644 drivers/nvmem/uniphier-efuse.c

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index 101ced4..9c32cfe 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -123,6 +123,17 @@ config NVMEM_SUNXI_SID
 	  This driver can also be built as a module. If so, the module
 	  will be called nvmem_sunxi_sid.
 
+config UNIPHIER_EFUSE
+	tristate "UniPhier SoCs eFuse support"
+	depends on ARCH_UNIPHIER || COMPILE_TEST
+	depends on HAS_IOMEM
+	help
+	  This is a simple driver to dump specified values of UniPhier SoC
+	  from eFuse.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called nvmem-uniphier-efuse.
+
 config NVMEM_VF610_OCOTP
 	tristate "VF610 SoC OCOTP support"
 	depends on SOC_VF610 || COMPILE_TEST
diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
index 1731406..2d07162 100644
--- a/drivers/nvmem/Makefile
+++ b/drivers/nvmem/Makefile
@@ -26,6 +26,8 @@ obj-$(CONFIG_ROCKCHIP_EFUSE)	+= nvmem_rockchip_efuse.o
 nvmem_rockchip_efuse-y		:= rockchip-efuse.o
 obj-$(CONFIG_NVMEM_SUNXI_SID)	+= nvmem_sunxi_sid.o
 nvmem_sunxi_sid-y		:= sunxi_sid.o
+obj-$(CONFIG_UNIPHIER_EFUSE)	+= nvmem-uniphier-efuse.o
+nvmem-uniphier-efuse-y		:= uniphier-efuse.o
 obj-$(CONFIG_NVMEM_VF610_OCOTP)	+= nvmem-vf610-ocotp.o
 nvmem-vf610-ocotp-y		:= vf610-ocotp.o
 obj-$(CONFIG_MESON_EFUSE)	+= nvmem_meson_efuse.o
diff --git a/drivers/nvmem/uniphier-efuse.c b/drivers/nvmem/uniphier-efuse.c
new file mode 100644
index 0000000..2bb45c4
--- /dev/null
+++ b/drivers/nvmem/uniphier-efuse.c
@@ -0,0 +1,97 @@
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
+#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/nvmem-provider.h>
+#include <linux/platform_device.h>
+
+struct uniphier_efuse_priv {
+	void __iomem *base;
+};
+
+static int uniphier_reg_read(void *context,
+			     unsigned int reg, void *_val, size_t bytes)
+{
+	struct uniphier_efuse_priv *priv = context;
+	u32 *val = _val;
+	int offs;
+
+	for (offs = 0; offs < bytes; offs += sizeof(u32))
+		*val++ = readl(priv->base + reg + offs);
+
+	return 0;
+}
+
+static int uniphier_efuse_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct resource *res;
+	struct nvmem_device *nvmem;
+	struct nvmem_config econfig ={};
+	struct uniphier_efuse_priv *priv;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	priv->base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+
+	econfig.stride = 4;
+	econfig.word_size = 4;
+	econfig.read_only = true;
+	econfig.reg_read = uniphier_reg_read;
+	econfig.size = resource_size(res);
+	econfig.priv = priv;
+	econfig.dev = dev;
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
