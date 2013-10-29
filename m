From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Tue, 29 Oct 2013 15:55:10 +0100
Subject: [PATCH 2/3] clk: shmobile: Add MSTP clock support
In-Reply-To: <1383058511-26046-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1383058511-26046-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <1383058511-26046-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MSTP clocks are gate clocks controlled through a register that handles
up to 32 clocks. The register is often sparsely populated.

Those clocks are found on Renesas ARM SoCs.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 .../bindings/clock/renesas,cpg-mstp-clocks.txt     |  47 +++++
 drivers/clk/shmobile/Makefile                      |   1 +
 drivers/clk/shmobile/clk-mstp.c                    | 229 +++++++++++++++++++++
 include/dt-bindings/clock/r8a7790-clock.h          |  56 +++++
 4 files changed, 333 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
 create mode 100644 drivers/clk/shmobile/clk-mstp.c
 create mode 100644 include/dt-bindings/clock/r8a7790-clock.h

diff --git a/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt b/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
new file mode 100644
index 0000000..b3a1ce0
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
@@ -0,0 +1,47 @@
+* Renesas R8A7790 MSTP Clocks
+
+The CPG can gate SoC device clocks. The gates are organized in groups of up to
+32 gates.
+
+This device tree binding describes a single 32 gate clocks group per node.
+Clocks are referenced by user nodes by the MSTP node phandle and the clock
+index in the group, from 0 to 31.
+
+Required Properties:
+
+  - compatible: Must be one of the following
+    - "renesas,r8a7790-mstp-clocks" for R8A7790 (R-Car H2) MSTP gate clocks
+    - "renesas,cpg-mstp-clock" for generic MSTP gate clocks
+  - reg: Base address and length of the memory resource used by the MSTP
+    clocks
+  - clocks: Reference to the parent clocks
+  - #clock-cells: Must be 1
+  - clock-output-names: The name of the clocks as free-form strings
+  - renesas,indices: Index of the gate clocks (0 to 31)
+
+The clocks, clock-output-names and renesas,indices properties contain one
+entry per gate. The MSTP groups are sparsely populated. Unimplemented gates
+must not be declared.
+
+
+Example
+-------
+
+	#include <dt-bindings/clock/r8a7790-clock.h>
+
+	mstp3_clks: mstp3_clks {
+		compatible = "renesas,r8a7790-mstp-clocks", "renesas,cpg-mstp-clocks";
+		reg = <0 0xe615013c 0 4>, <0 0xe6150048 0 4>;
+		clocks = <&cp_clk>, <&mmc1_clk>, <&sd3_clk>, <&sd2_clk>,
+			 <&cpg_clocks R8A7790_CLK_SD1>, <&cpg_clocks R8A7790_CLK_SD0>,
+			 <&mmc0_clk>;
+		#clock-cells = <1>;
+		clock-output-names =
+			"tpu0", "mmcif1", "sdhi3", "sdhi2",
+			 "sdhi1", "sdhi0", "mmcif0";
+		renesas,clock-indices = <
+			R8A7790_CLK_TPU0 R8A7790_CLK_MMCIF1 R8A7790_CLK_SDHI3
+			R8A7790_CLK_SDHI2 R8A7790_CLK_SDHI1 R8A7790_CLK_SDHI0
+			R8A7790_CLK_MMCIF0
+		>;
+	};
diff --git a/drivers/clk/shmobile/Makefile b/drivers/clk/shmobile/Makefile
index d5e14e0..3275c78 100644
--- a/drivers/clk/shmobile/Makefile
+++ b/drivers/clk/shmobile/Makefile
@@ -1,5 +1,6 @@
 obj-$(CONFIG_ARCH_EMEV2)		+= clk-emev2.o
 obj-$(CONFIG_ARCH_SHMOBILE_MULTI)	+= clk-div6.o
+obj-$(CONFIG_ARCH_SHMOBILE_MULTI)	+= clk-mstp.o
 
 # for emply built-in.o
 obj-n	:= dummy
diff --git a/drivers/clk/shmobile/clk-mstp.c b/drivers/clk/shmobile/clk-mstp.c
new file mode 100644
index 0000000..e576b60
--- /dev/null
+++ b/drivers/clk/shmobile/clk-mstp.c
@@ -0,0 +1,229 @@
+/*
+ * R-Car MSTP clocks
+ *
+ * Copyright (C) 2013 Ideas On Board SPRL
+ *
+ * Contact: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/clkdev.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/spinlock.h>
+
+/*
+ * MSTP clocks. We can't use standard gate clocks as we need to poll on the
+ * status register when enabling the clock.
+ */
+
+#define MSTP_MAX_CLOCKS		32
+
+/**
+ * struct mstp_clock_group - MSTP gating clocks group
+ *
+ * @data: clocks in this group
+ * @smstpcr: module stop control register
+ * @mstpsr: module stop status register (optional)
+ * @lock: protects writes to SMSTPCR
+ */
+struct mstp_clock_group {
+	struct clk_onecell_data data;
+	void __iomem *smstpcr;
+	void __iomem *mstpsr;
+	spinlock_t lock;
+};
+
+/**
+ * struct mstp_clock - MSTP gating clock
+ * @hw: handle between common and hardware-specific interfaces
+ * @bit_index: control bit index
+ * @group: MSTP clocks group
+ */
+struct mstp_clock {
+	struct clk_hw hw;
+	u32 bit_index;
+	struct mstp_clock_group *group;
+};
+
+#define to_mstp_clock(_hw) container_of(_hw, struct mstp_clock, hw)
+
+static int cpg_mstp_clock_endisable(struct clk_hw *hw, bool enable)
+{
+	struct mstp_clock *clock = to_mstp_clock(hw);
+	struct mstp_clock_group *group = clock->group;
+	u32 bitmask = BIT(clock->bit_index);
+	unsigned long flags;
+	unsigned int i;
+	u32 value;
+
+	spin_lock_irqsave(&group->lock, flags);
+
+	value = clk_readl(group->smstpcr);
+	if (enable)
+		value &= ~bitmask;
+	else
+		value |= bitmask;
+	clk_writel(value, group->smstpcr);
+
+	spin_unlock_irqrestore(&group->lock, flags);
+
+	if (!enable || !group->mstpsr)
+		return 0;
+
+	for (i = 1000; i > 0; --i) {
+		if (!(clk_readl(group->mstpsr) & bitmask))
+			break;
+		cpu_relax();
+	}
+
+	if (!i) {
+		pr_err("%s: failed to enable %p[%d]\n", __func__,
+		       group->smstpcr, clock->bit_index);
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
+static int cpg_mstp_clock_enable(struct clk_hw *hw)
+{
+	return cpg_mstp_clock_endisable(hw, true);
+}
+
+static void cpg_mstp_clock_disable(struct clk_hw *hw)
+{
+	cpg_mstp_clock_endisable(hw, false);
+}
+
+static int cpg_mstp_clock_is_enabled(struct clk_hw *hw)
+{
+	struct mstp_clock *clock = to_mstp_clock(hw);
+	struct mstp_clock_group *group = clock->group;
+	u32 value;
+
+	if (group->mstpsr)
+		value = clk_readl(group->mstpsr);
+	else
+		value = clk_readl(group->smstpcr);
+
+	return !!(value & BIT(clock->bit_index));
+}
+
+static const struct clk_ops cpg_mstp_clock_ops = {
+	.enable = cpg_mstp_clock_enable,
+	.disable = cpg_mstp_clock_disable,
+	.is_enabled = cpg_mstp_clock_is_enabled,
+};
+
+static struct clk * __init
+cpg_mstp_clock_register(const char *name, const char *parent_name,
+			unsigned int index, struct mstp_clock_group *group)
+{
+	struct clk_init_data init;
+	struct mstp_clock *clock;
+	struct clk *clk;
+
+	clock = kzalloc(sizeof(*clock), GFP_KERNEL);
+	if (!clock) {
+		pr_err("%s: failed to allocate MSTP clock.\n", __func__);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	init.name = name;
+	init.ops = &cpg_mstp_clock_ops;
+	init.flags = CLK_IS_BASIC;
+	init.parent_names = &parent_name;
+	init.num_parents = 1;
+
+	clock->bit_index = index;
+	clock->group = group;
+	clock->hw.init = &init;
+
+	clk = clk_register(NULL, &clock->hw);
+
+	if (IS_ERR(clk))
+		kfree(clock);
+
+	return clk;
+}
+
+static void __init cpg_mstp_clocks_init(struct device_node *np)
+{
+	struct mstp_clock_group *group;
+	struct clk **clks;
+	unsigned int i;
+
+	group = kzalloc(sizeof(*group), GFP_KERNEL);
+	clks = kzalloc(MSTP_MAX_CLOCKS * sizeof(*clks), GFP_KERNEL);
+	if (group == NULL || clks == NULL) {
+		kfree(group);
+		kfree(clks);
+		pr_err("%s: failed to allocate group\n", __func__);
+		return;
+	}
+
+	spin_lock_init(&group->lock);
+	group->data.clks = clks;
+
+	group->smstpcr = of_iomap(np, 0);
+	group->mstpsr = of_iomap(np, 1);
+
+	if (group->smstpcr == NULL) {
+		pr_err("%s: failed to remap SMSTPCR\n", __func__);
+		kfree(group);
+		kfree(clks);
+		return;
+	}
+
+	for (i = 0; i < MSTP_MAX_CLOCKS; ++i) {
+		const char *parent_name;
+		const char *name;
+		u32 clkidx;
+		int ret;
+
+		/* Skip clocks with no name. */
+		ret = of_property_read_string_index(np, "clock-output-names",
+						    i, &name);
+		if (ret < 0 || strlen(name) == 0)
+			continue;
+
+		parent_name = of_clk_get_parent_name(np, i);
+		ret = of_property_read_u32_index(np, "renesas,clock-indices", i,
+						 &clkidx);
+		if (parent_name == NULL || ret < 0)
+			break;
+
+		if (clkidx >= MSTP_MAX_CLOCKS) {
+			pr_err("%s: invalid clock %s %s index %u)\n",
+			       __func__, np->name, name, clkidx);
+			continue;
+		}
+
+		clks[clkidx] = cpg_mstp_clock_register(name, parent_name, i,
+						       group);
+		if (!IS_ERR(clks[clkidx])) {
+			group->data.clk_num = max(group->data.clk_num, clkidx);
+			/*
+			 * Register a clkdev to let board code retrieve the
+			 * clock by name and register aliases for non-DT
+			 * devices.
+			 *
+			 * FIXME: Remove this when all devices that require a
+			 * clock will be instantiated from DT.
+			 */
+			clk_register_clkdev(clks[clkidx], name, NULL);
+		} else {
+			pr_err("%s: failed to register %s %s clock (%ld)\n",
+			       __func__, np->name, name, PTR_ERR(clks[clkidx]));
+		}
+	}
+
+	of_clk_add_provider(np, of_clk_src_onecell_get, &group->data);
+}
+CLK_OF_DECLARE(cpg_mstp_clks, "renesas,cpg-mstp-clocks", cpg_mstp_clocks_init);
diff --git a/include/dt-bindings/clock/r8a7790-clock.h b/include/dt-bindings/clock/r8a7790-clock.h
new file mode 100644
index 0000000..19f2b48
--- /dev/null
+++ b/include/dt-bindings/clock/r8a7790-clock.h
@@ -0,0 +1,56 @@
+/*
+ * Copyright 2013 Ideas On Board SPRL
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#ifndef __DT_BINDINGS_CLOCK_R8A7790_H__
+#define __DT_BINDINGS_CLOCK_R8A7790_H__
+
+/* MSTP1 */
+#define R8A7790_CLK_CMT0		20
+
+/* MSTP2 */
+#define R8A7790_CLK_SCIFA2		2
+#define R8A7790_CLK_SCIFA1		3
+#define R8A7790_CLK_SCIFA0		4
+#define R8A7790_CLK_SCIFB0		6
+#define R8A7790_CLK_SCIFB1		7
+#define R8A7790_CLK_SCIFB2		16
+
+/* MSTP3 */
+#define R8A7790_CLK_TPU0		4
+#define R8A7790_CLK_MMCIF1		5
+#define R8A7790_CLK_SDHI3		11
+#define R8A7790_CLK_SDHI2		12
+#define R8A7790_CLK_SDHI1		13
+#define R8A7790_CLK_SDHI0		14
+#define R8A7790_CLK_MMCIF0		15
+
+/* MSTP5 */
+#define R8A7790_CLK_THERMAL		22
+
+/* MSTP7 */
+#define R8A7790_CLK_HSCIF1		16
+#define R8A7790_CLK_HSCIF0		17
+#define R8A7790_CLK_SCIF1		20
+#define R8A7790_CLK_SCIF0		21
+#define R8A7790_CLK_DU2			22
+#define R8A7790_CLK_DU1			23
+#define R8A7790_CLK_DU0			24
+#define R8A7790_CLK_LVDS1		25
+#define R8A7790_CLK_LVDS0		26
+
+/* MSTP8 */
+#define R8A7790_CLK_ETHER		13
+
+/* MSTP9 */
+#define R8A7790_CLK_I2C3		28
+#define R8A7790_CLK_I2C2		29
+#define R8A7790_CLK_I2C1		30
+#define R8A7790_CLK_I2C0		31
+
+#endif /* __DT_BINDINGS_CLOCK_R8A7790_H__ */
-- 
1.8.1.5
