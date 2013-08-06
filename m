From: chander.kashyap@linaro.org (Chander Kashyap)
Date: Tue,  6 Aug 2013 14:04:25 +0530
Subject: [RFC PATCH 3/3] clk: Exynos5250: Add alternate parent name for
 mout_cpu
In-Reply-To: <1375778065-21808-1-git-send-email-chander.kashyap@linaro.org>
References: <1375778065-21808-1-git-send-email-chander.kashyap@linaro.org>
Message-ID: <1375778065-21808-4-git-send-email-chander.kashyap@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Temporary parent migration is required during cpu frequency scaling. Hence
this patch adds support to supply alternate parent name for cpu clock i.e.
"mout_cpu".

Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
---
 drivers/clk/samsung/clk-exynos5250.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5250.c b/drivers/clk/samsung/clk-exynos5250.c
index 6f767c5..bfd96ba 100644
--- a/drivers/clk/samsung/clk-exynos5250.c
+++ b/drivers/clk/samsung/clk-exynos5250.c
@@ -209,10 +209,14 @@ struct samsung_fixed_factor_clock exynos5250_fixed_factor_clks[] __initdata = {
 };
 
 struct samsung_mux_clock exynos5250_mux_clks[] __initdata = {
-	MUX_A(none, "mout_apll", mout_apll_p, SRC_CPU, 0, 1, "mout_apll"),
-	MUX_A(none, "mout_cpu", mout_cpu_p, SRC_CPU, 16, 1, "mout_cpu"),
+	MUX_FA(none, "mout_apll", mout_apll_p, SRC_CPU, 0, 1,
+			CLK_SET_RATE_PARENT, 0, "mout_apll", NULL),
+	MUX_FA(none, "mout_cpu", mout_cpu_p, SRC_CPU, 16, 1,
+			CLK_SET_RATE_PARENT | CLK_SET_RATE_ALTERNATE,
+			0, "mout_cpu", "sclk_mpll"),
 	MUX(none, "mout_mpll_fout", mout_mpll_fout_p, PLL_DIV2_SEL, 4, 1),
-	MUX_A(none, "sclk_mpll", mout_mpll_p, SRC_CORE1, 8, 1, "mout_mpll"),
+	MUX_FA(none, "sclk_mpll", mout_mpll_p, SRC_CORE1, 8, 1,
+			CLK_SET_RATE_PARENT, 0, "mout_mpll", NULL),
 	MUX(none, "mout_bpll_fout", mout_bpll_fout_p, PLL_DIV2_SEL, 0, 1),
 	MUX(none, "sclk_bpll", mout_bpll_p, SRC_CDREX, 0, 1),
 	MUX(none, "mout_vpllsrc", mout_vpllsrc_p, SRC_TOP2, 0, 1),
-- 
1.7.9.5
