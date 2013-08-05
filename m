From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 5 Aug 2013 12:12:21 -0400
Subject: [PATCH 2/8] clk: keystone: Add gate control clock driver
In-Reply-To: <1375719147-7578-1-git-send-email-santosh.shilimkar@ti.com>
References: <1375719147-7578-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1375719147-7578-3-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the driver for the clock gate control which uses PSC (Power Sleep
Controller) IP on Keystone 2 based SOCs. It is responsible for enabling and
disabling of the clocks for different IPs present in the SoC.

Cc: Mike Turquette <mturquette@linaro.org>

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 .../devicetree/bindings/clock/keystone-gate.txt    |   30 ++
 drivers/clk/keystone/gate.c                        |  306 ++++++++++++++++++++
 include/linux/clk/keystone.h                       |    1 +
 3 files changed, 337 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/keystone-gate.txt
 create mode 100644 drivers/clk/keystone/gate.c

diff --git a/Documentation/devicetree/bindings/clock/keystone-gate.txt b/Documentation/devicetree/bindings/clock/keystone-gate.txt
new file mode 100644
index 0000000..40afef5
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/keystone-gate.txt
@@ -0,0 +1,30 @@
+Binding for Keystone gate control driver which uses PSC controller IP.
+
+This binding uses the common clock binding[1].
+
+[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
+
+Required properties:
+- compatible : shall be "keystone,psc-clk".
+- #clock-cells : from common clock binding; shall be set to 0.
+- clocks : parent clock phandle
+- reg :	psc address address space
+
+Optional properties:
+- clock-output-names : From common clock binding to override the
+			default output clock name
+- status : "enabled" if clock is always enabled
+- lpsc : lpsc module id, if not set defaults to zero
+- pd : power domain number, if not set defaults to zero (always ON)
+- gpsc : gpsc number, if not set defaults to zero
+
+Example:
+	clock {
+		#clock-cells = <0>;
+		compatible = "keystone,psc-clk";
+		clocks = <&chipclk3>;
+		clock-output-names = "debugss_trc";
+		reg = <0x02350000 4096>;
+		lpsc = <5>;
+		pd = <1>;
+	};
diff --git a/drivers/clk/keystone/gate.c b/drivers/clk/keystone/gate.c
new file mode 100644
index 0000000..72ac478
--- /dev/null
+++ b/drivers/clk/keystone/gate.c
@@ -0,0 +1,306 @@
+/*
+ * Clock driver for Keystone 2 based devices
+ *
+ * Copyright (C) 2013 Texas Instruments.
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
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/slab.h>
+#include <linux/of_address.h>
+#include <linux/of.h>
+#include <linux/module.h>
+
+/* PSC register offsets */
+#define PTCMD			0x120
+#define PTSTAT			0x128
+#define PDSTAT			0x200
+#define PDCTL			0x300
+#define MDSTAT			0x800
+#define MDCTL			0xa00
+
+/* PSC module states */
+#define PSC_STATE_SWRSTDISABLE	0
+#define PSC_STATE_SYNCRST	1
+#define PSC_STATE_DISABLE	2
+#define PSC_STATE_ENABLE	3
+
+#define MDSTAT_STATE_MASK	0x3f
+#define MDSTAT_MCKOUT		BIT(12)
+#define PDSTAT_STATE_MASK	0x1f
+#define MDCTL_FORCE		BIT(31)
+#define MDCTL_LRESET		BIT(8)
+#define PDCTL_NEXT		BIT(0)
+
+/* PSC flags. Disable state is SwRstDisable */
+#define PSC_SWRSTDISABLE	BIT(0)
+/* Force module state transtition */
+#define PSC_FORCE		BIT(1)
+/* Keep module in local reset */
+#define PSC_LRESET		BIT(2)
+#define NUM_GPSC		2
+#define REG_OFFSET		4
+
+/**
+ * struct clk_psc_data - PSC data
+ * @base: Base address for a PSC
+ * @flags: framework flags
+ * @lpsc: Is it local PSC
+ * @gpsc: Is it global PSC
+ * @domain: PSC domain
+ *
+ */
+struct clk_psc_data {
+	void __iomem *base;
+	u32	flags;
+	u32	psc_flags;
+	u8	lpsc;
+	u8	gpsc;
+	u8	domain;
+};
+
+/**
+ * struct clk_psc - PSC clock structure
+ * @hw: clk_hw for the psc
+ * @psc_data: PSC driver specific data
+ * @lock: Spinlock used by the driver
+ */
+struct clk_psc {
+	struct clk_hw hw;
+	struct clk_psc_data *psc_data;
+	spinlock_t *lock;
+};
+
+struct reg_psc {
+	u32 phy_base;
+	u32 size;
+	void __iomem *io_base;
+};
+
+static struct reg_psc psc_addr[NUM_GPSC];
+static DEFINE_SPINLOCK(psc_lock);
+
+#define to_clk_psc(_hw) container_of(_hw, struct clk_psc, hw)
+
+static void psc_config(void __iomem *psc_base, unsigned int domain,
+		unsigned int id, bool enable, u32 flags)
+{
+	u32 ptcmd, pdstat, pdctl, mdstat, mdctl, next_state;
+
+	if (enable)
+		next_state = PSC_STATE_ENABLE;
+	else if (flags & PSC_SWRSTDISABLE)
+		next_state = PSC_STATE_SWRSTDISABLE;
+	else
+		next_state = PSC_STATE_DISABLE;
+
+	mdctl = readl(psc_base + MDCTL + REG_OFFSET * id);
+	mdctl &= ~MDSTAT_STATE_MASK;
+	mdctl |= next_state;
+	if (flags & PSC_FORCE)
+		mdctl |= MDCTL_FORCE;
+	if (flags & PSC_LRESET)
+		mdctl &= ~MDCTL_LRESET;
+	writel(mdctl, psc_base + MDCTL + REG_OFFSET * id);
+
+	pdstat = readl(psc_base + PDSTAT + REG_OFFSET * domain);
+	if (!(pdstat & PDSTAT_STATE_MASK)) {
+		pdctl = readl(psc_base + PDCTL + REG_OFFSET * domain);
+		pdctl |= PDCTL_NEXT;
+		writel(pdctl, psc_base + PDCTL + REG_OFFSET * domain);
+	}
+
+	ptcmd = 1 << domain;
+	writel(ptcmd, psc_base + PTCMD);
+	while ((readl(psc_base + PTSTAT) >> domain) & 1)
+		;
+
+	do {
+		mdstat = readl(psc_base + MDSTAT + REG_OFFSET * id);
+	} while (!((mdstat & MDSTAT_STATE_MASK) == next_state));
+}
+
+static int keystone_clk_is_enabled(struct clk_hw *hw)
+{
+	struct clk_psc *psc = to_clk_psc(hw);
+	struct clk_psc_data *data = psc->psc_data;
+	u32 mdstat = readl(data->base + MDSTAT + REG_OFFSET * data->lpsc);
+
+	return (mdstat & MDSTAT_MCKOUT) ? 1 : 0;
+}
+
+static int keystone_clk_enable(struct clk_hw *hw)
+{
+	struct clk_psc *psc = to_clk_psc(hw);
+	struct clk_psc_data *data = psc->psc_data;
+	unsigned long flags = 0;
+
+	if (psc->lock)
+		spin_lock_irqsave(psc->lock, flags);
+
+	psc_config(data->base, data->domain, data->lpsc, 1, data->psc_flags);
+
+	if (psc->lock)
+		spin_unlock_irqrestore(psc->lock, flags);
+
+	return 0;
+}
+
+static void keystone_clk_disable(struct clk_hw *hw)
+{
+	struct clk_psc *psc = to_clk_psc(hw);
+	struct clk_psc_data *data = psc->psc_data;
+	unsigned long flags = 0;
+
+	if (psc->lock)
+		spin_lock_irqsave(psc->lock, flags);
+
+	psc_config(data->base, data->domain, data->lpsc, 0, data->psc_flags);
+
+	if (psc->lock)
+		spin_unlock_irqrestore(psc->lock, flags);
+}
+
+static const struct clk_ops clk_psc_ops = {
+	.enable = keystone_clk_enable,
+	.disable = keystone_clk_disable,
+	.is_enabled = keystone_clk_is_enabled,
+};
+
+/**
+ * clk_register_psc - register psc clock
+ * @dev: device that is registering this clock
+ * @name: name of this clock
+ * @parent_name: name of clock's parent
+ * @psc_data: platform data to configure this clock
+ * @lock: spinlock used by this clock
+ */
+static struct clk *clk_register_psc(struct device *dev,
+			const char *name,
+			const char *parent_name,
+			struct clk_psc_data *psc_data,
+			spinlock_t *lock)
+{
+	struct clk_init_data init;
+	struct clk_psc *psc;
+	struct clk *clk;
+
+	psc = kzalloc(sizeof(*psc), GFP_KERNEL);
+	if (!psc)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = name;
+	init.ops = &clk_psc_ops;
+	init.flags = psc_data->flags;
+	init.parent_names = (parent_name ? &parent_name : NULL);
+	init.num_parents = (parent_name ? 1 : 0);
+
+	psc->psc_data = psc_data;
+	psc->lock = lock;
+	psc->hw.init = &init;
+
+	clk = clk_register(NULL, &psc->hw);
+	if (IS_ERR(clk))
+		kfree(psc);
+
+	return clk;
+}
+
+/**
+ * of_psc_clk_init - initialize psc clock through DT
+ * @node: device tree node for this clock
+ * @lock: spinlock used by this clock
+ */
+static void __init of_psc_clk_init(struct device_node *node, spinlock_t *lock)
+{
+	const char *parent_name, *status = NULL, *base_flags = NULL;
+	struct clk_psc_data *data;
+	const char *clk_name = node->name;
+	u32 gpsc = 0, lpsc = 0, pd = 0;
+	struct resource res;
+	struct clk *clk;
+	int rc;
+
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	WARN_ON(!data);
+
+	if (of_address_to_resource(node, 0, &res)) {
+		pr_err("psc_clk_init - no reg property defined\n");
+		goto out;
+	}
+
+	of_property_read_u32(node, "gpsc", &gpsc);
+	of_property_read_u32(node, "lpsc", &lpsc);
+	of_property_read_u32(node, "pd", &pd);
+
+	if (gpsc >= NUM_GPSC) {
+		pr_err("psc_clk_init - no reg property defined\n");
+		goto out;
+	}
+
+	of_property_read_string(node,
+			"clock-output-names", &clk_name);
+	parent_name = of_clk_get_parent_name(node, 0);
+	WARN_ON(!parent_name);
+
+	/* Expected that same phy_base is used for all psc clocks of
+	 * a give gpsc. So ioremap is done only once.
+	 */
+	if (psc_addr[gpsc].phy_base) {
+		if (psc_addr[gpsc].phy_base != res.start) {
+			pr_err("Different psc base for same GPSC\n");
+			goto out;
+		}
+	} else {
+		psc_addr[gpsc].phy_base = res.start;
+		psc_addr[gpsc].io_base =
+			ioremap(res.start, resource_size(&res));
+	}
+
+	WARN_ON(!psc_addr[gpsc].io_base);
+	data->base = psc_addr[gpsc].io_base;
+	data->lpsc = lpsc;
+	data->gpsc = gpsc;
+	data->domain = pd;
+
+	if (of_property_read_bool(node, "ti,psc-lreset"))
+		data->psc_flags |= PSC_LRESET;
+	if (of_property_read_bool(node, "ti,psc-force"))
+		data->psc_flags |= PSC_FORCE;
+
+	clk = clk_register_psc(NULL, clk_name, parent_name,
+				data, lock);
+
+	if (clk) {
+		of_clk_add_provider(node, of_clk_src_simple_get, clk);
+
+		rc = of_property_read_string(node, "status", &status);
+		if (status && !strcmp(status, "enabled"))
+			clk_prepare_enable(clk);
+		return;
+	}
+	pr_err("psc_clk_init - error registering psc clk %s\n", node->name);
+out:
+	kfree(data);
+	return;
+}
+
+/**
+ * of_keystone_psc_clk_init - initialize psc clock through DT
+ * @node: device tree node for this clock
+ */
+void __init of_keystone_psc_clk_init(struct device_node *node)
+{
+	of_psc_clk_init(node, &psc_lock);
+}
+EXPORT_SYMBOL_GPL(of_keystone_psc_clk_init);
+CLK_OF_DECLARE(keystone_gate_clk, "keystone,psc-clk", of_keystone_psc_clk_init);
diff --git a/include/linux/clk/keystone.h b/include/linux/clk/keystone.h
index 1ade95d..7b3e154 100644
--- a/include/linux/clk/keystone.h
+++ b/include/linux/clk/keystone.h
@@ -14,5 +14,6 @@
 #define __LINUX_CLK_KEYSTONE_H_
 
 extern void of_keystone_pll_clk_init(struct device_node *node);
+extern void of_keystone_psc_clk_init(struct device_node *node);
 
 #endif /* __LINUX_CLK_KEYSTONE_H_ */
-- 
1.7.9.5
