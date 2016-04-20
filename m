From: zhengxing@rock-chips.com (Xing Zheng)
Date: Wed, 20 Apr 2016 19:11:32 +0800
Subject: [PATCH 5/6] clk: rockchip: rk3399: fix the cifout clock
In-Reply-To: <1461150414-29638-1-git-send-email-zhengxing@rock-chips.com>
References: <1461150414-29638-1-git-send-email-zhengxing@rock-chips.com>
Message-ID: <1461150692-29751-1-git-send-email-zhengxing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The cifout clock is incorrect due to the manual error, we need to
fix it.

Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
---

 drivers/clk/rockchip/clk-rk3399.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/rockchip/clk-rk3399.c b/drivers/clk/rockchip/clk-rk3399.c
index 1da4fe1..e81cc85 100644
--- a/drivers/clk/rockchip/clk-rk3399.c
+++ b/drivers/clk/rockchip/clk-rk3399.c
@@ -158,7 +158,7 @@ PNAME(mux_dclk_vop0_p)			= { "dclk_vop0_div",
 PNAME(mux_dclk_vop1_p)			= { "dclk_vop1_div",
 					    "dclk_vop1_frac" };
 
-PNAME(mux_clk_cif_p)			= { "clk_cifout_div", "xin24m" };
+PNAME(mux_clk_cif_p)				= { "clk_cifout_src", "xin24m" };
 
 PNAME(mux_pll_src_24m_usbphy480m_p)	= { "xin24m", "clk_usbphy_480m" };
 PNAME(mux_pll_src_24m_pciephy_p)	= { "xin24m", "clk_pciephy_ref100m" };
@@ -1254,11 +1254,12 @@ static struct rockchip_clk_branch rk3399_clk_branches[] __initdata = {
 			RK3399_CLKGATE_CON(27), 6, GFLAGS),
 
 	/* cif */
-	COMPOSITE(0, "clk_cifout_div", mux_pll_src_cpll_gpll_npll_p, 0,
-			RK3399_CLKSEL_CON(56), 6, 2, MFLAGS, 0, 5, DFLAGS,
+	COMPOSITE_NODIV(0, "clk_cifout_src", mux_pll_src_cpll_gpll_npll_p, 0,
+			RK3399_CLKSEL_CON(56), 6, 2, MFLAGS,
 			RK3399_CLKGATE_CON(10), 7, GFLAGS),
-	MUX(SCLK_CIF_OUT, "clk_cifout", mux_clk_cif_p, CLK_SET_RATE_PARENT,
-			RK3399_CLKSEL_CON(56), 5, 1, MFLAGS),
+
+	COMPOSITE_NOGATE(SCLK_CIF_OUT, "clk_cifout", mux_clk_cif_p, 0,
+			 RK3399_CLKSEL_CON(56), 5, 1, MFLAGS, 0, 5, DFLAGS),
 
 	/* gic */
 	COMPOSITE(ACLK_GIC_PRE, "aclk_gic_pre", mux_pll_src_cpll_gpll_p, CLK_IGNORE_UNUSED,
-- 
1.7.9.5
