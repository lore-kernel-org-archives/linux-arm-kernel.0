From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri,  6 Jul 2018 12:02:43 +0100
Subject: [PATCH v3 2/7] arm64: numa: separate out updates to percpu nodeid and
 NUMA node cpumap
In-Reply-To: <1530874968-5960-1-git-send-email-sudeep.holla@arm.com>
References: <1530874968-5960-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <1530874968-5960-3-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently numa_clear_node removes both cpu information from the NUMA
node cpumap as well as the NUMA node id from the cpu. Similarly
numa_store_cpu_info updates both percpu nodeid and NUMA cpumap.

However we need to retain the numa node id for the cpu and only remove
the cpu information from the numa node cpumap during CPU hotplug out.
The same can be extended for hotplugging in the CPU.

This patch separates out numa_{add,remove}_cpu from numa_clear_node and
numa_store_cpu_info.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Reviewed-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
Tested-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
Tested-by: Hanjun Guo <hanjun.guo@linaro.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm64/include/asm/numa.h |  4 ++++
 arch/arm64/kernel/smp.c       |  2 ++
 arch/arm64/mm/numa.c          | 29 +++++++++++++++++++++--------
 3 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/numa.h b/arch/arm64/include/asm/numa.h
index 01bc46d5b43a..626ad01e83bf 100644
--- a/arch/arm64/include/asm/numa.h
+++ b/arch/arm64/include/asm/numa.h
@@ -35,10 +35,14 @@ void __init numa_set_distance(int from, int to, int distance);
 void __init numa_free_distance(void);
 void __init early_map_cpu_to_node(unsigned int cpu, int nid);
 void numa_store_cpu_info(unsigned int cpu);
+void numa_add_cpu(unsigned int cpu);
+void numa_remove_cpu(unsigned int cpu);
 
 #else	/* CONFIG_NUMA */
 
 static inline void numa_store_cpu_info(unsigned int cpu) { }
+static inline void numa_add_cpu(unsigned int cpu) { }
+static inline void numa_remove_cpu(unsigned int cpu) { }
 static inline void arm64_numa_init(void) { }
 static inline void early_map_cpu_to_node(unsigned int cpu, int nid) { }
 
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 2faa9863d2e5..2a315f32fad3 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -225,6 +225,7 @@ asmlinkage notrace void secondary_start_kernel(void)
 	notify_cpu_starting(cpu);
 
 	store_cpu_topology(cpu);
+	numa_add_cpu(cpu);
 
 	/*
 	 * OK, now it's safe to let the boot CPU continue.  Wait for
@@ -679,6 +680,7 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 	this_cpu = smp_processor_id();
 	store_cpu_topology(this_cpu);
 	numa_store_cpu_info(this_cpu);
+	numa_add_cpu(this_cpu);
 
 	/*
 	 * If UP is mandated by "nosmp" (which implies "maxcpus=0"), don't set
diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
index dad128ba98bf..146c04ceaa51 100644
--- a/arch/arm64/mm/numa.c
+++ b/arch/arm64/mm/numa.c
@@ -70,19 +70,32 @@ EXPORT_SYMBOL(cpumask_of_node);
 
 #endif
 
-static void map_cpu_to_node(unsigned int cpu, int nid)
+static void numa_update_cpu(unsigned int cpu, bool remove)
 {
-	set_cpu_numa_node(cpu, nid);
-	if (nid >= 0)
+	int nid = cpu_to_node(cpu);
+
+	if (nid == NUMA_NO_NODE)
+		return;
+
+	if (remove)
+		cpumask_clear_cpu(cpu, node_to_cpumask_map[nid]);
+	else
 		cpumask_set_cpu(cpu, node_to_cpumask_map[nid]);
 }
 
-void numa_clear_node(unsigned int cpu)
+void numa_add_cpu(unsigned int cpu)
 {
-	int nid = cpu_to_node(cpu);
+	numa_update_cpu(cpu, false);
+}
 
-	if (nid >= 0)
-		cpumask_clear_cpu(cpu, node_to_cpumask_map[nid]);
+void numa_remove_cpu(unsigned int cpu)
+{
+	numa_update_cpu(cpu, true);
+}
+
+void numa_clear_node(unsigned int cpu)
+{
+	numa_remove_cpu(cpu);
 	set_cpu_numa_node(cpu, NUMA_NO_NODE);
 }
 
@@ -116,7 +129,7 @@ static void __init setup_node_to_cpumask_map(void)
  */
 void numa_store_cpu_info(unsigned int cpu)
 {
-	map_cpu_to_node(cpu, cpu_to_node_map[cpu]);
+	set_cpu_numa_node(cpu, cpu_to_node_map[cpu]);
 }
 
 void __init early_map_cpu_to_node(unsigned int cpu, int nid)
-- 
2.7.4
