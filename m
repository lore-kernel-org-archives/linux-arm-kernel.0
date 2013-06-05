From: gmbnomis@gmail.com (Simon Baatz)
Date: Wed, 5 Jun 2013 21:55:55 +0200
Subject: [PATCH V4] ARM: handle user space mapped pages in
 flush_kernel_dcache_page
In-Reply-To: <20130605135817.GL8758@arm.com>
References: <1368336956-6693-1-git-send-email-gmbnomis@gmail.com>
 <20130529110508.GH17767@MacBook-Pro.local>
 <20130529191657.GA13047@schnuecks.de>
 <20130530164335.GK23631@arm.com>
 <20130531120519.GB3803@titan.lakedaemon.net>
 <20130531141508.GB15551@arm.com>
 <20130603173817.GA32211@schnuecks.de>
 <20130605135817.GL8758@arm.com>
Message-ID: <20130605195555.GA16341@schnuecks.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 05, 2013 at 02:58:17PM +0100, Catalin Marinas wrote:
> On Mon, Jun 03, 2013 at 06:38:18PM +0100, Simon Baatz wrote:
...
> > The actual flush covering both the lowmem and highmem cases actually
> > is as simple as this (inspired by __flush_dcache_page() in 2.6.32):
> > 
> > 	addr = page_address(page);
> > #ifdef CONFIG_HIGHMEM
> > 	/*
> > 	 * kmap_atomic() doesn't set the page virtual address, and
> > 	 * kunmap_atomic() takes care of cache flushing already.
> > 	 */
> > 	if (addr)
> > #endif
> > 		__cpuc_flush_dcache_area(addr, PAGE_SIZE);
> > 
> > If you agree that this makes sense, I will send a new version.
> 
> It makes sense (with the addition of the cache_is_vivt() check). Maybe
> something like
> 
> 	if (IS_ENABLED(CONFIG_HIGHMEM) && addr)
> 
> to avoid the #ifdef.

Yes, IS_ENABLED is much nicer. However, IS_ENABLED apparently is not
available for <= 3.0.x. :-(
 
> > If we change the patch this way, there is no need to split off
> > __flush_kernel_dcache_page() from __flush_dcache_page(), which also
> > makes it simpler to apply to past stable kernels.
> > 
> > The only thing we need to be aware of is the change of
> > flush_kernel_dcache_page() in 2.6.37 (commit f8b63c1).  In earlier
> > versions, we would only need to fix the highmem case.  However, I
> > wonder whether it makes sense to apply a fix to 2.6.32 and 2.6.34
> > without this ever being reported as a problem.
> 
> I think you can cc stable with a dependency for 2.6.37 onwards and send
> a different patch for earlier versions directly to the
> stable at vger.kernel.org alias, specifying the versions it needs to be
> applied to.

Ok. Next version of the patch then for >= 3.2.x. 3.0.x is special (#ifdef).

2.6.3[24].x are special anyway. However, for the latter I still
wonder whether this makes sense. "stable_kernel_rules.txt" states:

 - It must fix a real bug that bothers people (not a, "This could be a
   problem..." type thing).

I don't know anyone who is/was bothered by the higmem bug. 

(Btw. I verified that the highmem problem is really there (using
current linux-next) and is fixed by the proposed patch.)

- Simon
