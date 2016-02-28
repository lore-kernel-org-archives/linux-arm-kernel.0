From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Sun, 28 Feb 2016 15:36:55 +0000
Subject: [PATCH v5 04/20] clk: bcm2835: remove uart0/1_pclk fixed clocks
In-Reply-To: <1456673831-2408-1-git-send-email-kernel@martin.sperl.org>
References: <1456673831-2408-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <1456673831-2408-5-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

Remove the fixed clocks uart0_pclk and uart1_pclk.
These are not referred to anywhere and the corresponding
uart clock is created by default.

The uart1 clock is created by clk-bcm2835-aux.

Note that the use of apb_pclk is questionable and
not referred to anywhere.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 drivers/clk/bcm/clk-bcm2835.c |   17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
index d999a13..c277ecb 100644
--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -319,28 +319,11 @@ static inline u32 cprman_read(struct bcm2835_cprman *cprman, u32 reg)
 void __init bcm2835_init_clocks(void)
 {
 	struct clk *clk;
-	int ret;
 
 	clk = clk_register_fixed_rate(NULL, "apb_pclk", NULL, CLK_IS_ROOT,
 				      126000000);
 	if (IS_ERR(clk))
 		pr_err("apb_pclk not registered\n");
-
-	clk = clk_register_fixed_rate(NULL, "uart0_pclk", NULL, CLK_IS_ROOT,
-				      3000000);
-	if (IS_ERR(clk))
-		pr_err("uart0_pclk not registered\n");
-	ret = clk_register_clkdev(clk, NULL, "20201000.uart");
-	if (ret)
-		pr_err("uart0_pclk alias not registered\n");
-
-	clk = clk_register_fixed_rate(NULL, "uart1_pclk", NULL, CLK_IS_ROOT,
-				      125000000);
-	if (IS_ERR(clk))
-		pr_err("uart1_pclk not registered\n");
-	ret = clk_register_clkdev(clk, NULL, "20215000.uart");
-	if (ret)
-		pr_err("uart1_pclk alias not registered\n");
 }
 
 struct bcm2835_pll_data {
-- 
1.7.10.4
