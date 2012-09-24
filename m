From: cyril@ti.com (Cyril Chemparathy)
Date: Mon, 24 Sep 2012 12:41:33 -0400
Subject: [PATCH v3 RESEND 08/17] ARM: LPAE: use phys_addr_t in
 free_memmap()
In-Reply-To: <20120924152220.GE26454@n2100.arm.linux.org.uk>
References: <1348242975-19184-1-git-send-email-cyril@ti.com>
 <1348242975-19184-9-git-send-email-cyril@ti.com>
 <20120924132942.GD23298@arm.com>
 <20120924134145.GB26454@n2100.arm.linux.org.uk> <506077BE.6000600@ti.com>
 <20120924152220.GE26454@n2100.arm.linux.org.uk>
Message-ID: <50608D3D.2010106@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/24/2012 11:22 AM, Russell King - ARM Linux wrote:
> On Mon, Sep 24, 2012 at 11:09:50AM -0400, Cyril Chemparathy wrote:
>> On 9/24/2012 9:41 AM, Russell King - ARM Linux wrote:
>>> On Mon, Sep 24, 2012 at 02:29:42PM +0100, Catalin Marinas wrote:
>>>> This function also calls free_bootmem() which takes unsigned long. Are
>>>> patches sent separately for this or we just ignore holes in memmap?
>>>> There are other calls to free_bootmem() or reserve_bootmem(), do they
>>>> just work with the high phys addresses?
>>>
>>> Bootmem only deals with physical addresses which fit within the size
>>> of an 'unsigned long'.  Unfortunately, the bootmem API is a mess of
>>> 'unsigned long' physical addresses and PFNs.
>>>
>>> Years ago there was a patch to make it use only PFNs but other changes
>>> resulted in that patch being thrown away.
>>>
>>
>> A separate patch has been posted for bootmem (see [1]).
>>
>> Tejun suggested that we'd be better off moving entirely to memblock
>> instead (see [2]).
>
> Yes we should, but that's not as easy as typing a few words in an email.
> When I tried it when I integrated memblock into our boot sequence, I
> found that sparsemem wouldn't work without bootmem being in place.
>
> It may be that things have now moved on, and we can just eliminate
> bootmem once and for all, but that's something I've not looked at for
> quite some time.
>

It appears to be not that hard actually... Or maybe I'm totally missing 
your point.  Could it be that you last looked at this prior to the 
nobootmem compatibility stuff being added in?

The following patch appears to work just fine on a faked sparsemem system:


diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 92f598a..e94fa4c 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -49,6 +49,7 @@ config ARM
  	select GENERIC_STRNCPY_FROM_USER
  	select GENERIC_STRNLEN_USER
  	select DCACHE_WORD_ACCESS if (CPU_V6 || CPU_V6K || CPU_V7) && 
!CPU_BIG_ENDIAN
+	select NO_BOOTMEM
  	help
  	  The ARM series is a line of low-power-consumption RISC chip designs
  	  licensed by ARM Ltd and targeted at embedded applications and
diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 29560d8..0ca6c00 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -150,58 +150,6 @@ static void __init find_limits(unsigned long *min, 
unsigned long *max_low,
  	*max_high = bank_pfn_end(&mi->bank[mi->nr_banks - 1]);
  }

-static void __init arm_bootmem_init(unsigned long start_pfn,
-	unsigned long end_pfn)
-{
-	struct memblock_region *reg;
-	unsigned int boot_pages;
-	phys_addr_t bitmap;
-	pg_data_t *pgdat;
-
-	/*
-	 * Allocate the bootmem bitmap page.  This must be in a region
-	 * of memory which has already been mapped.
-	 */
-	boot_pages = bootmem_bootmap_pages(end_pfn - start_pfn);
-	bitmap = memblock_alloc_base(boot_pages << PAGE_SHIFT, L1_CACHE_BYTES,
-				__pfn_to_phys(end_pfn));
-
-	/*
-	 * Initialise the bootmem allocator, handing the
-	 * memory banks over to bootmem.
-	 */
-	node_set_online(0);
-	pgdat = NODE_DATA(0);
-	init_bootmem_node(pgdat, __phys_to_pfn(bitmap), start_pfn, end_pfn);
-
-	/* Free the lowmem regions from memblock into bootmem. */
-	for_each_memblock(memory, reg) {
-		unsigned long start = memblock_region_memory_base_pfn(reg);
-		unsigned long end = memblock_region_memory_end_pfn(reg);
-
-		if (end >= end_pfn)
-			end = end_pfn;
-		if (start >= end)
-			break;
-
-		free_bootmem(__pfn_to_phys(start), (end - start) << PAGE_SHIFT);
-	}
-
-	/* Reserve the lowmem memblock reserved regions in bootmem. */
-	for_each_memblock(reserved, reg) {
-		unsigned long start = memblock_region_reserved_base_pfn(reg);
-		unsigned long end = memblock_region_reserved_end_pfn(reg);
-
-		if (end >= end_pfn)
-			end = end_pfn;
-		if (start >= end)
-			break;
-
-		reserve_bootmem(__pfn_to_phys(start),
-			        (end - start) << PAGE_SHIFT, BOOTMEM_DEFAULT);
-	}
-}
-
  #ifdef CONFIG_ZONE_DMA

  unsigned long arm_dma_zone_size __read_mostly;
@@ -393,8 +341,6 @@ void __init bootmem_init(void)

  	find_limits(&min, &max_low, &max_high);

-	arm_bootmem_init(min, max_low);
-
  	/*
  	 * Sparsemem tries to allocate bootmem in memory_present(),
  	 * so must be done after the fixed reservations
@@ -443,6 +389,54 @@ static inline int free_area(unsigned long pfn, 
unsigned long end, char *s)
  	return pages;
  }

+static unsigned long free_all_lowmem(void)
+{
+	unsigned long max_low = max_low_pfn + PHYS_PFN_OFFSET;
+	struct memblock_region *mem, *res;
+	unsigned long total_pages = 0;
+
+	/* set highmem page free */
+	for_each_memblock(memory, mem) {
+		unsigned long start = memblock_region_memory_base_pfn(mem);
+		unsigned long end = memblock_region_memory_end_pfn(mem);
+
+		/* Ignore complete lowmem entries */
+		if (start > max_low)
+			continue;
+
+		/* Truncate partial highmem entries */
+		if (end > max_low)
+			end = max_low;
+
+		/* Find and exclude any reserved regions */
+		for_each_memblock(reserved, res) {
+			unsigned long res_start, res_end;
+
+			res_start = memblock_region_reserved_base_pfn(res);
+			res_end = memblock_region_reserved_end_pfn(res);
+
+			if (res_end < start)
+				continue;
+			if (res_start < start)
+				res_start = start;
+			if (res_start > end)
+				res_start = end;
+			if (res_end > end)
+				res_end = end;
+			if (res_start != start)
+				total_pages += free_area(start, res_start, NULL);
+			start = res_end;
+			if (start == end)
+				break;
+		}
+
+		/* And now free anything which remains */
+		if (start < end)
+			total_pages += free_area(start, end, NULL);
+	}
+	return total_pages;
+}
+
  /*
   * Poison init memory with an undefined instruction (ARM) or a branch 
to an
   * undefined instruction (Thumb).
@@ -606,7 +600,7 @@ void __init mem_init(void)
  	/* this will put all unused low memory onto the freelists */
  	free_unused_memmap(&meminfo);

-	totalram_pages += free_all_bootmem();
+	totalram_pages += free_all_lowmem();

  #ifdef CONFIG_SA1111
  	/* now that our DMA memory is actually so designated, we can free it */

-- 
Thanks
- Cyril
