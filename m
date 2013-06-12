From: jagarwal@nvidia.com (Jay Agarwal)
Date: Wed, 12 Jun 2013 12:43:43 +0530
Subject: [PATCH V4 1/4] ARM: tegra30: clocks: Fix pciex clock registration
Message-ID: <1371021223-6709-1-git-send-email-jagarwal@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Registering pciex as peripheral clock instead of fixed clock
as tegra_perih_reset_assert(deassert) api of this clock api
gives warning and ultimately does not succeed to assert(deassert)

Signed-off-by: Jay Agarwal <jagarwal@nvidia.com>
---
Patch is based on remotes/gitorious_thierryreding_linux/tegra/next and should be applied on top of this.

Changes in V4:
- Avoid modifying tegra pcie driver name for duplicate clocks as per review comments

 drivers/clk/tegra/clk-tegra30.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/tegra/clk-tegra30.c b/drivers/clk/tegra/clk-tegra30.c
index c6921f5..ba99e38 100644
--- a/drivers/clk/tegra/clk-tegra30.c
+++ b/drivers/clk/tegra/clk-tegra30.c
@@ -1598,6 +1598,12 @@ static void __init tegra30_periph_clk_init(void)
 	clk_register_clkdev(clk, "afi", "tegra-pcie");
 	clks[afi] = clk;
 
+	/* pciex */
+	clk = tegra_clk_register_periph_gate("pciex", "pll_e", 0, clk_base, 0,
+				    74, &periph_u_regs, periph_clk_enb_refcnt);
+	clk_register_clkdev(clk, "pciex", "tegra-pcie");
+	clks[pciex] = clk;
+
 	/* kfuse */
 	clk = tegra_clk_register_periph_gate("kfuse", "clk_m",
 				    TEGRA_PERIPH_ON_APB,
@@ -1716,11 +1722,6 @@ static void __init tegra30_fixed_clk_init(void)
 				1, 0, &cml_lock);
 	clk_register_clkdev(clk, "cml1", NULL);
 	clks[cml1] = clk;
-
-	/* pciex */
-	clk = clk_register_fixed_rate(NULL, "pciex", "pll_e", 0, 100000000);
-	clk_register_clkdev(clk, "pciex", NULL);
-	clks[pciex] = clk;
 }
 
 static void __init tegra30_osc_clk_init(void)
-- 
1.7.0.4
