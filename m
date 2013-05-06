From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon,  6 May 2013 15:11:11 -0600
Subject: [PATCH 2/2] clk: tegra: add ac97 controller clock
In-Reply-To: <1367874671-11474-1-git-send-email-swarren@wwwdotorg.org>
References: <1367874671-11474-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1367874671-11474-3-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lucas Stach <dev@lynxeye.de>

AC97 controller clock is hardwired to pll_a_out0.

Signed-off-by: Lucas Stach <dev@lynxeye.de>
Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
Reviewed-by: Prashant Gaikwad <pgaikwad@nvidia.com>
Acked-by: Mike Turquette <mturquette@linaro.org>
Tested-by: Stephen Warren <swarren@nvidia.com>
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 drivers/clk/tegra/clk-tegra20.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/clk/tegra/clk-tegra20.c b/drivers/clk/tegra/clk-tegra20.c
index ecfe532..2547bc0 100644
--- a/drivers/clk/tegra/clk-tegra20.c
+++ b/drivers/clk/tegra/clk-tegra20.c
@@ -872,6 +872,14 @@ static void __init tegra20_periph_clk_init(void)
 	struct clk *clk;
 	int i;
 
+	/* ac97 */
+	clk = tegra_clk_register_periph_gate("ac97", "pll_a_out0",
+				    TEGRA_PERIPH_ON_APB,
+				    clk_base, 0, 3, &periph_l_regs,
+				    periph_clk_enb_refcnt);
+	clk_register_clkdev(clk, NULL, "tegra20-ac97");
+	clks[ac97] = clk;
+
 	/* apbdma */
 	clk = tegra_clk_register_periph_gate("apbdma", "pclk", 0, clk_base,
 				    0, 34, &periph_h_regs,
-- 
1.7.10.4
