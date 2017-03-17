From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 17 Mar 2017 18:18:38 +0100
Subject: [PATCH v2 4/6] clk: rockchip: rename RK1108 to RV1108
In-Reply-To: <20170317171840.4683-1-heiko@sntech.de>
References: <20170317171840.4683-1-heiko@sntech.de>
Message-ID: <20170317171840.4683-5-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andy Yan <andy.yan@rock-chips.com>

Rockchip finally named the SOC as RV1108, so change it.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>

[include rename in rk1108.dtsi to prevent compile errors]
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk1108.dtsi                      |   2 +-
 drivers/clk/rockchip/Makefile                      |   2 +-
 .../clk/rockchip/{clk-rk1108.c => clk-rv1108.c}    | 414 ++++++++++-----------
 drivers/clk/rockchip/clk.h                         |  28 +-
 .../clock/{rk1108-cru.h => rv1108-cru.h}           |   6 +-
 5 files changed, 226 insertions(+), 226 deletions(-)
 rename drivers/clk/rockchip/{clk-rk1108.c => clk-rv1108.c} (57%)
 rename include/dt-bindings/clock/{rk1108-cru.h => rv1108-cru.h} (97%)

diff --git a/arch/arm/boot/dts/rk1108.dtsi b/arch/arm/boot/dts/rk1108.dtsi
index 6c8fc19d0ecd..1297924db6ad 100644
--- a/arch/arm/boot/dts/rk1108.dtsi
+++ b/arch/arm/boot/dts/rk1108.dtsi
@@ -41,7 +41,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
-#include <dt-bindings/clock/rk1108-cru.h>
+#include <dt-bindings/clock/rv1108-cru.h>
 #include <dt-bindings/pinctrl/rockchip.h>
 / {
 	#address-cells = <1>;
diff --git a/drivers/clk/rockchip/Makefile b/drivers/clk/rockchip/Makefile
index 141971488f40..26b220c988b2 100644
--- a/drivers/clk/rockchip/Makefile
+++ b/drivers/clk/rockchip/Makefile
@@ -12,7 +12,7 @@ obj-y	+= clk-muxgrf.o
 obj-y	+= clk-ddr.o
 obj-$(CONFIG_RESET_CONTROLLER)	+= softrst.o
 
-obj-y	+= clk-rk1108.o
+obj-y	+= clk-rv1108.o
 obj-y	+= clk-rk3036.o
 obj-y	+= clk-rk3188.o
 obj-y	+= clk-rk3228.o
diff --git a/drivers/clk/rockchip/clk-rk1108.c b/drivers/clk/rockchip/clk-rv1108.c
similarity index 57%
rename from drivers/clk/rockchip/clk-rk1108.c
rename to drivers/clk/rockchip/clk-rv1108.c
index 92750d798e5d..7c05ab366348 100644
--- a/drivers/clk/rockchip/clk-rk1108.c
+++ b/drivers/clk/rockchip/clk-rv1108.c
@@ -18,16 +18,16 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/syscore_ops.h>
-#include <dt-bindings/clock/rk1108-cru.h>
+#include <dt-bindings/clock/rv1108-cru.h>
 #include "clk.h"
 
-#define RK1108_GRF_SOC_STATUS0	0x480
+#define RV1108_GRF_SOC_STATUS0	0x480
 
-enum rk1108_plls {
+enum rv1108_plls {
 	apll, dpll, gpll,
 };
 
-static struct rockchip_pll_rate_table rk1108_pll_rates[] = {
+static struct rockchip_pll_rate_table rv1108_pll_rates[] = {
 	/* _mhz, _refdiv, _fbdiv, _postdiv1, _postdiv2, _dsmpd, _frac */
 	RK3036_PLL_RATE(1608000000, 1, 67, 1, 1, 1, 0),
 	RK3036_PLL_RATE(1584000000, 1, 66, 1, 1, 1, 0),
@@ -74,32 +74,32 @@ static struct rockchip_pll_rate_table rk1108_pll_rates[] = {
 	{ /* sentinel */ },
 };
 
-#define RK1108_DIV_CORE_MASK		0xf
-#define RK1108_DIV_CORE_SHIFT		4
+#define RV1108_DIV_CORE_MASK		0xf
+#define RV1108_DIV_CORE_SHIFT		4
 
-#define RK1108_CLKSEL0(_core_peri_div)	\
+#define RV1108_CLKSEL0(_core_peri_div)	\
 	{				\
-		.reg = RK1108_CLKSEL_CON(1),	\
-		.val = HIWORD_UPDATE(_core_peri_div, RK1108_DIV_CORE_MASK,\
-				RK1108_DIV_CORE_SHIFT)	\
+		.reg = RV1108_CLKSEL_CON(1),	\
+		.val = HIWORD_UPDATE(_core_peri_div, RV1108_DIV_CORE_MASK,\
+				RV1108_DIV_CORE_SHIFT)	\
 	}
 
-#define RK1108_CPUCLK_RATE(_prate, _core_peri_div)			\
+#define RV1108_CPUCLK_RATE(_prate, _core_peri_div)			\
 	{								\
 		.prate = _prate,					\
 		.divs = {						\
-			RK1108_CLKSEL0(_core_peri_div),		\
+			RV1108_CLKSEL0(_core_peri_div),		\
 		},							\
 	}
 
-static struct rockchip_cpuclk_rate_table rk1108_cpuclk_rates[] __initdata = {
-	RK1108_CPUCLK_RATE(816000000, 4),
-	RK1108_CPUCLK_RATE(600000000, 4),
-	RK1108_CPUCLK_RATE(312000000, 4),
+static struct rockchip_cpuclk_rate_table rv1108_cpuclk_rates[] __initdata = {
+	RV1108_CPUCLK_RATE(816000000, 4),
+	RV1108_CPUCLK_RATE(600000000, 4),
+	RV1108_CPUCLK_RATE(312000000, 4),
 };
 
-static const struct rockchip_cpuclk_reg_data rk1108_cpuclk_data = {
-	.core_reg = RK1108_CLKSEL_CON(0),
+static const struct rockchip_cpuclk_reg_data rv1108_cpuclk_data = {
+	.core_reg = RV1108_CLKSEL_CON(0),
 	.div_core_shift = 0,
 	.div_core_mask = 0x1f,
 	.mux_core_alt = 1,
@@ -131,13 +131,13 @@ PNAME(mux_i2s_out_p)		= { "i2s0_pre", "xin12m" };
 PNAME(mux_i2s1_p)		= { "i2s1_src", "i2s1_frac", "xin12m" };
 PNAME(mux_i2s2_p)		= { "i2s2_src", "i2s2_frac", "xin12m" };
 
-static struct rockchip_pll_clock rk1108_pll_clks[] __initdata = {
-	[apll] = PLL(pll_rk3399, PLL_APLL, "apll", mux_pll_p, 0, RK1108_PLL_CON(0),
-		     RK1108_PLL_CON(3), 8, 31, 0, rk1108_pll_rates),
-	[dpll] = PLL(pll_rk3399, PLL_DPLL, "dpll", mux_pll_p, 0, RK1108_PLL_CON(8),
-		     RK1108_PLL_CON(11), 8, 31, 0, NULL),
-	[gpll] = PLL(pll_rk3399, PLL_GPLL, "gpll", mux_pll_p, 0, RK1108_PLL_CON(16),
-		     RK1108_PLL_CON(19), 8, 31, ROCKCHIP_PLL_SYNC_RATE, rk1108_pll_rates),
+static struct rockchip_pll_clock rv1108_pll_clks[] __initdata = {
+	[apll] = PLL(pll_rk3399, PLL_APLL, "apll", mux_pll_p, 0, RV1108_PLL_CON(0),
+		     RV1108_PLL_CON(3), 8, 31, 0, rv1108_pll_rates),
+	[dpll] = PLL(pll_rk3399, PLL_DPLL, "dpll", mux_pll_p, 0, RV1108_PLL_CON(8),
+		     RV1108_PLL_CON(11), 8, 31, 0, NULL),
+	[gpll] = PLL(pll_rk3399, PLL_GPLL, "gpll", mux_pll_p, 0, RV1108_PLL_CON(16),
+		     RV1108_PLL_CON(19), 8, 31, ROCKCHIP_PLL_SYNC_RATE, rv1108_pll_rates),
 };
 
 #define MFLAGS CLK_MUX_HIWORD_MASK
@@ -145,56 +145,56 @@ static struct rockchip_pll_clock rk1108_pll_clks[] __initdata = {
 #define GFLAGS (CLK_GATE_HIWORD_MASK | CLK_GATE_SET_TO_DISABLE)
 #define IFLAGS ROCKCHIP_INVERTER_HIWORD_MASK
 
-static struct rockchip_clk_branch rk1108_uart0_fracmux __initdata =
+static struct rockchip_clk_branch rv1108_uart0_fracmux __initdata =
 	MUX(SCLK_UART0, "sclk_uart0", mux_uart0_p, CLK_SET_RATE_PARENT,
-			RK1108_CLKSEL_CON(13), 8, 2, MFLAGS);
+			RV1108_CLKSEL_CON(13), 8, 2, MFLAGS);
 
-static struct rockchip_clk_branch rk1108_uart1_fracmux __initdata =
+static struct rockchip_clk_branch rv1108_uart1_fracmux __initdata =
 	MUX(SCLK_UART1, "sclk_uart1", mux_uart1_p, CLK_SET_RATE_PARENT,
-			RK1108_CLKSEL_CON(14), 8, 2, MFLAGS);
+			RV1108_CLKSEL_CON(14), 8, 2, MFLAGS);
 
-static struct rockchip_clk_branch rk1108_uart2_fracmux __initdata =
+static struct rockchip_clk_branch rv1108_uart2_fracmux __initdata =
 	MUX(SCLK_UART2, "sclk_uart2", mux_uart2_p, CLK_SET_RATE_PARENT,
-			RK1108_CLKSEL_CON(15), 8, 2, MFLAGS);
+			RV1108_CLKSEL_CON(15), 8, 2, MFLAGS);
 
-static struct rockchip_clk_branch rk1108_i2s0_fracmux __initdata =
+static struct rockchip_clk_branch rv1108_i2s0_fracmux __initdata =
 	MUX(0, "i2s0_pre", mux_i2s0_pre_p, CLK_SET_RATE_PARENT,
-			RK1108_CLKSEL_CON(5), 12, 2, MFLAGS);
+			RV1108_CLKSEL_CON(5), 12, 2, MFLAGS);
 
-static struct rockchip_clk_branch rk1108_i2s1_fracmux __initdata =
+static struct rockchip_clk_branch rv1108_i2s1_fracmux __initdata =
 	MUX(0, "i2s1_pre", mux_i2s1_p, CLK_SET_RATE_PARENT,
-			RK1108_CLKSEL_CON(6), 12, 2, MFLAGS);
+			RV1108_CLKSEL_CON(6), 12, 2, MFLAGS);
 
-static struct rockchip_clk_branch rk1108_i2s2_fracmux __initdata =
+static struct rockchip_clk_branch rv1108_i2s2_fracmux __initdata =
 	MUX(0, "i2s2_pre", mux_i2s2_p, CLK_SET_RATE_PARENT,
-			RK1108_CLKSEL_CON(7), 12, 2, MFLAGS);
+			RV1108_CLKSEL_CON(7), 12, 2, MFLAGS);
 
-static struct rockchip_clk_branch rk1108_clk_branches[] __initdata = {
+static struct rockchip_clk_branch rv1108_clk_branches[] __initdata = {
 	MUX(0, "hdmi_phy", mux_hdmiphy_phy_p, CLK_SET_RATE_PARENT,
-			RK1108_MISC_CON, 13, 2, MFLAGS),
+			RV1108_MISC_CON, 13, 2, MFLAGS),
 	MUX(0, "usb480m", mux_usb480m_pre_p, CLK_SET_RATE_PARENT,
-			RK1108_MISC_CON, 15, 2, MFLAGS),
+			RV1108_MISC_CON, 15, 2, MFLAGS),
 	/*
 	 * Clock-Architecture Diagram 2
 	 */
 
 	/* PD_CORE */
 	GATE(0, "dpll_core", "dpll", CLK_IGNORE_UNUSED,
-			RK1108_CLKGATE_CON(0), 1, GFLAGS),
+			RV1108_CLKGATE_CON(0), 1, GFLAGS),
 	GATE(0, "apll_core", "apll", CLK_IGNORE_UNUSED,
-			RK1108_CLKGATE_CON(0), 0, GFLAGS),
+			RV1108_CLKGATE_CON(0), 0, GFLAGS),
 	GATE(0, "gpll_core", "gpll", CLK_IGNORE_UNUSED,
-			RK1108_CLKGATE_CON(0), 2, GFLAGS),
+			RV1108_CLKGATE_CON(0), 2, GFLAGS),
 	COMPOSITE_NOMUX(0, "pclken_dbg", "armclk", CLK_IGNORE_UNUSED,
-			RK1108_CLKSEL_CON(1), 4, 4, DFLAGS | CLK_DIVIDER_READ_ONLY,
-			RK1108_CLKGATE_CON(0), 5, GFLAGS),
+			RV1108_CLKSEL_CON(1), 4, 4, DFLAGS | CLK_DIVIDER_READ_ONLY,
+			RV1108_CLKGATE_CON(0), 5, GFLAGS),
 	COMPOSITE_NOMUX(ACLK_ENMCORE, "aclkenm_core", "armclk", CLK_IGNORE_UNUSED,
-			RK1108_CLKSEL_CON(1), 0, 3, DFLAGS | CLK_DIVIDER_READ_ONLY,
-			RK1108_CLKGATE_CON(0), 4, GFLAGS),
+			RV1108_CLKSEL_CON(1), 0, 3, DFLAGS | CLK_DIVIDER_READ_ONLY,
+			RV1108_CLKGATE_CON(0), 4, GFLAGS),
 	GATE(ACLK_CORE, "aclk_core", "aclkenm_core", CLK_IGNORE_UNUSED,
-			RK1108_CLKGATE_CON(11), 0, GFLAGS),
+			RV1108_CLKGATE_CON(11), 0, GFLAGS),
 	GATE(0, "pclk_dbg", "pclken_dbg", CLK_IGNORE_UNUSED,
-			RK1108_CLKGATE_CON(11), 1, GFLAGS),
+			RV1108_CLKGATE_CON(11), 1, GFLAGS),
 
 	/* PD_RKVENC */
 
@@ -202,58 +202,58 @@ static struct rockchip_clk_branch rk1108_clk_branches[] __initdata = {
 
 	/* PD_PMU_wrapper */
 	COMPOSITE_NOMUX(0, "pmu_24m_ena", "gpll", CLK_IGNORE_UNUSED,
-			RK1108_CLKSEL_CON(38), 0, 5, DFLAGS,
-			RK1108_CLKGATE_CON(8), 12, GFLAGS),
+			RV1108_CLKSEL_CON(38), 0, 5, DFLAGS,
+			RV1108_CLKGATE_CON(8), 12, GFLAGS),
 	GATE(0, "pmu", "pmu_24m_ena", CLK_IGNORE_UNUSED,
-			RK1108_CLKGATE_CON(10), 0, GFLAGS),
+			RV1108_CLKGATE_CON(10), 0, GFLAGS),
 	GATE(0, "intmem1", "pmu_24m_ena", CLK_IGNORE_UNUSED,
-			RK1108_CLKGATE_CON(10), 1, GFLAGS),
+			RV1108_CLKGATE_CON(10), 1, GFLAGS),
 	GATE(0, "gpio0_pmu", "pmu_24m_ena", CLK_IGNORE_UNUSED,
-			RK1108_CLKGATE_CON(10), 2, GFLAGS),
+			RV1108_CLKGATE_CON(10), 2, GFLAGS),
 	GATE(0, "pmugrf", "pmu_24m_ena", CLK_IGNORE_UNUSED,
-			RK1108_CLKGATE_CON(10), 3, GFLAGS),
+			RV1108_CLKGATE_CON(10), 3, GFLAGS),
 	GATE(0, "pmu_noc", "pmu_24m_ena", CLK_IGNORE_UNUSED,
-			RK1108_CLKGATE_CON(10), 4, GFLAGS),
+			RV1108_CLKGATE_CON(10), 4, GFLAGS),
 	GATE(0, "i2c0_pmu_pclk", "pmu_24m_ena", CLK_IGNORE_UNUSED,
-			RK1108_CLKGATE_CON(10), 5, GFLAGS),
+			RV1108_CLKGATE_CON(10), 5, GFLAGS),
 	GATE(0, "pwm0_pmu_pclk", "pmu_24m_ena", CLK_IGNORE_UNUSED,
-			RK1108_CLKGATE_CON(10), 6, GFLAGS),
+			RV1108_CLKGATE_CON(10), 6, GFLAGS),
 	COMPOSITE(0, "pwm0_pmu_clk", mux_pll_src_2plls_p, CLK_IGNORE_UNUSED,
-			RK1108_CLKSEL_CON(12), 7, 1, MFLAGS, 0, 7, DFLAGS,
-			RK1108_CLKGATE_CON(8), 15, GFLAGS),
+			RV1108_CLKSEL_CON(12), 7, 1, MFLAGS, 0, 7, DFLAGS,
+			RV1108_CLKGATE_CON(8), 15, GFLAGS),
 	COMPOSITE(0, "i2c0_pmu_clk", mux_pll_src_2plls_p, CLK_IGNORE_UNUSED,
-			RK1108_CLKSEL_CON(19), 7, 1, MFLAGS, 0, 7, DFLAGS,
-			RK1108_CLKGATE_CON(8), 14, GFLAGS),
+			RV1108_CLKSEL_CON(19), 7, 1, MFLAGS, 0, 7, DFLAGS,
+			RV1108_CLKGATE_CON(8), 14, GFLAGS),
 	GATE(0, "pvtm_pmu", "xin24m", CLK_IGNORE_UNUSED,
-			RK1108_CLKGATE_CON(8), 13, GFLAGS),
+			RV1108_CLKGATE_CON(8), 13, GFLAGS),
 
 	/*
 	 * Clock-Architecture Diagram 4
 	 */
 	COMPOSITE(0, "aclk_vio0_2wrap_occ", mux_pll_src_4plls_p, CLK_IGNORE_UNUSED,
-			RK1108_CLKSEL_CON(28), 6, 2, MFLAGS, 0, 5, DFLAGS,
-			RK1108_CLKGATE_CON(6), 0, GFLAGS),
+			RV1108_CLKSEL_CON(28), 6, 2, MFLAGS, 0, 5, DFLAGS,
+			RV1108_CLKGATE_CON(6), 0, GFLAGS),
 	GATE(0, "aclk_vio0_pre", "aclk_vio0_2wrap_occ", CLK_IGNORE_UNUSED,
-			RK1108_CLKGATE_CON(17), 0, GFLAGS),
+			RV1108_CLKGATE_CON(17), 0, GFLAGS),
 	COMPOSITE_NOMUX(0, "hclk_vio_pre", "aclk_vio0_pre", 0,
-			RK1108_CLKSEL_CON(29), 0, 5, DFLAGS,
-			RK1108_CLKGATE_CON(7), 2, GFLAGS),
+			RV1108_CLKSEL_CON(29), 0, 5, DFLAGS,
+			RV1108_CLKGATE_CON(7), 2, GFLAGS),
 	COMPOSITE_NOMUX(0, "pclk_vio_pre", "aclk_vio0_pre", 0,
-			RK1108_CLKSEL_CON(29), 8, 5, DFLAGS,
-			RK1108_CLKGATE_CON(7), 3, GFLAGS),
+			RV1108_CLKSEL_CON(29), 8, 5, DFLAGS,
+			RV1108_CLKGATE_CON(7), 3, GFLAGS),
 
 	INVERTER(0, "pclk_vip", "ext_vip",
-			RK1108_CLKSEL_CON(31), 8, IFLAGS),
+			RV1108_CLKSEL_CON(31), 8, IFLAGS),
 	GATE(0, "pclk_isp_pre", "pclk_vip", CLK_IGNORE_UNUSED,
-			RK1108_CLKGATE_CON(7), 6, GFLAGS),
+			RV1108_CLKGATE_CON(7), 6, GFLAGS),
 	GATE(0, "pclk_isp", "pclk_isp_pre", CLK_IGNORE_UNUSED,
-			RK1108_CLKGATE_CON(18), 10, GFLAGS),
+			RV1108_CLKGATE_CON(18), 10, GFLAGS),
 	GATE(0, "dclk_hdmiphy_src_gpll", "gpll", CLK_IGNORE_UNUSED,
-			RK1108_CLKGATE_CON(6), 5, GFLAGS),
+			RV1108_CLKGATE_CON(6), 5, GFLAGS),
 	GATE(0, "dclk_hdmiphy_src_dpll", "dpll", CLK_IGNORE_UNUSED,
-			RK1108_CLKGATE_CON(6), 4, GFLAGS),
+			RV1108_CLKGATE_CON(6), 4, GFLAGS),
 	COMPOSITE_NOGATE(0, "dclk_hdmiphy", mux_dclk_hdmiphy_pre_p, 0,
-			RK1108_CLKSEL_CON(32), 6, 2, MFLAGS, 8, 6, DFLAGS),
+			RV1108_CLKSEL_CON(32), 6, 2, MFLAGS, 8, 6, DFLAGS),
 
 	/*
 	 * Clock-Architecture Diagram 5
@@ -262,153 +262,153 @@ static struct rockchip_clk_branch rk1108_clk_branches[] __initdata = {
 	FACTOR(0, "xin12m", "xin24m", 0, 1, 2),
 
 	COMPOSITE(0, "i2s0_src", mux_pll_src_2plls_p, 0,
-			RK1108_CLKSEL_CON(5), 8, 1, MFLAGS, 0, 7, DFLAGS,
-			RK1108_CLKGATE_CON(2), 0, GFLAGS),
+			RV1108_CLKSEL_CON(5), 8, 1, MFLAGS, 0, 7, DFLAGS,
+			RV1108_CLKGATE_CON(2), 0, GFLAGS),
 	COMPOSITE_FRACMUX(0, "i2s1_frac", "i2s1_src", CLK_SET_RATE_PARENT,
-			RK1108_CLKSEL_CON(8), 0,
-			RK1108_CLKGATE_CON(2), 1, GFLAGS,
-			&rk1108_i2s0_fracmux),
+			RV1108_CLKSEL_CON(8), 0,
+			RV1108_CLKGATE_CON(2), 1, GFLAGS,
+			&rv1108_i2s0_fracmux),
 	GATE(SCLK_I2S0, "sclk_i2s0", "i2s0_pre", CLK_SET_RATE_PARENT,
-			RK1108_CLKGATE_CON(2), 2, GFLAGS),
+			RV1108_CLKGATE_CON(2), 2, GFLAGS),
 	COMPOSITE_NODIV(0, "i2s_out", mux_i2s_out_p, 0,
-			RK1108_CLKSEL_CON(5), 15, 1, MFLAGS,
-			RK1108_CLKGATE_CON(2), 3, GFLAGS),
+			RV1108_CLKSEL_CON(5), 15, 1, MFLAGS,
+			RV1108_CLKGATE_CON(2), 3, GFLAGS),
 
 	COMPOSITE(0, "i2s1_src", mux_pll_src_2plls_p, 0,
-			RK1108_CLKSEL_CON(6), 8, 1, MFLAGS, 0, 7, DFLAGS,
-			RK1108_CLKGATE_CON(2), 4, GFLAGS),
+			RV1108_CLKSEL_CON(6), 8, 1, MFLAGS, 0, 7, DFLAGS,
+			RV1108_CLKGATE_CON(2), 4, GFLAGS),
 	COMPOSITE_FRACMUX(0, "i2s1_frac", "i2s1_src", CLK_SET_RATE_PARENT,
 			RK2928_CLKSEL_CON(9), 0,
 			RK2928_CLKGATE_CON(2), 5, GFLAGS,
-			&rk1108_i2s1_fracmux),
+			&rv1108_i2s1_fracmux),
 	GATE(SCLK_I2S1, "sclk_i2s1", "i2s1_pre", CLK_SET_RATE_PARENT,
-			RK1108_CLKGATE_CON(2), 6, GFLAGS),
+			RV1108_CLKGATE_CON(2), 6, GFLAGS),
 
 	COMPOSITE(0, "i2s2_src", mux_pll_src_2plls_p, 0,
-			RK1108_CLKSEL_CON(7), 8, 1, MFLAGS, 0, 7, DFLAGS,
-			RK1108_CLKGATE_CON(3), 8, GFLAGS),
+			RV1108_CLKSEL_CON(7), 8, 1, MFLAGS, 0, 7, DFLAGS,
+			RV1108_CLKGATE_CON(3), 8, GFLAGS),
 	COMPOSITE_FRACMUX(0, "i2s2_frac", "i2s2_src", CLK_SET_RATE_PARENT,
-			RK1108_CLKSEL_CON(10), 0,
-			RK1108_CLKGATE_CON(2), 9, GFLAGS,
-			&rk1108_i2s2_fracmux),
+			RV1108_CLKSEL_CON(10), 0,
+			RV1108_CLKGATE_CON(2), 9, GFLAGS,
+			&rv1108_i2s2_fracmux),
 	GATE(SCLK_I2S2, "sclk_i2s2", "i2s2_pre", CLK_SET_RATE_PARENT,
-			RK1108_CLKGATE_CON(2), 10, GFLAGS),
+			RV1108_CLKGATE_CON(2), 10, GFLAGS),
 
 	/* PD_BUS */
 	GATE(0, "aclk_bus_src_gpll", "gpll", CLK_IGNORE_UNUSED,
-			RK1108_CLKGATE_CON(1), 0, GFLAGS),
+			RV1108_CLKGATE_CON(1), 0, GFLAGS),
 	GATE(0, "aclk_bus_src_apll", "apll", CLK_IGNORE_UNUSED,
-			RK1108_CLKGATE_CON(1), 1, GFLAGS),
+			RV1108_CLKGATE_CON(1), 1, GFLAGS),
 	GATE(0, "aclk_bus_src_dpll", "dpll", CLK_IGNORE_UNUSED,
-			RK1108_CLKGATE_CON(1), 2, GFLAGS),
+			RV1108_CLKGATE_CON(1), 2, GFLAGS),
 	COMPOSITE_NOGATE(ACLK_PRE, "aclk_bus_pre", mux_aclk_bus_src_p, 0,
-			RK1108_CLKSEL_CON(2), 8, 2, MFLAGS, 0, 5, DFLAGS),
+			RV1108_CLKSEL_CON(2), 8, 2, MFLAGS, 0, 5, DFLAGS),
 	COMPOSITE_NOMUX(0, "hclk_bus_pre", "aclk_bus_2wrap_occ", 0,
-			RK1108_CLKSEL_CON(3), 0, 5, DFLAGS,
-			RK1108_CLKGATE_CON(1), 4, GFLAGS),
+			RV1108_CLKSEL_CON(3), 0, 5, DFLAGS,
+			RV1108_CLKGATE_CON(1), 4, GFLAGS),
 	COMPOSITE_NOMUX(0, "pclken_bus", "aclk_bus_2wrap_occ", 0,
-			RK1108_CLKSEL_CON(3), 8, 5, DFLAGS,
-			RK1108_CLKGATE_CON(1), 5, GFLAGS),
+			RV1108_CLKSEL_CON(3), 8, 5, DFLAGS,
+			RV1108_CLKGATE_CON(1), 5, GFLAGS),
 	GATE(0, "pclk_bus_pre", "pclken_bus", CLK_IGNORE_UNUSED,
-			RK1108_CLKGATE_CON(1), 6, GFLAGS),
+			RV1108_CLKGATE_CON(1), 6, GFLAGS),
 	GATE(0, "pclk_top_pre", "pclken_bus", CLK_IGNORE_UNUSED,
-			RK1108_CLKGATE_CON(1), 7, GFLAGS),
+			RV1108_CLKGATE_CON(1), 7, GFLAGS),
 	GATE(0, "pclk_ddr_pre", "pclken_bus", CLK_IGNORE_UNUSED,
-			RK1108_CLKGATE_CON(1), 8, GFLAGS),
+			RV1108_CLKGATE_CON(1), 8, GFLAGS),
 	GATE(0, "clk_timer0", "mux_pll_p", CLK_IGNORE_UNUSED,
-			RK1108_CLKGATE_CON(1), 9, GFLAGS),
+			RV1108_CLKGATE_CON(1), 9, GFLAGS),
 	GATE(0, "clk_timer1", "mux_pll_p", CLK_IGNORE_UNUSED,
-			RK1108_CLKGATE_CON(1), 10, GFLAGS),
+			RV1108_CLKGATE_CON(1), 10, GFLAGS),
 	GATE(0, "pclk_timer", "pclk_bus_pre", CLK_IGNORE_UNUSED,
-			RK1108_CLKGATE_CON(13), 4, GFLAGS),
+			RV1108_CLKGATE_CON(13), 4, GFLAGS),
 
 	COMPOSITE(0, "uart0_src", mux_pll_src_dpll_gpll_usb480m_p, CLK_IGNORE_UNUSED,
-			RK1108_CLKSEL_CON(13), 12, 2, MFLAGS, 0, 7, DFLAGS,
-			RK1108_CLKGATE_CON(3), 1, GFLAGS),
+			RV1108_CLKSEL_CON(13), 12, 2, MFLAGS, 0, 7, DFLAGS,
+			RV1108_CLKGATE_CON(3), 1, GFLAGS),
 	COMPOSITE(0, "uart1_src", mux_pll_src_dpll_gpll_usb480m_p, CLK_IGNORE_UNUSED,
-			RK1108_CLKSEL_CON(14), 12, 2, MFLAGS, 0, 7, DFLAGS,
-			RK1108_CLKGATE_CON(3), 3, GFLAGS),
+			RV1108_CLKSEL_CON(14), 12, 2, MFLAGS, 0, 7, DFLAGS,
+			RV1108_CLKGATE_CON(3), 3, GFLAGS),
 	COMPOSITE(0, "uart21_src", mux_pll_src_dpll_gpll_usb480m_p, CLK_IGNORE_UNUSED,
-			RK1108_CLKSEL_CON(15), 12, 2, MFLAGS, 0, 7, DFLAGS,
-			RK1108_CLKGATE_CON(3), 5, GFLAGS),
+			RV1108_CLKSEL_CON(15), 12, 2, MFLAGS, 0, 7, DFLAGS,
+			RV1108_CLKGATE_CON(3), 5, GFLAGS),
 
 	COMPOSITE_FRACMUX(0, "uart0_frac", "uart0_src", CLK_SET_RATE_PARENT,
-			RK1108_CLKSEL_CON(16), 0,
-			RK1108_CLKGATE_CON(3), 2, GFLAGS,
-			&rk1108_uart0_fracmux),
+			RV1108_CLKSEL_CON(16), 0,
+			RV1108_CLKGATE_CON(3), 2, GFLAGS,
+			&rv1108_uart0_fracmux),
 	COMPOSITE_FRACMUX(0, "uart1_frac", "uart1_src", CLK_SET_RATE_PARENT,
-			RK1108_CLKSEL_CON(17), 0,
-			RK1108_CLKGATE_CON(3), 4, GFLAGS,
-			&rk1108_uart1_fracmux),
+			RV1108_CLKSEL_CON(17), 0,
+			RV1108_CLKGATE_CON(3), 4, GFLAGS,
+			&rv1108_uart1_fracmux),
 	COMPOSITE_FRACMUX(0, "uart2_frac", "uart2_src", CLK_SET_RATE_PARENT,
-			RK1108_CLKSEL_CON(18), 0,
-			RK1108_CLKGATE_CON(3), 6, GFLAGS,
-			&rk1108_uart2_fracmux),
+			RV1108_CLKSEL_CON(18), 0,
+			RV1108_CLKGATE_CON(3), 6, GFLAGS,
+			&rv1108_uart2_fracmux),
 	GATE(PCLK_UART0, "pclk_uart0", "pclk_bus_pre", CLK_IGNORE_UNUSED,
-			RK1108_CLKGATE_CON(13), 10, GFLAGS),
+			RV1108_CLKGATE_CON(13), 10, GFLAGS),
 	GATE(PCLK_UART1, "pclk_uart1", "pclk_bus_pre", CLK_IGNORE_UNUSED,
-			RK1108_CLKGATE_CON(13), 11, GFLAGS),
+			RV1108_CLKGATE_CON(13), 11, GFLAGS),
 	GATE(PCLK_UART2, "pclk_uart2", "pclk_bus_pre", CLK_IGNORE_UNUSED,
-			RK1108_CLKGATE_CON(13), 12, GFLAGS),
+			RV1108_CLKGATE_CON(13), 12, GFLAGS),
 
 	COMPOSITE(0, "clk_i2c1", mux_pll_src_2plls_p, CLK_IGNORE_UNUSED,
-			RK1108_CLKSEL_CON(19), 15, 2, MFLAGS, 8, 7, DFLAGS,
-			RK1108_CLKGATE_CON(3), 7, GFLAGS),
+			RV1108_CLKSEL_CON(19), 15, 2, MFLAGS, 8, 7, DFLAGS,
+			RV1108_CLKGATE_CON(3), 7, GFLAGS),
 	COMPOSITE(0, "clk_i2c2", mux_pll_src_2plls_p, CLK_IGNORE_UNUSED,
-			RK1108_CLKSEL_CON(20), 7, 2, MFLAGS, 0, 7, DFLAGS,
-			RK1108_CLKGATE_CON(3), 8, GFLAGS),
+			RV1108_CLKSEL_CON(20), 7, 2, MFLAGS, 0, 7, DFLAGS,
+			RV1108_CLKGATE_CON(3), 8, GFLAGS),
 	COMPOSITE(0, "clk_i2c3", mux_pll_src_2plls_p, CLK_IGNORE_UNUSED,
-			RK1108_CLKSEL_CON(20), 15, 2, MFLAGS, 8, 7, DFLAGS,
-			RK1108_CLKGATE_CON(3), 9, GFLAGS),
+			RV1108_CLKSEL_CON(20), 15, 2, MFLAGS, 8, 7, DFLAGS,
+			RV1108_CLKGATE_CON(3), 9, GFLAGS),
 	GATE(0, "pclk_i2c1", "pclk_bus_pre", CLK_IGNORE_UNUSED,
-			RK1108_CLKGATE_CON(13), 0, GFLAGS),
+			RV1108_CLKGATE_CON(13), 0, GFLAGS),
 	GATE(0, "pclk_i2c2", "pclk_bus_pre", CLK_IGNORE_UNUSED,
-			RK1108_CLKGATE_CON(13), 1, GFLAGS),
+			RV1108_CLKGATE_CON(13), 1, GFLAGS),
 	GATE(0, "pclk_i2c3", "pclk_bus_pre", CLK_IGNORE_UNUSED,
-			RK1108_CLKGATE_CON(13), 2, GFLAGS),
+			RV1108_CLKGATE_CON(13), 2, GFLAGS),
 	COMPOSITE(0, "clk_pwm1", mux_pll_src_2plls_p, CLK_IGNORE_UNUSED,
-			RK1108_CLKSEL_CON(12), 15, 2, MFLAGS, 8, 7, DFLAGS,
-			RK1108_CLKGATE_CON(3), 10, GFLAGS),
+			RV1108_CLKSEL_CON(12), 15, 2, MFLAGS, 8, 7, DFLAGS,
+			RV1108_CLKGATE_CON(3), 10, GFLAGS),
 	GATE(0, "pclk_pwm1", "pclk_bus_pre", CLK_IGNORE_UNUSED,
-			RK1108_CLKGATE_CON(13), 6, GFLAGS),
+			RV1108_CLKGATE_CON(13), 6, GFLAGS),
 	GATE(0, "pclk_wdt", "pclk_bus_pre", CLK_IGNORE_UNUSED,
-			RK1108_CLKGATE_CON(13), 3, GFLAGS),
+			RV1108_CLKGATE_CON(13), 3, GFLAGS),
 	GATE(0, "pclk_gpio1", "pclk_bus_pre", CLK_IGNORE_UNUSED,
-			RK1108_CLKGATE_CON(13), 7, GFLAGS),
+			RV1108_CLKGATE_CON(13), 7, GFLAGS),
 	GATE(0, "pclk_gpio2", "pclk_bus_pre", CLK_IGNORE_UNUSED,
-			RK1108_CLKGATE_CON(13), 8, GFLAGS),
+			RV1108_CLKGATE_CON(13), 8, GFLAGS),
 	GATE(0, "pclk_gpio3", "pclk_bus_pre", CLK_IGNORE_UNUSED,
-			RK1108_CLKGATE_CON(13), 9, GFLAGS),
+			RV1108_CLKGATE_CON(13), 9, GFLAGS),
 
 	GATE(0, "pclk_grf", "pclk_bus_pre", CLK_IGNORE_UNUSED,
-			RK1108_CLKGATE_CON(14), 0, GFLAGS),
+			RV1108_CLKGATE_CON(14), 0, GFLAGS),
 
 	GATE(ACLK_DMAC, "aclk_dmac", "aclk_bus_pre", 0,
-	     RK1108_CLKGATE_CON(12), 2, GFLAGS),
+	     RV1108_CLKGATE_CON(12), 2, GFLAGS),
 	GATE(0, "hclk_rom", "hclk_bus_pre", CLK_IGNORE_UNUSED,
-			RK1108_CLKGATE_CON(12), 3, GFLAGS),
+			RV1108_CLKGATE_CON(12), 3, GFLAGS),
 	GATE(0, "aclk_intmem", "aclk_bus_pre", CLK_IGNORE_UNUSED,
-			RK1108_CLKGATE_CON(12), 1, GFLAGS),
+			RV1108_CLKGATE_CON(12), 1, GFLAGS),
 
 	/* PD_DDR */
 	GATE(0, "apll_ddr", "apll", CLK_IGNORE_UNUSED,
-			RK1108_CLKGATE_CON(0), 8, GFLAGS),
+			RV1108_CLKGATE_CON(0), 8, GFLAGS),
 	GATE(0, "dpll_ddr", "dpll", CLK_IGNORE_UNUSED,
-			RK1108_CLKGATE_CON(0), 9, GFLAGS),
+			RV1108_CLKGATE_CON(0), 9, GFLAGS),
 	GATE(0, "gpll_ddr", "gpll", CLK_IGNORE_UNUSED,
-			RK1108_CLKGATE_CON(0), 10, GFLAGS),
+			RV1108_CLKGATE_CON(0), 10, GFLAGS),
 	COMPOSITE(0, "ddrphy4x", mux_ddrphy_p, CLK_IGNORE_UNUSED,
-			RK1108_CLKSEL_CON(4), 8, 2, MFLAGS, 0, 3,
+			RV1108_CLKSEL_CON(4), 8, 2, MFLAGS, 0, 3,
 			DFLAGS | CLK_DIVIDER_POWER_OF_TWO,
-			RK1108_CLKGATE_CON(10), 9, GFLAGS),
+			RV1108_CLKGATE_CON(10), 9, GFLAGS),
 	GATE(0, "ddrupctl", "ddrphy_pre", CLK_IGNORE_UNUSED,
-			RK1108_CLKGATE_CON(12), 4, GFLAGS),
+			RV1108_CLKGATE_CON(12), 4, GFLAGS),
 	GATE(0, "ddrc", "ddrphy", CLK_IGNORE_UNUSED,
-			RK1108_CLKGATE_CON(12), 5, GFLAGS),
+			RV1108_CLKGATE_CON(12), 5, GFLAGS),
 	GATE(0, "ddrmon", "ddrphy_pre", CLK_IGNORE_UNUSED,
-			RK1108_CLKGATE_CON(12), 6, GFLAGS),
+			RV1108_CLKGATE_CON(12), 6, GFLAGS),
 	GATE(0, "timer_clk", "xin24m", CLK_IGNORE_UNUSED,
-			RK1108_CLKGATE_CON(0), 11, GFLAGS),
+			RV1108_CLKGATE_CON(0), 11, GFLAGS),
 
 	/*
 	 * Clock-Architecture Diagram 6
@@ -416,73 +416,73 @@ static struct rockchip_clk_branch rk1108_clk_branches[] __initdata = {
 
 	/* PD_PERI */
 	COMPOSITE_NOMUX(0, "pclk_periph_pre", "gpll", 0,
-			RK1108_CLKSEL_CON(23), 10, 5, DFLAGS,
-			RK1108_CLKGATE_CON(4), 5, GFLAGS),
+			RV1108_CLKSEL_CON(23), 10, 5, DFLAGS,
+			RV1108_CLKGATE_CON(4), 5, GFLAGS),
 	GATE(0, "pclk_periph", "pclk_periph_pre", CLK_IGNORE_UNUSED,
-			RK1108_CLKGATE_CON(15), 13, GFLAGS),
+			RV1108_CLKGATE_CON(15), 13, GFLAGS),
 	COMPOSITE_NOMUX(0, "hclk_periph_pre", "gpll", 0,
-			RK1108_CLKSEL_CON(23), 5, 5, DFLAGS,
-			RK1108_CLKGATE_CON(4), 4, GFLAGS),
+			RV1108_CLKSEL_CON(23), 5, 5, DFLAGS,
+			RV1108_CLKGATE_CON(4), 4, GFLAGS),
 	GATE(0, "hclk_periph", "hclk_periph_pre", CLK_IGNORE_UNUSED,
-			RK1108_CLKGATE_CON(15), 12, GFLAGS),
+			RV1108_CLKGATE_CON(15), 12, GFLAGS),
 
 	GATE(0, "aclk_peri_src_dpll", "dpll", CLK_IGNORE_UNUSED,
-			RK1108_CLKGATE_CON(4), 1, GFLAGS),
+			RV1108_CLKGATE_CON(4), 1, GFLAGS),
 	GATE(0, "aclk_peri_src_gpll", "gpll", CLK_IGNORE_UNUSED,
-			RK1108_CLKGATE_CON(4), 2, GFLAGS),
+			RV1108_CLKGATE_CON(4), 2, GFLAGS),
 	COMPOSITE(0, "aclk_periph", mux_aclk_peri_src_p, CLK_IGNORE_UNUSED,
-			RK1108_CLKSEL_CON(23), 15, 2, MFLAGS, 0, 5, DFLAGS,
-			RK1108_CLKGATE_CON(15), 11, GFLAGS),
+			RV1108_CLKSEL_CON(23), 15, 2, MFLAGS, 0, 5, DFLAGS,
+			RV1108_CLKGATE_CON(15), 11, GFLAGS),
 
 	COMPOSITE(SCLK_SDMMC, "sclk_sdmmc0", mux_mmc_src_p, 0,
-			RK1108_CLKSEL_CON(25), 8, 2, MFLAGS, 0, 8, DFLAGS,
-			RK1108_CLKGATE_CON(5), 0, GFLAGS),
+			RV1108_CLKSEL_CON(25), 8, 2, MFLAGS, 0, 8, DFLAGS,
+			RV1108_CLKGATE_CON(5), 0, GFLAGS),
 
 	COMPOSITE_NODIV(0, "sclk_sdio_src", mux_mmc_src_p, 0,
-			RK1108_CLKSEL_CON(25), 10, 2, MFLAGS,
-			RK1108_CLKGATE_CON(5), 2, GFLAGS),
+			RV1108_CLKSEL_CON(25), 10, 2, MFLAGS,
+			RV1108_CLKGATE_CON(5), 2, GFLAGS),
 	DIV(SCLK_SDIO, "sclk_sdio", "sclk_sdio_src", 0,
-			RK1108_CLKSEL_CON(26), 0, 8, DFLAGS),
+			RV1108_CLKSEL_CON(26), 0, 8, DFLAGS),
 
 	COMPOSITE_NODIV(0, "sclk_emmc_src", mux_mmc_src_p, 0,
-			RK1108_CLKSEL_CON(25), 12, 2, MFLAGS,
-			RK1108_CLKGATE_CON(5), 1, GFLAGS),
+			RV1108_CLKSEL_CON(25), 12, 2, MFLAGS,
+			RV1108_CLKGATE_CON(5), 1, GFLAGS),
 	DIV(SCLK_EMMC, "sclk_emmc", "sclk_emmc_src", 0,
 			RK2928_CLKSEL_CON(26), 8, 8, DFLAGS),
-	GATE(HCLK_SDMMC, "hclk_sdmmc", "hclk_periph", 0, RK1108_CLKGATE_CON(15), 0, GFLAGS),
-	GATE(HCLK_SDIO, "hclk_sdio", "hclk_periph", 0, RK1108_CLKGATE_CON(15), 1, GFLAGS),
-	GATE(HCLK_EMMC, "hclk_emmc", "hclk_periph", 0, RK1108_CLKGATE_CON(15), 2, GFLAGS),
+	GATE(HCLK_SDMMC, "hclk_sdmmc", "hclk_periph", 0, RV1108_CLKGATE_CON(15), 0, GFLAGS),
+	GATE(HCLK_SDIO, "hclk_sdio", "hclk_periph", 0, RV1108_CLKGATE_CON(15), 1, GFLAGS),
+	GATE(HCLK_EMMC, "hclk_emmc", "hclk_periph", 0, RV1108_CLKGATE_CON(15), 2, GFLAGS),
 
 	COMPOSITE(SCLK_NANDC, "sclk_nandc", mux_pll_src_2plls_p, 0,
-			RK1108_CLKSEL_CON(27), 14, 2, MFLAGS, 8, 5, DFLAGS,
-			RK1108_CLKGATE_CON(5), 3, GFLAGS),
-	GATE(HCLK_NANDC, "hclk_nandc", "hclk_periph", 0, RK1108_CLKGATE_CON(15), 3, GFLAGS),
+			RV1108_CLKSEL_CON(27), 14, 2, MFLAGS, 8, 5, DFLAGS,
+			RV1108_CLKGATE_CON(5), 3, GFLAGS),
+	GATE(HCLK_NANDC, "hclk_nandc", "hclk_periph", 0, RV1108_CLKGATE_CON(15), 3, GFLAGS),
 
 	COMPOSITE(SCLK_SFC, "sclk_sfc", mux_pll_src_2plls_p, 0,
-			RK1108_CLKSEL_CON(27), 7, 2, MFLAGS, 0, 7, DFLAGS,
-			RK1108_CLKGATE_CON(5), 4, GFLAGS),
-	GATE(HCLK_SFC, "hclk_sfc", "hclk_periph", 0, RK1108_CLKGATE_CON(15), 10, GFLAGS),
+			RV1108_CLKSEL_CON(27), 7, 2, MFLAGS, 0, 7, DFLAGS,
+			RV1108_CLKGATE_CON(5), 4, GFLAGS),
+	GATE(HCLK_SFC, "hclk_sfc", "hclk_periph", 0, RV1108_CLKGATE_CON(15), 10, GFLAGS),
 
 	COMPOSITE(0, "sclk_macphy_pre", mux_pll_src_apll_gpll_p, 0,
-			RK1108_CLKSEL_CON(24), 12, 2, MFLAGS, 0, 5, DFLAGS,
-			RK1108_CLKGATE_CON(4), 10, GFLAGS),
+			RV1108_CLKSEL_CON(24), 12, 2, MFLAGS, 0, 5, DFLAGS,
+			RV1108_CLKGATE_CON(4), 10, GFLAGS),
 	MUX(0, "sclk_macphy", mux_sclk_macphy_p, CLK_SET_RATE_PARENT,
-			RK1108_CLKSEL_CON(24), 8, 2, MFLAGS),
-	GATE(0, "sclk_macphy_rx", "sclk_macphy", 0, RK1108_CLKGATE_CON(4), 8, GFLAGS),
-	GATE(0, "sclk_mac_ref", "sclk_macphy", 0, RK1108_CLKGATE_CON(4), 6, GFLAGS),
-	GATE(0, "sclk_mac_refout", "sclk_macphy", 0, RK1108_CLKGATE_CON(4), 7, GFLAGS),
+			RV1108_CLKSEL_CON(24), 8, 2, MFLAGS),
+	GATE(0, "sclk_macphy_rx", "sclk_macphy", 0, RV1108_CLKGATE_CON(4), 8, GFLAGS),
+	GATE(0, "sclk_mac_ref", "sclk_macphy", 0, RV1108_CLKGATE_CON(4), 6, GFLAGS),
+	GATE(0, "sclk_mac_refout", "sclk_macphy", 0, RV1108_CLKGATE_CON(4), 7, GFLAGS),
 
-	MMC(SCLK_SDMMC_DRV,    "sdmmc_drv",    "sclk_sdmmc", RK1108_SDMMC_CON0, 1),
-	MMC(SCLK_SDMMC_SAMPLE, "sdmmc_sample", "sclk_sdmmc", RK1108_SDMMC_CON1, 1),
+	MMC(SCLK_SDMMC_DRV,    "sdmmc_drv",    "sclk_sdmmc", RV1108_SDMMC_CON0, 1),
+	MMC(SCLK_SDMMC_SAMPLE, "sdmmc_sample", "sclk_sdmmc", RV1108_SDMMC_CON1, 1),
 
-	MMC(SCLK_SDIO_DRV,     "sdio_drv",     "sclk_sdio",  RK1108_SDIO_CON0,  1),
-	MMC(SCLK_SDIO_SAMPLE,  "sdio_sample",  "sclk_sdio",  RK1108_SDIO_CON1,  1),
+	MMC(SCLK_SDIO_DRV,     "sdio_drv",     "sclk_sdio",  RV1108_SDIO_CON0,  1),
+	MMC(SCLK_SDIO_SAMPLE,  "sdio_sample",  "sclk_sdio",  RV1108_SDIO_CON1,  1),
 
-	MMC(SCLK_EMMC_DRV,     "emmc_drv",     "sclk_emmc",  RK1108_EMMC_CON0,  1),
-	MMC(SCLK_EMMC_SAMPLE,  "emmc_sample",  "sclk_emmc",  RK1108_EMMC_CON1,  1),
+	MMC(SCLK_EMMC_DRV,     "emmc_drv",     "sclk_emmc",  RV1108_EMMC_CON0,  1),
+	MMC(SCLK_EMMC_SAMPLE,  "emmc_sample",  "sclk_emmc",  RV1108_EMMC_CON1,  1),
 };
 
-static const char *const rk1108_critical_clocks[] __initconst = {
+static const char *const rv1108_critical_clocks[] __initconst = {
 	"aclk_core",
 	"aclk_bus_src_gpll",
 	"aclk_periph",
@@ -490,7 +490,7 @@ static const char *const rk1108_critical_clocks[] __initconst = {
 	"pclk_periph",
 };
 
-static void __init rk1108_clk_init(struct device_node *np)
+static void __init rv1108_clk_init(struct device_node *np)
 {
 	struct rockchip_clk_provider *ctx;
 	void __iomem *reg_base;
@@ -508,24 +508,24 @@ static void __init rk1108_clk_init(struct device_node *np)
 		return;
 	}
 
-	rockchip_clk_register_plls(ctx, rk1108_pll_clks,
-				   ARRAY_SIZE(rk1108_pll_clks),
-				   RK1108_GRF_SOC_STATUS0);
-	rockchip_clk_register_branches(ctx, rk1108_clk_branches,
-				  ARRAY_SIZE(rk1108_clk_branches));
-	rockchip_clk_protect_critical(rk1108_critical_clocks,
-				      ARRAY_SIZE(rk1108_critical_clocks));
+	rockchip_clk_register_plls(ctx, rv1108_pll_clks,
+				   ARRAY_SIZE(rv1108_pll_clks),
+				   RV1108_GRF_SOC_STATUS0);
+	rockchip_clk_register_branches(ctx, rv1108_clk_branches,
+				  ARRAY_SIZE(rv1108_clk_branches));
+	rockchip_clk_protect_critical(rv1108_critical_clocks,
+				      ARRAY_SIZE(rv1108_critical_clocks));
 
 	rockchip_clk_register_armclk(ctx, ARMCLK, "armclk",
 			mux_armclk_p, ARRAY_SIZE(mux_armclk_p),
-			&rk1108_cpuclk_data, rk1108_cpuclk_rates,
-			ARRAY_SIZE(rk1108_cpuclk_rates));
+			&rv1108_cpuclk_data, rv1108_cpuclk_rates,
+			ARRAY_SIZE(rv1108_cpuclk_rates));
 
-	rockchip_register_softrst(np, 13, reg_base + RK1108_SOFTRST_CON(0),
+	rockchip_register_softrst(np, 13, reg_base + RV1108_SOFTRST_CON(0),
 				  ROCKCHIP_SOFTRST_HIWORD_MASK);
 
-	rockchip_register_restart_notifier(ctx, RK1108_GLB_SRST_FST, NULL);
+	rockchip_register_restart_notifier(ctx, RV1108_GLB_SRST_FST, NULL);
 
 	rockchip_clk_of_add_provider(np, ctx);
 }
-CLK_OF_DECLARE(rk1108_cru, "rockchip,rk1108-cru", rk1108_clk_init);
+CLK_OF_DECLARE(rv1108_cru, "rockchip,rv1108-cru", rv1108_clk_init);
diff --git a/drivers/clk/rockchip/clk.h b/drivers/clk/rockchip/clk.h
index 7c15473ea72b..ef601dded32c 100644
--- a/drivers/clk/rockchip/clk.h
+++ b/drivers/clk/rockchip/clk.h
@@ -34,20 +34,20 @@ struct clk;
 #define HIWORD_UPDATE(val, mask, shift) \
 		((val) << (shift) | (mask) << ((shift) + 16))
 
-/* register positions shared by RK1108, RK2928, RK3036, RK3066, RK3188 and RK3228 */
-#define RK1108_PLL_CON(x)		((x) * 0x4)
-#define RK1108_CLKSEL_CON(x)		((x) * 0x4 + 0x60)
-#define RK1108_CLKGATE_CON(x)		((x) * 0x4 + 0x120)
-#define RK1108_SOFTRST_CON(x)		((x) * 0x4 + 0x180)
-#define RK1108_GLB_SRST_FST		0x1c0
-#define RK1108_GLB_SRST_SND		0x1c4
-#define RK1108_MISC_CON			0x1cc
-#define RK1108_SDMMC_CON0		0x1d8
-#define RK1108_SDMMC_CON1		0x1dc
-#define RK1108_SDIO_CON0		0x1e0
-#define RK1108_SDIO_CON1		0x1e4
-#define RK1108_EMMC_CON0		0x1e8
-#define RK1108_EMMC_CON1		0x1ec
+/* register positions shared by RV1108, RK2928, RK3036, RK3066, RK3188 and RK3228 */
+#define RV1108_PLL_CON(x)		((x) * 0x4)
+#define RV1108_CLKSEL_CON(x)		((x) * 0x4 + 0x60)
+#define RV1108_CLKGATE_CON(x)		((x) * 0x4 + 0x120)
+#define RV1108_SOFTRST_CON(x)		((x) * 0x4 + 0x180)
+#define RV1108_GLB_SRST_FST		0x1c0
+#define RV1108_GLB_SRST_SND		0x1c4
+#define RV1108_MISC_CON			0x1cc
+#define RV1108_SDMMC_CON0		0x1d8
+#define RV1108_SDMMC_CON1		0x1dc
+#define RV1108_SDIO_CON0		0x1e0
+#define RV1108_SDIO_CON1		0x1e4
+#define RV1108_EMMC_CON0		0x1e8
+#define RV1108_EMMC_CON1		0x1ec
 
 #define RK2928_PLL_CON(x)		((x) * 0x4)
 #define RK2928_MODE_CON		0x40
diff --git a/include/dt-bindings/clock/rk1108-cru.h b/include/dt-bindings/clock/rv1108-cru.h
similarity index 97%
rename from include/dt-bindings/clock/rk1108-cru.h
rename to include/dt-bindings/clock/rv1108-cru.h
index 9350a5527a36..ae26f8105914 100644
--- a/include/dt-bindings/clock/rk1108-cru.h
+++ b/include/dt-bindings/clock/rv1108-cru.h
@@ -13,8 +13,8 @@
  * GNU General Public License for more details.
  */
 
-#ifndef _DT_BINDINGS_CLK_ROCKCHIP_RK1108_H
-#define _DT_BINDINGS_CLK_ROCKCHIP_RK1108_H
+#ifndef _DT_BINDINGS_CLK_ROCKCHIP_RV1108_H
+#define _DT_BINDINGS_CLK_ROCKCHIP_RV1108_H
 
 /* pll id */
 #define PLL_APLL			0
@@ -266,4 +266,4 @@
 #define ARST_DSP_EDP_PERF		184
 #define ARST_DSP_EPP_PERF		185
 
-#endif /* _DT_BINDINGS_CLK_ROCKCHIP_RK1108_H */
+#endif /* _DT_BINDINGS_CLK_ROCKCHIP_RV1108_H */
-- 
2.11.0
