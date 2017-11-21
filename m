From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 21 Nov 2017 14:39:44 +0000
Subject: [RFC 3/9] arm64: handle 52-bit addresses in TTBR
In-Reply-To: <1511265485-27163-4-git-send-email-kristina.martsenko@arm.com>
References: <1511265485-27163-1-git-send-email-kristina.martsenko@arm.com>
 <1511265485-27163-4-git-send-email-kristina.martsenko@arm.com>
Message-ID: <8ebb78d3-68b0-3272-e12b-005c1b524736@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kristina,

On 21/11/17 11:57, Kristina Martsenko wrote:
> The top 4 bits of a 52-bit physical address are positioned at bits 2..5
> in the TTBR registers. Introduce a couple of macros to move the bits
> there, and change all TTBR writers to use them.
> 
> Leave TTBR0 PAN code unchanged, to avoid complicating it. A system with
> 52-bit PA will have PAN anyway (because it's ARMv8.1 or later), and a
> system without 52-bit PA can only use up to 48-bit PAs. Add a kconfig
> dependency to ensure PAN is configured.
> 
> In addition, when using 52-bit PA there is a special alignment
> requirement on the top-level table. We don't currently have any VA_BITS
> configuration that would violate the requirement, but one could be added
> in the future, so add a compile-time BUG_ON to check for it.
> 
> Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>
> ---
>   arch/arm/include/asm/kvm_mmu.h       |  2 ++
>   arch/arm64/Kconfig                   |  1 +
>   arch/arm64/include/asm/assembler.h   | 17 +++++++++++++++++
>   arch/arm64/include/asm/kvm_mmu.h     |  2 ++
>   arch/arm64/include/asm/mmu_context.h |  2 +-
>   arch/arm64/include/asm/pgtable.h     |  6 ++++++
>   arch/arm64/kernel/head.S             |  6 ++++--
>   arch/arm64/kernel/hibernate-asm.S    | 12 +++++++-----
>   arch/arm64/kernel/hibernate.c        |  2 +-
>   arch/arm64/kvm/hyp-init.S            |  3 ++-
>   arch/arm64/mm/pgd.c                  |  8 ++++++++
>   arch/arm64/mm/proc.S                 | 13 ++++++++-----
>   virt/kvm/arm/arm.c                   |  2 +-
>   13 files changed, 60 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
> index fa6f2174276b..8dbec683638b 100644
> --- a/arch/arm/include/asm/kvm_mmu.h
> +++ b/arch/arm/include/asm/kvm_mmu.h
> @@ -221,6 +221,8 @@ static inline unsigned int kvm_get_vmid_bits(void)
>   	return 8;
>   }
>   
> +#define kvm_phys_to_vttbr(addr)		(addr)
> +
>   #endif	/* !__ASSEMBLY__ */
>   
>   #endif /* __ARM_KVM_MMU_H__ */
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 30d0cc272903..7e63048e3425 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -622,6 +622,7 @@ config ARM64_PA_BITS_48
>   config ARM64_PA_BITS_52
>   	bool "52-bit (ARMv8.2)"
>   	depends on ARM64_64K_PAGES
> +	depends on ARM64_PAN || !ARM64_SW_TTBR0_PAN
>   	help
>   	  Enable support for a 52-bit physical address space, introduced as
>   	  part of the ARMv8.2-LPA extension.
> diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
> index 04cf94766b78..ba3c796b9fe1 100644
> --- a/arch/arm64/include/asm/assembler.h
> +++ b/arch/arm64/include/asm/assembler.h
> @@ -512,4 +512,21 @@ alternative_else_nop_endif
>   #endif
>   	.endm
>   
> +/*
> + * Arrange a physical address in a TTBR register, taking care of 52-bit
> + * addresses.
> + *
> + * 	phys:	physical address, preserved
> + * 	ttbr:	returns the TTBR value
> + */
> +	.macro	phys_to_ttbr, phys, ttbr
> +#ifdef CONFIG_ARM64_PA_BITS_52
> +	and	\ttbr, \phys, #(1 << 48) - 1
> +	orr	\ttbr, \ttbr, \phys, lsr #48 - 2
> +	bic	\ttbr, \ttbr, #(1 << 2) - 1

Is there any reason for masking off each end of the result separately 
like this, or could we just do it more straightforwardly?

#define TTBR_BADDR_MASK ((1 << 46) - 1) << 2

	orr	\ttbr, \phys, \phys, lsr #46
	and	\ttbr, \ttbr, #TTBR_BADDR_MASK

(and equivalently for phys_to_pte in patch 4)

Even better if there's a convenient place to define the mask such that 
it can be shared with KVM's existing VTTBR stuff too.

Robin.

> +#else
> +	mov	\ttbr, \phys
> +#endif
> +	.endm
> +
>   #endif	/* __ASM_ASSEMBLER_H */
> diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
> index 672c8684d5c2..747bfff92948 100644
> --- a/arch/arm64/include/asm/kvm_mmu.h
> +++ b/arch/arm64/include/asm/kvm_mmu.h
> @@ -309,5 +309,7 @@ static inline unsigned int kvm_get_vmid_bits(void)
>   	return (cpuid_feature_extract_unsigned_field(reg, ID_AA64MMFR1_VMIDBITS_SHIFT) == 2) ? 16 : 8;
>   }
>   
> +#define kvm_phys_to_vttbr(addr)		phys_to_ttbr(addr)
> +
>   #endif /* __ASSEMBLY__ */
>   #endif /* __ARM64_KVM_MMU_H__ */
> diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
> index 3257895a9b5e..c0aa2b221769 100644
> --- a/arch/arm64/include/asm/mmu_context.h
> +++ b/arch/arm64/include/asm/mmu_context.h
> @@ -51,7 +51,7 @@ static inline void contextidr_thread_switch(struct task_struct *next)
>    */
>   static inline void cpu_set_reserved_ttbr0(void)
>   {
> -	unsigned long ttbr = __pa_symbol(empty_zero_page);
> +	unsigned long ttbr = phys_to_ttbr(__pa_symbol(empty_zero_page));
>   
>   	write_sysreg(ttbr, ttbr0_el1);
>   	isb();
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index b46e54c2399b..dcca52feaea2 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -720,6 +720,12 @@ static inline void update_mmu_cache(struct vm_area_struct *vma,
>   #define kc_vaddr_to_offset(v)	((v) & ~VA_START)
>   #define kc_offset_to_vaddr(o)	((o) | VA_START)
>   
> +#ifdef CONFIG_ARM64_PA_BITS_52
> +#define phys_to_ttbr(addr)	(((addr) & GENMASK(47, 6)) | (((addr) & GENMASK(51, 48)) >> 46))
> +#else
> +#define phys_to_ttbr(addr)	(addr)
> +#endif
> +
>   #endif /* !__ASSEMBLY__ */
>   
>   #endif /* __ASM_PGTABLE_H */
> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index 0b243ecaf7ac..7fcbe23d9ce8 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -661,8 +661,10 @@ ENTRY(__enable_mmu)
>   	update_early_cpu_boot_status 0, x1, x2
>   	adrp	x1, idmap_pg_dir
>   	adrp	x2, swapper_pg_dir
> -	msr	ttbr0_el1, x1			// load TTBR0
> -	msr	ttbr1_el1, x2			// load TTBR1
> +	phys_to_ttbr x1, x3
> +	phys_to_ttbr x2, x4
> +	msr	ttbr0_el1, x3			// load TTBR0
> +	msr	ttbr1_el1, x4			// load TTBR1
>   	isb
>   	msr	sctlr_el1, x0
>   	isb
> diff --git a/arch/arm64/kernel/hibernate-asm.S b/arch/arm64/kernel/hibernate-asm.S
> index e56d848b6466..84f5d52fddda 100644
> --- a/arch/arm64/kernel/hibernate-asm.S
> +++ b/arch/arm64/kernel/hibernate-asm.S
> @@ -33,12 +33,14 @@
>    * Even switching to our copied tables will cause a changed output address at
>    * each stage of the walk.
>    */
> -.macro break_before_make_ttbr_switch zero_page, page_table
> -	msr	ttbr1_el1, \zero_page
> +.macro break_before_make_ttbr_switch zero_page, page_table, tmp
> +	phys_to_ttbr \zero_page, \tmp
> +	msr	ttbr1_el1, \tmp
>   	isb
>   	tlbi	vmalle1
>   	dsb	nsh
> -	msr	ttbr1_el1, \page_table
> +	phys_to_ttbr \page_table, \tmp
> +	msr	ttbr1_el1, \tmp
>   	isb
>   .endm
>   
> @@ -78,7 +80,7 @@ ENTRY(swsusp_arch_suspend_exit)
>   	 * We execute from ttbr0, change ttbr1 to our copied linear map tables
>   	 * with a break-before-make via the zero page
>   	 */
> -	break_before_make_ttbr_switch	x5, x0
> +	break_before_make_ttbr_switch	x5, x0, x6
>   
>   	mov	x21, x1
>   	mov	x30, x2
> @@ -109,7 +111,7 @@ ENTRY(swsusp_arch_suspend_exit)
>   	dsb	ish		/* wait for PoU cleaning to finish */
>   
>   	/* switch to the restored kernels page tables */
> -	break_before_make_ttbr_switch	x25, x21
> +	break_before_make_ttbr_switch	x25, x21, x6
>   
>   	ic	ialluis
>   	dsb	ish
> diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
> index 095d3c170f5d..1ef660ebf049 100644
> --- a/arch/arm64/kernel/hibernate.c
> +++ b/arch/arm64/kernel/hibernate.c
> @@ -263,7 +263,7 @@ static int create_safe_exec_page(void *src_start, size_t length,
>   	 */
>   	cpu_set_reserved_ttbr0();
>   	local_flush_tlb_all();
> -	write_sysreg(virt_to_phys(pgd), ttbr0_el1);
> +	write_sysreg(phys_to_ttbr(virt_to_phys(pgd)), ttbr0_el1);
>   	isb();
>   
>   	*phys_dst_addr = virt_to_phys((void *)dst);
> diff --git a/arch/arm64/kvm/hyp-init.S b/arch/arm64/kvm/hyp-init.S
> index f731a48bd9f1..a99718f32af9 100644
> --- a/arch/arm64/kvm/hyp-init.S
> +++ b/arch/arm64/kvm/hyp-init.S
> @@ -63,7 +63,8 @@ __do_hyp_init:
>   	cmp	x0, #HVC_STUB_HCALL_NR
>   	b.lo	__kvm_handle_stub_hvc
>   
> -	msr	ttbr0_el2, x0
> +	phys_to_ttbr x0, x4
> +	msr	ttbr0_el2, x4
>   
>   	mrs	x4, tcr_el1
>   	ldr	x5, =TCR_EL2_MASK
> diff --git a/arch/arm64/mm/pgd.c b/arch/arm64/mm/pgd.c
> index 371c5f03a170..77919e615dfc 100644
> --- a/arch/arm64/mm/pgd.c
> +++ b/arch/arm64/mm/pgd.c
> @@ -49,6 +49,14 @@ void __init pgd_cache_init(void)
>   	if (PGD_SIZE == PAGE_SIZE)
>   		return;
>   
> +#ifdef CONFIG_ARM64_PA_BITS_52
> +	/*
> +	 * With 52-bit physical addresses, the architecture requires the
> +	 * top-level table to be aligned to at least 64 bytes.
> +	 */
> +	BUILD_BUG_ON(PGD_SIZE < 64);
> +#endif
> +
>   	/*
>   	 * Naturally aligned pgds required by the architecture.
>   	 */
> diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
> index 9f16cfa89dac..5a29dbc703e2 100644
> --- a/arch/arm64/mm/proc.S
> +++ b/arch/arm64/mm/proc.S
> @@ -138,10 +138,11 @@ ENDPROC(cpu_do_resume)
>    *	- pgd_phys - physical address of new TTB
>    */
>   ENTRY(cpu_do_switch_mm)
> -	pre_ttbr0_update_workaround x0, x2, x3
> +	phys_to_ttbr x0, x2
> +	pre_ttbr0_update_workaround x2, x3, x4
>   	mmid	x1, x1				// get mm->context.id
> -	bfi	x0, x1, #48, #16		// set the ASID
> -	msr	ttbr0_el1, x0			// set TTBR0
> +	bfi	x2, x1, #48, #16		// set the ASID
> +	msr	ttbr0_el1, x2			// set TTBR0
>   	isb
>   	post_ttbr0_update_workaround
>   	ret
> @@ -159,14 +160,16 @@ ENTRY(idmap_cpu_replace_ttbr1)
>   	msr	daifset, #0xf
>   
>   	adrp	x1, empty_zero_page
> -	msr	ttbr1_el1, x1
> +	phys_to_ttbr x1, x3
> +	msr	ttbr1_el1, x3
>   	isb
>   
>   	tlbi	vmalle1
>   	dsb	nsh
>   	isb
>   
> -	msr	ttbr1_el1, x0
> +	phys_to_ttbr x0, x3
> +	msr	ttbr1_el1, x3
>   	isb
>   
>   	msr	daif, x2
> diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
> index 95cba0799828..c208420aa11e 100644
> --- a/virt/kvm/arm/arm.c
> +++ b/virt/kvm/arm/arm.c
> @@ -506,7 +506,7 @@ static void update_vttbr(struct kvm *kvm)
>   	pgd_phys = virt_to_phys(kvm->arch.pgd);
>   	BUG_ON(pgd_phys & ~VTTBR_BADDR_MASK);
>   	vmid = ((u64)(kvm->arch.vmid) << VTTBR_VMID_SHIFT) & VTTBR_VMID_MASK(kvm_vmid_bits);
> -	kvm->arch.vttbr = pgd_phys | vmid;
> +	kvm->arch.vttbr = kvm_phys_to_vttbr(pgd_phys) | vmid;
>   
>   	spin_unlock(&kvm_vmid_lock);
>   }
> 
