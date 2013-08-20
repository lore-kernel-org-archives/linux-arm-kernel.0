From: Sudeep.KarkadaNagesha@arm.com (Sudeep KarkadaNagesha)
Date: Tue, 20 Aug 2013 10:30:20 +0100
Subject: [PATCH v4 18/19] cpufreq: pmac64-cpufreq: remove device tree parsing
 for cpu nodes
In-Reply-To: <1376991021-12160-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
References: <1374492747-13879-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376991021-12160-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Message-ID: <1376991021-12160-19-git-send-email-Sudeep.KarkadaNagesha@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>

Now that the cpu device registration initialises the of_node(if available)
appropriately for all the cpus, parsing here is redundant.

This patch removes all DT parsing and uses cpu->of_node instead.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
---
 drivers/cpufreq/pmac64-cpufreq.c | 47 ++++++++++------------------------------
 1 file changed, 11 insertions(+), 36 deletions(-)

diff --git a/drivers/cpufreq/pmac64-cpufreq.c b/drivers/cpufreq/pmac64-cpufreq.c
index 7ba4234..97b719f 100644
--- a/drivers/cpufreq/pmac64-cpufreq.c
+++ b/drivers/cpufreq/pmac64-cpufreq.c
@@ -22,6 +22,7 @@
 #include <linux/init.h>
 #include <linux/completion.h>
 #include <linux/mutex.h>
+#include <linux/of_device.h>
 #include <asm/prom.h>
 #include <asm/machdep.h>
 #include <asm/irq.h>
@@ -383,9 +384,8 @@ static struct cpufreq_driver g5_cpufreq_driver = {
 
 #ifdef CONFIG_PMAC_SMU
 
-static int __init g5_neo2_cpufreq_init(struct device_node *cpus)
+static int __init g5_neo2_cpufreq_init(struct device_node *cpunode)
 {
-	struct device_node *cpunode;
 	unsigned int psize, ssize;
 	unsigned long max_freq;
 	char *freq_method, *volt_method;
@@ -405,20 +405,6 @@ static int __init g5_neo2_cpufreq_init(struct device_node *cpus)
 	else
 		return -ENODEV;
 
-	/* Get first CPU node */
-	for (cpunode = NULL;
-	     (cpunode = of_get_next_child(cpus, cpunode)) != NULL;) {
-		const u32 *reg = of_get_property(cpunode, "reg", NULL);
-		if (reg == NULL || (*reg) != 0)
-			continue;
-		if (!strcmp(cpunode->type, "cpu"))
-			break;
-	}
-	if (cpunode == NULL) {
-		printk(KERN_ERR "cpufreq: Can't find any CPU 0 node\n");
-		return -ENODEV;
-	}
-
 	/* Check 970FX for now */
 	valp = of_get_property(cpunode, "cpu-version", NULL);
 	if (!valp) {
@@ -537,9 +523,9 @@ static int __init g5_neo2_cpufreq_init(struct device_node *cpus)
 #endif /* CONFIG_PMAC_SMU */
 
 
-static int __init g5_pm72_cpufreq_init(struct device_node *cpus)
+static int __init g5_pm72_cpufreq_init(struct device_node *cpunode)
 {
-	struct device_node *cpuid = NULL, *hwclock = NULL, *cpunode = NULL;
+	struct device_node *cpuid = NULL, *hwclock = NULL;
 	const u8 *eeprom = NULL;
 	const u32 *valp;
 	u64 max_freq, min_freq, ih, il;
@@ -548,17 +534,6 @@ static int __init g5_pm72_cpufreq_init(struct device_node *cpus)
 	DBG("cpufreq: Initializing for PowerMac7,2, PowerMac7,3 and"
 	    " RackMac3,1...\n");
 
-	/* Get first CPU node */
-	for (cpunode = NULL;
-	     (cpunode = of_get_next_child(cpus, cpunode)) != NULL;) {
-		if (!strcmp(cpunode->type, "cpu"))
-			break;
-	}
-	if (cpunode == NULL) {
-		printk(KERN_ERR "cpufreq: Can't find any CPU node\n");
-		return -ENODEV;
-	}
-
 	/* Lookup the cpuid eeprom node */
         cpuid = of_find_node_by_path("/u3 at 0,f8000000/i2c at f8001000/cpuid at a0");
 	if (cpuid != NULL)
@@ -718,25 +693,25 @@ static int __init g5_pm72_cpufreq_init(struct device_node *cpus)
 
 static int __init g5_cpufreq_init(void)
 {
-	struct device_node *cpus;
+	struct device_node *cpunode;
 	int rc = 0;
 
-	cpus = of_find_node_by_path("/cpus");
-	if (cpus == NULL) {
-		DBG("No /cpus node !\n");
+	/* Get first CPU node */
+	cpunode = of_cpu_device_node_get(0);
+	if (cpunode == NULL) {
+		pr_err("cpufreq: Can't find any CPU node\n");
 		return -ENODEV;
 	}
 
 	if (of_machine_is_compatible("PowerMac7,2") ||
 	    of_machine_is_compatible("PowerMac7,3") ||
 	    of_machine_is_compatible("RackMac3,1"))
-		rc = g5_pm72_cpufreq_init(cpus);
+		rc = g5_pm72_cpufreq_init(cpunode);
 #ifdef CONFIG_PMAC_SMU
 	else
-		rc = g5_neo2_cpufreq_init(cpus);
+		rc = g5_neo2_cpufreq_init(cpunode);
 #endif /* CONFIG_PMAC_SMU */
 
-	of_node_put(cpus);
 	return rc;
 }
 
-- 
1.8.1.2
