From: mnazarewicz@google.com (Michal Nazarewicz)
Date: Wed, 21 Sep 2011 18:26:21 +0200
Subject: [PATCH 1/3] fixup! mm: alloc_contig_freed_pages() added
In-Reply-To: <1316619959.16137.308.camel@nimitz>
References: <1316619959.16137.308.camel@nimitz>
Message-ID: <f57b57f83bc5980e3db7d9d42f91c7e1765b4766.1316622205.git.mina86@mina86.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Michal Nazarewicz <mina86@mina86.com>

Signed-off-by: Michal Nazarewicz <mina86@mina86.com>

---
 include/asm-generic/memory_model.h |   17 ++++++++++++++
 include/linux/page-isolation.h     |    4 ++-
 mm/page_alloc.c                    |   43 +++++++++++++++++++++++++++--------
 3 files changed, 53 insertions(+), 11 deletions(-)

> On Wed, 2011-09-21 at 17:19 +0200, Michal Nazarewicz wrote:
>> I wanted to avoid calling pfn_to_page() each time as it seem fairly
>> expensive in sparsemem and disctontig modes.  At the same time, the
>> macro trickery is so that users of sparsemem-vmemmap and flatmem won't
>> have to pay the price.

On Wed, 21 Sep 2011 17:45:59 +0200, Dave Hansen <dave@linux.vnet.ibm.com> wrote:
> Personally, I'd say the (incredibly minuscule) runtime cost is worth the
> cost of making folks' eyes bleed when they see those macros.  I think
> there are some nicer ways to do it.

Yeah.  I wasn't amazed by them either.

> Is there a reason you can't logically do?
>	page = pfn_to_page(pfn);
> 	for (;;) {
> 		if (pfn_to_section_nr(pfn) == pfn_to_section_nr(pfn+1))
> 			page++;
> 		else
> 			page = pfn_to_page(pfn+1);
> 	}

Done.  Thanks for the suggestions!

>> +#define __contig_next_page(page, pageblock_left, pfn, increment)	\
>> +	(likely((pageblock_left) -= (increment)) ? (page) + (increment)	\
>> +	 : (((pageblock_left) = pageblock_nr_pages), pfn_to_page(pfn)))
>> +
>> +#define __contig_first_page(pageblock_left, pfn) (			\
>> +	((pageblock_left) = pageblock_nr_pages -			\
>> +		 ((pfn) & (pageblock_nr_pages - 1))),			\
>> +	pfn_to_page(pfn))
>> +
>> +#endif

> For the love of Pete, please make those in to functions if you're going
> to keep them.

That was tricky because they modify pageblock_left.  Not relevant now
anyways though.

diff --git a/include/asm-generic/memory_model.h b/include/asm-generic/memory_model.h
index fb2d63f..900da88 100644
--- a/include/asm-generic/memory_model.h
+++ b/include/asm-generic/memory_model.h
@@ -69,6 +69,23 @@
 })
 #endif /* CONFIG_FLATMEM/DISCONTIGMEM/SPARSEMEM */
 
+#if defined(CONFIG_SPARSEMEM) && !defined(CONFIG_SPARSEMEM_VMEMMAP)
+
+/*
+ * Both PFNs must be from the same zone!  If this function returns
+ * true, pfn_to_page(pfn1) + (pfn2 - pfn1) == pfn_to_page(pfn2).
+ */
+static inline bool zone_pfn_same_memmap(unsigned long pfn1, unsigned long pfn2)
+{
+	return pfn_to_section_nr(pfn1) == pfn_to_section_nr(pfn2);
+}
+
+#else
+
+#define zone_pfn_same_memmap(pfn1, pfn2) (true)
+
+#endif
+
 #define page_to_pfn __page_to_pfn
 #define pfn_to_page __pfn_to_page
 
diff --git a/include/linux/page-isolation.h b/include/linux/page-isolation.h
index b2a81fd..003c52f 100644
--- a/include/linux/page-isolation.h
+++ b/include/linux/page-isolation.h
@@ -46,11 +46,13 @@ static inline void unset_migratetype_isolate(struct page *page)
 {
 	__unset_migratetype_isolate(page, MIGRATE_MOVABLE);
 }
+
+/* The below functions must be run on a range from a single zone. */
 extern unsigned long alloc_contig_freed_pages(unsigned long start,
 					      unsigned long end, gfp_t flag);
 extern int alloc_contig_range(unsigned long start, unsigned long end,
 			      gfp_t flags, unsigned migratetype);
-extern void free_contig_pages(struct page *page, int nr_pages);
+extern void free_contig_pages(unsigned long pfn, unsigned nr_pages);
 
 /*
  * For migration.
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 46e78d4..bc200a9 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5725,31 +5725,46 @@ unsigned long alloc_contig_freed_pages(unsigned long start, unsigned long end,
 	int order;
 
 	VM_BUG_ON(!pfn_valid(start));
-	zone = page_zone(pfn_to_page(start));
+	page = pfn_to_page(start);
+	zone = page_zone(page);
 
 	spin_lock_irq(&zone->lock);
 
-	page = pfn_to_page(pfn);
 	for (;;) {
-		VM_BUG_ON(page_count(page) || !PageBuddy(page));
+		VM_BUG_ON(!page_count(page) || !PageBuddy(page) ||
+			  page_zone(page) != zone);
+
 		list_del(&page->lru);
 		order = page_order(page);
+		count = 1UL << order;
 		zone->free_area[order].nr_free--;
 		rmv_page_order(page);
-		__mod_zone_page_state(zone, NR_FREE_PAGES, -(1UL << order));
-		pfn  += 1 << order;
+		__mod_zone_page_state(zone, NR_FREE_PAGES, -(long)count);
+
+		pfn += count;
 		if (pfn >= end)
 			break;
 		VM_BUG_ON(!pfn_valid(pfn));
-		page += 1 << order;
+
+		if (zone_pfn_same_memmap(pfn - count, pfn))
+			page += count;
+		else
+			page = pfn_to_page(pfn);
 	}
 
 	spin_unlock_irq(&zone->lock);
 
 	/* After this, pages in the range can be freed one be one */
-	page = pfn_to_page(start);
-	for (count = pfn - start; count; --count, ++page)
+	count = pfn - start;
+	pfn = start;
+	for (page = pfn_to_page(pfn); count; --count) {
 		prep_new_page(page, 0, flag);
+		++pfn;
+		if (likely(zone_pfn_same_memmap(pfn - 1, pfn)))
+			++page;
+		else
+			page = pfn_to_page(pfn);
+	}
 
 	return pfn;
 }
@@ -5903,10 +5918,18 @@ done:
 	return ret;
 }
 
-void free_contig_pages(struct page *page, int nr_pages)
+void free_contig_pages(unsigned long pfn, unsigned nr_pages)
 {
-	for (; nr_pages; --nr_pages, ++page)
+	struct page *page = pfn_to_page(pfn);
+
+	while (nr_pages--) {
 		__free_page(page);
+		++pfn;
+		if (likely(zone_pfn_same_memmap(pfn - 1, pfn)))
+			++page;
+		else
+			page = pfn_to_page(pfn);
+	}
 }
 
 #ifdef CONFIG_MEMORY_HOTREMOVE
-- 
1.7.3.1
