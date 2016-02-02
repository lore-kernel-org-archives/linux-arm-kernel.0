From: gkulkarni@caviumnetworks.com (Ganapatrao Kulkarni)
Date: Tue, 2 Feb 2016 15:39:19 +0530
Subject: [PATCH v10 4/8] arm64, numa : Enable numa dt for arm64 platforms.
In-Reply-To: <1454407763-1017-1-git-send-email-gkulkarni@caviumnetworks.com>
References: <1454407763-1017-1-git-send-email-gkulkarni@caviumnetworks.com>
Message-ID: <1454407763-1017-5-git-send-email-gkulkarni@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding numa dt binding support for arm64 based platforms.

Reviewed-by: Robert Richter <rrichter@cavium.com>
Signed-off-by: Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>
---
 arch/arm64/include/asm/numa.h |  2 ++
 arch/arm64/kernel/smp.c       |  2 ++
 arch/arm64/mm/numa.c          | 17 +++++++++++++++++
 3 files changed, 21 insertions(+)

diff --git a/arch/arm64/include/asm/numa.h b/arch/arm64/include/asm/numa.h
index 574267f..e9b4f29 100644
--- a/arch/arm64/include/asm/numa.h
+++ b/arch/arm64/include/asm/numa.h
@@ -31,12 +31,14 @@ void __init arm64_numa_init(void);
 int __init numa_add_memblk(int nodeid, u64 start, u64 end);
 void __init numa_set_distance(int from, int to, int distance);
 void __init numa_free_distance(void);
+void __init early_map_cpu_to_node(unsigned int cpu, int nid);
 void numa_store_cpu_info(unsigned int cpu);
 
 #else	/* CONFIG_NUMA */
 
 static inline void numa_store_cpu_info(unsigned int cpu) { }
 static inline void arm64_numa_init(void) { }
+static inline void early_map_cpu_to_node(unsigned int cpu, int nid) { }
 
 #endif	/* CONFIG_NUMA */
 
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index d6e7d6a..46c45c8 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -520,6 +520,8 @@ static void __init of_parse_and_init_cpus(void)
 
 		pr_debug("cpu logical map 0x%llx\n", hwid);
 		cpu_logical_map(cpu_count) = hwid;
+
+		early_map_cpu_to_node(cpu_count, of_node_to_nid(dn));
 next:
 		cpu_count++;
 	}
diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
index 60f19a2..7aad5d4 100644
--- a/arch/arm64/mm/numa.c
+++ b/arch/arm64/mm/numa.c
@@ -20,6 +20,7 @@
 #include <linux/bootmem.h>
 #include <linux/memblock.h>
 #include <linux/module.h>
+#include <linux/of.h>
 
 struct pglist_data *node_data[MAX_NUMNODES] __read_mostly;
 EXPORT_SYMBOL(node_data);
@@ -122,6 +123,15 @@ void numa_store_cpu_info(unsigned int cpu)
 	map_cpu_to_node(cpu, numa_off ? 0 : cpu_to_node_map[cpu]);
 }
 
+void __init early_map_cpu_to_node(unsigned int cpu, int nid)
+{
+	/* fallback to node 0 */
+	if (nid < 0 || nid >= MAX_NUMNODES)
+		nid = 0;
+
+	cpu_to_node_map[cpu] = nid;
+}
+
 /**
  * numa_add_memblk - Set node id to memblk
  * @nid: NUMA node ID of the new memblk
@@ -383,5 +393,12 @@ static int __init dummy_numa_init(void)
  */
 void __init arm64_numa_init(void)
 {
+	if (!numa_off) {
+#ifdef CONFIG_OF_NUMA
+		if (!numa_init(of_numa_init))
+			return;
+#endif
+	}
+
 	numa_init(dummy_numa_init);
 }
-- 
1.8.1.4
