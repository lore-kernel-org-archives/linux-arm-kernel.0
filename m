From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Fri, 3 Feb 2017 10:45:39 +0900
Subject: [PATCH v31 05/12] arm64: kdump: protect crash dump kernel memory
In-Reply-To: <20170202115425.GJ31394@leverpostej>
References: <20170201124218.5823-1-takahiro.akashi@linaro.org>
 <20170201124630.6016-4-takahiro.akashi@linaro.org>
 <20170201180008.GG4756@leverpostej>
 <20170201182506.GA30584@leverpostej>
 <20170202103905.GF13549@linaro.org>
 <20170202115425.GJ31394@leverpostej>
Message-ID: <20170203014538.GA29585@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark,

On Thu, Feb 02, 2017 at 11:54:25AM +0000, Mark Rutland wrote:
> On Thu, Feb 02, 2017 at 07:39:06PM +0900, AKASHI Takahiro wrote:
> > Mark,
> > 
> > On Wed, Feb 01, 2017 at 06:25:06PM +0000, Mark Rutland wrote:
> > > On Wed, Feb 01, 2017 at 06:00:08PM +0000, Mark Rutland wrote:
> > > > On Wed, Feb 01, 2017 at 09:46:24PM +0900, AKASHI Takahiro wrote:
> > > > > arch_kexec_protect_crashkres() and arch_kexec_unprotect_crashkres()
> > > > > are meant to be called around kexec_load() in order to protect
> > > > > the memory allocated for crash dump kernel once after it's loaded.
> > > > > 
> > > > > The protection is implemented here by unmapping the region rather than
> > > > > making it read-only.
> > > > > To make the things work correctly, we also have to
> > > > > - put the region in an isolated, page-level mapping initially, and
> > > > > - move copying kexec's control_code_page to machine_kexec_prepare()
> > > > > 
> > > > > Note that page-level mapping is also required to allow for shrinking
> > > > > the size of memory, through /sys/kernel/kexec_crash_size, by any number
> > > > > of multiple pages.
> > > > 
> > > > Looking at kexec_crash_size_store(), I don't see where memory returned
> > > > to the OS is mapped. AFAICT, if the region is protected when the user
> > > > shrinks the region, the memory will not be mapped, yet handed over to
> > > > the kernel for general allocation.
> > > > 
> > > > Surely we need an arch-specific callback to handle that? e.g.
> > > > 
> > > > arch_crash_release_region(unsigned long base, unsigned long size)
> > > > {
> > > > 	/*
> > > > 	 * Ensure the region is part of the linear map before we return
> > > > 	 * it to the OS. We won't unmap this again, so we can use block
> > > > 	 * mappings.
> > > > 	 */
> > > > 	create_pgd_mapping(&init_mm, start, __phys_to_virt(start),
> > > > 			   size, PAGE_KERNEL, false);
> > > > }
> > > > 
> > > > ... which we'd call from crash_shrink_memory() before we freed the
> > > > reserved pages.
> > > 
> > > Another question is (how) does hyp map this region?
> > 
> > I don't get your point here.
> > Hyp mode does care only physical memory in intermediate address, doesn't it?
> 
> My concern was that hyp may map the region; and thus buggy code at hyp
> can corrupt the region (and/or hyp may conflict w.r.t. attributes).

Grep'ing create_hyp_mappings() under arch/arm(64)/kvm shows that
we have only a few small regions of memory mapped in hyp mode.
I also confirmed that there is no active mapping for crash dump kernel
memory by checking mmu tables with DS-5 debugger.

> We mght have to ensure hyp doesn't map the crashkernel region, and to
> case us pain, disallow freeing of any part of the region.

So I don't believe we need to worry such a case.

Thanks,
-Takahiro AKASHI

> I'll dig into this.
> 
> Thanks,
> Mark.
> 
> > If this is not a matter now, I will post v32 tomorrow :)
> > 
> > -Takahiro AKASHI
> > 
> > 
> > > Thanks,
> > > Mark.
