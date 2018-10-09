From: james.morse@arm.com (James Morse)
Date: Tue,  9 Oct 2018 12:08:30 +0100
Subject: [PATCH] arm64: Fix /proc/iomem for reserved but not memory regions
Message-ID: <20181009110830.13331-1-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We describe ranges of 'reserved' memory to userspace via /proc/iomem.
commit 50d7ba36b916 ("arm64: export memblock_reserve()d regions via
/proc/iomem") updated the logic to export regions that were reserved
because their contents should be preserved. This allowed kexec-tools
to tell the difference between 'reserved' memory that must be
preserved and not overwritten, (e.g. the ACPI tables), and 'nomap'
memory that must not be touched without knowing the memory-attributes
(e.g. RAS CPER regions).

Because kexec-tools generates the kdump /proc/vmcore elf headers
from this file, the difference matters for 'reserved' memory, which
should be included in the /proc/vmcore, while 'nomap' should not.
(previously we only described 'nomap', which meant kexec could
overwrite 'reserved' memory by accident).

The above commit wrongly assumed that memblock_reserve() would not
be used to reserve regions that aren't memory. It turns out this is
exactly what early_init_dt_reserve_memory_arch() will do if it finds
a DT reserved-memory that was also carved out of the memory node.
The ramoops description on hikey and dragonboard-410c both do this.

This surprises reserve_memblock_reserved_regions() which finds a
reserved-memory range wasn't previously described as memory. It generates
a warning and describes the region as reserved. (adding this entry was
expected to fail and return the conflicting memory resource)

To work around this on systems with shipped DT files that do this,
reserve_memblock_reserved_regions() needs to cope with reserved
regions that aren't memory, which means we must walk two lists at once.

We can't use walk_system_ram_res() and reserve_region_with_split()
together, as the former hands its callback a copied resource on
the stack, where as the latter expects the in-tree resource to be
provided.

Allocate an array of struct resources during request_standard_resources()
so that we have all the 'System RAM' regions on hand.

We walk the reserved_mem_region, using mem_idx as a cursor in the
array of 'System RAM'. Adjacent memblock_reserved() regions will be merged,
so we consider multiple System RAM regions for one span of
memblock_reserved(). We don't always move the cursor as multiple
memblock_reserved() regions may exist in one System RAM region.

Fixes: 50d7ba36b916 ("arm64: export memblock_reserve()d regions via /proc/iomem")
Reported-by: John Stultz <john.stultz@linaro.org>
Reported-by: Paolo Pisati <p.pisati@gmail.com>
CC: Akashi Takahiro <takahiro.akashi@linaro.org>
CC: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: James Morse <james.morse@arm.com>
Tested-by: John Stultz <john.stultz@linaro.org>
---
Changes since RFC: vastly improved commit message.

 arch/arm64/kernel/setup.c | 50 ++++++++++++++++++++++++---------------
 1 file changed, 31 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 5b4fac434c84..952c2b126882 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -64,6 +64,9 @@
 #include <asm/xen/hypervisor.h>
 #include <asm/mmu_context.h>
 
+static int num_standard_resources;
+static struct resource *standard_resources;
+
 phys_addr_t __fdt_pointer __initdata;
 
 /*
@@ -206,14 +209,19 @@ static void __init request_standard_resources(void)
 {
 	struct memblock_region *region;
 	struct resource *res;
+	unsigned long i = 0;
 
 	kernel_code.start   = __pa_symbol(_text);
 	kernel_code.end     = __pa_symbol(__init_begin - 1);
 	kernel_data.start   = __pa_symbol(_sdata);
 	kernel_data.end     = __pa_symbol(_end - 1);
 
+	num_standard_resources = memblock.memory.cnt;
+	standard_resources = alloc_bootmem_low(num_standard_resources *
+					       sizeof(*standard_resources));
+
 	for_each_memblock(memory, region) {
-		res = alloc_bootmem_low(sizeof(*res));
+		res = &standard_resources[i++];
 		if (memblock_is_nomap(region)) {
 			res->name  = "reserved";
 			res->flags = IORESOURCE_MEM;
@@ -244,8 +252,11 @@ static void __init request_standard_resources(void)
 static int __init reserve_memblock_reserved_regions(void)
 {
 	phys_addr_t start, end, roundup_end = 0;
-	struct resource *mem, *res;
-	u64 i;
+	struct resource *mem;
+	u64 i, mem_idx = 0;
+
+	if (!standard_resources)
+		return 0;
 
 	for_each_reserved_mem_region(i, &start, &end) {
 		if (end <= roundup_end)
@@ -255,24 +266,25 @@ static int __init reserve_memblock_reserved_regions(void)
 		end = __pfn_to_phys(PFN_UP(end)) - 1;
 		roundup_end = end;
 
-		res = kzalloc(sizeof(*res), GFP_ATOMIC);
-		if (WARN_ON(!res))
-			return -ENOMEM;
-		res->start = start;
-		res->end = end;
-		res->name  = "reserved";
-		res->flags = IORESOURCE_MEM;
+		while (start > standard_resources[mem_idx].end) {
+			mem_idx++;
+			if (mem_idx >= num_standard_resources)
+				return 0; /* no more 'System RAM' */
+		}
+		do {
+			mem = &standard_resources[mem_idx];
 
-		mem = request_resource_conflict(&iomem_resource, res);
-		/*
-		 * We expected memblock_reserve() regions to conflict with
-		 * memory created by request_standard_resources().
-		 */
-		if (WARN_ON_ONCE(!mem))
-			continue;
-		kfree(res);
+			if (mem->start > end)
+				continue; /* doesn't overlap with memory */
+
+			start = max(start, mem->start);
+			reserve_region_with_split(mem, start,
+						  min(end, mem->end),
+						  "reserved");
 
-		reserve_region_with_split(mem, start, end, "reserved");
+			if (mem->end < end)
+				mem_idx++;
+		} while (mem->end < end && mem_idx < num_standard_resources);
 	}
 
 	return 0;
-- 
2.19.0
