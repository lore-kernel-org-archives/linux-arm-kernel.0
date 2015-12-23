From: zhengxing@rock-chips.com (Xing Zheng)
Date: Wed, 23 Dec 2015 17:05:55 +0800
Subject: [PATCH 2/2] clk: rockchip: rk3036: fix and add node id for emac clock
In-Reply-To: <1450861555-11213-1-git-send-email-zhengxing@rock-chips.com>
References: <1450861555-11213-1-git-send-email-zhengxing@rock-chips.com>
Message-ID: <1450861555-11213-2-git-send-email-zhengxing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Due to referred old version TRM, there is incorrect emac clock node,
we should fix it. The SEL_21_9 is the parent of SEL_21_4.

In the emac driver, we need to refer HCLK_MAC, and because There are
only 3PLLs (APLL/GPLL/DPLL) on the rk3036, most clock are under the
GPLL, and it is unable to provide the accurate rate for mac_ref which
need to 50MHz probability, we should let it under the APLL and are
able to set the freq which integer multiples of 50MHz, so we add these
emac node for reference.

Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
---

 drivers/clk/rockchip/clk-rk3036.c      |   11 ++++++-----
 include/dt-bindings/clock/rk3036-cru.h |    2 ++
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/rockchip/clk-rk3036.c b/drivers/clk/rockchip/clk-rk3036.c
index 1016836..92426b0 100644
--- a/drivers/clk/rockchip/clk-rk3036.c
+++ b/drivers/clk/rockchip/clk-rk3036.c
@@ -328,13 +328,14 @@ static struct rockchip_clk_branch rk3036_clk_branches[] __initdata = {
 			RK2928_CLKSEL_CON(16), 0, 2, MFLAGS, 2, 5, DFLAGS,
 			RK2928_CLKGATE_CON(10), 5, GFLAGS),
 
-	COMPOSITE_NOGATE(0, "mac_pll_src", mux_pll_src_3plls_p, 0,
-			RK2928_CLKSEL_CON(21), 0, 2, MFLAGS, 4, 5, DFLAGS),
+	MUX(SCLK_MACPLL, "mac_pll_pre", mux_pll_src_3plls_p, 0,
+			RK2928_CLKSEL_CON(21), 0, 2, MFLAGS),
+	DIV(0, "mac_pll_src", "mac_pll_pre", 0,
+			RK2928_CLKSEL_CON(21), 9, 5, DFLAGS),
 	MUX(SCLK_MACREF, "mac_clk_ref", mux_mac_p, CLK_SET_RATE_PARENT,
 			RK2928_CLKSEL_CON(21), 3, 1, MFLAGS),
-
 	COMPOSITE_NOMUX(SCLK_MAC, "mac_clk", "mac_clk_ref", 0,
-			RK2928_CLKSEL_CON(21), 9, 5, DFLAGS,
+			RK2928_CLKSEL_CON(21), 4, 5, DFLAGS,
 			RK2928_CLKGATE_CON(2), 6, GFLAGS),
 
 	MUX(SCLK_HDMI, "dclk_hdmi", mux_dclk_p, 0,
@@ -389,7 +390,7 @@ static struct rockchip_clk_branch rk3036_clk_branches[] __initdata = {
 	GATE(HCLK_OTG1, "hclk_otg1", "hclk_peri", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(7), 3, GFLAGS),
 	GATE(HCLK_I2S, "hclk_i2s", "hclk_peri", 0, RK2928_CLKGATE_CON(7), 2, GFLAGS),
 	GATE(0, "hclk_sfc", "hclk_peri", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(3), 14, GFLAGS),
-	GATE(0, "hclk_mac", "hclk_peri", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(3), 15, GFLAGS),
+	GATE(HCLK_MAC, "hclk_mac", "hclk_peri", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(3), 15, GFLAGS),
 
 	/* pclk_peri gates */
 	GATE(0, "pclk_peri_matrix", "pclk_peri", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(4), 1, GFLAGS),
diff --git a/include/dt-bindings/clock/rk3036-cru.h b/include/dt-bindings/clock/rk3036-cru.h
index ebc7a7b..de44109 100644
--- a/include/dt-bindings/clock/rk3036-cru.h
+++ b/include/dt-bindings/clock/rk3036-cru.h
@@ -54,6 +54,7 @@
 #define SCLK_PVTM_VIDEO		125
 #define SCLK_MAC		151
 #define SCLK_MACREF		152
+#define SCLK_MACPLL		153
 #define SCLK_SFC		160
 
 /* aclk gates */
@@ -92,6 +93,7 @@
 #define HCLK_SDMMC		456
 #define HCLK_SDIO		457
 #define HCLK_EMMC		459
+#define HCLK_MAC		460
 #define HCLK_I2S		462
 #define HCLK_LCDC		465
 #define HCLK_ROM		467
-- 
1.7.9.5
