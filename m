From: Sudeep.KarkadaNagesha@arm.com (Sudeep.KarkadaNagesha at arm.com)
Date: Mon, 15 Jul 2013 11:22:08 +0100
Subject: [RFC PATCH 07/11] cpufreq: cpufreq-cpu0: remove device tree parsing
 for cpu nodes
In-Reply-To: <1373883732-26303-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
References: <1373883732-26303-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Message-ID: <1373883732-26303-8-git-send-email-Sudeep.KarkadaNagesha@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>

Now that the cpu device registration initialises the of_node(if available)
appropriately for all the cpus, parsing here is redundant.

This patch removes all DT parsing and uses cpu->of_node instead.

Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
---
 drivers/cpufreq/cpufreq-cpu0.c | 23 ++++-------------------
 1 file changed, 4 insertions(+), 19 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-cpu0.c b/drivers/cpufreq/cpufreq-cpu0.c
index ad1fde2..5b05c26 100644
--- a/drivers/cpufreq/cpufreq-cpu0.c
+++ b/drivers/cpufreq/cpufreq-cpu0.c
@@ -174,29 +174,17 @@ static struct cpufreq_driver cpu0_cpufreq_driver = {
 
 static int cpu0_cpufreq_probe(struct platform_device *pdev)
 {
-	struct device_node *np, *parent;
+	struct device_node *np;
 	int ret;
 
-	parent = of_find_node_by_path("/cpus");
-	if (!parent) {
-		pr_err("failed to find OF /cpus\n");
-		return -ENOENT;
-	}
-
-	for_each_child_of_node(parent, np) {
-		if (of_get_property(np, "operating-points", NULL))
-			break;
-	}
+	cpu_dev = &pdev->dev;
 
+	np = of_node_get(cpu_dev->of_node);
 	if (!np) {
 		pr_err("failed to find cpu0 node\n");
-		ret = -ENOENT;
-		goto out_put_parent;
+		return -ENOENT;
 	}
 
-	cpu_dev = &pdev->dev;
-	cpu_dev->of_node = np;
-
 	cpu_reg = devm_regulator_get(cpu_dev, "cpu0");
 	if (IS_ERR(cpu_reg)) {
 		/*
@@ -269,15 +257,12 @@ static int cpu0_cpufreq_probe(struct platform_device *pdev)
 	}
 
 	of_node_put(np);
-	of_node_put(parent);
 	return 0;
 
 out_free_table:
 	opp_free_cpufreq_table(cpu_dev, &freq_table);
 out_put_node:
 	of_node_put(np);
-out_put_parent:
-	of_node_put(parent);
 	return ret;
 }
 
-- 
1.8.1.2
