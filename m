From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 24 Feb 2016 16:14:26 +0100
Subject: [PATCH v2 6/6] clk: mvebu: add AP806 ring clock driver
In-Reply-To: <1456326866-30854-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1456326866-30854-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1456326866-30854-7-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds a new driver to handle the ring clocks found in the
AP806 HW block, which is the core block of all Armada 7K and 8K
Marvell 64-bits processors. Those ring clocks are derived from the
core ring clock handled by the AP806 core clock driver. The ring
clocks are used by various peripherals inside the AP806.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/clk/mvebu/Kconfig      |  3 ++
 drivers/clk/mvebu/Makefile     |  1 +
 drivers/clk/mvebu/ap806-ring.c | 74 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 78 insertions(+)
 create mode 100644 drivers/clk/mvebu/ap806-ring.c

diff --git a/drivers/clk/mvebu/Kconfig b/drivers/clk/mvebu/Kconfig
index fd84172..5d30aac 100644
--- a/drivers/clk/mvebu/Kconfig
+++ b/drivers/clk/mvebu/Kconfig
@@ -45,3 +45,6 @@ config ORION_CLK
 
 config ARMADA_AP806_CORE_CLK
 	bool
+
+config ARMADA_AP806_RING_CLK
+	bool
diff --git a/drivers/clk/mvebu/Makefile b/drivers/clk/mvebu/Makefile
index db5c28c..48ca2d3 100644
--- a/drivers/clk/mvebu/Makefile
+++ b/drivers/clk/mvebu/Makefile
@@ -6,6 +6,7 @@ obj-$(CONFIG_ARMADA_375_CLK)	+= armada-375.o
 obj-$(CONFIG_ARMADA_38X_CLK)	+= armada-38x.o
 obj-$(CONFIG_ARMADA_39X_CLK)	+= armada-39x.o
 obj-$(CONFIG_ARMADA_AP806_CORE_CLK) += ap806-core.o
+obj-$(CONFIG_ARMADA_AP806_RING_CLK) += ap806-ring.o
 obj-$(CONFIG_ARMADA_XP_CLK)	+= armada-xp.o
 obj-$(CONFIG_DOVE_CLK)		+= dove.o dove-divider.o
 obj-$(CONFIG_KIRKWOOD_CLK)	+= kirkwood.o
diff --git a/drivers/clk/mvebu/ap806-ring.c b/drivers/clk/mvebu/ap806-ring.c
new file mode 100644
index 0000000..f980192
--- /dev/null
+++ b/drivers/clk/mvebu/ap806-ring.c
@@ -0,0 +1,74 @@
+/*
+ * Marvell Armada AP806 ring clocks
+ *
+ * Copyright (C) 2016 Marvell
+ *
+ * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#define pr_fmt(fmt) "ap806-ring-clk: " fmt
+
+#include <linux/kernel.h>
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/io.h>
+#include <linux/mfd/syscon.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/regmap.h>
+
+#define AP806_RING_DIV_CLK_REG 0x250
+
+#define AP806_RING_DIV_NUM	5
+
+static struct clk *ap806_ring_clks[AP806_RING_DIV_NUM];
+
+static struct clk_onecell_data ap806_ring_clk_data = {
+	.clks = ap806_ring_clks,
+	.clk_num = AP806_RING_DIV_NUM,
+};
+
+static void __init ap806_ring_clk_init(struct device_node *np)
+{
+	struct regmap *regmap;
+	const char *parent;
+	u32 reg;
+	int i;
+
+	regmap = syscon_node_to_regmap(np->parent);
+	if (IS_ERR(regmap)) {
+		pr_err("cannot get regmap\n");
+		return;
+	}
+
+	if (regmap_read(regmap, AP806_RING_DIV_CLK_REG, &reg)) {
+		pr_err("cannot read from regmap\n");
+		return;
+	}
+
+	parent = of_clk_get_parent_name(np, 0);
+
+	for (i = 0; i < AP806_RING_DIV_NUM; i++) {
+		unsigned long divider;
+		const char *name;
+
+		/* Each clock is represented by 6 bits */
+		divider = (reg >> (6 * i)) & 0x3f;
+
+		of_property_read_string_index(np, "clock-output-names",
+					      i, &name);
+
+		ap806_ring_clks[i] =
+			clk_register_fixed_factor(NULL, name, parent,
+						  0, 1, divider);
+	}
+
+	of_clk_add_provider(np, of_clk_src_onecell_get, &ap806_ring_clk_data);
+}
+
+CLK_OF_DECLARE(ap806_ring_clk, "marvell,armada-ap806-ring-clock",
+	       ap806_ring_clk_init);
-- 
2.6.4
