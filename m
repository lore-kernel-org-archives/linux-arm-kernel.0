From: dennis.chen@arm.com (Dennis Chen)
Date: Wed, 29 Jun 2016 08:57:34 +0800
Subject: [PATCH v5 2/3] mm: memblock Add some new functions to address the mem
 limit issue
In-Reply-To: <1467161855-10010-1-git-send-email-dennis.chen@arm.com>
References: <1467161855-10010-1-git-send-email-dennis.chen@arm.com>
Message-ID: <1467161855-10010-2-git-send-email-dennis.chen@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In some cases, memblock is queried to determine whether a physical
address corresponds to memory present in a system even if unused by
the OS for the linear mapping, highmem, etc. For example, the ACPI
core needs this information to determine which attributes to use when
mapping ACPI regions. Use of incorrect memory types can result in
faults, data corruption, or other issues.

Removing memory with memblock_enforce_memory_limit throws away this
information, and so a kernel booted with 'mem=' may suffers from the
issues described above. To avoid this, we need to kept those nomap
regions instead of removing all above limit, which preserves the
information we need while preventing other use of the regions.

This patch adds new insfrastructure to keep all nomap memblock regions
while removing others, to cater for this.

Signed-off-by: Dennis Chen <dennis.chen@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Steve Capper <steve.capper@arm.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Matt Fleming <matt@codeblueprint.co.uk>
Cc: linux-mm at kvack.org
Cc: linux-acpi at vger.kernel.org
Cc: linux-efi at vger.kernel.org
---
Change history
v4->v5: Fix a build warning
v3->v4: Incorporate some review comments from Mark Rutland.
v2->v3: Only keep the NOMAP regions above limit while removing all
others according to the proposal from Ard's
v1->v2: Flag all regions above the limit as NOMAP per Mark's suggestion

 include/linux/memblock.h |  1 +
 mm/memblock.c            | 53 +++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 49 insertions(+), 5 deletions(-)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 6c14b61..2925da2 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -332,6 +332,7 @@ phys_addr_t memblock_mem_size(unsigned long limit_pfn);
 phys_addr_t memblock_start_of_DRAM(void);
 phys_addr_t memblock_end_of_DRAM(void);
 void memblock_enforce_memory_limit(phys_addr_t memory_limit);
+void memblock_mem_limit_remove_map(phys_addr_t limit);
 bool memblock_is_memory(phys_addr_t addr);
 int memblock_is_map_memory(phys_addr_t addr);
 int memblock_is_region_memory(phys_addr_t base, phys_addr_t size);
diff --git a/mm/memblock.c b/mm/memblock.c
index 0fc0fa1..050ad0c 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1465,15 +1465,16 @@ phys_addr_t __init_memblock memblock_end_of_DRAM(void)
 	return (memblock.memory.regions[idx].base + memblock.memory.regions[idx].size);
 }
 
-void __init memblock_enforce_memory_limit(phys_addr_t limit)
+static phys_addr_t __init_memblock __find_max_addr(phys_addr_t limit)
 {
 	phys_addr_t max_addr = (phys_addr_t)ULLONG_MAX;
 	struct memblock_region *r;
 
-	if (!limit)
-		return;
-
-	/* find out max address */
+	/*
+	 * translate the memory @limit size into the max address within one of
+	 * the memory memblock regions, if the @limit exceeds the total size
+	 * of those regions, max_addr will keep original value ULLONG_MAX
+	 */
 	for_each_memblock(memory, r) {
 		if (limit <= r->size) {
 			max_addr = r->base + limit;
@@ -1482,6 +1483,22 @@ void __init memblock_enforce_memory_limit(phys_addr_t limit)
 		limit -= r->size;
 	}
 
+	return max_addr;
+}
+
+void __init memblock_enforce_memory_limit(phys_addr_t limit)
+{
+	phys_addr_t max_addr = (phys_addr_t)ULLONG_MAX;
+
+	if (!limit)
+		return;
+
+	max_addr = __find_max_addr(limit);
+
+	/* @limit exceeds the total size of the memory, do nothing */
+	if (max_addr == (phys_addr_t)ULLONG_MAX)
+		return;
+
 	/* truncate both memory and reserved regions */
 	memblock_remove_range(&memblock.memory, max_addr,
 			      (phys_addr_t)ULLONG_MAX);
@@ -1489,6 +1506,32 @@ void __init memblock_enforce_memory_limit(phys_addr_t limit)
 			      (phys_addr_t)ULLONG_MAX);
 }
 
+void __init memblock_mem_limit_remove_map(phys_addr_t limit)
+{
+	struct memblock_type *type = &memblock.memory;
+	phys_addr_t max_addr;
+	int i, ret, start_rgn, end_rgn;
+
+	if (!limit)
+		return;
+
+	max_addr = __find_max_addr(limit);
+
+	/* @limit exceeds the total size of the memory, do nothing */
+	if (max_addr == (phys_addr_t)ULLONG_MAX)
+		return;
+
+	ret = memblock_isolate_range(type, max_addr, (phys_addr_t)ULLONG_MAX,
+				&start_rgn, &end_rgn);
+	if (ret)
+		return;
+
+	for (i = end_rgn - 1; i >= start_rgn; i--) {
+		if (!memblock_is_nomap(&type->regions[i]))
+			memblock_remove_region(type, i);
+	}
+}
+
 static int __init_memblock memblock_search(struct memblock_type *type, phys_addr_t addr)
 {
 	unsigned int left = 0, right = type->cnt;
-- 
2.7.4
