From: steve.capper@arm.com (Steve Capper)
Date: Wed, 12 Dec 2012 17:40:00 +0000
Subject: [RFC PATCH] ARM: Consider memblocks in mem_init and show_mem.
Message-ID: <1355334000-10198-1-git-send-email-steve.capper@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is based on Michael Spang's patch [1]; and is my attempt at
applying the feedback from Russell [2].

With discontiguous memory (a requirement for running NUMA on some
systems), membanks may not necessarily be representable as
contiguous blocks of struct page *s. This patch updates the page
scanning code in mem_init and show_mem to consider pages in the
intersection of membanks and memblocks instead.

We can't consider memblocks solely as under sparse memory
configurations, contiguous physical membanks won't necessarily have
a contiguous memory map (but may be merged into the same memblock).

Only memory blocks in the "memory" region were considered as the
"reserved" region was found to always overlap "memory"; all the
memory banks are added with memblock_add (which adds to "memory")
and no instances were found where memory was added to "reserved"
then removed from "memory".

In mem_init we are running on one CPU, and I can't see the
memblocks changing whilst being enumerated.

In show_mem, we can be running on multiple CPUs; whilst the
memblock manipulation functions are annotated as __init, this
doesn't stop memblocks being manipulated during bootup. I can't
see any place where memblocks are removed or merged other than
driver initialisation (memblock_steal) or boot memory
initialisation.

One consequence of using memblocks in show_mem, is that we are
unable to define ARCH_DISCARD_MEMBLOCK.

Any feedback would be welcome.

Thanks,
-- 
Steve

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2012-October/127104.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2012-November/135455.html

Signed-off-by: Steve Capper <steve.capper@arm.com>
---
 arch/arm/mm/init.c |  119 ++++++++++++++++++++++++++++++++++------------------
 1 file changed, 79 insertions(+), 40 deletions(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index ad722f1..abe4eae 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -94,36 +94,56 @@ void show_mem(unsigned int filter)
 {
 	int free = 0, total = 0, reserved = 0;
 	int shared = 0, cached = 0, slab = 0, i;
-	struct meminfo * mi = &meminfo;
+	struct meminfo *mi = &meminfo;
+	struct memblock_region *reg;
 
 	printk("Mem-info:\n");
 	show_free_areas(filter);
 
 	for_each_bank (i, mi) {
 		struct membank *bank = &mi->bank[i];
-		unsigned int pfn1, pfn2;
-		struct page *page, *end;
-
-		pfn1 = bank_pfn_start(bank);
-		pfn2 = bank_pfn_end(bank);
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
-			page++;
-		} while (page < end);
+		unsigned int sbank, ebank;
+
+		sbank = bank_pfn_start(bank);
+		ebank = bank_pfn_end(bank);
+
+		/* consider every memory block that intersects our memory bank */
+		for_each_memblock(memory, reg) {
+			struct page *page, *end;
+			unsigned int pfn1, pfn2;
+			unsigned int sblock = memblock_region_memory_base_pfn(reg);
+			unsigned int eblock = memblock_region_memory_end_pfn(reg);
+
+			/* we're beyond the membank */
+			if (sblock >= ebank)
+				break;
+
+			/* we're not yet at the membank */
+			if (eblock <= sbank)
+				continue;
+
+			/* take the intersection between bank and block */
+			pfn1 = max(sblock, sbank);
+			pfn2 = min(eblock, ebank);
+
+			page = pfn_to_page(pfn1);
+			end = pfn_to_page(pfn2 - 1) + 1;
+
+			do {
+				total++;
+				if (PageReserved(page))
+					reserved++;
+				else if (PageSwapCache(page))
+					cached++;
+				else if (PageSlab(page))
+					slab++;
+				else if (!page_count(page))
+					free++;
+				else
+					shared += page_count(page) - 1;
+				page++;
+			} while (page < end);
+		}
 	}
 
 	printk("%d pages of RAM\n", total);
@@ -619,22 +639,41 @@ void __init mem_init(void)
 
 	for_each_bank(i, &meminfo) {
 		struct membank *bank = &meminfo.bank[i];
-		unsigned int pfn1, pfn2;
-		struct page *page, *end;
-
-		pfn1 = bank_pfn_start(bank);
-		pfn2 = bank_pfn_end(bank);
-
-		page = pfn_to_page(pfn1);
-		end  = pfn_to_page(pfn2 - 1) + 1;
-
-		do {
-			if (PageReserved(page))
-				reserved_pages++;
-			else if (!page_count(page))
-				free_pages++;
-			page++;
-		} while (page < end);
+		unsigned int sbank, ebank;
+
+		sbank = bank_pfn_start(bank);
+		ebank = bank_pfn_end(bank);
+
+		/* consider every memory block that intersects our memory bank */
+		for_each_memblock(memory, reg) {
+			struct page *page, *end;
+			unsigned int pfn1, pfn2;
+			unsigned int sblock = memblock_region_memory_base_pfn(reg);
+			unsigned int eblock = memblock_region_memory_end_pfn(reg);
+
+			/* we're beyond the membank */
+			if (sblock >= ebank)
+				break;
+
+			/* we're not yet at the membank */
+			if (eblock <= sbank)
+				continue;
+
+			/* take the intersection between bank and block */
+			pfn1 = max(sblock, sbank);
+			pfn2 = min(eblock, ebank);
+
+			page = pfn_to_page(pfn1);
+			end = pfn_to_page(pfn2 - 1) + 1;
+
+			do {
+				if (PageReserved(page))
+					reserved_pages++;
+				else if (!page_count(page))
+					free_pages++;
+				page++;
+			} while (page < end);
+		}
 	}
 
 	/*
-- 
1.7.9.5
