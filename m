From: thunder.leizhen@huawei.com (Zhen Lei)
Date: Thu, 1 Sep 2016 14:55:02 +0800
Subject: [PATCH v8 11/16] arm64/numa: support HAVE_MEMORYLESS_NODES
In-Reply-To: <1472712907-12700-1-git-send-email-thunder.leizhen@huawei.com>
References: <1472712907-12700-1-git-send-email-thunder.leizhen@huawei.com>
Message-ID: <1472712907-12700-12-git-send-email-thunder.leizhen@huawei.com>
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
 arch/arm64/Kconfig   |  4 ++++
 arch/arm64/mm/numa.c | 11 ++++++-----
 2 files changed, 10 insertions(+), 5 deletions(-)

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

diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
index 087064d..891bdaa 100644
--- a/arch/arm64/mm/numa.c
+++ b/arch/arm64/mm/numa.c
@@ -149,10 +149,11 @@ static int __init pcpu_cpu_distance(unsigned int from, unsigned int to)
 static void * __init pcpu_fc_alloc(unsigned int cpu, size_t size,
 				       size_t align)
 {
-	int nid = early_cpu_to_node(cpu);
+	phys_addr_t alloc;

-	return  memblock_virt_alloc_try_nid(size, align,
-			__pa(MAX_DMA_ADDRESS), MEMBLOCK_ALLOC_ACCESSIBLE, nid);
+	alloc = memblock_alloc_near_nid(size, align, early_cpu_to_node(cpu));
+
+	return phys_to_virt(alloc);
 }

 static void __init pcpu_fc_free(void *ptr, size_t size)
@@ -222,7 +223,7 @@ static void __init setup_node_data(int nid, u64 start_pfn, u64 end_pfn)
 	pr_info("Initmem setup node %d [mem %#010Lx-%#010Lx]\n",
 		nid, start_pfn << PAGE_SHIFT, (end_pfn << PAGE_SHIFT) - 1);

-	nd_pa = memblock_alloc_try_nid(nd_size, SMP_CACHE_BYTES, nid);
+	nd_pa = memblock_alloc_near_nid(nd_size, SMP_CACHE_BYTES, nid);
 	nd = __va(nd_pa);

 	/* report and initialize */
@@ -232,7 +233,7 @@ static void __init setup_node_data(int nid, u64 start_pfn, u64 end_pfn)
 	if (tnid != nid)
 		pr_info("NODE_DATA(%d) on node %d\n", nid, tnid);

-	node_data[nid] = nd;
+	NODE_DATA(nid) = nd;
 	memset(NODE_DATA(nid), 0, sizeof(pg_data_t));
 	NODE_DATA(nid)->node_id = nid;
 	NODE_DATA(nid)->node_start_pfn = start_pfn;
--
2.5.0
