From: jszhang@marvell.com (Jisheng Zhang)
Date: Fri, 23 Aug 2013 10:34:01 +0800
Subject: [PATCH v2 3/4] clk: mvebu: add missing iounmap
In-Reply-To: <1377225242-5854-1-git-send-email-jszhang@marvell.com>
References: <1377225242-5854-1-git-send-email-jszhang@marvell.com>
Message-ID: <1377225242-5854-4-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add missing iounmap to setup error path.

Change-Id: I4371569d14d7026aa9f90d7cd53f669d365fe26a
Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/clk/mvebu/clk-cpu.c |  4 +++-
 drivers/clk/mvebu/common.c  | 18 ++++++++++++------
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/mvebu/clk-cpu.c b/drivers/clk/mvebu/clk-cpu.c
index b0fbc07..1466865 100644
--- a/drivers/clk/mvebu/clk-cpu.c
+++ b/drivers/clk/mvebu/clk-cpu.c
@@ -119,7 +119,7 @@ void __init of_cpu_clk_setup(struct device_node *node)
 
 	cpuclk = kzalloc(ncpus * sizeof(*cpuclk), GFP_KERNEL);
 	if (WARN_ON(!cpuclk))
-		return;
+		goto cpuclk_out;
 
 	clks = kzalloc(ncpus * sizeof(*clks), GFP_KERNEL);
 	if (WARN_ON(!clks))
@@ -170,6 +170,8 @@ bail_out:
 		kfree(cpuclk[ncpus].clk_name);
 clks_out:
 	kfree(cpuclk);
+cpuclk_out:
+	iounmap(clock_complex_base);
 }
 
 CLK_OF_DECLARE(armada_xp_cpu_clock, "marvell,armada-xp-cpu-clock",
diff --git a/drivers/clk/mvebu/common.c b/drivers/clk/mvebu/common.c
index adaa4a1..25ceccf 100644
--- a/drivers/clk/mvebu/common.c
+++ b/drivers/clk/mvebu/common.c
@@ -45,8 +45,10 @@ void __init mvebu_coreclk_setup(struct device_node *np,
 	clk_data.clk_num = 2 + desc->num_ratios;
 	clk_data.clks = kzalloc(clk_data.clk_num * sizeof(struct clk *),
 				GFP_KERNEL);
-	if (WARN_ON(!clk_data.clks))
+	if (WARN_ON(!clk_data.clks)) {
+		iounmap(base);
 		return;
+	}
 
 	/* Register TCLK */
 	of_property_read_string_index(np, "clock-output-names", 0,
@@ -134,7 +136,7 @@ void __init mvebu_clk_gating_setup(struct device_node *np,
 
 	ctrl = kzalloc(sizeof(*ctrl), GFP_KERNEL);
 	if (WARN_ON(!ctrl))
-		return;
+		goto ctrl_out;
 
 	spin_lock_init(&ctrl->lock);
 
@@ -145,10 +147,8 @@ void __init mvebu_clk_gating_setup(struct device_node *np,
 	ctrl->num_gates = n;
 	ctrl->gates = kzalloc(ctrl->num_gates * sizeof(struct clk *),
 			      GFP_KERNEL);
-	if (WARN_ON(!ctrl->gates)) {
-		kfree(ctrl);
-		return;
-	}
+	if (WARN_ON(!ctrl->gates))
+		goto gates_out;
 
 	for (n = 0; n < ctrl->num_gates; n++) {
 		const char *parent =
@@ -160,4 +160,10 @@ void __init mvebu_clk_gating_setup(struct device_node *np,
 	}
 
 	of_clk_add_provider(np, clk_gating_get_src, ctrl);
+
+	return;
+gates_out:
+	kfree(ctrl);
+ctrl_out:
+	iounmap(base);
 }
-- 
1.8.4.rc3
