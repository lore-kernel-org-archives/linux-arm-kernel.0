From: zyw@rock-chips.com (Chris Zhong)
Date: Tue,  9 Aug 2016 11:02:33 -0700
Subject: [v2 PATCH] clk: rockchip: mark rk3399 hdcp_noc and vio_noc as critical
Message-ID: <1470765753-11619-1-git-send-email-zyw@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix incorrect rk3399 aclk_vio gating bit, it should be 0, not 10. With
this modification, the aclk_vio_noc should be put into critical list,
since it is required by VOP.
And the Type-C DP need these clocks: aclk_hdcp_noc, hclk_hdcp_noc,
pclk_hdcp_noc. Mark them as critical to avoid someone close them.

Signed-off-by: Chris Zhong <zyw@rock-chips.com>
---

 drivers/clk/rockchip/clk-rk3399.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk-rk3399.c b/drivers/clk/rockchip/clk-rk3399.c
index b173711a..676b017 100644
--- a/drivers/clk/rockchip/clk-rk3399.c
+++ b/drivers/clk/rockchip/clk-rk3399.c
@@ -1073,7 +1073,7 @@ static struct rockchip_clk_branch rk3399_clk_branches[] __initdata = {
 	/* vio */
 	COMPOSITE(ACLK_VIO, "aclk_vio", mux_pll_src_cpll_gpll_ppll_p, CLK_IGNORE_UNUSED,
 			RK3399_CLKSEL_CON(42), 6, 2, MFLAGS, 0, 5, DFLAGS,
-			RK3399_CLKGATE_CON(11), 10, GFLAGS),
+			RK3399_CLKGATE_CON(11), 0, GFLAGS),
 	COMPOSITE_NOMUX(PCLK_VIO, "pclk_vio", "aclk_vio", 0,
 			RK3399_CLKSEL_CON(43), 0, 5, DFLAGS,
 			RK3399_CLKGATE_CON(11), 1, GFLAGS),
@@ -1470,6 +1470,9 @@ static const char *const rk3399_cru_critical_clocks[] __initconst = {
 	"aclk_cci_pre",
 	"aclk_gic",
 	"aclk_gic_noc",
+	"aclk_hdcp_noc",
+	"hclk_hdcp_noc",
+	"pclk_hdcp_noc",
 	"pclk_perilp0",
 	"pclk_perilp0",
 	"hclk_perilp0",
@@ -1489,6 +1492,7 @@ static const char *const rk3399_cru_critical_clocks[] __initconst = {
 	"gpll_hclk_perilp1_src",
 	"gpll_aclk_perilp0_src",
 	"gpll_aclk_perihp_src",
+	"aclk_vio_noc",
 };
 
 static const char *const rk3399_pmucru_critical_clocks[] __initconst = {
-- 
1.9.1
