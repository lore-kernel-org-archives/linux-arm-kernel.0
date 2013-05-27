From: gmbnomis@gmail.com (Simon Baatz)
Date: Mon, 27 May 2013 23:42:45 +0200
Subject: [PATCH V4] ARM: handle user space mapped pages in
 flush_kernel_dcache_page
In-Reply-To: <20130523104303.GC16722@arm.com>
References: <1368336956-6693-1-git-send-email-gmbnomis@gmail.com>
 <20130523104303.GC16722@arm.com>
Message-ID: <20130527214245.GB517@schnuecks.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

On Thu, May 23, 2013 at 11:43:03AM +0100, Catalin Marinas wrote:
> On Sun, May 12, 2013 at 06:35:56AM +0100, Simon Baatz wrote:
> > Commit f8b63c1 made flush_kernel_dcache_page a no-op assuming that the pages
> > it needs to handle are kernel mapped only.  However, for example when doing
> > direct I/O, pages with user space mappings may occur.
> > 
> > Thus, continue to do lazy flushing if there are no user space mappings.
> > Otherwise, flush the kernel cache lines directly.
> > 
> > Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Russell King <linux@arm.linux.org.uk>
> 
> An issue is that for kunmap_atomic() && VIVT we flush the same page
> twice. I don't think we should remove the cache flushing in
> __kunmap_atomic() for VIVT since not all kunmap_atomic() calls require
> flush_kernel_dcache_page() (unless we just assume that highmem && vivt
> don't work together). Flushing the VIVT cache on kunmap is essential
> since we just lose the alias after that.

Not sure if I am missing something here. From our previous
discussion:

> > > > We probably should reuse it in flush_kernel_dcache_page() to flush
> > > > the kernel mapping. (The last else clause looks strange though)
> > > 
> > > I think it makes sense to reuse this logic in
> > > flush_kernel_dcache_page(). If the page is already mapped with kmap,
> > > then kmap_high_get() should return the actual address. If it was mapped
> > > with kmap_atomic, kmap_high_get() would return NULL, hence the 'else'
> > > clause and the additional kmap_atomic(). The cache_is_vipt() check is
> > > useful because kunmap_atomic() would flush VIVT caches anyway.


As you say, this logic does not flush on VIVT if the page was mapped
via kmap_atomic() (and kmap_atomic() could not reuse an existing
mapping via kmap_high_get())

kmap_atomic() tries to reuse an existing mapping and only allocates a
new dedicated kmap if it finds none.  Consequently, __kunmap_atomic()
only flushes in the latter case (because we lose the alias).

Thus, no double flushing should occur here. If kunmap_atomic() will
flush, __flush_kernel_dcache_page() will not and vice versa.

> > +void flush_kernel_dcache_page(struct page *page)
> > +{
> > +	if (cache_is_vivt() || cache_is_vipt_aliasing()) {
> 
> So you could add the ((cache_is_vivt() || cache_is_vipt_aliasing()) &&
> !PageHighMem(page)) check back (as it was prior to commit f8b63c184,
> actually reverting it) and the mapping tests as a possible optimisation.
> But in this case there is no need to split __flush_dcache_page() in two
> since we don't care about the PageHighMem() case.
> 
> And we need to fix kunmap() with VIVT to flush the cache as well (in
> case anyone uses highmem on VIVT hardware).

I still think your previous comment that we need to handle the
highmem case as well was right and reusing the respective part of
__flush_dcache_page() does the right thing.

But as said, perhaps I am missing something here.

- Simon 
