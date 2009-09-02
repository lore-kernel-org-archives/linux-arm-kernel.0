From: nico@cam.org (Nicolas Pitre)
Date: Wed, 02 Sep 2009 11:52:33 -0400 (EDT)
Subject: ARM highmem stuff - 5687/1
In-Reply-To: <20090902135355.GB12595@n2100.arm.linux.org.uk>
References: <20090902135355.GB12595@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.0909021009010.6044@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2 Sep 2009, Russell King - ARM Linux wrote:

> Do we need a similar fix for flush_anon_page()?

Hmmmm... Maybe.  Especially since the only usage of flush_anon_page() is 
in __get_user_pages() where the page passed to flush_anon_page() may or 
may not be kmapped (it is not explicitly kmapped in that function, but 
non atomic kmaps are lazily unmapped and would still require to be 
flushed if their mapping is still there).  However, in 
__get_user_pages(), there is a flush_dcache_page() right after the call 
to flush_anon_page(), so the __cpuc_flush_dcache_page() in 
__flush_anon_page() appears redundant to me and could simply be removed 
entirely.

> In both cases, can we just avoid calling __cpuc_flush_dcache_page() if 
> PageHighMem(page) is true rather than checking page_address(page) is 
> non-zero?

No.  Like I say above, unlike with kunmap_atomic(), the cache is 
untouched by kunmap().  This is because kmap() and kunmap() can be used 
repeatedly on the same set of pages and their actual mappings don't need 
to be flushed and removed between those calls.  However if a 
flush_dcache_page() is required on a highmem page that still has a valid 
kmap mapping then the flush is relevant.


Nicolas
