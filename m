From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 30 Oct 2014 14:26:13 +0100
Subject: [PATCH] clk: rockchip: fix rk3188 hsadc_frac definition
Message-ID: <1711655.syFkKtShzb@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The arguments to COMPOSITE_FRAC for hsadc_frac were mangled, leaving out the
the general clock flags argument. This results in strange effects, as only
sometimes a zero-division is reported as the wrong register is read.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
We added the fraction divider handling in 3.18, so this should
go as fix into the current 3.18 to 

Mike, I don't see anymore fixes on the horizon currently, so I'm not sure
if you want a pull request for this one patch or apply it directly.

 drivers/clk/rockchip/clk-rk3188.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/rockchip/clk-rk3188.c b/drivers/clk/rockchip/clk-rk3188.c
index 0bc0e7d..b5c7c01 100644
--- a/drivers/clk/rockchip/clk-rk3188.c
+++ b/drivers/clk/rockchip/clk-rk3188.c
@@ -320,9 +320,9 @@ static struct rockchip_clk_branch common_clk_branches[] __initdata = {
 	COMPOSITE(0, "hsadc_src", mux_pll_src_gpll_cpll_p, 0,
 			RK2928_CLKSEL_CON(22), 0, 1, MFLAGS, 8, 8, DFLAGS,
 			RK2928_CLKGATE_CON(2), 6, GFLAGS),
-	COMPOSITE_FRAC(0, "hsadc_frac", "hsadc_src",
+	COMPOSITE_FRAC(0, "hsadc_frac", "hsadc_src", 0,
 			RK2928_CLKSEL_CON(23), 0,
-			RK2928_CLKGATE_CON(2), 7, 0, GFLAGS),
+			RK2928_CLKGATE_CON(2), 7, GFLAGS),
 	MUX(SCLK_HSADC, "sclk_hsadc", mux_sclk_hsadc_p, 0,
 			RK2928_CLKSEL_CON(22), 4, 2, MFLAGS),
 
-- 
2.0.1
