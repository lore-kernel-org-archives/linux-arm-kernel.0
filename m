From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 22 Dec 2015 22:28:02 +0100
Subject: [PATCH v2 5/5] clk: rockchip: Allow the RK3288 SPDIF clocks to change
 their parent
In-Reply-To: <1450819682-4932-1-git-send-email-heiko@sntech.de>
References: <1450819682-4932-1-git-send-email-heiko@sntech.de>
Message-ID: <1450819682-4932-6-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sjoerd Simons <sjoerd.simons@collabora.co.uk>

The clock branches leading to sclk_spdif and sclk_spdif_8ch on RK3288
SoCs only feed those clocks, allow those clocks to change their parents
all the way up the hierarchy.

Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/clk/rockchip/clk-rk3288.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/rockchip/clk-rk3288.c b/drivers/clk/rockchip/clk-rk3288.c
index e0bb0f0..80065e6 100644
--- a/drivers/clk/rockchip/clk-rk3288.c
+++ b/drivers/clk/rockchip/clk-rk3288.c
@@ -317,25 +317,25 @@ static struct rockchip_clk_branch rk3288_clk_branches[] __initdata = {
 
 	MUX(0, "spdif_src", mux_pll_src_cpll_gpll_p, 0,
 			RK3288_CLKSEL_CON(5), 15, 1, MFLAGS),
-	COMPOSITE_NOMUX(0, "spdif_pre", "spdif_src", 0,
+	COMPOSITE_NOMUX(0, "spdif_pre", "spdif_src", CLK_SET_RATE_PARENT,
 			RK3288_CLKSEL_CON(5), 0, 7, DFLAGS,
 			RK3288_CLKGATE_CON(4), 4, GFLAGS),
-	COMPOSITE_FRACMUX(0, "spdif_frac", "spdif_src", 0,
+	COMPOSITE_FRACMUX(0, "spdif_frac", "spdif_src", CLK_SET_RATE_PARENT,
 			RK3288_CLKSEL_CON(9), 0,
 			RK3288_CLKGATE_CON(4), 5, GFLAGS,
-		MUX(0, "spdif_mux", mux_spdif_p, 0,
+		MUX(0, "spdif_mux", mux_spdif_p, CLK_SET_RATE_PARENT,
 				RK3288_CLKSEL_CON(5), 8, 2, MFLAGS)),
-	GATE(SCLK_SPDIF, "sclk_spdif", "spdif_mux", 0,
+	GATE(SCLK_SPDIF, "sclk_spdif", "spdif_mux", CLK_SET_RATE_PARENT,
 			RK3288_CLKGATE_CON(4), 6, GFLAGS),
-	COMPOSITE_NOMUX(0, "spdif_8ch_pre", "spdif_src", 0,
+	COMPOSITE_NOMUX(0, "spdif_8ch_pre", "spdif_src", CLK_SET_RATE_PARENT,
 			RK3288_CLKSEL_CON(40), 0, 7, DFLAGS,
 			RK3288_CLKGATE_CON(4), 7, GFLAGS),
-	COMPOSITE_FRACMUX(0, "spdif_8ch_frac", "spdif_8ch_pre", 0,
+	COMPOSITE_FRACMUX(0, "spdif_8ch_frac", "spdif_8ch_pre", CLK_SET_RATE_PARENT,
 			RK3288_CLKSEL_CON(41), 0,
 			RK3288_CLKGATE_CON(4), 8, GFLAGS,
-		MUX(0, "spdif_8ch_mux", mux_spdif_8ch_p, 0,
+		MUX(0, "spdif_8ch_mux", mux_spdif_8ch_p, CLK_SET_RATE_PARENT,
 				RK3288_CLKSEL_CON(40), 8, 2, MFLAGS)),
-	GATE(SCLK_SPDIF8CH, "sclk_spdif_8ch", "spdif_8ch_mux", 0,
+	GATE(SCLK_SPDIF8CH, "sclk_spdif_8ch", "spdif_8ch_mux", CLK_SET_RATE_PARENT,
 			RK3288_CLKGATE_CON(4), 9, GFLAGS),
 
 	GATE(0, "sclk_acc_efuse", "xin24m", 0,
-- 
2.6.4
