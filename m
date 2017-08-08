From: zhangqing@rock-chips.com (Elaine Zhang)
Date: Tue,  8 Aug 2017 15:18:59 +0800
Subject: [PATCH v3 7/9] clk: rockchip: fix up some clks describe error for
 rv1108 SoC
In-Reply-To: <1502176547-30817-1-git-send-email-zhangqing@rock-chips.com>
References: <1502176547-30817-1-git-send-email-zhangqing@rock-chips.com>
Message-ID: <1502176739-32321-1-git-send-email-zhangqing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

1. fix up the parent name
2. remove the CLK_IGNORE_UNUSED flag for some clk not need to always on.
3. fix up some clks regs describe error.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 drivers/clk/rockchip/clk-rv1108.c | 122 ++++++++++++++++++++------------------
 1 file changed, 63 insertions(+), 59 deletions(-)

diff --git a/drivers/clk/rockchip/clk-rv1108.c b/drivers/clk/rockchip/clk-rv1108.c
index 5cb7699305f5..829beef82cff 100644
--- a/drivers/clk/rockchip/clk-rv1108.c
+++ b/drivers/clk/rockchip/clk-rv1108.c
@@ -129,22 +129,22 @@ enum rv1108_plls {
 PNAME(mux_usb480m_pre_p)	= { "usbphy", "xin24m" };
 PNAME(mux_hdmiphy_phy_p)	= { "hdmiphy", "xin24m" };
 PNAME(mux_dclk_hdmiphy_pre_p)	= { "dclk_hdmiphy_src_gpll", "dclk_hdmiphy_src_dpll" };
-PNAME(mux_pll_src_4plls_p)	= { "dpll", "hdmiphy", "gpll", "usb480m" };
+PNAME(mux_pll_src_4plls_p)	= { "dpll", "gpll", "hdmiphy", "usb480m" };
 PNAME(mux_pll_src_3plls_p)	= { "apll", "gpll", "dpll" };
 PNAME(mux_pll_src_2plls_p)	= { "dpll", "gpll" };
 PNAME(mux_pll_src_apll_gpll_p)	= { "apll", "gpll" };
-PNAME(mux_aclk_peri_src_p)	= { "aclk_peri_src_dpll", "aclk_peri_src_gpll" };
+PNAME(mux_aclk_peri_src_p)	= { "aclk_peri_src_gpll", "aclk_peri_src_dpll" };
 PNAME(mux_aclk_bus_src_p)	= { "aclk_bus_src_gpll", "aclk_bus_src_apll", "aclk_bus_src_dpll" };
 PNAME(mux_mmc_src_p)		= { "dpll", "gpll", "xin24m", "usb480m" };
 PNAME(mux_pll_src_dpll_gpll_usb480m_p)	= { "dpll", "gpll", "usb480m" };
 PNAME(mux_uart0_p)		= { "uart0_src", "uart0_frac", "xin24m" };
 PNAME(mux_uart1_p)		= { "uart1_src", "uart1_frac", "xin24m" };
 PNAME(mux_uart2_p)		= { "uart2_src", "uart2_frac", "xin24m" };
-PNAME(mux_sclk_macphy_p)	= { "sclk_macphy_pre", "ext_gmac" };
+PNAME(mux_sclk_macphy_p)	= { "ext_gmac", "sclk_macphy_pre" };
 PNAME(mux_i2s0_pre_p)		= { "i2s0_src", "i2s0_frac", "ext_i2s", "xin12m" };
 PNAME(mux_i2s_out_p)		= { "i2s0_pre", "xin12m" };
-PNAME(mux_i2s1_p)		= { "i2s1_src", "i2s1_frac", "xin12m" };
-PNAME(mux_i2s2_p)		= { "i2s2_src", "i2s2_frac", "xin12m" };
+PNAME(mux_i2s1_p)		= { "i2s1_src", "i2s1_frac", "dummy", "xin12m" };
+PNAME(mux_i2s2_p)		= { "i2s2_src", "i2s2_frac", "dummy", "xin12m" };
 PNAME(mux_wifi_src_p)	= { "gpll", "xin24m" };
 PNAME(mux_cifout_src_p)	= { "hdmiphy", "gpll" };
 PNAME(mux_cifout_p)	= { "sclk_cifout_src", "xin24m" };
@@ -197,10 +197,10 @@ enum rv1108_plls {
 			RV1108_CLKSEL_CON(7), 12, 2, MFLAGS);
 
 static struct rockchip_clk_branch rv1108_clk_branches[] __initdata = {
-	MUX(0, "hdmi_phy", mux_hdmiphy_phy_p, CLK_SET_RATE_PARENT,
-			RV1108_MISC_CON, 13, 2, MFLAGS),
+	MUX(0, "hdmiphy", mux_hdmiphy_phy_p, CLK_SET_RATE_PARENT,
+			RV1108_MISC_CON, 13, 1, MFLAGS),
 	MUX(0, "usb480m", mux_usb480m_pre_p, CLK_SET_RATE_PARENT,
-			RV1108_MISC_CON, 15, 2, MFLAGS),
+			RV1108_MISC_CON, 15, 1, MFLAGS),
 	/*
 	 * Clock-Architecture Diagram 2
 	 */
@@ -442,7 +442,7 @@ enum rv1108_plls {
 	GATE(0, "dclk_hdmiphy_src_dpll", "dpll", CLK_IGNORE_UNUSED,
 			RV1108_CLKGATE_CON(6), 4, GFLAGS),
 	COMPOSITE_NOGATE(0, "dclk_hdmiphy_pre", mux_dclk_hdmiphy_pre_p, 0,
-			RV1108_CLKSEL_CON(32), 6, 2, MFLAGS, 8, 6, DFLAGS),
+			RV1108_CLKSEL_CON(32), 6, 1, MFLAGS, 8, 6, DFLAGS),
 	COMPOSITE_NOGATE(DCLK_VOP_SRC, "dclk_vop_src", mux_dclk_hdmiphy_pre_p, 0,
 			RV1108_CLKSEL_CON(32), 6, 1, MFLAGS, 0, 6, DFLAGS),
 	MUX(DCLK_HDMIPHY, "dclk_hdmiphy", mux_dclk_hdmiphy_p, CLK_SET_RATE_PARENT,
@@ -498,6 +498,7 @@ enum rv1108_plls {
 			RV1108_CLKGATE_CON(14), 11, GFLAGS),
 	GATE(0, "pclk_mipi_csiphy", "pclk_top_pre", CLK_IGNORE_UNUSED,
 			RV1108_CLKGATE_CON(14), 12, GFLAGS),
+
 	/*
 	 * Clock-Architecture Diagram 5
 	 */
@@ -508,7 +509,7 @@ enum rv1108_plls {
 	COMPOSITE(SCLK_I2S0_SRC, "i2s0_src", mux_pll_src_2plls_p, 0,
 			RV1108_CLKSEL_CON(5), 8, 1, MFLAGS, 0, 7, DFLAGS,
 			RV1108_CLKGATE_CON(2), 0, GFLAGS),
-	COMPOSITE_FRACMUX(0, "i2s1_frac", "i2s1_src", CLK_SET_RATE_PARENT,
+	COMPOSITE_FRACMUX(0, "i2s0_frac", "i2s0_src", CLK_SET_RATE_PARENT,
 			RV1108_CLKSEL_CON(8), 0,
 			RV1108_CLKGATE_CON(2), 1, GFLAGS,
 			&rv1108_i2s0_fracmux),
@@ -518,7 +519,7 @@ enum rv1108_plls {
 			RV1108_CLKSEL_CON(5), 15, 1, MFLAGS,
 			RV1108_CLKGATE_CON(2), 3, GFLAGS),
 
-	COMPOSITE(0, "i2s1_src", mux_pll_src_2plls_p, 0,
+	COMPOSITE(SCLK_I2S1_SRC, "i2s1_src", mux_pll_src_2plls_p, 0,
 			RV1108_CLKSEL_CON(6), 8, 1, MFLAGS, 0, 7, DFLAGS,
 			RV1108_CLKGATE_CON(2), 4, GFLAGS),
 	COMPOSITE_FRACMUX(0, "i2s1_frac", "i2s1_src", CLK_SET_RATE_PARENT,
@@ -528,7 +529,7 @@ enum rv1108_plls {
 	GATE(SCLK_I2S1, "sclk_i2s1", "i2s1_pre", CLK_SET_RATE_PARENT,
 			RV1108_CLKGATE_CON(2), 6, GFLAGS),
 
-	COMPOSITE(0, "i2s2_src", mux_pll_src_2plls_p, 0,
+	COMPOSITE(SCLK_I2S2_SRC, "i2s2_src", mux_pll_src_2plls_p, 0,
 			RV1108_CLKSEL_CON(7), 8, 1, MFLAGS, 0, 7, DFLAGS,
 			RV1108_CLKGATE_CON(3), 8, GFLAGS),
 	COMPOSITE_FRACMUX(0, "i2s2_frac", "i2s2_src", CLK_SET_RATE_PARENT,
@@ -547,23 +548,23 @@ enum rv1108_plls {
 			RV1108_CLKGATE_CON(1), 2, GFLAGS),
 	COMPOSITE_NOGATE(ACLK_PRE, "aclk_bus_pre", mux_aclk_bus_src_p, 0,
 			RV1108_CLKSEL_CON(2), 8, 2, MFLAGS, 0, 5, DFLAGS),
-	COMPOSITE_NOMUX(0, "hclk_bus_pre", "aclk_bus_2wrap_occ", 0,
+	COMPOSITE_NOMUX(HCLK_BUS, "hclk_bus_pre", "aclk_bus_pre", 0,
 			RV1108_CLKSEL_CON(3), 0, 5, DFLAGS,
 			RV1108_CLKGATE_CON(1), 4, GFLAGS),
-	COMPOSITE_NOMUX(0, "pclken_bus", "aclk_bus_2wrap_occ", 0,
+	COMPOSITE_NOMUX(0, "pclk_bus_pre", "aclk_bus_pre", 0,
 			RV1108_CLKSEL_CON(3), 8, 5, DFLAGS,
 			RV1108_CLKGATE_CON(1), 5, GFLAGS),
-	GATE(0, "pclk_bus_pre", "pclken_bus", CLK_IGNORE_UNUSED,
+	GATE(PCLK_BUS, "pclk_bus", "pclk_bus_pre", 0,
 			RV1108_CLKGATE_CON(1), 6, GFLAGS),
-	GATE(0, "pclk_top_pre", "pclken_bus", CLK_IGNORE_UNUSED,
+	GATE(0, "pclk_top_pre", "pclk_bus_pre", CLK_IGNORE_UNUSED,
 			RV1108_CLKGATE_CON(1), 7, GFLAGS),
-	GATE(0, "pclk_ddr_pre", "pclken_bus", CLK_IGNORE_UNUSED,
+	GATE(0, "pclk_ddr_pre", "pclk_bus_pre", CLK_IGNORE_UNUSED,
 			RV1108_CLKGATE_CON(1), 8, GFLAGS),
-	GATE(0, "clk_timer0", "mux_pll_p", CLK_IGNORE_UNUSED,
+	GATE(SCLK_TIMER0, "clk_timer0", "xin24m", 0,
 			RV1108_CLKGATE_CON(1), 9, GFLAGS),
-	GATE(0, "clk_timer1", "mux_pll_p", CLK_IGNORE_UNUSED,
+	GATE(SCLK_TIMER1, "clk_timer1", "xin24m", CLK_IGNORE_UNUSED,
 			RV1108_CLKGATE_CON(1), 10, GFLAGS),
-	GATE(0, "pclk_timer", "pclk_bus_pre", CLK_IGNORE_UNUSED,
+	GATE(PCLK_TIMER, "pclk_timer", "pclk_bus_pre", CLK_IGNORE_UNUSED,
 			RV1108_CLKGATE_CON(13), 4, GFLAGS),
 
 	GATE(HCLK_I2S0_8CH, "hclk_i2s0_8ch", "hclk_bus_pre", 0,
@@ -587,13 +588,13 @@ enum rv1108_plls {
 	GATE(PCLK_SPI, "pclk_spi", "pclk_bus_pre", 0,
 			RV1108_CLKGATE_CON(13), 5, GFLAGS),
 
-	COMPOSITE(0, "uart0_src", mux_pll_src_dpll_gpll_usb480m_p, CLK_IGNORE_UNUSED,
+	COMPOSITE(SCLK_UART0_SRC, "uart0_src", mux_pll_src_dpll_gpll_usb480m_p, CLK_IGNORE_UNUSED,
 			RV1108_CLKSEL_CON(13), 12, 2, MFLAGS, 0, 7, DFLAGS,
 			RV1108_CLKGATE_CON(3), 1, GFLAGS),
-	COMPOSITE(0, "uart1_src", mux_pll_src_dpll_gpll_usb480m_p, CLK_IGNORE_UNUSED,
+	COMPOSITE(SCLK_UART1_SRC, "uart1_src", mux_pll_src_dpll_gpll_usb480m_p, CLK_IGNORE_UNUSED,
 			RV1108_CLKSEL_CON(14), 12, 2, MFLAGS, 0, 7, DFLAGS,
 			RV1108_CLKGATE_CON(3), 3, GFLAGS),
-	COMPOSITE(0, "uart21_src", mux_pll_src_dpll_gpll_usb480m_p, CLK_IGNORE_UNUSED,
+	COMPOSITE(SCLK_UART2_SRC, "uart2_src", mux_pll_src_dpll_gpll_usb480m_p, CLK_IGNORE_UNUSED,
 			RV1108_CLKSEL_CON(15), 12, 2, MFLAGS, 0, 7, DFLAGS,
 			RV1108_CLKGATE_CON(3), 5, GFLAGS),
 
@@ -609,40 +610,40 @@ enum rv1108_plls {
 			RV1108_CLKSEL_CON(18), 0,
 			RV1108_CLKGATE_CON(3), 6, GFLAGS,
 			&rv1108_uart2_fracmux),
-	GATE(PCLK_UART0, "pclk_uart0", "pclk_bus_pre", CLK_IGNORE_UNUSED,
+	GATE(PCLK_UART0, "pclk_uart0", "pclk_bus_pre", 0,
 			RV1108_CLKGATE_CON(13), 10, GFLAGS),
-	GATE(PCLK_UART1, "pclk_uart1", "pclk_bus_pre", CLK_IGNORE_UNUSED,
+	GATE(PCLK_UART1, "pclk_uart1", "pclk_bus_pre", 0,
 			RV1108_CLKGATE_CON(13), 11, GFLAGS),
-	GATE(PCLK_UART2, "pclk_uart2", "pclk_bus_pre", CLK_IGNORE_UNUSED,
+	GATE(PCLK_UART2, "pclk_uart2", "pclk_bus_pre", 0,
 			RV1108_CLKGATE_CON(13), 12, GFLAGS),
 
-	COMPOSITE(0, "clk_i2c1", mux_pll_src_2plls_p, CLK_IGNORE_UNUSED,
-			RV1108_CLKSEL_CON(19), 15, 2, MFLAGS, 8, 7, DFLAGS,
+	COMPOSITE(SCLK_I2C1, "clk_i2c1", mux_pll_src_2plls_p, 0,
+			RV1108_CLKSEL_CON(19), 15, 1, MFLAGS, 8, 7, DFLAGS,
 			RV1108_CLKGATE_CON(3), 7, GFLAGS),
-	COMPOSITE(0, "clk_i2c2", mux_pll_src_2plls_p, CLK_IGNORE_UNUSED,
-			RV1108_CLKSEL_CON(20), 7, 2, MFLAGS, 0, 7, DFLAGS,
+	COMPOSITE(SCLK_I2C2, "clk_i2c2", mux_pll_src_2plls_p, 0,
+			RV1108_CLKSEL_CON(20), 7, 1, MFLAGS, 0, 7, DFLAGS,
 			RV1108_CLKGATE_CON(3), 8, GFLAGS),
-	COMPOSITE(0, "clk_i2c3", mux_pll_src_2plls_p, CLK_IGNORE_UNUSED,
-			RV1108_CLKSEL_CON(20), 15, 2, MFLAGS, 8, 7, DFLAGS,
+	COMPOSITE(SCLK_I2C3, "clk_i2c3", mux_pll_src_2plls_p, 0,
+			RV1108_CLKSEL_CON(20), 15, 1, MFLAGS, 8, 7, DFLAGS,
 			RV1108_CLKGATE_CON(3), 9, GFLAGS),
-	GATE(0, "pclk_i2c1", "pclk_bus_pre", CLK_IGNORE_UNUSED,
+	GATE(PCLK_I2C1, "pclk_i2c1", "pclk_bus_pre", 0,
 			RV1108_CLKGATE_CON(13), 0, GFLAGS),
-	GATE(0, "pclk_i2c2", "pclk_bus_pre", CLK_IGNORE_UNUSED,
+	GATE(PCLK_I2C2, "pclk_i2c2", "pclk_bus_pre", 0,
 			RV1108_CLKGATE_CON(13), 1, GFLAGS),
-	GATE(0, "pclk_i2c3", "pclk_bus_pre", CLK_IGNORE_UNUSED,
+	GATE(PCLK_I2C3, "pclk_i2c3", "pclk_bus_pre", 0,
 			RV1108_CLKGATE_CON(13), 2, GFLAGS),
-	COMPOSITE(0, "clk_pwm1", mux_pll_src_2plls_p, CLK_IGNORE_UNUSED,
+	COMPOSITE(SCLK_PWM, "clk_pwm1", mux_pll_src_2plls_p, 0,
 			RV1108_CLKSEL_CON(12), 15, 2, MFLAGS, 8, 7, DFLAGS,
 			RV1108_CLKGATE_CON(3), 10, GFLAGS),
-	GATE(0, "pclk_pwm1", "pclk_bus_pre", CLK_IGNORE_UNUSED,
+	GATE(PCLK_PWM, "pclk_pwm1", "pclk_bus_pre", 0,
 			RV1108_CLKGATE_CON(13), 6, GFLAGS),
-	GATE(0, "pclk_wdt", "pclk_bus_pre", CLK_IGNORE_UNUSED,
+	GATE(PCLK_WDT, "pclk_wdt", "pclk_bus_pre", 0,
 			RV1108_CLKGATE_CON(13), 3, GFLAGS),
-	GATE(0, "pclk_gpio1", "pclk_bus_pre", CLK_IGNORE_UNUSED,
+	GATE(PCLK_GPIO1, "pclk_gpio1", "pclk_bus_pre", 0,
 			RV1108_CLKGATE_CON(13), 7, GFLAGS),
-	GATE(0, "pclk_gpio2", "pclk_bus_pre", CLK_IGNORE_UNUSED,
+	GATE(PCLK_GPIO2, "pclk_gpio2", "pclk_bus_pre", 0,
 			RV1108_CLKGATE_CON(13), 8, GFLAGS),
-	GATE(0, "pclk_gpio3", "pclk_bus_pre", CLK_IGNORE_UNUSED,
+	GATE(PCLK_GPIO3, "pclk_gpio3", "pclk_bus_pre", 0,
 			RV1108_CLKGATE_CON(13), 9, GFLAGS),
 
 	GATE(0, "pclk_grf", "pclk_bus_pre", CLK_IGNORE_UNUSED,
@@ -676,15 +677,17 @@ enum rv1108_plls {
 			RV1108_CLKGATE_CON(0), 9, GFLAGS),
 	GATE(0, "gpll_ddr", "gpll", CLK_IGNORE_UNUSED,
 			RV1108_CLKGATE_CON(0), 10, GFLAGS),
-	COMPOSITE(0, "ddrphy4x", mux_ddrphy_p, CLK_IGNORE_UNUSED,
+	COMPOSITE_NOGATE(0, "clk_ddrphy_src", mux_ddrphy_p, CLK_IGNORE_UNUSED,
 			RV1108_CLKSEL_CON(4), 8, 2, MFLAGS, 0, 3,
-			DFLAGS | CLK_DIVIDER_POWER_OF_TWO,
+			DFLAGS | CLK_DIVIDER_POWER_OF_TWO),
+	FACTOR(0, "clk_ddr", "clk_ddrphy_src", 0, 1, 2),
+	GATE(0, "clk_ddrphy4x", "clk_ddr", CLK_IGNORE_UNUSED,
 			RV1108_CLKGATE_CON(10), 9, GFLAGS),
-	GATE(0, "ddrupctl", "ddrphy_pre", CLK_IGNORE_UNUSED,
+	GATE(0, "pclk_ddrupctl", "pclk_ddr_pre", CLK_IGNORE_UNUSED,
 			RV1108_CLKGATE_CON(12), 4, GFLAGS),
-	GATE(0, "ddrc", "ddrphy", CLK_IGNORE_UNUSED,
+	GATE(0, "nclk_ddrupctl", "clk_ddr", CLK_IGNORE_UNUSED,
 			RV1108_CLKGATE_CON(12), 5, GFLAGS),
-	GATE(0, "ddrmon", "ddrphy_pre", CLK_IGNORE_UNUSED,
+	GATE(0, "pclk_ddrmon", "pclk_ddr_pre", CLK_IGNORE_UNUSED,
 			RV1108_CLKGATE_CON(12), 6, GFLAGS),
 	GATE(0, "timer_clk", "xin24m", CLK_IGNORE_UNUSED,
 			RV1108_CLKGATE_CON(0), 11, GFLAGS),
@@ -701,20 +704,20 @@ enum rv1108_plls {
 	COMPOSITE_NOMUX(0, "pclk_periph_pre", "gpll", 0,
 			RV1108_CLKSEL_CON(23), 10, 5, DFLAGS,
 			RV1108_CLKGATE_CON(4), 5, GFLAGS),
-	GATE(0, "pclk_periph", "pclk_periph_pre", CLK_IGNORE_UNUSED,
+	GATE(PCLK_PERI, "pclk_periph", "pclk_periph_pre", CLK_IGNORE_UNUSED,
 			RV1108_CLKGATE_CON(15), 13, GFLAGS),
 	COMPOSITE_NOMUX(0, "hclk_periph_pre", "gpll", 0,
 			RV1108_CLKSEL_CON(23), 5, 5, DFLAGS,
 			RV1108_CLKGATE_CON(4), 4, GFLAGS),
-	GATE(0, "hclk_periph", "hclk_periph_pre", CLK_IGNORE_UNUSED,
+	GATE(HCLK_PERI, "hclk_periph", "hclk_periph_pre", CLK_IGNORE_UNUSED,
 			RV1108_CLKGATE_CON(15), 12, GFLAGS),
 
 	GATE(0, "aclk_peri_src_dpll", "dpll", CLK_IGNORE_UNUSED,
 			RV1108_CLKGATE_CON(4), 1, GFLAGS),
 	GATE(0, "aclk_peri_src_gpll", "gpll", CLK_IGNORE_UNUSED,
 			RV1108_CLKGATE_CON(4), 2, GFLAGS),
-	COMPOSITE(0, "aclk_periph", mux_aclk_peri_src_p, CLK_IGNORE_UNUSED,
-			RV1108_CLKSEL_CON(23), 15, 2, MFLAGS, 0, 5, DFLAGS,
+	COMPOSITE(ACLK_PERI, "aclk_periph", mux_aclk_peri_src_p, 0,
+			RV1108_CLKSEL_CON(23), 15, 1, MFLAGS, 0, 5, DFLAGS,
 			RV1108_CLKGATE_CON(15), 11, GFLAGS),
 
 	COMPOSITE(SCLK_SDMMC, "sclk_sdmmc0", mux_mmc_src_p, 0,
@@ -737,7 +740,7 @@ enum rv1108_plls {
 	GATE(HCLK_EMMC, "hclk_emmc", "hclk_periph", 0, RV1108_CLKGATE_CON(15), 2, GFLAGS),
 
 	COMPOSITE(SCLK_NANDC, "sclk_nandc", mux_pll_src_2plls_p, 0,
-			RV1108_CLKSEL_CON(27), 14, 2, MFLAGS, 8, 5, DFLAGS,
+			RV1108_CLKSEL_CON(27), 14, 1, MFLAGS, 8, 5, DFLAGS,
 			RV1108_CLKGATE_CON(5), 3, GFLAGS),
 	GATE(HCLK_NANDC, "hclk_nandc", "hclk_periph", 0, RV1108_CLKGATE_CON(15), 3, GFLAGS),
 
@@ -746,19 +749,20 @@ enum rv1108_plls {
 	GATE(HCLK_OTG, "hclk_otg", "hclk_periph", 0, RV1108_CLKGATE_CON(15), 8, GFLAGS),
 	GATE(0, "hclk_otg_pmu", "hclk_periph", CLK_IGNORE_UNUSED, RV1108_CLKGATE_CON(15), 9, GFLAGS),
 	GATE(SCLK_USBPHY, "clk_usbphy", "xin24m", CLK_IGNORE_UNUSED, RV1108_CLKGATE_CON(5), 5, GFLAGS),
+
 	COMPOSITE(SCLK_SFC, "sclk_sfc", mux_pll_src_2plls_p, 0,
-			RV1108_CLKSEL_CON(27), 7, 2, MFLAGS, 0, 7, DFLAGS,
+			RV1108_CLKSEL_CON(27), 7, 1, MFLAGS, 0, 7, DFLAGS,
 			RV1108_CLKGATE_CON(5), 4, GFLAGS),
 	GATE(HCLK_SFC, "hclk_sfc", "hclk_periph", 0, RV1108_CLKGATE_CON(15), 10, GFLAGS),
 
-	COMPOSITE(0, "sclk_macphy_pre", mux_pll_src_apll_gpll_p, 0,
-			RV1108_CLKSEL_CON(24), 12, 2, MFLAGS, 0, 5, DFLAGS,
+	COMPOSITE(SCLK_MACPHY_PRE, "sclk_macphy_pre", mux_pll_src_apll_gpll_p, 0,
+			RV1108_CLKSEL_CON(24), 12, 1, MFLAGS, 0, 5, DFLAGS,
 			RV1108_CLKGATE_CON(4), 10, GFLAGS),
-	MUX(0, "sclk_macphy", mux_sclk_macphy_p, CLK_SET_RATE_PARENT,
-			RV1108_CLKSEL_CON(24), 8, 2, MFLAGS),
-	GATE(0, "sclk_macphy_rx", "sclk_macphy", 0, RV1108_CLKGATE_CON(4), 8, GFLAGS),
-	GATE(0, "sclk_mac_ref", "sclk_macphy", 0, RV1108_CLKGATE_CON(4), 6, GFLAGS),
-	GATE(0, "sclk_mac_refout", "sclk_macphy", 0, RV1108_CLKGATE_CON(4), 7, GFLAGS),
+	MUX(SCLK_MACPHY, "sclk_macphy", mux_sclk_macphy_p, CLK_SET_RATE_PARENT,
+			RV1108_CLKSEL_CON(24), 8, 1, MFLAGS),
+	GATE(SCLK_MACPHY_RX, "sclk_macphy_rx", "sclk_macphy", 0, RV1108_CLKGATE_CON(4), 8, GFLAGS),
+	GATE(SCLK_MAC_REF, "sclk_mac_ref", "sclk_macphy", 0, RV1108_CLKGATE_CON(4), 6, GFLAGS),
+	GATE(SCLK_MAC_REFOUT, "sclk_mac_refout", "sclk_macphy", 0, RV1108_CLKGATE_CON(4), 7, GFLAGS),
 
 	MMC(SCLK_SDMMC_DRV,    "sdmmc_drv",    "sclk_sdmmc", RV1108_SDMMC_CON0, 1),
 	MMC(SCLK_SDMMC_SAMPLE, "sdmmc_sample", "sclk_sdmmc", RV1108_SDMMC_CON1, 1),
-- 
1.9.1
