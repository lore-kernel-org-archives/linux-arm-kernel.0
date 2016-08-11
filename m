From: thunder.leizhen@huawei.com (Zhen Lei)
Date: Thu, 11 Aug 2016 17:33:45 +0800
Subject: [PATCH v6 11/14] arm64/numa: support HAVE_MEMORYLESS_NODES
In-Reply-To: <1470908028-8596-1-git-send-email-thunder.leizhen@huawei.com>
References: <1470908028-8596-1-git-send-email-thunder.leizhen@huawei.com>
Message-ID: <1470908028-8596-12-git-send-email-thunder.leizhen@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some numa nodes may have no memory. For example:
1. cpu0 on node0
2. cpu1 on node1
3. device0 access the momory from node0 and node1 take the same time.

So, we can not simply classify device0 to node0 or node1, but we can
define a node2 which distances to node0 and node1 are the same.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 arch/arm64/Kconfig      |  4 ++++
 arch/arm64/kernel/smp.c |  1 +
 arch/arm64/mm/numa.c    | 43 +++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 2815af6..3a2b6ed 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -611,6 +611,10 @@ config NEED_PER_CPU_EMBED_FIRST_CHUNK
 	def_bool y
 	depends on NUMA

+config HAVE_MEMORYLESS_NODES
+	def_bool y
+	depends on NUMA
+
 source kernel/Kconfig.preempt
 source kernel/Kconfig.hz

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 76a6d92..aa677f4 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -619,6 +619,7 @@ static void __init of_parse_and_init_cpus(void)
 			}

 			bootcpu_valid = true;
+			early_map_cpu_to_node(0, of_node_to_nid(dn));

 			/*
 			 * cpu_logical_map has already been
diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
index bd4d26a9..30d3279 100644
--- a/arch/arm64/mm/numa.c
+++ b/arch/arm64/mm/numa.c
@@ -128,6 +128,14 @@ void __init early_map_cpu_to_node(unsigned int cpu, int nid)
 		nid = 0;

 	cpu_to_node_map[cpu] = nid;
+
+	/*
+	 * We should set the numa node of cpu0 as soon as possible, because it
+	 * has already been set up online before. cpu_to_node(0) will soon be
+	 * called.
+	 */
+	if (!cpu)
+		set_cpu_numa_node(cpu, nid);
 }

 #ifdef CONFIG_HAVE_SETUP_PER_CPU_AREA
@@ -210,6 +218,35 @@ int __init numa_add_memblk(int nid, u64 start, u64 end)
 	return ret;
 }

+static u64 __init alloc_node_data_from_nearest_node(int nid, const size_t size)
+{
+	int i, best_nid, distance;
+	u64 pa;
+	DECLARE_BITMAP(nodes_map, MAX_NUMNODES);
+
+	bitmap_zero(nodes_map, MAX_NUMNODES);
+	bitmap_set(nodes_map, nid, 1);
+
+find_nearest_node:
+	best_nid = NUMA_NO_NODE;
+	distance = INT_MAX;
+
+	for_each_clear_bit(i, nodes_map, MAX_NUMNODES)
+		if (numa_distance[nid][i] < distance) {
+			best_nid = i;
+			distance = numa_distance[nid][i];
+		}
+
+	pa = memblock_alloc_nid(size, SMP_CACHE_BYTES, best_nid);
+	if (!pa) {
+		BUG_ON(best_nid == NUMA_NO_NODE);
+		bitmap_set(nodes_map, best_nid, 1);
+		goto find_nearest_node;
+	}
+
+	return pa;
+}
+
 /**
  * Initialize NODE_DATA for a node on the local memory
  */
@@ -223,7 +260,9 @@ static void __init setup_node_data(int nid, u64 start_pfn, u64 end_pfn)
 	pr_info("Initmem setup node %d [mem %#010Lx-%#010Lx]\n",
 		nid, start_pfn << PAGE_SHIFT, (end_pfn << PAGE_SHIFT) - 1);

-	nd_pa = memblock_alloc_try_nid(nd_size, SMP_CACHE_BYTES, nid);
+	nd_pa = memblock_alloc_nid(nd_size, SMP_CACHE_BYTES, nid);
+	if (!nd_pa)
+		nd_pa = alloc_node_data_from_nearest_node(nid, nd_size);
 	nd = __va(nd_pa);

 	/* report and initialize */
@@ -233,7 +272,7 @@ static void __init setup_node_data(int nid, u64 start_pfn, u64 end_pfn)
 	if (tnid != nid)
 		pr_info("    NODE_DATA(%d) on node %d\n", nid, tnid);

-	node_data[nid] = nd;
+	NODE_DATA(nid) = nd;
 	memset(NODE_DATA(nid), 0, sizeof(pg_data_t));
 	NODE_DATA(nid)->node_id = nid;
 	NODE_DATA(nid)->node_start_pfn = start_pfn;
--
2.5.0
