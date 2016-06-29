From: andi.shyti@gmail.com (andi.shyti at gmail.com)
Date: Wed, 29 Jun 2016 17:45:10 +0300
Subject: [PATCH v2 2/2] clk: rockchip: remove unused
 rockchip_clk_protect_critical function
In-Reply-To: <1467211510-3485-1-git-send-email-andi@etezian.org>
References: <1467211510-3485-1-git-send-email-andi@etezian.org>
Message-ID: <1467211510-3485-3-git-send-email-andi@etezian.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andi Shyti <andi@etezian.org>

because there is no need anymore to enable critical clocks in
each driver, this function is not necessary anymore.

The drivers having critical clocks use the CLK_IS_CRITICAL flag.

Signed-off-by: Andi Shyti <andi@etezian.org>
---
 drivers/clk/rockchip/clk.c | 14 --------------
 drivers/clk/rockchip/clk.h |  1 -
 2 files changed, 15 deletions(-)

diff --git a/drivers/clk/rockchip/clk.c b/drivers/clk/rockchip/clk.c
index 7ffd134..d9bc61b 100644
--- a/drivers/clk/rockchip/clk.c
+++ b/drivers/clk/rockchip/clk.c
@@ -525,20 +525,6 @@ void __init rockchip_clk_register_armclk(struct rockchip_clk_provider *ctx,
 	rockchip_clk_add_lookup(ctx, clk, lookup_id);
 }
 
-void __init rockchip_clk_protect_critical(const char *const clocks[],
-					  int nclocks)
-{
-	int i;
-
-	/* Protect the clocks that needs to stay on */
-	for (i = 0; i < nclocks; i++) {
-		struct clk *clk = __clk_lookup(clocks[i]);
-
-		if (clk)
-			clk_prepare_enable(clk);
-	}
-}
-
 static void __iomem *rst_base;
 static unsigned int reg_restart;
 static void (*cb_restart)(void);
diff --git a/drivers/clk/rockchip/clk.h b/drivers/clk/rockchip/clk.h
index 2194ffa..2fb7acb 100644
--- a/drivers/clk/rockchip/clk.h
+++ b/drivers/clk/rockchip/clk.h
@@ -614,7 +614,6 @@ void rockchip_clk_register_armclk(struct rockchip_clk_provider *ctx,
 			const struct rockchip_cpuclk_reg_data *reg_data,
 			const struct rockchip_cpuclk_rate_table *rates,
 			int nrates);
-void rockchip_clk_protect_critical(const char *const clocks[], int nclocks);
 void rockchip_register_restart_notifier(struct rockchip_clk_provider *ctx,
 					unsigned int reg, void (*cb)(void));
 
-- 
2.8.1
