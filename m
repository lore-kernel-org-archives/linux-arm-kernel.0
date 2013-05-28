From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 28 May 2013 14:50:18 -0400 (EDT)
Subject: [PATCH V4] ARM: handle user space mapped pages in
 flush_kernel_dcache_page
In-Reply-To: <20130528102001.GB14329@arm.com>
References: <1368336956-6693-1-git-send-email-gmbnomis@gmail.com>
 <20130523104303.GC16722@arm.com> <20130527214245.GB517@schnuecks.de>
 <20130528102001.GB14329@arm.com>
Message-ID: <alpine.LFD.2.03.1305281423510.1918@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 28 May 2013, Catalin Marinas wrote:

> On Mon, May 27, 2013 at 10:42:45PM +0100, Simon Baatz wrote:
> > On Thu, May 23, 2013 at 11:43:03AM +0100, Catalin Marinas wrote:
> > > On Sun, May 12, 2013 at 06:35:56AM +0100, Simon Baatz wrote:
> > > > Commit f8b63c1 made flush_kernel_dcache_page a no-op assuming that the pages
> > > > it needs to handle are kernel mapped only.  However, for example when doing
> > > > direct I/O, pages with user space mappings may occur.
> > > > 
> > > > Thus, continue to do lazy flushing if there are no user space mappings.
> > > > Otherwise, flush the kernel cache lines directly.
> > > > 
> > > > Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
> > > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > > Cc: Russell King <linux@arm.linux.org.uk>
> > > 
> > > An issue is that for kunmap_atomic() && VIVT we flush the same page
> > > twice. I don't think we should remove the cache flushing in
> > > __kunmap_atomic() for VIVT since not all kunmap_atomic() calls require
> > > flush_kernel_dcache_page() (unless we just assume that highmem && vivt
> > > don't work together). Flushing the VIVT cache on kunmap is essential
> > > since we just lose the alias after that.
> > 
> > Not sure if I am missing something here. From our previous
> > discussion:
> > 
> > > > > > We probably should reuse it in flush_kernel_dcache_page() to flush
> > > > > > the kernel mapping. (The last else clause looks strange though)
> > > > > 
> > > > > I think it makes sense to reuse this logic in
> > > > > flush_kernel_dcache_page(). If the page is already mapped with kmap,
> > > > > then kmap_high_get() should return the actual address. If it was mapped
> > > > > with kmap_atomic, kmap_high_get() would return NULL, hence the 'else'
> > > > > clause and the additional kmap_atomic(). The cache_is_vipt() check is
> > > > > useful because kunmap_atomic() would flush VIVT caches anyway.
> 
> I think the context was that page_address() is not always valid after
> kmap_atomic(), so reusing the same logic would make sense.

Following my explanation of kunmap()... remember that kunmap()'d pages 
are not actually unmaped right away.  So the only thing that 
kmap_high_get() does is to look for such a mapping and pin it with an 
increased use count if it exists, or return NULL if there is no such 
mapping.  In the former case page_address() is valid, in the second case 
it is NULL.  Yet, after kunmap_atomic() (or kunmap() as well) you never 
know when page_address() might suddenly return NULL if it returned an 
address unless you pin the page down with kmap_high_get().

> But the key point I try to understand is why kunmap() does not need to
> flush the VIVT cache. If it does need to, then we can simplify your
> patch.

It does not and should not for performance reasons.

> > As you say, this logic does not flush on VIVT if the page was mapped
> > via kmap_atomic() (and kmap_atomic() could not reuse an existing
> > mapping via kmap_high_get())
> > 
> > kmap_atomic() tries to reuse an existing mapping and only allocates a
> > new dedicated kmap if it finds none.  Consequently, __kunmap_atomic()
> > only flushes in the latter case (because we lose the alias).

That is exact.

> > 
> > Thus, no double flushing should occur here. If kunmap_atomic() will
> > flush, __flush_kernel_dcache_page() will not and vice versa.
> 
> That's correct for the current code. Let's wait for some insight from
> Nico or Russell on whether kunmap() needs to lush the VIVT cache as
> well. If it doesn't need to, then my original comment made sense.

I hope I've been able to shed some light on the way highmem caching 
works.  I'm not sure I fully understand what the patch in this thread 
does though, but I've never fully grokked the subtleties behind 
flush_dcache_page either.


Nicolas
