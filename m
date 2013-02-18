From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Mon, 18 Feb 2013 13:51:20 +0530
Subject: [PATCH v6 10/16] clocksource: mct: use fin_pll clock as the tick
 clock source for mct
In-Reply-To: <1361175686-19400-1-git-send-email-thomas.abraham@linaro.org>
References: <1361175686-19400-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1361175686-19400-11-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the migration of Exynos4 clocks to use common clock framework, the old
styled 'xtal' clock is not used anymore. Instead, the clock 'fin_pll' is used
as the tick clock for mct controller.

Cc: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 drivers/clocksource/exynos_mct.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index e067130..8f84c42 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -480,10 +480,13 @@ static struct local_timer_ops exynos4_mct_tick_ops __cpuinitdata = {
 
 static void __init exynos4_timer_resources(struct device_node *np)
 {
-	struct clk *mct_clk;
-	mct_clk = clk_get(NULL, "xtal");
+	struct clk *tick_clk;
 
-	clk_rate = clk_get_rate(mct_clk);
+	tick_clk = np ? of_clk_get_by_name(np, "fin_pll") :
+				clk_get(NULL, "fin_pll");
+	if (IS_ERR(tick_clk))
+		panic("%s: unable to determine tick clock rate\n", __func__);
+	clk_rate = clk_get_rate(tick_clk);
 
 	reg_base = np ? of_iomap(np, 0) : S5P_VA_SYSTIMER;
 	if (!reg_base)
-- 
1.7.5.4
