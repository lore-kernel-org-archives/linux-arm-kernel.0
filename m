From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 24 Feb 2015 12:03:41 +0000
Subject: [RFC PATCH] arm64: mm: increase VA range of identity map
In-Reply-To: <1424775342-30588-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1424775342-30588-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20150224120341.GC27420@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 24, 2015 at 10:55:42AM +0000, Ard Biesheuvel wrote:
> This patch fixes the annoying issue that AMD Seattle cannot boot the
> arm64 defconfig build, crashing so early that even earlycon is completely
> silent. It does so by allowing an ID map to have more translation levels
> than the default configured value.

We could have changed the defconfig to 4 levels of page tables but since
it's currently only needed for idmap, I like your approach.

> diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
> index 3e6859bc3e11..c2da529bb7bd 100644
> --- a/arch/arm/kvm/mmu.c
> +++ b/arch/arm/kvm/mmu.c
> @@ -1532,6 +1532,12 @@ int kvm_mmu_init(void)
>  			 (unsigned long)phys_base);
>  	}
>  
> +	if ((hyp_idmap_start >> PGDIR_SHIFT) >= PTRS_PER_PGD) {
> +		kvm_err("Couldn't identity map HYP init page (PA exceeds VA range)\n");
> +		err = -ENOMEM;
> +		goto out;
> +	}
> +
>  	hyp_pgd = (pgd_t *)__get_free_pages(GFP_KERNEL | __GFP_ZERO, hyp_pgd_order);
>  	boot_hyp_pgd = (pgd_t *)__get_free_pages(GFP_KERNEL | __GFP_ZERO, hyp_pgd_order);

I wonder whether Hyp can share the same idmap as the rest of the kernel
(extending the latter to cover the hyp text). The Hyp one requires the
PTE_USER attributes but we could use the same attributes on the kernel
idmap since it's never used at the same time with a user process.

> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> index f800d45ea226..19f6297a472b 100644
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -42,12 +42,14 @@
>   * PAGE_OFFSET - the virtual address of the start of the kernel image (top
>   *		 (VA_BITS - 1))
>   * VA_BITS - the maximum number of bits for virtual addresses.
> + * MAX_VA_BITS - architectural max value for VA_BITS
>   * TASK_SIZE - the maximum size of a user space task.
>   * TASK_UNMAPPED_BASE - the lower boundary of the mmap VM area.
>   * The module space lives between the addresses given by TASK_SIZE
>   * and PAGE_OFFSET - it must be within 128MB of the kernel text.
>   */
>  #define VA_BITS			(CONFIG_ARM64_VA_BITS)
> +#define MAX_VA_BITS		48

Can we determine this dynamically based on the phys address? So on
hardware that doesn't need such large idmap, it would stick to the host
configured levels.

> diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
> index a9eee33dfa62..641ce0574999 100644
> --- a/arch/arm64/include/asm/mmu_context.h
> +++ b/arch/arm64/include/asm/mmu_context.h
> @@ -64,6 +64,44 @@ static inline void cpu_set_reserved_ttbr0(void)
>  	: "r" (ttbr));
>  }
>  
> +/*
> + * TCR.T0SZ value to use when the ID map is active. Usually equals
> + * TCR_T0SZ(VA_BITS), unless system RAM is positioned very high in
> + * physical memory, in which case it will be smaller.
> + */
> +extern u64 idmap_t0sz;
> +
> +static inline void __cpu_set_tcr_t0sz(u64 t0sz)
> +{
> +	unsigned long tcr;
> +
> +	if (!IS_ENABLED(CONFIG_ARM64_VA_BITS_48)
> +	    && unlikely(idmap_t0sz != TCR_T0SZ(VA_BITS)))
> +		asm volatile(
> +		"	mrs	%0, tcr_el1		;"
> +		"	bfi	%0, %1, #%2, #%3	;"
> +		"	msr	tcr_el1, %0		;"
> +		"	isb"
> +		: "=&r" (tcr)
> +		: "r"(t0sz), "I"(TCR_T0SZ_OFFSET), "I"(TCR_TxSZ_WIDTH));
> +}

We need some TLB invalidation here (or in the functions below) as the
TCR bits are allowed to be cached in the TLB. I think in general it
should be:

	cpu_set_reserved_ttbr0();
	flush_tlb_all();	/* any trace of previous T0SZ */
	cpu_set_(idmap|default)_tcr_t0sz();

> +/*
> + * Set TCR.T0SZ to the value appropriate for activating the identity map.
> + */
> +static inline void cpu_set_idmap_tcr_t0sz(void)
> +{
> +	__cpu_set_tcr_t0sz(idmap_t0sz);
> +}
> +
> +/*
> + * Set TCR.T0SZ to its default value (based on VA_BITS)
> + */
> +static inline void cpu_set_default_tcr_t0sz(void)
> +{
> +	__cpu_set_tcr_t0sz(TCR_T0SZ(VA_BITS));
> +}
> +

So flush_tlb_all() could be at the beginning of these functions.

> diff --git a/arch/arm64/include/asm/page.h b/arch/arm64/include/asm/page.h
> index 22b16232bd60..3d02b1869eb8 100644
> --- a/arch/arm64/include/asm/page.h
> +++ b/arch/arm64/include/asm/page.h
> @@ -33,7 +33,9 @@
>   * image. Both require pgd, pud (4 levels only) and pmd tables to (section)
>   * map the kernel. With the 64K page configuration, swapper and idmap need to
>   * map to pte level. The swapper also maps the FDT (see __create_page_tables
> - * for more information).
> + * for more information). Note that the number of ID map translation levels
> + * could be increased on the fly if system RAM is out of reach for the default
> + * VA range, so 3 pages are reserved in all cases.
>   */
>  #ifdef CONFIG_ARM64_64K_PAGES
>  #define SWAPPER_PGTABLE_LEVELS	(CONFIG_ARM64_PGTABLE_LEVELS)
> @@ -42,7 +44,7 @@
>  #endif
>  
>  #define SWAPPER_DIR_SIZE	(SWAPPER_PGTABLE_LEVELS * PAGE_SIZE)
> -#define IDMAP_DIR_SIZE		(SWAPPER_DIR_SIZE)
> +#define IDMAP_DIR_SIZE		(3 * PAGE_SIZE)

That's fine, we make this permanent.

> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index 8ce88e08c030..8e1778e7638e 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -387,6 +387,26 @@ __create_page_tables:
>  	mov	x0, x25				// idmap_pg_dir
>  	ldr	x3, =KERNEL_START
>  	add	x3, x3, x28			// __pa(KERNEL_START)
> +
> +#ifndef CONFIG_ARM64_VA_BITS_48
> +#define EXTRA_SHIFT	(PGDIR_SHIFT + PAGE_SHIFT - 3)
> +	/*
> +	 * If VA_BITS < 48, it may be too small to allow for an ID mapping to be
> +	 * created that covers system RAM if that is located sufficiently high
> +	 * in the physical address space. So for the ID map, use the entire
> +	 * available virtual range in that case.
> +	 */
> +	lsr	x5, x3, #VA_BITS
> +	cbz	x5, 1f
> +
> +	adrp	x6, idmap_t0sz
> +	mov	x5, #TCR_T0SZ(MAX_VA_BITS)
> +	str	x5, [x6, #:lo12:idmap_t0sz]

Could we use memstart_addr (it's probably available in x24 here) to
calculate the idmap_t0sz? We get get the ilog2(memstart_addr +
KERNEL_END - PAGE_OFFSET) using clz.

> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 328b8ce4b007..606005101020 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -150,6 +150,7 @@ asmlinkage void secondary_start_kernel(void)
>  	 * point to zero page to avoid speculatively fetching new entries.
>  	 */
>  	cpu_set_reserved_ttbr0();
> +	cpu_set_default_tcr_t0sz();
>  	flush_tlb_all();

If you avoid the flush_tlb_all() in cpu_set_default_tcr_t0sz(), you
should place the latter after the TLB invalidation.

> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index c6daaf6c6f97..dffa1d05a101 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -40,6 +40,8 @@
>  
>  #include "mm.h"
>  
> +u64 idmap_t0sz = TCR_T0SZ(VA_BITS);
> +
>  /*
>   * Empty_zero_page is a special page that is used for zero-initialized data
>   * and COW.
> @@ -453,6 +455,7 @@ void __init paging_init(void)
>  	 * point to zero page to avoid speculatively fetching new entries.
>  	 */
>  	cpu_set_reserved_ttbr0();
> +	cpu_set_default_tcr_t0sz();
>  	flush_tlb_all();
>  }

Same here.

> @@ -461,6 +464,8 @@ void __init paging_init(void)
>   */
>  void setup_mm_for_reboot(void)
>  {
> +	cpu_set_reserved_ttbr0();
> +	cpu_set_idmap_tcr_t0sz();
>  	cpu_switch_mm(idmap_pg_dir, &init_mm);
>  	flush_tlb_all();
>  }

And I think here we should move the flush_tlb_all() just after
cpu_set_reserved_ttbr0(). Since this would point to the zero page, we
won't get any new allocations, so I don't think we would need another
TLB invalidation after cpu_switch_mm().

-- 
Catalin
