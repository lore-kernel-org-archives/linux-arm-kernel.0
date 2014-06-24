From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 24 Jun 2014 18:08:26 +0200
Subject: [PATCH v2 3/4] clk: samsung: Add driver to control CLKOUT line on
 Exynos SoCs
In-Reply-To: <1403626107-12073-1-git-send-email-t.figa@samsung.com>
References: <1403626107-12073-1-git-send-email-t.figa@samsung.com>
Message-ID: <1403626107-12073-4-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch introduces a driver that handles configuration of CLKOUT pin
of Exynos SoCs that can be used to output certain clocks from inside of
the SoC to a dedicated output pin.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
---
 .../devicetree/bindings/arm/samsung/pmu.txt        |  30 ++++
 drivers/clk/samsung/Makefile                       |   1 +
 drivers/clk/samsung/clk-exynos-clkout.c            | 153 +++++++++++++++++++++
 3 files changed, 184 insertions(+)
 create mode 100644 drivers/clk/samsung/clk-exynos-clkout.c

diff --git a/Documentation/devicetree/bindings/arm/samsung/pmu.txt b/Documentation/devicetree/bindings/arm/samsung/pmu.txt
index 2a4ab04..f9865e7 100644
--- a/Documentation/devicetree/bindings/arm/samsung/pmu.txt
+++ b/Documentation/devicetree/bindings/arm/samsung/pmu.txt
@@ -12,8 +12,38 @@ Properties:
 
  - reg : offset and length of the register set.
 
+ - #clock-cells : must be <1>, since PMU requires once cell as clock specifier.
+		The single specifier cell is used as index to list of clocks
+		provided by PMU, which is currently:
+			0 : SoC clock output (CLKOUT pin)
+
+ - clock-names : list of clock names for particular CLKOUT mux inputs in
+		following format:
+			"clkoutN", where N is a decimal number corresponding to
+			CLKOUT mux control bits value for given input, e.g.
+				"clkout0", "clkout7", "clkout15".
+
+ - clocks : list of phandles and specifiers to all input clocks listed in
+		clock-names property.
+
 Example :
 pmu_system_controller: system-controller at 10040000 {
 	compatible = "samsung,exynos5250-pmu", "syscon";
 	reg = <0x10040000 0x5000>;
+	#clock-cells = <1>;
+	clock-names = "clkout0", "clkout1", "clkout2", "clkout3",
+			"clkout4", "clkout8", "clkout9";
+	clocks = <&clock CLK_OUT_DMC>, <&clock CLK_OUT_TOP>,
+		<&clock CLK_OUT_LEFTBUS>, <&clock CLK_OUT_RIGHTBUS>,
+		<&clock CLK_OUT_CPU>, <&clock CLK_XXTI>,
+		<&clock CLK_XUSBXTI>;
+};
+
+Example of clock consumer :
+
+usb3503: usb3503 at 08 {
+	/* ... */
+	clock-names = "refclk";
+	clocks = <&pmu_system_controller 0>;
+	/* ... */
 };
diff --git a/drivers/clk/samsung/Makefile b/drivers/clk/samsung/Makefile
index 69e8177..2949a55 100644
--- a/drivers/clk/samsung/Makefile
+++ b/drivers/clk/samsung/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_SOC_EXYNOS5410)	+= clk-exynos5410.o
 obj-$(CONFIG_SOC_EXYNOS5420)	+= clk-exynos5420.o
 obj-$(CONFIG_SOC_EXYNOS5440)	+= clk-exynos5440.o
 obj-$(CONFIG_ARCH_EXYNOS)	+= clk-exynos-audss.o
+obj-$(CONFIG_ARCH_EXYNOS)	+= clk-exynos-clkout.o
 obj-$(CONFIG_S3C2410_COMMON_CLK)+= clk-s3c2410.o
 obj-$(CONFIG_S3C2410_COMMON_DCLK)+= clk-s3c2410-dclk.o
 obj-$(CONFIG_S3C2412_COMMON_CLK)+= clk-s3c2412.o
diff --git a/drivers/clk/samsung/clk-exynos-clkout.c b/drivers/clk/samsung/clk-exynos-clkout.c
new file mode 100644
index 0000000..3a7cb25
--- /dev/null
+++ b/drivers/clk/samsung/clk-exynos-clkout.c
@@ -0,0 +1,153 @@
+/*
+ * Copyright (c) 2014 Samsung Electronics Co., Ltd.
+ * Author: Tomasz Figa <t.figa@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Clock driver for Exynos clock output
+ */
+
+#include <linux/clk.h>
+#include <linux/clkdev.h>
+#include <linux/clk-provider.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/syscore_ops.h>
+
+#define EXYNOS_CLKOUT_NR_CLKS		1
+#define EXYNOS_CLKOUT_PARENTS		32
+
+#define EXYNOS_PMU_DEBUG_REG		0xa00
+#define EXYNOS_CLKOUT_DISABLE_SHIFT	0
+#define EXYNOS_CLKOUT_MUX_SHIFT		8
+#define EXYNOS4_CLKOUT_MUX_MASK		0xf
+#define EXYNOS5_CLKOUT_MUX_MASK		0x1f
+
+struct exynos_clkout {
+	struct clk_gate gate;
+	struct clk_mux mux;
+	spinlock_t slock;
+	struct clk_onecell_data data;
+	struct clk *clk_table[EXYNOS_CLKOUT_NR_CLKS];
+	void __iomem *reg;
+	u32 pmu_debug_save;
+};
+
+static struct exynos_clkout *clkout;
+
+static int exynos_clkout_suspend(void)
+{
+	clkout->pmu_debug_save = readl(clkout->reg + EXYNOS_PMU_DEBUG_REG);
+
+	return 0;
+}
+
+static void exynos_clkout_resume(void)
+{
+	writel(clkout->pmu_debug_save, clkout->reg + EXYNOS_PMU_DEBUG_REG);
+}
+
+static struct syscore_ops exynos_clkout_syscore_ops = {
+	.suspend = exynos_clkout_suspend,
+	.resume = exynos_clkout_resume,
+};
+
+static void __init exynos_clkout_init(struct device_node *node, u32 mux_mask)
+{
+	const char *parent_names[EXYNOS_CLKOUT_PARENTS];
+	struct clk *parents[EXYNOS_CLKOUT_PARENTS];
+	int parent_count;
+	int ret;
+	int i;
+
+	clkout = kzalloc(sizeof(*clkout), GFP_KERNEL);
+	if (!clkout)
+		return;
+
+	spin_lock_init(&clkout->slock);
+
+	parent_count = 0;
+	for (i = 0; i < EXYNOS_CLKOUT_PARENTS; ++i) {
+		char name[] = "clkoutXX";
+
+		snprintf(name, sizeof(name), "clkout%d", i);
+		parents[i] = of_clk_get_by_name(node, name);
+		if (IS_ERR(parents[i])) {
+			parent_names[i] = "none";
+			continue;
+		}
+
+		parent_names[i] = __clk_get_name(parents[i]);
+		parent_count = i + 1;
+	}
+
+	if (!parent_count)
+		goto free_clkout;
+
+	clkout->reg = of_iomap(node, 0);
+	if (!clkout->reg)
+		goto clks_put;
+
+	clkout->gate.reg = clkout->reg + EXYNOS_PMU_DEBUG_REG;
+	clkout->gate.bit_idx = EXYNOS_CLKOUT_DISABLE_SHIFT;
+	clkout->gate.flags = CLK_GATE_SET_TO_DISABLE;
+	clkout->gate.lock = &clkout->slock;
+
+	clkout->mux.reg = clkout->reg + EXYNOS_PMU_DEBUG_REG;
+	clkout->mux.mask = mux_mask;
+	clkout->mux.shift = EXYNOS_CLKOUT_MUX_SHIFT;
+	clkout->mux.lock = &clkout->slock;
+
+	clkout->clk_table[0] = clk_register_composite(NULL, "clkout",
+				parent_names, parent_count, &clkout->mux.hw,
+				&clk_mux_ops, NULL, NULL, &clkout->gate.hw,
+				&clk_gate_ops, CLK_SET_RATE_PARENT
+				| CLK_SET_RATE_NO_REPARENT);
+	if (IS_ERR(clkout->clk_table[0]))
+		goto err_unmap;
+
+	clkout->data.clks = clkout->clk_table;
+	clkout->data.clk_num = EXYNOS_CLKOUT_NR_CLKS;
+	ret = of_clk_add_provider(node, of_clk_src_onecell_get, &clkout->data);
+	if (ret)
+		goto err_clk_unreg;
+
+	register_syscore_ops(&exynos_clkout_syscore_ops);
+
+	return;
+
+err_clk_unreg:
+	clk_unregister(clkout->clk_table[0]);
+err_unmap:
+	iounmap(clkout->reg);
+clks_put:
+	for (i = 0; i < EXYNOS_CLKOUT_PARENTS; ++i)
+		if (!IS_ERR(parents[i]))
+			clk_put(parents[i]);
+free_clkout:
+	kfree(clkout);
+
+	pr_err("%s: failed to register clkout clock\n", __func__);
+}
+
+static void __init exynos4_clkout_init(struct device_node *node)
+{
+	exynos_clkout_init(node, EXYNOS4_CLKOUT_MUX_MASK);
+}
+CLK_OF_DECLARE(exynos4210_clkout, "samsung,exynos4210-pmu",
+		exynos4_clkout_init);
+CLK_OF_DECLARE(exynos4212_clkout, "samsung,exynos4212-pmu",
+		exynos4_clkout_init);
+CLK_OF_DECLARE(exynos4412_clkout, "samsung,exynos4412-pmu",
+		exynos4_clkout_init);
+
+static void __init exynos5_clkout_init(struct device_node *node)
+{
+	exynos_clkout_init(node, EXYNOS5_CLKOUT_MUX_MASK);
+}
+CLK_OF_DECLARE(exynos5250_clkout, "samsung,exynos5250-pmu",
+		exynos5_clkout_init);
+CLK_OF_DECLARE(exynos5420_clkout, "samsung,exynos5420-pmu",
+		exynos5_clkout_init);
-- 
1.9.3
