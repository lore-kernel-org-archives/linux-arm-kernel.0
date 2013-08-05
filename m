From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 5 Aug 2013 12:12:20 -0400
Subject: [PATCH 1/8] clk: keystone: add Keystone PLL clock driver
In-Reply-To: <1375719147-7578-1-git-send-email-santosh.shilimkar@ti.com>
References: <1375719147-7578-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1375719147-7578-2-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the driver for the PLL IPs found on Keystone 2 devices. The main PLL
IP typically has a multiplier, and a divider. The addtional PLL IPs like
ARMPLL, DDRPLL and PAPLL are controlled by the memory mapped register where
as the Main PLL is controlled by a PLL controller and memory map registers.
This difference is handle using 'has_pll_cntrl' property.

Cc: Mike Turquette <mturquette@linaro.org>

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 .../devicetree/bindings/clock/keystone-pll.txt     |   36 ++++
 drivers/clk/keystone/pll.c                         |  197 ++++++++++++++++++++
 include/linux/clk/keystone.h                       |   18 ++
 3 files changed, 251 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/keystone-pll.txt
 create mode 100644 drivers/clk/keystone/pll.c
 create mode 100644 include/linux/clk/keystone.h

diff --git a/Documentation/devicetree/bindings/clock/keystone-pll.txt b/Documentation/devicetree/bindings/clock/keystone-pll.txt
new file mode 100644
index 0000000..58f6470
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/keystone-pll.txt
@@ -0,0 +1,36 @@
+Binding for keystone PLLs. The main PLL IP typically has a multiplier,
+a divider and a post divider. The additional PLL IPs like ARMPLL, DDRPLL
+and PAPLL are controlled by the memory mapped register where as the Main
+PLL is controlled by a PLL controller. This difference is handle using
+'pll_has_pllctrl' property.
+
+This binding uses the common clock binding[1].
+
+[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
+
+Required properties:
+- compatible : shall be "keystone,pll-clk".
+- #clock-cells : from common clock binding; shall be set to 0.
+- clocks : parent clock phandle
+- reg - index 0 -  PLLCTRL PLLM register address
+- 	index 1 -  MAINPLL_CTL0 register address
+- pll_has_pllctrl - PLL is controlled by controller or memory mapped register
+- pllm_lower_mask - pllm lower bit mask
+- pllm_upper_mask - pllm upper bit mask
+- plld_mask - plld mask
+- fixed_postdiv - fixed post divider value
+
+Example:
+	clock {
+		#clock-cells = <0>;
+		compatible = "keystone,pll-clk";
+		clocks = <&refclk>;
+		reg = <0x02310110 4	/* PLLCTRL PLLM */
+			0x02620328 4>;	/* MAINPLL_CTL0 */
+		pll_has_pllctrl;
+		pllm_lower_mask	= <0x3f>;
+		pllm_upper_mask = <0x7f000>;
+		pllm_upper_shift = <6>;
+		plld_mask = <0x3f>;
+		fixed_postdiv = <2>;
+	};
diff --git a/drivers/clk/keystone/pll.c b/drivers/clk/keystone/pll.c
new file mode 100644
index 0000000..1453eea
--- /dev/null
+++ b/drivers/clk/keystone/pll.c
@@ -0,0 +1,197 @@
+/*
+ * Main PLL clk driver for Keystone devices
+ *
+ * Copyright (C) 2013 Texas Instruments Inc.
+ *	Murali Karicheri <m-karicheri2@ti.com>
+ *	Santosh Shilimkar <santosh.shilimkar@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/slab.h>
+#include <linux/of_address.h>
+#include <linux/of.h>
+#include <linux/module.h>
+#include <linux/clk/keystone.h>
+
+/**
+ * struct clk_pll_data - pll data structure
+ * @has_pllctrl: If set to non zero, lower 6 bits of multiplier is in pllm
+ *	register of pll controller, else it is in the pll_ctrl0((bit 11-6)
+ * @phy_pllm: Physical address of PLLM in pll controller. Used when
+ *	has_pllctrl is non zero.
+ * @phy_pll_ctl0: Physical address of PLL ctrl0. This could be that of
+ *	Main PLL or any other PLLs in the device such as ARM PLL, DDR PLL
+ *	or PA PLL available on keystone2. These PLLs are controlled by
+ *	this register. Main PLL is controlled by a PLL controller.
+ * @pllm: PLL register map address
+ * @pll_ctl0: PLL controller map address
+ * @pllm_lower_mask: multiplier lower mask
+ * @pllm_upper_mask: multiplier upper mask
+ * @pllm_upper_shift: multiplier upper shift
+ * @plld_mask: divider mask
+ * @fixed_postdiv: Post divider
+ */
+struct clk_pll_data {
+	unsigned char has_pllctrl;
+	u32 phy_pllm;
+	u32 phy_pll_ctl0;
+	void __iomem *pllm;
+	void __iomem *pll_ctl0;
+	u32 pllm_lower_mask;
+	u32 pllm_upper_mask;
+	u32 pllm_upper_shift;
+	u32 plld_mask;
+	u32 fixed_postdiv;
+};
+
+/**
+ * struct clk_pll - Main pll clock
+ * @hw: clk_hw for the pll
+ * @pll_data: PLL driver specific data
+ */
+struct clk_pll {
+	struct clk_hw hw;
+	struct clk_pll_data *pll_data;
+};
+
+#define to_clk_pll(_hw) container_of(_hw, struct clk_pll, hw)
+
+static unsigned long clk_pllclk_recalc(struct clk_hw *hw,
+					unsigned long parent_rate)
+{
+	struct clk_pll *pll = to_clk_pll(hw);
+	struct clk_pll_data *pll_data = pll->pll_data;
+	unsigned long rate = parent_rate;
+	u32  mult = 0, prediv, postdiv, val;
+
+	/*
+	 * get bits 0-5 of multiplier from pllctrl PLLM register
+	 * if has_pllctrl is non zero */
+	if (pll_data->has_pllctrl) {
+		val = readl(pll_data->pllm);
+		mult = (val & pll_data->pllm_lower_mask);
+	}
+
+	/* bit6-12 of PLLM is in Main PLL control register */
+	val = readl(pll_data->pll_ctl0);
+	mult |= ((val & pll_data->pllm_upper_mask)
+			>> pll_data->pllm_upper_shift);
+	prediv = (val & pll_data->plld_mask);
+	postdiv = pll_data->fixed_postdiv;
+
+	rate /= (prediv + 1);
+	rate = (rate * (mult + 1));
+	rate /= postdiv;
+
+	return rate;
+}
+
+static const struct clk_ops clk_pll_ops = {
+	.recalc_rate = clk_pllclk_recalc,
+};
+
+static struct clk *clk_register_pll(struct device *dev,
+			const char *name,
+			const char *parent_name,
+			struct clk_pll_data *pll_data)
+{
+	struct clk_init_data init;
+	struct clk_pll *pll;
+	struct clk *clk;
+
+	if (!pll_data)
+		return ERR_PTR(-ENODEV);
+
+	pll = kzalloc(sizeof(*pll), GFP_KERNEL);
+	if (!pll)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = name;
+	init.ops = &clk_pll_ops;
+	init.flags = 0;
+	init.parent_names = (parent_name ? &parent_name : NULL);
+	init.num_parents = (parent_name ? 1 : 0);
+
+	pll->pll_data	= pll_data;
+	pll->hw.init = &init;
+
+	clk = clk_register(NULL, &pll->hw);
+	if (IS_ERR(clk))
+		goto out;
+
+	return clk;
+out:
+	kfree(pll);
+	return NULL;
+}
+
+/**
+ * of_keystone_pll_clk_init - PLL initialisation via DT
+ * @node: device tree node for this clock
+ */
+void __init of_keystone_pll_clk_init(struct device_node *node)
+{
+	struct clk_pll_data *pll_data;
+	const char *parent_name;
+	struct clk *clk;
+	int temp;
+
+	pll_data = kzalloc(sizeof(*pll_data), GFP_KERNEL);
+	WARN_ON(!pll_data);
+
+	parent_name = of_clk_get_parent_name(node, 0);
+
+	if (of_find_property(node, "pll_has_pllctrl", &temp)) {
+		/* PLL is controlled by the pllctrl */
+		pll_data->has_pllctrl = 1;
+		pll_data->pllm = of_iomap(node, 0);
+		WARN_ON(!pll_data->pllm);
+
+		pll_data->pll_ctl0 = of_iomap(node, 1);
+		WARN_ON(!pll_data->pll_ctl0);
+
+		if (of_property_read_u32(node, "pllm_lower_mask",
+				&pll_data->pllm_lower_mask))
+			goto out;
+
+	} else {
+		/* PLL is controlled by the ctrl register */
+		pll_data->has_pllctrl = 0;
+		pll_data->pll_ctl0 = of_iomap(node, 0);
+	}
+
+	if (of_property_read_u32(node, "pllm_upper_mask",
+			&pll_data->pllm_upper_mask))
+		goto out;
+
+	if (of_property_read_u32(node, "pllm_upper_shift",
+			&pll_data->pllm_upper_shift))
+		goto out;
+
+	if (of_property_read_u32(node, "plld_mask", &pll_data->plld_mask))
+		goto out;
+
+	if (of_property_read_u32(node, "fixed_postdiv",
+					&pll_data->fixed_postdiv))
+		goto out;
+
+	clk = clk_register_pll(NULL, node->name, parent_name,
+					 pll_data);
+	if (clk) {
+		of_clk_add_provider(node, of_clk_src_simple_get, clk);
+		return;
+	}
+out:
+	pr_err("of_keystone_pll_clk_init - error initializing clk %s\n",
+		 node->name);
+	kfree(pll_data);
+}
+EXPORT_SYMBOL_GPL(of_keystone_pll_clk_init);
+CLK_OF_DECLARE(keystone_pll_clk, "keystone,pll-clk", of_keystone_pll_clk_init);
diff --git a/include/linux/clk/keystone.h b/include/linux/clk/keystone.h
new file mode 100644
index 0000000..1ade95d
--- /dev/null
+++ b/include/linux/clk/keystone.h
@@ -0,0 +1,18 @@
+/*
+ * Keystone Clock driver header
+ *
+ * Copyright (C) 2013 Texas Instruments Inc.
+ *	Santosh Shilimkar <santosh.shilimkar@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#ifndef __LINUX_CLK_KEYSTONE_H_
+#define __LINUX_CLK_KEYSTONE_H_
+
+extern void of_keystone_pll_clk_init(struct device_node *node);
+
+#endif /* __LINUX_CLK_KEYSTONE_H_ */
-- 
1.7.9.5
