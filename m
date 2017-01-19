From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Thu, 19 Jan 2017 18:49:42 +0900
Subject: [PATCH v29 3/9] arm64: kdump: reserve memory for crash dump kernel
In-Reply-To: <20170117115441.GC11939@leverpostej>
References: <20161228043347.27358-1-takahiro.akashi@linaro.org>
 <20161228043605.27470-2-takahiro.akashi@linaro.org>
 <20170112150926.GA12249@leverpostej>
 <20170113081617.GI20972@linaro.org>
 <20170113113914.GB26804@leverpostej>
 <20170117082043.GM20972@linaro.org>
 <20170117115441.GC11939@leverpostej>
Message-ID: <20170119094941.GP20972@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 17, 2017 at 11:54:42AM +0000, Mark Rutland wrote:
> On Tue, Jan 17, 2017 at 05:20:44PM +0900, AKASHI Takahiro wrote:
> > On Fri, Jan 13, 2017 at 11:39:15AM +0000, Mark Rutland wrote:
> > > Great! I think it would be better to follow the approach of
> > > mark_rodata_ro(), rather than opening up set_memory_*(), but otherwise,
> > > it looks like it should work.
> > 
> > I'm not quite sure what the approach of mark_rodata_ro() means, but
> > I found that using create_mapping_late() may cause two problems:
> > 
> > 1) it fails when PTE_CONT bits mismatch between an old and new mmu entry.
> >    This can happen, say, if the memory range for crash dump kernel
> >    starts in the mid of _continuous_ pages.
> 
> That should only happen if we try to remap a segment different to what
> we originally mapped.
> 
> I was intending that we'd explicitly map the reserved region separately
> in the boot path, like we do for kernel segments in map_kernel(). We
> would allow sections and/or CONT entires. 
> 
> Then, in __map_memblock() we'd then skip that range as we do for the
> linear map alias of the kernel image.
> 
> That way, we can later use create_mapping_late for that same region, and
> it should handle sections and/or CONT entries in the exact same way as
> it does for the kernel image segments in mark_rodata_ro().

I see.
Which one do you prefer, yours above or my (second) solution?
Either way, they do almost the same thing in terms of mapping.

> > 2) The control code page, of one-page size, is still written out in
> >    machine_kexec() which is called at a crash, and this means that
> >    the range must be writable even after kexec_load(), but
> >    create_mapping_late() does not handle a case of changing attributes
> >    for a single page which is in _section_ mapping.
> >    We cannot make single-page mapping for the control page since the address
> >    of that page is not determined at the boot time.
> 
> That is a problem. I'm not sure I follow how set_memory_*() helps here
> though?
> 
> > As for (1), we need to call memblock_isolate_range() to make the region
> > an independent one.
> > 
> > > Either way, this still leaves us with an RO alias on crashed cores (and
> > > potential cache attribute mismatches in future). Do we need to read from
> > > the region later,
> > 
> > I believe not, but the region must be _writable_ as I mentioned in (2) above.
> > To avoid this issue, we have to move copying the control code page
> > to machine_kexec_prepare() which is called in kexec_load() and so
> > the region is writable anyway then.
> > I want Geoff to affirm that this change is safe.
> > 
> > (See my second solution below.)
> 
> From a quick scan that looks ok.
> 
> > > or could we unmap it entirely?
> > 
> > given the change above, I think we can.

I'm now asking Geoff ...

> 
> Great!
>
> > Is there any code to re-use especially for unmapping?
> 
> I don't think we have much code useful for unmapping. We could re-use 
> create_mapping_late for this, passing a set of prot bits that means the
> entries are invalid (e.g. have a PAGE_KERNEL_INVALID).

Do you really think that we should totally invalidate mmu entries?
I guess that, given proper cache & TLB flush operations, RO attribute is
good enough for memory consistency, no?
(None accesses the region, as I said, except in the case of re-loading
crash dump kernel though.)

> We'd have to perform the TLB invalidation ourselves, but that shouldn't
> be too painful.

Do we need to invalidate TLBs not only before but also after changing
permission attributes as make_rodata_ro() does?

-Takahiro AKASHI

> Thanks,
> Mark.
> 
> > ===8<===
> > diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
> > index c0fc3d458195..80a52e9aaf73 100644
> > --- a/arch/arm64/kernel/machine_kexec.c
> > +++ b/arch/arm64/kernel/machine_kexec.c
> > @@ -26,8 +26,6 @@
> >  extern const unsigned char arm64_relocate_new_kernel[];
> >  extern const unsigned long arm64_relocate_new_kernel_size;
> >  
> > -static unsigned long kimage_start;
> > -
> >  /**
> >   * kexec_image_info - For debugging output.
> >   */
> > @@ -68,7 +66,7 @@ void machine_kexec_cleanup(struct kimage *kimage)
> >   */
> >  int machine_kexec_prepare(struct kimage *kimage)
> >  {
> > -	kimage_start = kimage->start;
> > +	void *reboot_code_buffer;
> >  
> >  	kexec_image_info(kimage);
> >  
> > @@ -77,6 +75,21 @@ int machine_kexec_prepare(struct kimage *kimage)
> >  		return -EBUSY;
> >  	}
> >  
> > +	reboot_code_buffer =
> > +			phys_to_virt(page_to_phys(kimage->control_code_page));
> > +
> > +	/*
> > +	 * Copy arm64_relocate_new_kernel to the reboot_code_buffer for use
> > +	 * after the kernel is shut down.
> > +	 */
> > +	memcpy(reboot_code_buffer, arm64_relocate_new_kernel,
> > +		arm64_relocate_new_kernel_size);
> > +
> > +	/* Flush the reboot_code_buffer in preparation for its execution. */
> > +	__flush_dcache_area(reboot_code_buffer, arm64_relocate_new_kernel_size);
> > +	flush_icache_range((uintptr_t)reboot_code_buffer,
> > +		arm64_relocate_new_kernel_size);
> > +
> >  	return 0;
> >  }
> >  
> > @@ -147,7 +160,6 @@ static void kexec_segment_flush(const struct kimage *kimage)
> >  void machine_kexec(struct kimage *kimage)
> >  {
> >  	phys_addr_t reboot_code_buffer_phys;
> > -	void *reboot_code_buffer;
> >  
> >  	/*
> >  	 * New cpus may have become stuck_in_kernel after we loaded the image.
> > @@ -156,7 +168,6 @@ void machine_kexec(struct kimage *kimage)
> >  			!WARN_ON(kimage == kexec_crash_image));
> >  
> >  	reboot_code_buffer_phys = page_to_phys(kimage->control_code_page);
> > -	reboot_code_buffer = phys_to_virt(reboot_code_buffer_phys);
> >  
> >  	kexec_image_info(kimage);
> >  
> > @@ -164,26 +175,12 @@ void machine_kexec(struct kimage *kimage)
> >  		kimage->control_code_page);
> >  	pr_debug("%s:%d: reboot_code_buffer_phys:  %pa\n", __func__, __LINE__,
> >  		&reboot_code_buffer_phys);
> > -	pr_debug("%s:%d: reboot_code_buffer:       %p\n", __func__, __LINE__,
> > -		reboot_code_buffer);
> >  	pr_debug("%s:%d: relocate_new_kernel:      %p\n", __func__, __LINE__,
> >  		arm64_relocate_new_kernel);
> >  	pr_debug("%s:%d: relocate_new_kernel_size: 0x%lx(%lu) bytes\n",
> >  		__func__, __LINE__, arm64_relocate_new_kernel_size,
> >  		arm64_relocate_new_kernel_size);
> >  
> > -	/*
> > -	 * Copy arm64_relocate_new_kernel to the reboot_code_buffer for use
> > -	 * after the kernel is shut down.
> > -	 */
> > -	memcpy(reboot_code_buffer, arm64_relocate_new_kernel,
> > -		arm64_relocate_new_kernel_size);
> > -
> > -	/* Flush the reboot_code_buffer in preparation for its execution. */
> > -	__flush_dcache_area(reboot_code_buffer, arm64_relocate_new_kernel_size);
> > -	flush_icache_range((uintptr_t)reboot_code_buffer,
> > -		arm64_relocate_new_kernel_size);
> > -
> >  	/* Flush the kimage list and its buffers. */
> >  	kexec_list_flush(kimage);
> >  
> > @@ -206,7 +203,7 @@ void machine_kexec(struct kimage *kimage)
> >  	 */
> >  
> >  	cpu_soft_restart(kimage != kexec_crash_image,
> > -		reboot_code_buffer_phys, kimage->head, kimage_start, 0);
> > +		reboot_code_buffer_phys, kimage->head, kimage->start, 0);
> >  
> >  	BUG(); /* Should never get here. */
> >  }
> > diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> > index 569ec3325bc8..e4cc170edc0c 100644
> > --- a/arch/arm64/mm/init.c
> > +++ b/arch/arm64/mm/init.c
> > @@ -90,6 +90,7 @@ early_param("initrd", early_initrd);
> >  static void __init reserve_crashkernel(void)
> >  {
> >  	unsigned long long crash_size, crash_base;
> > +	int start_rgn, end_rgn;
> >  	int ret;
> >  
> >  	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
> > @@ -120,6 +121,8 @@ static void __init reserve_crashkernel(void)
> >  			return;
> >  		}
> >  	}
> > +	memblock_isolate_range(&memblock.memory, crash_base, crash_size,
> > +			&start_rgn, &end_rgn);
> >  	memblock_reserve(crash_base, crash_size);
> >  
> >  	pr_info("Reserving %lldMB of memory at %lldMB for crashkernel\n",
> > diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> > index 17243e43184e..b7c75845407a 100644
> > --- a/arch/arm64/mm/mmu.c
> > +++ b/arch/arm64/mm/mmu.c
> > @@ -22,6 +22,8 @@
> >  #include <linux/kernel.h>
> >  #include <linux/errno.h>
> >  #include <linux/init.h>
> > +#include <linux/ioport.h>
> > +#include <linux/kexec.h>
> >  #include <linux/libfdt.h>
> >  #include <linux/mman.h>
> >  #include <linux/nodemask.h>
> > @@ -817,3 +819,27 @@ int pmd_clear_huge(pmd_t *pmd)
> >  	pmd_clear(pmd);
> >  	return 1;
> >  }
> > +
> > +#ifdef CONFIG_KEXEC_CORE
> > +void arch_kexec_protect_crashkres(void)
> > +{
> > +	flush_tlb_all();
> > +
> > +	create_mapping_late(crashk_res.start, __phys_to_virt(crashk_res.start),
> > +			    resource_size(&crashk_res), PAGE_KERNEL_RO);
> > +
> > +	/* flush the TLBs after updating live kernel mappings */
> > +	flush_tlb_all();
> > +}
> > +
> > +void arch_kexec_unprotect_crashkres(void)
> > +{
> > +	flush_tlb_all();
> > +
> > +	create_mapping_late(crashk_res.start, __phys_to_virt(crashk_res.start),
> > +			    resource_size(&crashk_res), PAGE_KERNEL);
> > +
> > +	/* flush the TLBs after updating live kernel mappings */
> > +	flush_tlb_all();
> > +}
> > +#endif
> > ===>8===
