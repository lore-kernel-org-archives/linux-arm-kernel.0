From: morten.rasmussen@arm.com (Morten Rasmussen)
Date: Fri, 20 Jul 2018 14:32:32 +0100
Subject: [PATCH 2/4] drivers/base/arch_topology: Rebuild sched_domain
 hierarchy when capacities change
In-Reply-To: <1532093554-30504-1-git-send-email-morten.rasmussen@arm.com>
References: <1532093554-30504-1-git-send-email-morten.rasmussen@arm.com>
Message-ID: <1532093554-30504-3-git-send-email-morten.rasmussen@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The setting of SD_ASYM_CPUCAPACITY depends on the per-cpu capacities.
These might not have their final values when the hierarchy is initially
built as the values depend on cpufreq to be initialized or the values
being set through sysfs. To ensure that the flags are set correctly we
need to rebuild the sched_domain hierarchy whenever the reported per-cpu
capacity (arch_scale_cpu_capacity()) changes.

This patch ensure that a full sched_domain rebuild happens when cpu
capacity changes occur.

cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
---
 drivers/base/arch_topology.c  | 26 ++++++++++++++++++++++++++
 include/linux/arch_topology.h |  1 +
 2 files changed, 27 insertions(+)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index e7cb0c6ade81..edfcf8d982e4 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -15,6 +15,7 @@
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/sched/topology.h>
+#include <linux/cpuset.h>
 
 DEFINE_PER_CPU(unsigned long, freq_scale) = SCHED_CAPACITY_SCALE;
 
@@ -47,6 +48,9 @@ static ssize_t cpu_capacity_show(struct device *dev,
 	return sprintf(buf, "%lu\n", topology_get_cpu_scale(NULL, cpu->dev.id));
 }
 
+static void update_topology_flags_workfn(struct work_struct *work);
+static DECLARE_WORK(update_topology_flags_work, update_topology_flags_workfn);
+
 static ssize_t cpu_capacity_store(struct device *dev,
 				  struct device_attribute *attr,
 				  const char *buf,
@@ -72,6 +76,8 @@ static ssize_t cpu_capacity_store(struct device *dev,
 		topology_set_cpu_scale(i, new_capacity);
 	mutex_unlock(&cpu_scale_mutex);
 
+	schedule_work(&update_topology_flags_work);
+
 	return count;
 }
 
@@ -96,6 +102,25 @@ static int register_cpu_capacity_sysctl(void)
 }
 subsys_initcall(register_cpu_capacity_sysctl);
 
+static int update_topology;
+
+int topology_update_cpu_topology(void)
+{
+	return update_topology;
+}
+
+/*
+ * Updating the sched_domains can't be done directly from cpufreq callbacks
+ * due to locking, so queue the work for later.
+ */
+static void update_topology_flags_workfn(struct work_struct *work)
+{
+	update_topology = 1;
+	rebuild_sched_domains();
+	pr_debug("sched_domain hierarchy rebuilt, flags updated\n");
+	update_topology = 0;
+}
+
 static u32 capacity_scale;
 static u32 *raw_capacity;
 
@@ -201,6 +226,7 @@ init_cpu_capacity_callback(struct notifier_block *nb,
 
 	if (cpumask_empty(cpus_to_visit)) {
 		topology_normalize_cpu_scale();
+		schedule_work(&update_topology_flags_work);
 		free_raw_capacity();
 		pr_debug("cpu_capacity: parsing done\n");
 		schedule_work(&parsing_done_work);
diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
index 2b709416de05..d9bdc1a7f4e7 100644
--- a/include/linux/arch_topology.h
+++ b/include/linux/arch_topology.h
@@ -9,6 +9,7 @@
 #include <linux/percpu.h>
 
 void topology_normalize_cpu_scale(void);
+int topology_update_cpu_topology(void);
 
 struct device_node;
 bool topology_parse_cpu_capacity(struct device_node *cpu_node, int cpu);
-- 
2.7.4
