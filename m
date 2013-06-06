From: lee.jones@linaro.org (Lee Jones)
Date: Thu,  6 Jun 2013 13:17:10 +0100
Subject: [PATCH 22/33] clk: ux500: Add Device Tree support for the RTC clock
In-Reply-To: <1370521041-32318-1-git-send-email-lee.jones@linaro.org>
References: <1370521041-32318-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1370521041-32318-23-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables the RTC fixed frequency clock to be specified from
Device Tree via phandles to the "rtc32k-clock" node.

Cc: Mike Turquette <mturquette@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/clk/ux500/u8500_clk.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/ux500/u8500_clk.c b/drivers/clk/ux500/u8500_clk.c
index c3ed09c..ebd0381 100644
--- a/drivers/clk/ux500/u8500_clk.c
+++ b/drivers/clk/ux500/u8500_clk.c
@@ -60,7 +60,7 @@ void u8500_clk_init(u32 clkrst1_base, u32 clkrst2_base, u32 clkrst3_base,
 	struct device_node *np = NULL;
 	struct device_node *child = NULL;
 	const char *sgaclk_parent = NULL;
-	struct clk *clk;
+	struct clk *clk, *rtc_clk;
 
 	/* Clock sources */
 	clk = clk_reg_prcmu_gate("soc0_pll", NULL, PRCMU_PLLSOC0,
@@ -80,11 +80,11 @@ void u8500_clk_init(u32 clkrst1_base, u32 clkrst2_base, u32 clkrst3_base,
 
 	/* FIXME: Add sys, ulp and int clocks here. */
 
-	clk = clk_register_fixed_rate(NULL, "rtc32k", "NULL",
+	rtc_clk = clk_register_fixed_rate(NULL, "rtc32k", "NULL",
 				CLK_IS_ROOT|CLK_IGNORE_UNUSED,
 				32768);
-	clk_register_clkdev(clk, "clk32k", NULL);
-	clk_register_clkdev(clk, "apb_pclk", "rtc-pl031");
+	clk_register_clkdev(rtc_clk, "clk32k", NULL);
+	clk_register_clkdev(rtc_clk, "apb_pclk", "rtc-pl031");
 
 	/* PRCMU clocks */
 	fw_version = prcmu_get_fw_version();
@@ -690,5 +690,8 @@ void u8500_clk_init(u32 clkrst1_base, u32 clkrst2_base, u32 clkrst3_base,
 
 		if (!of_node_cmp(child->name, "prcc-kernel-clock"))
 			of_clk_add_provider(child, ux500_twocell_get, prcc_kclk);
+
+		if (!of_node_cmp(child->name, "rtc32k-clock"))
+			of_clk_add_provider(child, of_clk_src_simple_get, rtc_clk);
 	}
 }
-- 
1.7.10.4
