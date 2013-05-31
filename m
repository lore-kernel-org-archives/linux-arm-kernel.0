From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 31 May 2013 15:15:08 +0100
Subject: [PATCH V4] ARM: handle user space mapped pages in
 flush_kernel_dcache_page
In-Reply-To: <20130531120519.GB3803@titan.lakedaemon.net>
References: <1368336956-6693-1-git-send-email-gmbnomis@gmail.com>
 <20130529110508.GH17767@MacBook-Pro.local>
 <20130529191657.GA13047@schnuecks.de>
 <20130530164335.GK23631@arm.com>
 <20130531120519.GB3803@titan.lakedaemon.net>
Message-ID: <20130531141508.GB15551@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 31, 2013 at 01:05:19PM +0100, Jason Cooper wrote:
> On Thu, May 30, 2013 at 05:43:35PM +0100, Catalin Marinas wrote:
> > On Wed, May 29, 2013 at 08:16:57PM +0100, Simon Baatz wrote:
> > > On Wed, May 29, 2013 at 12:05:09PM +0100, Catalin Marinas wrote:
> > > > On Sun, May 12, 2013 at 06:35:56AM +0100, Simon Baatz wrote:
> > > > > Commit f8b63c1 made flush_kernel_dcache_page a no-op assuming that the pages
> > > > > it needs to handle are kernel mapped only.  However, for example when doing
> > > > > direct I/O, pages with user space mappings may occur.
> > > > 
> > > > After Nico's clarification, I think the original commit introducing this
> > > > function was also incomplete (commit 73be1591 - [ARM] 5545/2: add
> > > > flush_kernel_dcache_page() for ARM) since it ignores highmem pages and
> > > > their flushing could be deferred for a long time.
> > > 
> > > Yes, I agree.
> > >  
> > > > For my understanding (if I re-read this tread) - basically code like
> > > > this should not leave the user mapping inconsistent:
> > > > 
> > > > kmap()
> > > > ...
> > > > flush_kernel_dcache_page()
> > > > kunmap()
> > > 
> > > s/user mapping/kernel mapping/ 
> > > The user mapping(s) can be assumed to be consistent when entering
> > > such code. Either there is none or the page was obtained by a
> > > mechanism like __get_user_pages(). Otherwise, we have a problem
> > > anyway when accessing the page via the kernel mapping.
> > 
> > Indeed. What I meant was user mapping inconsistent with the kernel
> > mapping. It's the latter that needs flushing.
> > 
> > > > > Thus, continue to do lazy flushing if there are no user space mappings.
> > > > > Otherwise, flush the kernel cache lines directly.
> > > > ...
> > > > >  /*
> > > > > + * Ensure cache coherency for kernel mapping of this page.
> > > > > + *
> > > > > + * If the page only exists in the page cache and there are no user
> > > > > + * space mappings, this is a no-op since the page was already marked
> > > > > + * dirty at creation.  Otherwise, we need to flush the dirty kernel
> > > > > + * cache lines directly.
> > > > > + */
> > > > > +void flush_kernel_dcache_page(struct page *page)
> > > > > +{
> > > > > +	if (cache_is_vivt() || cache_is_vipt_aliasing()) {
> > > > > +		struct address_space *mapping;
> > > > > +
> > > > > +		mapping = page_mapping(page);
> > > > > +
> > > > > +		if (!mapping || mapping_mapped(mapping))
> > > > > +			__flush_kernel_dcache_page(page);
> > > > > +	}
> > > > > +}
> > > > 
> > > > BTW, does the mapping check optimise anything for the
> > > > flush_kernel_dcache_page() uses? Would we have a mapping anyway (or
> > > > anonymous page) in most cases?
> > > 
> > > Looking at the relevant uses in the kernel, we have:
> > > 
> > >     drivers/scsi/libsas/sas_host_smp.c
> > >     drivers/mmc/host/mmc_spi.c
> > >     drivers/block/ps3disk.c
> > >     fs/exec.c
> > >     lib/scatterlist.c
> > >  
> > > That is not much (I omit my usual rant here that many uses of
> > > flush_dcache_page() in drivers are incorrect and should be uses of
> > > flush_kernel_dcache_page() ...).
> > > 
> > > Without looking at the actual code, we seem to have two basic use
> > > cases:
> > > 
> > > 1. Block drivers (the ones listed above + those using the memory
> > > scatterlist iterator in scatterlist.c)
> > > 
> > > These will probably almost exclusively use page cache pages for which
> > > we can be lazy.  Other pages only occur in special I/O situations
> > > like direct I/O.
> > > 
> > > 2. fs/exec.c
> > > 
> > > I think these are anonymous pages only
> > > 
> > > Thus depending on the actual drivers used, usage can be dominated by
> > > page cache pages on one setup and anon pages on the other.
> > > 
> > > I prefer the currently proposed way since it prevents massive
> > > overflushing if flush_kernel_dcache_page() is used in an I/O path.
> > > 
> > > (Btw. I am still puzzled as to why making flush_kernel_dcache_page()
> > > the current nop apparently did not cause problems in fs/exec.c.)
> > 
> > We get extra flushing via flush_old_exec() -> exec_mmap() -> mmput() ->
> > exit_mmap() -> flush_cache_mm() before we actually start the new exec so
> > this would flush the arg page as well.
> > 
> > > > Otherwise the patch looks good.
> > > 
> > > Thanks. Especially, thanks for pointing out the highmem case.
> > 
> > You can add my ack (before I forget the whole discussion ;))
> > 
> > Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> 
> wrt to 73be1591, this appears to go all the way back to v2.6.31.x... Can
> Simon go ahead and put this in rmk's patch tracker and mention that it
> should go to all -stable trees?

I'm not sure how easy it is to apply this patch on past stable versions.
Maybe something simpler for stable like always flushing the cache in
flush_kernel_dcache_page() with optimisation only in recent stable
versions.

-- 
Catalin
