From: nico@cam.org (Nicolas Pitre)
Date: Wed, 02 Sep 2009 13:31:06 -0400 (EDT)
Subject: ARM highmem stuff - 5687/1
In-Reply-To: <alpine.LFD.2.00.0909021009010.6044@xanadu.home>
References: <20090902135355.GB12595@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.0909021009010.6044@xanadu.home>
Message-ID: <alpine.LFD.2.00.0909021321160.6044@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2 Sep 2009, Nicolas Pitre wrote:

> On Wed, 2 Sep 2009, Russell King - ARM Linux wrote:
> 
> > Do we need a similar fix for flush_anon_page()?
> 
> Hmmmm... Maybe.  Especially since the only usage of flush_anon_page() is 
> in __get_user_pages() where the page passed to flush_anon_page() may or 
> may not be kmapped (it is not explicitly kmapped in that function, but 
> non atomic kmaps are lazily unmapped and would still require to be 
> flushed if their mapping is still there).  However, in 
> __get_user_pages(), there is a flush_dcache_page() right after the call 
> to flush_anon_page(), so the __cpuc_flush_dcache_page() in 
> __flush_anon_page() appears redundant to me and could simply be removed 
> entirely.

This made me think about a race that exists with the highmem kmap 
business though...

Let's suppose a highmem page is kmap'd with kmap().  A pkmap entry is 
used, the page mapped to it, and the virtual cache is dirtied.  Then 
kunmap() is used which does virtually nothing except for decrementing a 
usage count.

Then, let's suppose the _same_ page gets mapped using kmap_atomic().  
It is therefore mapped onto a fixmap entry instead, which has a 
different virtual address unaware of the dirty data for that page 
sitting in the pkmap mapping.

Fortunately the fix is simple:

diff --git a/arch/arm/mm/highmem.c b/arch/arm/mm/highmem.c
index a34954d..73cae57 100644
--- a/arch/arm/mm/highmem.c
+++ b/arch/arm/mm/highmem.c
@@ -40,11 +40,16 @@ void *kmap_atomic(struct page *page, enum km_type type)
 {
 	unsigned int idx;
 	unsigned long vaddr;
+	void *kmap;
 
 	pagefault_disable();
 	if (!PageHighMem(page))
 		return page_address(page);
 
+	kmap = kmap_high_get(page);
+	if (kmap)
+		return kmap;
+
 	idx = type + KM_TYPE_NR * smp_processor_id();
 	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
 #ifdef CONFIG_DEBUG_HIGHMEM
@@ -80,6 +85,9 @@ void kunmap_atomic(void *kvaddr, enum km_type type)
 #else
 		(void) idx;  /* to kill a warning */
 #endif
+	} else if (vaddr >= PKMAP_ADDR(0) && vaddr < PKMAP_ADDR(LAST_PKMAP)) {
+		/* this address was obtained through kmap_high_get() */
+		kunmap_high(pte_page(pkmap_page_table[PKMAP_NR(vaddr)]));
 	}
 	pagefault_enable();
 }


Nicolas
