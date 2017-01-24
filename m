From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 24 Jan 2017 10:32:26 +0800
Subject: [PATCH 07/11] clk: sunxi-ng: Add A80 Display Engine CCU
In-Reply-To: <20170124023230.3990-1-wens@csie.org>
References: <20170124023230.3990-1-wens@csie.org>
Message-ID: <20170124023230.3990-8-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the display engine clock controls found on the A80.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 .../devicetree/bindings/clock/sun9i-de.txt         |  28 ++
 drivers/clk/sunxi-ng/Makefile                      |   1 +
 drivers/clk/sunxi-ng/ccu-sun9i-a80-de.c            | 283 +++++++++++++++++++++
 drivers/clk/sunxi-ng/ccu-sun9i-a80-de.h            |  33 +++
 include/dt-bindings/clock/sun9i-a80-de.h           |  80 ++++++
 include/dt-bindings/reset/sun9i-a80-de.h           |  58 +++++
 6 files changed, 483 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/sun9i-de.txt
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun9i-a80-de.c
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun9i-a80-de.h
 create mode 100644 include/dt-bindings/clock/sun9i-a80-de.h
 create mode 100644 include/dt-bindings/reset/sun9i-a80-de.h

diff --git a/Documentation/devicetree/bindings/clock/sun9i-de.txt b/Documentation/devicetree/bindings/clock/sun9i-de.txt
new file mode 100644
index 000000000000..3a5e6df70677
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/sun9i-de.txt
@@ -0,0 +1,28 @@
+Allwinner A80 Display Engine Clock Control Binding
+------------------------------------
+
+Required properties :
+- compatible: must contain one of the following compatibles:
+		- "allwinner,sun9i-a80-de-clocks"
+
+- reg: Must contain the registers base address and length
+- clocks: phandle to the clocks feeding the display engine subsystem.
+	  Three are needed:
+  - "mod": the display engine module clock
+  - "dram": the DRAM bus clock for the system
+  - "bus": the bus clock for the whole display engine subsystem
+- clock-names: Must contain the clock names described just above
+- resets: phandle to the reset control for the display engine subsystem.
+- #clock-cells : must contain 1
+- #reset-cells : must contain 1
+
+Example:
+de_clocks: clock at 03000000 {
+	compatible = "allwinner,sun9i-a80-de-clks";
+	reg = <0x03000000 0x30>;
+	clocks = <&ccu CLK_DE>, <&ccu CLK_SDRAM>, <&ccu CLK_BUS_DE>;
+	clock-names = "mod", "dram", "bus";
+	resets = <&ccu RST_BUS_DE>;
+	#clock-cells = <1>;
+	#reset-cells = <1>;
+};
diff --git a/drivers/clk/sunxi-ng/Makefile b/drivers/clk/sunxi-ng/Makefile
index 8f37ef7fb67d..6feaac0c5600 100644
--- a/drivers/clk/sunxi-ng/Makefile
+++ b/drivers/clk/sunxi-ng/Makefile
@@ -26,4 +26,5 @@ obj-$(CONFIG_SUN8I_A33_CCU)	+= ccu-sun8i-a33.o
 obj-$(CONFIG_SUN8I_H3_CCU)	+= ccu-sun8i-h3.o
 obj-$(CONFIG_SUN8I_V3S_CCU)	+= ccu-sun8i-v3s.o
 obj-$(CONFIG_SUN9I_A80_CCU)	+= ccu-sun9i-a80.o
+obj-$(CONFIG_SUN9I_A80_CCU)	+= ccu-sun9i-a80-de.o
 obj-$(CONFIG_SUN9I_A80_CCU)	+= ccu-sun9i-a80-usb.o
diff --git a/drivers/clk/sunxi-ng/ccu-sun9i-a80-de.c b/drivers/clk/sunxi-ng/ccu-sun9i-a80-de.c
new file mode 100644
index 000000000000..3fc27db0a49a
--- /dev/null
+++ b/drivers/clk/sunxi-ng/ccu-sun9i-a80-de.c
@@ -0,0 +1,283 @@
+/*
+ * Copyright (c) 2016 Chen-Yu Tsai. All rights reserved.
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
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/reset.h>
+
+#include "ccu_common.h"
+#include "ccu_div.h"
+#include "ccu_gate.h"
+#include "ccu_reset.h"
+
+#include "ccu-sun9i-a80-de.h"
+
+static SUNXI_CCU_GATE(fe0_clk,		"fe0",		"fe0-div",
+		      0x00, BIT(0), 0);
+static SUNXI_CCU_GATE(fe1_clk,		"fe1",		"fe1-div",
+		      0x00, BIT(1), 0);
+static SUNXI_CCU_GATE(fe2_clk,		"fe2",		"fe2-div",
+		      0x00, BIT(2), 0);
+static SUNXI_CCU_GATE(iep_deu0_clk,	"iep-deu0",	"de",
+		      0x00, BIT(4), 0);
+static SUNXI_CCU_GATE(iep_deu1_clk,	"iep-deu1",	"de",
+		      0x00, BIT(5), 0);
+static SUNXI_CCU_GATE(be0_clk,		"be0",		"be0-div",
+		      0x00, BIT(8), 0);
+static SUNXI_CCU_GATE(be1_clk,		"be1",		"be1-div",
+		      0x00, BIT(9), 0);
+static SUNXI_CCU_GATE(be2_clk,		"be2",		"be2-div",
+		      0x00, BIT(10), 0);
+static SUNXI_CCU_GATE(iep_drc0_clk,	"iep-drc0",	"de",
+		      0x00, BIT(12), 0);
+static SUNXI_CCU_GATE(iep_drc1_clk,	"iep-drc1",	"de",
+		      0x00, BIT(13), 0);
+static SUNXI_CCU_GATE(merge_clk,	"merge",	"de",
+		      0x00, BIT(20), 0);
+
+static SUNXI_CCU_GATE(dram_fe0_clk,	"dram-fe0",	"sdram",
+		      0x04, BIT(0), 0);
+static SUNXI_CCU_GATE(dram_fe1_clk,	"dram-fe1",	"sdram",
+		      0x04, BIT(1), 0);
+static SUNXI_CCU_GATE(dram_fe2_clk,	"dram-fe2",	"sdram",
+		      0x04, BIT(2), 0);
+static SUNXI_CCU_GATE(dram_deu0_clk,	"dram-deu0",	"sdram",
+		      0x04, BIT(4), 0);
+static SUNXI_CCU_GATE(dram_deu1_clk,	"dram-deu1",	"sdram",
+		      0x04, BIT(5), 0);
+static SUNXI_CCU_GATE(dram_be0_clk,	"dram-be0",	"sdram",
+		      0x04, BIT(8), 0);
+static SUNXI_CCU_GATE(dram_be1_clk,	"dram-be1",	"sdram",
+		      0x04, BIT(9), 0);
+static SUNXI_CCU_GATE(dram_be2_clk,	"dram-be2",	"sdram",
+		      0x04, BIT(10), 0);
+static SUNXI_CCU_GATE(dram_drc0_clk,	"dram-drc0",	"sdram",
+		      0x04, BIT(12), 0);
+static SUNXI_CCU_GATE(dram_drc1_clk,	"dram-drc1",	"sdram",
+		      0x04, BIT(13), 0);
+
+static SUNXI_CCU_GATE(bus_fe0_clk,	"bus-fe0",	"bus-de",
+		      0x08, BIT(0), 0);
+static SUNXI_CCU_GATE(bus_fe1_clk,	"bus-fe1",	"bus-de",
+		      0x08, BIT(1), 0);
+static SUNXI_CCU_GATE(bus_fe2_clk,	"bus-fe2",	"bus-de",
+		      0x08, BIT(2), 0);
+static SUNXI_CCU_GATE(bus_deu0_clk,	"bus-deu0",	"bus-de",
+		      0x08, BIT(4), 0);
+static SUNXI_CCU_GATE(bus_deu1_clk,	"bus-deu1",	"bus-de",
+		      0x08, BIT(5), 0);
+static SUNXI_CCU_GATE(bus_be0_clk,	"bus-be0",	"bus-de",
+		      0x08, BIT(8), 0);
+static SUNXI_CCU_GATE(bus_be1_clk,	"bus-be1",	"bus-de",
+		      0x08, BIT(9), 0);
+static SUNXI_CCU_GATE(bus_be2_clk,	"bus-be2",	"bus-de",
+		      0x08, BIT(10), 0);
+static SUNXI_CCU_GATE(bus_drc0_clk,	"bus-drc0",	"bus-de",
+		      0x08, BIT(12), 0);
+static SUNXI_CCU_GATE(bus_drc1_clk,	"bus-drc1",	"bus-de",
+		      0x08, BIT(13), 0);
+
+static SUNXI_CCU_M(fe0_div_clk, "fe0-div", "de", 0x20, 0, 4, 0);
+static SUNXI_CCU_M(fe1_div_clk, "fe1-div", "de", 0x20, 4, 4, 0);
+static SUNXI_CCU_M(fe2_div_clk, "fe2-div", "de", 0x20, 8, 4, 0);
+static SUNXI_CCU_M(be0_div_clk, "be0-div", "de", 0x20, 16, 4, 0);
+static SUNXI_CCU_M(be1_div_clk, "be1-div", "de", 0x20, 20, 4, 0);
+static SUNXI_CCU_M(be2_div_clk, "be2-div", "de", 0x20, 24, 4, 0);
+
+static struct ccu_common *sun9i_a80_de_clks[] = {
+	&fe0_clk.common,
+	&fe1_clk.common,
+	&fe2_clk.common,
+	&iep_deu0_clk.common,
+	&iep_deu1_clk.common,
+	&be0_clk.common,
+	&be1_clk.common,
+	&be2_clk.common,
+	&iep_drc0_clk.common,
+	&iep_drc1_clk.common,
+	&merge_clk.common,
+
+	&dram_fe0_clk.common,
+	&dram_fe1_clk.common,
+	&dram_fe2_clk.common,
+	&dram_deu0_clk.common,
+	&dram_deu1_clk.common,
+	&dram_be0_clk.common,
+	&dram_be1_clk.common,
+	&dram_be2_clk.common,
+	&dram_drc0_clk.common,
+	&dram_drc1_clk.common,
+
+	&bus_fe0_clk.common,
+	&bus_fe1_clk.common,
+	&bus_fe2_clk.common,
+	&bus_deu0_clk.common,
+	&bus_deu1_clk.common,
+	&bus_be0_clk.common,
+	&bus_be1_clk.common,
+	&bus_be2_clk.common,
+	&bus_drc0_clk.common,
+	&bus_drc1_clk.common,
+
+	&fe0_div_clk.common,
+	&fe1_div_clk.common,
+	&fe2_div_clk.common,
+	&be0_div_clk.common,
+	&be1_div_clk.common,
+	&be2_div_clk.common,
+};
+
+static struct clk_hw_onecell_data sun9i_a80_de_hw_clks = {
+	.hws	= {
+		[CLK_FE0]	= &fe0_clk.common.hw,
+		[CLK_FE1]	= &fe1_clk.common.hw,
+		[CLK_FE2]	= &fe2_clk.common.hw,
+		[CLK_IEP_DEU0]	= &iep_deu0_clk.common.hw,
+		[CLK_IEP_DEU1]	= &iep_deu1_clk.common.hw,
+		[CLK_BE0]	= &be0_clk.common.hw,
+		[CLK_BE1]	= &be1_clk.common.hw,
+		[CLK_BE2]	= &be2_clk.common.hw,
+		[CLK_IEP_DRC0]	= &iep_drc0_clk.common.hw,
+		[CLK_IEP_DRC1]	= &iep_drc1_clk.common.hw,
+		[CLK_MERGE]	= &merge_clk.common.hw,
+
+		[CLK_DRAM_FE0]	= &dram_fe0_clk.common.hw,
+		[CLK_DRAM_FE1]	= &dram_fe1_clk.common.hw,
+		[CLK_DRAM_FE2]	= &dram_fe2_clk.common.hw,
+		[CLK_DRAM_DEU0]	= &dram_deu0_clk.common.hw,
+		[CLK_DRAM_DEU1]	= &dram_deu1_clk.common.hw,
+		[CLK_DRAM_BE0]	= &dram_be0_clk.common.hw,
+		[CLK_DRAM_BE1]	= &dram_be1_clk.common.hw,
+		[CLK_DRAM_BE2]	= &dram_be2_clk.common.hw,
+		[CLK_DRAM_DRC0]	= &dram_drc0_clk.common.hw,
+		[CLK_DRAM_DRC1]	= &dram_drc1_clk.common.hw,
+
+		[CLK_BUS_FE0]	= &bus_fe0_clk.common.hw,
+		[CLK_BUS_FE1]	= &bus_fe1_clk.common.hw,
+		[CLK_BUS_FE2]	= &bus_fe2_clk.common.hw,
+		[CLK_BUS_DEU0]	= &bus_deu0_clk.common.hw,
+		[CLK_BUS_DEU1]	= &bus_deu1_clk.common.hw,
+		[CLK_BUS_BE0]	= &bus_be0_clk.common.hw,
+		[CLK_BUS_BE1]	= &bus_be1_clk.common.hw,
+		[CLK_BUS_BE2]	= &bus_be2_clk.common.hw,
+		[CLK_BUS_DRC0]	= &bus_drc0_clk.common.hw,
+		[CLK_BUS_DRC1]	= &bus_drc1_clk.common.hw,
+
+		[CLK_FE0_DIV]	= &fe0_div_clk.common.hw,
+		[CLK_FE1_DIV]	= &fe1_div_clk.common.hw,
+		[CLK_FE2_DIV]	= &fe2_div_clk.common.hw,
+		[CLK_BE0_DIV]	= &be0_div_clk.common.hw,
+		[CLK_BE1_DIV]	= &be1_div_clk.common.hw,
+		[CLK_BE2_DIV]	= &be2_div_clk.common.hw,
+	},
+	.num	= CLK_NUMBER,
+};
+
+static struct ccu_reset_map sun9i_a80_de_resets[] = {
+	[RST_FE0]	= { 0x0c, BIT(0) },
+	[RST_FE1]	= { 0x0c, BIT(1) },
+	[RST_FE2]	= { 0x0c, BIT(2) },
+	[RST_DEU0]	= { 0x0c, BIT(4) },
+	[RST_DEU1]	= { 0x0c, BIT(5) },
+	[RST_BE0]	= { 0x0c, BIT(8) },
+	[RST_BE1]	= { 0x0c, BIT(9) },
+	[RST_BE2]	= { 0x0c, BIT(10) },
+	[RST_DRC0]	= { 0x0c, BIT(12) },
+	[RST_DRC1]	= { 0x0c, BIT(13) },
+	[RST_MERGE]	= { 0x0c, BIT(20) },
+};
+
+static const struct sunxi_ccu_desc sun9i_a80_de_clk_desc = {
+	.ccu_clks	= sun9i_a80_de_clks,
+	.num_ccu_clks	= ARRAY_SIZE(sun9i_a80_de_clks),
+
+	.hw_clks	= &sun9i_a80_de_hw_clks,
+
+	.resets		= sun9i_a80_de_resets,
+	.num_resets	= ARRAY_SIZE(sun9i_a80_de_resets),
+};
+
+static int sun9i_a80_de_clk_probe(struct platform_device *pdev)
+{
+	struct resource *res;
+	struct clk *bus_clk;
+	struct reset_control *rstc;
+	void __iomem *reg;
+	int ret;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	reg = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(reg))
+		return PTR_ERR(reg);
+
+	bus_clk = devm_clk_get(&pdev->dev, "bus");
+	if (IS_ERR(bus_clk)) {
+		ret = PTR_ERR(bus_clk);
+		if (ret != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "Couldn't get bus clk: %d\n", ret);
+		return ret;
+	}
+
+	rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
+	if (IS_ERR(rstc)) {
+		ret = PTR_ERR(bus_clk);
+		if (ret != -EPROBE_DEFER)
+			dev_err(&pdev->dev,
+				"Couldn't get reset control: %d\n", ret);
+		return ret;
+	}
+
+	/* The bus clock needs to be enabled for us to access the registers */
+	ret = clk_prepare_enable(bus_clk);
+	if (ret) {
+		dev_err(&pdev->dev, "Couldn't enable bus clk: %d\n", ret);
+		return ret;
+	}
+
+	/* The reset control needs to be asserted for the controls to work */
+	ret = reset_control_deassert(rstc);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"Couldn't deassert reset control: %d\n", ret);
+		goto err_disable_clk;
+	}
+
+	ret = sunxi_ccu_probe(pdev->dev.of_node, reg,
+			      &sun9i_a80_de_clk_desc);
+	if (ret)
+		goto err_assert_reset;
+
+	return 0;
+
+err_assert_reset:
+	reset_control_assert(rstc);
+err_disable_clk:
+	clk_disable_unprepare(bus_clk);
+	return ret;
+}
+
+static const struct of_device_id sun9i_a80_de_clk_ids[] = {
+	{ .compatible = "allwinner,sun9i-a80-de-clks" },
+	{ }
+};
+
+static struct platform_driver sun9i_a80_de_clk_driver = {
+	.probe	= sun9i_a80_de_clk_probe,
+	.driver	= {
+		.name	= "sun9i-a80-de-clks",
+		.of_match_table	= sun9i_a80_de_clk_ids,
+	},
+};
+builtin_platform_driver(sun9i_a80_de_clk_driver);
diff --git a/drivers/clk/sunxi-ng/ccu-sun9i-a80-de.h b/drivers/clk/sunxi-ng/ccu-sun9i-a80-de.h
new file mode 100644
index 000000000000..a4769041e40f
--- /dev/null
+++ b/drivers/clk/sunxi-ng/ccu-sun9i-a80-de.h
@@ -0,0 +1,33 @@
+/*
+ * Copyright 2016 Chen-Yu Tsai
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
+#ifndef _CCU_SUN9I_A80_DE_H_
+#define _CCU_SUN9I_A80_DE_H_
+
+#include <dt-bindings/clock/sun9i-a80-de.h>
+#include <dt-bindings/reset/sun9i-a80-de.h>
+
+/* Intermediary clock dividers are not exported */
+#define CLK_FE0_DIV	31
+#define CLK_FE1_DIV	32
+#define CLK_FE2_DIV	33
+#define CLK_BE0_DIV	34
+#define CLK_BE1_DIV	35
+#define CLK_BE2_DIV	36
+
+#define CLK_NUMBER	(CLK_BE2_DIV + 1)
+
+#endif /* _CCU_SUN9I_A80_DE_H_ */
diff --git a/include/dt-bindings/clock/sun9i-a80-de.h b/include/dt-bindings/clock/sun9i-a80-de.h
new file mode 100644
index 000000000000..3dad6c3cd131
--- /dev/null
+++ b/include/dt-bindings/clock/sun9i-a80-de.h
@@ -0,0 +1,80 @@
+/*
+ * Copyright (C) 2016 Chen-Yu Tsai <wens@csie.org>
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
+#ifndef _DT_BINDINGS_CLOCK_SUN9I_A80_DE_H_
+#define _DT_BINDINGS_CLOCK_SUN9I_A80_DE_H_
+
+#define CLK_FE0			0
+#define CLK_FE1			1
+#define CLK_FE2			2
+#define CLK_IEP_DEU0		3
+#define CLK_IEP_DEU1		4
+#define CLK_BE0			5
+#define CLK_BE1			6
+#define CLK_BE2			7
+#define CLK_IEP_DRC0		8
+#define CLK_IEP_DRC1		9
+#define CLK_MERGE		10
+
+#define CLK_DRAM_FE0		11
+#define CLK_DRAM_FE1		12
+#define CLK_DRAM_FE2		13
+#define CLK_DRAM_DEU0		14
+#define CLK_DRAM_DEU1		15
+#define CLK_DRAM_BE0		16
+#define CLK_DRAM_BE1		17
+#define CLK_DRAM_BE2		18
+#define CLK_DRAM_DRC0		19
+#define CLK_DRAM_DRC1		20
+
+#define CLK_BUS_FE0		21
+#define CLK_BUS_FE1		22
+#define CLK_BUS_FE2		23
+#define CLK_BUS_DEU0		24
+#define CLK_BUS_DEU1		25
+#define CLK_BUS_BE0		26
+#define CLK_BUS_BE1		27
+#define CLK_BUS_BE2		28
+#define CLK_BUS_DRC0		29
+#define CLK_BUS_DRC1		30
+
+#endif /* _DT_BINDINGS_CLOCK_SUN9I_A80_DE_H_ */
diff --git a/include/dt-bindings/reset/sun9i-a80-de.h b/include/dt-bindings/reset/sun9i-a80-de.h
new file mode 100644
index 000000000000..205072770171
--- /dev/null
+++ b/include/dt-bindings/reset/sun9i-a80-de.h
@@ -0,0 +1,58 @@
+/*
+ * Copyright (C) 2016 Chen-Yu Tsai <wens@csie.org>
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
+#ifndef _DT_BINDINGS_RESET_SUN9I_A80_DE_H_
+#define _DT_BINDINGS_RESET_SUN9I_A80_DE_H_
+
+#define RST_FE0		0
+#define RST_FE1		1
+#define RST_FE2		2
+#define RST_DEU0	3
+#define RST_DEU1	4
+#define RST_BE0		5
+#define RST_BE1		6
+#define RST_BE2		7
+#define RST_DRC0	8
+#define RST_DRC1	9
+#define RST_MERGE	10
+
+#endif /* _DT_BINDINGS_RESET_SUN9I_A80_DE_H_ */
-- 
2.11.0
