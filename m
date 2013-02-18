From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Mon, 18 Feb 2013 13:51:21 +0530
Subject: [PATCH v6 11/16] clocksource: mct: add support for mct clock setup
In-Reply-To: <1361175686-19400-1-git-send-email-thomas.abraham@linaro.org>
References: <1361175686-19400-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1361175686-19400-12-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for mct clock lookup and setup to ensure that the mct clock
is has been turned on.

Cc: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 drivers/clocksource/exynos_mct.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index 8f84c42..43e39b5 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -480,7 +480,7 @@ static struct local_timer_ops exynos4_mct_tick_ops __cpuinitdata = {
 
 static void __init exynos4_timer_resources(struct device_node *np)
 {
-	struct clk *tick_clk;
+	struct clk *mct_clk, *tick_clk;
 
 	tick_clk = np ? of_clk_get_by_name(np, "fin_pll") :
 				clk_get(NULL, "fin_pll");
@@ -488,6 +488,11 @@ static void __init exynos4_timer_resources(struct device_node *np)
 		panic("%s: unable to determine tick clock rate\n", __func__);
 	clk_rate = clk_get_rate(tick_clk);
 
+	mct_clk = np ? of_clk_get_by_name(np, "mct") : clk_get(NULL, "mct");
+	if (IS_ERR(mct_clk))
+		panic("%s: unable to retrieve mct clock instance\n", __func__);
+	clk_prepare_enable(mct_clk);
+
 	reg_base = np ? of_iomap(np, 0) : S5P_VA_SYSTIMER;
 	if (!reg_base)
 		panic("%s: unable to ioremap mct address space\n", __func__);
-- 
1.7.5.4
