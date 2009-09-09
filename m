From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 09 Sep 2009 11:57:35 +0100
Subject: free_memmap() and sparsemem
Message-ID: <1252493855.24414.30.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

I haven't followed the full thread on omap and memory holes but I got an
issue on RealView PBX with sparsemem enabled (patches not pushed yet for
mainline). Basically I'm using this configuration:

256MB @ 0x00000000 -> PAGE_OFFSET
512MB @ 0x20000000 -> PAGE_OFFSET + 0x10000000
256MB @ 0x80000000 -> PAGE_OFFSET + 0x20000000

I could only use two banks (the second at 0x70000000) but I need the
first 256MB for DMA (since Linux only accepts DMA zone to be at the
bottom). The phys_to_virt/virt_to_phys macros were modified to provide a
contiguous translation to virtual addresses.

Anyway, the free_memmap() called from free_unused_memmap_node()
shouldn't actually do much with sparsemem because the way the page
arrays are structured. In theory, start_pg and end_pg should be the same
but because the start_pfn passed to this function doesn't belong to any
node, it gets some random values for start_pg. The patch below solved
the problem for me:

Fix the start_pg value in free_memmap()

From: Catalin Marinas <catalin.marinas@arm.com>

If sparsemem is enabled, the start_pfn passed to the free_memmap()
function corresponds to an area of memory not known to the kernel and
pfn_to_page returns a wrong value. The (start_pfn - 1), however, is
known to the kernel.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/mm/init.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 82c4b42..b0423b7 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -419,7 +419,7 @@ free_memmap(int node, unsigned long start_pfn, unsigned long end_pfn)
 	/*
 	 * Convert start_pfn/end_pfn to a struct page pointer.
 	 */
-	start_pg = pfn_to_page(start_pfn);
+	start_pg = pfn_to_page(start_pfn - 1) + 1;
 	end_pg = pfn_to_page(end_pfn);
 
 	/*

-- 
Catalin
