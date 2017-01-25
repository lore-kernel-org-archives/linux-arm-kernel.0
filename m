From: james.morse@arm.com (James Morse)
Date: Wed, 25 Jan 2017 17:37:38 +0000
Subject: [PATCH v30 05/11] arm64: kdump: protect crash dump kernel memory
In-Reply-To: <20170124085004.3892-4-takahiro.akashi@linaro.org>
References: <20170124084638.3770-1-takahiro.akashi@linaro.org>
 <20170124085004.3892-4-takahiro.akashi@linaro.org>
Message-ID: <5888E262.4050208@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Akashi,

On 24/01/17 08:49, AKASHI Takahiro wrote:
> To protect the memory reserved for crash dump kernel once after loaded,
> arch_kexec_protect_crashres/unprotect_crashres() are meant to deal with
> permissions of the corresponding kernel mappings.
> 
> We also have to
> - put the region in an isolated mapping, and
> - move copying kexec's control_code_page to machine_kexec_prepare()
> so that the region will be completely read-only after loading.


> Note that the region must reside in linear mapping and have corresponding
> page structures in order to be potentially freed by shrinking it through
> /sys/kernel/kexec_crash_size.

Nasty! Presumably you have to build the crash region out of individual page
mappings so that they can be returned to the slab-allocator one page at a time,
and still be able to set/clear the valid bits on the remaining chunk.
(I don't see how that happens in this patch)

debug_pagealloc has to do this too so it can flip the valid bits one page at a
time. You could change the debug_pagealloc_enabled() value passed in at the top
__create_pgd_mapping() level to be a needs_per_page_mapping(addr, size) test
that happens as we build the linear map. (This would save the 3 extra calls to
__create_pgd_mapping() in __map_memblock())

I'm glad to see you can't resize the region if a crash kernel is loaded!

This secretly-unmapped is the sort of thing that breaks hibernate, it blindly
assumes pfn_valid() means it can access the page if it wants to. Setting
PG_Reserved is a quick way to trick it out of doing this, but that would leave
the crash kernel region un-initialised after resume, while kexec_crash_image
still has a value.
I think the best fix for this is to forbid hibernate if kexec_crash_loaded()
arguing these are mutually-exclusive features, and the protect crash-dump
feature exists to prevent things like hibernate corrupting the crash region.


> diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
> index bc96c8a7fc79..f7938fecf3ff 100644
> --- a/arch/arm64/kernel/machine_kexec.c
> +++ b/arch/arm64/kernel/machine_kexec.c
> @@ -159,32 +171,20 @@ void machine_kexec(struct kimage *kimage)
>  		kimage->control_code_page);
>  	pr_debug("%s:%d: reboot_code_buffer_phys:  %pa\n", __func__, __LINE__,
>  		&reboot_code_buffer_phys);
> -	pr_debug("%s:%d: reboot_code_buffer:       %p\n", __func__, __LINE__,
> -		reboot_code_buffer);
>  	pr_debug("%s:%d: relocate_new_kernel:      %p\n", __func__, __LINE__,
>  		arm64_relocate_new_kernel);
>  	pr_debug("%s:%d: relocate_new_kernel_size: 0x%lx(%lu) bytes\n",
>  		__func__, __LINE__, arm64_relocate_new_kernel_size,
>  		arm64_relocate_new_kernel_size);
>  
> -	/*
> -	 * Copy arm64_relocate_new_kernel to the reboot_code_buffer for use
> -	 * after the kernel is shut down.
> -	 */
> -	memcpy(reboot_code_buffer, arm64_relocate_new_kernel,
> -		arm64_relocate_new_kernel_size);
> -
> -	/* Flush the reboot_code_buffer in preparation for its execution. */
> -	__flush_dcache_area(reboot_code_buffer, arm64_relocate_new_kernel_size);
> -	flush_icache_range((uintptr_t)reboot_code_buffer,
> -		arm64_relocate_new_kernel_size);



> -	/* Flush the kimage list and its buffers. */
> -	kexec_list_flush(kimage);
> +	if (kimage != kexec_crash_image) {
> +		/* Flush the kimage list and its buffers. */
> +		kexec_list_flush(kimage);
>  
> -	/* Flush the new image if already in place. */
> -	if (kimage->head & IND_DONE)
> -		kexec_segment_flush(kimage);
> +		/* Flush the new image if already in place. */
> +		if (kimage->head & IND_DONE)
> +			kexec_segment_flush(kimage);
> +	}

So for kdump we cleaned the kimage->segment[i].mem regions in
arch_kexec_protect_crashkres(), so don't need to do it here.

What about the kimage->head[i] array of list entries that were cleaned by
kexec_list_flush()? Now we don't clean that for kdump either, but we do pass it
arm64_relocate_new_kernel() at the end of this function:
> cpu_soft_restart(1, reboot_code_buffer_phys, kimage->head, kimage_start, 0);

Can we test the IND_DONE_BIT of kimage->head, so that we know that
arm64_relocate_new_kernel() won't try to walk the unclean list?
Alternatively we could call kexec_list_flush() in arch_kexec_protect_crashkres()
too.



Thanks,

James
