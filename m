From: nico@cam.org (Nicolas Pitre)
Date: Wed, 02 Sep 2009 13:59:43 -0400 (EDT)
Subject: ARM highmem stuff - 5687/1
In-Reply-To: <alpine.LFD.2.00.0909021009010.6044@xanadu.home>
References: <20090902135355.GB12595@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.0909021009010.6044@xanadu.home>
Message-ID: <alpine.LFD.2.00.0909021331450.6044@xanadu.home>
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

Something like this:

    [ARM] remove redundant cache flush from __flush_anon_page()
    
    The only usage of flush_anon_page() is in __get_user_pages() where
    a call to flush_dcache_page() is performed immediately after the call
    to flush_anon_page().  This makes the __cpuc_flush_dcache_page() in
    __flush_anon_page() redundant.
    
    Signed-off-by: Nicolas Pitre <nico@marvell.com>

diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
index 575f3ad..c0f4039 100644
--- a/arch/arm/mm/flush.c
+++ b/arch/arm/mm/flush.c
@@ -262,11 +262,4 @@ void __flush_anon_page(struct vm_area_struct *vma, struct page *page, unsigned l
 		 */
 		flush_pfn_alias(pfn, vmaddr);
 	}
-
-	/*
-	 * Invalidate kernel mapping.  No data should be contained
-	 * in this mapping of the page.  FIXME: this is overkill
-	 * since we actually ask for a write-back and invalidate.
-	 */
-	__cpuc_flush_dcache_page(page_address(page));
 }
