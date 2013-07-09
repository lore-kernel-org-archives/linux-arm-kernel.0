From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 9 Jul 2013 20:13:51 +0100
Subject: [PATCH V2] ARM: mm: restrict early_alloc_aligned to legal area
In-Reply-To: <1373387888-4137-1-git-send-email-swarren@wwwdotorg.org>
References: <1373387888-4137-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20130709191350.GV24642@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 09, 2013 at 10:38:08AM -0600, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> When early_alloc_aligned() is called, it appears that only memory in the
> first memory bank is mapped for CPU access. However, memblock_alloc() is
> called to allocate the RAM, and that can return RAM that is part of any
> valid memory bank, which hence could be inaccessible to the CPU. If this
> happens, the subsequent memset() will hang or crash.

Let me also be clear that historically, we never permitted non-section
mappings of normal memory; however OMAP needed to be able to map SRAM
using normal memory with executable attributes, but prevent speculative
prefetches to the secure region of SRAM, which thus had to remain unmapped.
Therefore, page mappings of normal memory were added only to allow OMAP
to make those mappings: it was *never* intended to permit standard
system memory to be mapped using page mappings, nor to permit non-
section sized mappings of system memory.

Moreover, I can assume from your patch that you haven't read the memblock
code, otherwise you'll known that memblock_alloc() has a built-in limit
which it allocates from in a top-down manner, and that limit can be
set by the architecture code (and we do already set it to the top of
lowmem.)

Lastly, the reason this happens is because at the point we encounter the
need for a page-based mapping of normal memory, the area which we allocate
from has not been made accessible.

Let me give you a variation of your problem:

- Your first chunk of memory starts a few pages in to a section
  boundary (anything within the first 16K).

The issue here is that map_lowmem() will start off by wanting to allocate
a L2 page table, but we haven't even mapped the first chunk of memory
yet (we only have a partial mapping which is sufficiently large in terms
of sections for the kernel only.)

The problem here is that if you bring the memblock limit down to that,
you will probably run out of memory you can allocate from, especially
if the end of the kernel is near to the section boundary.

Realistically, I don't think that is solvable.

Second problem:

- Your first chunk of memory doesn't finish on a section boundary.

The issue here is that even with your patch, you start allocating from
the top of the first chunk of memory, which in this case itself won't
be mapped at the time that you need to gain access to that page.
This can be worked around by rounding the limit down to a section
boundary.

However, should we be penalising other systems for this behaviour by
placing the memblock allocation at the end of the first chunk of memory,
which might be (a) in precious DMA memory on platforms with limited
DMA capabilities and (b) might be rather small because it also houses
the kernel image, especially where memory is broken up across several
sparsemem sections.

What I would like to see is a patch which modifies sanity_check_meminfo()
to deal with this and set the memblock limit appropriately.  Note that
paging_init() also calls memblock_set_current_limit(), but I think
that call can be removed now as memblock_init() has been removed (used
to be called from arm_memblock_init() - see fe091c208a) which used to
reset the limit.

So something like this (untested):

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 08b37c4..ce74fa2 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -988,6 +988,7 @@ phys_addr_t arm_lowmem_limit __initdata = 0;
 
 void __init sanity_check_meminfo(void)
 {
+	phys_addr_t memblock_limit = 0;
 	int i, j, highmem = 0;
 
 	for (i = 0, j = 0; i < meminfo.nr_banks; i++) {
@@ -1067,9 +1068,20 @@ void __init sanity_check_meminfo(void)
 			bank->size = newsize;
 		}
 #endif
-		if (!bank->highmem && bank->start + bank->size > arm_lowmem_limit)
-			arm_lowmem_limit = bank->start + bank->size;
+		if (!bank->highmem) {
+			if (bank->start + bank->size > arm_lowmem_limit)
+				arm_lowmem_limit = bank->start + bank->size;
 
+			/*
+			 * Find the first bank of memory which starts
+			 * on a section boundary, but doesn't finish
+			 * on a section boundary.
+			 */
+			if (memblock_limit == 0 &&
+			    IS_ALIGNED(bank->start, SECTION_SIZE) &&
+			    !IS_ALIGNED(bank->start + size, SECTION_SIZE))
+				memblock_limit = bank->start + bank->size;
+		}
 		j++;
 	}
 #ifdef CONFIG_HIGHMEM
@@ -1094,7 +1106,18 @@ void __init sanity_check_meminfo(void)
 #endif
 	meminfo.nr_banks = j;
 	high_memory = __va(arm_lowmem_limit - 1) + 1;
-	memblock_set_current_limit(arm_lowmem_limit);
+
+	/*
+	 * Round the memblock limit down to a section size.  This
+	 * helps to ensure that we will allocate memory from the
+	 * last full section, which should be mapped.
+	 */
+	if (memblock_limit)
+		memblock_limit = round_down(memblock_limit, SECTION_SIZE);
+	if (memblock_limit == 0)
+		memblock_limit = arm_lowmem_limit;
+
+	memblock_set_current_limit(memblock_limit);
 }
 
 static inline void prepare_page_table(void)
@@ -1297,8 +1320,6 @@ void __init paging_init(struct machine_desc *mdesc)
 {
 	void *zero_page;
 
-	memblock_set_current_limit(arm_lowmem_limit);
-
 	build_mem_type_table();
 	prepare_page_table();
 	map_lowmem();
