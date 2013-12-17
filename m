From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 17 Dec 2013 10:56:39 +0100
Subject: [PATCH] clk: exynos: File scope reg_save array should depend on
 PM_SLEEP
Message-ID: <1387274199-470-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move reg_save[] into CONFIG_PM_SLEEP dependency block as it is used only
by suspend and resume functions.

This fixes the warning on CONFIG_PM_SLEEP=n:
drivers/clk/samsung/clk-exynos-audss.c:29:22: warning: ?reg_save? defined but not used [-Wunused-variable]

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/clk/samsung/clk-exynos-audss.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos-audss.c b/drivers/clk/samsung/clk-exynos-audss.c
index 39b40aaede2b..68e515d093d8 100644
--- a/drivers/clk/samsung/clk-exynos-audss.c
+++ b/drivers/clk/samsung/clk-exynos-audss.c
@@ -26,17 +26,17 @@ static struct clk_onecell_data clk_data;
 #define ASS_CLK_DIV 0x4
 #define ASS_CLK_GATE 0x8
 
+/* list of all parent clock list */
+static const char *mout_audss_p[] = { "fin_pll", "fout_epll" };
+static const char *mout_i2s_p[] = { "mout_audss", "cdclk0", "sclk_audio0" };
+
+#ifdef CONFIG_PM_SLEEP
 static unsigned long reg_save[][2] = {
 	{ASS_CLK_SRC,  0},
 	{ASS_CLK_DIV,  0},
 	{ASS_CLK_GATE, 0},
 };
 
-/* list of all parent clock list */
-static const char *mout_audss_p[] = { "fin_pll", "fout_epll" };
-static const char *mout_i2s_p[] = { "mout_audss", "cdclk0", "sclk_audio0" };
-
-#ifdef CONFIG_PM_SLEEP
 static int exynos_audss_clk_suspend(void)
 {
 	int i;
-- 
1.7.9.5
