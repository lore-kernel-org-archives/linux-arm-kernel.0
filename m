From: chunyan.zhang@spreadtrum.com (Chunyan Zhang)
Date: Sun, 18 Jun 2017 09:58:48 +0800
Subject: [PATCH V1 2/9] clk: sprd: Add common infrastructure
In-Reply-To: <20170618015855.27738-1-chunyan.zhang@spreadtrum.com>
References: <20170618015855.27738-1-chunyan.zhang@spreadtrum.com>
Message-ID: <20170618015855.27738-3-chunyan.zhang@spreadtrum.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Added Spreadtrum's clock driver common structure and registration code.

Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
---
 drivers/clk/Makefile          |  1 +
 drivers/clk/sprd/Makefile     |  3 ++
 drivers/clk/sprd/ccu_common.c | 78 +++++++++++++++++++++++++++++++++++++
 drivers/clk/sprd/ccu_common.h | 90 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 172 insertions(+)
 create mode 100644 drivers/clk/sprd/Makefile
 create mode 100644 drivers/clk/sprd/ccu_common.c
 create mode 100644 drivers/clk/sprd/ccu_common.h

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
diff --git a/drivers/clk/sprd/Makefile b/drivers/clk/sprd/Makefile
new file mode 100644
index 0000000..8f802b2
--- /dev/null
+++ b/drivers/clk/sprd/Makefile
@@ -0,0 +1,3 @@
+ifneq ($(CONFIG_OF),)
+obj-y	+= ccu_common.o
+endif
diff --git a/drivers/clk/sprd/ccu_common.c b/drivers/clk/sprd/ccu_common.c
new file mode 100644
index 0000000..911f4ba
--- /dev/null
+++ b/drivers/clk/sprd/ccu_common.c
@@ -0,0 +1,78 @@
+/*
+ * Spreadtrum clock infrastructure
+ *
+ * Copyright (C) 2017 Spreadtrum, Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0
+ */
+
+#include "ccu_common.h"
+
+static inline void __iomem *ccu_find_base(struct ccu_addr_map *maps,
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
+int sprd_ccu_probe(struct device_node *node, struct ccu_addr_map *maps,
+		   unsigned int count, const struct sprd_ccu_desc *desc)
+{
+	int i, ret = 0;
+	struct ccu_common *cclk;
+	struct clk_hw *hw;
+
+	for (i = 0; i < desc->num_ccu_clks; i++) {
+		cclk = desc->ccu_clks[i];
+		if (!cclk)
+			continue;
+
+		cclk->base = ccu_find_base(maps, count, cclk->reg);
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
diff --git a/drivers/clk/sprd/ccu_common.h b/drivers/clk/sprd/ccu_common.h
new file mode 100644
index 0000000..ff07772
--- /dev/null
+++ b/drivers/clk/sprd/ccu_common.h
@@ -0,0 +1,90 @@
+/*
+ * Spreadtrum clock infrastructure
+ *
+ * Copyright (C) 2017 Spreadtrum, Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0
+ */
+
+#ifndef _CCU_COMMON_H_
+#define _CCU_COMMON_H_
+
+#include <linux/clk-provider.h>
+
+struct device_node;
+
+#define CLK_HW_INIT_NO_PARENT(_name, _ops, _flags)	\
+	(&(struct clk_init_data) {			\
+		.flags		= _flags,		\
+		.name		= _name,		\
+		.parent_names	= NULL,			\
+		.num_parents	= 0,			\
+		.ops		= _ops,			\
+	})
+
+#define CLK_HW_INIT(_name, _parent, _ops, _flags)		\
+	(&(struct clk_init_data) {				\
+		.flags		= _flags,			\
+		.name		= _name,			\
+		.parent_names	= (const char *[]) { _parent },	\
+		.num_parents	= 1,				\
+		.ops		= _ops,				\
+	})
+
+#define CLK_HW_INIT_PARENTS(_name, _parents, _ops, _flags)	\
+	(&(struct clk_init_data) {				\
+		.flags		= _flags,			\
+		.name		= _name,			\
+		.parent_names	= _parents,			\
+		.num_parents	= ARRAY_SIZE(_parents),		\
+		.ops		= _ops,				\
+	})
+
+#define CLK_FIXED_FACTOR(_struct, _name, _parent,			\
+			_div, _mult, _flags)				\
+	struct clk_fixed_factor _struct = {				\
+		.div		= _div,					\
+		.mult		= _mult,				\
+		.hw.init	= CLK_HW_INIT(_name,			\
+					      _parent,			\
+					      &clk_fixed_factor_ops,	\
+					      _flags),			\
+	}
+
+struct ccu_common {
+	void __iomem	*base;
+	u32		reg;
+	spinlock_t	*lock;
+	struct clk_hw	hw;
+};
+
+struct ccu_addr_map {
+	phys_addr_t phy;
+	void __iomem *virt;
+};
+
+static inline u32 ccu_readl(struct ccu_common *common)
+{
+	return readl(common->base + common->reg);
+}
+
+static inline void ccu_writel(u32 val, struct ccu_common *common)
+{
+	writel(val, common->base + common->reg);
+}
+
+static inline struct ccu_common *hw_to_ccu_common(struct clk_hw *hw)
+{
+	return container_of(hw, struct ccu_common, hw);
+}
+
+struct sprd_ccu_desc {
+	struct ccu_common		**ccu_clks;
+	unsigned long			num_ccu_clks;
+	struct clk_hw_onecell_data	*hw_clks;
+};
+
+int sprd_ccu_probe(struct device_node *node, struct ccu_addr_map *maps,
+		   unsigned int count, const struct sprd_ccu_desc *desc);
+
+#endif /* _CCU_COMMON_H_ */
-- 
2.7.4
