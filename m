From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 24 Jan 2017 10:32:25 +0800
Subject: [PATCH 06/11] clk: sunxi-ng: Add A80 USB CCU
In-Reply-To: <20170124023230.3990-1-wens@csie.org>
References: <20170124023230.3990-1-wens@csie.org>
Message-ID: <20170124023230.3990-7-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the USB clock controls found on the A80.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 .../devicetree/bindings/clock/sun9i-usb.txt        |  24 ++++
 drivers/clk/sunxi-ng/Makefile                      |   1 +
 drivers/clk/sunxi-ng/ccu-sun9i-a80-usb.c           | 144 +++++++++++++++++++++
 drivers/clk/sunxi-ng/ccu-sun9i-a80-usb.h           |  25 ++++
 include/dt-bindings/clock/sun9i-a80-usb.h          |  59 +++++++++
 include/dt-bindings/reset/sun9i-a80-usb.h          |  56 ++++++++
 6 files changed, 309 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/sun9i-usb.txt
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun9i-a80-usb.c
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun9i-a80-usb.h
 create mode 100644 include/dt-bindings/clock/sun9i-a80-usb.h
 create mode 100644 include/dt-bindings/reset/sun9i-a80-usb.h

diff --git a/Documentation/devicetree/bindings/clock/sun9i-usb.txt b/Documentation/devicetree/bindings/clock/sun9i-usb.txt
new file mode 100644
index 000000000000..c2d38626eaaa
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/sun9i-usb.txt
@@ -0,0 +1,24 @@
+Allwinner A80 USB Clock Control Binding
+------------------------------------
+
+Required properties :
+- compatible: must contain one of the following compatibles:
+		- "allwinner,sun9i-a80-usb-clocks"
+
+- reg: Must contain the registers base address and length
+- clocks: phandle to the clocks feeding the USB subsystem. Two are needed:
+  - "bus": the bus clock for the whole USB subsystem
+  - "hosc": the high frequency oscillator (usually at 24MHz)
+- clock-names: Must contain the clock names described just above
+- #clock-cells : must contain 1
+- #reset-cells : must contain 1
+
+Example:
+usb_clocks: clock at 00a08000 {
+	compatible = "allwinner,sun9i-a80-usb-clks";
+	reg = <0x00a08000 0x8>;
+	clocks = <&ccu CLK_BUS_USB>, <&osc24M>;
+	clock-names = "bus", "hosc";
+	#clock-cells = <1>;
+	#reset-cells = <1>;
+};
diff --git a/drivers/clk/sunxi-ng/Makefile b/drivers/clk/sunxi-ng/Makefile
index 126bb7c1c3f7..8f37ef7fb67d 100644
--- a/drivers/clk/sunxi-ng/Makefile
+++ b/drivers/clk/sunxi-ng/Makefile
@@ -26,3 +26,4 @@ obj-$(CONFIG_SUN8I_A33_CCU)	+= ccu-sun8i-a33.o
 obj-$(CONFIG_SUN8I_H3_CCU)	+= ccu-sun8i-h3.o
 obj-$(CONFIG_SUN8I_V3S_CCU)	+= ccu-sun8i-v3s.o
 obj-$(CONFIG_SUN9I_A80_CCU)	+= ccu-sun9i-a80.o
+obj-$(CONFIG_SUN9I_A80_CCU)	+= ccu-sun9i-a80-usb.o
diff --git a/drivers/clk/sunxi-ng/ccu-sun9i-a80-usb.c b/drivers/clk/sunxi-ng/ccu-sun9i-a80-usb.c
new file mode 100644
index 000000000000..1d76f24f7df3
--- /dev/null
+++ b/drivers/clk/sunxi-ng/ccu-sun9i-a80-usb.c
@@ -0,0 +1,144 @@
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
+
+#include "ccu_common.h"
+#include "ccu_gate.h"
+#include "ccu_reset.h"
+
+#include "ccu-sun9i-a80-usb.h"
+
+static SUNXI_CCU_GATE(bus_hci0_clk, "bus-hci0", "bus-usb", 0x0, BIT(1), 0);
+static SUNXI_CCU_GATE(usb_ohci0_clk, "usb-ohci0", "osc24M", 0x0, BIT(2), 0);
+static SUNXI_CCU_GATE(bus_hci1_clk, "bus-hci1", "bus-usb", 0x0, BIT(3), 0);
+static SUNXI_CCU_GATE(bus_hci2_clk, "bus-hci2", "bus-usb", 0x0, BIT(5), 0);
+static SUNXI_CCU_GATE(usb_ohci2_clk, "usb-ohci2", "osc24M", 0x0, BIT(6), 0);
+
+static SUNXI_CCU_GATE(usb0_phy_clk, "usb0-phy", "osc24M", 0x4, BIT(1), 0);
+static SUNXI_CCU_GATE(usb1_hsic_clk, "usb1-hsic", "osc24M", 0x4, BIT(2), 0);
+static SUNXI_CCU_GATE(usb1_phy_clk, "usb1-phy", "osc24M", 0x4, BIT(3), 0);
+static SUNXI_CCU_GATE(usb2_hsic_clk, "usb2-hsic", "osc24M", 0x4, BIT(4), 0);
+static SUNXI_CCU_GATE(usb2_phy_clk, "usb2-phy", "osc24M", 0x4, BIT(5), 0);
+static SUNXI_CCU_GATE(usb_hsic_clk, "usb-hsic", "osc24M", 0x4, BIT(10), 0);
+
+static struct ccu_common *sun9i_a80_usb_clks[] = {
+	&bus_hci0_clk.common,
+	&usb_ohci0_clk.common,
+	&bus_hci1_clk.common,
+	&bus_hci2_clk.common,
+	&usb_ohci2_clk.common,
+
+	&usb0_phy_clk.common,
+	&usb1_hsic_clk.common,
+	&usb1_phy_clk.common,
+	&usb2_hsic_clk.common,
+	&usb2_phy_clk.common,
+	&usb_hsic_clk.common,
+};
+
+static struct clk_hw_onecell_data sun9i_a80_usb_hw_clks = {
+	.hws	= {
+		[CLK_BUS_HCI0]	= &bus_hci0_clk.common.hw,
+		[CLK_USB_OHCI0]	= &usb_ohci0_clk.common.hw,
+		[CLK_BUS_HCI1]	= &bus_hci1_clk.common.hw,
+		[CLK_BUS_HCI2]	= &bus_hci2_clk.common.hw,
+		[CLK_USB_OHCI2]	= &usb_ohci2_clk.common.hw,
+
+		[CLK_USB0_PHY]	= &usb0_phy_clk.common.hw,
+		[CLK_USB1_HSIC]	= &usb1_hsic_clk.common.hw,
+		[CLK_USB1_PHY]	= &usb1_phy_clk.common.hw,
+		[CLK_USB2_HSIC]	= &usb2_hsic_clk.common.hw,
+		[CLK_USB2_PHY]	= &usb2_phy_clk.common.hw,
+		[CLK_USB_HSIC]	= &usb_hsic_clk.common.hw,
+	},
+	.num	= CLK_NUMBER,
+};
+
+static struct ccu_reset_map sun9i_a80_usb_resets[] = {
+	[RST_USB0_HCI]		= { 0x0, BIT(17) },
+	[RST_USB1_HCI]		= { 0x0, BIT(18) },
+	[RST_USB2_HCI]		= { 0x0, BIT(19) },
+
+	[RST_USB0_PHY]		= { 0x4, BIT(17) },
+	[RST_USB1_HSIC]		= { 0x4, BIT(18) },
+	[RST_USB1_PHY]		= { 0x4, BIT(19) },
+	[RST_USB2_HSIC]		= { 0x4, BIT(20) },
+	[RST_USB2_PHY]		= { 0x4, BIT(21) },
+};
+
+static const struct sunxi_ccu_desc sun9i_a80_usb_clk_desc = {
+	.ccu_clks	= sun9i_a80_usb_clks,
+	.num_ccu_clks	= ARRAY_SIZE(sun9i_a80_usb_clks),
+
+	.hw_clks	= &sun9i_a80_usb_hw_clks,
+
+	.resets		= sun9i_a80_usb_resets,
+	.num_resets	= ARRAY_SIZE(sun9i_a80_usb_resets),
+};
+
+static int sun9i_a80_usb_clk_probe(struct platform_device *pdev)
+{
+	struct resource *res;
+	struct clk *bus_clk;
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
+	/* The bus clock needs to be enabled for us to access the registers */
+	ret = clk_prepare_enable(bus_clk);
+	if (ret) {
+		dev_err(&pdev->dev, "Couldn't enable bus clk: %d\n", ret);
+		return ret;
+	}
+
+	ret = sunxi_ccu_probe(pdev->dev.of_node, reg,
+			      &sun9i_a80_usb_clk_desc);
+	if (ret)
+		goto err_disable_clk;
+
+	return 0;
+
+err_disable_clk:
+	clk_disable_unprepare(bus_clk);
+	return ret;
+}
+
+static const struct of_device_id sun9i_a80_usb_clk_ids[] = {
+	{ .compatible = "allwinner,sun9i-a80-usb-clks" },
+	{ }
+};
+
+static struct platform_driver sun9i_a80_usb_clk_driver = {
+	.probe	= sun9i_a80_usb_clk_probe,
+	.driver	= {
+		.name	= "sun9i-a80-usb-clks",
+		.of_match_table	= sun9i_a80_usb_clk_ids,
+	},
+};
+builtin_platform_driver(sun9i_a80_usb_clk_driver);
diff --git a/drivers/clk/sunxi-ng/ccu-sun9i-a80-usb.h b/drivers/clk/sunxi-ng/ccu-sun9i-a80-usb.h
new file mode 100644
index 000000000000..a184280ba854
--- /dev/null
+++ b/drivers/clk/sunxi-ng/ccu-sun9i-a80-usb.h
@@ -0,0 +1,25 @@
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
+#ifndef _CCU_SUN9I_A80_USB_H_
+#define _CCU_SUN9I_A80_USB_H_
+
+#include <dt-bindings/clock/sun9i-a80-usb.h>
+#include <dt-bindings/reset/sun9i-a80-usb.h>
+
+#define CLK_NUMBER	(CLK_USB_HSIC + 1)
+
+#endif /* _CCU_SUN9I_A80_USB_H_ */
diff --git a/include/dt-bindings/clock/sun9i-a80-usb.h b/include/dt-bindings/clock/sun9i-a80-usb.h
new file mode 100644
index 000000000000..783a60d2ccea
--- /dev/null
+++ b/include/dt-bindings/clock/sun9i-a80-usb.h
@@ -0,0 +1,59 @@
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
+#ifndef _DT_BINDINGS_CLOCK_SUN9I_A80_USB_H_
+#define _DT_BINDINGS_CLOCK_SUN9I_A80_USB_H_
+
+#define CLK_BUS_HCI0	0
+#define CLK_USB_OHCI0	1
+#define CLK_BUS_HCI1	2
+#define CLK_BUS_HCI2	3
+#define CLK_USB_OHCI2	4
+
+#define CLK_USB0_PHY	5
+#define CLK_USB1_HSIC	6
+#define CLK_USB1_PHY	7
+#define CLK_USB2_HSIC	8
+#define CLK_USB2_PHY	9
+#define CLK_USB_HSIC	10
+
+#endif /* _DT_BINDINGS_CLOCK_SUN9I_A80_USB_H_ */
diff --git a/include/dt-bindings/reset/sun9i-a80-usb.h b/include/dt-bindings/reset/sun9i-a80-usb.h
new file mode 100644
index 000000000000..ee492864c2aa
--- /dev/null
+++ b/include/dt-bindings/reset/sun9i-a80-usb.h
@@ -0,0 +1,56 @@
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
+#ifndef _DT_BINDINGS_RESET_SUN9I_A80_USB_H_
+#define _DT_BINDINGS_RESET_SUN9I_A80_USB_H_
+
+#define RST_USB0_HCI	0
+#define RST_USB1_HCI	1
+#define RST_USB2_HCI	2
+
+#define RST_USB0_PHY	3
+#define RST_USB1_HSIC	4
+#define RST_USB1_PHY	5
+#define RST_USB2_HSIC	6
+#define RST_USB2_PHY	7
+
+#endif /* _DT_BINDINGS_RESET_SUN9I_A80_USB_H_ */
-- 
2.11.0
