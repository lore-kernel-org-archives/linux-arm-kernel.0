From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 20 Aug 2013 19:31:43 +0200
Subject: [PATCH 16/16] clk: samsung: exynos5250: Simplify registration of PLL
 rate tables
In-Reply-To: <1377019903-14614-1-git-send-email-t.figa@samsung.com>
References: <1377019903-14614-1-git-send-email-t.figa@samsung.com>
Message-ID: <1377019903-14614-17-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the _get_rate() helper has been modified to use __clk_lookup()
internally, checking of PLL input rates can be done using it and so the
registration code can be simplified.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/clk/samsung/clk-exynos5250.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5250.c b/drivers/clk/samsung/clk-exynos5250.c
index a9916a4..00a80e4 100644
--- a/drivers/clk/samsung/clk-exynos5250.c
+++ b/drivers/clk/samsung/clk-exynos5250.c
@@ -543,8 +543,6 @@ static struct of_device_id ext_clk_match[] __initdata = {
 static void __init exynos5250_clk_init(struct device_node *np)
 {
 	void __iomem *reg_base;
-	struct clk *vpllsrc;
-	unsigned long fin_pll_rate, mout_vpllsrc_rate = 0;
 
 	if (np) {
 		reg_base = of_iomap(np, 0);
@@ -563,16 +561,10 @@ static void __init exynos5250_clk_init(struct device_node *np)
 	samsung_clk_register_mux(exynos5250_pll_pmux_clks,
 				ARRAY_SIZE(exynos5250_pll_pmux_clks));
 
-	fin_pll_rate = _get_rate("fin_pll");
-
-	if (fin_pll_rate == 24 * MHZ)
+	if (_get_rate("fin_pll") == 24 * MHZ)
 		exynos5250_plls[epll].rate_table = epll_24mhz_tbl;
 
-	vpllsrc = __clk_lookup("mout_vpllsrc");
-	if (vpllsrc)
-		mout_vpllsrc_rate = clk_get_rate(vpllsrc);
-
-	if (mout_vpllsrc_rate == 24 * MHZ)
+	if (_get_rate("mout_vpllsrc") == 24 * MHZ)
 		exynos5250_plls[vpll].rate_table =  vpll_24mhz_tbl;
 
 	samsung_clk_register_pll(exynos5250_plls, ARRAY_SIZE(exynos5250_plls),
-- 
1.8.3.2
