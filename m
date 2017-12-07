From: chunyan.zhang@spreadtrum.com (Chunyan Zhang)
Date: Thu, 7 Dec 2017 20:57:05 +0800
Subject: [PATCH V7 02/12] clk: sprd: Add common infrastructure
In-Reply-To: <20171207125715.16160-1-chunyan.zhang@spreadtrum.com>
References: <20171207125715.16160-1-chunyan.zhang@spreadtrum.com>
Message-ID: <20171207125715.16160-3-chunyan.zhang@spreadtrum.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Added Spreadtrum's clock driver framework together with common
structures and interface functions.

Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
---
 drivers/clk/Kconfig       |  1 +
 drivers/clk/Makefile      |  1 +
 drivers/clk/sprd/Kconfig  |  4 ++
 drivers/clk/sprd/Makefile |  3 ++
 drivers/clk/sprd/common.c | 96 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/sprd/common.h | 38 +++++++++++++++++++
 6 files changed, 143 insertions(+)
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
index f7f761b..d880d13 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -85,6 +85,7 @@ obj-$(CONFIG_COMMON_CLK_SAMSUNG)	+= samsung/
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
index 0000000..e038b044
--- /dev/null
+++ b/drivers/clk/sprd/common.c
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Spreadtrum clock infrastructure
+//
+// Copyright (C) 2017 Spreadtrum, Inc.
+// Author: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
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
+static void sprd_clk_set_regmap(const struct sprd_clk_desc *desc,
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
+	struct regmap *regmap;
+
+	if (of_find_property(node, "sprd,syscon", NULL)) {
+		regmap = syscon_regmap_lookup_by_phandle(node, "sprd,syscon");
+		if (IS_ERR_OR_NULL(regmap)) {
+			pr_err("%s: failed to get syscon regmap\n", __func__);
+			return PTR_ERR(regmap);
+		}
+	} else {
+		base = of_iomap(node, 0);
+		regmap = devm_regmap_init_mmio(&pdev->dev, base,
+					       &sprdclk_regmap_config);
+		if (IS_ERR_OR_NULL(regmap)) {
+			pr_err("failed to init regmap\n");
+			return PTR_ERR(regmap);
+		}
+	}
+
+	sprd_clk_set_regmap(desc, regmap);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(sprd_clk_regmap_init);
+
+int sprd_clk_probe(struct device *dev, struct clk_hw_onecell_data *clkhw)
+{
+	int i, ret;
+	struct clk_hw *hw;
+
+	for (i = 0; i < clkhw->num; i++) {
+
+		hw = clkhw->hws[i];
+
+		if (!hw)
+			continue;
+
+		ret = devm_clk_hw_register(dev, hw);
+		if (ret) {
+			dev_err(dev, "Couldn't register clock %d - %s\n",
+				i, hw->init->name);
+			return ret;
+		}
+	}
+
+	ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get, clkhw);
+	if (ret)
+		dev_err(dev, "Failed to add clock provider\n");
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(sprd_clk_probe);
+
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/clk/sprd/common.h b/drivers/clk/sprd/common.h
new file mode 100644
index 0000000..abd9ff5
--- /dev/null
+++ b/drivers/clk/sprd/common.h
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Spreadtrum clock infrastructure
+//
+// Copyright (C) 2017 Spreadtrum, Inc.
+// Author: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
+
+#ifndef _SPRD_CLK_COMMON_H_
+#define _SPRD_CLK_COMMON_H_
+
+#include <linux/clk-provider.h>
+#include <linux/of_platform.h>
+#include <linux/regmap.h>
+
+struct device_node;
+
+struct sprd_clk_common {
+	struct regmap	*regmap;
+	u32		reg;
+	struct clk_hw	hw;
+};
+
+struct sprd_clk_desc {
+	struct sprd_clk_common		**clk_clks;
+	unsigned long			num_clk_clks;
+	struct clk_hw_onecell_data      *hw_clks;
+};
+
+static inline struct sprd_clk_common *
+	hw_to_sprd_clk_common(const struct clk_hw *hw)
+{
+	return container_of(hw, struct sprd_clk_common, hw);
+}
+int sprd_clk_regmap_init(struct platform_device *pdev,
+			 const struct sprd_clk_desc *desc);
+int sprd_clk_probe(struct device *dev, struct clk_hw_onecell_data *clkhw);
+
+#endif /* _SPRD_CLK_COMMON_H_ */
-- 
2.7.4
