From: james.morse@arm.com (James Morse)
Date: Fri, 11 Mar 2016 11:37:54 +0000
Subject: [PATCH v14 12/20] arm64/kexec: Add core kexec support
In-Reply-To: <cdab8a2001a9f8beb605bfcd565201c37dad78e6.1457135058.git.geoff@infradead.org>
References: <cover.1457135058.git.geoff@infradead.org>
 <cdab8a2001a9f8beb605bfcd565201c37dad78e6.1457135058.git.geoff@infradead.org>
Message-ID: <56E2AE12.4020604@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geoff,

On 04/03/16 23:51, Geoff Levand wrote:
> Add three new files, kexec.h, machine_kexec.c and relocate_kernel.S to the
> arm64 architecture that add support for the kexec re-boot mechanism
> (CONFIG_KEXEC) on arm64 platforms.
> 
> Signed-off-by: Geoff Levand <geoff@infradead.org>

> diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
> new file mode 100644
> index 0000000..6fd0f0c
> --- /dev/null
> +++ b/arch/arm64/kernel/machine_kexec.c

[ ... snip ... ]

> +/**
> + * kexec_list_flush - Helper to flush the kimage list to PoC.
> + */
> +static void kexec_list_flush(struct kimage *kimage)
> +{
> +	kimage_entry_t *entry;
> +	unsigned int flag;
> +
> +	for (entry = &kimage->head, flag = 0; flag != IND_DONE; entry++) {
> +		void *addr = kmap(phys_to_page(*entry & PAGE_MASK));

Isn't kmap() only needed for highmem? All memory should be accessible via the
linear map, so this could just be a call to phys_to_virt(), without the
intermediate page step.


> +
> +		flag = *entry & IND_FLAGS;
> +
> +		switch (flag) {
> +		case IND_INDIRECTION:
> +			entry = (kimage_entry_t *)addr - 1;
> +			__flush_dcache_area(addr, PAGE_SIZE);
> +			break;
> +		case IND_DESTINATION:
> +			break;
> +		case IND_SOURCE:
> +			__flush_dcache_area(addr, PAGE_SIZE);
> +			break;
> +		case IND_DONE:
> +			break;
> +		default:
> +			BUG();
> +		}
> +		kunmap(addr);
> +	}
> +}
> +
> +/**
> + * kexec_segment_flush - Helper to flush the kimage segments to PoC.
> + */
> +static void kexec_segment_flush(const struct kimage *kimage)
> +{
> +	unsigned long i;
> +
> +	pr_devel("%s:\n", __func__);
> +
> +	for (i = 0; i < kimage->nr_segments; i++) {
> +		pr_devel("  segment[%lu]: %016lx - %016lx, %lx bytes, %lu pages\n",
> +			i,
> +			kimage->segment[i].mem,
> +			kimage->segment[i].mem + kimage->segment[i].memsz,
> +			kimage->segment[i].memsz,
> +			kimage->segment[i].memsz /  PAGE_SIZE);
> +
> +		__flush_dcache_area(phys_to_virt(kimage->segment[i].mem),
> +			kimage->segment[i].memsz);
> +	}
> +}
> +
> +/**
> + * machine_kexec - Do the kexec reboot.
> + *
> + * Called from the core kexec code for a sys_reboot with LINUX_REBOOT_CMD_KEXEC.
> + */
> +void machine_kexec(struct kimage *kimage)
> +{
> +	phys_addr_t reboot_code_buffer_phys;
> +	void *reboot_code_buffer;
> +
> +	BUG_ON(num_online_cpus() > 1);
> +
> +	reboot_code_buffer_phys = page_to_phys(kimage->control_code_page);
> +	reboot_code_buffer = kmap(kimage->control_code_page);

page_address()?


> +
> +	/*
> +	 * Copy arm64_relocate_new_kernel to the reboot_code_buffer for use
> +	 * after the kernel is shut down.
> +	 */
> +	memcpy(reboot_code_buffer, arm64_relocate_new_kernel,
> +		arm64_relocate_new_kernel_size);
> +
> +	/* Flush the reboot_code_buffer in preparation for its execution. */
> +	__flush_dcache_area(reboot_code_buffer, arm64_relocate_new_kernel_size);
> +	flush_icache_range((uintptr_t)reboot_code_buffer,
> +		arm64_relocate_new_kernel_size);
> +
> +	/* Flush the kimage list. */
> +	kexec_list_flush(kimage);
> +
> +	/* Flush the new image if already in place. */
> +	if (kimage->head & IND_DONE)
> +		kexec_segment_flush(kimage);
> +
> +	pr_info("Bye!\n");
> +
> +	/* Disable all DAIF exceptions. */
> +	asm volatile ("msr daifset, #0xf" : : : "memory");
> +
> +	cpu_install_idmap();
> +
> +	/*
> +	 * cpu_soft_restart will shutdown the MMU, disable data caches, then
> +	 * transfer control to the reboot_code_buffer which contains a copy of
> +	 * the arm64_relocate_new_kernel routine.  arm64_relocate_new_kernel
> +	 * uses physical addressing to relocate the new image to its final
> +	 * position and transfers control to the image entry point when the
> +	 * relocation is complete.
> +	 */
> +
> +	cpu_soft_restart(is_hyp_mode_available(),
> +		reboot_code_buffer_phys, kimage->head, kimage_start, 0);
> +
> +	BUG(); /* Should never get here. */
> +}
> +
> +void machine_crash_shutdown(struct pt_regs *regs)
> +{
> +	/* Empty routine needed to avoid build errors. */
> +}

Thanks!

James
