From: Sudeep.KarkadaNagesha@arm.com (Sudeep.KarkadaNagesha at arm.com)
Date: Wed, 17 Jul 2013 15:06:24 +0100
Subject: [RFC PATCH v2 15/15] cpufreq: pmac32-cpufreq: remove device tree
 parsing for cpu nodes
In-Reply-To: <1374069984-20567-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
References: <1374069984-20567-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Message-ID: <1374069984-20567-16-git-send-email-Sudeep.KarkadaNagesha@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>

Now that the cpu device registration initialises the of_node(if available)
appropriately for all the cpus, parsing here is redundant.

This patch removes DT parsing and uses cpu->of_node instead.

Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
---
 drivers/cpufreq/pmac32-cpufreq.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/pmac32-cpufreq.c b/drivers/cpufreq/pmac32-cpufreq.c
index 3104fad..b6822ee 100644
--- a/drivers/cpufreq/pmac32-cpufreq.c
+++ b/drivers/cpufreq/pmac32-cpufreq.c
@@ -21,6 +21,7 @@
 #include <linux/sched.h>
 #include <linux/adb.h>
 #include <linux/pmu.h>
+#include <linux/cpu.h>
 #include <linux/cpufreq.h>
 #include <linux/init.h>
 #include <linux/device.h>
@@ -643,6 +644,7 @@ static int pmac_cpufreq_init_750FX(struct device_node *cpunode)
  */
 static int __init pmac_cpufreq_setup(void)
 {
+	struct device *cpu_dev;
 	struct device_node	*cpunode;
 	const u32		*value;
 
@@ -650,7 +652,14 @@ static int __init pmac_cpufreq_setup(void)
 		return 0;
 
 	/* Assume only one CPU */
-	cpunode = of_find_node_by_type(NULL, "cpu");
+	cpu_dev = get_cpu_device(0);
+	if (!cpu_dev) {
+		pr_err("failed to get cpu device\n");
+		return -ENODEV;
+	}
+
+	/* Get first CPU node */
+	cpunode = of_node_get(cpu_dev->of_node);
 	if (!cpunode)
 		goto out;
 
-- 
1.8.1.2
