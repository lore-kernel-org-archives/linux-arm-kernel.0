From: thunder.leizhen@huawei.com (Zhen Lei)
Date: Thu, 1 Sep 2016 14:55:07 +0800
Subject: [PATCH v8 16/16] arm64/numa: define numa_distance as array to
 simplify code
In-Reply-To: <1472712907-12700-1-git-send-email-thunder.leizhen@huawei.com>
References: <1472712907-12700-1-git-send-email-thunder.leizhen@huawei.com>
Message-ID: <1472712907-12700-17-git-send-email-thunder.leizhen@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

1. MAX_NUMNODES is base on CONFIG_NODES_SHIFT, the default value of the
   latter is very small now.
2. Suppose the default value of MAX_NUMNODES is enlarged to 64, so the
   size of numa_distance is 4K, it's still acceptable if run the Image
   on other processors.
3. It will make function __node_distance quicker than before.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 arch/arm64/include/asm/numa.h |  1 -
 arch/arm64/mm/numa.c          | 74 +++----------------------------------------
 2 files changed, 5 insertions(+), 70 deletions(-)

diff --git a/arch/arm64/include/asm/numa.h b/arch/arm64/include/asm/numa.h
index 600887e..9b6cc38 100644
--- a/arch/arm64/include/asm/numa.h
+++ b/arch/arm64/include/asm/numa.h
@@ -32,7 +32,6 @@ static inline const struct cpumask *cpumask_of_node(int node)
 void __init arm64_numa_init(void);
 int __init numa_add_memblk(int nodeid, u64 start, u64 end);
 void __init numa_set_distance(int from, int to, int distance);
-void __init numa_free_distance(void);
 void __init early_map_cpu_to_node(unsigned int cpu, int nid);
 void numa_store_cpu_info(unsigned int cpu);

diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
index ef7e336..15ff117 100644
--- a/arch/arm64/mm/numa.c
+++ b/arch/arm64/mm/numa.c
@@ -33,8 +33,7 @@ EXPORT_SYMBOL(node_data);
 nodemask_t numa_nodes_parsed __initdata;
 static int cpu_to_node_map[NR_CPUS] = { [0 ... NR_CPUS-1] = NUMA_NO_NODE };

-static int numa_distance_cnt;
-static u8 *numa_distance;
+static u8 numa_distance[MAX_NUMNODES][MAX_NUMNODES];
 static bool numa_off;

 static __init int numa_parse_early_param(char *opt)
@@ -245,59 +244,6 @@ static void __init setup_node_data(int nid, u64 start_pfn, u64 end_pfn)
 }

 /**
- * numa_free_distance
- *
- * The current table is freed.
- */
-void __init numa_free_distance(void)
-{
-	size_t size;
-
-	if (!numa_distance)
-		return;
-
-	size = numa_distance_cnt * numa_distance_cnt *
-		sizeof(numa_distance[0]);
-
-	memblock_free(__pa(numa_distance), size);
-	numa_distance_cnt = 0;
-	numa_distance = NULL;
-}
-
-/**
- *
- * Create a new NUMA distance table.
- *
- */
-static int __init numa_alloc_distance(void)
-{
-	size_t size;
-	u64 phys;
-	int i, j;
-
-	size = nr_node_ids * nr_node_ids * sizeof(numa_distance[0]);
-	phys = memblock_find_in_range(0, PFN_PHYS(max_pfn),
-				      size, PAGE_SIZE);
-	if (WARN_ON(!phys))
-		return -ENOMEM;
-
-	memblock_reserve(phys, size);
-
-	numa_distance = __va(phys);
-	numa_distance_cnt = nr_node_ids;
-
-	/* fill with the default distances */
-	for (i = 0; i < numa_distance_cnt; i++)
-		for (j = 0; j < numa_distance_cnt; j++)
-			numa_distance[i * numa_distance_cnt + j] = i == j ?
-				LOCAL_DISTANCE : REMOTE_DISTANCE;
-
-	pr_debug("Initialized distance table, cnt=%d\n", numa_distance_cnt);
-
-	return 0;
-}
-
-/**
  * numa_set_distance - Set inter node NUMA distance from node to node.
  * @from: the 'from' node to set distance
  * @to: the 'to'  node to set distance
@@ -312,12 +258,7 @@ static int __init numa_alloc_distance(void)
  */
 void __init numa_set_distance(int from, int to, int distance)
 {
-	if (!numa_distance) {
-		pr_warn_once("Warning: distance table not allocated yet\n");
-		return;
-	}
-
-	if (from >= numa_distance_cnt || to >= numa_distance_cnt ||
+	if (from >= MAX_NUMNODES || to >= MAX_NUMNODES ||
 			from < 0 || to < 0) {
 		pr_warn_once("Warning: node ids are out of bound, from=%d to=%d distance=%d\n",
 			    from, to, distance);
@@ -331,7 +272,7 @@ void __init numa_set_distance(int from, int to, int distance)
 		return;
 	}

-	numa_distance[from * numa_distance_cnt + to] = distance;
+	numa_distance[from][to] = distance;
 }

 /**
@@ -339,9 +280,9 @@ void __init numa_set_distance(int from, int to, int distance)
  */
 int __node_distance(int from, int to)
 {
-	if (from >= numa_distance_cnt || to >= numa_distance_cnt)
+	if (from >= MAX_NUMNODES || to >= MAX_NUMNODES)
 		return from == to ? LOCAL_DISTANCE : REMOTE_DISTANCE;
-	return numa_distance[from * numa_distance_cnt + to];
+	return numa_distance[from][to];
 }
 EXPORT_SYMBOL(__node_distance);

@@ -381,11 +322,6 @@ static int __init numa_init(int (*init_func)(void))
 	nodes_clear(numa_nodes_parsed);
 	nodes_clear(node_possible_map);
 	nodes_clear(node_online_map);
-	numa_free_distance();
-
-	ret = numa_alloc_distance();
-	if (ret < 0)
-		return ret;

 	ret = init_func();
 	if (ret < 0)
--
2.5.0
