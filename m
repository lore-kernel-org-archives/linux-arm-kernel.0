From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 18 Sep 2013 13:14:20 +0100
Subject: [PATCH 23/41] clk: ux500: Provide u8500_clk with skeleton Device Tree
 support
In-Reply-To: <1379506478-16625-1-git-send-email-lee.jones@linaro.org>
References: <1379506478-16625-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1379506478-16625-24-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The functional components will be added on a per-clock basis.

Acked-by: Mike Turquette <mturquette@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/clk/ux500/u8500_of_clk.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/clk/ux500/u8500_of_clk.c b/drivers/clk/ux500/u8500_of_clk.c
index ceebce6..bfbe3ca 100644
--- a/drivers/clk/ux500/u8500_of_clk.c
+++ b/drivers/clk/ux500/u8500_of_clk.c
@@ -7,6 +7,7 @@
  * License terms: GNU General Public License (GPL) version 2
  */
 
+#include <linux/of.h>
 #include <linux/clk.h>
 #include <linux/clkdev.h>
 #include <linux/clk-provider.h>
@@ -14,13 +15,27 @@
 #include <linux/platform_data/clk-ux500.h>
 #include "clk.h"
 
+static const struct of_device_id u8500_clk_of_match[] = {
+	{ .compatible = "stericsson,u8500-clks", },
+	{ },
+};
+
 void u8500_of_clk_init(u32 clkrst1_base, u32 clkrst2_base, u32 clkrst3_base,
 		       u32 clkrst5_base, u32 clkrst6_base)
 {
 	struct prcmu_fw_version *fw_version;
+	struct device_node *np = NULL;
+	struct device_node *child = NULL;
 	const char *sgaclk_parent = NULL;
 	struct clk *clk;
 
+	if (of_have_populated_dt())
+		np = of_find_matching_node(NULL, u8500_clk_of_match);
+	if (!np) {
+		pr_err("Either DT or U8500 Clock node not found\n");
+		return;
+	}
+
 	/* Clock sources */
 	clk = clk_reg_prcmu_gate("soc0_pll", NULL, PRCMU_PLLSOC0,
 				CLK_IS_ROOT|CLK_IGNORE_UNUSED);
@@ -378,4 +393,8 @@ void u8500_of_clk_init(u32 clkrst1_base, u32 clkrst2_base, u32 clkrst3_base,
 	/* Periph6 */
 	clk = clk_reg_prcc_kclk("p3_rng_kclk", "rngclk",
 			clkrst6_base, BIT(0), CLK_SET_RATE_GATE);
+
+	for_each_child_of_node(np, child) {
+		/* Place holder for supported nodes. */
+	}
 }
-- 
1.8.1.2
