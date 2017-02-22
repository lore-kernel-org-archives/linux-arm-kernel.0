From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Wed, 22 Feb 2017 23:18:48 +0800
Subject: [PATCH 2/8] clk: sunxi-ng: add support for DE2 CCU
In-Reply-To: <20170222151854.3280-1-icenowy@aosc.xyz>
References: <20170222151854.3280-1-icenowy@aosc.xyz>
Message-ID: <20170222151854.3280-3-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The "Display Engine 2.0" in Allwinner newer SoCs contains a clock
management unit for its subunits, like the DE CCU in A80.

Add a sunxi-ng style driver for it.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
 drivers/clk/sunxi-ng/Kconfig          |   6 +
 drivers/clk/sunxi-ng/Makefile         |   1 +
 drivers/clk/sunxi-ng/ccu-sunxi-de2.c  | 204 ++++++++++++++++++++++++++++++++++
 drivers/clk/sunxi-ng/ccu-sunxi-de2.h  |  28 +++++
 include/dt-bindings/clock/sunxi-de2.h |  54 +++++++++
 include/dt-bindings/reset/sunxi-de2.h |  50 +++++++++
 6 files changed, 343 insertions(+)
 create mode 100644 drivers/clk/sunxi-ng/ccu-sunxi-de2.c
 create mode 100644 drivers/clk/sunxi-ng/ccu-sunxi-de2.h
 create mode 100644 include/dt-bindings/clock/sunxi-de2.h
 create mode 100644 include/dt-bindings/reset/sunxi-de2.h

diff --git a/drivers/clk/sunxi-ng/Kconfig b/drivers/clk/sunxi-ng/Kconfig
index 695bbf9ef428..52b88b22ec67 100644
--- a/drivers/clk/sunxi-ng/Kconfig
+++ b/drivers/clk/sunxi-ng/Kconfig
@@ -141,4 +141,10 @@ config SUN9I_A80_CCU
 	select SUNXI_CCU_PHASE
 	default MACH_SUN9I
 
+config SUNXI_DE2_CCU
+	bool "Support for the Allwinner SoCs DE2 CCU"
+	select SUNXI_CCU_DIV
+	select SUNXI_CCU_GATE
+	default n
+
 endif
diff --git a/drivers/clk/sunxi-ng/Makefile b/drivers/clk/sunxi-ng/Makefile
index 6feaac0c5600..1d36c40384a6 100644
--- a/drivers/clk/sunxi-ng/Makefile
+++ b/drivers/clk/sunxi-ng/Makefile
@@ -28,3 +28,4 @@ obj-$(CONFIG_SUN8I_V3S_CCU)	+= ccu-sun8i-v3s.o
 obj-$(CONFIG_SUN9I_A80_CCU)	+= ccu-sun9i-a80.o
 obj-$(CONFIG_SUN9I_A80_CCU)	+= ccu-sun9i-a80-de.o
 obj-$(CONFIG_SUN9I_A80_CCU)	+= ccu-sun9i-a80-usb.o
+obj-$(CONFIG_SUNXI_DE2_CCU)	+= ccu-sunxi-de2.o
diff --git a/drivers/clk/sunxi-ng/ccu-sunxi-de2.c b/drivers/clk/sunxi-ng/ccu-sunxi-de2.c
new file mode 100644
index 000000000000..4259c145d5da
--- /dev/null
+++ b/drivers/clk/sunxi-ng/ccu-sunxi-de2.c
@@ -0,0 +1,204 @@
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
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/reset.h>
+
+#include "ccu_common.h"
+#include "ccu_div.h"
+#include "ccu_gate.h"
+#include "ccu_reset.h"
+
+#include "ccu-sunxi-de2.h"
+
+static SUNXI_CCU_GATE(bus_mixer0_clk,	"bus-mixer0",	"bus-de",
+		      0x04, BIT(0), 0);
+static SUNXI_CCU_GATE(bus_mixer1_clk,	"bus-mixer1",	"bus-de",
+		      0x04, BIT(1), 0);
+static SUNXI_CCU_GATE(bus_wb_clk,	"bus-wb",	"bus-de",
+		      0x04, BIT(2), 0);
+
+static SUNXI_CCU_GATE(mixer0_clk,	"mixer0",	"mixer0-div",
+		      0x00, BIT(0), CLK_SET_RATE_PARENT);
+static SUNXI_CCU_GATE(mixer1_clk,	"mixer1",	"mixer1-div",
+		      0x00, BIT(1), CLK_SET_RATE_PARENT);
+static SUNXI_CCU_GATE(wb_clk,		"wb",		"wb-div",
+		      0x00, BIT(2), CLK_SET_RATE_PARENT);
+
+static SUNXI_CCU_M(mixer0_div_clk, "mixer0-div", "de", 0x0c, 0, 4,
+		   CLK_SET_RATE_PARENT);
+static SUNXI_CCU_M(mixer1_div_clk, "mixer1-div", "de", 0x0c, 4, 4,
+		   CLK_SET_RATE_PARENT);
+static SUNXI_CCU_M(wb_div_clk, "wb-div", "de", 0x0c, 8, 4,
+		   CLK_SET_RATE_PARENT);
+
+static struct ccu_common *sunxi_de2_clks[] = {
+	&mixer0_clk.common,
+	&mixer1_clk.common,
+	&wb_clk.common,
+
+	&bus_mixer0_clk.common,
+	&bus_mixer1_clk.common,
+	&bus_wb_clk.common,
+
+	&mixer0_div_clk.common,
+	&mixer1_div_clk.common,
+	&wb_div_clk.common,
+};
+
+static struct clk_hw_onecell_data sunxi_de2_hw_clks = {
+	.hws	= {
+		[CLK_MIXER0]		= &mixer0_clk.common.hw,
+		[CLK_MIXER1]		= &mixer1_clk.common.hw,
+		[CLK_WB]		= &wb_clk.common.hw,
+
+		[CLK_BUS_MIXER0]	= &bus_mixer0_clk.common.hw,
+		[CLK_BUS_MIXER1]	= &bus_mixer1_clk.common.hw,
+		[CLK_BUS_WB]		= &bus_wb_clk.common.hw,
+
+		[CLK_MIXER0_DIV]	= &mixer1_div_clk.common.hw,
+		[CLK_MIXER1_DIV]	= &mixer0_div_clk.common.hw,
+		[CLK_WB_DIV]		= &wb_div_clk.common.hw,
+	},
+	.num	= CLK_NUMBER,
+};
+
+static struct ccu_reset_map sun8i_a83t_de2_resets[] = {
+	[RST_MIXER0]	= { 0x08, BIT(0) },
+	/*
+	 * For A83T, H3 and R40, mixer1 reset line is shared with wb, so
+	 * only RST_WB is exported here.
+	 */
+	[RST_WB]	= { 0x08, BIT(2) },
+};
+
+static struct ccu_reset_map sun50i_a64_de2_resets[] = {
+	[RST_MIXER0]	= { 0x08, BIT(0) },
+	[RST_MIXER1]	= { 0x08, BIT(1) },
+	[RST_WB]	= { 0x08, BIT(2) },
+};
+
+static const struct sunxi_ccu_desc sun8i_a83t_de2_clk_desc = {
+	.ccu_clks	= sunxi_de2_clks,
+	.num_ccu_clks	= ARRAY_SIZE(sunxi_de2_clks),
+
+	.hw_clks	= &sunxi_de2_hw_clks,
+
+	.resets		= sun8i_a83t_de2_resets,
+	.num_resets	= ARRAY_SIZE(sun8i_a83t_de2_resets),
+};
+
+static const struct sunxi_ccu_desc sun50i_a64_de2_clk_desc = {
+	.ccu_clks	= sunxi_de2_clks,
+	.num_ccu_clks	= ARRAY_SIZE(sunxi_de2_clks),
+
+	.hw_clks	= &sunxi_de2_hw_clks,
+
+	.resets		= sun50i_a64_de2_resets,
+	.num_resets	= ARRAY_SIZE(sun50i_a64_de2_resets),
+};
+
+static int sunxi_de2_clk_probe(struct platform_device *pdev)
+{
+	struct resource *res;
+	struct clk *bus_clk;
+	struct reset_control *rstc;
+	void __iomem *reg;
+	const struct sunxi_ccu_desc *ccu_desc;
+	int ret;
+
+	ccu_desc = of_device_get_match_data(&pdev->dev);
+	if (!ccu_desc)
+		return -EINVAL;
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
+	ret = sunxi_ccu_probe(pdev->dev.of_node, reg, ccu_desc);
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
+static const struct of_device_id sunxi_de2_clk_ids[] = {
+	{
+		.compatible = "allwinner,sun8i-a83t-de2-clk",
+		.data = &sun8i_a83t_de2_clk_desc,
+	},
+	{
+		.compatible = "allwinner,sun50i-h5-de2-clk",
+		.data = &sun50i_a64_de2_clk_desc,
+	},
+	/*
+	 * The Allwinner A64 SoC needs some bit to be poke in syscon to make
+	 * DE2 really working.
+	 * So there's currently no A64 compatible here.
+	 * H5 shares the same reset line with A64, so here H5 is using the
+	 * clock description of A64.
+	 */
+	{ }
+};
+
+static struct platform_driver sunxi_de2_clk_driver = {
+	.probe	= sunxi_de2_clk_probe,
+	.driver	= {
+		.name	= "sunxi-de2-clks",
+		.of_match_table	= sunxi_de2_clk_ids,
+	},
+};
+builtin_platform_driver(sunxi_de2_clk_driver);
diff --git a/drivers/clk/sunxi-ng/ccu-sunxi-de2.h b/drivers/clk/sunxi-ng/ccu-sunxi-de2.h
new file mode 100644
index 000000000000..a7b19daa964a
--- /dev/null
+++ b/drivers/clk/sunxi-ng/ccu-sunxi-de2.h
@@ -0,0 +1,28 @@
+/*
+ * Copyright 2016 Icenowy Zheng <icenowy@aosc.xyz>
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
+#ifndef _CCU_SUNXI_DE2_H_
+#define _CCU_SUNXI_DE2_H_
+
+#include <dt-bindings/clock/sunxi-de2.h>
+#include <dt-bindings/reset/sunxi-de2.h>
+
+/* Intermediary clock dividers are not exported */
+#define CLK_MIXER0_DIV	3
+#define CLK_MIXER1_DIV	4
+#define CLK_WB_DIV	5
+
+#define CLK_NUMBER	(CLK_WB + 1)
+
+#endif /* _CCU_SUNXI_DE2_H_ */
diff --git a/include/dt-bindings/clock/sunxi-de2.h b/include/dt-bindings/clock/sunxi-de2.h
new file mode 100644
index 000000000000..a817bdbda5ef
--- /dev/null
+++ b/include/dt-bindings/clock/sunxi-de2.h
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
+#ifndef _DT_BINDINGS_CLOCK_SUNXI_DE2_H_
+#define _DT_BINDINGS_CLOCK_SUNXI_DE2_H_
+
+#define CLK_BUS_MIXER0		0
+#define CLK_BUS_MIXER1		1
+#define CLK_BUS_WB		2
+
+#define CLK_MIXER0		6
+#define CLK_MIXER1		7
+#define CLK_WB			8
+
+#endif /* _DT_BINDINGS_CLOCK_SUNXI_DE2_H_ */
diff --git a/include/dt-bindings/reset/sunxi-de2.h b/include/dt-bindings/reset/sunxi-de2.h
new file mode 100644
index 000000000000..a13113044d70
--- /dev/null
+++ b/include/dt-bindings/reset/sunxi-de2.h
@@ -0,0 +1,50 @@
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
+#ifndef _DT_BINDINGS_RESET_SUNXI_DE2_H_
+#define _DT_BINDINGS_RESET_SUNXI_DE2_H_
+
+#define RST_MIXER0	0
+#define RST_MIXER1	1
+#define RST_WB		2
+
+#endif /* _DT_BINDINGS_RESET_SUNXI_DE2_H_ */
-- 
2.11.1
