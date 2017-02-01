From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 1 Feb 2017 18:25:06 +0000
Subject: [PATCH v31 05/12] arm64: kdump: protect crash dump kernel memory
In-Reply-To: <20170201180008.GG4756@leverpostej>
References: <20170201124218.5823-1-takahiro.akashi@linaro.org>
 <20170201124630.6016-4-takahiro.akashi@linaro.org>
 <20170201180008.GG4756@leverpostej>
Message-ID: <20170201182506.GA30584@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 01, 2017 at 06:00:08PM +0000, Mark Rutland wrote:
> On Wed, Feb 01, 2017 at 09:46:24PM +0900, AKASHI Takahiro wrote:
> > arch_kexec_protect_crashkres() and arch_kexec_unprotect_crashkres()
> > are meant to be called around kexec_load() in order to protect
> > the memory allocated for crash dump kernel once after it's loaded.
> > 
> > The protection is implemented here by unmapping the region rather than
> > making it read-only.
> > To make the things work correctly, we also have to
> > - put the region in an isolated, page-level mapping initially, and
> > - move copying kexec's control_code_page to machine_kexec_prepare()
> > 
> > Note that page-level mapping is also required to allow for shrinking
> > the size of memory, through /sys/kernel/kexec_crash_size, by any number
> > of multiple pages.
> 
> Looking at kexec_crash_size_store(), I don't see where memory returned
> to the OS is mapped. AFAICT, if the region is protected when the user
> shrinks the region, the memory will not be mapped, yet handed over to
> the kernel for general allocation.
> 
> Surely we need an arch-specific callback to handle that? e.g.
> 
> arch_crash_release_region(unsigned long base, unsigned long size)
> {
> 	/*
> 	 * Ensure the region is part of the linear map before we return
> 	 * it to the OS. We won't unmap this again, so we can use block
> 	 * mappings.
> 	 */
> 	create_pgd_mapping(&init_mm, start, __phys_to_virt(start),
> 			   size, PAGE_KERNEL, false);
> }
> 
> ... which we'd call from crash_shrink_memory() before we freed the
> reserved pages.

Another question is (how) does hyp map this region?

Thanks,
Mark.
