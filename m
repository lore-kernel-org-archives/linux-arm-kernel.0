From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 20 Aug 2013 19:31:40 +0200
Subject: [PATCH 13/16] clk: samsung: exynos4: Reorder registration of
 mout_vpllsrc
In-Reply-To: <1377019903-14614-1-git-send-email-t.figa@samsung.com>
References: <1377019903-14614-1-git-send-email-t.figa@samsung.com>
Message-ID: <1377019903-14614-14-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since PLL input frequency must be known before PLL registration,
mout_vpllsrc clock which is a reference clock of VPLL must be registered
before VPLL.

This patch reorders clock registration to register mout_vpllsrc before
VPLL.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/clk/samsung/clk-exynos4.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/samsung/clk-exynos4.c b/drivers/clk/samsung/clk-exynos4.c
index 42a4001..34474ce 100644
--- a/drivers/clk/samsung/clk-exynos4.c
+++ b/drivers/clk/samsung/clk-exynos4.c
@@ -380,12 +380,15 @@ static struct samsung_mux_clock exynos4_mux_clks[] __initdata = {
 };
 
 /* list of mux clocks supported in exynos4210 soc */
+static struct samsung_mux_clock exynos4210_mux_early[] __initdata = {
+	MUX(none, "mout_vpllsrc", mout_vpllsrc_p, SRC_TOP1, 0, 1),
+};
+
 static struct samsung_mux_clock exynos4210_mux_clks[] __initdata = {
 	MUX(none, "mout_aclk200", sclk_ampll_p4210, SRC_TOP0, 12, 1),
 	MUX(none, "mout_aclk100", sclk_ampll_p4210, SRC_TOP0, 16, 1),
 	MUX(none, "mout_aclk160", sclk_ampll_p4210, SRC_TOP0, 20, 1),
 	MUX(none, "mout_aclk133", sclk_ampll_p4210, SRC_TOP0, 24, 1),
-	MUX(none, "mout_vpllsrc", mout_vpllsrc_p, SRC_TOP1, 0, 1),
 	MUX(none, "mout_mixer", mout_mixer_p4210, SRC_TV, 4, 1),
 	MUX(none, "mout_dac", mout_dac_p4210, SRC_TV, 8, 1),
 	MUX(none, "mout_g2d0", sclk_ampll_p4210, E4210_SRC_IMAGE, 0, 1),
@@ -1036,6 +1039,9 @@ static void __init exynos4_clk_init(struct device_node *np,
 	exynos4_clk_register_finpll(xom);
 
 	if (exynos4_soc == EXYNOS4210) {
+		samsung_clk_register_mux(exynos4210_mux_early,
+					ARRAY_SIZE(exynos4210_mux_early));
+
 		samsung_clk_register_pll(exynos4210_plls,
 					ARRAY_SIZE(exynos4210_plls), reg_base);
 	} else {
-- 
1.8.3.2
