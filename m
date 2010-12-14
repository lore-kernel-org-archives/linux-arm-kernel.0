From: tomi.valkeinen@nokia.com (Tomi Valkeinen)
Date: Tue, 14 Dec 2010 14:16:59 +0200
Subject: [PATCH] OMAP: DSS: VRAM: Align start & size of vram to 2M
Message-ID: <mailman.60.1292329460.1530.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Align the start address and size of VRAM area to 2M as per comments from
Russell King:

> > So, why SZ_2M?
>
> Firstly, that's the granularity which we allocate page tables - one
> Linux page table covers 2MB of memory.  We want to avoid creating page
> tables for the main memory mapping as that increases TLB pressure through
> the use of additional TLB entries, and more page table walks.
>
> Plus, we never used to allow the kernel's direct memory mapping to be
> mapped at anything less than section size - this restriction has since
> been lifted due to OMAP SRAM problems, but I'd rather we stuck with it
> to ensure that we have proper behaviour from all parts of the system.
>
> Secondly, we don't want to end up with lots of fragmentation at the end
> of the memory mapping as that'll reduce performance, not only by making
> the pfn_valid() search more expensive.
>
> Emsuring a minimum allocation size and alignment makes sure that the
> regions can be coalesced together into one block, and minimises run-time
> expenses.
>
> So please, 2MB, or if you object, at the _very_ _least_ 1MB.  But
> definitely not PAGE_SIZE.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
---
 drivers/video/omap2/vram.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap2/vram.c b/drivers/video/omap2/vram.c
index 2fd7e52..9441e2e 100644
--- a/drivers/video/omap2/vram.c
+++ b/drivers/video/omap2/vram.c
@@ -551,7 +551,7 @@ void __init omap_vram_reserve_sdram_memblock(void)
 	if (!size)
 		return;
 
-	size = PAGE_ALIGN(size);
+	size = ALIGN(size, SZ_2M);
 
 	if (paddr) {
 		if (paddr & ~PAGE_MASK) {
@@ -576,7 +576,7 @@ void __init omap_vram_reserve_sdram_memblock(void)
 			return;
 		}
 	} else {
-		paddr = memblock_alloc(size, PAGE_SIZE);
+		paddr = memblock_alloc(size, SZ_2M);
 	}
 
 	memblock_free(paddr, size);
-- 
1.7.1
