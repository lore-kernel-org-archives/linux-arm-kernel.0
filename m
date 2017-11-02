From: chunyan.zhang@spreadtrum.com (Chunyan Zhang)
Date: Thu, 2 Nov 2017 14:56:18 +0800
Subject: [PATCH V3 03/11] clk: sprd: Add common infrastructure
In-Reply-To: <20171102065626.21835-1-chunyan.zhang@spreadtrum.com>
References: <20171102065626.21835-1-chunyan.zhang@spreadtrum.com>
Message-ID: <20171102065626.21835-4-chunyan.zhang@spreadtrum.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Added Spreadtrum's clock driver framework together with common
structures and interface functions.

Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
---
 drivers/clk/Kconfig       |   1 +
 drivers/clk/Makefile      |   1 +
 drivers/clk/sprd/Kconfig  |   4 ++
 drivers/clk/sprd/Makefile |   3 ++
 drivers/clk/sprd/common.c | 112 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/sprd/common.h |  57 +++++++++++++++++++++++
 6 files changed, 178 insertions(+)
 create mode 100644 drivers/clk/sprd/Kconfig
 create mode 100644 drivers/clk/sprd/Makefile
 create mode 100644 drivers/clk/sprd/common.c
 create mode 100644 drivers/clk/sprd/common.h

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 1c4e1aa..ce1a32be 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -236,6 +236,7 @@ source "drivers/clk/mvebu/Kconfig"
 source "drivers/clk/qcom/Kconfig"
 source "drivers/clk/renesas/Kconfig"
 source "drivers/clk/samsung/Kconfig"
+source "drivers/clk/sprd/Kconfig"
 source "drivers/clk/sunxi-ng/Kconfig"
 source "drivers/clk/tegra/Kconfig"
 source "drivers/clk/ti/Kconfig"
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index c99f363..fa33891 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -84,6 +84,7 @@ obj-$(CONFIG_COMMON_CLK_SAMSUNG)	+= samsung/
 obj-$(CONFIG_ARCH_SIRF)			+= sirf/
 obj-$(CONFIG_ARCH_SOCFPGA)		+= socfpga/
 obj-$(CONFIG_PLAT_SPEAR)		+= spear/
+obj-$(CONFIG_ARCH_SPRD)			+= sprd/
 obj-$(CONFIG_ARCH_STI)			+= st/
 obj-$(CONFIG_ARCH_SUNXI)		+= sunxi/
 obj-$(CONFIG_ARCH_SUNXI)		+= sunxi-ng/
diff --git a/drivers/clk/sprd/Kconfig b/drivers/clk/sprd/Kconfig
new file mode 100644
index 0000000..67a3287
--- /dev/null
+++ b/drivers/clk/sprd/Kconfig
@@ -0,0 +1,4 @@
+config SPRD_COMMON_CLK
+	tristate "Clock support for Spreadtrum SoCs"
+	depends on ARCH_SPRD || COMPILE_TEST
+	default ARCH_SPRD
diff --git a/drivers/clk/sprd/Makefile b/drivers/clk/sprd/Makefile
new file mode 100644
index 0000000..74f4b80
--- /dev/null
+++ b/drivers/clk/sprd/Makefile
@@ -0,0 +1,3 @@
+obj-$(CONFIG_SPRD_COMMON_CLK)	+= clk-sprd.o
+
+clk-sprd-y	+= common.o
diff --git a/drivers/clk/sprd/common.c b/drivers/clk/sprd/common.c
new file mode 100644
index 0000000..9ae5932
--- /dev/null
+++ b/drivers/clk/sprd/common.c
@@ -0,0 +1,112 @@
+/*
+ * Spreadtrum clock infrastructure
+ *
+ * Copyright (C) 2017 Spreadtrum, Inc.
+ * Author: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0
+ */
+
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+#include <linux/regmap.h>
+
+#include "common.h"
+
+static const struct regmap_config sprdclk_regmap_config = {
+	.reg_bits	= 32,
+	.reg_stride	= 4,
+	.val_bits	= 32,
+	.max_register	= 0xffff,
+	.fast_io	= true,
+};
+
+void sprd_clk_set_regmap(const struct sprd_clk_desc *desc,
+			 struct regmap *regmap)
+{
+	int i;
+	struct sprd_clk_common *cclk;
+
+	for (i = 0; i < desc->num_clk_clks; i++) {
+		cclk = desc->clk_clks[i];
+		if (!cclk)
+			continue;
+
+		cclk->regmap = regmap;
+	}
+}
+
+int sprd_clk_regmap_init(struct platform_device *pdev,
+			 const struct sprd_clk_desc *desc)
+{
+	void __iomem *base;
+	struct device_node *node = pdev->dev.of_node;
+	struct regmap *regmap = NULL;
+
+	if (of_find_property(node, "sprd,syscon", NULL)) {
+		regmap = syscon_regmap_lookup_by_phandle(node, "sprd,syscon");
+		if (IS_ERR(regmap)) {
+			pr_err("%s: failed to get syscon regmap\n", __func__);
+			return PTR_ERR(regmap);
+		}
+	} else {
+		base = of_iomap(node, 0);
+		regmap = devm_regmap_init_mmio(&pdev->dev, base,
+					       &sprdclk_regmap_config);
+		if (IS_ERR(regmap)) {
+			pr_err("failed to init regmap.\n");
+			return PTR_ERR(regmap);
+		}
+	}
+
+	sprd_clk_set_regmap(desc, regmap);
+
+	return 0;
+}
+
+int sprd_clk_probe(struct device_node *node,
+		   struct clk_hw_onecell_data *clkhw)
+{
+	int i, ret = 0;
+	struct clk_hw *hw;
+
+	for (i = 0; i < clkhw->num; i++) {
+
+		hw = clkhw->hws[i];
+
+		if (!hw)
+			continue;
+
+		ret = clk_hw_register(NULL, hw);
+		if (ret) {
+			pr_err("Couldn't register clock %d - %s\n",
+			       i, hw->init->name);
+			goto err_clk_unreg;
+		}
+	}
+
+	ret = of_clk_add_hw_provider(node, of_clk_hw_onecell_get,
+				     clkhw);
+	if (ret) {
+		pr_err("Failed to add clock provider.\n");
+		goto err_clk_unreg;
+	}
+
+	return 0;
+
+err_clk_unreg:
+	while (--i >= 0) {
+		hw = clkhw->hws[i];
+		if (!hw)
+			continue;
+
+		clk_hw_unregister(hw);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(sprd_clk_probe);
+
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/clk/sprd/common.h b/drivers/clk/sprd/common.h
new file mode 100644
index 0000000..7283387
--- /dev/null
+++ b/drivers/clk/sprd/common.h
@@ -0,0 +1,57 @@
+/*
+ * Spreadtrum clock infrastructure
+ *
+ * Copyright (C) 2017 Spreadtrum, Inc.
+ * Author: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0
+ */
+
+#ifndef _SPRD_CLK_COMMON_H_
+#define _SPRD_CLK_COMMON_H_
+
+#include <linux/clk-provider.h>
+#include <linux/of_platform.h>
+#include <linux/regmap.h>
+
+#include "../clk_common.h"
+
+struct device_node;
+
+struct sprd_clk_common {
+	struct regmap	*regmap;
+	u32		reg;
+	spinlock_t	*lock;
+	struct clk_hw	hw;
+};
+
+struct sprd_clk_desc {
+	struct sprd_clk_common		**clk_clks;
+	unsigned long			num_clk_clks;
+	struct clk_hw_onecell_data      *hw_clks;
+};
+
+#define sprd_regmap_read(map, reg, val)				\
+({								\
+	(map) ? regmap_read((map), (reg), (val)) : (-EINVAL);	\
+})
+
+#define sprd_regmap_write(map, reg, val)			\
+({								\
+	(map) ? regmap_write((map), (reg), (val)) : (-EINVAL);	\
+})
+
+static inline struct sprd_clk_common *
+	hw_to_sprd_clk_common(const struct clk_hw *hw)
+{
+	return container_of(hw, struct sprd_clk_common, hw);
+}
+
+void sprd_clk_set_regmap(const struct sprd_clk_desc *desc,
+			 struct regmap *regmap);
+int sprd_clk_regmap_init(struct platform_device *pdev,
+			 const struct sprd_clk_desc *desc);
+int sprd_clk_probe(struct device_node *node,
+			 struct clk_hw_onecell_data *clkhw);
+
+#endif /* _SPRD_CLK_COMMON_H_ */
-- 
2.7.4
