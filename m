From: pgaikwad@nvidia.com (Prashant Gaikwad)
Date: Fri, 4 Jan 2013 12:30:56 +0530
Subject: [PATCH 5/7] clk: vt8500: Use common of_clk_init() function
In-Reply-To: <1357282858-2112-1-git-send-email-pgaikwad@nvidia.com>
References: <1357282858-2112-1-git-send-email-pgaikwad@nvidia.com>
Message-ID: <1357282858-2112-5-git-send-email-pgaikwad@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use common of_clk_init() function for clock initialization.

Signed-off-by: Prashant Gaikwad <pgaikwad@nvidia.com>
---
 drivers/clk/clk-vt8500.c |   15 ++++-----------
 1 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/clk-vt8500.c b/drivers/clk/clk-vt8500.c
index fe25570..3ce1c3e 100644
--- a/drivers/clk/clk-vt8500.c
+++ b/drivers/clk/clk-vt8500.c
@@ -272,7 +272,7 @@ static __init void vtwm_device_clk_init(struct device_node *node)
 	rc = of_clk_add_provider(node, of_clk_src_simple_get, clk);
 	clk_register_clkdev(clk, clk_name, NULL);
 }
-
+CLK_OF_DECLARE(vt8500_device, "via,vt8500-device-clock", vtwm_device_clk_init);
 
 /* PLL clock related functions */
 
@@ -502,20 +502,13 @@ static void __init vt8500_pll_init(struct device_node *node)
 {
 	vtwm_pll_clk_init(node, PLL_TYPE_VT8500);
 }
+CLK_OF_DECLARE(vt8500_pll, "via,vt8500-pll-clock", vt8500_pll_init);
 
 static void __init wm8650_pll_init(struct device_node *node)
 {
 	vtwm_pll_clk_init(node, PLL_TYPE_WM8650);
 }
-
-static const __initconst struct of_device_id clk_match[] = {
-	{ .compatible = "fixed-clock", .data = of_fixed_clk_setup, },
-	{ .compatible = "via,vt8500-pll-clock", .data = vt8500_pll_init, },
-	{ .compatible = "wm,wm8650-pll-clock", .data = wm8650_pll_init, },
-	{ .compatible = "via,vt8500-device-clock",
-					.data = vtwm_device_clk_init, },
-	{ /* sentinel */ }
-};
+CLK_OF_DECLARE(wm8650_pll, "wm,wm8650-pll-clock", wm8650_pll_init);
 
 void __init vtwm_clk_init(void __iomem *base)
 {
@@ -524,5 +517,5 @@ void __init vtwm_clk_init(void __iomem *base)
 
 	pmc_base = base;
 
-	of_clk_init(clk_match);
+	of_clk_init(NULL);
 }
-- 
1.7.4.1
