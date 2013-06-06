From: lee.jones@linaro.org (Lee Jones)
Date: Thu,  6 Jun 2013 13:17:11 +0100
Subject: [PATCH 23/33] clk: ux500: Add Device Tree support for the TWD clock
In-Reply-To: <1370521041-32318-1-git-send-email-lee.jones@linaro.org>
References: <1370521041-32318-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1370521041-32318-24-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables the TWD fixed factor clock to be specified from
Device Tree via phandles to the "smp-twd-clock" node.

Cc: Mike Turquette <mturquette@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/clk/ux500/u8500_clk.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/ux500/u8500_clk.c b/drivers/clk/ux500/u8500_clk.c
index ebd0381..b890067 100644
--- a/drivers/clk/ux500/u8500_clk.c
+++ b/drivers/clk/ux500/u8500_clk.c
@@ -60,7 +60,7 @@ void u8500_clk_init(u32 clkrst1_base, u32 clkrst2_base, u32 clkrst3_base,
 	struct device_node *np = NULL;
 	struct device_node *child = NULL;
 	const char *sgaclk_parent = NULL;
-	struct clk *clk, *rtc_clk;
+	struct clk *clk, *rtc_clk, *twd_clk;
 
 	/* Clock sources */
 	clk = clk_reg_prcmu_gate("soc0_pll", NULL, PRCMU_PLLSOC0,
@@ -283,9 +283,9 @@ void u8500_clk_init(u32 clkrst1_base, u32 clkrst2_base, u32 clkrst3_base,
 				PRCMU_ARMSS, 0, CLK_IS_ROOT|CLK_IGNORE_UNUSED);
 	clk_register_clkdev(clk, "armss", NULL);
 
-	clk = clk_register_fixed_factor(NULL, "smp_twd", "armss",
+	twd_clk = clk_register_fixed_factor(NULL, "smp_twd", "armss",
 				CLK_IGNORE_UNUSED, 1, 2);
-	clk_register_clkdev(clk, NULL, "smp_twd");
+	clk_register_clkdev(twd_clk, NULL, "smp_twd");
 
 	/*
 	 * FIXME: Add special handled PRCMU clocks here:
@@ -693,5 +693,8 @@ void u8500_clk_init(u32 clkrst1_base, u32 clkrst2_base, u32 clkrst3_base,
 
 		if (!of_node_cmp(child->name, "rtc32k-clock"))
 			of_clk_add_provider(child, of_clk_src_simple_get, rtc_clk);
+
+		if (!of_node_cmp(child->name, "smp-twd-clock"))
+			of_clk_add_provider(child, of_clk_src_simple_get, twd_clk);
 	}
 }
-- 
1.7.10.4
