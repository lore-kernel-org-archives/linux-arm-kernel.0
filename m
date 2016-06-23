From: dennis.chen@arm.com (Dennis Chen)
Date: Thu, 23 Jun 2016 19:30:14 +0800
Subject: [PATCH 1/2] mm: memblock Add some new functions to address the mem
 limit issue
Message-ID: <1466681415-8058-1-git-send-email-dennis.chen@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Two major changes in this patch:
[1] Add memblock_mem_limit_mark_nomap(phys_addr_t limit) function to
mark memblock regions above the @limit as NOMAP region, which will
be used to address the observed 'mem=x' kernel parameter issue.

[2] Add 'size' and 'flag' debug output in the memblock debugfs.
The '/sys/kernel/debug/memblock/memory' output looks like before:
   0: 0x0000008000000000..0x0000008001e7ffff
   1: 0x0000008001e80000..0x00000083ff184fff
   2: 0x00000083ff185000..0x00000083ff1c2fff
   3: 0x00000083ff1c3000..0x00000083ff222fff
   4: 0x00000083ff223000..0x00000083ffe42fff
   5: 0x00000083ffe43000..0x00000083ffffffff

With this patch applied:
   0: 0x0000008000000000..0x0000008001e7ffff  0x0000000001e80000  0x4
   1: 0x0000008001e80000..0x00000083ff184fff  0x00000003fd305000  0x0
   2: 0x00000083ff185000..0x00000083ff1c2fff  0x000000000003e000  0x4
   3: 0x00000083ff1c3000..0x00000083ff222fff  0x0000000000060000  0x0
   4: 0x00000083ff223000..0x00000083ffe42fff  0x0000000000c20000  0x4
   5: 0x00000083ffe43000..0x00000083ffffffff  0x00000000001bd000  0x0

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
 include/linux/memblock.h |  2 ++
 mm/memblock.c            | 50 ++++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 44 insertions(+), 8 deletions(-)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 6c14b61..5e069c8 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -92,6 +92,7 @@ int memblock_mark_hotplug(phys_addr_t base, phys_addr_t size);
 int memblock_clear_hotplug(phys_addr_t base, phys_addr_t size);
 int memblock_mark_mirror(phys_addr_t base, phys_addr_t size);
 int memblock_mark_nomap(phys_addr_t base, phys_addr_t size);
+int memblock_clear_nomap(phys_addr_t base, phys_addr_t size);
 ulong choose_memblock_flags(void);
 
 /* Low level functions */
@@ -332,6 +333,7 @@ phys_addr_t memblock_mem_size(unsigned long limit_pfn);
 phys_addr_t memblock_start_of_DRAM(void);
 phys_addr_t memblock_end_of_DRAM(void);
 void memblock_enforce_memory_limit(phys_addr_t memory_limit);
+void memblock_mem_limit_mark_nomap(phys_addr_t limit);
 bool memblock_is_memory(phys_addr_t addr);
 int memblock_is_map_memory(phys_addr_t addr);
 int memblock_is_region_memory(phys_addr_t base, phys_addr_t size);
diff --git a/mm/memblock.c b/mm/memblock.c
index ca09915..60930ac 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -814,6 +814,18 @@ int __init_memblock memblock_mark_nomap(phys_addr_t base, phys_addr_t size)
 }
 
 /**
+ * memblock_clear_nomap - Clear flag MEMBLOCK_NOMAP for a specified region.
+ * @base: the base phys addr of the region
+ * @size: the size of the region
+ *
+ * Return 0 on success, -errno on failure.
+ */
+int __init_memblock memblock_clear_nomap(phys_addr_t base, phys_addr_t size)
+{
+	return memblock_setclr_flag(base, size, 0, MEMBLOCK_NOMAP);
+}
+
+/**
  * __next_reserved_mem_region - next function for for_each_reserved_region()
  * @idx: pointer to u64 loop variable
  * @out_start: ptr to phys_addr_t for start address of the region, can be %NULL
@@ -1465,14 +1477,11 @@ phys_addr_t __init_memblock memblock_end_of_DRAM(void)
 	return (memblock.memory.regions[idx].base + memblock.memory.regions[idx].size);
 }
 
-void __init memblock_enforce_memory_limit(phys_addr_t limit)
+static phys_addr_t __find_max_addr(phys_addr_t limit)
 {
 	phys_addr_t max_addr = (phys_addr_t)ULLONG_MAX;
 	struct memblock_region *r;
 
-	if (!limit)
-		return;
-
 	/* find out max address */
 	for_each_memblock(memory, r) {
 		if (limit <= r->size) {
@@ -1482,6 +1491,18 @@ void __init memblock_enforce_memory_limit(phys_addr_t limit)
 		limit -= r->size;
 	}
 
+	return max_addr;
+}
+
+void __init memblock_enforce_memory_limit(phys_addr_t limit)
+{
+	phys_addr_t max_addr;
+
+	if (!limit)
+		return;
+
+	max_addr = __find_max_addr(limit);
+
 	/* truncate both memory and reserved regions */
 	memblock_remove_range(&memblock.memory, max_addr,
 			      (phys_addr_t)ULLONG_MAX);
@@ -1489,6 +1510,17 @@ void __init memblock_enforce_memory_limit(phys_addr_t limit)
 			      (phys_addr_t)ULLONG_MAX);
 }
 
+void __init memblock_mem_limit_mark_nomap(phys_addr_t limit)
+{
+	phys_addr_t max_addr;
+
+	if (!limit)
+		return;
+
+	max_addr = __find_max_addr(limit);
+	memblock_mark_nomap(max_addr, (phys_addr_t)ULLONG_MAX);
+}
+
 static int __init_memblock memblock_search(struct memblock_type *type, phys_addr_t addr)
 {
 	unsigned int left = 0, right = type->cnt;
@@ -1677,13 +1709,15 @@ static int memblock_debug_show(struct seq_file *m, void *private)
 		reg = &type->regions[i];
 		seq_printf(m, "%4d: ", i);
 		if (sizeof(phys_addr_t) == 4)
-			seq_printf(m, "0x%08lx..0x%08lx\n",
+			seq_printf(m, "0x%08lx..0x%08lx  0x%08lx  0x%lx\n",
 				   (unsigned long)reg->base,
-				   (unsigned long)(reg->base + reg->size - 1));
+				   (unsigned long)(reg->base + reg->size - 1),
+				   (unsigned long)reg->size, reg->flags);
 		else
-			seq_printf(m, "0x%016llx..0x%016llx\n",
+			seq_printf(m, "0x%016llx..0x%016llx  0x%016llx  0x%lx\n",
 				   (unsigned long long)reg->base,
-				   (unsigned long long)(reg->base + reg->size - 1));
+				   (unsigned long long)(reg->base + reg->size - 1),
+				   (unsigned long long)reg->size, reg->flags);
 
 	}
 	return 0;
-- 
1.8.3.1
