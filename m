From: b51503@freescale.com (Bai Ping)
Date: Thu, 26 Nov 2015 10:18:43 +0800
Subject: [PATCH] clk: imx: Replace clk error check with imx_check_clocks()
Message-ID: <1448504323-17737-1-git-send-email-b51503@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As we already have a 'imx_check_clocks' to do the clock error
check, so cleanup the error check code.

Signed-off-by: Bai Ping <b51503@freescale.com>
---
 drivers/clk/imx/clk-imx6ul.c | 4 +---
 drivers/clk/imx/clk-imx7d.c  | 5 +----
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/imx/clk-imx6ul.c b/drivers/clk/imx/clk-imx6ul.c
index 01718d0..08692d7 100644
--- a/drivers/clk/imx/clk-imx6ul.c
+++ b/drivers/clk/imx/clk-imx6ul.c
@@ -399,9 +399,7 @@ static void __init imx6ul_clocks_init(struct device_node *ccm_node)
 	/* mask handshake of mmdc */
 	writel_relaxed(BM_CCM_CCDR_MMDC_CH0_MASK, base + CCDR);
 
-	for (i = 0; i < ARRAY_SIZE(clks); i++)
-		if (IS_ERR(clks[i]))
-			pr_err("i.MX6UL clk %d: register failed with %ld\n", i, PTR_ERR(clks[i]));
+	imx_check_clocks(clks, ARRAY_SIZE(clks));
 
 	clk_data.clks = clks;
 	clk_data.clk_num = ARRAY_SIZE(clks);
diff --git a/drivers/clk/imx/clk-imx7d.c b/drivers/clk/imx/clk-imx7d.c
index 581b428..fbb6a8c 100644
--- a/drivers/clk/imx/clk-imx7d.c
+++ b/drivers/clk/imx/clk-imx7d.c
@@ -839,10 +839,7 @@ static void __init imx7d_clocks_init(struct device_node *ccm_node)
 					 clks[IMX7D_PLL_ARM_MAIN_CLK],
 					 clks[IMX7D_PLL_SYS_MAIN_CLK]);
 
-	for (i = 0; i < ARRAY_SIZE(clks); i++)
-		if (IS_ERR(clks[i]))
-			pr_err("i.MX7D clk %d: register failed with %ld\n",
-					i, PTR_ERR(clks[i]));
+	imx_check_clocks(clks, ARRAY_SIZE(clks));
 
 	clk_data.clks = clks;
 	clk_data.clk_num = ARRAY_SIZE(clks);
-- 
1.9.1
