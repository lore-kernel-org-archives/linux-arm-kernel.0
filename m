From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 26 Mar 2015 11:46:12 +0000
Subject: [PATCH] ARM: print cma-reserved pages from show_mem
In-Reply-To: <CADtm3G64rPf7O76xUbLwqsqTkJxdGJMT9sHj810xPuThDA0ddg@mail.gmail.com>
References: <1423092164-9145-1-git-send-email-gregory.0xf0@gmail.com>
 <54D40DAF.4080609@codeaurora.org>
 <CADtm3G7ROX4CrxSKRvTKcjqCiX=uJQZ=Q5izH8pS61z4jfumLg@mail.gmail.com>
 <54D534FB.1090101@codeaurora.org>
 <CADtm3G7CUYUUbmTrWiudQ5j-wX9hu86Ox8TkB+FnXwEvjb=xeg@mail.gmail.com>
 <20150210113230.GJ8656@n2100.arm.linux.org.uk>
 <CADtm3G64rPf7O76xUbLwqsqTkJxdGJMT9sHj810xPuThDA0ddg@mail.gmail.com>
Message-ID: <20150326114612.GD8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 23, 2015 at 02:08:12AM -0700, Gregory Fong wrote:
> Hello,
> 
> On Tue, Feb 10, 2015 at 3:32 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Mon, Feb 09, 2015 at 11:55:54AM -0800, Gregory Fong wrote:
> >> On Fri, Feb 6, 2015 at 1:41 PM, Laura Abbott <lauraa@codeaurora.org> wrote:
> >> > So it looks like the lib/show_mem.c does something different
> >> > #ifdef CONFIG_CMA
> >> >         printk("%lu pages reserved\n", (reserved - totalcma_pages));
> >> >         printk("%lu pages cma reserved\n", totalcma_pages);
> >> > #else
> >> >         printk("%lu pages reserved\n", reserved);
> >> > #endif
> >> >
> >> >
> >> > No need to change the name, instead I'd say fix up arm to match what
> >> > the generic showmem is doing.
> >>
> >> The trouble is that lib/show_mem.c and ARM's show_mem use the
> >> 'reserved' variable to hold different info, which was not a problem I
> >> was aiming to tackle here, and am not sure I understand what's going
> >> on well enough to do so.  But let's give it a shot:
> >>
> >> In lib/show_mem.c, reserved is calculated by iterating over all online
> >> nodes, then increasing reserved by (zone->present_pages -
> >> zone->managed_pages).  This count includes CMA pages and so when
> >> reserved pages is printed it should be 'reserved' - totalcma_pages, as
> >> it currently is.
> >
> > So, some digging is needed into why the generic version is different.
> > You have to remember that many of the algorithms for this kind of thing
> > were based on the x86 implementation, so differences like this are
> > probably down to ARM being annoyingly overlooked or ignored when generic
> > changes happen.
> >
> 
> Revisiting this finally, it looks like this was changed by Mel about a
> year and a half ago in commit c78e93630d15b5f5774213aad9bdc9f52473a89b
> "mm: do not walk all of system memory during show_mem"[1], which
> removes the pfn walk and gets this info from struct zone instead,
> saving a lot of time.  Is there any reason to not to change the ARM
> show_mem to do this as well?  With that, I'm not sure I understand why
> there would need to be an ARM-specific implementation at all anymore,
> but maybe I'm missing something.

Looking at Mel's commit, I don't see a reason why we couldn't use that
solution - it gets rid of walking the page array, which has been fraught
in the past due to ARM having platforms which have holes in their
physical memory.

We could try that solution - I don't see much downside to it.  Most of
that information is as debug information for MM stuff anyway, and IMHO
it doesn't make much sense for it to be different between architectures.

Maybe we should just switch to using the generic version?

8<===
From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH] ARM: switch to use the generic show_mem() implementation

Switch ARM to use the generic show_mem() implementation, which displays
the statistics from the mm zone rather than walking the page arrays.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/init.c | 49 -------------------------------------------------
 1 file changed, 49 deletions(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 1609b022a72f..ae369c1066e6 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -86,55 +86,6 @@ static int __init parse_tag_initrd2(const struct tag *tag)
 
 __tagtable(ATAG_INITRD2, parse_tag_initrd2);
 
-/*
- * This keeps memory configuration data used by a couple memory
- * initialization functions, as well as show_mem() for the skipping
- * of holes in the memory map.  It is populated by arm_add_memory().
- */
-void show_mem(unsigned int filter)
-{
-	int free = 0, total = 0, reserved = 0;
-	int shared = 0, cached = 0, slab = 0;
-	struct memblock_region *reg;
-
-	printk("Mem-info:\n");
-	show_free_areas(filter);
-
-	for_each_memblock (memory, reg) {
-		unsigned int pfn1, pfn2;
-		struct page *page, *end;
-
-		pfn1 = memblock_region_memory_base_pfn(reg);
-		pfn2 = memblock_region_memory_end_pfn(reg);
-
-		page = pfn_to_page(pfn1);
-		end  = pfn_to_page(pfn2 - 1) + 1;
-
-		do {
-			total++;
-			if (PageReserved(page))
-				reserved++;
-			else if (PageSwapCache(page))
-				cached++;
-			else if (PageSlab(page))
-				slab++;
-			else if (!page_count(page))
-				free++;
-			else
-				shared += page_count(page) - 1;
-			pfn1++;
-			page = pfn_to_page(pfn1);
-		} while (pfn1 < pfn2);
-	}
-
-	printk("%d pages of RAM\n", total);
-	printk("%d free pages\n", free);
-	printk("%d reserved pages\n", reserved);
-	printk("%d slab pages\n", slab);
-	printk("%d pages shared\n", shared);
-	printk("%d pages swap cached\n", cached);
-}
-
 static void __init find_limits(unsigned long *min, unsigned long *max_low,
 			       unsigned long *max_high)
 {
-- 
1.8.3.1



-- 
FTTC broadband for 0.8mile line: currently@10.5Mbps down 400kbps up
according to speedtest.net.
