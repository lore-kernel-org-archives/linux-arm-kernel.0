From: fujita.tomonori@lab.ntt.co.jp (FUJITA Tomonori)
Date: Tue, 20 Jul 2010 18:56:37 +0900
Subject: [PATCH 0/3] Cache maintenance on VIPT caches
In-Reply-To: <1279291157.17878.49.camel@e102109-lin.cambridge.arm.com>
References: <20100625115826.30030.89790.stgit@e102109-lin.cambridge.arm.com>
	<20100716131908.GA15032@bnru02.bnr.st.com>
	<1279291157.17878.49.camel@e102109-lin.cambridge.arm.com>
Message-ID: <20100720185611I.fujita.tomonori@lab.ntt.co.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc'ed to linux-arch

On Fri, 16 Jul 2010 15:39:17 +0100
Catalin Marinas <catalin.marinas@arm.com> wrote:

> On Fri, 2010-07-16 at 14:19 +0100, Rabin VINCENT wrote:
> > On Fri, Jun 25, 2010 at 14:01:27 +0200, Catalin Marinas wrote:
> > > The first and third patches have already been posted in the same form.
> > > The second patch have been modified to handle all the VIPT caches via
> > > __sync_icache_dcache(). The initial use case for this patch was dealing
> > > with an SMP race condition but following suggestions from Rabin, it was
> > > extended to cover ARMv6 onwards, both UP and SMP.
> > >
> > > Any Tested-by's are welcome.
> > 
> > This version also fixes the MMC rootfs init crashes, without the need
> > for the flush_kernel_dcache_page() change:
> > 
> > Tested-by: Rabin Vincent <rabin.vincent@stericsson.com>
> 
> Thanks for testing.

This patchset for arm handles I/D coherency (and D aliasing) with
PG_arch_1, right? If so, can you please send it to linux-arch? I guess
that some non arm people might be interested in it.


> > I ask because the
> > mmci patches that I posted convert that driver to use the sg_miter API
> > (which uses flush_kernel_dcache_page() internally), and not do any
> > flushing inside the driver itself.  Or do you think it would be
> > appropriate to have the driver call flush_dcache_page() explicitly?
> > (Although this would be double flushing on systems with aliasing caches
> > where flush_kernel_dcache_page() is not a no-op.)
> 
> I'm not sure why sg_miter doesn't call flush_dcache_page() but
> flush_kernel_dcache_page() (I cc'ed Fujita as he seems to have added
> this code).

It is intended to handle D aliasing due to kmap. As cachetlb.txt says
that it is assumed here that the user has no incoherent cached copies
(it was already addressed elsewhere). So flush_dcache_page() does too
much there.
