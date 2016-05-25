From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Wed, 25 May 2016 13:28:23 +0530
Subject: [PATCH v6 1/2] soc: samsung: add exynos chipid driver support
In-Reply-To: <1464163104-8163-1-git-send-email-pankaj.dubey@samsung.com>
References: <1464163104-8163-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <1464163104-8163-2-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Exynos SoCs have Chipid, for identification of product IDs
and SoC revisions. This patch intends to provide initialization
code for all these functionalities, at the same time it provides some
sysfs entries for accessing these information to user-space.

This driver uses existing binding for exynos-chipid.

CC: Grant Likely <grant.likely@linaro.org>
CC: Rob Herring <robh+dt@kernel.org>
CC: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 drivers/soc/samsung/Kconfig            |   5 +
 drivers/soc/samsung/Makefile           |   1 +
 drivers/soc/samsung/exynos-chipid.c    | 172 +++++++++++++++++++++++++++++++++
 include/linux/soc/samsung/exynos-soc.h |  51 ++++++++++
 4 files changed, 229 insertions(+)
 create mode 100644 drivers/soc/samsung/exynos-chipid.c
 create mode 100644 include/linux/soc/samsung/exynos-soc.h

diff --git a/drivers/soc/samsung/Kconfig b/drivers/soc/samsung/Kconfig
index d7fc123..fc793f3 100644
--- a/drivers/soc/samsung/Kconfig
+++ b/drivers/soc/samsung/Kconfig
@@ -10,4 +10,9 @@ config EXYNOS_PMU
 	bool "Exynos PMU controller driver" if COMPILE_TEST
 	depends on (ARM && ARCH_EXYNOS) || ((ARM || ARM64) && COMPILE_TEST)
 
+config EXYNOS_CHIPID
+	bool "Exynos Chipid controller driver" if COMPILE_TEST
+	depends on (ARM && ARCH_EXYNOS) || ((ARM || ARM64) && COMPILE_TEST)
+	select SOC_BUS
+
 endif
diff --git a/drivers/soc/samsung/Makefile b/drivers/soc/samsung/Makefile
index f64ac4d..81023ed 100644
--- a/drivers/soc/samsung/Makefile
+++ b/drivers/soc/samsung/Makefile
@@ -1,2 +1,3 @@
 obj-$(CONFIG_EXYNOS_PMU)	+= exynos-pmu.o exynos3250-pmu.o exynos4-pmu.o \
 					exynos5250-pmu.o exynos5420-pmu.o
+obj-$(CONFIG_EXYNOS_CHIPID)	+= exynos-chipid.o
diff --git a/drivers/soc/samsung/exynos-chipid.c b/drivers/soc/samsung/exynos-chipid.c
new file mode 100644
index 0000000..fa20fdd
--- /dev/null
+++ b/drivers/soc/samsung/exynos-chipid.c
@@ -0,0 +1,172 @@
+/*
+ * Copyright (c) 2016 Samsung Electronics Co., Ltd.
+ *	      http://www.samsung.com/
+ *
+ * EXYNOS - CHIP ID support
+ * Author: Pankaj Dubey <pankaj.dubey@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/sys_soc.h>
+#include <linux/soc/samsung/exynos-soc.h>
+
+#define EXYNOS_SUBREV_MASK	(0xF << 4)
+#define EXYNOS_MAINREV_MASK	(0xF << 0)
+#define EXYNOS_REV_MASK		(EXYNOS_SUBREV_MASK | EXYNOS_MAINREV_MASK)
+
+static void __iomem *exynos_chipid_base;
+
+struct exynos_chipid_info exynos_soc_info;
+EXPORT_SYMBOL(exynos_soc_info);
+
+static const char * __init product_id_to_name(unsigned int product_id)
+{
+	const char *soc_name;
+	unsigned int soc_id = product_id & EXYNOS_SOC_MASK;
+
+	switch (soc_id) {
+	case EXYNOS3250_SOC_ID:
+		soc_name = "EXYNOS3250";
+		break;
+	case EXYNOS4210_SOC_ID:
+		soc_name = "EXYNOS4210";
+		break;
+	case EXYNOS4212_SOC_ID:
+		soc_name = "EXYNOS4212";
+		break;
+	case EXYNOS4412_SOC_ID:
+		soc_name = "EXYNOS4412";
+		break;
+	case EXYNOS4415_SOC_ID:
+		soc_name = "EXYNOS4415";
+		break;
+	case EXYNOS5250_SOC_ID:
+		soc_name = "EXYNOS5250";
+		break;
+	case EXYNOS5260_SOC_ID:
+		soc_name = "EXYNOS5260";
+		break;
+	case EXYNOS5420_SOC_ID:
+		soc_name = "EXYNOS5420";
+		break;
+	case EXYNOS5440_SOC_ID:
+		soc_name = "EXYNOS5440";
+		break;
+	case EXYNOS5800_SOC_ID:
+		soc_name = "EXYNOS5800";
+		break;
+	default:
+		soc_name = "UNKNOWN";
+	}
+	return soc_name;
+}
+
+static const struct of_device_id of_exynos_chipid_ids[] = {
+	{
+		.compatible	= "samsung,exynos4210-chipid",
+	},
+	{},
+};
+
+/**
+ *  exynos_chipid_early_init: Early chipid initialization
+ *  @dev: pointer to chipid device
+ */
+int __init exynos_chipid_early_init(struct device *dev)
+{
+	struct device_node *np;
+	const struct of_device_id *match;
+
+	if (exynos_chipid_base)
+		return 0;
+
+	if (!dev)
+		np = of_find_matching_node_and_match(NULL,
+			of_exynos_chipid_ids, &match);
+	else
+		np = dev->of_node;
+
+	if (!np)
+		return -ENODEV;
+
+	exynos_chipid_base = of_iomap(np, 0);
+
+	if (!exynos_chipid_base)
+		return PTR_ERR(exynos_chipid_base);
+	
+	exynos_soc_info.product_id  = __raw_readl(exynos_chipid_base);
+	exynos_soc_info.revision = exynos_soc_info.product_id & EXYNOS_REV_MASK;
+
+	return 0;
+}
+
+static int __init exynos_chipid_probe(struct platform_device *pdev)
+{
+	struct soc_device_attribute *soc_dev_attr;
+	struct soc_device *soc_dev;
+	struct device_node *root;
+	int ret;
+
+	ret = exynos_chipid_early_init(&pdev->dev);
+	if (ret) {
+		dev_dbg(&pdev->dev, "Exynos chipid probe failed: %d\n", ret);
+		return ret;
+	}
+
+	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
+	if (!soc_dev_attr)
+		return -ENODEV;
+
+	soc_dev_attr->family = "Samsung Exynos";
+
+	root = of_find_node_by_path("/");
+	ret = of_property_read_string(root, "model", &soc_dev_attr->machine);
+	of_node_put(root);
+	if (ret)
+		goto free_soc;
+
+	soc_dev_attr->revision = kasprintf(GFP_KERNEL, "%d",
+					exynos_soc_info.revision);
+	if (!soc_dev_attr->revision)
+		goto free_soc;
+
+	soc_dev_attr->soc_id = product_id_to_name(exynos_soc_info.product_id);
+
+	soc_dev = soc_device_register(soc_dev_attr);
+	if (IS_ERR(soc_dev))
+		goto free_rev;
+
+	soc_device_to_device(soc_dev);
+
+	dev_info(&pdev->dev, "Exynos: CPU[%s] CPU_REV[0x%x] Detected\n",
+			product_id_to_name(exynos_soc_info.product_id),
+			exynos_soc_info.revision);
+	return 0;
+free_rev:
+	kfree(soc_dev_attr->revision);
+free_soc:
+	kfree(soc_dev_attr);
+	return -EINVAL;
+}
+
+static struct platform_driver exynos_chipid_driver = {
+	.driver = {
+		.name = "exynos-chipid",
+		.of_match_table = of_exynos_chipid_ids,
+	},
+};
+
+static int __init exynos_chipid_init(void)
+{
+	return platform_driver_probe(&exynos_chipid_driver, exynos_chipid_probe);
+}
+device_initcall(exynos_chipid_init);
diff --git a/include/linux/soc/samsung/exynos-soc.h b/include/linux/soc/samsung/exynos-soc.h
new file mode 100644
index 0000000..38b95ad
--- /dev/null
+++ b/include/linux/soc/samsung/exynos-soc.h
@@ -0,0 +1,51 @@
+/*
+ * Copyright (c) 2016 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * Header for EXYNOS SoC Chipid support
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __EXYNOS_SOC_H
+#define __EXYNOS_SOC_H
+
+#define EXYNOS3250_SOC_ID	0xE3472000
+#define EXYNOS4210_SOC_ID	0x43210000
+#define EXYNOS4212_SOC_ID	0x43220000
+#define EXYNOS4412_SOC_ID	0xE4412000
+#define EXYNOS4415_SOC_ID	0xE4415000
+#define EXYNOS5250_SOC_ID	0x43520000
+#define EXYNOS5260_SOC_ID	0xE5260000
+#define EXYNOS5410_SOC_ID	0xE5410000
+#define EXYNOS5420_SOC_ID	0xE5420000
+#define EXYNOS5440_SOC_ID	0xE5440000
+#define EXYNOS5800_SOC_ID	0xE5422000
+
+#define EXYNOS_SOC_MASK		0xFFFFF000
+
+#define EXYNOS4210_REV_0	0x0
+#define EXYNOS4210_REV_1_0	0x10
+#define EXYNOS4210_REV_1_1	0x11
+
+/**
+ * Struct exynos_chipid_info
+ * @soc_product_id: product id allocated to exynos SoC
+ * @soc_revision: revision of exynos SoC
+ */
+
+struct exynos_chipid_info {
+	u32 product_id;
+	u32 revision;
+};
+
+extern struct exynos_chipid_info exynos_soc_info;
+
+/* Since we need chipid to be initialized as early as possible
+ * during secondary core bootup adding early initialization function
+ */
+extern int exynos_chipid_early_init(struct device *dev);
+
+#endif /* __EXYNOS_SOC_H */
-- 
2.4.5
