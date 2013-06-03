From: gregkh@linuxfoundation.org (Greg KH)
Date: Mon, 3 Jun 2013 13:38:38 -0700
Subject: [PATCH V4] ARM: handle user space mapped pages in
 flush_kernel_dcache_page
In-Reply-To: <20130603192230.GS3803@titan.lakedaemon.net>
References: <1368336956-6693-1-git-send-email-gmbnomis@gmail.com>
 <20130529110508.GH17767@MacBook-Pro.local>
 <20130529191657.GA13047@schnuecks.de>
 <20130530164335.GK23631@arm.com>
 <20130531120519.GB3803@titan.lakedaemon.net>
 <20130531141508.GB15551@arm.com>
 <20130603173817.GA32211@schnuecks.de>
 <20130603180339.GN3803@titan.lakedaemon.net>
 <20130603192230.GS3803@titan.lakedaemon.net>
Message-ID: <20130603203838.GA32069@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 03, 2013 at 03:22:30PM -0400, Jason Cooper wrote:
> It would be helpful if I actually did as I stated ;-)
> 
> Adding Greg for real this time.
> 
> On Mon, Jun 03, 2013 at 02:03:39PM -0400, Jason Cooper wrote:
> > All,
> > 
> > Adding gregkh for insight into -stable and applying fixes to previous
> > kernels when the bug was not against them (but the offending commit
> > exists in them).
> > 
> > Greg,
> > 
> > Some history:  This bug stems from attempting to write O_DIRECT to a
> > dm-crypt device on ARM architectures.  In my case, it was trying (years
> > ago!) to put an LVM into a dm-crypt container.  This data corruption can
> > be more readily seen by using dd to write to a dm-crypt device with the
> > direct flag.
> > 
> > On Mon, Jun 03, 2013 at 07:38:18PM +0200, Simon Baatz wrote:
> > > Hi Catalin,
> > > 
> > > On Fri, May 31, 2013 at 03:15:08PM +0100, Catalin Marinas wrote:
> > > > On Fri, May 31, 2013 at 01:05:19PM +0100, Jason Cooper wrote:
> > > > > On Thu, May 30, 2013 at 05:43:35PM +0100, Catalin Marinas wrote:
> > > > > > On Wed, May 29, 2013 at 08:16:57PM +0100, Simon Baatz wrote:
> > > > > > > On Wed, May 29, 2013 at 12:05:09PM +0100, Catalin Marinas wrote:
> > > > > > > > On Sun, May 12, 2013 at 06:35:56AM +0100, Simon Baatz wrote:
> > > > > > > > > Commit f8b63c1 made flush_kernel_dcache_page a no-op assuming that the pages
> > > > > > > > > it needs to handle are kernel mapped only.  However, for example when doing
> > > > > > > > > direct I/O, pages with user space mappings may occur.
> > > > > > > > 
> > > > > > > > After Nico's clarification, I think the original commit introducing this
> > > > > > > > function was also incomplete (commit 73be1591 - [ARM] 5545/2: add
> > > > > > > > flush_kernel_dcache_page() for ARM) since it ignores highmem pages and
> > > > > > > > their flushing could be deferred for a long time.
> > > > > > > 
> > > > > > > Yes, I agree.
> > > > > > >  
> > > > > > > > For my understanding (if I re-read this tread) - basically code like
> > > > > > > > this should not leave the user mapping inconsistent:
> > > > > > > > 
> > > > > > > > kmap()
> > > > > > > > ...
> > > > > > > > flush_kernel_dcache_page()
> > > > > > > > kunmap()
> > > > ...
> > > > > 
> > > > > wrt to 73be1591, this appears to go all the way back to v2.6.31.x... Can
> > > > > Simon go ahead and put this in rmk's patch tracker and mention that it
> > > > > should go to all -stable trees?
> > > > 
> > > > I'm not sure how easy it is to apply this patch on past stable versions.
> > > > Maybe something simpler for stable like always flushing the cache in
> > > > flush_kernel_dcache_page() with optimisation only in recent stable
> > > > versions.
> > > 
> > > Looking at how to adapt the change to previous kernel versions, it
> > > occurred to me that we could probably simplify the current patch
> > > since we can make stronger assumptions than __flush_dcache_page()
> > > can do. As discussed, __flush_dcache_page() does:
> > > 
> > >                         addr = kmap_high_get(page);
> > >                         if (addr) {
> > >                                 __cpuc_flush_dcache_area(addr, PAGE_SIZE);
> > >                                 kunmap_high(page);
> > >                         }
> > > 
> > > The kmap_high_get() is used to ensure that the page is/remains pinned
> > > during the flush.  However, the API of flush_kernel_dcache_page()
> > > ensures that the page is already kmapped when it is called (as in the
> > > quoted example above).
> > > 
> > > Thus, it is already pinned and we can simply look at page_address(). 
> > > If it is NULL, the page must have been obtained via kmap_atomic() and
> > > we don't need to flush anyway since kunmap_atomic() will do this. 
> > > 
> > > The actual flush covering both the lowmem and highmem cases actually
> > > is as simple as this (inspired by __flush_dcache_page() in 2.6.32):
> > > 
> > > 	addr = page_address(page);
> > > #ifdef CONFIG_HIGHMEM
> > > 	/*
> > > 	 * kmap_atomic() doesn't set the page virtual address, and
> > > 	 * kunmap_atomic() takes care of cache flushing already.
> > > 	 */
> > > 	if (addr)
> > > #endif
> > > 		__cpuc_flush_dcache_area(addr, PAGE_SIZE);
> > > 
> > > If you agree that this makes sense, I will send a new version.
> > > 
> > > If we change the patch this way, there is no need to split off
> > > __flush_kernel_dcache_page() from __flush_dcache_page(), which also
> > > makes it simpler to apply to past stable kernels.
> > > 
> > > The only thing we need to be aware of is the change of
> > > flush_kernel_dcache_page() in 2.6.37 (commit f8b63c1).  In earlier
> > > versions, we would only need to fix the highmem case.  However, I
> > > wonder whether it makes sense to apply a fix to 2.6.32 and 2.6.34
> > > without this ever being reported as a problem.
> > 
> > imho, if you discover a problem while running kernel v3.9.x, and the
> > commit causing the problem goes all the way back to 2.6.32, then the fix
> > should go back that far as well (assuming those kernels are still
> > actively maintained).  I don't think we would need a bug report for each
> > kernel version.
> > 
> > However, some more nuanced problems are not the result of a single
> > commit, but potentially the interaction of several commits.  In this
> > case, a more conservative application may be in order.
> > 
> > Greg, any thoughts?

If a patch needs to be backported to stable kernels, and it isn't
relevant at _all_ for Linus's tree due to it being fixed some other way
that is not backportable, then I can accept the patch into the stable
releases.

Otherwise, just send me the git commit ids of the fix in Linus's tree to
the stable at vger.kernel.org mailing list please.

thanks,

greg k-h
