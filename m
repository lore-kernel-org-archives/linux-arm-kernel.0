From: zhangqing@rock-chips.com (Elaine Zhang)
Date: Tue,  2 May 2017 15:34:05 +0800
Subject: [PATCH v3 3/4] clk: rockchip: rk3288: make noc and some special clk
 as critical_clocks
In-Reply-To: <1493710446-7203-1-git-send-email-zhangqing@rock-chips.com>
References: <1493710446-7203-1-git-send-email-zhangqing@rock-chips.com>
Message-ID: <1493710446-7203-4-git-send-email-zhangqing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The atclk\dbg\jtag\xin12m\pclk_core clks no driver to handle them.
But this clks need enable,so make it as critical.

The ddrupctl0\ddrupctl1\publ0\publ1 clks no driver to handle them,
Chip design requirements for these clock to always on,
The new document will update the description of these clock.

The pmu_hclk_otg0 is Chip design defect, must be always on,
The new document will update the description of this clock.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 drivers/clk/rockchip/clk-rk3288.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/rockchip/clk-rk3288.c b/drivers/clk/rockchip/clk-rk3288.c
index 68ba7d4105e7..450de24a1b42 100644
--- a/drivers/clk/rockchip/clk-rk3288.c
+++ b/drivers/clk/rockchip/clk-rk3288.c
@@ -292,13 +292,13 @@ enum rk3288_plls {
 	COMPOSITE_NOMUX(0, "aclk_core_mp", "armclk", CLK_IGNORE_UNUSED,
 			RK3288_CLKSEL_CON(0), 4, 4, DFLAGS | CLK_DIVIDER_READ_ONLY,
 			RK3288_CLKGATE_CON(12), 6, GFLAGS),
-	COMPOSITE_NOMUX(0, "atclk", "armclk", 0,
+	COMPOSITE_NOMUX(0, "atclk", "armclk", CLK_IGNORE_UNUSED,
 			RK3288_CLKSEL_CON(37), 4, 5, DFLAGS | CLK_DIVIDER_READ_ONLY,
 			RK3288_CLKGATE_CON(12), 7, GFLAGS),
 	COMPOSITE_NOMUX(0, "pclk_dbg_pre", "armclk", CLK_IGNORE_UNUSED,
 			RK3288_CLKSEL_CON(37), 9, 5, DFLAGS | CLK_DIVIDER_READ_ONLY,
 			RK3288_CLKGATE_CON(12), 8, GFLAGS),
-	GATE(0, "pclk_dbg", "pclk_dbg_pre", 0,
+	GATE(0, "pclk_dbg", "pclk_dbg_pre", CLK_IGNORE_UNUSED,
 			RK3288_CLKGATE_CON(12), 9, GFLAGS),
 	GATE(0, "cs_dbg", "pclk_dbg_pre", CLK_IGNORE_UNUSED,
 			RK3288_CLKGATE_CON(12), 10, GFLAGS),
@@ -626,7 +626,7 @@ enum rk3288_plls {
 	INVERTER(SCLK_HSADC, "sclk_hsadc", "sclk_hsadc_out",
 			RK3288_CLKSEL_CON(22), 7, IFLAGS),
 
-	GATE(0, "jtag", "ext_jtag", 0,
+	GATE(0, "jtag", "ext_jtag", CLK_IGNORE_UNUSED,
 			RK3288_CLKGATE_CON(4), 14, GFLAGS),
 
 	COMPOSITE_NODIV(SCLK_USBPHY480M_SRC, "usbphy480m_src", mux_usbphy480m_p, 0,
@@ -635,7 +635,7 @@ enum rk3288_plls {
 	COMPOSITE_NODIV(SCLK_HSICPHY480M, "sclk_hsicphy480m", mux_hsicphy480m_p, 0,
 			RK3288_CLKSEL_CON(29), 0, 2, MFLAGS,
 			RK3288_CLKGATE_CON(3), 6, GFLAGS),
-	GATE(0, "hsicphy12m_xin12m", "xin12m", 0,
+	GATE(0, "hsicphy12m_xin12m", "xin12m", CLK_IGNORE_UNUSED,
 			RK3288_CLKGATE_CON(13), 9, GFLAGS),
 	DIV(0, "hsicphy12m_usbphy", "sclk_hsicphy480m", 0,
 			RK3288_CLKSEL_CON(11), 8, 6, DFLAGS),
@@ -816,6 +816,12 @@ enum rk3288_plls {
 	"pclk_alive_niu",
 	"pclk_pd_pmu",
 	"pclk_pmu_niu",
+	"pclk_core_niu",
+	"pclk_ddrupctl0",
+	"pclk_publ0",
+	"pclk_ddrupctl1",
+	"pclk_publ1",
+	"pmu_hclk_otg0",
 };
 
 static void __iomem *rk3288_cru_base;
-- 
1.9.1
