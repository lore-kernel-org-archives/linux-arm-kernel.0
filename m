From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 18 Sep 2013 13:14:26 +0100
Subject: [PATCH 29/41] clk: ux500: Add Device Tree support for the TWD clock
In-Reply-To: <1379506478-16625-1-git-send-email-lee.jones@linaro.org>
References: <1379506478-16625-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1379506478-16625-30-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables the TWD fixed factor clock to be specified from
Device Tree via phandles to the "smp-twd-clock" node.

Acked-by: Mike Turquette <mturquette@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/clk/ux500/u8500_of_clk.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/ux500/u8500_of_clk.c b/drivers/clk/ux500/u8500_of_clk.c
index fc647cf..0769db8 100644
--- a/drivers/clk/ux500/u8500_of_clk.c
+++ b/drivers/clk/ux500/u8500_of_clk.c
@@ -60,7 +60,7 @@ void u8500_of_clk_init(u32 clkrst1_base, u32 clkrst2_base, u32 clkrst3_base,
 	struct device_node *np = NULL;
 	struct device_node *child = NULL;
 	const char *sgaclk_parent = NULL;
-	struct clk *clk, *rtc_clk;
+	struct clk *clk, *rtc_clk, *twd_clk;
 
 	if (of_have_populated_dt())
 		np = of_find_matching_node(NULL, u8500_clk_of_match);
@@ -234,7 +234,7 @@ void u8500_of_clk_init(u32 clkrst1_base, u32 clkrst2_base, u32 clkrst3_base,
 	clk = clk_reg_prcmu_scalable_rate("armss", NULL,
 				PRCMU_ARMSS, 0, CLK_IS_ROOT|CLK_IGNORE_UNUSED);
 
-	clk = clk_register_fixed_factor(NULL, "smp_twd", "armss",
+	twd_clk = clk_register_fixed_factor(NULL, "smp_twd", "armss",
 				CLK_IGNORE_UNUSED, 1, 2);
 
 	/*
@@ -551,5 +551,8 @@ void u8500_of_clk_init(u32 clkrst1_base, u32 clkrst2_base, u32 clkrst3_base,
 
 		if (!of_node_cmp(child->name, "rtc32k-clock"))
 			of_clk_add_provider(child, of_clk_src_simple_get, rtc_clk);
+
+		if (!of_node_cmp(child->name, "smp-twd-clock"))
+			of_clk_add_provider(child, of_clk_src_simple_get, twd_clk);
 	}
 }
-- 
1.8.1.2
