From: Sudeep.KarkadaNagesha@arm.com (Sudeep KarkadaNagesha)
Date: Tue, 20 Aug 2013 10:30:19 +0100
Subject: [PATCH v4 17/19] cpufreq: maple-cpufreq: remove device tree parsing
 for cpu nodes
In-Reply-To: <1376991021-12160-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
References: <1374492747-13879-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376991021-12160-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Message-ID: <1376991021-12160-18-git-send-email-Sudeep.KarkadaNagesha@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>

Now that the cpu device registration initialises the of_node(if available)
appropriately for all the cpus, parsing here is redundant.

This patch removes all DT parsing and uses cpu->of_node instead.

Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
---
 drivers/cpufreq/maple-cpufreq.c | 23 +++--------------------
 1 file changed, 3 insertions(+), 20 deletions(-)

diff --git a/drivers/cpufreq/maple-cpufreq.c b/drivers/cpufreq/maple-cpufreq.c
index cdd6291..f071dc4 100644
--- a/drivers/cpufreq/maple-cpufreq.c
+++ b/drivers/cpufreq/maple-cpufreq.c
@@ -24,7 +24,7 @@
 #include <linux/completion.h>
 #include <linux/mutex.h>
 #include <linux/time.h>
-#include <linux/of.h>
+#include <linux/of_device.h>
 
 #define DBG(fmt...) pr_debug(fmt)
 
@@ -201,7 +201,6 @@ static struct cpufreq_driver maple_cpufreq_driver = {
 
 static int __init maple_cpufreq_init(void)
 {
-	struct device_node *cpus;
 	struct device_node *cpunode;
 	unsigned int psize;
 	unsigned long max_freq;
@@ -217,24 +216,11 @@ static int __init maple_cpufreq_init(void)
 	    !of_machine_is_compatible("Momentum,Apache"))
 		return 0;
 
-	cpus = of_find_node_by_path("/cpus");
-	if (cpus == NULL) {
-		DBG("No /cpus node !\n");
-		return -ENODEV;
-	}
-
 	/* Get first CPU node */
-	for (cpunode = NULL;
-	     (cpunode = of_get_next_child(cpus, cpunode)) != NULL;) {
-		const u32 *reg = of_get_property(cpunode, "reg", NULL);
-		if (reg == NULL || (*reg) != 0)
-			continue;
-		if (!strcmp(cpunode->type, "cpu"))
-			break;
-	}
+	cpunode = of_cpu_device_node_get(0);
 	if (cpunode == NULL) {
 		printk(KERN_ERR "cpufreq: Can't find any CPU 0 node\n");
-		goto bail_cpus;
+		goto bail_noprops;
 	}
 
 	/* Check 970FX for now */
@@ -290,14 +276,11 @@ static int __init maple_cpufreq_init(void)
 	rc = cpufreq_register_driver(&maple_cpufreq_driver);
 
 	of_node_put(cpunode);
-	of_node_put(cpus);
 
 	return rc;
 
 bail_noprops:
 	of_node_put(cpunode);
-bail_cpus:
-	of_node_put(cpus);
 
 	return rc;
 }
-- 
1.8.1.2
