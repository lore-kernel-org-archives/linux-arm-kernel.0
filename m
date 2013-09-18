From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 18 Sep 2013 13:14:25 +0100
Subject: [PATCH 28/41] clk: ux500: Add Device Tree support for the RTC clock
In-Reply-To: <1379506478-16625-1-git-send-email-lee.jones@linaro.org>
References: <1379506478-16625-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1379506478-16625-29-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables the RTC fixed frequency clock to be specified from
Device Tree via phandles to the "rtc32k-clock" node.

Acked-by: Mike Turquette <mturquette@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/clk/ux500/u8500_of_clk.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/ux500/u8500_of_clk.c b/drivers/clk/ux500/u8500_of_clk.c
index 4fcafd0..fc647cf 100644
--- a/drivers/clk/ux500/u8500_of_clk.c
+++ b/drivers/clk/ux500/u8500_of_clk.c
@@ -60,7 +60,7 @@ void u8500_of_clk_init(u32 clkrst1_base, u32 clkrst2_base, u32 clkrst3_base,
 	struct device_node *np = NULL;
 	struct device_node *child = NULL;
 	const char *sgaclk_parent = NULL;
-	struct clk *clk;
+	struct clk *clk, *rtc_clk;
 
 	if (of_have_populated_dt())
 		np = of_find_matching_node(NULL, u8500_clk_of_match);
@@ -84,7 +84,7 @@ void u8500_of_clk_init(u32 clkrst1_base, u32 clkrst2_base, u32 clkrst3_base,
 
 	/* FIXME: Add sys, ulp and int clocks here. */
 
-	clk = clk_register_fixed_rate(NULL, "rtc32k", "NULL",
+	rtc_clk = clk_register_fixed_rate(NULL, "rtc32k", "NULL",
 				CLK_IS_ROOT|CLK_IGNORE_UNUSED,
 				32768);
 
@@ -548,5 +548,8 @@ void u8500_of_clk_init(u32 clkrst1_base, u32 clkrst2_base, u32 clkrst3_base,
 
 		if (!of_node_cmp(child->name, "prcc-kernel-clock"))
 			of_clk_add_provider(child, ux500_twocell_get, prcc_kclk);
+
+		if (!of_node_cmp(child->name, "rtc32k-clock"))
+			of_clk_add_provider(child, of_clk_src_simple_get, rtc_clk);
 	}
 }
-- 
1.8.1.2
