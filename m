From: will.deacon@arm.com (Will Deacon)
Date: Tue, 9 Oct 2018 16:26:10 +0100
Subject: [PATCH] arm64: Fix /proc/iomem for reserved but not memory regions
In-Reply-To: <20181009110830.13331-1-james.morse@arm.com>
References: <20181009110830.13331-1-james.morse@arm.com>
Message-ID: <20181009152610.GA9259@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi James,

On Tue, Oct 09, 2018 at 12:08:30PM +0100, James Morse wrote:
> We describe ranges of 'reserved' memory to userspace via /proc/iomem.
> commit 50d7ba36b916 ("arm64: export memblock_reserve()d regions via
> /proc/iomem") updated the logic to export regions that were reserved
> because their contents should be preserved. This allowed kexec-tools
> to tell the difference between 'reserved' memory that must be
> preserved and not overwritten, (e.g. the ACPI tables), and 'nomap'
> memory that must not be touched without knowing the memory-attributes
> (e.g. RAS CPER regions).
> 
> Because kexec-tools generates the kdump /proc/vmcore elf headers
> from this file, the difference matters for 'reserved' memory, which
> should be included in the /proc/vmcore, while 'nomap' should not.
> (previously we only described 'nomap', which meant kexec could
> overwrite 'reserved' memory by accident).
> 
> The above commit wrongly assumed that memblock_reserve() would not
> be used to reserve regions that aren't memory. It turns out this is
> exactly what early_init_dt_reserve_memory_arch() will do if it finds
> a DT reserved-memory that was also carved out of the memory node.
> The ramoops description on hikey and dragonboard-410c both do this.
> 
> This surprises reserve_memblock_reserved_regions() which finds a
> reserved-memory range wasn't previously described as memory. It generates
> a warning and describes the region as reserved. (adding this entry was
> expected to fail and return the conflicting memory resource)
> 
> To work around this on systems with shipped DT files that do this,
> reserve_memblock_reserved_regions() needs to cope with reserved
> regions that aren't memory, which means we must walk two lists at once.
> 
> We can't use walk_system_ram_res() and reserve_region_with_split()
> together, as the former hands its callback a copied resource on
> the stack, where as the latter expects the in-tree resource to be
> provided.
> 
> Allocate an array of struct resources during request_standard_resources()
> so that we have all the 'System RAM' regions on hand.
> 
> We walk the reserved_mem_region, using mem_idx as a cursor in the
> array of 'System RAM'. Adjacent memblock_reserved() regions will be merged,
> so we consider multiple System RAM regions for one span of
> memblock_reserved(). We don't always move the cursor as multiple
> memblock_reserved() regions may exist in one System RAM region.

The last 3 paragraphs here are just describing the code, which I don't think
you need to bother with in the commit message. If you want to justify not
using walk_system_ram_res(), I'd do that in a comment.

> @@ -244,8 +252,11 @@ static void __init request_standard_resources(void)
>  static int __init reserve_memblock_reserved_regions(void)
>  {
>  	phys_addr_t start, end, roundup_end = 0;
> -	struct resource *mem, *res;
> -	u64 i;
> +	struct resource *mem;
> +	u64 i, mem_idx = 0;
> +
> +	if (!standard_resources)
> +		return 0;
>  
>  	for_each_reserved_mem_region(i, &start, &end) {
>  		if (end <= roundup_end)
> @@ -255,24 +266,25 @@ static int __init reserve_memblock_reserved_regions(void)
>  		end = __pfn_to_phys(PFN_UP(end)) - 1;
>  		roundup_end = end;
>  
> -		res = kzalloc(sizeof(*res), GFP_ATOMIC);
> -		if (WARN_ON(!res))
> -			return -ENOMEM;
> -		res->start = start;
> -		res->end = end;
> -		res->name  = "reserved";
> -		res->flags = IORESOURCE_MEM;
> +		while (start > standard_resources[mem_idx].end) {
> +			mem_idx++;
> +			if (mem_idx >= num_standard_resources)
> +				return 0; /* no more 'System RAM' */

It might just be me, but I find the control flow here pretty hard to reason
about. In fact, the way I managed to understand it was by writing my own
implementation and gradually figuring out why you need all of the checks
that you have here :)

The version I came up with is below, which I think I prefer, but I would
say that wouldn't I? What do you think? Is there something I've missed?

It's fairly "dumb" compared to your code (i.e. it always looks at all the
reserved regions) but this is __init code, so I don't think it matters.

Will

--->8

@@ -243,36 +251,26 @@ static void __init request_standard_resources(void)
 
 static int __init reserve_memblock_reserved_regions(void)
 {
-	phys_addr_t start, end, roundup_end = 0;
-	struct resource *mem, *res;
-	u64 i;
-
-	for_each_reserved_mem_region(i, &start, &end) {
-		if (end <= roundup_end)
-			continue; /* done already */
-
-		start = __pfn_to_phys(PFN_DOWN(start));
-		end = __pfn_to_phys(PFN_UP(end)) - 1;
-		roundup_end = end;
-
-		res = kzalloc(sizeof(*res), GFP_ATOMIC);
-		if (WARN_ON(!res))
-			return -ENOMEM;
-		res->start = start;
-		res->end = end;
-		res->name  = "reserved";
-		res->flags = IORESOURCE_MEM;
-
-		mem = request_resource_conflict(&iomem_resource, res);
-		/*
-		 * We expected memblock_reserve() regions to conflict with
-		 * memory created by request_standard_resources().
-		 */
-		if (WARN_ON_ONCE(!mem))
+	u64 i, j;
+
+	for (i = 0; i < num_standard_resources; ++i) {
+		struct resource *mem = &standard_resources[i];
+		phys_addr_t r_start, r_end, mem_size = mem->end - mem->start;
+
+		if (!memblock_is_region_reserved(mem->start, mem_size))
 			continue;
-		kfree(res);
 
-		reserve_region_with_split(mem, start, end, "reserved");
+		for_each_reserved_mem_region(j, &r_start, &r_end) {
+			resource_size_t start, end;
+
+			start = max(PFN_PHYS(PFN_DOWN(r_start)), mem->start);
+			end = min(PFN_PHYS(PFN_UP(r_end)), mem->end);
+
+			if (start > mem->end || end < mem->start)
+				continue;
+
+			reserve_region_with_split(mem, start, end, "reserved");
+		}
 	}
 
 	return 0;
