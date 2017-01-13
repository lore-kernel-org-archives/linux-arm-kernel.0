From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 13 Jan 2017 11:39:15 +0000
Subject: [PATCH v29 3/9] arm64: kdump: reserve memory for crash dump kernel
In-Reply-To: <20170113081617.GI20972@linaro.org>
References: <20161228043347.27358-1-takahiro.akashi@linaro.org>
 <20161228043605.27470-2-takahiro.akashi@linaro.org>
 <20170112150926.GA12249@leverpostej>
 <20170113081617.GI20972@linaro.org>
Message-ID: <20170113113914.GB26804@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 13, 2017 at 05:16:18PM +0900, AKASHI Takahiro wrote:
> On Thu, Jan 12, 2017 at 03:09:26PM +0000, Mark Rutland wrote:
> > > +static int __init export_crashkernel(void)

> > > +	/* Add /chosen/linux,crashkernel-* properties */

> > > +	of_remove_property(node, of_find_property(node,
> > > +				"linux,crashkernel-base", NULL));
> > > +	of_remove_property(node, of_find_property(node,
> > > +				"linux,crashkernel-size", NULL));
> > > +
> > > +	ret = of_add_property(node, &crash_base_prop);
> > > +	if (ret)
> > > +		goto ret_err;
> > > +
> > > +	ret = of_add_property(node, &crash_size_prop);
> > > +	if (ret)
> > > +		goto ret_err;

> > I very much do not like this.
> > 
> > I don't think we should be modifying the DT exposed to userspace in this
> > manner, in the usual boot path, especially given that the kernel itself
> > does not appear to be a consumer of this property. I do not think that
> > it is right to use the DT exposed to userspace as a communication
> > channel solely between the kernel and userspace.
> 
> As you mentioned in your comments against my patch#9, this property
> originates from PPC implementation.
> I added it solely from the sympathy for dt-based architectures.
>
> > So I think we should drop the above, and for arm64 have userspace
> > consistently use /proc/iomem (or perhaps a new kexec-specific file) to
> > determine the region reserved for the crash kernel, if it needs to know
> > this.
> 
> As a matter of fact, my port of kexec-tools doesn't check this property
> and dropping it won't cause any problem.

Ok. It sounds like we're both happy for this to go, then.

While it's unfortunate that architectures differ, I think we have
legitimate reasons to differ, and it's preferable to do so. We have a
different set of constraints (e.g. supporting EFI memory maps), and
following the PPC approach creates longer term issues for us, making it
harder to do the right thing consistently.

> > > +/*
> > > + * reserve_crashkernel() - reserves memory for crash kernel
> > > + *
> > > + * This function reserves memory area given in "crashkernel=" kernel command
> > > + * line parameter. The memory reserved is used by dump capture kernel when
> > > + * primary kernel is crashing.
> > > + */
> > > +static void __init reserve_crashkernel(void)

> > > +	memblock_reserve(crash_base, crash_size);
> > 
> > This will mean that the crash kernel will have a permanent alias in the linear
> > map which is vulnerable to being clobbered. There could also be issues
> > with mismatched attributes in future.
> 
> Good point, I've never thought of that except making the memblock
> region "reserved."
> 
> > We're probably ok for now, but in future we'll likely want to fix this
> > up to remove the region (or mark it nomap), and only map it temporarily
> > when loading things into the region.
> 
> Well, I found that the following commit is already in:
>         commit 9b492cf58077
>         Author: Xunlei Pang <xlpang@redhat.com>
>         Date:   Mon May 23 16:24:10 2016 -0700
> 
>             kexec: introduce a protection mechanism for the crashkernel
>             reserved memory
> 
> To make best use of this framework, I'd like to re-use set_memory_ro/rx()
> instead of removing the region from linear mapping. But to do so,
> we need to
> * make memblock_isolate_range() global,
> * allow set_memory_ro/rx() to be applied to regions in linear mapping
> since set_memory_ro/rx() works only on page-level mappings.
> 
> What do you think?
> (See my tentative solution below.)

Great! I think it would be better to follow the approach of
mark_rodata_ro(), rather than opening up set_memory_*(), but otherwise,
it looks like it should work.

Either way, this still leaves us with an RO alias on crashed cores (and
potential cache attribute mismatches in future). Do we need to read from
the region later, or could we unmap it entirely?

Thanks,
Mark.

> ===8<===
> diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
> index c0fc3d458195..bb21c0473b8e 100644
> --- a/arch/arm64/kernel/machine_kexec.c
> +++ b/arch/arm64/kernel/machine_kexec.c
> @@ -211,6 +211,44 @@ void machine_kexec(struct kimage *kimage)
>  	BUG(); /* Should never get here. */
>  }
>  
> +static int kexec_mark_range(unsigned long start, unsigned long end,
> +							bool protect)
> +{
> +	unsigned int nr_pages;
> +
> +	if (!end || start >= end)
> +		return 0;
> +
> +	nr_pages = (end >> PAGE_SHIFT) - (start >> PAGE_SHIFT) + 1;
> +
> +	if (protect)
> +		return set_memory_ro(__phys_to_virt(start), nr_pages);
> +	else
> +		return set_memory_rw(__phys_to_virt(start), nr_pages);
> +}
> +
> +static void kexec_mark_crashkres(bool protect)
> +{
> +	unsigned long control;
> +
> +	/* Don't touch the control code page used in crash_kexec().*/
> +	control = page_to_phys(kexec_crash_image->control_code_page);
> +	kexec_mark_range(crashk_res.start, control - 1, protect);
> +
> +	control += KEXEC_CONTROL_PAGE_SIZE;
> +	kexec_mark_range(control, crashk_res.end, protect);
> +}
> +
> +void arch_kexec_protect_crashkres(void)
> +{
> +	kexec_mark_crashkres(true);
> +}
> +
> +void arch_kexec_unprotect_crashkres(void)
> +{
> +	kexec_mark_crashkres(false);
> +}
> +
>  static void machine_kexec_mask_interrupts(void)
>  {
>  	unsigned int i;
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 569ec3325bc8..764ec89c4f76 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -90,6 +90,7 @@ early_param("initrd", early_initrd);
>  static void __init reserve_crashkernel(void)
>  {
>  	unsigned long long crash_size, crash_base;
> +	int start_rgn, end_rgn;
>  	int ret;
>  
>  	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
> @@ -121,6 +122,9 @@ static void __init reserve_crashkernel(void)
>  		}
>  	}
>  	memblock_reserve(crash_base, crash_size);
> +	memblock_isolate_range(&memblock.memory, crash_base, crash_size,
> +			&start_rgn, &end_rgn);
> +
>  
>  	pr_info("Reserving %lldMB of memory at %lldMB for crashkernel\n",
>  		crash_size >> 20, crash_base >> 20);
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 17243e43184e..0f60f19c287b 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -22,6 +22,7 @@
>  #include <linux/kernel.h>
>  #include <linux/errno.h>
>  #include <linux/init.h>
> +#include <linux/kexec.h>
>  #include <linux/libfdt.h>
>  #include <linux/mman.h>
>  #include <linux/nodemask.h>
> @@ -362,6 +363,17 @@ static void __init __map_memblock(pgd_t *pgd, phys_addr_t start, phys_addr_t end
>  	unsigned long kernel_start = __pa(_text);
>  	unsigned long kernel_end = __pa(__init_begin);
>  
> +#ifdef CONFIG_KEXEC_CORE
> +	if (crashk_res.end && start >= crashk_res.start &&
> +			end <= (crashk_res.end + 1)) {
> +		__create_pgd_mapping(pgd, start, __phys_to_virt(start),
> +				     end - start, PAGE_KERNEL,
> +				     early_pgtable_alloc,
> +				     true);
> +		return;
> +	}
> +#endif
> +
>  	/*
>  	 * Take care not to create a writable alias for the
>  	 * read-only text and rodata sections of the kernel image.
> ===>8===
