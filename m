From: pgaikwad@nvidia.com (Prashant Gaikwad)
Date: Fri, 4 Jan 2013 12:30:57 +0530
Subject: [PATCH 6/7] clk: zynq: Use common of_clk_init() function
In-Reply-To: <1357282858-2112-1-git-send-email-pgaikwad@nvidia.com>
References: <1357282858-2112-1-git-send-email-pgaikwad@nvidia.com>
Message-ID: <1357282858-2112-6-git-send-email-pgaikwad@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use common of_clk_init() function for clock initialization.

Signed-off-by: Prashant Gaikwad <pgaikwad@nvidia.com>
---
 drivers/clk/clk-zynq.c |   14 ++++----------
 1 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/clk-zynq.c b/drivers/clk/clk-zynq.c
index 37a3051..b14a25f 100644
--- a/drivers/clk/clk-zynq.c
+++ b/drivers/clk/clk-zynq.c
@@ -81,6 +81,7 @@ static void __init zynq_pll_clk_setup(struct device_node *np)
 	if (WARN_ON(ret))
 		return;
 }
+CLK_OF_DECLARE(zynq_pll, "xlnx,zynq-pll", zynq_pll_clk_setup);
 
 struct zynq_periph_clk {
 	struct clk_hw		hw;
@@ -187,6 +188,7 @@ static void __init zynq_periph_clk_setup(struct device_node *np)
 	if (WARN_ON(err))
 		return;
 }
+CLK_OF_DECLARE(zynq_periph, "xlnx,zynq-periph-clock", zynq_periph_clk_setup);
 
 /* CPU Clock domain is modelled as a mux with 4 children subclks, whose
  * derivative rates depend on CLK_621_TRUE
@@ -366,18 +368,10 @@ static void __init zynq_cpu_clk_setup(struct device_node *np)
 	if (WARN_ON(err))
 		return;
 }
-
-static const __initconst struct of_device_id zynq_clk_match[] = {
-	{ .compatible = "fixed-clock", .data = of_fixed_clk_setup, },
-	{ .compatible = "xlnx,zynq-pll", .data = zynq_pll_clk_setup, },
-	{ .compatible = "xlnx,zynq-periph-clock",
-		.data = zynq_periph_clk_setup, },
-	{ .compatible = "xlnx,zynq-cpu-clock", .data = zynq_cpu_clk_setup, },
-	{}
-};
+CLK_OF_DECLARE(zynq_cpu, "xlnx,zynq-cpu-clock", zynq_cpu_clk_setup);
 
 void __init xilinx_zynq_clocks_init(void __iomem *slcr)
 {
 	slcr_base = slcr;
-	of_clk_init(zynq_clk_match);
+	of_clk_init(NULL);
 }
-- 
1.7.4.1
