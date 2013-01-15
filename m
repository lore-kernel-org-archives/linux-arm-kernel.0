From: dinggnu@gmail.com (Cong Ding)
Date: Tue, 15 Jan 2013 15:23:08 +0000
Subject: [PATCH v2] clk: mvebu/clk-cpu.c: fix memory leakage
In-Reply-To: <50F563EC.3030804@free-electrons.com>
References: <1358183892-28928-1-git-send-email-dinggnu@gmail.com>
 <50F563EC.3030804@free-electrons.com>
Message-ID: <20130115152307.GA25615@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>From 75c73077905b822be6e8a32a09d6b0cdb5e61763 Mon Sep 17 00:00:00 2001
From: Cong Ding <dinggnu@gmail.com>
Date: Mon, 14 Jan 2013 18:06:26 +0100
Subject: [PATCH v2] clk: mvebu/clk-cpu.c: fix memory leakage

the variable cpuclk and clk_name should be properly freed when error happens.

Signed-off-by: Cong Ding <dinggnu@gmail.com>
---
 drivers/clk/mvebu/clk-cpu.c |   15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/mvebu/clk-cpu.c b/drivers/clk/mvebu/clk-cpu.c
index ff004578..1066a43 100644
--- a/drivers/clk/mvebu/clk-cpu.c
+++ b/drivers/clk/mvebu/clk-cpu.c
@@ -124,7 +124,7 @@ void __init of_cpu_clk_setup(struct device_node *node)
 
 	clks = kzalloc(ncpus * sizeof(*clks), GFP_KERNEL);
 	if (WARN_ON(!clks))
-		return;
+		goto clks_out;
 
 	for_each_node_by_type(dn, "cpu") {
 		struct clk_init_data init;
@@ -134,11 +134,13 @@ void __init of_cpu_clk_setup(struct device_node *node)
 		int cpu, err;
 
 		if (WARN_ON(!clk_name))
-			return;
+			goto bail_out;
 
 		err = of_property_read_u32(dn, "reg", &cpu);
-		if (WARN_ON(err))
-			return;
+		if (WARN_ON(err)) {
+			kfree(clk_name);
+			goto bail_out;
+		}
 
 		sprintf(clk_name, "cpu%d", cpu);
 		parent_clk = of_clk_get(node, 0);
@@ -156,8 +158,10 @@ void __init of_cpu_clk_setup(struct device_node *node)
 		init.num_parents = 1;
 
 		clk = clk_register(NULL, &cpuclk[cpu].hw);
-		if (WARN_ON(IS_ERR(clk)))
+		if (WARN_ON(IS_ERR(clk))) {
+			kfree(clk_name);
 			goto bail_out;
+		}
 		clks[cpu] = clk;
 	}
 	clk_data.clk_num = MAX_CPU;
@@ -167,6 +171,7 @@ void __init of_cpu_clk_setup(struct device_node *node)
 	return;
 bail_out:
 	kfree(clks);
+clks_out:
 	kfree(cpuclk);
 }
 
-- 
1.7.9.5
