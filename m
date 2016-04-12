From: alim.akhtar@samsung.com (Alim Akhtar)
Date: Tue, 12 Apr 2016 16:37:23 +0530
Subject: [PATCH] clk: samsung: exynos7: Enable clocks for CMU_CCORE and
 CMU_FSYS0 blocks
Message-ID: <1460459243-27120-1-git-send-email-alim.akhtar@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables clocks for CMU_CCORE and CMU_FSYS0 blocks. This is
required before accessing registers of these blocks.

Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 drivers/clk/samsung/clk-exynos7.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/clk/samsung/clk-exynos7.c b/drivers/clk/samsung/clk-exynos7.c
index ad68d46..7013aa7 100644
--- a/drivers/clk/samsung/clk-exynos7.c
+++ b/drivers/clk/samsung/clk-exynos7.c
@@ -8,6 +8,7 @@
  *
 */
 
+#include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/of.h>
 
@@ -205,7 +206,11 @@ static struct samsung_cmu_info topc_cmu_info __initdata = {
 
 static void __init exynos7_clk_topc_init(struct device_node *np)
 {
+	struct clk *clk;
+
 	samsung_cmu_register_one(np, &topc_cmu_info);
+	clk = __clk_lookup("aclk_ccore_133");
+	clk_prepare_enable(clk);
 }
 
 CLK_OF_DECLARE(exynos7_clk_topc, "samsung,exynos7-clock-topc",
@@ -573,7 +578,11 @@ static struct samsung_cmu_info top1_cmu_info __initdata = {
 
 static void __init exynos7_clk_top1_init(struct device_node *np)
 {
+	struct clk *clk;
+
 	samsung_cmu_register_one(np, &top1_cmu_info);
+	clk = __clk_lookup("aclk_fsys0_200");
+	clk_prepare_enable(clk);
 }
 
 CLK_OF_DECLARE(exynos7_clk_top1, "samsung,exynos7-clock-top1",
-- 
1.7.10.4
