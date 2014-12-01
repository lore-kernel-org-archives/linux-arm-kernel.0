From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 01 Dec 2014 10:12:54 +0100
Subject: [PATCH] clk: samsung: exynos4415: Fix build with PM_SLEEP disabled
Message-ID: <1417425174-26694-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix following build errors when PM_SLEEP is disabled (e.g. by disabling
SUSPEND and HIBERNATION):

drivers/clk/samsung/clk-exynos4415.c: In function ?exynos4415_cmu_init?:
drivers/clk/samsung/clk-exynos4415.c:982:2: error: ?exynos4415_ctx? undeclared (first use in this function)
drivers/clk/samsung/clk-exynos4415.c:982:2: note: each undeclared identifier is reported only once for each function it appears in
drivers/clk/samsung/clk-exynos4415.c: In function ?exynos4415_cmu_dmc_init?:
drivers/clk/samsung/clk-exynos4415.c:1123:2: error: ?exynos4415_dmc_ctx? undeclared (first use in this function)
make[3]: *** [drivers/clk/samsung/clk-exynos4415.o] Error 1

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/clk/samsung/clk-exynos4415.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos4415.c b/drivers/clk/samsung/clk-exynos4415.c
index c7208c7a3add..2123fc251e0f 100644
--- a/drivers/clk/samsung/clk-exynos4415.c
+++ b/drivers/clk/samsung/clk-exynos4415.c
@@ -118,12 +118,13 @@ enum exynos4415_plls {
 	nr_plls,
 };
 
+static struct samsung_clk_provider *exynos4415_ctx;
+
 /*
  * Support for CMU save/restore across system suspends
  */
 #ifdef CONFIG_PM_SLEEP
 static struct samsung_clk_reg_dump *exynos4415_clk_regs;
-static struct samsung_clk_provider *exynos4415_ctx;
 
 static unsigned long exynos4415_cmu_clk_regs[] __initdata = {
 	SRC_LEFTBUS,
@@ -1031,9 +1032,10 @@ enum exynos4415_dmc_plls {
 	nr_dmc_plls,
 };
 
+static struct samsung_clk_provider *exynos4415_dmc_ctx;
+
 #ifdef CONFIG_PM_SLEEP
 static struct samsung_clk_reg_dump *exynos4415_dmc_clk_regs;
-static struct samsung_clk_provider *exynos4415_dmc_ctx;
 
 static unsigned long exynos4415_cmu_dmc_clk_regs[] __initdata = {
 	MPLL_LOCK,
-- 
1.9.1
