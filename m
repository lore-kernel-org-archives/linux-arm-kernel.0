From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 03 Jul 2014 02:01:14 +0200
Subject: [PATCH v5 08/14] clk: rockchip: add clock driver for rk3188 and
 rk3066 clocks
In-Reply-To: <156042792.J76K6jxIGl@diego>
References: <156042792.J76K6jxIGl@diego>
Message-ID: <2237100.JKxQGlbnD2@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a clock driver that handles the specific muxes, dividers and gates
of rk3188 and rk3066 SoCs.

The structure of the clock list resembles the arrangement of their
counterparts in the clock architecture diagrams found in the SoC
documentation.

Clocks exported to the clock provider are currently limited to well known
or measured ones. So additional clock exports may be necessary in the future.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Acked-By: Max Schwarz <max.schwarz@online.de>
Tested-By: Max Schwarz <max.schwarz@online.de>
---
 drivers/clk/rockchip/Makefile                 |   2 +
 drivers/clk/rockchip/clk-rk3188.c             | 672 ++++++++++++++++++++++++++
 include/dt-bindings/clock/rk3066a-cru.h       |  35 ++
 include/dt-bindings/clock/rk3188-cru-common.h | 249 ++++++++++
 include/dt-bindings/clock/rk3188-cru.h        |  51 ++
 5 files changed, 1009 insertions(+)
 create mode 100644 drivers/clk/rockchip/clk-rk3188.c
 create mode 100644 include/dt-bindings/clock/rk3066a-cru.h
 create mode 100644 include/dt-bindings/clock/rk3188-cru-common.h
 create mode 100644 include/dt-bindings/clock/rk3188-cru.h

diff --git a/drivers/clk/rockchip/Makefile b/drivers/clk/rockchip/Makefile
index 85f8a55..3eebf72 100644
--- a/drivers/clk/rockchip/Makefile
+++ b/drivers/clk/rockchip/Makefile
@@ -6,3 +6,5 @@ obj-y	+= clk-rockchip.o
 obj-y	+= clk.o
 obj-y	+= clk-pll.o
 obj-$(CONFIG_RESET_CONTROLLER)	+= softrst.o
+
+obj-y	+= clk-rk3188.o
diff --git a/drivers/clk/rockchip/clk-rk3188.c b/drivers/clk/rockchip/clk-rk3188.c
new file mode 100644
index 0000000..a83a6d8
--- /dev/null
+++ b/drivers/clk/rockchip/clk-rk3188.c
@@ -0,0 +1,672 @@
+/*
+ * Copyright (c) 2014 MundoReader S.L.
+ * Author: Heiko Stuebner <heiko@sntech.de>
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
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <dt-bindings/clock/rk3188-cru-common.h>
+#include "clk.h"
+
+#define RK3188_GRF_SOC_STATUS	0xac
+
+enum rk3188_plls {
+	apll, cpll, dpll, gpll,
+};
+
+struct rockchip_pll_rate_table rk3188_pll_rates[] = {
+	RK3066_PLL_RATE(2208000000, 1, 92, 1),
+	RK3066_PLL_RATE(2184000000, 1, 91, 1),
+	RK3066_PLL_RATE(2160000000, 1, 90, 1),
+	RK3066_PLL_RATE(2136000000, 1, 89, 1),
+	RK3066_PLL_RATE(2112000000, 1, 88, 1),
+	RK3066_PLL_RATE(2088000000, 1, 87, 1),
+	RK3066_PLL_RATE(2064000000, 1, 86, 1),
+	RK3066_PLL_RATE(2040000000, 1, 85, 1),
+	RK3066_PLL_RATE(2016000000, 1, 84, 1),
+	RK3066_PLL_RATE(1992000000, 1, 83, 1),
+	RK3066_PLL_RATE(1968000000, 1, 82, 1),
+	RK3066_PLL_RATE(1944000000, 1, 81, 1),
+	RK3066_PLL_RATE(1920000000, 1, 80, 1),
+	RK3066_PLL_RATE(1896000000, 1, 79, 1),
+	RK3066_PLL_RATE(1872000000, 1, 78, 1),
+	RK3066_PLL_RATE(1848000000, 1, 77, 1),
+	RK3066_PLL_RATE(1824000000, 1, 76, 1),
+	RK3066_PLL_RATE(1800000000, 1, 75, 1),
+	RK3066_PLL_RATE(1776000000, 1, 74, 1),
+	RK3066_PLL_RATE(1752000000, 1, 73, 1),
+	RK3066_PLL_RATE(1728000000, 1, 72, 1),
+	RK3066_PLL_RATE(1704000000, 1, 71, 1),
+	RK3066_PLL_RATE(1680000000, 1, 70, 1),
+	RK3066_PLL_RATE(1656000000, 1, 69, 1),
+	RK3066_PLL_RATE(1632000000, 1, 68, 1),
+	RK3066_PLL_RATE(1608000000, 1, 67, 1),
+	RK3066_PLL_RATE(1560000000, 1, 65, 1),
+	RK3066_PLL_RATE(1512000000, 1, 63, 1),
+	RK3066_PLL_RATE(1488000000, 1, 62, 1),
+	RK3066_PLL_RATE(1464000000, 1, 61, 1),
+	RK3066_PLL_RATE(1440000000, 1, 60, 1),
+	RK3066_PLL_RATE(1416000000, 1, 59, 1),
+	RK3066_PLL_RATE(1392000000, 1, 58, 1),
+	RK3066_PLL_RATE(1368000000, 1, 57, 1),
+	RK3066_PLL_RATE(1344000000, 1, 56, 1),
+	RK3066_PLL_RATE(1320000000, 1, 55, 1),
+	RK3066_PLL_RATE(1296000000, 1, 54, 1),
+	RK3066_PLL_RATE(1272000000, 1, 53, 1),
+	RK3066_PLL_RATE(1248000000, 1, 52, 1),
+	RK3066_PLL_RATE(1224000000, 1, 51, 1),
+	RK3066_PLL_RATE(1200000000, 1, 50, 1),
+	RK3066_PLL_RATE(1188000000, 2, 99, 1),
+	RK3066_PLL_RATE(1176000000, 1, 49, 1),
+	RK3066_PLL_RATE(1128000000, 1, 47, 1),
+	RK3066_PLL_RATE(1104000000, 1, 46, 1),
+	RK3066_PLL_RATE(1008000000, 1, 84, 2),
+	RK3066_PLL_RATE( 912000000, 1, 76, 2),
+	RK3066_PLL_RATE( 891000000, 8, 594, 2),
+	RK3066_PLL_RATE( 888000000, 1, 74, 2),
+	RK3066_PLL_RATE( 816000000, 1, 68, 2),
+	RK3066_PLL_RATE( 798000000, 2, 133, 2),
+	RK3066_PLL_RATE( 792000000, 1, 66, 2),
+	RK3066_PLL_RATE( 768000000, 1, 64, 2),
+	RK3066_PLL_RATE( 742500000, 8, 495, 2),
+	RK3066_PLL_RATE( 696000000, 1, 58, 2),
+	RK3066_PLL_RATE( 600000000, 1, 50, 2),
+	RK3066_PLL_RATE( 594000000, 2, 198, 4),
+	RK3066_PLL_RATE( 552000000, 1, 46, 2),
+	RK3066_PLL_RATE( 504000000, 1, 84, 4),
+	RK3066_PLL_RATE( 456000000, 1, 76, 4),
+	RK3066_PLL_RATE( 408000000, 1, 68, 4),
+	RK3066_PLL_RATE( 384000000, 2, 128, 4),
+	RK3066_PLL_RATE( 360000000, 1, 60, 4),
+	RK3066_PLL_RATE( 312000000, 1, 52, 4),
+	RK3066_PLL_RATE( 300000000, 1, 50, 4),
+	RK3066_PLL_RATE( 297000000, 2, 198, 8),
+	RK3066_PLL_RATE( 252000000, 1, 84, 8),
+	RK3066_PLL_RATE( 216000000, 1, 72, 8),
+	RK3066_PLL_RATE( 148500000, 2, 99, 8),
+	RK3066_PLL_RATE( 126000000, 1, 84, 16),
+	RK3066_PLL_RATE(  48000000, 1, 64, 32),
+	{ /* sentinel */ },
+};
+
+PNAME(mux_pll_p)		= { "xin24m", "xin32k" };
+PNAME(mux_armclk_p)		= { "apll", "gpll_armclk" };
+PNAME(mux_ddrphy_p)		= { "dpll", "gpll_ddr" };
+PNAME(mux_pll_src_gpll_cpll_p)	= { "gpll", "cpll" };
+PNAME(mux_pll_src_cpll_gpll_p)	= { "cpll", "gpll" };
+PNAME(mux_aclk_cpu_p)		= { "apll", "gpll" };
+PNAME(mux_sclk_cif0_p)		= { "cif0_pre", "xin24m" };
+PNAME(mux_sclk_i2s0_p)		= { "i2s0_pre", "i2s0_frac", "xin12m" };
+PNAME(mux_sclk_spdif_p)		= { "spdif_src", "spdif_frac", "xin12m" };
+PNAME(mux_sclk_uart0_p)		= { "uart0_pre", "uart0_frac", "xin24m" };
+PNAME(mux_sclk_uart1_p)		= { "uart1_pre", "uart1_frac", "xin24m" };
+PNAME(mux_sclk_uart2_p)		= { "uart2_pre", "uart2_frac", "xin24m" };
+PNAME(mux_sclk_uart3_p)		= { "uart3_pre", "uart3_frac", "xin24m" };
+PNAME(mux_sclk_hsadc_p)		= { "hsadc_src", "hsadc_frac", "ext_hsadc" };
+PNAME(mux_mac_p)		= { "gpll", "dpll" };
+PNAME(mux_sclk_macref_p)	= { "mac_src", "ext_rmii" };
+
+static struct rockchip_pll_clock rk3188_pll_clks[] __initdata = {
+	[apll] = PLL(pll_rk3066, PLL_APLL, "apll", mux_pll_p, 0, RK2928_PLL_CON(0),
+		     RK2928_MODE_CON, 0, 6, rk3188_pll_rates),
+	[dpll] = PLL(pll_rk3066, PLL_DPLL, "dpll", mux_pll_p, 0, RK2928_PLL_CON(4),
+		     RK2928_MODE_CON, 4, 5, NULL),
+	[cpll] = PLL(pll_rk3066, PLL_CPLL, "cpll", mux_pll_p, 0, RK2928_PLL_CON(8),
+		     RK2928_MODE_CON, 8, 7, rk3188_pll_rates),
+	[gpll] = PLL(pll_rk3066, PLL_GPLL, "gpll", mux_pll_p, 0, RK2928_PLL_CON(12),
+		     RK2928_MODE_CON, 12, 8, rk3188_pll_rates),
+};
+
+#define MFLAGS CLK_MUX_HIWORD_MASK
+#define DFLAGS CLK_DIVIDER_HIWORD_MASK
+#define GFLAGS (CLK_GATE_HIWORD_MASK | CLK_GATE_SET_TO_DISABLE)
+
+/* 2 ^ (val + 1) */
+static struct clk_div_table div_core_peri_t[] = {
+	{ .val = 0, .div = 2 },
+	{ .val = 1, .div = 4 },
+	{ .val = 2, .div = 8 },
+	{ .val = 3, .div = 16 },
+	{ /* sentinel */ },
+};
+
+static struct rockchip_clk_branch common_clk_branches[] __initdata = {
+	/*
+	 * Clock-Architecture Diagram 2
+	 */
+
+	GATE(0, "gpll_armclk", "gpll", 0, RK2928_CLKGATE_CON(0), 1, GFLAGS),
+
+	/* these two are set by the cpuclk and should not be changed */
+	COMPOSITE_NOMUX_DIVTBL(CORE_PERI, "core_peri", "armclk", 0,
+			RK2928_CLKSEL_CON(0), 6, 2, DFLAGS | CLK_DIVIDER_READ_ONLY,
+			div_core_peri_t, RK2928_CLKGATE_CON(0), 0, GFLAGS),
+
+	COMPOSITE(0, "aclk_vepu", mux_pll_src_cpll_gpll_p, 0,
+			RK2928_CLKSEL_CON(32), 7, 1, MFLAGS, 0, 5, DFLAGS,
+			RK2928_CLKGATE_CON(3), 9, GFLAGS),
+	GATE(0, "hclk_vepu", "aclk_vepu", 0,
+			RK2928_CLKGATE_CON(3), 10, GFLAGS),
+	COMPOSITE(0, "aclk_vdpu", mux_pll_src_cpll_gpll_p, 0,
+			RK2928_CLKSEL_CON(32), 15, 1, MFLAGS, 8, 5, DFLAGS,
+			RK2928_CLKGATE_CON(3), 11, GFLAGS),
+	GATE(0, "hclk_vdpu", "aclk_vdpu", 0,
+			RK2928_CLKGATE_CON(3), 12, GFLAGS),
+
+	GATE(0, "gpll_ddr", "gpll", 0,
+			RK2928_CLKGATE_CON(1), 7, GFLAGS),
+	COMPOSITE(0, "ddrphy", mux_ddrphy_p, 0,
+			RK2928_CLKSEL_CON(26), 8, 1, MFLAGS, 0, 2, DFLAGS | CLK_DIVIDER_POWER_OF_TWO,
+			RK2928_CLKGATE_CON(0), 2, GFLAGS),
+
+	GATE(0, "aclk_cpu", "aclk_cpu_pre", 0,
+			RK2928_CLKGATE_CON(0), 3, GFLAGS),
+
+	DIV(0, "pclk_cpu_pre", "aclk_cpu_pre", 0,
+			RK2928_CLKSEL_CON(1), 12, 2, DFLAGS | CLK_DIVIDER_POWER_OF_TWO),
+	GATE(0, "atclk_cpu", "pclk_cpu_pre", 0,
+			RK2928_CLKGATE_CON(0), 6, GFLAGS),
+	GATE(0, "pclk_cpu", "pclk_cpu_pre", 0,
+			RK2928_CLKGATE_CON(0), 5, GFLAGS),
+	DIV(0, "hclk_cpu_pre", "aclk_cpu_pre", 0,
+			RK2928_CLKSEL_CON(1), 8, 2, DFLAGS | CLK_DIVIDER_POWER_OF_TWO),
+	COMPOSITE_NOMUX(0, "hclk_ahb2apb", "hclk_cpu_pre", 0,
+			RK2928_CLKSEL_CON(1), 14, 2, DFLAGS | CLK_DIVIDER_POWER_OF_TWO,
+			RK2928_CLKGATE_CON(4), 9, GFLAGS),
+	GATE(0, "hclk_cpu", "hclk_cpu_pre", 0,
+			RK2928_CLKGATE_CON(0), 4, GFLAGS),
+
+	COMPOSITE(0, "aclk_lcdc0_pre", mux_pll_src_cpll_gpll_p, 0,
+			RK2928_CLKSEL_CON(31), 7, 1, MFLAGS, 0, 5, DFLAGS,
+			RK2928_CLKGATE_CON(3), 0, GFLAGS),
+	COMPOSITE(0, "aclk_lcdc1_pre", mux_pll_src_cpll_gpll_p, 0,
+			RK2928_CLKSEL_CON(31), 15, 1, MFLAGS, 8, 5, DFLAGS,
+			RK2928_CLKGATE_CON(1), 4, GFLAGS),
+
+	GATE(0, "aclk_peri", "aclk_peri_pre", 0,
+			RK2928_CLKGATE_CON(2), 1, GFLAGS),
+	COMPOSITE_NOMUX(0, "hclk_peri", "aclk_peri_pre", 0,
+			RK2928_CLKSEL_CON(10), 8, 2, DFLAGS | CLK_DIVIDER_POWER_OF_TWO,
+			RK2928_CLKGATE_CON(2), 2, GFLAGS),
+	COMPOSITE_NOMUX(0, "pclk_peri", "aclk_peri_pre", 0,
+			RK2928_CLKSEL_CON(10), 12, 2, DFLAGS | CLK_DIVIDER_POWER_OF_TWO,
+			RK2928_CLKGATE_CON(2), 3, GFLAGS),
+
+	MUX(0, "cif_src", mux_pll_src_cpll_gpll_p, 0,
+			RK2928_CLKSEL_CON(29), 0, 1, MFLAGS),
+	COMPOSITE_NOMUX(0, "cif0_pre", "cif_src", 0,
+			RK2928_CLKSEL_CON(29), 1, 5, DFLAGS,
+			RK2928_CLKGATE_CON(3), 7, GFLAGS),
+	MUX(SCLK_CIF0, "sclk_cif0", mux_sclk_cif0_p, 0,
+			RK2928_CLKSEL_CON(29), 7, 1, MFLAGS),
+
+	GATE(0, "pclkin_cif0", "ext_cif0", 0,
+			RK2928_CLKGATE_CON(3), 3, GFLAGS),
+
+	/*
+	 * the 480m are generated inside the usb block from these clocks,
+	 * but they are also a source for the hsicphy clock.
+	 */
+	GATE(SCLK_OTGPHY0, "sclk_otgphy0", "usb480m", 0,
+			RK2928_CLKGATE_CON(1), 5, GFLAGS),
+	GATE(SCLK_OTGPHY1, "sclk_otgphy1", "usb480m", 0,
+			RK2928_CLKGATE_CON(1), 6, GFLAGS),
+
+	COMPOSITE(0, "mac_src", mux_mac_p, 0,
+			RK2928_CLKSEL_CON(21), 0, 1, MFLAGS, 8, 5, DFLAGS,
+			RK2928_CLKGATE_CON(2), 5, GFLAGS),
+	MUX(SCLK_MAC, "sclk_macref", mux_sclk_macref_p, CLK_SET_RATE_PARENT,
+			RK2928_CLKSEL_CON(21), 4, 1, MFLAGS),
+	GATE(0, "sclk_mac_lbtest", "sclk_macref",
+			RK2928_CLKGATE_CON(2), 12, 0, GFLAGS),
+
+	COMPOSITE(0, "hsadc_src", mux_pll_src_gpll_cpll_p, 0,
+			RK2928_CLKSEL_CON(22), 0, 1, MFLAGS, 8, 8, DFLAGS,
+			RK2928_CLKGATE_CON(2), 6, GFLAGS),
+	COMPOSITE_FRAC(0, "hsadc_frac", "hsadc_src",
+			RK2928_CLKSEL_CON(23), 0,
+			RK2928_CLKGATE_CON(2), 7, 0, GFLAGS),
+	MUX(SCLK_HSADC, "sclk_hsadc", mux_sclk_hsadc_p, 0,
+			RK2928_CLKSEL_CON(22), 4, 2, MFLAGS),
+
+	COMPOSITE_NOMUX(SCLK_SARADC, "sclk_saradc", "xin24m", 0,
+			RK2928_CLKSEL_CON(24), 8, 8, DFLAGS,
+			RK2928_CLKGATE_CON(2), 8, GFLAGS),
+
+	/*
+	 * Clock-Architecture Diagram 4
+	 */
+
+	GATE(SCLK_SMC, "sclk_smc", "hclk_peri",
+			RK2928_CLKGATE_CON(2), 4, 0, GFLAGS),
+
+	COMPOSITE_NOMUX(SCLK_SPI0, "sclk_spi0", "pclk_peri", 0,
+			RK2928_CLKSEL_CON(25), 0, 7, DFLAGS,
+			RK2928_CLKGATE_CON(2), 9, GFLAGS),
+	COMPOSITE_NOMUX(SCLK_SPI1, "sclk_spi1", "pclk_peri", 0,
+			RK2928_CLKSEL_CON(25), 8, 7, DFLAGS,
+			RK2928_CLKGATE_CON(2), 10, GFLAGS),
+
+	COMPOSITE_NOMUX(SCLK_SDMMC, "sclk_sdmmc", "hclk_peri", 0,
+			RK2928_CLKSEL_CON(11), 0, 6, DFLAGS,
+			RK2928_CLKGATE_CON(2), 11, GFLAGS),
+	COMPOSITE_NOMUX(SCLK_SDIO, "sclk_sdio", "hclk_peri", 0,
+			RK2928_CLKSEL_CON(12), 0, 6, DFLAGS,
+			RK2928_CLKGATE_CON(2), 13, GFLAGS),
+	COMPOSITE_NOMUX(SCLK_EMMC, "sclk_emmc", "hclk_peri", 0,
+			RK2928_CLKSEL_CON(12), 8, 6, DFLAGS,
+			RK2928_CLKGATE_CON(2), 14, GFLAGS),
+
+	MUX(0, "uart_src", mux_pll_src_gpll_cpll_p, 0,
+			RK2928_CLKSEL_CON(12), 15, 1, MFLAGS),
+	COMPOSITE_NOMUX(0, "uart0_pre", "uart_src", 0,
+			RK2928_CLKSEL_CON(13), 0, 7, DFLAGS,
+			RK2928_CLKGATE_CON(1), 8, GFLAGS),
+	COMPOSITE_FRAC(0, "uart0_frac", "uart0_pre", 0,
+			RK2928_CLKSEL_CON(17), 0,
+			RK2928_CLKGATE_CON(1), 9, GFLAGS),
+	MUX(SCLK_UART0, "sclk_uart0", mux_sclk_uart0_p, 0,
+			RK2928_CLKSEL_CON(13), 8, 2, MFLAGS),
+	COMPOSITE_NOMUX(0, "uart1_pre", "uart_src", 0,
+			RK2928_CLKSEL_CON(14), 0, 7, DFLAGS,
+			RK2928_CLKGATE_CON(1), 10, GFLAGS),
+	COMPOSITE_FRAC(0, "uart1_frac", "uart1_pre", 0,
+			RK2928_CLKSEL_CON(18), 0,
+			RK2928_CLKGATE_CON(1), 11, GFLAGS),
+	MUX(SCLK_UART1, "sclk_uart1", mux_sclk_uart1_p, 0,
+			RK2928_CLKSEL_CON(14), 8, 2, MFLAGS),
+	COMPOSITE_NOMUX(0, "uart2_pre", "uart_src", 0,
+			RK2928_CLKSEL_CON(15), 0, 7, DFLAGS,
+			RK2928_CLKGATE_CON(1), 12, GFLAGS),
+	COMPOSITE_FRAC(0, "uart2_frac", "uart2_pre", 0,
+			RK2928_CLKSEL_CON(19), 0,
+			RK2928_CLKGATE_CON(1), 13, GFLAGS),
+	MUX(SCLK_UART2, "sclk_uart2", mux_sclk_uart2_p, 0,
+			RK2928_CLKSEL_CON(15), 8, 2, MFLAGS),
+	COMPOSITE_NOMUX(0, "uart3_pre", "uart_src", 0,
+			RK2928_CLKSEL_CON(16), 0, 7, DFLAGS,
+			RK2928_CLKGATE_CON(1), 14, GFLAGS),
+	COMPOSITE_FRAC(0, "uart3_frac", "uart3_pre", 0,
+			RK2928_CLKSEL_CON(20), 0,
+			RK2928_CLKGATE_CON(1), 15, GFLAGS),
+	MUX(SCLK_UART3, "sclk_uart3", mux_sclk_uart3_p, 0,
+			RK2928_CLKSEL_CON(16), 8, 2, MFLAGS),
+
+	GATE(SCLK_JTAG, "jtag", "ext_jtag", 0, RK2928_CLKGATE_CON(1), 3, GFLAGS),
+
+	GATE(SCLK_TIMER0, "timer0", "xin24m", 0, RK2928_CLKGATE_CON(1), 0, GFLAGS),
+	GATE(SCLK_TIMER1, "timer1", "xin24m", 0, RK2928_CLKGATE_CON(1), 1, GFLAGS),
+
+	/* clk_core_pre gates */
+	GATE(0, "core_dbg", "armclk", 0, RK2928_CLKGATE_CON(9), 0, GFLAGS),
+
+	/* aclk_cpu gates */
+	GATE(ACLK_DMA1, "aclk_dma1", "aclk_cpu", 0, RK2928_CLKGATE_CON(5), 0, GFLAGS),
+	GATE(0, "aclk_intmem", "aclk_cpu", 0, RK2928_CLKGATE_CON(4), 12, GFLAGS),
+	GATE(0, "aclk_strc_sys", "aclk_cpu", 0, RK2928_CLKGATE_CON(4), 10, GFLAGS),
+
+	/* hclk_cpu gates */
+	GATE(HCLK_ROM, "hclk_rom", "hclk_cpu", 0, RK2928_CLKGATE_CON(5), 6, GFLAGS),
+	GATE(HCLK_I2S0, "hclk_i2s0", "hclk_cpu", 0, RK2928_CLKGATE_CON(7), 2, GFLAGS),
+	GATE(HCLK_SPDIF, "hclk_spdif", "hclk_cpu", 0, RK2928_CLKGATE_CON(7), 1, GFLAGS),
+	GATE(0, "hclk_cpubus", "hclk_cpu", 0, RK2928_CLKGATE_CON(4), 8, GFLAGS),
+	/* hclk_ahb2apb is part of a clk branch */
+	GATE(0, "hclk_vio_bus", "hclk_cpu", 0, RK2928_CLKGATE_CON(6), 12, GFLAGS),
+	GATE(HCLK_LCDC0, "hclk_lcdc0", "hclk_cpu", 0, RK2928_CLKGATE_CON(6), 1, GFLAGS),
+	GATE(HCLK_LCDC1, "hclk_lcdc1", "aclk_cpu", 0, RK2928_CLKGATE_CON(6), 2, GFLAGS),
+	GATE(HCLK_CIF0, "hclk_cif0", "hclk_cpu", 0, RK2928_CLKGATE_CON(6), 4, GFLAGS),
+	GATE(HCLK_IPP, "hclk_ipp", "hclk_cpu", 0, RK2928_CLKGATE_CON(6), 9, GFLAGS),
+	GATE(HCLK_RGA, "hclk_rga", "hclk_cpu", 0, RK2928_CLKGATE_CON(6), 10, GFLAGS),
+
+	/* hclk_peri gates */
+	GATE(0, "hclk_peri_axi_matrix", "hclk_peri", 0, RK2928_CLKGATE_CON(4), 0, GFLAGS),
+	GATE(0, "hclk_peri_ahb_arbi", "hclk_peri", 0, RK2928_CLKGATE_CON(4), 6, GFLAGS),
+	GATE(0, "hclk_emem_peri", "hclk_peri", 0, RK2928_CLKGATE_CON(4), 7, GFLAGS),
+	GATE(HCLK_EMAC, "hclk_emac", "hclk_peri", 0, RK2928_CLKGATE_CON(7), 0, GFLAGS),
+	GATE(HCLK_NANDC0, "hclk_nandc0", "hclk_peri", 0, RK2928_CLKGATE_CON(5), 9, GFLAGS),
+	GATE(0, "hclk_usb_peri", "hclk_peri", 0, RK2928_CLKGATE_CON(4), 5, GFLAGS),
+	GATE(HCLK_OTG0, "hclk_usbotg0", "hclk_peri", 0, RK2928_CLKGATE_CON(5), 13, GFLAGS),
+	GATE(HCLK_HSADC, "hclk_hsadc", "hclk_peri", 0, RK2928_CLKGATE_CON(7), 5, GFLAGS),
+	GATE(HCLK_PIDF, "hclk_pidfilter", "hclk_peri", 0, RK2928_CLKGATE_CON(7), 6, GFLAGS),
+	GATE(HCLK_SDMMC, "hclk_sdmmc", "hclk_peri", 0, RK2928_CLKGATE_CON(5), 10, GFLAGS),
+	GATE(HCLK_SDIO, "hclk_sdio", "hclk_peri", 0, RK2928_CLKGATE_CON(5), 11, GFLAGS),
+	GATE(HCLK_EMMC, "hclk_emmc", "hclk_peri", 0, RK2928_CLKGATE_CON(5), 12, GFLAGS),
+
+	/* aclk_lcdc0_pre gates */
+	GATE(0, "aclk_vio0", "aclk_lcdc0_pre", 0, RK2928_CLKGATE_CON(6), 13, GFLAGS),
+	GATE(ACLK_LCDC0, "aclk_lcdc0", "aclk_vio0", 0, RK2928_CLKGATE_CON(6), 0, GFLAGS),
+	GATE(ACLK_CIF0, "aclk_cif0", "aclk_vio0", 0, RK2928_CLKGATE_CON(6), 5, GFLAGS),
+	GATE(ACLK_IPP, "aclk_ipp", "aclk_vio0", 0, RK2928_CLKGATE_CON(6), 8, GFLAGS),
+
+	/* aclk_lcdc1_pre gates */
+	GATE(0, "aclk_vio1", "aclk_lcdc1_pre", 0, RK2928_CLKGATE_CON(9), 5, GFLAGS),
+	GATE(ACLK_LCDC1, "aclk_lcdc1", "aclk_vio1", 0, RK2928_CLKGATE_CON(6), 3, GFLAGS),
+	GATE(ACLK_RGA, "aclk_rga", "aclk_vio1", 0, RK2928_CLKGATE_CON(6), 11, GFLAGS),
+
+	/* atclk_cpu gates */
+	GATE(0, "atclk", "atclk_cpu", 0, RK2928_CLKGATE_CON(9), 3, GFLAGS),
+	GATE(0, "trace", "atclk_cpu", 0, RK2928_CLKGATE_CON(9), 2, GFLAGS),
+
+	/* pclk_cpu gates */
+	GATE(PCLK_PWM01, "pclk_pwm01", "pclk_cpu", 0, RK2928_CLKGATE_CON(7), 10, GFLAGS),
+	GATE(PCLK_TIMER0, "pclk_timer0", "pclk_cpu", 0, RK2928_CLKGATE_CON(7), 7, GFLAGS),
+	GATE(PCLK_I2C0, "pclk_i2c0", "pclk_cpu", 0, RK2928_CLKGATE_CON(8), 4, GFLAGS),
+	GATE(PCLK_I2C1, "pclk_i2c1", "pclk_cpu", 0, RK2928_CLKGATE_CON(8), 5, GFLAGS),
+	GATE(PCLK_GPIO0, "pclk_gpio0", "pclk_cpu", 0, RK2928_CLKGATE_CON(8), 9, GFLAGS),
+	GATE(PCLK_GPIO1, "pclk_gpio1", "pclk_cpu", 0, RK2928_CLKGATE_CON(8), 10, GFLAGS),
+	GATE(PCLK_GPIO2, "pclk_gpio2", "pclk_cpu", 0, RK2928_CLKGATE_CON(8), 11, GFLAGS),
+	GATE(PCLK_EFUSE, "pclk_efuse", "pclk_cpu", 0, RK2928_CLKGATE_CON(5), 2, GFLAGS),
+	GATE(PCLK_TZPC, "pclk_tzpc", "pclk_cpu", 0, RK2928_CLKGATE_CON(5), 3, GFLAGS),
+	GATE(0, "pclk_ddrupctl", "pclk_cpu", 0, RK2928_CLKGATE_CON(5), 7, GFLAGS),
+	GATE(0, "pclk_ddrpubl", "pclk_cpu", 0, RK2928_CLKGATE_CON(9), 6, GFLAGS),
+	GATE(0, "pclk_dbg", "pclk_cpu", 0, RK2928_CLKGATE_CON(9), 1, GFLAGS),
+	GATE(PCLK_GRF, "pclk_grf", "pclk_cpu", 0, RK2928_CLKGATE_CON(5), 4, GFLAGS),
+	GATE(PCLK_PMU, "pclk_pmu", "pclk_cpu", 0, RK2928_CLKGATE_CON(5), 5, GFLAGS),
+
+	/* aclk_peri */
+	GATE(ACLK_DMA2, "aclk_dma2", "aclk_peri", 0, RK2928_CLKGATE_CON(5), 1, GFLAGS),
+	GATE(ACLK_SMC, "aclk_smc", "aclk_peri", 0, RK2928_CLKGATE_CON(5), 8, GFLAGS),
+	GATE(0, "aclk_peri_niu", "aclk_peri", 0, RK2928_CLKGATE_CON(4), 4, GFLAGS),
+	GATE(0, "aclk_cpu_peri", "aclk_peri", 0, RK2928_CLKGATE_CON(4), 2, GFLAGS),
+	GATE(0, "aclk_peri_axi_matrix", "aclk_peri", 0, RK2928_CLKGATE_CON(4), 3, GFLAGS),
+
+	/* pclk_peri gates */
+	GATE(0, "pclk_peri_axi_matrix", "pclk_peri", 0, RK2928_CLKGATE_CON(4), 1, GFLAGS),
+	GATE(PCLK_PWM23, "pclk_pwm23", "pclk_peri", 0, RK2928_CLKGATE_CON(7), 11, GFLAGS),
+	GATE(PCLK_WDT, "pclk_wdt", "pclk_peri", 0, RK2928_CLKGATE_CON(7), 15, GFLAGS),
+	GATE(PCLK_SPI0, "pclk_spi0", "pclk_peri", 0, RK2928_CLKGATE_CON(7), 12, GFLAGS),
+	GATE(PCLK_SPI1, "pclk_spi1", "pclk_peri", 0, RK2928_CLKGATE_CON(7), 13, GFLAGS),
+	GATE(PCLK_UART2, "pclk_uart2", "pclk_peri", 0, RK2928_CLKGATE_CON(8), 2, GFLAGS),
+	GATE(PCLK_UART3, "pclk_uart3", "pclk_peri", 0, RK2928_CLKGATE_CON(8), 3, GFLAGS),
+	GATE(PCLK_I2C2, "pclk_i2c2", "pclk_peri", 0, RK2928_CLKGATE_CON(8), 6, GFLAGS),
+	GATE(PCLK_I2C3, "pclk_i2c3", "pclk_peri", 0, RK2928_CLKGATE_CON(8), 7, GFLAGS),
+	GATE(PCLK_I2C4, "pclk_i2c4", "pclk_peri", 0, RK2928_CLKGATE_CON(8), 8, GFLAGS),
+	GATE(PCLK_GPIO3, "pclk_gpio3", "pclk_peri", 0, RK2928_CLKGATE_CON(8), 12, GFLAGS),
+	GATE(PCLK_SARADC, "pclk_saradc", "pclk_peri", 0, RK2928_CLKGATE_CON(7), 14, GFLAGS),
+};
+
+PNAME(mux_rk3066_lcdc0_p)	= { "dclk_lcdc0_src", "xin27m" };
+PNAME(mux_rk3066_lcdc1_p)	= { "dclk_lcdc1_src", "xin27m" };
+PNAME(mux_sclk_cif1_p)		= { "cif1_pre", "xin24m" };
+PNAME(mux_sclk_i2s1_p)		= { "i2s1_pre", "i2s1_frac", "xin12m" };
+PNAME(mux_sclk_i2s2_p)		= { "i2s2_pre", "i2s2_frac", "xin12m" };
+
+static struct clk_div_table div_aclk_cpu_t[] = {
+	{ .val = 0, .div = 1 },
+	{ .val = 1, .div = 2 },
+	{ .val = 2, .div = 3 },
+	{ .val = 3, .div = 4 },
+	{ .val = 4, .div = 8 },
+	{ /* sentinel */ },
+};
+
+static struct rockchip_clk_branch rk3066a_clk_branches[] __initdata = {
+	COMPOSITE_NOGATE(0, "armclk", mux_armclk_p, 0,
+			RK2928_CLKSEL_CON(0), 8, 1, MFLAGS, 0, 5, DFLAGS),
+	DIVTBL(0, "aclk_cpu_pre", "armclk", 0,
+			RK2928_CLKSEL_CON(1), 0, 3, DFLAGS, div_aclk_cpu_t),
+
+	GATE(CORE_L2C, "core_l2c", "aclk_cpu", 0,
+			RK2928_CLKGATE_CON(9), 4, GFLAGS),
+
+	COMPOSITE(0, "aclk_peri_pre", mux_pll_src_gpll_cpll_p, 0,
+			RK2928_CLKSEL_CON(10), 15, 1, MFLAGS, 0, 5, DFLAGS,
+			RK2928_CLKGATE_CON(2), 0, GFLAGS),
+
+	COMPOSITE(0, "dclk_lcdc0_src", mux_pll_src_cpll_gpll_p, 0,
+			RK2928_CLKSEL_CON(27), 0, 1, MFLAGS, 8, 8, DFLAGS,
+			RK2928_CLKGATE_CON(3), 1, GFLAGS),
+	MUX(DCLK_LCDC0, "dclk_lcdc0", mux_rk3066_lcdc0_p, 0,
+			RK2928_CLKSEL_CON(27), 4, 1, MFLAGS),
+	COMPOSITE(0, "dclk_lcdc1_src", mux_pll_src_cpll_gpll_p, 0,
+			RK2928_CLKSEL_CON(28), 0, 1, MFLAGS, 8, 8, DFLAGS,
+			RK2928_CLKGATE_CON(3), 2, GFLAGS),
+	MUX(DCLK_LCDC1, "dclk_lcdc1", mux_rk3066_lcdc1_p, 0,
+			RK2928_CLKSEL_CON(28), 4, 1, MFLAGS),
+
+	COMPOSITE_NOMUX(0, "cif1_pre", "cif_src", 0,
+			RK2928_CLKSEL_CON(29), 8, 5, DFLAGS,
+			RK2928_CLKGATE_CON(3), 8, GFLAGS),
+	MUX(SCLK_CIF1, "sclk_cif1", mux_sclk_cif1_p, 0,
+			RK2928_CLKSEL_CON(29), 15, 1, MFLAGS),
+
+	GATE(0, "pclkin_cif1", "ext_cif1", 0,
+			RK2928_CLKGATE_CON(3), 4, GFLAGS),
+
+	COMPOSITE(0, "aclk_gpu_src", mux_pll_src_cpll_gpll_p, 0,
+			RK2928_CLKSEL_CON(33), 8, 1, MFLAGS, 0, 5, DFLAGS,
+			RK2928_CLKGATE_CON(3), 13, GFLAGS),
+	GATE(ACLK_GPU, "aclk_gpu", "aclk_gpu_src", 0,
+			RK2928_CLKGATE_CON(5), 15, GFLAGS),
+
+	GATE(SCLK_TIMER2, "timer2", "xin24m", 0,
+			RK2928_CLKGATE_CON(3), 2, GFLAGS),
+
+	COMPOSITE_NOMUX(0, "sclk_tsadc", "xin24m", 0,
+			RK2928_CLKSEL_CON(34), 0, 16, DFLAGS,
+			RK2928_CLKGATE_CON(2), 15, GFLAGS),
+
+	MUX(0, "i2s_src", mux_pll_src_gpll_cpll_p, 0,
+			RK2928_CLKSEL_CON(2), 15, 1, MFLAGS),
+	COMPOSITE_NOMUX(0, "i2s0_pre", "i2s_src", 0,
+			RK2928_CLKSEL_CON(2), 0, 7, DFLAGS,
+			RK2928_CLKGATE_CON(0), 7, GFLAGS),
+	COMPOSITE_FRAC(0, "i2s0_frac", "i2s0_pre", 0,
+			RK2928_CLKSEL_CON(6), 0,
+			RK2928_CLKGATE_CON(0), 8, GFLAGS),
+	MUX(SCLK_I2S0, "sclk_i2s0", mux_sclk_i2s0_p, 0,
+			RK2928_CLKSEL_CON(2), 8, 2, MFLAGS),
+	COMPOSITE_NOMUX(0, "i2s1_pre", "i2s_src", 0,
+			RK2928_CLKSEL_CON(3), 0, 7, DFLAGS,
+			RK2928_CLKGATE_CON(0), 9, GFLAGS),
+	COMPOSITE_FRAC(0, "i2s1_frac", "i2s1_pre", 0,
+			RK2928_CLKSEL_CON(7), 0,
+			RK2928_CLKGATE_CON(0), 10, GFLAGS),
+	MUX(SCLK_I2S1, "sclk_i2s1", mux_sclk_i2s1_p, 0,
+			RK2928_CLKSEL_CON(3), 8, 2, MFLAGS),
+	COMPOSITE_NOMUX(0, "i2s2_pre", "i2s_src", 0,
+			RK2928_CLKSEL_CON(4), 0, 7, DFLAGS,
+			RK2928_CLKGATE_CON(0), 11, GFLAGS),
+	COMPOSITE_FRAC(0, "i2s2_frac", "i2s2_pre", 0,
+			RK2928_CLKSEL_CON(8), 0,
+			RK2928_CLKGATE_CON(0), 12, GFLAGS),
+	MUX(SCLK_I2S2, "sclk_i2s2", mux_sclk_i2s2_p, 0,
+			RK2928_CLKSEL_CON(4), 8, 2, MFLAGS),
+	COMPOSITE_NOMUX(0, "spdif_pre", "i2s_src", 0,
+			RK2928_CLKSEL_CON(5), 0, 7, DFLAGS,
+			RK2928_CLKGATE_CON(0), 13, GFLAGS),
+	COMPOSITE_FRAC(0, "spdif_frac", "spdif_pll", 0,
+			RK2928_CLKSEL_CON(9), 0,
+			RK2928_CLKGATE_CON(0), 14, GFLAGS),
+	MUX(SCLK_SPDIF, "sclk_spdif", mux_sclk_spdif_p, 0,
+			RK2928_CLKSEL_CON(5), 8, 2, MFLAGS),
+
+	GATE(HCLK_I2S1, "hclk_i2s1", "hclk_cpu", 0, RK2928_CLKGATE_CON(7), 3, GFLAGS),
+	GATE(HCLK_I2S2, "hclk_i2s2", "hclk_cpu", 0, RK2928_CLKGATE_CON(7), 4, GFLAGS),
+	GATE(0, "hclk_cif1", "hclk_cpu", 0, RK2928_CLKGATE_CON(6), 6, GFLAGS),
+	GATE(0, "hclk_hdmi", "hclk_cpu", 0, RK2928_CLKGATE_CON(4), 14, GFLAGS),
+
+	GATE(HCLK_OTG1, "hclk_usbotg1", "hclk_peri", 0, RK2928_CLKGATE_CON(5), 14, GFLAGS),
+
+	GATE(0, "aclk_cif1", "aclk_vio1", 0, RK2928_CLKGATE_CON(6), 7, GFLAGS),
+
+	GATE(PCLK_TIMER1, "pclk_timer1", "pclk_cpu", 0, RK2928_CLKGATE_CON(7), 8, GFLAGS),
+	GATE(PCLK_TIMER2, "pclk_timer2", "pclk_cpu", 0, RK2928_CLKGATE_CON(7), 9, GFLAGS),
+	GATE(PCLK_GPIO6, "pclk_gpio6", "pclk_cpu", 0, RK2928_CLKGATE_CON(8), 15, GFLAGS),
+	GATE(PCLK_UART0, "pclk_uart0", "pclk_cpu", 0, RK2928_CLKGATE_CON(8), 0, GFLAGS),
+	GATE(PCLK_UART1, "pclk_uart1", "pclk_cpu", 0, RK2928_CLKGATE_CON(8), 1, GFLAGS),
+
+	GATE(PCLK_GPIO4, "pclk_gpio4", "pclk_peri", 0, RK2928_CLKGATE_CON(8), 13, GFLAGS),
+	GATE(PCLK_TSADC, "pclk_tsadc", "pclk_peri", 0, RK2928_CLKGATE_CON(4), 13, GFLAGS),
+};
+
+static struct clk_div_table div_rk3188_aclk_core_t[] = {
+	{ .val = 0, .div = 1 },
+	{ .val = 1, .div = 2 },
+	{ .val = 2, .div = 3 },
+	{ .val = 3, .div = 4 },
+	{ .val = 4, .div = 8 },
+	{ /* sentinel */ },
+};
+
+PNAME(mux_hsicphy_p)		= { "sclk_otgphy0", "sclk_otgphy1",
+				    "gpll", "cpll" };
+
+static struct rockchip_clk_branch rk3188_clk_branches[] __initdata = {
+	COMPOSITE_NOGATE(0, "armclk", mux_armclk_p, 0,
+			RK2928_CLKSEL_CON(0), 8, 1, MFLAGS, 9, 5, DFLAGS),
+	COMPOSITE_NOMUX_DIVTBL(0, "aclk_core", "armclk", 0,
+			RK2928_CLKSEL_CON(1), 3, 3, DFLAGS | CLK_DIVIDER_READ_ONLY,
+			div_rk3188_aclk_core_t, RK2928_CLKGATE_CON(0), 7, GFLAGS),
+
+	/* do not source aclk_cpu_pre from the apll, to keep complexity down */
+	COMPOSITE_NOGATE(0, "aclk_cpu_pre", mux_aclk_cpu_p, CLK_SET_RATE_NO_REPARENT,
+			RK2928_CLKSEL_CON(0), 5, 1, MFLAGS, 0, 5, DFLAGS),
+
+	GATE(CORE_L2C, "core_l2c", "armclk", 0,
+			RK2928_CLKGATE_CON(9), 4, GFLAGS),
+
+	COMPOSITE(0, "aclk_peri_pre", mux_pll_src_cpll_gpll_p, 0,
+			RK2928_CLKSEL_CON(10), 15, 1, MFLAGS, 0, 5, DFLAGS,
+			RK2928_CLKGATE_CON(2), 0, GFLAGS),
+
+	COMPOSITE(DCLK_LCDC0, "dclk_lcdc0", mux_pll_src_cpll_gpll_p, 0,
+			RK2928_CLKSEL_CON(27), 0, 1, MFLAGS, 8, 8, DFLAGS,
+			RK2928_CLKGATE_CON(3), 1, GFLAGS),
+	COMPOSITE(DCLK_LCDC1, "dclk_lcdc1", mux_pll_src_cpll_gpll_p, 0,
+			RK2928_CLKSEL_CON(28), 0, 1, MFLAGS, 8, 8, DFLAGS,
+			RK2928_CLKGATE_CON(3), 2, GFLAGS),
+
+	COMPOSITE(0, "aclk_gpu_src", mux_pll_src_cpll_gpll_p, 0,
+			RK2928_CLKSEL_CON(34), 7, 1, MFLAGS, 0, 5, DFLAGS,
+			RK2928_CLKGATE_CON(3), 15, GFLAGS),
+	GATE(ACLK_GPU, "aclk_gpu", "aclk_gpu_src", 0,
+			RK2928_CLKGATE_CON(9), 7, GFLAGS),
+
+	GATE(SCLK_TIMER2, "timer2", "xin24m", 0, RK2928_CLKGATE_CON(3), 4, GFLAGS),
+	GATE(SCLK_TIMER3, "timer3", "xin24m", 0, RK2928_CLKGATE_CON(1), 2, GFLAGS),
+	GATE(SCLK_TIMER4, "timer4", "xin24m", 0, RK2928_CLKGATE_CON(3), 5, GFLAGS),
+	GATE(SCLK_TIMER5, "timer5", "xin24m", 0, RK2928_CLKGATE_CON(3), 8, GFLAGS),
+	GATE(SCLK_TIMER6, "timer6", "xin24m", 0, RK2928_CLKGATE_CON(3), 14, GFLAGS),
+
+	COMPOSITE_NODIV(0, "sclk_hsicphy_480m", mux_hsicphy_p, 0,
+			RK2928_CLKSEL_CON(30), 0, 2, DFLAGS,
+			RK2928_CLKGATE_CON(3), 6, GFLAGS),
+	DIV(0, "sclk_hsicphy_12m", "sclk_hsicphy_480m", 0,
+			RK2928_CLKGATE_CON(11), 8, 6, DFLAGS),
+
+	MUX(0, "i2s_src", mux_pll_src_gpll_cpll_p, 0,
+			RK2928_CLKSEL_CON(2), 15, 1, MFLAGS),
+	COMPOSITE_NOMUX(0, "i2s0_pre", "i2s_src", 0,
+			RK2928_CLKSEL_CON(3), 0, 7, DFLAGS,
+			RK2928_CLKGATE_CON(0), 9, GFLAGS),
+	COMPOSITE_FRAC(0, "i2s0_frac", "i2s0_pre", 0,
+			RK2928_CLKSEL_CON(7), 0,
+			RK2928_CLKGATE_CON(0), 10, GFLAGS),
+	MUX(SCLK_I2S0, "sclk_i2s0", mux_sclk_i2s0_p, 0,
+			RK2928_CLKSEL_CON(3), 8, 2, MFLAGS),
+	COMPOSITE_NOMUX(0, "spdif_pre", "i2s_src", 0,
+			RK2928_CLKSEL_CON(5), 0, 7, DFLAGS,
+			RK2928_CLKGATE_CON(13), 13, GFLAGS),
+	COMPOSITE_FRAC(0, "spdif_frac", "spdif_pll", 0,
+			RK2928_CLKSEL_CON(9), 0,
+			RK2928_CLKGATE_CON(0), 14, GFLAGS),
+	MUX(SCLK_SPDIF, "sclk_spdif", mux_sclk_spdif_p, 0,
+			RK2928_CLKSEL_CON(5), 8, 2, MFLAGS),
+
+	GATE(0, "hclk_imem0", "hclk_cpu", 0, RK2928_CLKGATE_CON(4), 14, GFLAGS),
+	GATE(0, "hclk_imem1", "hclk_cpu", 0, RK2928_CLKGATE_CON(4), 15, GFLAGS),
+
+	GATE(HCLK_OTG1, "hclk_usbotg1", "hclk_peri", 0, RK2928_CLKGATE_CON(7), 3, GFLAGS),
+	GATE(HCLK_HSIC, "hclk_hsic", "hclk_peri", 0, RK2928_CLKGATE_CON(7), 4, GFLAGS),
+
+	GATE(PCLK_TIMER3, "pclk_timer3", "pclk_cpu", 0, RK2928_CLKGATE_CON(7), 9, GFLAGS),
+
+	GATE(PCLK_UART0, "pclk_uart0", "hclk_ahb2apb", 0, RK2928_CLKGATE_CON(8), 0, GFLAGS),
+	GATE(PCLK_UART1, "pclk_uart1", "hclk_ahb2apb", 0, RK2928_CLKGATE_CON(8), 1, GFLAGS),
+
+	GATE(ACLK_GPS, "aclk_gps", "aclk_peri", 0, RK2928_CLKGATE_CON(8), 13, GFLAGS),
+};
+
+static void __init rk3188_common_clk_init(struct device_node *np)
+{
+	void __iomem *reg_base;
+	struct clk *clk;
+
+	reg_base = of_iomap(np, 0);
+	if (!reg_base) {
+		pr_err("%s: could not map cru region\n", __func__);
+		return;
+	}
+
+	rockchip_clk_init(np, reg_base, CLK_NR_CLKS);
+
+	/* xin12m is created by an cru-internal divider */
+	clk = clk_register_fixed_factor(NULL, "xin12m", "xin24m", 0, 1, 2);
+	if (IS_ERR(clk))
+		pr_warn("%s: could not register clock xin12m: %ld\n",
+			__func__, PTR_ERR(clk));
+
+	clk = clk_register_fixed_factor(NULL, "usb480m", "xin24m", 0, 20, 1);
+	if (IS_ERR(clk))
+		pr_warn("%s: could not register clock usb480m: %ld\n",
+			__func__, PTR_ERR(clk));
+
+	rockchip_clk_register_plls(rk3188_pll_clks,
+				   ARRAY_SIZE(rk3188_pll_clks),
+				   RK3188_GRF_SOC_STATUS);
+	rockchip_clk_register_branches(common_clk_branches,
+				  ARRAY_SIZE(common_clk_branches));
+
+	rockchip_register_softrst(np, 9, reg_base + RK2928_SOFTRST_CON(0),
+				  ROCKCHIP_SOFTRST_HIWORD_MASK);
+}
+
+static void __init rk3066a_clk_init(struct device_node *np)
+{
+	rk3188_common_clk_init(np);
+	rockchip_clk_register_branches(rk3066a_clk_branches,
+				  ARRAY_SIZE(rk3066a_clk_branches));
+}
+CLK_OF_DECLARE(rk3066a_cru, "rockchip,rk3066a-cru", rk3066a_clk_init);
+
+static void __init rk3188a_clk_init(struct device_node *np)
+{
+	rk3188_common_clk_init(np);
+	rockchip_clk_register_branches(rk3188_clk_branches,
+				  ARRAY_SIZE(rk3188_clk_branches));
+}
+CLK_OF_DECLARE(rk3188a_cru, "rockchip,rk3188a-cru", rk3188a_clk_init);
+
+static void __init rk3188_clk_init(struct device_node *np)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(rk3188_pll_clks); i++) {
+		struct rockchip_pll_clock *pll = &rk3188_pll_clks[i];
+		struct rockchip_pll_rate_table *rate;
+
+		if (!pll->rate_table)
+			continue;
+
+		rate = pll->rate_table;
+		while (rate->rate > 0) {
+			rate->bwadj = 0;
+			rate++;
+		}
+	}
+
+	rk3188a_clk_init(np);
+}
+CLK_OF_DECLARE(rk3188_cru, "rockchip,rk3188-cru", rk3188_clk_init);
diff --git a/include/dt-bindings/clock/rk3066a-cru.h b/include/dt-bindings/clock/rk3066a-cru.h
new file mode 100644
index 0000000..bc1ed1d
--- /dev/null
+++ b/include/dt-bindings/clock/rk3066a-cru.h
@@ -0,0 +1,35 @@
+/*
+ * Copyright (c) 2014 MundoReader S.L.
+ * Author: Heiko Stuebner <heiko@sntech.de>
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
+#include <dt-bindings/clock/rk3188-cru-common.h>
+
+/* soft-reset indices */
+#define SRST_SRST1		0
+#define SRST_SRST2		1
+
+#define SRST_L2MEM		18
+#define SRST_I2S0		23
+#define SRST_I2S1		24
+#define SRST_I2S2		25
+#define SRST_TIMER2		29
+
+#define SRST_GPIO4		36
+#define SRST_GPIO6		38
+
+#define SRST_TSADC		92
+
+#define SRST_HDMI		96
+#define SRST_HDMI_APB		97
+#define SRST_CIF1		111
diff --git a/include/dt-bindings/clock/rk3188-cru-common.h b/include/dt-bindings/clock/rk3188-cru-common.h
new file mode 100644
index 0000000..750ee60
--- /dev/null
+++ b/include/dt-bindings/clock/rk3188-cru-common.h
@@ -0,0 +1,249 @@
+/*
+ * Copyright (c) 2014 MundoReader S.L.
+ * Author: Heiko Stuebner <heiko@sntech.de>
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
+/* core clocks from */
+#define PLL_APLL		1
+#define PLL_DPLL		2
+#define PLL_CPLL		3
+#define PLL_GPLL		4
+#define CORE_PERI		5
+#define CORE_L2C		6
+
+/* sclk gates (special clocks) */
+#define SCLK_UART0		64
+#define SCLK_UART1		65
+#define SCLK_UART2		66
+#define SCLK_UART3		67
+#define SCLK_MAC		68
+#define SCLK_SPI0		69
+#define SCLK_SPI1		70
+#define SCLK_SARADC		71
+#define SCLK_SDMMC		72
+#define SCLK_SDIO		73
+#define SCLK_EMMC		74
+#define SCLK_I2S0		75
+#define SCLK_I2S1		76
+#define SCLK_I2S2		77
+#define SCLK_SPDIF		78
+#define SCLK_CIF0		79
+#define SCLK_CIF1		80
+#define SCLK_OTGPHY0		81
+#define SCLK_OTGPHY1		82
+#define SCLK_HSADC		83
+#define SCLK_TIMER0		84
+#define SCLK_TIMER1		85
+#define SCLK_TIMER2		86
+#define SCLK_TIMER3		87
+#define SCLK_TIMER4		88
+#define SCLK_TIMER5		89
+#define SCLK_TIMER6		90
+#define SCLK_JTAG		91
+#define SCLK_SMC		92
+
+#define DCLK_LCDC0		190
+#define DCLK_LCDC1		191
+
+/* aclk gates */
+#define ACLK_DMA1		192
+#define ACLK_DMA2		193
+#define ACLK_GPS		194
+#define ACLK_LCDC0		195
+#define ACLK_LCDC1		196
+#define ACLK_GPU		197
+#define ACLK_SMC		198
+#define ACLK_CIF		199
+#define ACLK_IPP		200
+#define ACLK_RGA		201
+#define ACLK_CIF0		202
+
+/* pclk gates */
+#define PCLK_GRF		320
+#define PCLK_PMU		321
+#define PCLK_TIMER0		322
+#define PCLK_TIMER1		323
+#define PCLK_TIMER2		324
+#define PCLK_TIMER3		325
+#define PCLK_PWM01		326
+#define PCLK_PWM23		327
+#define PCLK_SPI0		328
+#define PCLK_SPI1		329
+#define PCLK_SARADC		330
+#define PCLK_WDT		331
+#define PCLK_UART0		332
+#define PCLK_UART1		333
+#define PCLK_UART2		334
+#define PCLK_UART3		335
+#define PCLK_I2C0		336
+#define PCLK_I2C1		337
+#define PCLK_I2C2		338
+#define PCLK_I2C3		339
+#define PCLK_I2C4		340
+#define PCLK_GPIO0		341
+#define PCLK_GPIO1		342
+#define PCLK_GPIO2		343
+#define PCLK_GPIO3		344
+#define PCLK_GPIO4		345
+#define PCLK_GPIO6		346
+#define PCLK_EFUSE		347
+#define PCLK_TZPC		348
+#define PCLK_TSADC		349
+
+/* hclk gates */
+#define HCLK_SDMMC		448
+#define HCLK_SDIO		449
+#define HCLK_EMMC		450
+#define HCLK_OTG0		451
+#define HCLK_EMAC		452
+#define HCLK_SPDIF		453
+#define HCLK_I2S0		454
+#define HCLK_I2S1		455
+#define HCLK_I2S2		456
+#define HCLK_OTG1		457
+#define HCLK_HSIC		458
+#define HCLK_HSADC		459
+#define HCLK_PIDF		460
+#define HCLK_LCDC0		461
+#define HCLK_LCDC1		462
+#define HCLK_ROM		463
+#define HCLK_CIF0		464
+#define HCLK_IPP		465
+#define HCLK_RGA		466
+#define HCLK_NANDC0		467
+
+#define CLK_NR_CLKS		(HCLK_NANDC0 + 1)
+
+/* soft-reset indices */
+#define SRST_MCORE		2
+#define SRST_CORE0		3
+#define SRST_CORE1		4
+#define SRST_MCORE_DBG		7
+#define SRST_CORE0_DBG		8
+#define SRST_CORE1_DBG		9
+#define SRST_CORE0_WDT		12
+#define SRST_CORE1_WDT		13
+#define SRST_STRC_SYS		14
+#define SRST_L2C		15
+
+#define SRST_CPU_AHB		17
+#define SRST_AHB2APB		19
+#define SRST_DMA1		20
+#define SRST_INTMEM		21
+#define SRST_ROM		22
+#define SRST_SPDIF		26
+#define SRST_TIMER0		27
+#define SRST_TIMER1		28
+#define SRST_EFUSE		30
+
+#define SRST_GPIO0		32
+#define SRST_GPIO1		33
+#define SRST_GPIO2		34
+#define SRST_GPIO3		35
+
+#define SRST_UART0		39
+#define SRST_UART1		40
+#define SRST_UART2		41
+#define SRST_UART3		42
+#define SRST_I2C0		43
+#define SRST_I2C1		44
+#define SRST_I2C2		45
+#define SRST_I2C3		46
+#define SRST_I2C4		47
+
+#define SRST_PWM0		48
+#define SRST_PWM1		49
+#define SRST_DAP_PO		50
+#define SRST_DAP		51
+#define SRST_DAP_SYS		52
+#define SRST_TPIU_ATB		53
+#define SRST_PMU_APB		54
+#define SRST_GRF		55
+#define SRST_PMU		56
+#define SRST_PERI_AXI		57
+#define SRST_PERI_AHB		58
+#define SRST_PERI_APB		59
+#define SRST_PERI_NIU		60
+#define SRST_CPU_PERI		61
+#define SRST_EMEM_PERI		62
+#define SRST_USB_PERI		63
+
+#define SRST_DMA2		64
+#define SRST_SMC		65
+#define SRST_MAC		66
+#define SRST_NANC0		68
+#define SRST_USBOTG0		69
+#define SRST_USBPHY0		70
+#define SRST_OTGC0		71
+#define SRST_USBOTG1		72
+#define SRST_USBPHY1		73
+#define SRST_OTGC1		74
+#define SRST_HSADC		76
+#define SRST_PIDFILTER		77
+#define SRST_DDR_MSCH		79
+
+#define SRST_TZPC		80
+#define SRST_SDMMC		81
+#define SRST_SDIO		82
+#define SRST_EMMC		83
+#define SRST_SPI0		84
+#define SRST_SPI1		85
+#define SRST_WDT		86
+#define SRST_SARADC		87
+#define SRST_DDRPHY		88
+#define SRST_DDRPHY_APB		89
+#define SRST_DDRCTL		90
+#define SRST_DDRCTL_APB		91
+#define SRST_DDRPUB		93
+
+#define SRST_VIO0_AXI		98
+#define SRST_VIO0_AHB		99
+#define SRST_LCDC0_AXI		100
+#define SRST_LCDC0_AHB		101
+#define SRST_LCDC0_DCLK		102
+#define SRST_LCDC1_AXI		103
+#define SRST_LCDC1_AHB		104
+#define SRST_LCDC1_DCLK		105
+#define SRST_IPP_AXI		106
+#define SRST_IPP_AHB		107
+#define SRST_RGA_AXI		108
+#define SRST_RGA_AHB		109
+#define SRST_CIF0		110
+
+#define SRST_VCODEC_AXI		112
+#define SRST_VCODEC_AHB		113
+#define SRST_VIO1_AXI		114
+#define SRST_VCODEC_CPU		115
+#define SRST_VCODEC_NIU		116
+#define SRST_GPU		120
+#define SRST_GPU_NIU		122
+#define SRST_TFUN_ATB		125
+#define SRST_TFUN_APB		126
+#define SRST_CTI4_APB		127
+
+#define SRST_TPIU_APB		128
+#define SRST_TRACE		129
+#define SRST_CORE_DBG		130
+#define SRST_DBG_APB		131
+#define SRST_CTI0		132
+#define SRST_CTI0_APB		133
+#define SRST_CTI1		134
+#define SRST_CTI1_APB		135
+#define SRST_PTM_CORE0		136
+#define SRST_PTM_CORE1		137
+#define SRST_PTM0		138
+#define SRST_PTM0_ATB		139
+#define SRST_PTM1		140
+#define SRST_PTM1_ATB		141
+#define SRST_CTM		142
+#define SRST_TS			143
diff --git a/include/dt-bindings/clock/rk3188-cru.h b/include/dt-bindings/clock/rk3188-cru.h
new file mode 100644
index 0000000..9fac8ed
--- /dev/null
+++ b/include/dt-bindings/clock/rk3188-cru.h
@@ -0,0 +1,51 @@
+/*
+ * Copyright (c) 2014 MundoReader S.L.
+ * Author: Heiko Stuebner <heiko@sntech.de>
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
+#include <dt-bindings/clock/rk3188-cru-common.h>
+
+/* soft-reset indices */
+#define SRST_PTM_CORE2		0
+#define SRST_PTM_CORE3		1
+#define SRST_CORE2		5
+#define SRST_CORE3		6
+#define SRST_CORE2_DBG		10
+#define SRST_CORE3_DBG		11
+
+#define SRST_TIMER2		16
+#define SRST_TIMER4		23
+#define SRST_I2S0		24
+#define SRST_TIMER5		25
+#define SRST_TIMER3		29
+#define SRST_TIMER6		31
+
+#define SRST_PTM3		36
+#define SRST_PTM3_ATB		37
+
+#define SRST_GPS		67
+#define SRST_HSICPHY		75
+#define SRST_TIMER		78
+
+#define SRST_PTM2		92
+#define SRST_CORE2_WDT		94
+#define SRST_CORE3_WDT		95
+
+#define SRST_PTM2_ATB		111
+
+#define SRST_HSIC		117
+#define SRST_CTI2		118
+#define SRST_CTI2_APB		119
+#define SRST_GPU_BRIDGE		121
+#define SRST_CTI3		123
+#define SRST_CTI3_APB		124
-- 
1.9.0
