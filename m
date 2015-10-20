From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Tue, 20 Oct 2015 14:45:37 +0530
Subject: [PATCH v5 6/8] drivers: soc: add support for exynos SROM driver
In-Reply-To: <1445332540-12814-1-git-send-email-pankaj.dubey@samsung.com>
References: <1445332540-12814-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <1445332540-12814-7-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds Exynos SROM controller driver which will handle
save restore of SROM registers during S2R.

Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 drivers/soc/Kconfig               |   1 +
 drivers/soc/Makefile              |   1 +
 drivers/soc/samsung/Kconfig       |  13 +++
 drivers/soc/samsung/Makefile      |   1 +
 drivers/soc/samsung/exynos-srom.c | 175 ++++++++++++++++++++++++++++++++++++++
 drivers/soc/samsung/exynos-srom.h |  51 +++++++++++
 6 files changed, 242 insertions(+)
 create mode 100644 drivers/soc/samsung/Kconfig
 create mode 100644 drivers/soc/samsung/Makefile
 create mode 100644 drivers/soc/samsung/exynos-srom.c
 create mode 100644 drivers/soc/samsung/exynos-srom.h

diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
index 96ddecb..69107c9 100644
--- a/drivers/soc/Kconfig
+++ b/drivers/soc/Kconfig
@@ -2,6 +2,7 @@ menu "SOC (System On Chip) specific Drivers"
 
 source "drivers/soc/mediatek/Kconfig"
 source "drivers/soc/qcom/Kconfig"
+source "drivers/soc/samsung/Kconfig"
 source "drivers/soc/sunxi/Kconfig"
 source "drivers/soc/ti/Kconfig"
 source "drivers/soc/versatile/Kconfig"
diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index 0b12d77..a623616 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -5,6 +5,7 @@
 obj-$(CONFIG_MACH_DOVE)		+= dove/
 obj-$(CONFIG_ARCH_MEDIATEK)	+= mediatek/
 obj-$(CONFIG_ARCH_QCOM)		+= qcom/
+obj-$(CONFIG_SOC_SAMSUNG)	+= samsung/
 obj-$(CONFIG_ARCH_SUNXI)	+= sunxi/
 obj-$(CONFIG_ARCH_TEGRA)	+= tegra/
 obj-$(CONFIG_SOC_TI)		+= ti/
diff --git a/drivers/soc/samsung/Kconfig b/drivers/soc/samsung/Kconfig
new file mode 100644
index 0000000..2833b5b
--- /dev/null
+++ b/drivers/soc/samsung/Kconfig
@@ -0,0 +1,13 @@
+#
+# SAMSUNG SoC drivers
+#
+menu "Samsung SOC driver support"
+
+config SOC_SAMSUNG
+	bool
+
+config EXYNOS_SROM
+	bool
+	depends on ARM && ARCH_EXYNOS && PM
+
+endmenu
diff --git a/drivers/soc/samsung/Makefile b/drivers/soc/samsung/Makefile
new file mode 100644
index 0000000..9c554d5
--- /dev/null
+++ b/drivers/soc/samsung/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_EXYNOS_SROM)	+= exynos-srom.o
diff --git a/drivers/soc/samsung/exynos-srom.c b/drivers/soc/samsung/exynos-srom.c
new file mode 100644
index 0000000..57a232d
--- /dev/null
+++ b/drivers/soc/samsung/exynos-srom.c
@@ -0,0 +1,175 @@
+/*
+ * Copyright (c) 2015 Samsung Electronics Co., Ltd.
+ *	      http://www.samsung.com/
+ *
+ * EXYNOS - SROM Controller support
+ * Author: Pankaj Dubey <pankaj.dubey@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#include "exynos-srom.h"
+
+static const unsigned long exynos_srom_offsets[] = {
+	/* SROM side */
+	EXYNOS_SROM_BW,
+	EXYNOS_SROM_BC0,
+	EXYNOS_SROM_BC1,
+	EXYNOS_SROM_BC2,
+	EXYNOS_SROM_BC3,
+};
+
+/**
+ * struct exynos_srom_reg_dump: register dump of SROM Controller registers.
+ * @offset: srom register offset from the controller base address.
+ * @value: the value of register under the offset.
+ */
+struct exynos_srom_reg_dump {
+	u32     offset;
+	u32     value;
+};
+
+/**
+ * struct exynos_srom: platform data for exynos srom controller driver.
+ * @dev: platform device pointer
+ * @reg_base: srom base address
+ * @reg_offset: exynos_srom_reg_dump pointer to hold offset and its value.
+ */
+struct exynos_srom {
+	struct device *dev;
+	void __iomem *reg_base;
+	struct exynos_srom_reg_dump *reg_offset;
+};
+
+static struct exynos_srom_reg_dump *exynos_srom_alloc_reg_dump(
+		const unsigned long *rdump,
+		unsigned long nr_rdump)
+{
+	struct exynos_srom_reg_dump *rd;
+	unsigned int i;
+
+	rd = kcalloc(nr_rdump, sizeof(*rd), GFP_KERNEL);
+	if (!rd)
+		return NULL;
+
+	for (i = 0; i < nr_rdump; ++i)
+		rd[i].offset = rdump[i];
+
+	return rd;
+}
+
+static int exynos_srom_probe(struct platform_device *pdev)
+{
+	struct device_node *np;
+	struct exynos_srom *srom;
+	struct device *dev = &pdev->dev;
+
+	np = dev->of_node;
+	if (!np) {
+		dev_err(&pdev->dev, "could not find device info\n");
+		return -EINVAL;
+	}
+
+	srom = devm_kzalloc(&pdev->dev,
+			sizeof(struct exynos_srom), GFP_KERNEL);
+	if (!srom)
+		return -ENOMEM;
+
+	srom->dev = dev;
+	srom->reg_base = of_iomap(np, 0);
+	if (!srom->reg_base) {
+		dev_err(&pdev->dev, "iomap of exynos srom controller failed\n");
+		return -ENOMEM;
+	}
+
+	platform_set_drvdata(pdev, srom);
+
+	srom->reg_offset = exynos_srom_alloc_reg_dump(exynos_srom_offsets,
+			sizeof(exynos_srom_offsets));
+	if (!srom->reg_offset) {
+		iounmap(srom->reg_base);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static int exynos_srom_remove(struct platform_device *pdev)
+{
+	struct exynos_srom *srom = platform_get_drvdata(pdev);
+
+	kfree(srom->reg_offset);
+	iounmap(srom->reg_base);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static void exynos_srom_save(void __iomem *base,
+				    struct exynos_srom_reg_dump *rd,
+				    unsigned int num_regs)
+{
+	for (; num_regs > 0; --num_regs, ++rd)
+		rd->value = readl(base + rd->offset);
+}
+
+static void exynos_srom_restore(void __iomem *base,
+				      const struct exynos_srom_reg_dump *rd,
+				      unsigned int num_regs)
+{
+	for (; num_regs > 0; --num_regs, ++rd)
+		writel(rd->value, base + rd->offset);
+}
+
+static int exynos_srom_suspend(struct device *dev)
+{
+	struct exynos_srom *srom = dev_get_drvdata(dev);
+
+	exynos_srom_save(srom->reg_base, srom->reg_offset,
+				ARRAY_SIZE(exynos_srom_offsets));
+	return 0;
+}
+
+static int exynos_srom_resume(struct device *dev)
+{
+	struct exynos_srom *srom = dev_get_drvdata(dev);
+
+	exynos_srom_restore(srom->reg_base, srom->reg_offset,
+				ARRAY_SIZE(exynos_srom_offsets));
+	return 0;
+}
+#endif
+
+static const struct of_device_id of_exynos_srom_ids[] = {
+	{
+		.compatible	= "samsung,exynos-srom",
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, of_exynos_srom_ids);
+
+static SIMPLE_DEV_PM_OPS(exynos_srom_pm_ops, exynos_srom_suspend, exynos_srom_resume);
+
+static struct platform_driver exynos_srom_driver = {
+	.probe = exynos_srom_probe,
+	.remove = exynos_srom_remove,
+	.driver = {
+		.name = "exynos-srom",
+		.of_match_table = of_exynos_srom_ids,
+		.pm = &exynos_srom_pm_ops,
+	},
+};
+module_platform_driver(exynos_srom_driver);
+
+MODULE_AUTHOR("Pankaj Dubey <pankaj.dubey@samsung.com>");
+MODULE_DESCRIPTION("Exynos SROM Controller Driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/soc/samsung/exynos-srom.h b/drivers/soc/samsung/exynos-srom.h
new file mode 100644
index 0000000..34660c6
--- /dev/null
+++ b/drivers/soc/samsung/exynos-srom.h
@@ -0,0 +1,51 @@
+/*
+ * Copyright (c) 2015 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * Exynos SROMC register definitions
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __EXYNOS_SROM_H
+#define __EXYNOS_SROM_H __FILE__
+
+#define EXYNOS_SROMREG(x)		(x)
+
+#define EXYNOS_SROM_BW		EXYNOS_SROMREG(0x0)
+#define EXYNOS_SROM_BC0		EXYNOS_SROMREG(0x4)
+#define EXYNOS_SROM_BC1		EXYNOS_SROMREG(0x8)
+#define EXYNOS_SROM_BC2		EXYNOS_SROMREG(0xc)
+#define EXYNOS_SROM_BC3		EXYNOS_SROMREG(0x10)
+#define EXYNOS_SROM_BC4		EXYNOS_SROMREG(0x14)
+#define EXYNOS_SROM_BC5		EXYNOS_SROMREG(0x18)
+
+/* one register BW holds 4 x 4-bit packed settings for NCS0 - NCS3 */
+
+#define EXYNOS_SROM_BW__DATAWIDTH__SHIFT	0
+#define EXYNOS_SROM_BW__ADDRMODE__SHIFT		1
+#define EXYNOS_SROM_BW__WAITENABLE__SHIFT	2
+#define EXYNOS_SROM_BW__BYTEENABLE__SHIFT	3
+
+#define EXYNOS_SROM_BW__CS_MASK			0xf
+
+#define EXYNOS_SROM_BW__NCS0__SHIFT		0
+#define EXYNOS_SROM_BW__NCS1__SHIFT		4
+#define EXYNOS_SROM_BW__NCS2__SHIFT		8
+#define EXYNOS_SROM_BW__NCS3__SHIFT		12
+#define EXYNOS_SROM_BW__NCS4__SHIFT		16
+#define EXYNOS_SROM_BW__NCS5__SHIFT		20
+
+/* applies to same to BCS0 - BCS3 */
+
+#define EXYNOS_SROM_BCX__PMC__SHIFT		0
+#define EXYNOS_SROM_BCX__TACP__SHIFT		4
+#define EXYNOS_SROM_BCX__TCAH__SHIFT		8
+#define EXYNOS_SROM_BCX__TCOH__SHIFT		12
+#define EXYNOS_SROM_BCX__TACC__SHIFT		16
+#define EXYNOS_SROM_BCX__TCOS__SHIFT		24
+#define EXYNOS_SROM_BCX__TACS__SHIFT		28
+
+#endif /* __EXYNOS_SROM_H */
-- 
2.4.5
