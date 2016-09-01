From: thunder.leizhen@huawei.com (Zhen Lei)
Date: Thu, 1 Sep 2016 14:55:01 +0800
Subject: [PATCH v8 10/16] mm/memblock: add a new function
 memblock_alloc_near_nid
In-Reply-To: <1472712907-12700-1-git-send-email-thunder.leizhen@huawei.com>
References: <1472712907-12700-1-git-send-email-thunder.leizhen@huawei.com>
Message-ID: <1472712907-12700-11-git-send-email-thunder.leizhen@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If HAVE_MEMORYLESS_NODES is selected, and some memoryless numa nodes are
actually exist. The percpu variable areas and numa control blocks of that
memoryless numa nodes must be allocated from the nearest available node
to improve performance.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 include/linux/memblock.h |  1 +
 mm/memblock.c            | 28 ++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 2925da2..8e866e0 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -290,6 +290,7 @@ static inline int memblock_get_region_node(const struct memblock_region *r)

 phys_addr_t memblock_alloc_nid(phys_addr_t size, phys_addr_t align, int nid);
 phys_addr_t memblock_alloc_try_nid(phys_addr_t size, phys_addr_t align, int nid);
+phys_addr_t memblock_alloc_near_nid(phys_addr_t size, phys_addr_t align, int nid);

 phys_addr_t memblock_alloc(phys_addr_t size, phys_addr_t align);

diff --git a/mm/memblock.c b/mm/memblock.c
index 483197e..6578fff 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1189,6 +1189,34 @@ again:
 	return ret;
 }

+phys_addr_t __init memblock_alloc_near_nid(phys_addr_t size, phys_addr_t align, int nid)
+{
+	int i, best_nid, distance;
+	u64 pa;
+	DECLARE_BITMAP(nodes_map, MAX_NUMNODES);
+
+	bitmap_zero(nodes_map, MAX_NUMNODES);
+
+find_nearest_node:
+	best_nid = NUMA_NO_NODE;
+	distance = INT_MAX;
+
+	for_each_clear_bit(i, nodes_map, MAX_NUMNODES)
+		if (node_distance(nid, i) < distance) {
+			best_nid = i;
+			distance = node_distance(nid, i);
+		}
+
+	pa = memblock_alloc_nid(size, align, best_nid);
+	if (!pa) {
+		BUG_ON(best_nid == NUMA_NO_NODE);
+		bitmap_set(nodes_map, best_nid, 1);
+		goto find_nearest_node;
+	}
+
+	return pa;
+}
+
 phys_addr_t __init __memblock_alloc_base(phys_addr_t size, phys_addr_t align, phys_addr_t max_addr)
 {
 	return memblock_alloc_base_nid(size, align, max_addr, NUMA_NO_NODE,
--
2.5.0
