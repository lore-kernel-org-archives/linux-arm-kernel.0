From: chunyan.zhang@spreadtrum.com (Chunyan Zhang)
Date: Tue, 11 Jul 2017 18:56:20 +0800
Subject: [PATCH V2 03/10] clk: sprd: Add common infrastructure
In-Reply-To: <20170711105627.20526-1-chunyan.zhang@spreadtrum.com>
References: <20170711105627.20526-1-chunyan.zhang@spreadtrum.com>
Message-ID: <20170711105627.20526-4-chunyan.zhang@spreadtrum.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Added Spreadtrum's clock driver framework together with common
structures and interface functions.

Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
---
 drivers/clk/Kconfig       |  1 +
 drivers/clk/Makefile      |  1 +
 drivers/clk/sprd/Kconfig  |  4 +++
 drivers/clk/sprd/Makefile |  3 ++
 drivers/clk/sprd/common.c | 83 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/sprd/common.h | 56 ++++++++++++++++++++++++++++++++
 6 files changed, 148 insertions(+)
 create mode 100644 drivers/clk/sprd/Kconfig
 create mode 100644 drivers/clk/sprd/Makefile
 create mode 100644 drivers/clk/sprd/common.c
 create mode 100644 drivers/clk/sprd/common.h

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 36cfea3..baf1688 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -225,6 +225,7 @@ source "drivers/clk/mvebu/Kconfig"
 source "drivers/clk/qcom/Kconfig"
 source "drivers/clk/renesas/Kconfig"
 source "drivers/clk/samsung/Kconfig"
+source "drivers/clk/sprd/Kconfig"
 source "drivers/clk/sunxi-ng/Kconfig"
 source "drivers/clk/tegra/Kconfig"
 source "drivers/clk/ti/Kconfig"
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index c19983a..1d62721 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -81,6 +81,7 @@ obj-$(CONFIG_COMMON_CLK_SAMSUNG)	+= samsung/
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
index 0000000..5ff0473
--- /dev/null
+++ b/drivers/clk/sprd/common.c
@@ -0,0 +1,83 @@
+/*
+ * Spreadtrum clock infrastructure
+ *
+ * Copyright (C) 2017 Spreadtrum, Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0
+ */
+
+#include <linux/module.h>
+
+#include "common.h"
+
+static inline void __iomem *clk_find_base(const struct clk_addr_map *maps,
+					  unsigned int num, unsigned int reg)
+{
+	int i;
+
+	for (i = 0; i < num; i++)
+		if ((reg & 0xffff0000) == maps[i].phy)
+			return maps[i].virt;
+
+	return 0;
+}
+
+int sprd_clk_probe(struct device_node *node, const struct clk_addr_map *maps,
+		   unsigned int count, const struct sprd_clk_desc *desc)
+{
+	int i, ret = 0;
+	struct sprd_clk_common *cclk;
+	struct clk_hw *hw;
+
+	for (i = 0; i < desc->num_clk_clks; i++) {
+		cclk = desc->clk_clks[i];
+		if (!cclk)
+			continue;
+
+		cclk->base = clk_find_base(maps, count, cclk->reg);
+		if (!cclk->base) {
+			pr_err("%s: No mapped address found for clock(0x%x)\n",
+				__func__, cclk->reg);
+			return -EINVAL;
+		}
+		cclk->reg = cclk->reg & 0xffff;
+	}
+
+	for (i = 0; i < desc->hw_clks->num; i++) {
+
+		hw = desc->hw_clks->hws[i];
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
+				     desc->hw_clks);
+	if (ret) {
+		pr_err("Failed to add clock provider.\n");
+		goto err_clk_unreg;
+	}
+
+	return 0;
+
+err_clk_unreg:
+	while (--i >= 0) {
+		hw = desc->hw_clks->hws[i];
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
index 0000000..c747a7d
--- /dev/null
+++ b/drivers/clk/sprd/common.h
@@ -0,0 +1,56 @@
+/*
+ * Spreadtrum clock infrastructure
+ *
+ * Copyright (C) 2017 Spreadtrum, Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0
+ */
+
+#ifndef _SPRD_CLK_COMMON_H_
+#define _SPRD_CLK_COMMON_H_
+
+#include <linux/clk-provider.h>
+
+#include "../clk_common.h"
+
+struct device_node;
+
+struct sprd_clk_common {
+	void __iomem	*base;
+	u32		reg;
+	spinlock_t	*lock;
+	struct clk_hw	hw;
+};
+
+struct clk_addr_map {
+	phys_addr_t phy;
+	void __iomem *virt;
+};
+
+static inline u32 sprd_clk_readl(const struct sprd_clk_common *common)
+{
+	return readl(common->base + common->reg);
+}
+
+static inline void sprd_clk_writel(u32 val,
+				   const struct sprd_clk_common *common)
+{
+	writel(val, common->base + common->reg);
+}
+
+static inline struct sprd_clk_common *
+	hw_to_sprd_clk_common(const struct clk_hw *hw)
+{
+	return container_of(hw, struct sprd_clk_common, hw);
+}
+
+struct sprd_clk_desc {
+	struct sprd_clk_common		**clk_clks;
+	unsigned long			num_clk_clks;
+	struct clk_hw_onecell_data	*hw_clks;
+};
+
+int sprd_clk_probe(struct device_node *node, const struct clk_addr_map *maps,
+		   unsigned int count, const struct sprd_clk_desc *desc);
+
+#endif /* _SPRD_CLK_COMMON_H_ */
-- 
2.7.4
