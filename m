From: gmbnomis@gmail.com (Simon Baatz)
Date: Wed, 29 May 2013 21:16:57 +0200
Subject: [PATCH V4] ARM: handle user space mapped pages in
 flush_kernel_dcache_page
In-Reply-To: <20130529110508.GH17767@MacBook-Pro.local>
References: <1368336956-6693-1-git-send-email-gmbnomis@gmail.com>
 <20130529110508.GH17767@MacBook-Pro.local>
Message-ID: <20130529191657.GA13047@schnuecks.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

On Wed, May 29, 2013 at 12:05:09PM +0100, Catalin Marinas wrote:
> On Sun, May 12, 2013 at 06:35:56AM +0100, Simon Baatz wrote:
> > Commit f8b63c1 made flush_kernel_dcache_page a no-op assuming that the pages
> > it needs to handle are kernel mapped only.  However, for example when doing
> > direct I/O, pages with user space mappings may occur.
> 
> After Nico's clarification, I think the original commit introducing this
> function was also incomplete (commit 73be1591 - [ARM] 5545/2: add
> flush_kernel_dcache_page() for ARM) since it ignores highmem pages and
> their flushing could be deferred for a long time.

Yes, I agree.
 
> For my understanding (if I re-read this tread) - basically code like
> this should not leave the user mapping inconsistent:
> 
> kmap()
> ...
> flush_kernel_dcache_page()
> kunmap()

s/user mapping/kernel mapping/ 
The user mapping(s) can be assumed to be consistent when entering
such code. Either there is none or the page was obtained by a
mechanism like __get_user_pages(). Otherwise, we have a problem
anyway when accessing the page via the kernel mapping.

The visibility of a page to user space is just needed for
optimization.  If the page is not visible to user space, we can use
our lazy flushing mechanism (PG_dcache_clean bit) and defer flushing
until the page is mapped into user space (if ever).  Otherwise, we
need to flush the kernel mapping since only that can be dirty.

And, we don't need to do anything in flush_kernel_dcache_page() for
non-aliasing caches, of course.
 
> If we use the atomic variants, we get the cache flushing automatically
> but the kunmap_high() does not flush the cache immediately, so we need
> to handle it in flush_kernel_dcache_page().

Exactly. But only if it is really needed. If we have no user space
mapping and don't lose the kernel mapping, we just may do nothing.
 
> > Thus, continue to do lazy flushing if there are no user space mappings.
> > Otherwise, flush the kernel cache lines directly.
> ...
> >  /*
> > + * Ensure cache coherency for kernel mapping of this page.
> > + *
> > + * If the page only exists in the page cache and there are no user
> > + * space mappings, this is a no-op since the page was already marked
> > + * dirty at creation.  Otherwise, we need to flush the dirty kernel
> > + * cache lines directly.
> > + */
> > +void flush_kernel_dcache_page(struct page *page)
> > +{
> > +	if (cache_is_vivt() || cache_is_vipt_aliasing()) {
> > +		struct address_space *mapping;
> > +
> > +		mapping = page_mapping(page);
> > +
> > +		if (!mapping || mapping_mapped(mapping))
> > +			__flush_kernel_dcache_page(page);
> > +	}
> > +}
> 
> BTW, does the mapping check optimise anything for the
> flush_kernel_dcache_page() uses? Would we have a mapping anyway (or
> anonymous page) in most cases?


Looking at the relevant uses in the kernel, we have:

    drivers/scsi/libsas/sas_host_smp.c
    drivers/mmc/host/mmc_spi.c
    drivers/block/ps3disk.c
    fs/exec.c
    lib/scatterlist.c
 
That is not much (I omit my usual rant here that many uses of
flush_dcache_page() in drivers are incorrect and should be uses of
flush_kernel_dcache_page() ...).

Without looking at the actual code, we seem to have two basic use
cases:

1. Block drivers (the ones listed above + those using the memory
scatterlist iterator in scatterlist.c)

These will probably almost exclusively use page cache pages for which
we can be lazy.  Other pages only occur in special I/O situations
like direct I/O.

2. fs/exec.c

I think these are anonymous pages only


Thus depending on the actual drivers used, usage can be dominated by
page cache pages on one setup and anon pages on the other.

I prefer the currently proposed way since it prevents massive
overflushing if flush_kernel_dcache_page() is used in an I/O path.


(Btw. I am still puzzled as to why making flush_kernel_dcache_page()
the current nop apparently did not cause problems in fs/exec.c.)

> Otherwise the patch looks good.

Thanks. Especially, thanks for pointing out the highmem case.


- Simon
