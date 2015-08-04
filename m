From: jamesjj.liao@mediatek.com (James Liao)
Date: Tue, 4 Aug 2015 16:16:57 +0800
Subject: [PATCH v6 8/9] clk: mediatek: Add USB clock support in MT8173
 APMIXEDSYS
In-Reply-To: <1438676218-11310-1-git-send-email-jamesjj.liao@mediatek.com>
References: <1438676218-11310-1-git-send-email-jamesjj.liao@mediatek.com>
Message-ID: <1438676218-11310-9-git-send-email-jamesjj.liao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add REF2USB_TX clock support into MT8173 APMIXEDSYS. This clock
is needed by USB 3.0.

Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
---
 drivers/clk/mediatek/Makefile          |   2 +-
 drivers/clk/mediatek/clk-apmixed.c     | 107 +++++++++++++++++++++++++++++++++
 drivers/clk/mediatek/clk-mt8173.c      |  47 +++++++++++++++
 drivers/clk/mediatek/clk-mtk.h         |   3 +
 drivers/clk/mediatek/clk-pll.c         |   7 +--
 include/dt-bindings/clock/mt8173-clk.h |   3 +-
 6 files changed, 161 insertions(+), 8 deletions(-)
 create mode 100644 drivers/clk/mediatek/clk-apmixed.c

diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index 8e4b2a4..95fdfac 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -1,4 +1,4 @@
-obj-y += clk-mtk.o clk-pll.o clk-gate.o
+obj-y += clk-mtk.o clk-pll.o clk-gate.o clk-apmixed.o
 obj-$(CONFIG_RESET_CONTROLLER) += reset.o
 obj-y += clk-mt8135.o
 obj-y += clk-mt8173.o
diff --git a/drivers/clk/mediatek/clk-apmixed.c b/drivers/clk/mediatek/clk-apmixed.c
new file mode 100644
index 0000000..5303c59
--- /dev/null
+++ b/drivers/clk/mediatek/clk-apmixed.c
@@ -0,0 +1,107 @@
+/*
+ * Copyright (c) 2015 MediaTek Inc.
+ * Author: James Liao <jamesjj.liao@mediatek.com>
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
+#include <linux/delay.h>
+#include <linux/of_address.h>
+#include <linux/slab.h>
+
+#include "clk-mtk.h"
+
+#define REF2USB_TX_EN		BIT(0)
+#define REF2USB_TX_LPF_EN	BIT(1)
+#define REF2USB_TX_OUT_EN	BIT(2)
+#define REF2USB_EN_MASK		(REF2USB_TX_EN | REF2USB_TX_LPF_EN | \
+				 REF2USB_TX_OUT_EN)
+
+struct mtk_ref2usb_tx {
+	struct clk_hw	hw;
+	void __iomem	*base_addr;
+};
+
+static inline struct mtk_ref2usb_tx *to_mtk_ref2usb_tx(struct clk_hw *hw)
+{
+	return container_of(hw, struct mtk_ref2usb_tx, hw);
+}
+
+static int mtk_ref2usb_tx_is_prepared(struct clk_hw *hw)
+{
+	struct mtk_ref2usb_tx *tx = to_mtk_ref2usb_tx(hw);
+
+	return (readl(tx->base_addr) & REF2USB_EN_MASK) == REF2USB_EN_MASK;
+}
+
+static int mtk_ref2usb_tx_prepare(struct clk_hw *hw)
+{
+	struct mtk_ref2usb_tx *tx = to_mtk_ref2usb_tx(hw);
+	u32 val;
+
+	val = readl(tx->base_addr);
+
+	val |= REF2USB_TX_EN;
+	writel(val, tx->base_addr);
+	udelay(100);
+
+	val |= REF2USB_TX_LPF_EN;
+	writel(val, tx->base_addr);
+
+	val |= REF2USB_TX_OUT_EN;
+	writel(val, tx->base_addr);
+
+	return 0;
+}
+
+static void mtk_ref2usb_tx_unprepare(struct clk_hw *hw)
+{
+	struct mtk_ref2usb_tx *tx = to_mtk_ref2usb_tx(hw);
+	u32 val;
+
+	val = readl(tx->base_addr);
+	val &= ~REF2USB_EN_MASK;
+	writel(val, tx->base_addr);
+}
+
+static const struct clk_ops mtk_ref2usb_tx_ops = {
+	.is_prepared	= mtk_ref2usb_tx_is_prepared,
+	.prepare	= mtk_ref2usb_tx_prepare,
+	.unprepare	= mtk_ref2usb_tx_unprepare,
+};
+
+struct clk * __init mtk_clk_register_ref2usb_tx(const char *name,
+			const char *parent_name, void __iomem *reg)
+{
+	struct mtk_ref2usb_tx *tx;
+	struct clk_init_data init = {};
+	struct clk *clk;
+
+	tx = kzalloc(sizeof(*tx), GFP_KERNEL);
+	if (!tx)
+		return ERR_PTR(-ENOMEM);
+
+	tx->base_addr = reg;
+	tx->hw.init = &init;
+
+	init.name = name;
+	init.ops = &mtk_ref2usb_tx_ops;
+	init.parent_names = &parent_name;
+	init.num_parents = 1;
+
+	clk = clk_register(NULL, &tx->hw);
+
+	if (IS_ERR(clk)) {
+		pr_err("Failed to register clk %s: %ld\n", name, PTR_ERR(clk));
+		kfree(tx);
+	}
+
+	return clk;
+}
diff --git a/drivers/clk/mediatek/clk-mt8173.c b/drivers/clk/mediatek/clk-mt8173.c
index 05335e5..63662d0 100644
--- a/drivers/clk/mediatek/clk-mt8173.c
+++ b/drivers/clk/mediatek/clk-mt8173.c
@@ -969,6 +969,24 @@ static void __init mtk_pericfg_init(struct device_node *node)
 }
 CLK_OF_DECLARE(mtk_pericfg, "mediatek,mt8173-pericfg", mtk_pericfg_init);
 
+struct mtk_clk_usb {
+	int id;
+	const char *name;
+	const char *parent;
+	u32 reg_ofs;
+};
+
+#define APMIXED_USB(_id, _name, _parent, _reg_ofs) {			\
+		.id = _id,						\
+		.name = _name,						\
+		.parent = _parent,					\
+		.reg_ofs = _reg_ofs,					\
+	}
+
+static const struct mtk_clk_usb apmixed_usb[] __initconst = {
+	APMIXED_USB(CLK_APMIXED_REF2USB_TX, "ref2usb_tx", "clk26m", 0x8),
+};
+
 #define MT8173_PLL_FMAX		(3000UL * MHZ)
 
 #define CON0_MT8173_RST_BAR	BIT(24)
@@ -1011,6 +1029,15 @@ static const struct mtk_pll_data plls[] = {
 static void __init mtk_apmixedsys_init(struct device_node *node)
 {
 	struct clk_onecell_data *clk_data;
+	void __iomem *base;
+	struct clk *clk;
+	int r, i;
+
+	base = of_iomap(node, 0);
+	if (!base) {
+		pr_err("%s(): ioremap failed\n", __func__);
+		return;
+	}
 
 	mt8173_pll_clk_data = clk_data = mtk_alloc_clk_data(CLK_APMIXED_NR_CLK);
 	if (!clk_data)
@@ -1018,6 +1045,26 @@ static void __init mtk_apmixedsys_init(struct device_node *node)
 
 	mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
 
+	for (i = 0; i < ARRAY_SIZE(apmixed_usb); i++) {
+		const struct mtk_clk_usb *cku = &apmixed_usb[i];
+
+		clk = mtk_clk_register_ref2usb_tx(cku->name, cku->parent,
+					base + cku->reg_ofs);
+
+		if (IS_ERR(clk)) {
+			pr_err("Failed to register clk %s: %ld\n", cku->name,
+					PTR_ERR(clk));
+			continue;
+		}
+
+		clk_data->clks[cku->id] = clk;
+	}
+
+	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	if (r)
+		pr_err("%s(): could not register clock provider: %d\n",
+			__func__, r);
+
 	mtk_clk_enable_critical();
 }
 CLK_OF_DECLARE(mtk_apmixedsys, "mediatek,mt8173-apmixedsys",
diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index 32d4f55..cf19363 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -173,6 +173,9 @@ void mtk_clk_register_plls(struct device_node *node,
 		const struct mtk_pll_data *plls, int num_plls,
 		struct clk_onecell_data *clk_data);
 
+struct clk *mtk_clk_register_ref2usb_tx(const char *name,
+			const char *parent_name, void __iomem *reg);
+
 #ifdef CONFIG_RESET_CONTROLLER
 void mtk_register_reset_controller(struct device_node *np,
 			unsigned int num_regs, int regofs);
diff --git a/drivers/clk/mediatek/clk-pll.c b/drivers/clk/mediatek/clk-pll.c
index 44409e9..813f0c7 100644
--- a/drivers/clk/mediatek/clk-pll.c
+++ b/drivers/clk/mediatek/clk-pll.c
@@ -302,7 +302,7 @@ void __init mtk_clk_register_plls(struct device_node *node,
 		const struct mtk_pll_data *plls, int num_plls, struct clk_onecell_data *clk_data)
 {
 	void __iomem *base;
-	int r, i;
+	int i;
 	struct clk *clk;
 
 	base = of_iomap(node, 0);
@@ -324,9 +324,4 @@ void __init mtk_clk_register_plls(struct device_node *node,
 
 		clk_data->clks[pll->id] = clk;
 	}
-
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
-	if (r)
-		pr_err("%s(): could not register clock provider: %d\n",
-			__func__, r);
 }
diff --git a/include/dt-bindings/clock/mt8173-clk.h b/include/dt-bindings/clock/mt8173-clk.h
index 87820ee..e3db63a 100644
--- a/include/dt-bindings/clock/mt8173-clk.h
+++ b/include/dt-bindings/clock/mt8173-clk.h
@@ -175,7 +175,8 @@
 #define CLK_APMIXED_APLL2		12
 #define CLK_APMIXED_LVDSPLL		13
 #define CLK_APMIXED_MSDCPLL2		14
-#define CLK_APMIXED_NR_CLK		15
+#define CLK_APMIXED_REF2USB_TX		15
+#define CLK_APMIXED_NR_CLK		16
 
 /* INFRA_SYS */
 
-- 
1.8.1.1.dirty
