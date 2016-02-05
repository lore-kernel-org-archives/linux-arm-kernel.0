From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 5 Feb 2016 16:26:17 +0000
Subject: [PATCH v4 07/13] arm64: Change cpu_resume() to enable mmu early
 then access sleep_sp by va
In-Reply-To: <1453977766-20907-8-git-send-email-james.morse@arm.com>
References: <1453977766-20907-1-git-send-email-james.morse@arm.com>
 <1453977766-20907-8-git-send-email-james.morse@arm.com>
Message-ID: <20160205162617.GD31547@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi James,

On Thu, Jan 28, 2016 at 10:42:40AM +0000, James Morse wrote:
> By enabling the MMU early in cpu_resume(), the sleep_save_sp and stack can
> be accessed by VA, which avoids the need to convert-addresses and clean to
> PoC on the suspend path.
> 
> MMU setup is shared with the boot path, meaning the swapper_pg_dir is
> restored directly: ttbr1_el1 is no longer saved/restored.
> 
> struct sleep_save_sp is removed, replacing it with a single array of
> pointers.
> 
> cpu_do_{suspend,resume} could be further reduced to not restore: cpacr_el1,
> mdscr_el1, tcr_el1, vbar_el1 and sctlr_el1, all of which are set by
> __cpu_setup(). However these values all contain res0 bits that may be used
> to enable future features.

This patch is a very nice clean-up, a comment below.

I think that for registers like tcr_el1 and sctlr_el1 we should define
a restore mask (to avoid overwriting bits set-up by __cpu_setup), eg
current code that restores the tcr_el1 seems wrong to me, see below.

[...]

> -/*
>   * This hook is provided so that cpu_suspend code can restore HW
>   * breakpoints as early as possible in the resume path, before reenabling
>   * debug exceptions. Code cannot be run from a CPU PM notifier since by the
>  {
>  	/*
> -	 * We are resuming from reset with TTBR0_EL1 set to the
> -	 * idmap to enable the MMU; set the TTBR0 to the reserved
> -	 * page tables to prevent speculative TLB allocations, flush
> -	 * the local tlb and set the default tcr_el1.t0sz so that
> -	 * the TTBR0 address space set-up is properly restored.
> -	 * If the current active_mm != &init_mm we entered cpu_suspend
> -	 * with mappings in TTBR0 that must be restored, so we switch
> -	 * them back to complete the address space configuration
> -	 * restoration before returning.
> +	 * We resume from suspend directly into the swapper_pg_dir. We may
> +	 * also need to load user-space page tables.
>  	 */
> -	cpu_set_reserved_ttbr0();
> -	local_flush_tlb_all();
> -	cpu_set_default_tcr_t0sz();

You remove the code above since you restore tcr_el1 in cpu_do_resume(),
but this is not the way it should be done, ie the restore should be done
with the code sequence above otherwise it is not safe.

>  	if (mm != &init_mm)
>  		cpu_switch_mm(mm->pgd, mm);
>  
> @@ -149,22 +114,17 @@ int cpu_suspend(unsigned long arg, int (*fn)(unsigned long))
>  	return ret;
>  }
>  
> -struct sleep_save_sp sleep_save_sp;
> +unsigned long *sleep_save_stash;
>  
>  static int __init cpu_suspend_init(void)
>  {
> -	void *ctx_ptr;
> -
>  	/* ctx_ptr is an array of physical addresses */
> -	ctx_ptr = kcalloc(mpidr_hash_size(), sizeof(phys_addr_t), GFP_KERNEL);
> +	sleep_save_stash = kcalloc(mpidr_hash_size(), sizeof(*sleep_save_stash),
> +				   GFP_KERNEL);
>  
> -	if (WARN_ON(!ctx_ptr))
> +	if (WARN_ON(!sleep_save_stash))
>  		return -ENOMEM;
>  
> -	sleep_save_sp.save_ptr_stash = ctx_ptr;
> -	sleep_save_sp.save_ptr_stash_phys = virt_to_phys(ctx_ptr);
> -	__flush_dcache_area(&sleep_save_sp, sizeof(struct sleep_save_sp));
> -
>  	return 0;
>  }
>  early_initcall(cpu_suspend_init);
> diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
> index 3c7d170de822..a755108aaa75 100644
> --- a/arch/arm64/mm/proc.S
> +++ b/arch/arm64/mm/proc.S
> @@ -61,62 +61,45 @@ ENTRY(cpu_do_suspend)
>  	mrs	x2, tpidr_el0
>  	mrs	x3, tpidrro_el0
>  	mrs	x4, contextidr_el1
> -	mrs	x5, mair_el1
>  	mrs	x6, cpacr_el1
> -	mrs	x7, ttbr1_el1
>  	mrs	x8, tcr_el1
>  	mrs	x9, vbar_el1
>  	mrs	x10, mdscr_el1
>  	mrs	x11, oslsr_el1
>  	mrs	x12, sctlr_el1
>  	stp	x2, x3, [x0]
> -	stp	x4, x5, [x0, #16]
> -	stp	x6, x7, [x0, #32]
> -	stp	x8, x9, [x0, #48]
> -	stp	x10, x11, [x0, #64]
> -	str	x12, [x0, #80]
> +	stp	x4, xzr, [x0, #16]
> +	stp	x6, x8, [x0, #32]
> +	stp	x9, x10, [x0, #48]
> +	stp	x11, x12, [x0, #64]
>  	ret
>  ENDPROC(cpu_do_suspend)
>  
>  /**
>   * cpu_do_resume - restore CPU register context
>   *
> - * x0: Physical address of context pointer
> - * x1: ttbr0_el1 to be restored
> - *
> - * Returns:
> - *	sctlr_el1 value in x0
> + * x0: Address of context pointer
>   */
>  ENTRY(cpu_do_resume)
> -	/*
> -	 * Invalidate local tlb entries before turning on MMU
> -	 */
> -	tlbi	vmalle1
>  	ldp	x2, x3, [x0]
>  	ldp	x4, x5, [x0, #16]
> -	ldp	x6, x7, [x0, #32]
> -	ldp	x8, x9, [x0, #48]
> -	ldp	x10, x11, [x0, #64]
> -	ldr	x12, [x0, #80]
> +	ldp	x6, x8, [x0, #32]
> +	ldp	x9, x10, [x0, #48]
> +	ldp	x11, x12, [x0, #64]
>  	msr	tpidr_el0, x2
>  	msr	tpidrro_el0, x3
>  	msr	contextidr_el1, x4
> -	msr	mair_el1, x5
>  	msr	cpacr_el1, x6
> -	msr	ttbr0_el1, x1
> -	msr	ttbr1_el1, x7
> -	tcr_set_idmap_t0sz x8, x7
>  	msr	tcr_el1, x8

I do not think that's correct. You restore tcr_el1 here, but this has
side effect of "restoring" t0sz too and that's not correct since this
has to be done with the sequence you removed above.

I'd rather not touch t0sz at all (use a mask) and restore t0sz in
__cpu_suspend_exit() as it is done at present using:

cpu_set_reserved_ttbr0();
local_flush_tlb_all();
cpu_set_default_tcr_t0sz();

That's the only safe way of doing it.

Other than that the patch seems fine to me.

Thanks,
Lorenzo

>  	msr	vbar_el1, x9
>  	msr	mdscr_el1, x10
> +	msr	sctlr_el1, x12
>  	/*
>  	 * Restore oslsr_el1 by writing oslar_el1
>  	 */
>  	ubfx	x11, x11, #1, #1
>  	msr	oslar_el1, x11
>  	msr	pmuserenr_el0, xzr		// Disable PMU access from EL0
> -	mov	x0, x12
> -	dsb	nsh		// Make sure local tlb invalidation completed
>  	isb
>  	ret
>  ENDPROC(cpu_do_resume)
> -- 
> 2.6.2
> 
