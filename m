From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 22 Jul 2013 23:31:23 -0400
Subject: [PATCH 07/13] ARM: bL_switcher: hot-unplug half of the available CPUs
In-Reply-To: <1374550289-25305-1-git-send-email-nicolas.pitre@linaro.org>
References: <1374550289-25305-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1374550289-25305-8-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In a regular kernel configuration, all the CPUs are initially available.
But the switcher execution model uses half of them at any time.  Instead
of hacking the DTB to remove half of the CPUs, let's remove them at
run time and make sure we still have a working switcher configuration.
This way, the same DTB can be used whether or not the switcher is used.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 arch/arm/common/bL_switcher.c | 78 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 77 insertions(+), 1 deletion(-)

diff --git a/arch/arm/common/bL_switcher.c b/arch/arm/common/bL_switcher.c
index 3ff7bfe126..4273be76ba 100644
--- a/arch/arm/common/bL_switcher.c
+++ b/arch/arm/common/bL_switcher.c
@@ -295,18 +295,94 @@ int bL_switch_request(unsigned int cpu, unsigned int new_cluster_id)
 }
 EXPORT_SYMBOL_GPL(bL_switch_request);
 
+/*
+ * Activation and configuration code.
+ */
+
+static cpumask_t bL_switcher_removed_logical_cpus;
+
+static void __init bL_switcher_restore_cpus(void)
+{
+	int i;
+
+	for_each_cpu(i, &bL_switcher_removed_logical_cpus)
+		cpu_up(i);
+}
+
+static int __init bL_switcher_halve_cpus(void)
+{
+	int cpu, cluster, i, ret;
+	cpumask_t cluster_mask[2], common_mask;
+
+	cpumask_clear(&bL_switcher_removed_logical_cpus);
+	cpumask_clear(&cluster_mask[0]);
+	cpumask_clear(&cluster_mask[1]);
+
+	for_each_online_cpu(i) {
+		cpu = cpu_logical_map(i) & 0xff;
+		cluster = (cpu_logical_map(i) >> 8) & 0xff;
+		if (cluster >= 2) {
+			pr_err("%s: only dual cluster systems are supported\n", __func__);
+			return -EINVAL;
+		}
+		cpumask_set_cpu(cpu, &cluster_mask[cluster]);
+	}
+
+	if (!cpumask_and(&common_mask, &cluster_mask[0], &cluster_mask[1])) {
+		pr_err("%s: no common set of CPUs\n", __func__);
+		return -EINVAL;
+	}
+
+	for_each_online_cpu(i) {
+		cpu = cpu_logical_map(i) & 0xff;
+		cluster = (cpu_logical_map(i) >> 8) & 0xff;
+
+		if (cpumask_test_cpu(cpu, &common_mask)) {
+			/*
+			 * We keep only those logical CPUs which number
+			 * is equal to their physical CPU number. This is
+			 * not perfect but good enough for now.
+			 */
+			if (cpu == i)
+				continue;
+		}
+
+		ret = cpu_down(i);
+		if (ret) {
+			bL_switcher_restore_cpus();
+			return ret;
+		}
+		cpumask_set_cpu(i, &bL_switcher_removed_logical_cpus);
+	}
+
+	return 0;
+}
+
 static int __init bL_switcher_init(void)
 {
-	int cpu;
+	int cpu, ret;
 
 	pr_info("big.LITTLE switcher initializing\n");
 
+	if (MAX_NR_CLUSTERS != 2) {
+		pr_err("%s: only dual cluster systems are supported\n", __func__);
+		return -EINVAL;
+	}
+
+	cpu_hotplug_driver_lock();
+	ret = bL_switcher_halve_cpus();
+	if (ret) {
+		cpu_hotplug_driver_unlock();
+		return ret;
+	}
+
 	for_each_online_cpu(cpu) {
 		struct bL_thread *t = &bL_threads[cpu];
 		init_waitqueue_head(&t->wq);
 		t->wanted_cluster = -1;
 		t->task = bL_switcher_thread_create(cpu, t);
 	}
+	cpu_hotplug_driver_unlock();
 
 	pr_info("big.LITTLE switcher initialized\n");
 	return 0;
-- 
1.8.1.2
