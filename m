From: dinggnu@gmail.com (Cong Ding)
Date: Tue, 15 Jan 2013 19:44:26 +0100
Subject: [PATCH v3] clk: mvebu/clk-cpu.c: fix memory leakage
In-Reply-To: <50F5A1A9.2030803@free-electrons.com>
References: <1358183892-28928-1-git-send-email-dinggnu@gmail.com>
 <50F563EC.3030804@free-electrons.com>
 <20130115152307.GA25615@gmail.com>
 <20130115153716.GF13433@titan.lakedaemon.net>
 <50F584F5.6030007@free-electrons.com>
 <20130115182629.GB7211@gmail.com>
 <50F5A1A9.2030803@free-electrons.com>
Message-ID: <20130115184423.GC7211@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

the variable cpuclk and clk_name should be properly freed when error happens.

Signed-off-by: Cong Ding <dinggnu@gmail.com>
Acked-by: Jason Cooper <jason@lakedaemon.net>
---
 drivers/clk/mvebu/clk-cpu.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/mvebu/clk-cpu.c b/drivers/clk/mvebu/clk-cpu.c
index ff004578..9dd2551 100644
--- a/drivers/clk/mvebu/clk-cpu.c
+++ b/drivers/clk/mvebu/clk-cpu.c
@@ -124,7 +124,7 @@ void __init of_cpu_clk_setup(struct device_node *node)
 
 	clks = kzalloc(ncpus * sizeof(*clks), GFP_KERNEL);
 	if (WARN_ON(!clks))
-		return;
+		goto clks_out;
 
 	for_each_node_by_type(dn, "cpu") {
 		struct clk_init_data init;
@@ -134,11 +134,11 @@ void __init of_cpu_clk_setup(struct device_node *node)
 		int cpu, err;
 
 		if (WARN_ON(!clk_name))
-			return;
+			goto bail_out;
 
 		err = of_property_read_u32(dn, "reg", &cpu);
 		if (WARN_ON(err))
-			return;
+			goto bail_out;
 
 		sprintf(clk_name, "cpu%d", cpu);
 		parent_clk = of_clk_get(node, 0);
@@ -167,6 +167,9 @@ void __init of_cpu_clk_setup(struct device_node *node)
 	return;
 bail_out:
 	kfree(clks);
+	while(ncpus--)
+		kfree(cpuclk[ncpus].clk_name);
+clks_out:
 	kfree(cpuclk);
 }
 
-- 
1.7.10.4
