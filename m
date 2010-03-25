From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 25 Mar 2010 16:01:26 +0000
Subject: [PATCH] ARM: Fix virtual kernel memory printing for sparsemem
In-Reply-To: <20100325153043.GE6590@n2100.arm.linux.org.uk>
References: <20100325145324.12837.85927.stgit@e102109-lin.cambridge.arm.com>
	<20100325151030.GD6590@n2100.arm.linux.org.uk>
	<1269530669.10064.28.camel@e102109-lin.cambridge.arm.com>
	<20100325153043.GE6590@n2100.arm.linux.org.uk>
Message-ID: <1269532886.10064.31.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-03-25 at 15:30 +0000, Russell King - ARM Linux wrote:
> On Thu, Mar 25, 2010 at 03:24:29PM +0000, Catalin Marinas wrote:
> > On Thu, 2010-03-25 at 15:10 +0000, Russell King - ARM Linux wrote:
> > > While this looks fine, I'd like to see a lot of Tested-by's against
> > > this before it's merged - we've had similar code in show_mem()
> > > which has proven to be quite problematical to get right for all the
> > > various different combinations we have.
> > >
> > > However, we also have the same method in show_mem() which we know
> > > works fine, so I'd also like to see the problem with using it in
> > > mem_init() fully analysed - rather than a "possibly because".
> >
> > I can remove the "possibly" part :). The page_count() is given a page
> > with some random flags and it thinks it's a compound page. It than tries
> > to access page->first which isn't set, hence the error.
> >
> > The original code assumes that for a given node the map is contiguous
> > and it calculates the page as (map + pfn). This is only true for
> > flatmem. With sparsemem the page calculation is a bit more complicated
> > but handled by pfn_to_page().
> 
> And show_mem() ?  It seems to suffer from the same problem.

And that's a patch which fixes both (but as you said, it would be good
if more people test it on various platforms).


ARM: Fix kernel memory printing for sparsemem

From: Catalin Marinas <catalin.marinas@arm.com>

The show_mem() and mem_init() function are assuming that the page map is
contiguous and calculates the start and end page of a bank using (map +
pfn). This fails with SPARSEMEM where pfn_to_page() must be used.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <Will.Deacon@arm.com>
Cc: Andreas Fenkart <andreas.fenkart@streamunlimited.com>
---
 arch/arm/mm/init.c |   14 ++++----------
 1 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index b69ac3a..4ee740a 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -83,9 +83,6 @@ void show_mem(void)
 	printk("Mem-info:\n");
 	show_free_areas();
 	for_each_online_node(node) {
-		pg_data_t *n = NODE_DATA(node);
-		struct page *map = pgdat_page_nr(n, 0) - n->node_start_pfn;
-
 		for_each_nodebank (i,mi,node) {
 			struct membank *bank = &mi->bank[i];
 			unsigned int pfn1, pfn2;
@@ -94,8 +91,8 @@ void show_mem(void)
 			pfn1 = bank_pfn_start(bank);
 			pfn2 = bank_pfn_end(bank);
 
-			page = map + pfn1;
-			end  = map + pfn2;
+			page = pfn_to_page(pfn1);
+			end  = pfn_to_page(pfn2 - 1) + 1;
 
 			do {
 				total++;
@@ -600,9 +597,6 @@ void __init mem_init(void)
 	reserved_pages = free_pages = 0;
 
 	for_each_online_node(node) {
-		pg_data_t *n = NODE_DATA(node);
-		struct page *map = pgdat_page_nr(n, 0) - n->node_start_pfn;
-
 		for_each_nodebank(i, &meminfo, node) {
 			struct membank *bank = &meminfo.bank[i];
 			unsigned int pfn1, pfn2;
@@ -611,8 +605,8 @@ void __init mem_init(void)
 			pfn1 = bank_pfn_start(bank);
 			pfn2 = bank_pfn_end(bank);
 
-			page = map + pfn1;
-			end  = map + pfn2;
+			page = pfn_to_page(pfn1);
+			end  = pfn_to_page(pfn2 - 1) + 1;
 
 			do {
 				if (PageReserved(page))


-- 
Catalin
