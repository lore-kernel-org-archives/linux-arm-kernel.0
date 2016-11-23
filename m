From: zhangfei.gao@linaro.org (Zhangfei Gao)
Date: Wed, 23 Nov 2016 16:07:56 +0800
Subject: [RFC V2: PATCH 2/2] reset: hisilicon: add reset-hi3660
In-Reply-To: <1479888476-13138-1-git-send-email-zhangfei.gao@linaro.org>
References: <Arnd Bergmann <arnd@arndb.de>,>
 <1479888476-13138-1-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <1479888476-13138-3-git-send-email-zhangfei.gao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add hi3660 reset driver
Reset offset & bits should be listed in dts
Like:
	iomcu_rst: iomcu_rst_controller {
		compatible = "hisilicon,hi3660-reset";
		#reset-cells = <1>;
		hisi,rst-syscon = <&iomcu>;
		hisi,reset-bits = <0x20 0x8		/* 0: i2c0 */
				   0x20 0x10		/* 1: i2c1 */
				   0x20 0x20		/* 2: i2c2 */
				   0x20 0x8000000>;	/* 3: i2c6 */
	};

Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 drivers/reset/hisilicon/Kconfig        |   7 ++
 drivers/reset/hisilicon/Makefile       |   1 +
 drivers/reset/hisilicon/reset-hi3660.c | 144 +++++++++++++++++++++++++++++++++
 3 files changed, 152 insertions(+)
 create mode 100644 drivers/reset/hisilicon/reset-hi3660.c

diff --git a/drivers/reset/hisilicon/Kconfig b/drivers/reset/hisilicon/Kconfig
index 1ff8b0c..10134dc 100644
--- a/drivers/reset/hisilicon/Kconfig
+++ b/drivers/reset/hisilicon/Kconfig
@@ -1,3 +1,10 @@
+config COMMON_RESET_HI3660
+	tristate "Hi3660 Reset Driver"
+	depends on ARCH_HISI || COMPILE_TEST
+	default ARCH_HISI
+	help
+	  Build the Hisilicon Hi3660 reset driver.
+
 config COMMON_RESET_HI6220
 	tristate "Hi6220 Reset Driver"
 	depends on ARCH_HISI || COMPILE_TEST
diff --git a/drivers/reset/hisilicon/Makefile b/drivers/reset/hisilicon/Makefile
index c932f86..ab8a7bf 100644
--- a/drivers/reset/hisilicon/Makefile
+++ b/drivers/reset/hisilicon/Makefile
@@ -1 +1,2 @@
 obj-$(CONFIG_COMMON_RESET_HI6220) += hi6220_reset.o
+obj-$(CONFIG_COMMON_RESET_HI3660) += reset-hi3660.o
diff --git a/drivers/reset/hisilicon/reset-hi3660.c b/drivers/reset/hisilicon/reset-hi3660.c
new file mode 100644
index 0000000..3307252
--- /dev/null
+++ b/drivers/reset/hisilicon/reset-hi3660.c
@@ -0,0 +1,144 @@
+/*
+ * Copyright (c) 2016-2017 Linaro Ltd.
+ * Copyright (c) 2016-2017 HiSilicon Technologies Co., Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+#include <linux/kernel.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/reset-controller.h>
+
+struct hi3660_reset_data {
+	unsigned int off;
+	unsigned int bits;
+};
+
+struct hi3660_reset_controller {
+	struct reset_controller_dev rst;
+	struct regmap *map;
+	const struct hi3660_reset_data *datas;
+};
+
+#define to_hi3660_reset_controller(_rst) \
+	container_of(_rst, struct hi3660_reset_controller, rst)
+
+static int hi3660_reset_program_hw(struct reset_controller_dev *rcdev,
+				   unsigned long idx, bool assert)
+{
+	struct hi3660_reset_controller *rc = to_hi3660_reset_controller(rcdev);
+	const struct hi3660_reset_data *d;
+
+	if (idx >= rcdev->nr_resets)
+		return -EINVAL;
+
+	d = &rc->datas[idx];
+
+	if (assert)
+		return regmap_write(rc->map, d->off, d->bits);
+	else
+		return regmap_write(rc->map, d->off + 4, d->bits);
+}
+
+static int hi3660_reset_assert(struct reset_controller_dev *rcdev,
+			       unsigned long idx)
+{
+	return hi3660_reset_program_hw(rcdev, idx, true);
+}
+
+static int hi3660_reset_deassert(struct reset_controller_dev *rcdev,
+				 unsigned long idx)
+{
+	return hi3660_reset_program_hw(rcdev, idx, false);
+}
+
+static int hi3660_reset_dev(struct reset_controller_dev *rcdev,
+			    unsigned long idx)
+{
+	int err;
+
+	err = hi3660_reset_assert(rcdev, idx);
+	if (err)
+		return err;
+
+	return hi3660_reset_deassert(rcdev, idx);
+}
+
+static struct reset_control_ops hi3660_reset_ops = {
+	.reset    = hi3660_reset_dev,
+	.assert   = hi3660_reset_assert,
+	.deassert = hi3660_reset_deassert,
+};
+
+static int hi3660_reset_probe(struct platform_device *pdev)
+{
+	struct hi3660_reset_controller *rc;
+	struct device_node *np = pdev->dev.of_node;
+	struct device *dev = &pdev->dev;
+	struct hi3660_reset_data *datas;
+	const __be32 *list;
+	int size, nr, i;
+
+	rc = devm_kzalloc(dev, sizeof(*rc), GFP_KERNEL);
+	if (!rc)
+		return -ENOMEM;
+
+	rc->map = syscon_regmap_lookup_by_phandle(np, "hisi,rst-syscon");
+	if (IS_ERR(rc->map)) {
+		dev_err(dev, "failed to get hi3660,rst-syscon\n");
+		return PTR_ERR(rc->map);
+	}
+
+	list = of_get_property(np, "hisi,reset-bits", &size);
+	if (!list || (size / sizeof(*list)) % 2 != 0) {
+		dev_err(dev, "invalid DT reset description\n");
+		return -EINVAL;
+	}
+
+	nr = (size / sizeof(*list)) / 2;
+	datas = devm_kzalloc(dev, nr * sizeof(*datas), GFP_KERNEL);
+	if (!datas)
+		return -ENOMEM;
+
+	for (i = 0; i < nr; i++) {
+		datas[i].off = be32_to_cpup(list++);
+		datas[i].bits = be32_to_cpup(list++);
+	}
+
+	rc->rst.ops = &hi3660_reset_ops,
+	rc->rst.of_node = np;
+	rc->rst.nr_resets = nr;
+	rc->datas = datas;
+
+	return reset_controller_register(&rc->rst);
+}
+
+static const struct of_device_id hi3660_reset_match[] = {
+	{ .compatible = "hisilicon,hi3660-reset", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, hi3660_reset_match);
+
+static struct platform_driver hi3660_reset_driver = {
+	.probe = hi3660_reset_probe,
+	.driver = {
+		.name = "hi3660-reset",
+		.of_match_table = hi3660_reset_match,
+	},
+};
+
+static int __init hi3660_reset_init(void)
+{
+	return platform_driver_register(&hi3660_reset_driver);
+}
+arch_initcall(hi3660_reset_init);
+
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:hi3660-reset");
+MODULE_DESCRIPTION("HiSilicon Hi3660 Reset Driver");
-- 
2.7.4
