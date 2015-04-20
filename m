From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 20 Apr 2015 15:06:28 +0200
Subject: [PATCH] clk: ux500: ape[ate|trace]clk are scaleable
Message-ID: <1429535188-4327-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The APEATCLK and APETRACECLK are actually scaleable so register
them as scaleable clocks.

Cc: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/clk/ux500/u8500_clk.c    | 7 ++++---
 drivers/clk/ux500/u8500_of_clk.c | 4 ++--
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/ux500/u8500_clk.c b/drivers/clk/ux500/u8500_clk.c
index 80069c370a47..4626b97b7d83 100644
--- a/drivers/clk/ux500/u8500_clk.c
+++ b/drivers/clk/ux500/u8500_clk.c
@@ -116,11 +116,12 @@ void u8500_clk_init(u32 clkrst1_base, u32 clkrst2_base, u32 clkrst3_base,
 	clk_register_clkdev(clk, NULL, "hdmi");
 	clk_register_clkdev(clk, "hdmi", "mcde");
 
-	clk = clk_reg_prcmu_gate("apeatclk", NULL, PRCMU_APEATCLK, CLK_IS_ROOT);
+	clk = clk_reg_prcmu_scalable("apeatclk", NULL, PRCMU_APEATCLK, 0,
+				     CLK_IS_ROOT|CLK_SET_RATE_GATE);
 	clk_register_clkdev(clk, NULL, "apeat");
 
-	clk = clk_reg_prcmu_gate("apetraceclk", NULL, PRCMU_APETRACECLK,
-				CLK_IS_ROOT);
+	clk = clk_reg_prcmu_scalable("apetraceclk", NULL, PRCMU_APETRACECLK, 0,
+				CLK_IS_ROOT|CLK_SET_RATE_GATE);
 	clk_register_clkdev(clk, NULL, "apetrace");
 
 	clk = clk_reg_prcmu_gate("mcdeclk", NULL, PRCMU_MCDECLK, CLK_IS_ROOT);
diff --git a/drivers/clk/ux500/u8500_of_clk.c b/drivers/clk/ux500/u8500_of_clk.c
index 7b55ef89baa5..e319ef912dc6 100644
--- a/drivers/clk/ux500/u8500_of_clk.c
+++ b/drivers/clk/ux500/u8500_of_clk.c
@@ -166,8 +166,8 @@ void u8500_of_clk_init(u32 clkrst1_base, u32 clkrst2_base, u32 clkrst3_base,
 	clk = clk_reg_prcmu_gate("apeatclk", NULL, PRCMU_APEATCLK, CLK_IS_ROOT);
 	prcmu_clk[PRCMU_APEATCLK] = clk;
 
-	clk = clk_reg_prcmu_gate("apetraceclk", NULL, PRCMU_APETRACECLK,
-				CLK_IS_ROOT);
+	clk = clk_reg_prcmu_scalable("apetraceclk", NULL, PRCMU_APETRACECLK, 0,
+				CLK_IS_ROOT|CLK_SET_RATE_GATE);
 	prcmu_clk[PRCMU_APETRACECLK] = clk;
 
 	clk = clk_reg_prcmu_gate("mcdeclk", NULL, PRCMU_MCDECLK, CLK_IS_ROOT);
-- 
1.9.3
