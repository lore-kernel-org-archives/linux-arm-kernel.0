From: heiko@sntech.de (Heiko Stuebner)
Date: Sat,  6 Sep 2014 01:06:07 +0200
Subject: [PATCH 04/11] clk: rockchip: make tightly bound armclk child-clocks
 read-only
In-Reply-To: <1409958374-30937-1-git-send-email-heiko@sntech.de>
References: <1409958374-30937-1-git-send-email-heiko@sntech.de>
Message-ID: <1409958374-30937-5-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rockchip SoCs contain clocks tightly bound to the armclk, where the best
rate / divider is supplied by the vendor after careful measuring.
Often this ideal rate may be greater than the current rate.

Therefore prevent the ccf from trying to set these dividers itself by
setting them to read-only.

In the case of the rk3066, this also includes the aclk_cpu, which makes it
necessary to also split its direct child-clocks (pclk_cpu, hclk_cpu, ...)
into individual definitions for rk3066 and rk3188.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/clk/rockchip/clk-rk3188.c | 26 ++++++++++++++++++--------
 drivers/clk/rockchip/clk-rk3288.c | 18 +++++++++---------
 2 files changed, 27 insertions(+), 17 deletions(-)

diff --git a/drivers/clk/rockchip/clk-rk3188.c b/drivers/clk/rockchip/clk-rk3188.c
index 2b893da..f6e3a70 100644
--- a/drivers/clk/rockchip/clk-rk3188.c
+++ b/drivers/clk/rockchip/clk-rk3188.c
@@ -174,17 +174,10 @@ static struct rockchip_clk_branch common_clk_branches[] __initdata = {
 	GATE(0, "aclk_cpu", "aclk_cpu_pre", 0,
 			RK2928_CLKGATE_CON(0), 3, GFLAGS),
 
-	DIV(0, "pclk_cpu_pre", "aclk_cpu_pre", 0,
-			RK2928_CLKSEL_CON(1), 12, 2, DFLAGS | CLK_DIVIDER_POWER_OF_TWO),
 	GATE(0, "atclk_cpu", "pclk_cpu_pre", 0,
 			RK2928_CLKGATE_CON(0), 6, GFLAGS),
 	GATE(0, "pclk_cpu", "pclk_cpu_pre", 0,
 			RK2928_CLKGATE_CON(0), 5, GFLAGS),
-	DIV(0, "hclk_cpu_pre", "aclk_cpu_pre", 0,
-			RK2928_CLKSEL_CON(1), 8, 2, DFLAGS | CLK_DIVIDER_POWER_OF_TWO),
-	COMPOSITE_NOMUX(0, "hclk_ahb2apb", "hclk_cpu_pre", 0,
-			RK2928_CLKSEL_CON(1), 14, 2, DFLAGS | CLK_DIVIDER_POWER_OF_TWO,
-			RK2928_CLKGATE_CON(4), 9, GFLAGS),
 	GATE(0, "hclk_cpu", "hclk_cpu_pre", 0,
 			RK2928_CLKGATE_CON(0), 4, GFLAGS),
 
@@ -416,7 +409,17 @@ static struct rockchip_clk_branch rk3066a_clk_branches[] __initdata = {
 	COMPOSITE_NOGATE(0, "armclk", mux_armclk_p, 0,
 			RK2928_CLKSEL_CON(0), 8, 1, MFLAGS, 0, 5, DFLAGS),
 	DIVTBL(0, "aclk_cpu_pre", "armclk", 0,
-			RK2928_CLKSEL_CON(1), 0, 3, DFLAGS, div_aclk_cpu_t),
+			RK2928_CLKSEL_CON(1), 0, 3, DFLAGS | CLK_DIVIDER_READ_ONLY, div_aclk_cpu_t),
+	DIV(0, "pclk_cpu_pre", "aclk_cpu_pre", 0,
+			RK2928_CLKSEL_CON(1), 12, 2, DFLAGS | CLK_DIVIDER_POWER_OF_TWO
+							    | CLK_DIVIDER_READ_ONLY),
+	DIV(0, "hclk_cpu_pre", "aclk_cpu_pre", 0,
+			RK2928_CLKSEL_CON(1), 8, 2, DFLAGS | CLK_DIVIDER_POWER_OF_TWO
+							   | CLK_DIVIDER_READ_ONLY),
+	COMPOSITE_NOMUX(0, "hclk_ahb2apb", "hclk_cpu_pre", 0,
+			RK2928_CLKSEL_CON(1), 14, 2, DFLAGS | CLK_DIVIDER_POWER_OF_TWO
+							    | CLK_DIVIDER_READ_ONLY,
+			RK2928_CLKGATE_CON(4), 9, GFLAGS),
 
 	GATE(CORE_L2C, "core_l2c", "aclk_cpu", 0,
 			RK2928_CLKGATE_CON(9), 4, GFLAGS),
@@ -534,6 +537,13 @@ static struct rockchip_clk_branch rk3188_clk_branches[] __initdata = {
 	/* do not source aclk_cpu_pre from the apll, to keep complexity down */
 	COMPOSITE_NOGATE(0, "aclk_cpu_pre", mux_aclk_cpu_p, CLK_SET_RATE_NO_REPARENT,
 			RK2928_CLKSEL_CON(0), 5, 1, MFLAGS, 0, 5, DFLAGS),
+	DIV(0, "pclk_cpu_pre", "aclk_cpu_pre", 0,
+			RK2928_CLKSEL_CON(1), 12, 2, DFLAGS | CLK_DIVIDER_POWER_OF_TWO),
+	DIV(0, "hclk_cpu_pre", "aclk_cpu_pre", 0,
+			RK2928_CLKSEL_CON(1), 8, 2, DFLAGS | CLK_DIVIDER_POWER_OF_TWO),
+	COMPOSITE_NOMUX(0, "hclk_ahb2apb", "hclk_cpu_pre", 0,
+			RK2928_CLKSEL_CON(1), 14, 2, DFLAGS | CLK_DIVIDER_POWER_OF_TWO,
+			RK2928_CLKGATE_CON(4), 9, GFLAGS),
 
 	GATE(CORE_L2C, "core_l2c", "armclk", 0,
 			RK2928_CLKGATE_CON(9), 4, GFLAGS),
diff --git a/drivers/clk/rockchip/clk-rk3288.c b/drivers/clk/rockchip/clk-rk3288.c
index 4586578..f0a23a0 100644
--- a/drivers/clk/rockchip/clk-rk3288.c
+++ b/drivers/clk/rockchip/clk-rk3288.c
@@ -170,31 +170,31 @@ static struct rockchip_clk_branch rk3288_clk_branches[] __initdata = {
 			RK3288_CLKSEL_CON(0), 15, 1, MFLAGS, 8, 5, DFLAGS),
 
 	COMPOSITE_NOMUX(0, "armcore0", "armclk", 0,
-			RK3288_CLKSEL_CON(36), 0, 3, DFLAGS,
+			RK3288_CLKSEL_CON(36), 0, 3, DFLAGS | CLK_DIVIDER_READ_ONLY,
 			RK3288_CLKGATE_CON(12), 0, GFLAGS),
 	COMPOSITE_NOMUX(0, "armcore1", "armclk", 0,
-			RK3288_CLKSEL_CON(36), 4, 3, DFLAGS,
+			RK3288_CLKSEL_CON(36), 4, 3, DFLAGS | CLK_DIVIDER_READ_ONLY,
 			RK3288_CLKGATE_CON(12), 1, GFLAGS),
 	COMPOSITE_NOMUX(0, "armcore2", "armclk", 0,
-			RK3288_CLKSEL_CON(36), 8, 3, DFLAGS,
+			RK3288_CLKSEL_CON(36), 8, 3, DFLAGS | CLK_DIVIDER_READ_ONLY,
 			RK3288_CLKGATE_CON(12), 2, GFLAGS),
 	COMPOSITE_NOMUX(0, "armcore3", "armclk", 0,
-			RK3288_CLKSEL_CON(36), 12, 3, DFLAGS,
+			RK3288_CLKSEL_CON(36), 12, 3, DFLAGS | CLK_DIVIDER_READ_ONLY,
 			RK3288_CLKGATE_CON(12), 3, GFLAGS),
 	COMPOSITE_NOMUX(0, "l2ram", "armclk", 0,
-			RK3288_CLKSEL_CON(37), 0, 3, DFLAGS,
+			RK3288_CLKSEL_CON(37), 0, 3, DFLAGS | CLK_DIVIDER_READ_ONLY,
 			RK3288_CLKGATE_CON(12), 4, GFLAGS),
 	COMPOSITE_NOMUX(0, "aclk_core_m0", "armclk", 0,
-			RK3288_CLKSEL_CON(0), 0, 4, DFLAGS,
+			RK3288_CLKSEL_CON(0), 0, 4, DFLAGS | CLK_DIVIDER_READ_ONLY,
 			RK3288_CLKGATE_CON(12), 5, GFLAGS),
 	COMPOSITE_NOMUX(0, "aclk_core_mp", "armclk", 0,
-			RK3288_CLKSEL_CON(0), 4, 4, DFLAGS,
+			RK3288_CLKSEL_CON(0), 4, 4, DFLAGS | CLK_DIVIDER_READ_ONLY,
 			RK3288_CLKGATE_CON(12), 6, GFLAGS),
 	COMPOSITE_NOMUX(0, "atclk", "armclk", 0,
-			RK3288_CLKSEL_CON(37), 4, 5, DFLAGS,
+			RK3288_CLKSEL_CON(37), 4, 5, DFLAGS | CLK_DIVIDER_READ_ONLY,
 			RK3288_CLKGATE_CON(12), 7, GFLAGS),
 	COMPOSITE_NOMUX(0, "pclk_dbg_pre", "armclk", 0,
-			RK3288_CLKSEL_CON(37), 9, 5, DFLAGS,
+			RK3288_CLKSEL_CON(37), 9, 5, DFLAGS | CLK_DIVIDER_READ_ONLY,
 			RK3288_CLKGATE_CON(12), 8, GFLAGS),
 	GATE(0, "pclk_dbg", "pclk_dbg_pre", 0,
 			RK3288_CLKGATE_CON(12), 9, GFLAGS),
-- 
2.0.1
