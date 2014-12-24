From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 24 Dec 2014 15:11 +0100
Subject: [PATCH] clk: rockchip: fix rk3066 pll lock bit location
Message-ID: <2140322.FD0TUOM80V@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The bit locations indicating the locking status of the plls on rk3066 are
shifted by one to the right when compared to the rk3188, bits [7:4] instead
of [8:5] on the rk3188, thus indicating the locking state of the wrong pll
or a completely different information in case of the gpll.

The recently introduced pll init code exposed that problem on some rk3066
boards when it tried to bring the boot-pll value in line with the value
from the rate table.

Fix this by defining separate pll definitions for rk3066 with the correct
locking indices.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/clk/rockchip/clk-rk3188.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/rockchip/clk-rk3188.c b/drivers/clk/rockchip/clk-rk3188.c
index c540789..4b4e090 100644
--- a/drivers/clk/rockchip/clk-rk3188.c
+++ b/drivers/clk/rockchip/clk-rk3188.c
@@ -210,6 +210,17 @@ PNAME(mux_sclk_hsadc_p)		= { "hsadc_src", "hsadc_frac", "ext_hsadc" };
 PNAME(mux_mac_p)		= { "gpll", "dpll" };
 PNAME(mux_sclk_macref_p)	= { "mac_src", "ext_rmii" };
 
+static struct rockchip_pll_clock rk3066_pll_clks[] __initdata = {
+	[apll] = PLL(pll_rk3066, PLL_APLL, "apll", mux_pll_p, 0, RK2928_PLL_CON(0),
+		     RK2928_MODE_CON, 0, 5, 0, rk3188_pll_rates),
+	[dpll] = PLL(pll_rk3066, PLL_DPLL, "dpll", mux_pll_p, 0, RK2928_PLL_CON(4),
+		     RK2928_MODE_CON, 4, 4, 0, NULL),
+	[cpll] = PLL(pll_rk3066, PLL_CPLL, "cpll", mux_pll_p, 0, RK2928_PLL_CON(8),
+		     RK2928_MODE_CON, 8, 6, ROCKCHIP_PLL_SYNC_RATE, rk3188_pll_rates),
+	[gpll] = PLL(pll_rk3066, PLL_GPLL, "gpll", mux_pll_p, 0, RK2928_PLL_CON(12),
+		     RK2928_MODE_CON, 12, 7, ROCKCHIP_PLL_SYNC_RATE, rk3188_pll_rates),
+};
+
 static struct rockchip_pll_clock rk3188_pll_clks[] __initdata = {
 	[apll] = PLL(pll_rk3066, PLL_APLL, "apll", mux_pll_p, 0, RK2928_PLL_CON(0),
 		     RK2928_MODE_CON, 0, 6, 0, rk3188_pll_rates),
@@ -735,8 +746,8 @@ static void __init rk3188_common_clk_init(struct device_node *np)
 static void __init rk3066a_clk_init(struct device_node *np)
 {
 	rk3188_common_clk_init(np);
-	rockchip_clk_register_plls(rk3188_pll_clks,
-				   ARRAY_SIZE(rk3188_pll_clks),
+	rockchip_clk_register_plls(rk3066_pll_clks,
+				   ARRAY_SIZE(rk3066_pll_clks),
 				   RK3066_GRF_SOC_STATUS);
 	rockchip_clk_register_branches(rk3066a_clk_branches,
 				  ARRAY_SIZE(rk3066a_clk_branches));
-- 
2.1.1
