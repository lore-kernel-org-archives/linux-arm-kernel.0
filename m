From: guohanjun@huawei.com (Hanjun Guo)
Date: Sat, 23 Jan 2016 17:39:23 +0800
Subject: [PATCH v3 08/12] arm64, numa: rework numa_add_memblk()
In-Reply-To: <1453541967-3744-1-git-send-email-guohanjun@huawei.com>
References: <1453541967-3744-1-git-send-email-guohanjun@huawei.com>
Message-ID: <1453541967-3744-9-git-send-email-guohanjun@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hanjun Guo <hanjun.guo@linaro.org>

Rework numa_add_memblk() to update the parameter "u64 size"
to "u64 end", this will make it consistent with x86 and
can simplify the code later.

Updates for arch/arm64/mm/numa.c should squash to core NUMA
patches from Ganapat.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 arch/arm64/kernel/acpi_numa.c |  2 +-
 arch/arm64/kernel/of_numa.c   |  2 +-
 arch/arm64/mm/numa.c          | 12 ++++++------
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/kernel/acpi_numa.c b/arch/arm64/kernel/acpi_numa.c
index 15fb935..3bcf058 100644
--- a/arch/arm64/kernel/acpi_numa.c
+++ b/arch/arm64/kernel/acpi_numa.c
@@ -184,7 +184,7 @@ int __init acpi_numa_memory_affinity_init(struct acpi_srat_mem_affinity *ma)
 		node, pxm,
 		(unsigned long long) start, (unsigned long long) end - 1);
 
-	if (numa_add_memblk(node, start, (end - start)) < 0) {
+	if (numa_add_memblk(node, start, end) < 0) {
 		bad_srat();
 		return -EINVAL;
 	}
diff --git a/arch/arm64/kernel/of_numa.c b/arch/arm64/kernel/of_numa.c
index 2f9e34b..aa6f3a3 100644
--- a/arch/arm64/kernel/of_numa.c
+++ b/arch/arm64/kernel/of_numa.c
@@ -168,7 +168,7 @@ static int __init early_init_parse_memory_node(unsigned long node)
 		pr_debug("NUMA-DT:  base = %llx , node = %u\n",
 				base, nid);
 
-		if (numa_add_memblk(nid, base, size) < 0)
+		if (numa_add_memblk(nid, base, base + size) < 0)
 			return -EINVAL;
 	}
 
diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
index e974995..2b04b8a 100644
--- a/arch/arm64/mm/numa.c
+++ b/arch/arm64/mm/numa.c
@@ -137,25 +137,25 @@ void numa_store_cpu_info(unsigned int cpu)
  * numa_add_memblk - Set node id to memblk
  * @nid: NUMA node ID of the new memblk
  * @start: Start address of the new memblk
- * @size:  Size of the new memblk
+ * @end:  End address of the new memblk
  *
  * RETURNS:
  * 0 on success, -errno on failure.
  */
-int __init numa_add_memblk(int nid, u64 start, u64 size)
+int __init numa_add_memblk(int nid, u64 start, u64 end)
 {
 	int ret;
 
-	ret = memblock_set_node(start, size, &memblock.memory, nid);
+	ret = memblock_set_node(start, (end - start), &memblock.memory, nid);
 	if (ret < 0) {
 		pr_err("NUMA: memblock [0x%llx - 0x%llx] failed to add on node %d\n",
-			start, (start + size - 1), nid);
+			start, (end - 1), nid);
 		return ret;
 	}
 
 	node_set(nid, numa_nodes_parsed);
 	pr_info("NUMA: Adding memblock [0x%llx - 0x%llx] on node %d\n",
-			start, (start + size - 1), nid);
+			start, (end - 1), nid);
 	return ret;
 }
 EXPORT_SYMBOL(numa_add_memblk);
@@ -366,7 +366,7 @@ static int __init dummy_numa_init(void)
 	       0LLU, PFN_PHYS(max_pfn) - 1);
 
 	for_each_memblock(memory, mblk) {
-		ret = numa_add_memblk(0, mblk->base, mblk->size);
+		ret = numa_add_memblk(0, mblk->base, mblk->base + mblk->size);
 		if (unlikely(ret < 0))
 			return ret;
 	}
-- 
1.9.1
