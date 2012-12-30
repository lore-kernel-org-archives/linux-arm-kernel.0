From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Sat, 29 Dec 2012 16:33:40 -0800
Subject: [PATCH v5 11/12] ARM: Exynos: use fin_pll clock as the tick clock
 source for mct
In-Reply-To: <1356827621-27617-1-git-send-email-thomas.abraham@linaro.org>
References: <1356827621-27617-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1356827621-27617-12-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the migration of Exynos4 clocks to use common clock framework, the old
styled 'xtal' clock is not used anymore. Instead, the clock 'fin_pll' is used
as the tick clock for mct controller.

Cc: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 arch/arm/mach-exynos/mct.c |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-exynos/mct.c b/arch/arm/mach-exynos/mct.c
index 448ce86..71e1502 100644
--- a/arch/arm/mach-exynos/mct.c
+++ b/arch/arm/mach-exynos/mct.c
@@ -487,10 +487,22 @@ static struct local_timer_ops exynos4_mct_tick_ops __cpuinitdata = {
 
 static void __init exynos4_timer_resources(struct device_node *np)
 {
+#ifdef CONFIG_COMMON_CLK
+	struct clk *tick_clk;
+
+	tick_clk = clk_get(NULL, "fin_pll");
+	if (IS_ERR(tick_clk))
+		panic("%s: unable to determine tick clock rate\n", __func__);
+	clk_rate = clk_get_rate(tick_clk);
+#else
+	/*
+	 * todo: remove this legacy code after adding common clock support for
+	 * exynos5250.
+	 */
 	struct clk *mct_clk;
 	mct_clk = clk_get(NULL, "xtal");
-
 	clk_rate = clk_get_rate(mct_clk);
+#endif
 
 	reg_base = np ? of_iomap(np, 0) : S5P_VA_SYSTIMER;
 	if (!reg_base)
-- 
1.7.5.4
