From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 16 Jul 2010 15:39:17 +0100
Subject: [PATCH 0/3] Cache maintenance on VIPT caches
In-Reply-To: <20100716131908.GA15032@bnru02.bnr.st.com>
References: <20100625115826.30030.89790.stgit@e102109-lin.cambridge.arm.com>
	<20100716131908.GA15032@bnru02.bnr.st.com>
Message-ID: <1279291157.17878.49.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2010-07-16 at 14:19 +0100, Rabin VINCENT wrote:
> On Fri, Jun 25, 2010 at 14:01:27 +0200, Catalin Marinas wrote:
> > The first and third patches have already been posted in the same form.
> > The second patch have been modified to handle all the VIPT caches via
> > __sync_icache_dcache(). The initial use case for this patch was dealing
> > with an SMP race condition but following suggestions from Rabin, it was
> > extended to cover ARMv6 onwards, both UP and SMP.
> >
> > Any Tested-by's are welcome.
> 
> This version also fixes the MMC rootfs init crashes, without the need
> for the flush_kernel_dcache_page() change:
> 
> Tested-by: Rabin Vincent <rabin.vincent@stericsson.com>

Thanks for testing.

> Will you be submitting this patch for linux-next?  

I'd like to but I'm still waiting for Russell's feedback (the linux-next
rules are that we shouldn't dump patches there that haven't been
reviewed yet).

> I ask because the
> mmci patches that I posted convert that driver to use the sg_miter API
> (which uses flush_kernel_dcache_page() internally), and not do any
> flushing inside the driver itself.  Or do you think it would be
> appropriate to have the driver call flush_dcache_page() explicitly?
> (Although this would be double flushing on systems with aliasing caches
> where flush_kernel_dcache_page() is not a no-op.)

I'm not sure why sg_miter doesn't call flush_dcache_page() but
flush_kernel_dcache_page() (I cc'ed Fujita as he seems to have added
this code).

Anyway, we could actually set the PG_dcache_clean bit in
flush_kernel_dcache_page() and thus avoid additional flushing when the
page gets mapped to user space (on VIPT non-aliasing caches).

I think it's fine for your driver not to call flush_dcache_page() as
long as a form of page flushing is done in the sg_miter API. The only
thing we miss is ARM11MPCore with VIPT non-aliasing caches where
flush_kernel_dcache_page() is a no-op, though we have to do non-lazy
flushing because the cache maintenance operations aren't broadcast to
the other CPUs.

There are several places where we can fix this - (1) implement
flush_kernel_dcache_page() for ARM11MPCore, (2) use flush_dcache_page()
in the sg_miter code or (3) call flush_dcache_page() in the mmci driver.

-- 
Catalin
