From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 20 Mar 2015 01:19:05 +0800
Subject: [PATCH 3/6] clk: sunxi: Register divs clocks before factor clocks
In-Reply-To: <1426785548-5932-1-git-send-email-wens@csie.org>
References: <1426785548-5932-1-git-send-email-wens@csie.org>
Message-ID: <1426785548-5932-4-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We want to reparent AHB clock to PLL6 on sun5i/sun7i using the assigned
clocks properties. AHB is a factor clock, while PLL6 is a divs clock.

Register divs clocks before factor clocks so reparenting works. This
is only needed because we do the reparenting on the clock provider.

The proper way to fix this is to split out all the old sunxi clocks
into separate CLK_OF_DECLARE statements, like we are doing for sun9i.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/clk/sunxi/clk-sunxi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index 7580a1bc88fd..d92e30371d8a 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -1312,15 +1312,15 @@ static void __init sunxi_init_clocks(const char *clocks[], int nclocks)
 {
 	unsigned int i;
 
+	/* Register divided output clocks */
+	of_sunxi_table_clock_setup(clk_divs_match, sunxi_divs_clk_setup);
+
 	/* Register factor clocks */
 	of_sunxi_table_clock_setup(clk_factors_match, sunxi_factors_clk_setup);
 
 	/* Register divider clocks */
 	of_sunxi_table_clock_setup(clk_div_match, sunxi_divider_clk_setup);
 
-	/* Register divided output clocks */
-	of_sunxi_table_clock_setup(clk_divs_match, sunxi_divs_clk_setup);
-
 	/* Register mux clocks */
 	of_sunxi_table_clock_setup(clk_mux_match, sunxi_mux_clk_setup);
 
-- 
2.1.4
