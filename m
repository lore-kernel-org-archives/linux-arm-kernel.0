From: wxt@rock-chips.com (Caesar Wang)
Date: Wed, 16 Dec 2015 16:27:17 +0800
Subject: [PATCH 1/5] clk: rockchip: rk3036: include downstream muxes into
 fractional dividers
In-Reply-To: <1450254441-3243-1-git-send-email-wxt@rock-chips.com>
References: <1450254441-3243-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1450254441-3243-2-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the newly introduced possibility to combine the fractional dividers
with their downstream muxes for all fractional dividers on currently
supported RK3036 SoCs.

Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
Signed-off-by: Caesar Wang <wxt@rock-chips.com>
---

 drivers/clk/rockchip/clk-rk3036.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/clk/rockchip/clk-rk3036.c b/drivers/clk/rockchip/clk-rk3036.c
index 75553af..dc01a2a 100644
--- a/drivers/clk/rockchip/clk-rk3036.c
+++ b/drivers/clk/rockchip/clk-rk3036.c
@@ -227,21 +227,21 @@ static struct rockchip_clk_branch rk3036_clk_branches[] __initdata = {
 	COMPOSITE_NOMUX(0, "uart2_src", "uart_pll_clk", 0,
 			RK2928_CLKSEL_CON(13), 0, 7, DFLAGS,
 			RK2928_CLKGATE_CON(1), 8, GFLAGS),
-	COMPOSITE_FRAC(0, "uart0_frac", "uart0_src", CLK_SET_RATE_PARENT,
+	COMPOSITE_FRACMUX(0, "uart0_frac", "uart0_src", CLK_SET_RATE_PARENT,
 			RK2928_CLKSEL_CON(17), 0,
-			RK2928_CLKGATE_CON(1), 9, GFLAGS),
-	COMPOSITE_FRAC(0, "uart1_frac", "uart1_src", CLK_SET_RATE_PARENT,
-			RK2928_CLKSEL_CON(18), 0,
-			RK2928_CLKGATE_CON(1), 11, GFLAGS),
-	COMPOSITE_FRAC(0, "uart2_frac", "uart2_src", CLK_SET_RATE_PARENT,
-			RK2928_CLKSEL_CON(19), 0,
-			RK2928_CLKGATE_CON(1), 13, GFLAGS),
+			RK2928_CLKGATE_CON(1), 9, GFLAGS,
 	MUX(SCLK_UART0, "sclk_uart0", mux_uart0_p, CLK_SET_RATE_PARENT,
-			RK2928_CLKSEL_CON(13), 8, 2, MFLAGS),
+			RK2928_CLKSEL_CON(13), 8, 2, MFLAGS)),
+	COMPOSITE_FRACMUX(0, "uart1_frac", "uart1_src", CLK_SET_RATE_PARENT,
+			RK2928_CLKSEL_CON(18), 0,
+			RK2928_CLKGATE_CON(1), 11, GFLAGS,
 	MUX(SCLK_UART1, "sclk_uart1", mux_uart1_p, CLK_SET_RATE_PARENT,
-			RK2928_CLKSEL_CON(14), 8, 2, MFLAGS),
+			RK2928_CLKSEL_CON(14), 8, 2, MFLAGS)),
+	COMPOSITE_FRACMUX(0, "uart2_frac", "uart2_src", CLK_SET_RATE_PARENT,
+			RK2928_CLKSEL_CON(19), 0,
+			RK2928_CLKGATE_CON(1), 13, GFLAGS,
 	MUX(SCLK_UART2, "sclk_uart2", mux_uart2_p, CLK_SET_RATE_PARENT,
-			RK2928_CLKSEL_CON(15), 8, 2, MFLAGS),
+			RK2928_CLKSEL_CON(15), 8, 2, MFLAGS)),
 
 	COMPOSITE(0, "aclk_vcodec", mux_pll_src_3plls_p, 0,
 			RK2928_CLKSEL_CON(32), 14, 2, MFLAGS, 8, 5, DFLAGS,
@@ -289,11 +289,11 @@ static struct rockchip_clk_branch rk3036_clk_branches[] __initdata = {
 	COMPOSITE(0, "i2s_src", mux_pll_src_3plls_p, 0,
 			RK2928_CLKSEL_CON(3), 14, 2, MFLAGS, 0, 7, DFLAGS,
 			RK2928_CLKGATE_CON(0), 9, GFLAGS),
-	COMPOSITE_FRAC(0, "i2s_frac", "i2s_src", CLK_SET_RATE_PARENT,
+	COMPOSITE_FRACMUX(0, "i2s_frac", "i2s_src", CLK_SET_RATE_PARENT,
 			RK2928_CLKSEL_CON(7), 0,
-			RK2928_CLKGATE_CON(0), 10, GFLAGS),
+			RK2928_CLKGATE_CON(0), 10, GFLAGS,
 	MUX(0, "i2s_pre", mux_i2s_pre_p, CLK_SET_RATE_PARENT,
-			RK2928_CLKSEL_CON(3), 8, 2, MFLAGS),
+			RK2928_CLKSEL_CON(3), 8, 2, MFLAGS)),
 	COMPOSITE_NODIV(SCLK_I2S_OUT, "i2s_clkout", mux_i2s_clkout_p, 0,
 			RK2928_CLKSEL_CON(3), 12, 1, MFLAGS,
 			RK2928_CLKGATE_CON(0), 13, GFLAGS),
@@ -303,11 +303,11 @@ static struct rockchip_clk_branch rk3036_clk_branches[] __initdata = {
 	COMPOSITE(0, "spdif_src", mux_pll_src_3plls_p, 0,
 			RK2928_CLKSEL_CON(5), 10, 2, MFLAGS, 0, 7, DFLAGS,
 			RK2928_CLKGATE_CON(2), 10, GFLAGS),
-	COMPOSITE_FRAC(0, "spdif_frac", "spdif_src", 0,
+	COMPOSITE_FRACMUX(0, "spdif_frac", "spdif_src", 0,
 			RK2928_CLKSEL_CON(9), 0,
-			RK2928_CLKGATE_CON(2), 12, GFLAGS),
+			RK2928_CLKGATE_CON(2), 12, GFLAGS,
 	MUX(SCLK_SPDIF, "sclk_spdif", mux_spdif_p, 0,
-			RK2928_CLKSEL_CON(5), 8, 2, MFLAGS),
+			RK2928_CLKSEL_CON(5), 8, 2, MFLAGS)),
 
 	GATE(SCLK_OTGPHY0, "sclk_otgphy0", "xin12m", CLK_IGNORE_UNUSED,
 			RK2928_CLKGATE_CON(1), 5, GFLAGS),
@@ -414,6 +414,7 @@ static const char *const rk3036_critical_clocks[] __initconst = {
 	"aclk_peri",
 	"hclk_peri",
 	"pclk_peri",
+	"uart_pll_clk",
 };
 
 static void __init rk3036_clk_init(struct device_node *np)
-- 
1.9.1
