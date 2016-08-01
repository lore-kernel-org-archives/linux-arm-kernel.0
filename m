From: zhengxing@rock-chips.com (Xing Zheng)
Date: Mon,  1 Aug 2016 17:58:23 +0800
Subject: [RESEND PATCH v2 8/8] clk: rockchip: rk3399: Add support frac mode
 frequencies
In-Reply-To: <1470045224-31854-1-git-send-email-zhengxing@rock-chips.com>
References: <1470045224-31854-1-git-send-email-zhengxing@rock-chips.com>
Message-ID: <1470045503-32062-1-git-send-email-zhengxing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need to support various display resolutions for external
display devices like HDMI/DP, the frac mode can help us to
acquire almost any frequencies, and need higher VCOs to reduce
clock jitters.

Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
---

Changes in v2:
- add the patch "fix incorrect parent for rk3399's {c,g}pll_aclk_perihp_src"
- add the patch "fix incorrect GATE bits for {c, g}pll_aclk_perihp_src"

 drivers/clk/rockchip/clk-rk3399.c |   21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk-rk3399.c b/drivers/clk/rockchip/clk-rk3399.c
index 071eb96..db8394b 100644
--- a/drivers/clk/rockchip/clk-rk3399.c
+++ b/drivers/clk/rockchip/clk-rk3399.c
@@ -109,6 +109,25 @@ static struct rockchip_pll_rate_table rk3399_pll_rates[] = {
 	{ /* sentinel */ },
 };
 
+static struct rockchip_pll_rate_table rk3399_pll_frates[] = {
+	/* _mhz, _refdiv, _fbdiv, _postdiv1, _postdiv2, _dsmpd, _frac */
+	RK3036_PLL_RATE( 594000000, 1, 123, 5, 1, 0, 12582912),  /* vco = 2970000000 */
+	RK3036_PLL_RATE( 593406593, 1, 123, 5, 1, 0, 10508804),  /* vco = 2967032965 */
+	RK3036_PLL_RATE( 297000000, 1, 123, 5, 2, 0, 12582912),  /* vco = 2970000000 */
+	RK3036_PLL_RATE( 296703297, 1, 123, 5, 2, 0, 10508807),  /* vco = 2967032970 */
+	RK3036_PLL_RATE( 148500000, 1, 129, 7, 3, 0, 15728640),  /* vco = 3118500000 */
+	RK3036_PLL_RATE( 148351648, 1, 123, 5, 4, 0, 10508800),  /* vco = 2967032960 */
+	RK3036_PLL_RATE( 106500000, 1, 124, 7, 4, 0,  4194304),  /* vco = 2982000000 */
+	RK3036_PLL_RATE(  74250000, 1, 129, 7, 6, 0, 15728640),  /* vco = 3118500000 */
+	RK3036_PLL_RATE(  74175824, 1, 129, 7, 6, 0, 13550823),  /* vco = 3115384608 */
+	RK3036_PLL_RATE(  65000000, 1, 113, 7, 6, 0, 12582912),  /* vco = 2730000000 */
+	RK3036_PLL_RATE(  59340659, 1, 121, 7, 7, 0,  2581098),  /* vco = 2907692291 */
+	RK3036_PLL_RATE(  54000000, 1, 110, 7, 7, 0,  4194304),  /* vco = 2646000000 */
+	RK3036_PLL_RATE(  27000000, 1,  55, 7, 7, 0,  2097152),  /* vco = 1323000000 */
+	RK3036_PLL_RATE(  26973027, 1,  55, 7, 7, 0,  1173232),  /* vco = 1321678323 */
+	{ /* sentinel */ },
+};
+
 /* CRU parents */
 PNAME(mux_pll_p)				= { "xin24m", "xin32k" };
 
@@ -229,7 +248,7 @@ static struct rockchip_pll_clock rk3399_pll_clks[] __initdata = {
 	[npll] = PLL(pll_rk3399, PLL_NPLL, "npll",  mux_pll_p, 0, RK3399_PLL_CON(40),
 		     RK3399_PLL_CON(43), 8, 31, ROCKCHIP_PLL_SYNC_RATE, rk3399_pll_rates),
 	[vpll] = PLL(pll_rk3399, PLL_VPLL, "vpll",  mux_pll_p, 0, RK3399_PLL_CON(48),
-		     RK3399_PLL_CON(51), 8, 31, ROCKCHIP_PLL_SYNC_RATE, rk3399_pll_rates),
+		     RK3399_PLL_CON(51), 8, 31, ROCKCHIP_PLL_SYNC_RATE, rk3399_pll_frates),
 };
 
 static struct rockchip_pll_clock rk3399_pmu_pll_clks[] __initdata = {
-- 
1.7.9.5
