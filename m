From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Wed,  1 Mar 2017 12:15:40 +0800
Subject: [PATCH 2/3] clk: sunxi-ng: add support for PRCM CCUs
In-Reply-To: <20170301041541.24388-1-icenowy@aosc.xyz>
References: <20170301041541.24388-1-icenowy@aosc.xyz>
Message-ID: <20170301041541.24388-3-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SoCs after A31 has a clock controller module in the PRCM part.

Support the clock controller module on H5 and A64 now.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
 drivers/clk/sunxi-ng/Kconfig            |   6 +
 drivers/clk/sunxi-ng/Makefile           |   1 +
 drivers/clk/sunxi-ng/ccu-sun6i-r.c      | 209 ++++++++++++++++++++++++++++++++
 drivers/clk/sunxi-ng/ccu-sun6i-r.h      |  27 +++++
 include/dt-bindings/clock/sun6i-r-ccu.h |  58 +++++++++
 include/dt-bindings/reset/sun6i-r-ccu.h |  54 +++++++++
 6 files changed, 355 insertions(+)
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun6i-r.c
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun6i-r.h
 create mode 100644 include/dt-bindings/clock/sun6i-r-ccu.h
 create mode 100644 include/dt-bindings/reset/sun6i-r-ccu.h

diff --git a/drivers/clk/sunxi-ng/Kconfig b/drivers/clk/sunxi-ng/Kconfig
index 695bbf9ef428..44984c050052 100644
--- a/drivers/clk/sunxi-ng/Kconfig
+++ b/drivers/clk/sunxi-ng/Kconfig
@@ -141,4 +141,10 @@ config SUN9I_A80_CCU
 	select SUNXI_CCU_PHASE
 	default MACH_SUN9I
 
+config SUN6I_R_CCU
+	bool "Support for Allwinner SoCs' PRCM CCUs"
+	select SUNXI_CCU_DIV
+	select SUNXI_CCU_GATE
+	default MACH_SUN8I || (ARCH_SUNXI && ARM64)
+
 endif
diff --git a/drivers/clk/sunxi-ng/Makefile b/drivers/clk/sunxi-ng/Makefile
index 6feaac0c5600..77ebcfd7d2ca 100644
--- a/drivers/clk/sunxi-ng/Makefile
+++ b/drivers/clk/sunxi-ng/Makefile
@@ -21,6 +21,7 @@ obj-$(CONFIG_SUNXI_CCU_MP)	+= ccu_mp.o
 obj-$(CONFIG_SUN50I_A64_CCU)	+= ccu-sun50i-a64.o
 obj-$(CONFIG_SUN5I_CCU)		+= ccu-sun5i.o
 obj-$(CONFIG_SUN6I_A31_CCU)	+= ccu-sun6i-a31.o
+obj-$(CONFIG_SUN6I_R_CCU)	+= ccu-sun6i-r.o
 obj-$(CONFIG_SUN8I_A23_CCU)	+= ccu-sun8i-a23.o
 obj-$(CONFIG_SUN8I_A33_CCU)	+= ccu-sun8i-a33.o
 obj-$(CONFIG_SUN8I_H3_CCU)	+= ccu-sun8i-h3.o
diff --git a/drivers/clk/sunxi-ng/ccu-sun6i-r.c b/drivers/clk/sunxi-ng/ccu-sun6i-r.c
new file mode 100644
index 000000000000..988d6b299e91
--- /dev/null
+++ b/drivers/clk/sunxi-ng/ccu-sun6i-r.c
@@ -0,0 +1,209 @@
+/*
+ * Copyright (c) 2016 Icenowy Zheng <icenowy@aosc.xyz>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+
+#include "ccu_common.h"
+#include "ccu_reset.h"
+
+#include "ccu_div.h"
+#include "ccu_gate.h"
+#include "ccu_mp.h"
+#include "ccu_nm.h"
+
+#include "ccu-sun6i-r.h"
+
+static const char * const cpus_parents[] = { "osc32k", "osc24M",
+					     "pll-periph0" };
+
+static struct ccu_div cpus_clk = {
+	.div		= _SUNXI_CCU_DIV_FLAGS(4, 2, CLK_DIVIDER_POWER_OF_TWO),
+
+	.mux		= {
+		.shift	= 16,
+		.width	= 2,
+
+		.variable_prediv	= {
+			.index	= 2,
+			.shift	= 8,
+			.width	= 5,
+		},
+	},
+
+	.common		= {
+		.reg		= 0x00,
+		.features	= CCU_FEATURE_VARIABLE_PREDIV,
+		.hw.init	= CLK_HW_INIT_PARENTS("cpus",
+						      cpus_parents,
+						      &ccu_div_ops,
+						      0),
+	},
+};
+
+static CLK_FIXED_FACTOR(r_ahb0_clk, "r-ahb0", "cpus", 1, 1, 0);
+
+static struct ccu_div r_apb0_clk = {
+	.div		= _SUNXI_CCU_DIV_FLAGS(0, 2, CLK_DIVIDER_POWER_OF_TWO),
+
+	.common		= {
+		.reg		= 0x0c,
+		.hw.init	= CLK_HW_INIT("r-apb0",
+					      "r-ahb0",
+					      &ccu_div_ops,
+					      0),
+	},
+};
+
+static SUNXI_CCU_GATE(r_bus_pio_clk,	"r-bus-pio",	"r-apb0",
+		      0x28, BIT(0), 0);
+static SUNXI_CCU_GATE(r_bus_ir_clk,	"r-bus-ir",	"r-apb0",
+		      0x28, BIT(1), 0);
+static SUNXI_CCU_GATE(r_bus_timer_clk,	"r-bus-timer",	"r-apb0",
+		      0x28, BIT(2), 0);
+static SUNXI_CCU_GATE(r_bus_rsb_clk,	"r-bus-rsb",	"r-apb0",
+		      0x28, BIT(3), 0);
+static SUNXI_CCU_GATE(r_bus_uart_clk,	"r-bus-uart",	"r-apb0",
+		      0x28, BIT(4), 0);
+static SUNXI_CCU_GATE(r_bus_i2c_clk,	"r-bus-i2c",	"r-apb0",
+		      0x28, BIT(6), 0);
+
+static const char * const r_mod0_default_parents[] = { "osc32K", "osc24M" };
+static SUNXI_CCU_MP_WITH_MUX_GATE(r_ir_clk, "r-ir",
+				  r_mod0_default_parents, 0x54,
+				  0, 4,		/* M */
+				  16, 2,	/* P */
+				  24, 2,	/* mux */
+				  BIT(31),	/* gate */
+				  0);
+
+static struct ccu_common *sun8i_h3_r_ccu_clks[] = {
+	&cpus_clk.common,
+	&r_apb0_clk.common,
+	&r_bus_pio_clk.common,
+	&r_bus_ir_clk.common,
+	&r_bus_timer_clk.common,
+	&r_bus_uart_clk.common,
+	&r_bus_i2c_clk.common,
+	&r_ir_clk.common,
+};
+
+static struct ccu_common *sun50i_a64_r_ccu_clks[] = {
+	&cpus_clk.common,
+	&r_apb0_clk.common,
+	&r_bus_pio_clk.common,
+	&r_bus_ir_clk.common,
+	&r_bus_timer_clk.common,
+	&r_bus_rsb_clk.common,
+	&r_bus_uart_clk.common,
+	&r_bus_i2c_clk.common,
+	&r_ir_clk.common,
+};
+
+static struct clk_hw_onecell_data sun8i_h3_r_hw_clks = {
+	.hws	= {
+		[CLK_CPUS]		= &cpus_clk.common.hw,
+		[CLK_R_AHB0]		= &r_ahb0_clk.hw,
+		[CLK_R_APB0]		= &r_apb0_clk.common.hw,
+		[CLK_R_BUS_PIO]		= &r_bus_pio_clk.common.hw,
+		[CLK_R_BUS_IR]		= &r_bus_ir_clk.common.hw,
+		[CLK_R_BUS_TIMER]	= &r_bus_timer_clk.common.hw,
+		[CLK_R_BUS_UART]	= &r_bus_uart_clk.common.hw,
+		[CLK_R_BUS_I2C]		= &r_bus_i2c_clk.common.hw,
+		[CLK_R_IR]		= &r_ir_clk.common.hw,
+	},
+	.num	= CLK_NUMBER,
+};
+
+static struct clk_hw_onecell_data sun50i_a64_r_hw_clks = {
+	.hws	= {
+		[CLK_CPUS]		= &cpus_clk.common.hw,
+		[CLK_R_AHB0]		= &r_ahb0_clk.hw,
+		[CLK_R_APB0]		= &r_apb0_clk.common.hw,
+		[CLK_R_BUS_PIO]		= &r_bus_pio_clk.common.hw,
+		[CLK_R_BUS_IR]		= &r_bus_ir_clk.common.hw,
+		[CLK_R_BUS_TIMER]	= &r_bus_timer_clk.common.hw,
+		[CLK_R_BUS_RSB]		= &r_bus_rsb_clk.common.hw,
+		[CLK_R_BUS_UART]	= &r_bus_uart_clk.common.hw,
+		[CLK_R_BUS_I2C]		= &r_bus_i2c_clk.common.hw,
+		[CLK_R_IR]		= &r_ir_clk.common.hw,
+	},
+	.num	= CLK_NUMBER,
+};
+
+static struct ccu_reset_map sun8i_h3_r_ccu_resets[] = {
+	[RST_R_BUS_PIO]		=  { 0xb0, BIT(0) },
+	[RST_R_BUS_IR]		=  { 0xb0, BIT(1) },
+	[RST_R_BUS_TIMER]	=  { 0xb0, BIT(2) },
+	[RST_R_BUS_UART]	=  { 0xb0, BIT(4) },
+	[RST_R_BUS_I2C]		=  { 0xb0, BIT(6) },
+};
+
+static struct ccu_reset_map sun50i_a64_r_ccu_resets[] = {
+	[RST_R_BUS_PIO]		=  { 0xb0, BIT(0) },
+	[RST_R_BUS_IR]		=  { 0xb0, BIT(1) },
+	[RST_R_BUS_TIMER]	=  { 0xb0, BIT(2) },
+	[RST_R_BUS_RSB]		=  { 0xb0, BIT(3) },
+	[RST_R_BUS_UART]	=  { 0xb0, BIT(4) },
+	[RST_R_BUS_I2C]		=  { 0xb0, BIT(6) },
+};
+
+static const struct sunxi_ccu_desc sun8i_h3_r_ccu_desc = {
+	.ccu_clks	= sun8i_h3_r_ccu_clks,
+	.num_ccu_clks	= ARRAY_SIZE(sun8i_h3_r_ccu_clks),
+
+	.hw_clks	= &sun8i_h3_r_hw_clks,
+
+	.resets		= sun8i_h3_r_ccu_resets,
+	.num_resets	= ARRAY_SIZE(sun8i_h3_r_ccu_resets),
+};
+
+static const struct sunxi_ccu_desc sun50i_a64_r_ccu_desc = {
+	.ccu_clks	= sun50i_a64_r_ccu_clks,
+	.num_ccu_clks	= ARRAY_SIZE(sun50i_a64_r_ccu_clks),
+
+	.hw_clks	= &sun50i_a64_r_hw_clks,
+
+	.resets		= sun50i_a64_r_ccu_resets,
+	.num_resets	= ARRAY_SIZE(sun50i_a64_r_ccu_resets),
+};
+
+static void __init sunxi_r_ccu_init(struct device_node *node,
+				    const struct sunxi_ccu_desc *desc)
+{
+	void __iomem *reg;
+
+	reg = of_io_request_and_map(node, 0, of_node_full_name(node));
+	if (IS_ERR(reg)) {
+		pr_err("%s: Could not map the clock registers\n",
+		       of_node_full_name(node));
+		return;
+	}
+
+	sunxi_ccu_probe(node, reg, desc);
+}
+
+static void __init sun8i_h3_r_ccu_setup(struct device_node *node)
+{
+	sunxi_r_ccu_init(node, &sun8i_h3_r_ccu_desc);
+}
+CLK_OF_DECLARE(sun8i_h3_r_ccu, "allwinner,sun8i-h3-r-ccu",
+	       sun8i_h3_r_ccu_setup);
+
+static void __init sun50i_a64_r_ccu_setup(struct device_node *node)
+{
+	sunxi_r_ccu_init(node, &sun50i_a64_r_ccu_desc);
+}
+CLK_OF_DECLARE(sun50i_a64_r_ccu, "allwinner,sun50i-a64-r-ccu",
+	       sun50i_a64_r_ccu_setup);
diff --git a/drivers/clk/sunxi-ng/ccu-sun6i-r.h b/drivers/clk/sunxi-ng/ccu-sun6i-r.h
new file mode 100644
index 000000000000..a7725b419a66
--- /dev/null
+++ b/drivers/clk/sunxi-ng/ccu-sun6i-r.h
@@ -0,0 +1,27 @@
+/*
+ * Copyright 2016 Icenowy <icenowy@aosc.xyz>
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
+#ifndef _CCU_SUN6I_R_H
+#define _CCU_SUN6I_R_H_
+
+#include <dt-bindings/clock/sun6i-r-ccu.h>
+#include <dt-bindings/reset/sun6i-r-ccu.h>
+
+/* AHB/APB bus clocks are not exported */
+#define CLK_R_AHB0	1
+#define CLK_R_APB0	2
+
+#define CLK_NUMBER	(CLK_R_IR + 1)
+
+#endif /* _CCU_SUN6I_R_H */
diff --git a/include/dt-bindings/clock/sun6i-r-ccu.h b/include/dt-bindings/clock/sun6i-r-ccu.h
new file mode 100644
index 000000000000..def6ee8e1980
--- /dev/null
+++ b/include/dt-bindings/clock/sun6i-r-ccu.h
@@ -0,0 +1,58 @@
+/*
+ * Copyright (c) 2016 Icenowy Zheng <icenowy@aosc.xyz>
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of the
+ *     License, or (at your option) any later version.
+ *
+ *     This file is distributed in the hope that it will be useful,
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ * Or, alternatively,
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use,
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+#ifndef _DT_BINDINGS_CLK_SUN6I_R_CCU_H_
+#define _DT_BINDINGS_CLK_SUN6I_R_CCU_H_
+
+#define CLK_CPUS		0
+
+#define CLK_R_BUS_PIO		3
+#define CLK_R_BUS_IR		4
+#define CLK_R_BUS_TIMER		5
+#define CLK_R_BUS_RSB		6
+#define CLK_R_BUS_UART		7
+/* 8 is reserved for CLK_R_BUS_W1 on A31 */
+#define CLK_R_BUS_I2C		9
+
+#define CLK_R_IR		10
+
+#endif /* _DT_BINDINGS_CLK_SUN6I_R_CCU_H_ */
diff --git a/include/dt-bindings/reset/sun6i-r-ccu.h b/include/dt-bindings/reset/sun6i-r-ccu.h
new file mode 100644
index 000000000000..5c708b85ce30
--- /dev/null
+++ b/include/dt-bindings/reset/sun6i-r-ccu.h
@@ -0,0 +1,54 @@
+/*
+ * Copyright (C) 2016 Icenowy Zheng <icenowy@aosc.xyz>
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of the
+ *     License, or (at your option) any later version.
+ *
+ *     This file is distributed in the hope that it will be useful,
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ * Or, alternatively,
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use,
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+#ifndef _DT_BINDINGS_RST_SUN6I_R_CCU_H_
+#define _DT_BINDINGS_RST_SUN6I_R_CCU_H_
+
+#define RST_R_BUS_PIO		0
+#define RST_R_BUS_IR		1
+#define RST_R_BUS_TIMER		2
+#define RST_R_BUS_RSB		3
+#define RST_R_BUS_UART		4
+/* 5 is reserved for RST_R_BUS_W1 on A31 */
+#define RST_R_BUS_I2C		6
+
+#endif /* _DT_BINDINGS_RST_SUN6I_R_CCU_H_ */
-- 
2.11.1
