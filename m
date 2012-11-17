From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 17 Nov 2012 15:22:23 +0100
Subject: [PATCH v2 2/9] clk: mvebu: add armada-370-xp CPU specific clocks
In-Reply-To: <1353162150-522-1-git-send-email-andrew@lunn.ch>
References: <1353162150-522-1-git-send-email-andrew@lunn.ch>
Message-ID: <1353162150-522-3-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gregory CLEMENT <gregory.clement@free-electrons.com>

Add Armada 370/XP specific CPU clocks

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Tested-by Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 .../devicetree/bindings/clock/mvebu-cpu-clock.txt  |   21 +++
 drivers/clk/mvebu/Kconfig                          |    3 +
 drivers/clk/mvebu/Makefile                         |    1 +
 drivers/clk/mvebu/clk-cpu.c                        |  155 ++++++++++++++++++++
 drivers/clk/mvebu/clk-cpu.h                        |   18 +++
 drivers/clk/mvebu/clk.c                            |   14 ++
 6 files changed, 212 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/mvebu-cpu-clock.txt
 create mode 100644 drivers/clk/mvebu/clk-cpu.c
 create mode 100644 drivers/clk/mvebu/clk-cpu.h

diff --git a/Documentation/devicetree/bindings/clock/mvebu-cpu-clock.txt b/Documentation/devicetree/bindings/clock/mvebu-cpu-clock.txt
new file mode 100644
index 0000000..1fb5a64
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/mvebu-cpu-clock.txt
@@ -0,0 +1,21 @@
+Device Tree Clock bindings for cpu clock of Marvell EBU platforms
+
+Required properties:
+- compatible : shall be one of the following:
+	"marvell,armada-xp-cpu-clockctrl" - cpu clocks for Armada XP
+- reg : Address and length of the clock complex register set
+- #clock-cells : should be set to 1.
+- clocks : shall be the input parent clock phandle for the clock.
+
+cpuclk: clock-complex at d0018700 {
+	#clock-cells = <1>;
+	compatible = "marvell,armada-xp-cpu-clockctrl";
+	reg = <0xd0018700 0xA0>;
+	clocks = <&coreclk 1>;
+}
+
+cpu at 0 {
+	compatible = "marvell,sheeva-v7";
+	reg = <0>;
+	clocks = <&cpuclk 0>;
+};
diff --git a/drivers/clk/mvebu/Kconfig b/drivers/clk/mvebu/Kconfig
index fd7bf97..1dd93ad 100644
--- a/drivers/clk/mvebu/Kconfig
+++ b/drivers/clk/mvebu/Kconfig
@@ -1,3 +1,6 @@
 config MVEBU_CLK_CORE
        bool
 
+config MVEBU_CLK_CPU
+       bool
+
diff --git a/drivers/clk/mvebu/Makefile b/drivers/clk/mvebu/Makefile
index de1d961..93da083 100644
--- a/drivers/clk/mvebu/Makefile
+++ b/drivers/clk/mvebu/Makefile
@@ -1 +1,2 @@
 obj-$(CONFIG_MVEBU_CLK_CORE) 	+= clk.o clk-core.o
+obj-$(CONFIG_MVEBU_CLK_CPU) 	+= clk-cpu.o
diff --git a/drivers/clk/mvebu/clk-cpu.c b/drivers/clk/mvebu/clk-cpu.c
new file mode 100644
index 0000000..1df027a
--- /dev/null
+++ b/drivers/clk/mvebu/clk-cpu.c
@@ -0,0 +1,155 @@
+/*
+ * Marvell MVEBU CPU clock handling.
+ *
+ * Copyright (C) 2012 Marvell
+ *
+ * Gregory CLEMENT <gregory.clement@free-electrons.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+#include <linux/kernel.h>
+#include <linux/clkdev.h>
+#include <linux/clk-provider.h>
+#include <linux/of_address.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/delay.h>
+#include "clk-cpu.h"
+
+#define SYS_CTRL_CLK_DIVIDER_CTRL_OFFSET    0x0
+#define SYS_CTRL_CLK_DIVIDER_VALUE_OFFSET   0xC
+#define SYS_CTRL_CLK_DIVIDER_MASK	    0x3F
+
+#define MAX_CPU	    4
+struct cpu_clk {
+	struct clk_hw hw;
+	int cpu;
+	const char *clk_name;
+	const char *parent_name;
+	void __iomem *reg_base;
+};
+
+static struct clk **clks;
+
+static struct clk_onecell_data clk_data;
+
+#define to_cpu_clk(p) container_of(p, struct cpu_clk, hw)
+
+static unsigned long clk_cpu_recalc_rate(struct clk_hw *hwclk,
+					 unsigned long parent_rate)
+{
+	struct cpu_clk *cpuclk = to_cpu_clk(hwclk);
+	u32 reg, div;
+
+	reg = readl(cpuclk->reg_base + SYS_CTRL_CLK_DIVIDER_VALUE_OFFSET);
+	div = (reg >> (cpuclk->cpu * 8)) & SYS_CTRL_CLK_DIVIDER_MASK;
+	return parent_rate / div;
+}
+
+static long clk_cpu_round_rate(struct clk_hw *hwclk, unsigned long rate,
+			       unsigned long *parent_rate)
+{
+	/* Valid ratio are 1:1, 1:2 and 1:3 */
+	u32 div;
+
+	div = *parent_rate / rate;
+	if (div == 0)
+		div = 1;
+	else if (div > 3)
+		div = 3;
+
+	return *parent_rate / div;
+}
+
+static int clk_cpu_set_rate(struct clk_hw *hwclk, unsigned long rate,
+			    unsigned long parent_rate)
+{
+	struct cpu_clk *cpuclk = to_cpu_clk(hwclk);
+	u32 reg, div;
+	u32 reload_mask;
+
+	div = parent_rate / rate;
+	reg = (readl(cpuclk->reg_base + SYS_CTRL_CLK_DIVIDER_VALUE_OFFSET)
+		& (~(SYS_CTRL_CLK_DIVIDER_MASK << (cpuclk->cpu * 8))))
+		| (div << (cpuclk->cpu * 8));
+	writel(reg, cpuclk->reg_base + SYS_CTRL_CLK_DIVIDER_VALUE_OFFSET);
+	/* Set clock divider reload smooth bit mask */
+	reload_mask = 1 << (20 + cpuclk->cpu);
+
+	reg = readl(cpuclk->reg_base + SYS_CTRL_CLK_DIVIDER_CTRL_OFFSET)
+	    | reload_mask;
+	writel(reg, cpuclk->reg_base + SYS_CTRL_CLK_DIVIDER_CTRL_OFFSET);
+
+	/* Now trigger the clock update */
+	reg = readl(cpuclk->reg_base + SYS_CTRL_CLK_DIVIDER_CTRL_OFFSET)
+	    | 1 << 24;
+	writel(reg, cpuclk->reg_base + SYS_CTRL_CLK_DIVIDER_CTRL_OFFSET);
+
+	/* Wait for clocks to settle down then clear reload request */
+	udelay(1000);
+	reg &= ~(reload_mask | 1 << 24);
+	writel(reg, cpuclk->reg_base + SYS_CTRL_CLK_DIVIDER_CTRL_OFFSET);
+	udelay(1000);
+
+	return 0;
+}
+
+static const struct clk_ops cpu_ops = {
+	.recalc_rate = clk_cpu_recalc_rate,
+	.round_rate = clk_cpu_round_rate,
+	.set_rate = clk_cpu_set_rate,
+};
+
+void __init of_cpu_clk_setup(struct device_node *node)
+{
+	struct cpu_clk *cpuclk;
+	void __iomem *clock_complex_base = of_iomap(node, 0);
+	int cpu;
+	if (clock_complex_base == NULL) {
+		pr_err("%s: clock-complex base register not set\n",
+			__func__);
+		return;
+	}
+
+	cpuclk = kzalloc(MAX_CPU * sizeof(*cpuclk), GFP_KERNEL);
+	clks = kzalloc(MAX_CPU * sizeof(*clks), GFP_KERNEL);
+
+	if (WARN_ON(!cpuclk))
+		return;
+	for (cpu = 0; cpu < MAX_CPU; cpu++) {
+		struct clk_init_data init;
+		struct clk *clk;
+		struct clk *parent_clk;
+		char *clk_name = kzalloc(5, GFP_KERNEL);
+
+		sprintf(clk_name, "cpu%d", cpu);
+		parent_clk = of_clk_get(node, 0);
+
+		cpuclk[cpu].parent_name = __clk_get_name(parent_clk);
+		cpuclk[cpu].clk_name = clk_name;
+		cpuclk[cpu].cpu = cpu;
+		cpuclk[cpu].reg_base = clock_complex_base;
+		cpuclk[cpu].hw.init = &init;
+
+		init.name = cpuclk[cpu].clk_name;
+		init.ops = &cpu_ops;
+		init.flags = 0;
+		init.parent_names = &cpuclk[cpu].parent_name;
+		init.num_parents = 1;
+
+		clk = clk_register(NULL, &cpuclk[cpu].hw);
+		if (WARN_ON(IS_ERR(clk)))
+			goto bail_out;
+		clks[cpu] = clk;
+	}
+	clk_data.clk_num = MAX_CPU;
+	clk_data.clks = clks;
+	of_clk_add_provider(node, of_clk_src_onecell_get, &clk_data);
+
+	return;
+bail_out:
+	kfree(clks);
+	kfree(cpuclk);
+}
diff --git a/drivers/clk/mvebu/clk-cpu.h b/drivers/clk/mvebu/clk-cpu.h
new file mode 100644
index 0000000..e208336
--- /dev/null
+++ b/drivers/clk/mvebu/clk-cpu.h
@@ -0,0 +1,18 @@
+/*
+ * Marvell MVEBU CPU clock handling.
+ *
+ * Copyright (C) 2012 Marvell
+ *
+ * Gregory CLEMENT <gregory.clement@free-electrons.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __MVEBU_CLK_CPU_H
+#define __MVEBU_CLK_CPU_H
+
+void __init of_cpu_clk_setup(struct device_node *node);
+
+#endif
diff --git a/drivers/clk/mvebu/clk.c b/drivers/clk/mvebu/clk.c
index e6742ac..dc310d6 100644
--- a/drivers/clk/mvebu/clk.c
+++ b/drivers/clk/mvebu/clk.c
@@ -16,8 +16,22 @@
 #include <linux/clk/mvebu.h>
 #include <linux/of.h>
 #include "clk-core.h"
+#include "clk-cpu.h"
+
+static const __initconst struct of_device_id clk_match[] = {
+#ifdef CONFIG_MVEBU_CLK_CPU
+	{
+		.compatible = "marvell,armada-xp-cpu-clockctrl",
+		.data = of_cpu_clk_setup,
+	},
+#endif
+	{
+		/* sentinel */
+	}
+};
 
 void __init mvebu_clocks_init(void)
 {
 	mvebu_core_clk_init();
+	of_clk_init(clk_match);
 }
-- 
1.7.10.4
