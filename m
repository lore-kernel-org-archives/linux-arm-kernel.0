From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 20 Oct 2014 22:10:27 +0800
Subject: [PATCH v2 2/5] clk: sunxi: Add support for A80 basic bus clocks
In-Reply-To: <1413814230-13735-1-git-send-email-wens@csie.org>
References: <1413814230-13735-1-git-send-email-wens@csie.org>
Message-ID: <1413814230-13735-3-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A80 SoC has 12 PLL clocks, 3 AHB clocks, 2 APB clocks, and a
new "GT" bus, which I assume is some kind of data bus connecting
the processor cores, memory and various busses. Also there is a
bus clock for a ARM CCI400 module.

As far as I can tell, the GT bus and CCI400 bus clock must be
protected.

This patch adds driver support for peripheral related PLLs and
bus clocks on the A80. The GT and CCI400 clocks are added as well
as these 2 along with the PLLs they are clocked from must not be
disabled.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 Documentation/devicetree/bindings/clock/sunxi.txt |   5 +
 drivers/clk/sunxi/Makefile                        |   1 +
 drivers/clk/sunxi/clk-sun9i-core.c                | 272 ++++++++++++++++++++++
 3 files changed, 278 insertions(+)
 create mode 100644 drivers/clk/sunxi/clk-sun9i-core.c

diff --git a/Documentation/devicetree/bindings/clock/sunxi.txt b/Documentation/devicetree/bindings/clock/sunxi.txt
index ed116df..7f1c486 100644
--- a/Documentation/devicetree/bindings/clock/sunxi.txt
+++ b/Documentation/devicetree/bindings/clock/sunxi.txt
@@ -10,14 +10,17 @@ Required properties:
 	"allwinner,sun4i-a10-pll1-clk" - for the main PLL clock and PLL4
 	"allwinner,sun6i-a31-pll1-clk" - for the main PLL clock on A31
 	"allwinner,sun8i-a23-pll1-clk" - for the main PLL clock on A23
+	"allwinner,sun9i-a80-pll4-clk" - for the peripheral PLLs on A80
 	"allwinner,sun4i-a10-pll5-clk" - for the PLL5 clock
 	"allwinner,sun4i-a10-pll6-clk" - for the PLL6 clock
 	"allwinner,sun6i-a31-pll6-clk" - for the PLL6 clock on A31
+	"allwinner,sun9i-a80-gt-clk" - for the GT bus clock on A80
 	"allwinner,sun4i-a10-cpu-clk" - for the CPU multiplexer clock
 	"allwinner,sun4i-a10-axi-clk" - for the AXI clock
 	"allwinner,sun8i-a23-axi-clk" - for the AXI clock on A23
 	"allwinner,sun4i-a10-axi-gates-clk" - for the AXI gates
 	"allwinner,sun4i-a10-ahb-clk" - for the AHB clock
+	"allwinner,sun9i-a80-ahb-clk" - for the AHB bus clocks on A80
 	"allwinner,sun4i-a10-ahb-gates-clk" - for the AHB gates on A10
 	"allwinner,sun5i-a13-ahb-gates-clk" - for the AHB gates on A13
 	"allwinner,sun5i-a10s-ahb-gates-clk" - for the AHB gates on A10s
@@ -29,6 +32,7 @@ Required properties:
 	"allwinner,sun4i-a10-apb0-clk" - for the APB0 clock
 	"allwinner,sun6i-a31-apb0-clk" - for the APB0 clock on A31
 	"allwinner,sun8i-a23-apb0-clk" - for the APB0 clock on A23
+	"allwinner,sun9i-a80-apb0-clk" - for the APB0 bus clock on A80
 	"allwinner,sun4i-a10-apb0-gates-clk" - for the APB0 gates on A10
 	"allwinner,sun5i-a13-apb0-gates-clk" - for the APB0 gates on A13
 	"allwinner,sun5i-a10s-apb0-gates-clk" - for the APB0 gates on A10s
@@ -36,6 +40,7 @@ Required properties:
 	"allwinner,sun7i-a20-apb0-gates-clk" - for the APB0 gates on A20
 	"allwinner,sun8i-a23-apb0-gates-clk" - for the APB0 gates on A23
 	"allwinner,sun4i-a10-apb1-clk" - for the APB1 clock
+	"allwinner,sun9i-a80-apb1-clk" - for the APB1 bus clock on A80
 	"allwinner,sun4i-a10-apb1-mux-clk" - for the APB1 clock muxing
 	"allwinner,sun4i-a10-apb1-gates-clk" - for the APB1 gates on A10
 	"allwinner,sun5i-a13-apb1-gates-clk" - for the APB1 gates on A13
diff --git a/drivers/clk/sunxi/Makefile b/drivers/clk/sunxi/Makefile
index 7ddc2b5..a66953c 100644
--- a/drivers/clk/sunxi/Makefile
+++ b/drivers/clk/sunxi/Makefile
@@ -7,6 +7,7 @@ obj-y += clk-a10-hosc.o
 obj-y += clk-a20-gmac.o
 obj-y += clk-mod0.o
 obj-y += clk-sun8i-mbus.o
+obj-y += clk-sun9i-core.o
 
 obj-$(CONFIG_MFD_SUN6I_PRCM) += \
 	clk-sun6i-ar100.o clk-sun6i-apb0.o clk-sun6i-apb0-gates.o \
diff --git a/drivers/clk/sunxi/clk-sun9i-core.c b/drivers/clk/sunxi/clk-sun9i-core.c
new file mode 100644
index 0000000..b509e26
--- /dev/null
+++ b/drivers/clk/sunxi/clk-sun9i-core.c
@@ -0,0 +1,272 @@
+/*
+ * Copyright 2014 Chen-Yu Tsai
+ *
+ * Chen-Yu Tsai <wens@csie.org>
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
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/clkdev.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/log2.h>
+
+#include "clk-factors.h"
+
+
+/**
+ * sun9i_a80_get_pll4_factors() - calculates n, p, m factors for PLL1
+ * PLL4 rate is calculated as follows
+ * rate = (parent_rate * n >> p) / (m + 1);
+ * parent_rate is always 24Mhz
+ *
+ * p and m are named div1 and div2 in Allwinner's SDK
+ */
+
+static void sun9i_a80_get_pll4_factors(u32 *freq, u32 parent_rate,
+				       u8 *n, u8 *k, u8 *m, u8 *p)
+{
+	int div;
+
+	/* Normalize value to a 6M multiple */
+	div = DIV_ROUND_UP(*freq, 6000000);
+
+	/* divs above 256 cannot be odd */
+	if (div > 256)
+		div = round_up(div, 2);
+
+	/* divs above 512 must be a multiple of 4 */
+	if (div > 512)
+		div = round_up(div, 4);
+
+	*freq = 6000000 * div;
+
+	/* we were called to round the frequency, we can now return */
+	if (n == NULL)
+		return;
+
+	/* p will be 1 for divs under 512 */
+	if (div < 512)
+		*p = 1;
+	else
+		*p = 0;
+
+	/* m will be 1 if div is odd */
+	if (div & 1)
+		*m = 1;
+	else
+		*m = 0;
+
+	/* calculate a suitable n based on m and p */
+	*n = div / (*p + 1) / (*m + 1);
+}
+
+static struct clk_factors_config sun9i_a80_pll4_config = {
+	.mshift = 18,
+	.mwidth = 1,
+	.nshift = 8,
+	.nwidth = 8,
+	.pshift = 16,
+	.pwidth = 1,
+};
+
+static const struct factors_data sun9i_a80_pll4_data __initconst = {
+	.enable = 31,
+	.table = &sun9i_a80_pll4_config,
+	.getter = sun9i_a80_get_pll4_factors,
+};
+
+static DEFINE_SPINLOCK(sun9i_a80_pll4_lock);
+
+static void __init sun9i_a80_pll4_setup(struct device_node *node)
+{
+	sunxi_factors_register(node, &sun9i_a80_pll4_data, &sun9i_a80_pll4_lock);
+}
+CLK_OF_DECLARE(sun9i_a80_pll4, "allwinner,sun9i-a80-pll4-clk", sun9i_a80_pll4_setup);
+
+
+/**
+ * sun9i_a80_get_gt_factors() - calculates m factor for GT
+ * GT rate is calculated as follows
+ * rate = parent_rate / (m + 1);
+ */
+
+static void sun9i_a80_get_gt_factors(u32 *freq, u32 parent_rate,
+				     u8 *n, u8 *k, u8 *m, u8 *p)
+{
+	u32 div;
+
+	if (parent_rate < *freq)
+		*freq = parent_rate;
+
+	div = DIV_ROUND_UP(parent_rate, *freq);
+
+	/* maximum divider is 4 */
+	if (div > 4)
+		div = 4;
+
+	*freq = parent_rate / div;
+
+	/* we were called to round the frequency, we can now return */
+	if (!m)
+		return;
+
+	*m = div;
+}
+
+static struct clk_factors_config sun9i_a80_gt_config = {
+	.mshift = 0,
+	.mwidth = 2,
+};
+
+static const struct factors_data sun9i_a80_gt_data __initconst = {
+	.mux = 24,
+	.muxmask = BIT(1) | BIT(0),
+	.table = &sun9i_a80_gt_config,
+	.getter = sun9i_a80_get_gt_factors,
+};
+
+static DEFINE_SPINLOCK(sun9i_a80_gt_lock);
+
+static void __init sun9i_a80_gt_setup(struct device_node *node)
+{
+	struct clk *gt = sunxi_factors_register(node, &sun9i_a80_gt_data,
+						&sun9i_a80_gt_lock);
+
+	/* The GT bus clock needs to be always enabled */
+	__clk_get(gt);
+	clk_prepare_enable(gt);
+}
+CLK_OF_DECLARE(sun9i_a80_gt, "allwinner,sun9i-a80-gt-clk", sun9i_a80_gt_setup);
+
+
+/**
+ * sun9i_a80_get_ahb_factors() - calculates p factor for AHB0/1/2
+ * AHB rate is calculated as follows
+ * rate = parent_rate >> p;
+ */
+
+static void sun9i_a80_get_ahb_factors(u32 *freq, u32 parent_rate,
+				      u8 *n, u8 *k, u8 *m, u8 *p)
+{
+	u32 _p;
+
+	if (parent_rate < *freq)
+		*freq = parent_rate;
+
+	_p = order_base_2(DIV_ROUND_UP(parent_rate, *freq));
+
+	/* maximum p is 3 */
+	if (_p > 3)
+		_p = 3;
+
+	*freq = parent_rate >> _p;
+
+	/* we were called to round the frequency, we can now return */
+	if (!p)
+		return;
+
+	*p = _p;
+}
+
+static struct clk_factors_config sun9i_a80_ahb_config = {
+	.pshift = 0,
+	.pwidth = 2,
+};
+
+static const struct factors_data sun9i_a80_ahb_data __initconst = {
+	.mux = 24,
+	.muxmask = BIT(1) | BIT(0),
+	.table = &sun9i_a80_ahb_config,
+	.getter = sun9i_a80_get_ahb_factors,
+};
+
+static DEFINE_SPINLOCK(sun9i_a80_ahb_lock);
+
+static void __init sun9i_a80_ahb_setup(struct device_node *node)
+{
+	sunxi_factors_register(node, &sun9i_a80_ahb_data, &sun9i_a80_ahb_lock);
+}
+CLK_OF_DECLARE(sun9i_a80_ahb, "allwinner,sun9i-a80-ahb-clk", sun9i_a80_ahb_setup);
+
+
+static const struct factors_data sun9i_a80_apb0_data __initconst = {
+	.mux = 24,
+	.muxmask = BIT(0),
+	.table = &sun9i_a80_ahb_config,
+	.getter = sun9i_a80_get_ahb_factors,
+};
+
+static DEFINE_SPINLOCK(sun9i_a80_apb0_lock);
+
+static void __init sun9i_a80_apb0_setup(struct device_node *node)
+{
+	sunxi_factors_register(node, &sun9i_a80_apb0_data, &sun9i_a80_apb0_lock);
+}
+CLK_OF_DECLARE(sun9i_a80_apb0, "allwinner,sun9i-a80-apb0-clk", sun9i_a80_apb0_setup);
+
+
+/**
+ * sun9i_a80_get_apb1_factors() - calculates m, p factors for APB1
+ * APB1 rate is calculated as follows
+ * rate = (parent_rate >> p) / (m + 1);
+ */
+
+static void sun9i_a80_get_apb1_factors(u32 *freq, u32 parent_rate,
+				       u8 *n, u8 *k, u8 *m, u8 *p)
+{
+	u32 div;
+	u8 calcm, calcp;
+
+	if (parent_rate < *freq)
+		*freq = parent_rate;
+
+	div = DIV_ROUND_UP(parent_rate, *freq);
+
+	/* Highest possible divider is 256 (p = 3, m = 31) */
+	if (div > 256)
+		div = 256;
+
+	calcp = order_base_2(div);
+	calcm = (parent_rate >> calcp) - 1;
+	*freq = (parent_rate >> calcp) / (calcm + 1);
+
+	/* we were called to round the frequency, we can now return */
+	if (n == NULL)
+		return;
+
+	*m = calcm;
+	*p = calcp;
+}
+
+static struct clk_factors_config sun9i_a80_apb1_config = {
+	.mshift = 0,
+	.mwidth = 5,
+	.pshift = 16,
+	.pwidth = 2,
+};
+
+static const struct factors_data sun9i_a80_apb1_data __initconst = {
+	.mux = 24,
+	.muxmask = BIT(0),
+	.table = &sun9i_a80_apb1_config,
+	.getter = sun9i_a80_get_apb1_factors,
+};
+
+static DEFINE_SPINLOCK(sun9i_a80_apb1_lock);
+
+static void __init sun9i_a80_apb1_setup(struct device_node *node)
+{
+	sunxi_factors_register(node, &sun9i_a80_apb1_data, &sun9i_a80_apb1_lock);
+}
+CLK_OF_DECLARE(sun9i_a80_apb1, "allwinner,sun9i-a80-apb1-clk", sun9i_a80_apb1_setup);
+
-- 
2.1.1
