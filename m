From: heiko@sntech.de (Heiko Stuebner)
Date: Sun,  5 Jul 2015 11:00:16 +0200
Subject: [PATCH 3/7] clk: rockchip: define the inverters of rk3066/rk3188 and
 rk3288
In-Reply-To: <1436086820-3757-1-git-send-email-heiko@sntech.de>
References: <1436086820-3757-1-git-send-email-heiko@sntech.de>
Message-ID: <1436086820-3757-4-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Both soc series' have inverters on the hsadc and camera interface clock
paths. So define them using the newly added inverter type.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/clk/rockchip/clk-rk3188.c | 9 ++++++++-
 drivers/clk/rockchip/clk-rk3288.c | 7 ++++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/rockchip/clk-rk3188.c b/drivers/clk/rockchip/clk-rk3188.c
index e4f9d47..a9ab4f9 100644
--- a/drivers/clk/rockchip/clk-rk3188.c
+++ b/drivers/clk/rockchip/clk-rk3188.c
@@ -235,6 +235,7 @@ static struct rockchip_pll_clock rk3188_pll_clks[] __initdata = {
 #define MFLAGS CLK_MUX_HIWORD_MASK
 #define DFLAGS CLK_DIVIDER_HIWORD_MASK
 #define GFLAGS (CLK_GATE_HIWORD_MASK | CLK_GATE_SET_TO_DISABLE)
+#define IFLAGS ROCKCHIP_INVERTER_HIWORD_MASK
 
 /* 2 ^ (val + 1) */
 static struct clk_div_table div_core_peri_t[] = {
@@ -310,6 +311,8 @@ static struct rockchip_clk_branch common_clk_branches[] __initdata = {
 
 	GATE(0, "pclkin_cif0", "ext_cif0", 0,
 			RK2928_CLKGATE_CON(3), 3, GFLAGS),
+	INVERTER(0, "pclk_cif0", "pclkin_cif0",
+			RK2928_CLKSEL_CON(30), 8, IFLAGS),
 
 	/*
 	 * the 480m are generated inside the usb block from these clocks,
@@ -334,8 +337,10 @@ static struct rockchip_clk_branch common_clk_branches[] __initdata = {
 	COMPOSITE_FRAC(0, "hsadc_frac", "hsadc_src", 0,
 			RK2928_CLKSEL_CON(23), 0,
 			RK2928_CLKGATE_CON(2), 7, GFLAGS),
-	MUX(SCLK_HSADC, "sclk_hsadc", mux_sclk_hsadc_p, 0,
+	MUX(0, "sclk_hsadc_out", mux_sclk_hsadc_p, 0,
 			RK2928_CLKSEL_CON(22), 4, 2, MFLAGS),
+	INVERTER(SCLK_HSADC, "sclk_hsadc", "sclk_hsadc_out",
+			RK2928_CLKSEL_CON(22), 7, IFLAGS),
 
 	COMPOSITE_NOMUX(SCLK_SARADC, "sclk_saradc", "xin24m", 0,
 			RK2928_CLKSEL_CON(24), 8, 8, DFLAGS,
@@ -557,6 +562,8 @@ static struct rockchip_clk_branch rk3066a_clk_branches[] __initdata = {
 
 	GATE(0, "pclkin_cif1", "ext_cif1", 0,
 			RK2928_CLKGATE_CON(3), 4, GFLAGS),
+	INVERTER(0, "pclk_cif1", "pclkin_cif1",
+			RK2928_CLKSEL_CON(30), 12, IFLAGS),
 
 	COMPOSITE(0, "aclk_gpu_src", mux_pll_src_cpll_gpll_p, 0,
 			RK2928_CLKSEL_CON(33), 8, 1, MFLAGS, 0, 5, DFLAGS,
diff --git a/drivers/clk/rockchip/clk-rk3288.c b/drivers/clk/rockchip/clk-rk3288.c
index df9dc96..a8bad7d 100644
--- a/drivers/clk/rockchip/clk-rk3288.c
+++ b/drivers/clk/rockchip/clk-rk3288.c
@@ -223,6 +223,7 @@ static struct clk_div_table div_hclk_cpu_t[] = {
 #define MFLAGS CLK_MUX_HIWORD_MASK
 #define DFLAGS CLK_DIVIDER_HIWORD_MASK
 #define GFLAGS (CLK_GATE_HIWORD_MASK | CLK_GATE_SET_TO_DISABLE)
+#define IFLAGS ROCKCHIP_INVERTER_HIWORD_MASK
 
 static struct rockchip_clk_branch rk3288_clk_branches[] __initdata = {
 	/*
@@ -592,8 +593,10 @@ static struct rockchip_clk_branch rk3288_clk_branches[] __initdata = {
 	COMPOSITE(0, "hsadc_src", mux_pll_src_cpll_gpll_p, 0,
 			RK3288_CLKSEL_CON(22), 0, 1, MFLAGS, 8, 8, DFLAGS,
 			RK3288_CLKGATE_CON(2), 6, GFLAGS),
-	MUX(SCLK_HSADC, "sclk_hsadc_out", mux_hsadcout_p, 0,
+	MUX(0, "sclk_hsadc_out", mux_hsadcout_p, 0,
 			RK3288_CLKSEL_CON(22), 4, 1, MFLAGS),
+	INVERTER(SCLK_HSADC, "sclk_hsadc", "sclk_hsadc_out",
+			RK3288_CLKSEL_CON(22), 7, IFLAGS),
 
 	GATE(0, "jtag", "ext_jtag", 0,
 			RK3288_CLKGATE_CON(4), 14, GFLAGS),
@@ -768,7 +771,9 @@ static struct rockchip_clk_branch rk3288_clk_branches[] __initdata = {
 	 */
 
 	GATE(0, "pclk_vip_in", "ext_vip", 0, RK3288_CLKGATE_CON(16), 0, GFLAGS),
+	INVERTER(0, "pclk_vip", "pclk_vip_in", RK3288_CLKSEL_CON(29), 4, IFLAGS),
 	GATE(0, "pclk_isp_in", "ext_isp", 0, RK3288_CLKGATE_CON(16), 3, GFLAGS),
+	INVERTER(0, "pclk_isp", "pclk_isp_in", RK3288_CLKSEL_CON(29), 3, IFLAGS),
 };
 
 static const char *const rk3288_critical_clocks[] __initconst = {
-- 
2.1.4
