From: hl@rock-chips.com (Lin Huang)
Date: Wed,  1 Jun 2016 17:35:37 +0800
Subject: [RFC PATCH 2/4] clk: rockchip: rk3399: add ddrc clock support
In-Reply-To: <1464773739-18152-1-git-send-email-hl@rock-chips.com>
References: <1464773739-18152-1-git-send-email-hl@rock-chips.com>
Message-ID: <1464773739-18152-3-git-send-email-hl@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add ddrc clock setting, so we can do ddr frequency
scaling on rk3399 platform in future.

Signed-off-by: Lin Huang <hl@rock-chips.com>
---
 drivers/clk/rockchip/clk-rk3399.c      | 16 ++++++++++++++++
 include/dt-bindings/clock/rk3399-cru.h |  1 +
 2 files changed, 17 insertions(+)

diff --git a/drivers/clk/rockchip/clk-rk3399.c b/drivers/clk/rockchip/clk-rk3399.c
index f1d8e44..749ea59 100644
--- a/drivers/clk/rockchip/clk-rk3399.c
+++ b/drivers/clk/rockchip/clk-rk3399.c
@@ -118,6 +118,10 @@ PNAME(mux_armclkb_p)				= { "clk_core_b_lpll_src",
 						    "clk_core_b_bpll_src",
 						    "clk_core_b_dpll_src",
 						    "clk_core_b_gpll_src" };
+PNAME(mux_ddrclk_p)				= { "clk_ddrc_lpll_src",
+						    "clk_ddrc_bpll_src",
+						    "clk_ddrc_dpll_src",
+						    "clk_ddrc_gpll_src" };
 PNAME(mux_aclk_cci_p)				= { "cpll_aclk_cci_src",
 						    "gpll_aclk_cci_src",
 						    "npll_aclk_cci_src",
@@ -1377,6 +1381,18 @@ static struct rockchip_clk_branch rk3399_clk_branches[] __initdata = {
 	COMPOSITE_NOMUX(0, "clk_test", "clk_test_pre", CLK_IGNORE_UNUSED,
 			RK3368_CLKSEL_CON(58), 0, 5, DFLAGS,
 			RK3368_CLKGATE_CON(13), 11, GFLAGS),
+
+	/* ddrc */
+	GATE(0, "clk_ddrc_lpll_src", "lpll", CLK_IGNORE_UNUSED,
+	     RK3399_CLKGATE_CON(3), 0, GFLAGS),
+	GATE(0, "clk_ddrc_bpll_src", "bpll", CLK_IGNORE_UNUSED,
+	     RK3399_CLKGATE_CON(3), 1, GFLAGS),
+	GATE(0, "clk_ddrc_dpll_src", "dpll", CLK_IGNORE_UNUSED,
+	     RK3399_CLKGATE_CON(3), 2, GFLAGS),
+	GATE(0, "clk_ddrc_gpll_src", "gpll", CLK_IGNORE_UNUSED,
+	     RK3399_CLKGATE_CON(3), 3, GFLAGS),
+	COMPOSITE_DDRC(SCLK_DDRCLK, "clk_ddrc", mux_ddrclk_p, CLK_IGNORE_UNUSED,
+		       RK3399_CLKSEL_CON(6), 4, 2, MFLAGS, 0, 3, DFLAGS),
 };
 
 static struct rockchip_clk_branch rk3399_clk_pmu_branches[] __initdata = {
diff --git a/include/dt-bindings/clock/rk3399-cru.h b/include/dt-bindings/clock/rk3399-cru.h
index 50a44cf..8a0f0442 100644
--- a/include/dt-bindings/clock/rk3399-cru.h
+++ b/include/dt-bindings/clock/rk3399-cru.h
@@ -131,6 +131,7 @@
 #define SCLK_DPHY_RX0_CFG		165
 #define SCLK_RMII_SRC			166
 #define SCLK_PCIEPHY_REF100M		167
+#define SCLK_DDRCLK			168
 
 #define DCLK_VOP0			180
 #define DCLK_VOP1			181
-- 
1.9.1
