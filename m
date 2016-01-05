From: js07.lee@samsung.com (Jungseung Lee)
Date: Tue, 05 Jan 2016 18:56:03 +0900
Subject: [PATCH] ARM: mm: Speed up page list initialization during boot
In-Reply-To: <20160102103722.GQ8644@n2100.arm.linux.org.uk>
References: <004001d14158$114be8d0$33e3ba70$@samsung.com>
 <005101d14158$b50842c0$1f18c840$@samsung.com>
 <CAJFHJrpgHmcXBwuV5i4nH4SOL-OwrY2-+Fe7x9W2c6GWW=F7bg@mail.gmail.com>
 <20160102103722.GQ8644@n2100.arm.linux.org.uk>
Message-ID: <002c01d1479f$49ea2970$ddbe7c50$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Thu, Dec 31, 2015 at 05:05:54AM -0800, Chirantan Ekbote wrote:
> > On Mon, Dec 28, 2015 at 2:15 AM, Jungseung Lee <js07.lee@samsung.com>
> wrote:
> > > Hi,
> > >
> > >>During boot, we populate the page lists by using the page freeing
> > >>mechanism on every individual page.  Unfortunately, this is very
> > >>inefficient because the memory manager spends a lot of time
> > >>coalescing pairs of adjacent free pages into bigger blocks.
> > >>
> > >>Rather than adding a single order 0 page at a time, we can take
> > >>advantage of the fact that we know that all the pages are available
> > >>and free up big blocks of pages at a time instead.
> > >>
> > >>Signed-off-by: Chirantan Ekbote <chirantan@chromium.org>
> > >>---
> > >> arch/arm/mm/init.c  | 19 +++++++++++++++++--  include/linux/gfp.h |
> > >>1
> > >>+
> > >> mm/internal.h       |  1 -
> > >> 3 files changed, 18 insertions(+), 3 deletions(-)
> > >>
> > >>diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c index
> > >>97c293e..c7fc2d8 100644
> > >>--- a/arch/arm/mm/init.c
> > >>+++ b/arch/arm/mm/init.c
> > >>@@ -22,6 +22,7 @@
> > >> #include <linux/memblock.h>
> > >> #include <linux/dma-contiguous.h>
> > >> #include <linux/sizes.h>
> > >>+#include <linux/bitops.h>
> > >>
> > >> #include <asm/mach-types.h>
> > >> #include <asm/memblock.h>
> > >>@@ -469,8 +470,22 @@ static void __init free_unused_memmap(struct
> > >>meminfo
> > > *mi)
> > >> #ifdef CONFIG_HIGHMEM
> > >> static inline void free_area_high(unsigned long pfn, unsigned long
> > >>end)  {
> > >>-      for (; pfn < end; pfn++)
> > >>-              free_highmem_page(pfn_to_page(pfn));
> > >>+      while (pfn < end) {
> > >>+              struct page *page = pfn_to_page(pfn);
> > >>+              unsigned long order = min(__ffs(pfn), MAX_ORDER - 1);
> > >>+              unsigned long nr_pages = 1 << order;
> > >>+              unsigned long rem = end - pfn;
> > >>+
> > >>+              if (nr_pages > rem) {
> > >>+                      order = __fls(rem);
> > >>+                      nr_pages = 1 << order;
> > >>+              }
> > >>+
> > >>+              __free_pages_bootmem(page, order);
> > >>+              totalram_pages += nr_pages;
> > >>+              totalhigh_pages += nr_pages;
> > >>+              pfn += nr_pages;
> > >>+      }
> > >> }
> > >> #endif
> > >>
> > >>diff --git a/include/linux/gfp.h b/include/linux/gfp.h index
> > >>39b81dc..a63d666 100644
> > >>--- a/include/linux/gfp.h
> > >>+++ b/include/linux/gfp.h
> > >>@@ -367,6 +367,7 @@ void *alloc_pages_exact_nid(int nid, size_t
> > >>size, gfp_t
> > > gfp_mask);
> > >> #define __get_dma_pages(gfp_mask, order) \
> > >>               __get_free_pages((gfp_mask) | GFP_DMA, (order))
> > >>
> > >>+extern void __free_pages_bootmem(struct page *page, unsigned int
> > >>+order);
> > >> extern void __free_pages(struct page *page, unsigned int order);
> > >>extern void free_pages(unsigned long addr, unsigned int order);
> > >>extern void free_hot_cold_page(struct page *page, int cold); diff
> > >>--git a/mm/internal.h b/mm/internal.h index 29e1e76..d2b8738 100644
> > >>--- a/mm/internal.h
> > >>+++ b/mm/internal.h
> > >>@@ -93,7 +93,6 @@ extern pmd_t *mm_find_pmd(struct mm_struct *mm,
> > >>unsigned
> > > long address);
> > >> /*
> > >>  * in mm/page_alloc.c
> > >>  */
> > >>-extern void __free_pages_bootmem(struct page *page, unsigned int
> > >>order);  extern void prep_compound_page(struct page *page, unsigned
> > >>long order);  #ifdef CONFIG_MEMORY_FAILURE  extern bool
> > >>is_free_buddy_page(struct page *page);
> > >>--
> > >>1.9.1.423.g4596e3a
> > >
> > > This patch really could save boot time.
> > > Is there any reason this patch is not merged to mainline kernel?
> > >
> >
> > Well it was ignored when I originally posted it so I assumed mainline
> > developers weren't really interested.  I can re-spin and send a new
> > version if there's interest in getting it merged now.

Chirantan, please send a new version. It really has benefit.

> 
> Not getting a reply can be for many reasons: people may be too busy and
> there may be too much other mail.  I generally have a major problem with
> email in that it's all too easy for stuff to get buried and forgotten.
> Remember, some of us get a lot of emails a day, and mails which should get
> a reply do get dropped simply because there isn't enough time to read them
> and properly write replies to every message that needs a response.
> 
> So, it's good practice to resend after a week or so if you think your
> message has been missed; it may well have been missed and buried under a
> thousand or more other messages by that time.
> 
> In any case, it would be nice for such "speed up" changes to be quantified
> with some kind of measurement.  How much does it speed the boot process
up,
> and in what circumstances?

In my circumstance CA15 with huge memory, 400ms is reduced.
I can find below sentence from chromium review.
https://chromium-review.googlesource.com/#/c/188971/
This reduces boot time by 260ms on pit and 560ms on pi.
> 
> Thanks.
> 
> --
> RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
> according to speedtest.net.
