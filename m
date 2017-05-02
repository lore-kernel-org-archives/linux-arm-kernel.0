From: zhangqing@rock-chips.com (Elaine Zhang)
Date: Tue,  2 May 2017 15:34:04 +0800
Subject: [PATCH v3 2/4] clk: rockchip: rk3228: make noc and some special clk
 as critical_clocks
In-Reply-To: <1493710446-7203-1-git-send-email-zhangqing@rock-chips.com>
References: <1493710446-7203-1-git-send-email-zhangqing@rock-chips.com>
Message-ID: <1493710446-7203-3-git-send-email-zhangqing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The jtag\bus\peri\initmem\rom\stimer\phy clks no driver to handle them.
But this clks need enable,so make it as critical.

The ddrupctl\ddrmon\ddrphy clks no driver to handle them,
Chip design requirements for these clock to always on,
The new document will update the description of these clock.

The hclk_otg_pmu is Chip design defect, must be always on,
The new document will update the description of this clock.

All these non-noc\non-arbi clocks,IC suggest always on,
Because it's have some order limitation, between the NOC clock switch and bus IDLE(or pd on/off).
The software is not very good to slove  this constraint.
Always on these clocks, has no effect on the system power consumption.
The new document will update the description of these clock.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 drivers/clk/rockchip/clk-rk3228.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk-rk3228.c b/drivers/clk/rockchip/clk-rk3228.c
index db6e5a9e6de6..4d3203f887e2 100644
--- a/drivers/clk/rockchip/clk-rk3228.c
+++ b/drivers/clk/rockchip/clk-rk3228.c
@@ -445,7 +445,7 @@ enum rk3228_plls {
 			RK2928_CLKGATE_CON(2), 12, GFLAGS,
 			&rk3228_spdif_fracmux),
 
-	GATE(0, "jtag", "ext_jtag", 0,
+	GATE(0, "jtag", "ext_jtag", CLK_IGNORE_UNUSED,
 			RK2928_CLKGATE_CON(1), 3, GFLAGS),
 
 	GATE(0, "sclk_otgphy0", "xin24m", 0,
@@ -644,9 +644,37 @@ enum rk3228_plls {
 
 static const char *const rk3228_critical_clocks[] __initconst = {
 	"aclk_cpu",
+	"pclk_cpu",
+	"hclk_cpu",
 	"aclk_peri",
 	"hclk_peri",
 	"pclk_peri",
+	"aclk_rga_noc",
+	"aclk_iep_noc",
+	"aclk_vop_noc",
+	"aclk_hdcp_noc",
+	"hclk_vio_ahb_arbi",
+	"hclk_vio_noc",
+	"hclk_vop_noc",
+	"hclk_host0_arb",
+	"hclk_host1_arb",
+	"hclk_host2_arb",
+	"hclk_otg_pmu",
+	"aclk_gpu_noc",
+	"sclk_initmem_mbist",
+	"aclk_initmem",
+	"hclk_rom",
+	"pclk_ddrupctl",
+	"pclk_ddrmon",
+	"pclk_msch_noc",
+	"pclk_stimer",
+	"pclk_ddrphy",
+	"pclk_acodecphy",
+	"pclk_phy_noc",
+	"aclk_vpu_noc",
+	"aclk_rkvdec_noc",
+	"hclk_vpu_noc",
+	"hclk_rkvdec_noc",
 };
 
 static void __init rk3228_clk_init(struct device_node *np)
-- 
1.9.1
