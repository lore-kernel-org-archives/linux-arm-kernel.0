From: james.morse@arm.com (James Morse)
Date: Wed, 25 Apr 2018 14:22:50 +0100
Subject: [PATCH] arm64: export memblock_reserve()d regions via /proc/iomem
Message-ID: <20180425132250.9397-1-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There has been some confusion around what is necessary to prevent kexec
overwriting important memory regions. memblock: reserve, or nomap?
Only memblock nomap regions are reported via /proc/iomem, kexec's
user-space doesn't know about memblock_reserve()d regions.

Until commit f56ab9a5b73ca ("efi/arm: Don't mark ACPI reclaim memory
as MEMBLOCK_NOMAP") the ACPI tables were nomap, now they are reserved
and thus possible for kexec to overwrite with the new kernel or initrd.
But this was always broken, as the UEFI memory map is also reserved
and not marked as nomap.

It turns out that while kexec-tools will pick up reserved sections in
iomem that look like:
| 80000000-dfffffff : System RAM
|   81000000-8158ffff : reserved

The reserved section is ignored by its 'locate_hole()' code. To fix
this, we need to describe memblock_reserved() and nomap regions as
'reserved' at the top level:
| 80000000-80ffffff : System RAM
| 81000000-8158ffff : reserved
| 81590000-dfffffff : System RAM

To complicate matters, our existing named sections are described as
being part of 'System RAM', but they are also memblock_reserve()d.
We need to keep this in-case something is depending on it. To do this
involves walking memblock multiple times:

First add the 'System RAM' sections that are memory and not-reserved.
These may be smaller than a page if part of the page is reserved. In
this case we want to describe the page as reserved, so we round these
regions down to the smallest page-size region, which may be empty.
(We round-up the memblock_reserved() regions to fill in the gaps).

The boundaries for kernel_data are changed because paging_init() punches
holes in the _sdata -> _edata region, and this code can't add a named
region that crosses memblock_reserve()d<->normal-memory regions. The
new helpers will catch any more overlapping regions that occur.

Lastly, we add the memblock_reserved() regions using
reserve_region_with_split(), which will fill in the gaps between the
existing named regions. (e.g. the regions occupied by the __init code).
This call uses the slab allocator, so has to run from an initcall.

Reported-by: Bhupesh Sharma <bhupesh.linux@gmail.com>
Reported-by: Tyler Baicar <tbaicar@codeaurora.org>
Suggested-by: Akashi Takahiro <takahiro.akashi@linaro.org>
Signed-off-by: James Morse <james.morse@arm.com>
CC: Ard Biesheuvel <ard.biesheuvel@linaro.org>
CC: Mark Rutland <mark.rutland@arm.com>

---
If we do send this to stable:
Fixes: d28f6df1305a ("arm64/kexec: Add core kexec support")

If we're happy to modify user-sapce, we can do much neater things.

It looks like UEFI's careful 'memory map not mapped' code had me convinced
it was nomap.

 arch/arm64/kernel/setup.c | 136 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 113 insertions(+), 23 deletions(-)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 30ad2f085d1f..e82c0d5c70f8 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -202,45 +202,135 @@ static void __init setup_machine_fdt(phys_addr_t dt_phys)
 	dump_stack_set_arch_desc("%s (DT)", name);
 }
 
+static struct resource * __init add_standard_resources(phys_addr_t start,
+						       phys_addr_t end,
+						       bool reserved)
+{
+	struct resource *res;
+
+	res = alloc_bootmem_low(sizeof(*res));
+
+	if (reserved) {
+		res->name  = "reserved";
+		res->flags = IORESOURCE_MEM;
+	} else {
+		res->name  = "System RAM";
+		res->flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
+	}
+	res->start = start;
+	res->end = end;
+
+	if (request_resource_conflict(&iomem_resource, res)) {
+		pr_warn_once("Attempted to add overlapping resources\n");
+		return NULL;
+	}
+
+	return res;
+}
+
+static void __init add_named_resources(struct resource *named_resource)
+{
+	phys_addr_t start, end;
+	struct resource *res;
+
+	start = __pfn_to_phys(PFN_DOWN(named_resource->start));
+	end = __pfn_to_phys(PFN_UP(named_resource->end)) - 1;
+	res = add_standard_resources(start, end, false);
+	if (res)
+		request_resource(res, named_resource);
+}
+
 static void __init request_standard_resources(void)
 {
+	phys_addr_t start, end;
 	struct memblock_region *region;
 	struct resource *res;
+	u64 i;
+	int num_res = 0;
 
 	kernel_code.start   = __pa_symbol(_text);
 	kernel_code.end     = __pa_symbol(__init_begin - 1);
 	kernel_data.start   = __pa_symbol(_sdata);
-	kernel_data.end     = __pa_symbol(_end - 1);
+	kernel_data.end     = __pa_symbol(_edata - 1);
 
-	for_each_memblock(memory, region) {
-		res = alloc_bootmem_low(sizeof(*res));
-		if (memblock_is_nomap(region)) {
-			res->name  = "reserved";
-			res->flags = IORESOURCE_MEM;
-		} else {
-			res->name  = "System RAM";
-			res->flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
-		}
-		res->start = __pfn_to_phys(memblock_region_memory_base_pfn(region));
-		res->end = __pfn_to_phys(memblock_region_memory_end_pfn(region)) - 1;
+	/*
+	 * We can't allocate memory while walking free memory, count the number
+	 * of struct resource's we will need. Round start/end to the smallest
+	 * page-size region as we round the reserved regions up.
+	 */
+	for_each_free_mem_range(i, NUMA_NO_NODE, 0, &start, &end, NULL) {
+		start = ALIGN(start, PAGE_SIZE);
+		end = ALIGN_DOWN(end, PAGE_SIZE) - 1;
+		if (end > start)
+			num_res++;
+	}
+
+	/* our allocation may split a free memblock */
+	num_res++;
+	res = alloc_bootmem_low(num_res * sizeof(*res));
 
-		request_resource(&iomem_resource, res);
+	/*
+	 * Add the non-reserved memory regions. flag=0 means we skip nomap
+	 * regions too.
+	 */
+	for_each_free_mem_range(i, NUMA_NO_NODE, 0, &start, &end, NULL) {
+		if (WARN_ON(!num_res))
+			return;
+
+		res->name  = "System RAM";
+		res->flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
+
+		res->start = ALIGN(start, PAGE_SIZE);
+		res->end = ALIGN_DOWN(end, PAGE_SIZE) - 1;
+		if (res->end > res->start) {
+			request_resource(&iomem_resource, res);
+			res++;
+			num_res--;
+		}
+	}
 
-		if (kernel_code.start >= res->start &&
-		    kernel_code.end <= res->end)
-			request_resource(res, &kernel_code);
-		if (kernel_data.start >= res->start &&
-		    kernel_data.end <= res->end)
-			request_resource(res, &kernel_data);
+	/* Add the named reserved regions and their system-ram parents */
+	add_named_resources(&kernel_code);
+	add_named_resources(&kernel_data);
 #ifdef CONFIG_KEXEC_CORE
-		/* Userspace will find "Crash kernel" region in /proc/iomem. */
-		if (crashk_res.end && crashk_res.start >= res->start &&
-		    crashk_res.end <= res->end)
-			request_resource(res, &crashk_res);
+	if (crashk_res.end)
+		add_named_resources(&crashk_res);
 #endif
+
+	/* Add the nomap regions */
+	for_each_memblock(memory, region) {
+		if (!memblock_is_nomap(region))
+			continue;
+
+		start = __pfn_to_phys(memblock_region_memory_base_pfn(region));
+		end = __pfn_to_phys(memblock_region_memory_end_pfn(region)) - 1;
+		add_standard_resources(start, end, true);
 	}
 }
 
+static int __init reserve_memblock_reserved_regions(void)
+{
+	phys_addr_t start, end, roundup_end = 0;
+	u64 i;
+
+	for_each_reserved_mem_region(i, &start, &end) {
+		if (end <= roundup_end)
+			continue; /* done already */
+
+		start = __pfn_to_phys(PFN_DOWN(start));
+		end = __pfn_to_phys(PFN_UP(end)) - 1;
+		roundup_end = end;
+
+		reserve_region_with_split(&iomem_resource, start, end,
+					  "reserved");
+	}
+
+	return 0;
+}
+/* reserve_region_with_split() requires the slab allocator: */
+arch_initcall(reserve_memblock_reserved_regions);
+
+
 u64 __cpu_logical_map[NR_CPUS] = { [0 ... NR_CPUS-1] = INVALID_HWID };
 
 void __init setup_arch(char **cmdline_p)
-- 
2.16.2
