From: zhangfei.gao@linaro.org (Zhangfei Gao)
Date: Tue, 22 Apr 2014 19:46:54 +0800
Subject: [PATCH 3/3] clk: hisi: add clk-hix5hd2.c
In-Reply-To: <1398167214-1604-1-git-send-email-zhangfei.gao@linaro.org>
References: <1398167214-1604-1-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <1398167214-1604-4-git-send-email-zhangfei.gao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Haifeng Yan <haifeng.yan@linaro.org>
Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 .../devicetree/bindings/clock/hix5hd2-clock.txt    |   31 ++++++
 drivers/clk/Makefile                               |    1 +
 drivers/clk/hisilicon/Makefile                     |    1 +
 drivers/clk/hisilicon/clk-hix5hd2.c                |  101 ++++++++++++++++++++
 include/dt-bindings/clock/hix5hd2-clock.h          |   58 +++++++++++
 5 files changed, 192 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/hix5hd2-clock.txt
 create mode 100644 drivers/clk/hisilicon/clk-hix5hd2.c
 create mode 100644 include/dt-bindings/clock/hix5hd2-clock.h

diff --git a/Documentation/devicetree/bindings/clock/hix5hd2-clock.txt b/Documentation/devicetree/bindings/clock/hix5hd2-clock.txt
new file mode 100644
index 0000000..7894a64
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/hix5hd2-clock.txt
@@ -0,0 +1,31 @@
+* Hisilicon Hix5hd2 Clock Controller
+
+The hix5hd2 clock controller generates and supplies clock to various
+controllers within the hix5hd2 SoC.
+
+Required Properties:
+
+- compatible: should be "hisilicon,hix5hd2-clock"
+- reg: Address and length of the register set
+- #clock-cells: Should be <1>
+
+Each clock is assigned an identifier and client nodes use this identifier
+to specify the clock which they consume.
+
+All these identifier could be found in <dt-bindings/clock/hix5hd2-clock.h>.
+
+Examples:
+	clock: clock at f8a22000 {
+		compatible = "hisilicon,hix5hd2-clock";
+		reg = <0xf8a22000 0x1000>;
+		#clock-cells = <1>;
+	};
+
+	uart0: uart at f8b00000 {
+		compatible = "arm,pl011", "arm,primecell";
+		reg = <0xf8b00000 0x1000>;
+		interrupts = <0 49 4>;
+		clocks = <&clock HIX5HD2_FIXED_83M>;
+		clock-names = "apb_pclk";
+		status = "disabled";
+	};
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 5f8a287..3e6e577 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -33,6 +33,7 @@ obj-$(CONFIG_COMMON_CLK_AT91)		+= at91/
 obj-$(CONFIG_ARCH_BCM_MOBILE)		+= bcm/
 obj-$(CONFIG_ARCH_HI3xxx)		+= hisilicon/
 obj-$(CONFIG_ARCH_HIP04)		+= hisilicon/
+obj-$(CONFIG_ARCH_HIX5HD2)		+= hisilicon/
 obj-$(CONFIG_COMMON_CLK_KEYSTONE)	+= keystone/
 ifeq ($(CONFIG_COMMON_CLK), y)
 obj-$(CONFIG_ARCH_MMP)			+= mmp/
diff --git a/drivers/clk/hisilicon/Makefile b/drivers/clk/hisilicon/Makefile
index 40b33c6..038c02f 100644
--- a/drivers/clk/hisilicon/Makefile
+++ b/drivers/clk/hisilicon/Makefile
@@ -6,3 +6,4 @@ obj-y	+= clk.o clkgate-separated.o
 
 obj-$(CONFIG_ARCH_HI3xxx)	+= clk-hi3620.o
 obj-$(CONFIG_ARCH_HIP04)	+= clk-hip04.o
+obj-$(CONFIG_ARCH_HIX5HD2)	+= clk-hix5hd2.o
diff --git a/drivers/clk/hisilicon/clk-hix5hd2.c b/drivers/clk/hisilicon/clk-hix5hd2.c
new file mode 100644
index 0000000..e5fcfb4
--- /dev/null
+++ b/drivers/clk/hisilicon/clk-hix5hd2.c
@@ -0,0 +1,101 @@
+/*
+ * Copyright (c) 2014 Linaro Ltd.
+ * Copyright (c) 2014 Hisilicon Limited.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ */
+
+#include <linux/of_address.h>
+#include <dt-bindings/clock/hix5hd2-clock.h>
+#include "clk.h"
+
+static struct hisi_fixed_rate_clock hix5hd2_fixed_rate_clks[] __initdata = {
+	{ HIX5HD2_FIXED_1200M, "1200m", NULL, CLK_IS_ROOT, 1200000000, },
+	{ HIX5HD2_FIXED_400M, "400m", NULL, CLK_IS_ROOT, 400000000, },
+	{ HIX5HD2_FIXED_48M, "48m", NULL, CLK_IS_ROOT, 48000000, },
+	{ HIX5HD2_FIXED_24M, "24m", NULL, CLK_IS_ROOT, 24000000, },
+	{ HIX5HD2_FIXED_600M, "600m", NULL, CLK_IS_ROOT, 600000000, },
+	{ HIX5HD2_FIXED_300M, "300m", NULL, CLK_IS_ROOT, 300000000, },
+	{ HIX5HD2_FIXED_75M, "75m", NULL, CLK_IS_ROOT, 75000000, },
+	{ HIX5HD2_FIXED_200M, "200m", NULL, CLK_IS_ROOT, 200000000, },
+	{ HIX5HD2_FIXED_100M, "100m", NULL, CLK_IS_ROOT, 100000000, },
+	{ HIX5HD2_FIXED_40M, "40m", NULL, CLK_IS_ROOT, 40000000, },
+	{ HIX5HD2_FIXED_150M, "150m", NULL, CLK_IS_ROOT, 150000000, },
+	{ HIX5HD2_FIXED_1728M, "1728m", NULL, CLK_IS_ROOT, 1728000000, },
+	{ HIX5HD2_FIXED_28P8M, "28p8m", NULL, CLK_IS_ROOT, 28000000, },
+	{ HIX5HD2_FIXED_432M, "432m", NULL, CLK_IS_ROOT, 432000000, },
+	{ HIX5HD2_FIXED_345P6M, "345p6m", NULL, CLK_IS_ROOT, 345000000, },
+	{ HIX5HD2_FIXED_288M, "288m", NULL, CLK_IS_ROOT, 288000000, },
+	{ HIX5HD2_FIXED_60M,	"60m", NULL, CLK_IS_ROOT, 60000000, },
+	{ HIX5HD2_FIXED_750M, "750m", NULL, CLK_IS_ROOT, 750000000, },
+	{ HIX5HD2_FIXED_500M, "500m", NULL, CLK_IS_ROOT, 500000000, },
+	{ HIX5HD2_FIXED_54M,	"54m", NULL, CLK_IS_ROOT, 54000000, },
+	{ HIX5HD2_FIXED_27M, "27m", NULL, CLK_IS_ROOT, 27000000, },
+	{ HIX5HD2_FIXED_1500M, "1500m", NULL, CLK_IS_ROOT, 1500000000, },
+	{ HIX5HD2_FIXED_375M, "375m", NULL, CLK_IS_ROOT, 375000000, },
+	{ HIX5HD2_FIXED_187M, "187m", NULL, CLK_IS_ROOT, 187000000, },
+	{ HIX5HD2_FIXED_250M, "250m", NULL, CLK_IS_ROOT, 250000000, },
+	{ HIX5HD2_FIXED_125M, "125m", NULL, CLK_IS_ROOT, 125000000, },
+	{ HIX5HD2_FIXED_2P02M, "2m", NULL, CLK_IS_ROOT, 2000000, },
+	{ HIX5HD2_FIXED_50M, "50m", NULL, CLK_IS_ROOT, 50000000, },
+	{ HIX5HD2_FIXED_25M, "25m", NULL, CLK_IS_ROOT, 25000000, },
+	{ HIX5HD2_FIXED_83M, "83m", NULL, CLK_IS_ROOT, 83333333, },
+};
+
+static const char *sfc_mux_p[] __initconst = {
+		"24m", "150m", "200m", "100m", "75m", };
+static u32 sfc_mux_table[] = {0, 4, 5, 6, 7};
+
+static const char *sdio1_mux_p[] __initconst = {
+		"75m", "100m", "50m", "15m", };
+static u32 sdio1_mux_table[] = {0, 1, 2, 3};
+
+static const char *fephy_mux_p[] __initconst = { "25m", "125m"};
+static u32 fephy_mux_table[] = {0, 1};
+
+
+static struct hisi_mux_clock hix5hd2_mux_clks[] __initdata = {
+	{ HIX5HD2_SFC_MUX, "sfc_mux", sfc_mux_p, ARRAY_SIZE(sfc_mux_p),
+		CLK_SET_RATE_PARENT, 0x5c, 8, 3, 0, sfc_mux_table, },
+	{ HIX5HD2_MMC_MUX, "mmc_mux", sdio1_mux_p, ARRAY_SIZE(sdio1_mux_p),
+		CLK_SET_RATE_PARENT, 0xa0, 8, 2, 0, sdio1_mux_table, },
+	{ HIX5HD2_FEPHY_MUX, "fephy_mux",
+		fephy_mux_p, ARRAY_SIZE(fephy_mux_p),
+		CLK_SET_RATE_PARENT, 0x120, 8, 2, 0, fephy_mux_table, },
+};
+
+static struct hisi_gate_clock hix5hd2_gate_clks[] __initdata = {
+	/*sfc*/
+	{ HIX5HD2_SFC_CLK, "clk_sfc", "sfc_mux",
+		CLK_SET_RATE_PARENT, 0x5c, 0, 0, },
+	{ HIX5HD2_SFC_RST, "rst_sfc", "clk_sfc",
+		CLK_SET_RATE_PARENT, 0x5c, 4, CLK_GATE_SET_TO_DISABLE, },
+	/*sdio1*/
+	{ HIX5HD2_MMC_BIU_CLK, "clk_mmc_biu", "200m",
+		CLK_SET_RATE_PARENT, 0xa0, 0, 0, },
+	{ HIX5HD2_MMC_CIU_CLK, "clk_mmc_ciu", "mmc_mux",
+		CLK_SET_RATE_PARENT, 0xa0, 1, 0, },
+	{ HIX5HD2_MMC_CIU_RST, "rst_mmc_ciu", "clk_mmc_ciu",
+		CLK_SET_RATE_PARENT, 0xa0, 4, CLK_GATE_SET_TO_DISABLE, },
+};
+
+static void __init hix5hd2_clk_init(struct device_node *np)
+{
+	struct hisi_clock_data *clk_data;
+
+	clk_data = hisi_clk_init(np, HIX5HD2_NR_CLKS);
+	if (!clk_data)
+		return;
+
+	hisi_clk_register_fixed_rate(hix5hd2_fixed_rate_clks,
+				     ARRAY_SIZE(hix5hd2_fixed_rate_clks),
+				     clk_data);
+	hisi_clk_register_mux(hix5hd2_mux_clks, ARRAY_SIZE(hix5hd2_mux_clks),
+					clk_data);
+	hisi_clk_register_gate(hix5hd2_gate_clks,
+			ARRAY_SIZE(hix5hd2_gate_clks), clk_data);
+}
+
+CLK_OF_DECLARE(hix5hd2_clk, "hisilicon,hix5hd2-clock", hix5hd2_clk_init);
diff --git a/include/dt-bindings/clock/hix5hd2-clock.h b/include/dt-bindings/clock/hix5hd2-clock.h
new file mode 100644
index 0000000..aad579a
--- /dev/null
+++ b/include/dt-bindings/clock/hix5hd2-clock.h
@@ -0,0 +1,58 @@
+/*
+ * Copyright (c) 2014 Linaro Ltd.
+ * Copyright (c) 2014 Hisilicon Limited.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ */
+
+#ifndef __DTS_HIX5HD2_CLOCK_H
+#define __DTS_HIX5HD2_CLOCK_H
+
+/* fixed rate */
+#define HIX5HD2_FIXED_1200M		1
+#define HIX5HD2_FIXED_400M		2
+#define HIX5HD2_FIXED_48M		3
+#define HIX5HD2_FIXED_24M		4
+#define HIX5HD2_FIXED_600M		5
+#define HIX5HD2_FIXED_300M		6
+#define HIX5HD2_FIXED_75M		7
+#define HIX5HD2_FIXED_200M		8
+#define HIX5HD2_FIXED_100M		9
+#define HIX5HD2_FIXED_40M		10
+#define HIX5HD2_FIXED_150M		11
+#define HIX5HD2_FIXED_1728M		12
+#define HIX5HD2_FIXED_28P8M		13
+#define HIX5HD2_FIXED_432M		14
+#define HIX5HD2_FIXED_345P6M		15
+#define HIX5HD2_FIXED_288M		16
+#define HIX5HD2_FIXED_60M		17
+#define HIX5HD2_FIXED_750M		18
+#define HIX5HD2_FIXED_500M		19
+#define HIX5HD2_FIXED_54M		20
+#define HIX5HD2_FIXED_27M		21
+#define HIX5HD2_FIXED_1500M		22
+#define HIX5HD2_FIXED_375M		23
+#define HIX5HD2_FIXED_187M		24
+#define HIX5HD2_FIXED_250M		25
+#define HIX5HD2_FIXED_125M		26
+#define HIX5HD2_FIXED_2P02M		27
+#define HIX5HD2_FIXED_50M		28
+#define HIX5HD2_FIXED_25M		29
+#define HIX5HD2_FIXED_83M		30
+
+/* mux clocks */
+#define HIX5HD2_SFC_MUX			64
+#define HIX5HD2_MMC_MUX			65
+#define HIX5HD2_FEPHY_MUX		66
+
+/* gate clocks */
+#define HIX5HD2_SFC_RST			128
+#define HIX5HD2_SFC_CLK			129
+#define HIX5HD2_MMC_CIU_CLK		130
+#define HIX5HD2_MMC_BIU_CLK		131
+#define HIX5HD2_MMC_CIU_RST		132
+
+#define HIX5HD2_NR_CLKS			256
+#endif	/* __DTS_HIX5HD2_CLOCK_H */
-- 
1.7.9.5
