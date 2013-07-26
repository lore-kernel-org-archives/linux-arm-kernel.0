From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Fri, 26 Jul 2013 18:05:31 +0800
Subject: [PATCH v6 09/11] clk: mmp: parse clock from dts
In-Reply-To: <1374833133-21119-1-git-send-email-haojian.zhuang@gmail.com>
References: <1374833133-21119-1-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <1374833133-21119-10-git-send-email-haojian.zhuang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Parse clock information from DTS file for mach-mmp.

Changelog:
v6:
1. Remove marvell string from properties in clock driver.
2. Append document for clock binding device tree.
3. Use apbc to replace apbcp. Since the main difference is register
base.

v5:
1. Replace clk_register_mux() by clk_register_mux_table().

Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
---
 .../devicetree/bindings/clock/mmp-clock.txt        |  51 ++++
 arch/arm/mach-mmp/mmp-dt.c                         |   2 +
 drivers/clk/mmp/Makefile                           |   2 +-
 drivers/clk/mmp/clk-mmp.c                          | 300 +++++++++++++++++++++
 4 files changed, 354 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/clock/mmp-clock.txt
 create mode 100644 drivers/clk/mmp/clk-mmp.c

diff --git a/Documentation/devicetree/bindings/clock/mmp-clock.txt b/Documentation/devicetree/bindings/clock/mmp-clock.txt
new file mode 100644
index 0000000..5fe52a2
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/mmp-clock.txt
@@ -0,0 +1,51 @@
+Device Tree Clock bindings for arch-mmp
+
+This binding uses the common clock binding[1].
+
+[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
+
+Required properties for fixed rate clocks:
+  - compatible : should be "marvell,mmp-fixed-clkrate".
+  - clocks : should be the input parent clock phandle for the clock. This
+	should be the reference clock.
+  - clock-output-names : should be reference name.
+  - #clock-cells : from common clock binding; should be set to 0.
+  - clock-frequency : frequency of the fixed rate clock
+
+Required properties for fixed factor clocks:
+  - compatible : should be "marvell,mmp-fixed-clkfactor".
+  - clocks : should be the input parent clock phandle for the clock. This
+	should be the reference clock.
+  - clock-output-names : should be reference name.
+  - #clock-cells : from common clock binding; should be set to 0.
+
+Required properties for mux clocks:
+  - compatible : should be "marvell,mmp-clkmux".
+  - clocks : should be the input parent clock phandle for the clock. This
+	should be the reference clock.
+  - clock-output-names : should be reference name.
+  - #clock-cells : from common clock binding; should be set to 0.
+  - mmp-clk-reg : mux register offset & mask bits.
+  - mmp-clk-sel : array of mux select bits
+
+Required properties for divider clocks:
+  - compatible : should be "marvell,mmp-apmu-clkdiv".
+  - clocks : should be the input parent clock phandle for the clock. This
+	should be the reference clock.
+  - clock-output-names : should be reference name.
+  - #clock-cells : from common clock binding; should be set to 0.
+  - mmp-clk-reg : divider register offset & mask bits.
+
+Required properties for gate clocks:
+  - compatible : should be "marvell,mmp-apbc-clk".
+  - clocks : should be the input parent clock phandle for the clock. This
+	should be the reference clock.
+  - clock-output-names : should be reference name.
+  - #clock-cells : from common clock binding; should be set to 0.
+  - mmp-clk-reg : gate register offset & mask bits.
+
+Optional properties for gate clocks:
+  - mmp-clk-delay : delay between enabling function clock and apb clock
+  - mmp-apbc-power-ctrl : enable apbc power control bit
+
+For example:
diff --git a/arch/arm/mach-mmp/mmp-dt.c b/arch/arm/mach-mmp/mmp-dt.c
index cca529c..f109bf6 100644
--- a/arch/arm/mach-mmp/mmp-dt.c
+++ b/arch/arm/mach-mmp/mmp-dt.c
@@ -9,6 +9,7 @@
  *  publishhed by the Free Software Foundation.
  */
 
+#include <linux/clk-provider.h>
 #include <linux/irqchip.h>
 #include <linux/of_platform.h>
 #include <asm/mach/arch.h>
@@ -48,6 +49,7 @@ static void __init pxa168_dt_init(void)
 
 static void __init pxa910_dt_init(void)
 {
+	of_clk_init(NULL);
 	of_platform_populate(NULL, of_default_bus_match_table,
 			     pxa910_auxdata_lookup, NULL);
 }
diff --git a/drivers/clk/mmp/Makefile b/drivers/clk/mmp/Makefile
index 392d780..83182e5 100644
--- a/drivers/clk/mmp/Makefile
+++ b/drivers/clk/mmp/Makefile
@@ -2,7 +2,7 @@
 # Makefile for mmp specific clk
 #
 
-obj-y += clk-apbc.o clk-apmu.o clk-frac.o
+obj-y += clk-apbc.o clk-apmu.o clk-frac.o clk-mmp.o
 
 obj-$(CONFIG_CPU_PXA168) += clk-pxa168.o
 obj-$(CONFIG_CPU_PXA910) += clk-pxa910.o
diff --git a/drivers/clk/mmp/clk-mmp.c b/drivers/clk/mmp/clk-mmp.c
new file mode 100644
index 0000000..50c16a0
--- /dev/null
+++ b/drivers/clk/mmp/clk-mmp.c
@@ -0,0 +1,300 @@
+/*
+ * Marvell MMP clock driver
+ *
+ * Copyright (c) 2012-2013 Linaro Limited.
+ *
+ * Author: Haojian Zhuang <haojian.zhuang@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/clkdev.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/slab.h>
+
+#include "clk.h"
+
+enum {
+	MMP_MPMU = 0,
+	MMP_APMU,
+	MMP_APBC,
+	MMP_APBCP,
+	MMP_APB,
+	MMP_MAX,
+};
+
+static void __iomem *mmp_clk_base[MMP_MAX];
+
+static DEFINE_SPINLOCK(mmp_clk_lock);
+
+static const struct of_device_id mmp_of_match[] = {
+	{ .compatible = "marvell,mmp-mpmu", .data = (void *)MMP_MPMU, },
+	{ .compatible = "marvell,mmp-apmu", .data = (void *)MMP_APMU, },
+	{ .compatible = "marvell,mmp-apbc", .data = (void *)MMP_APBC, },
+	{ .compatible = "marvell,mmp-apbcp", .data = (void *)MMP_APBCP, },
+	{ .compatible = "mrvl,apb-bus", .data = (void *)MMP_APB, },
+};
+
+void __iomem __init *mmp_init_clocks(struct device_node *np)
+{
+	struct device_node *parent;
+	const struct of_device_id *match;
+	void __iomem *ret = NULL;
+	int i;
+
+	parent = of_get_parent(np);
+	if (!parent)
+		goto out;
+	match = of_match_node(mmp_of_match, parent);
+	if (!match)
+		goto out;
+
+	i = (unsigned int)match->data;
+	switch (i) {
+	case MMP_MPMU:
+	case MMP_APMU:
+	case MMP_APBC:
+	case MMP_APBCP:
+	case MMP_APB:
+		if (!mmp_clk_base[i]) {
+			ret = of_iomap(parent, 0);
+			WARN_ON(!ret);
+			mmp_clk_base[i] = ret;
+		} else {
+			ret = mmp_clk_base[i];
+		}
+		break;
+	default:
+		goto out;
+	}
+out:
+	return ret;
+}
+
+static void __init mmp_fixed_rate_setup(struct device_node *np)
+{
+	struct clk *clk;
+	const char *clk_name, *parent_name;
+	int rate;
+
+	if (of_property_read_u32(np, "clock-frequency", &rate))
+		return;
+
+	if (of_property_read_string(np, "clock-output-names", &clk_name))
+		return;
+
+	/* this node has only one parent */
+	parent_name = of_clk_get_parent_name(np, 0);
+	if (!parent_name)
+		return;
+
+	clk = clk_register_fixed_rate(NULL, clk_name, parent_name, 0, rate);
+	if (IS_ERR(clk))
+		return;
+	of_clk_add_provider(np, of_clk_src_simple_get, clk);
+}
+CLK_OF_DECLARE(mmp_fixed_rate, "marvell,mmp-fixed-clkrate",
+	       mmp_fixed_rate_setup);
+
+static void __init mmp_fixed_factor_setup(struct device_node *np)
+{
+	struct clk *clk;
+	const char *clk_name, *parent_name;
+	u32 data[2];
+
+	if (of_property_read_u32_array(np, "mmp-fixed-factor",
+				&data[0], 2))
+		return;
+	if (of_property_read_string(np, "clock-output-names", &clk_name))
+		return;
+
+	/* this node has only one parent */
+	parent_name = of_clk_get_parent_name(np, 0);
+	if (!parent_name)
+		return;
+
+	clk = clk_register_fixed_factor(NULL, clk_name, parent_name, 0,
+			data[0], data[1]);
+	if (IS_ERR(clk))
+		return;
+	clk_register_clkdev(clk, clk_name, NULL);
+	of_clk_add_provider(np, of_clk_src_simple_get, clk);
+}
+CLK_OF_DECLARE(mmp_fixed_factor, "marvell,mmp-fixed-clkfactor",
+	       mmp_fixed_factor_setup);
+
+static void __init mmp_apmu_div_setup(struct device_node *np)
+{
+	u32 data[2];
+	u8 shift, width;
+	void __iomem *reg, *base;
+	const char *parent_name, *clk_name;
+	struct clk *clk;
+
+	base = mmp_init_clocks(np);
+	if (!base)
+		return;
+
+	if (of_property_read_u32_array(np, "mmp-clk-reg", &data[0], 2))
+		return;
+	reg = base + data[0];
+	shift = ffs(data[1]) - 1;
+	width = fls(data[1]) - ffs(data[1]) + 1;
+
+	parent_name = of_clk_get_parent_name(np, 0);
+	if (!parent_name)
+		return;
+	if (of_property_read_string(np, "clock-output-names", &clk_name))
+		return;
+
+	clk = clk_register_divider(NULL, clk_name, parent_name,
+			CLK_SET_RATE_PARENT, reg, shift, width, 0,
+			&mmp_clk_lock);
+	if (IS_ERR(clk))
+		return;
+	of_clk_add_provider(np, of_clk_src_simple_get, clk);
+	return;
+}
+CLK_OF_DECLARE(mmp_div, "marvell,mmp-apmu-clkdiv", mmp_apmu_div_setup);
+
+static int __init mmp_parse_mux(struct device_node *np,
+				u8 *num_parents,
+				u32 *clk_sel)
+{
+	int i, cnt, ret;
+
+	/* get the count of items in mux */
+	for (i = 0, cnt = 0; ; i++, cnt++) {
+		/* parent's #clock-cells property is always 0 */
+		if (!of_parse_phandle(np, "clocks", i))
+			break;
+	}
+
+	for (i = 0; i < cnt; i++) {
+		if (!of_clk_get_parent_name(np, i))
+			break;
+	}
+	*num_parents = cnt;
+	clk_sel = kzalloc(sizeof(u32 *) * cnt, GFP_KERNEL);
+	if (!clk_sel)
+		return -ENOMEM;
+	ret = of_property_read_u32_array(np, "mmp-clk-sel", clk_sel, cnt);
+	if (ret)
+		goto err;
+	return 0;
+err:
+	kfree(clk_sel);
+	return ret;
+}
+
+static void __init mmp_mux_setup(struct device_node *np)
+{
+	u32 data[2], mask, *clk_sel = NULL, mux_flags = 0;
+	u8 shift, num_parents;
+	void __iomem *reg, *base;
+	const char **parent_names;
+	const char *clk_name;
+	struct clk *clk;
+	int i, ret;
+
+	base = mmp_init_clocks(np);
+	if (!base)
+		return;
+	if (of_property_read_string(np, "clock-output-names", &clk_name))
+		return;
+	if (of_property_read_u32_array(np, "mmp-clk-reg", &data[0], 2))
+		return;
+	ret = mmp_parse_mux(np, &num_parents, clk_sel);
+	if (ret)
+		return;
+
+	reg = base + data[0];
+	shift = ffs(data[1]) - 1;
+	mask = data[1] >> shift;
+
+	parent_names = kzalloc(sizeof(char *) * num_parents, GFP_KERNEL);
+	if (!parent_names)
+		goto err;
+	for (i = 0; i < num_parents; i++)
+		parent_names[i] = of_clk_get_parent_name(np, i);
+	clk = clk_register_mux_table(NULL, clk_name, parent_names, num_parents,
+				     CLK_SET_RATE_PARENT, reg, shift, mask,
+				     mux_flags, clk_sel, &mmp_clk_lock);
+	if (IS_ERR(clk))
+		goto err_clk;
+	of_clk_add_provider(np, of_clk_src_simple_get, clk);
+	return;
+err_clk:
+	kfree(parent_names);
+err:
+	kfree(clk_sel);
+}
+CLK_OF_DECLARE(mmp_mux, "marvell,mmp-clkmux", mmp_mux_setup);
+
+#define APBC_NO_BUS_CTRL	BIT(0)
+#define APBC_POWER_CTRL		BIT(1)
+
+static void __init mmp_apbc_setup(struct device_node *np)
+{
+	u32 data[2], delay, apbc_flags, clkdev;
+	void __iomem *reg, *base;
+	const char **parent_names;
+	const char *clk_name = NULL;
+	struct clk *clk;
+
+	base = mmp_init_clocks(np);
+	if (!base)
+		return;
+
+	if (of_property_read_string(np, "clock-names", &clk_name))
+		clkdev = 1;
+	else {
+		of_property_read_string(np, "clock-output-names", &clk_name);
+		clkdev = 0;
+	}
+
+	if (of_property_read_u32_array(np, "mmp-clk-reg", &data[0], 2))
+		return;
+	/* If mmp-clk-delay property isn't defined, set delay as 10us */
+	if (of_property_read_u32(np, "mmp-clk-delay", &delay))
+		delay = 10;
+	if (of_get_property(np, "mmp-apbc-power-ctrl", NULL))
+		apbc_flags |= APBC_POWER_CTRL;
+
+	reg = base + data[0];
+
+	/* only has the fixed parent */
+	parent_names = kzalloc(sizeof(char *), GFP_KERNEL);
+	if (!parent_names)
+		return;
+	parent_names[0] = of_clk_get_parent_name(np, 0);
+
+	clk = mmp_clk_register_apbc(clk_name, parent_names[0],
+				    reg, delay, 0, &mmp_clk_lock);
+	if (IS_ERR(clk)) {
+		kfree(parent_names);
+		return;
+	}
+	if (clkdev)
+		clk_register_clkdev(clk, clk_name, NULL);
+	of_clk_add_provider(np, of_clk_src_simple_get, clk);
+}
+CLK_OF_DECLARE(mmp_apbc, "marvell,mmp-apbc-clk", mmp_apbc_setup);
-- 
1.8.1.2
