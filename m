From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 20 Jul 2010 12:42:52 +0100
Subject: [PATCH 0/3] Cache maintenance on VIPT caches
In-Reply-To: <1279625820.10002.16.camel@e102109-lin.cambridge.arm.com>
References: <20100625115826.30030.89790.stgit@e102109-lin.cambridge.arm.com>
	<20100716131908.GA15032@bnru02.bnr.st.com>
	<1279291157.17878.49.camel@e102109-lin.cambridge.arm.com>
	<20100720185611I.fujita.tomonori@lab.ntt.co.jp>
	<1279625820.10002.16.camel@e102109-lin.cambridge.arm.com>
Message-ID: <1279626172.10002.20.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2010-07-20 at 12:37 +0100, Catalin Marinas wrote:
> On Tue, 2010-07-20 at 18:56 +0900, FUJITA Tomonori wrote:
> > On Fri, 16 Jul 2010 15:39:17 +0100
> > Catalin Marinas <catalin.marinas@arm.com> wrote:
> >
> > > On Fri, 2010-07-16 at 14:19 +0100, Rabin VINCENT wrote:
> > > > I ask because the
> > > > mmci patches that I posted convert that driver to use the sg_miter API
> > > > (which uses flush_kernel_dcache_page() internally), and not do any
> > > > flushing inside the driver itself.  Or do you think it would be
> > > > appropriate to have the driver call flush_dcache_page() explicitly?
> > > > (Although this would be double flushing on systems with aliasing caches
> > > > where flush_kernel_dcache_page() is not a no-op.)
> > >
> > > I'm not sure why sg_miter doesn't call flush_dcache_page() but
> > > flush_kernel_dcache_page() (I cc'ed Fujita as he seems to have added
> > > this code).
> >
> > It is intended to handle D aliasing due to kmap. As cachetlb.txt says
> > that it is assumed here that the user has no incoherent cached copies
> > (it was already addressed elsewhere). So flush_dcache_page() does too
> > much there.
> 
> OK. So in this case a PIO driver using sg_miter should still call
> flush_dcache_page() as usual (or not at all as we change the meaning
> PG_arch_1 for the architectures where this matters).

Actually the flush_dcache_page() call in drivers is still useful on SMP
systems where the cache maintenance must happen on the CPU that dirtied
the cache (ARM11MPCore), though I have a workaround for this as well
(doing a 'read-for-ownership' before flushing the D-cache).

-- 
Catalin
