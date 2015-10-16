From: andrew-ct.chen@mediatek.com (andrew-ct.chen at mediatek.com)
Date: Fri, 16 Oct 2015 16:39:10 +0800
Subject: [PATCH 2/3] nvmem: mediatek: Add Mediatek EFUSE driver
In-Reply-To: <1444984751-4572-1-git-send-email-andrew-ct.chen@mediatek.com>
References: <1444984751-4572-1-git-send-email-andrew-ct.chen@mediatek.com>
Message-ID: <1444984751-4572-3-git-send-email-andrew-ct.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrew-CT Chen <andrew-ct.chen@mediatek.com>

Add Mediatek EFUSE driver to access hardware data like
thermal sensor calibration or HDMI impedance.

Signed-off-by: Andrew-CT Chen <andrew-ct.chen@mediatek.com>
---
 drivers/nvmem/Kconfig     | 11 ++++++
 drivers/nvmem/Makefile    |  1 +
 drivers/nvmem/mtk-efuse.c | 89 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 101 insertions(+)
 create mode 100644 drivers/nvmem/mtk-efuse.c

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index 8db2978..1bd5badc 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -14,6 +14,17 @@ menuconfig NVMEM
 
 if NVMEM
 
+config MTK_EFUSE
+	tristate "Mediatek SoCs EFUSE support"
+	depends on ARCH_MEDIATEK || COMPILE_TEST
+	select REGMAP_MMIO
+	help
+	  This is a driver to access hardware related data like sensor
+	  calibration, HDMI impedance etc.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called efuse-mtk.
+
 config QCOM_QFPROM
 	tristate "QCOM QFPROM Support"
 	depends on ARCH_QCOM || COMPILE_TEST
diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
index 4328b93..916b727 100644
--- a/drivers/nvmem/Makefile
+++ b/drivers/nvmem/Makefile
@@ -6,6 +6,7 @@ obj-$(CONFIG_NVMEM)		+= nvmem_core.o
 nvmem_core-y			:= core.o
 
 # Devices
+obj-$(CONFIG_MTK_EFUSE)		+= mtk-efuse.o
 obj-$(CONFIG_QCOM_QFPROM)	+= nvmem_qfprom.o
 nvmem_qfprom-y			:= qfprom.o
 obj-$(CONFIG_NVMEM_SUNXI_SID)	+= nvmem_sunxi_sid.o
diff --git a/drivers/nvmem/mtk-efuse.c b/drivers/nvmem/mtk-efuse.c
new file mode 100644
index 0000000..9021c0b
--- /dev/null
+++ b/drivers/nvmem/mtk-efuse.c
@@ -0,0 +1,89 @@
+/*
+ * Copyright (c) 2015 MediaTek Inc.
+ * Author: Andrew-CT Chen <andrew-ct.chen@mediatek.com>
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
+#include <linux/module.h>
+#include <linux/nvmem-provider.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+static struct regmap_config mtk_regmap_config = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+};
+
+static int mtk_efuse_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct resource *res;
+	struct nvmem_device *nvmem;
+	struct nvmem_config *econfig;
+	struct regmap *regmap;
+	void __iomem *base;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	econfig = devm_kzalloc(dev, sizeof(*econfig), GFP_KERNEL);
+	if (!econfig)
+		return -ENOMEM;
+
+	mtk_regmap_config.max_register = resource_size(res) - 1;
+
+	regmap = devm_regmap_init_mmio(dev, base, &mtk_regmap_config);
+	if (IS_ERR(regmap)) {
+		dev_err(dev, "regmap init failed\n");
+		return PTR_ERR(regmap);
+	}
+
+	econfig->dev = dev;
+	econfig->owner = THIS_MODULE;
+	nvmem = nvmem_register(econfig);
+	if (IS_ERR(nvmem))
+		return PTR_ERR(nvmem);
+
+	platform_set_drvdata(pdev, nvmem);
+
+	return 0;
+}
+
+static int mtk_efuse_remove(struct platform_device *pdev)
+{
+	struct nvmem_device *nvmem = platform_get_drvdata(pdev);
+
+	return nvmem_unregister(nvmem);
+}
+
+static const struct of_device_id mtk_efuse_of_match[] = {
+	{ .compatible = "mediatek,mt8135-efuse",},
+	{ .compatible = "mediatek,mt8173-efuse",},
+	{/* sentinel */},
+};
+MODULE_DEVICE_TABLE(of, mtk_efuse_of_match);
+
+static struct platform_driver mtk_efuse_driver = {
+	.probe = mtk_efuse_probe,
+	.remove = mtk_efuse_remove,
+	.driver = {
+		.name = "mediatek,efuse",
+		.of_match_table = mtk_efuse_of_match,
+	},
+};
+module_platform_driver(mtk_efuse_driver);
+MODULE_AUTHOR("Andrew-CT Chen <andrew-ct.chen@mediatek.com>");
+MODULE_DESCRIPTION("Mediatek EFUSE driver");
+MODULE_LICENSE("GPL v2");
-- 
1.9.1
