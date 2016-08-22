From: hl@rock-chips.com (Lin Huang)
Date: Mon, 22 Aug 2016 11:36:19 +0800
Subject: [PATCH v7 3/8] clk: rockchip: rk3399: add ddrc clock support
In-Reply-To: <1471836984-6316-1-git-send-email-hl@rock-chips.com>
References: <1471836984-6316-1-git-send-email-hl@rock-chips.com>
Message-ID: <1471836984-6316-4-git-send-email-hl@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add ddrc clock setting, so we can do ddr frequency
scaling on rk3399 platform in future.

Signed-off-by: Lin Huang <hl@rock-chips.com>
---
Changes in v7:
- change SCLK_DDRC name from clk_ddrc to sclk_ddrc

Changes in v6:
- None

Changes in v5:
- fit for the ddr type

Changes in v4:
- None

Changes in v3:
- None

Changes in v2:
- remove clk_ddrc_dpll_src from critical clock list

Changes in v1:
- remove ddrc source CLK_IGNORE_UNUSED flag
- move clk_ddrc and clk_ddrc_dpll_src to critical

 drivers/clk/rockchip/clk-rk3399.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/clk/rockchip/clk-rk3399.c b/drivers/clk/rockchip/clk-rk3399.c
index e445cd6..134bd18 100644
--- a/drivers/clk/rockchip/clk-rk3399.c
+++ b/drivers/clk/rockchip/clk-rk3399.c
@@ -120,6 +120,10 @@ PNAME(mux_armclkb_p)				= { "clk_core_b_lpll_src",
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
@@ -1379,6 +1383,18 @@ static struct rockchip_clk_branch rk3399_clk_branches[] __initdata = {
 	COMPOSITE_NOMUX(0, "clk_test", "clk_test_pre", CLK_IGNORE_UNUSED,
 			RK3368_CLKSEL_CON(58), 0, 5, DFLAGS,
 			RK3368_CLKGATE_CON(13), 11, GFLAGS),
+
+	/* ddrc */
+	GATE(0, "clk_ddrc_lpll_src", "lpll", 0, RK3399_CLKGATE_CON(3),
+	     0, GFLAGS),
+	GATE(0, "clk_ddrc_bpll_src", "bpll", 0, RK3399_CLKGATE_CON(3),
+	     1, GFLAGS),
+	GATE(0, "clk_ddrc_dpll_src", "dpll", 0, RK3399_CLKGATE_CON(3),
+	     2, GFLAGS),
+	GATE(0, "clk_ddrc_gpll_src", "gpll", 0, RK3399_CLKGATE_CON(3),
+	     3, GFLAGS),
+	COMPOSITE_DDRCLK(SCLK_DDRC, "sclk_ddrc", mux_ddrclk_p, 0,
+		       RK3399_CLKSEL_CON(6), 4, 2, 0, 0, ROCKCHIP_DDRCLK_SIP),
 };
 
 static struct rockchip_clk_branch rk3399_clk_pmu_branches[] __initdata = {
@@ -1493,6 +1509,9 @@ static const char *const rk3399_cru_critical_clocks[] __initconst = {
 	"gpll_aclk_perilp0_src",
 	"gpll_aclk_perihp_src",
 	"aclk_vio_noc",
+
+	/* ddrc */
+	"sclk_ddrc"
 };
 
 static const char *const rk3399_pmucru_critical_clocks[] __initconst = {
-- 
2.6.6
