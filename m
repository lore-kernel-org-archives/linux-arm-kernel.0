From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 6 Dec 2017 14:32:43 +0000
Subject: [PATCH v3 11/20] arm64: mm: Map entry trampoline into trampoline
 and kernel page tables
In-Reply-To: <1512563739-25239-12-git-send-email-will.deacon@arm.com>
References: <1512563739-25239-1-git-send-email-will.deacon@arm.com>
 <1512563739-25239-12-git-send-email-will.deacon@arm.com>
Message-ID: <20171206143243.rzcssrrkomyb66jg@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 06, 2017 at 12:35:30PM +0000, Will Deacon wrote:
> The exception entry trampoline needs to be mapped at the same virtual
> address in both the trampoline page table (which maps nothing else)
> and also the kernel page table, so that we can swizzle TTBR1_EL1 on
> exceptions from and return to EL0.
> 
> This patch maps the trampoline at a fixed virtual address in the fixmap
> area of the kernel virtual address space, which allows the kernel proper
> to be randomized with respect to the trampoline when KASLR is enabled.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm64/include/asm/fixmap.h  |  4 ++++
>  arch/arm64/include/asm/pgtable.h |  1 +
>  arch/arm64/kernel/asm-offsets.c  |  6 +++++-
>  arch/arm64/mm/mmu.c              | 23 +++++++++++++++++++++++
>  4 files changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/fixmap.h b/arch/arm64/include/asm/fixmap.h
> index 4052ec39e8db..8119b49be98d 100644
> --- a/arch/arm64/include/asm/fixmap.h
> +++ b/arch/arm64/include/asm/fixmap.h
> @@ -58,6 +58,10 @@ enum fixed_addresses {
>  	FIX_APEI_GHES_NMI,
>  #endif /* CONFIG_ACPI_APEI_GHES */
>  
> +#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
> +	FIX_ENTRY_TRAMP_TEXT,
> +#define TRAMP_VALIAS		(__fix_to_virt(FIX_ENTRY_TRAMP_TEXT))
> +#endif /* CONFIG_UNMAP_KERNEL_AT_EL0 */
>  	__end_of_permanent_fixed_addresses,
>  
>  	/*
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 149d05fb9421..774003b247ad 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -680,6 +680,7 @@ static inline void pmdp_set_wrprotect(struct mm_struct *mm,
>  
>  extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
>  extern pgd_t idmap_pg_dir[PTRS_PER_PGD];
> +extern pgd_t tramp_pg_dir[PTRS_PER_PGD];
>  
>  /*
>   * Encode and decode a swap entry:
> diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
> index 71bf088f1e4b..af247d10252f 100644
> --- a/arch/arm64/kernel/asm-offsets.c
> +++ b/arch/arm64/kernel/asm-offsets.c
> @@ -24,6 +24,7 @@
>  #include <linux/kvm_host.h>
>  #include <linux/suspend.h>
>  #include <asm/cpufeature.h>
> +#include <asm/fixmap.h>
>  #include <asm/thread_info.h>
>  #include <asm/memory.h>
>  #include <asm/smp_plat.h>
> @@ -148,11 +149,14 @@ int main(void)
>    DEFINE(ARM_SMCCC_RES_X2_OFFS,		offsetof(struct arm_smccc_res, a2));
>    DEFINE(ARM_SMCCC_QUIRK_ID_OFFS,	offsetof(struct arm_smccc_quirk, id));
>    DEFINE(ARM_SMCCC_QUIRK_STATE_OFFS,	offsetof(struct arm_smccc_quirk, state));
> -
>    BLANK();
>    DEFINE(HIBERN_PBE_ORIG,	offsetof(struct pbe, orig_address));
>    DEFINE(HIBERN_PBE_ADDR,	offsetof(struct pbe, address));
>    DEFINE(HIBERN_PBE_NEXT,	offsetof(struct pbe, next));
>    DEFINE(ARM64_FTR_SYSVAL,	offsetof(struct arm64_ftr_reg, sys_val));
> +  BLANK();
> +#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
> +  DEFINE(TRAMP_VALIAS,		TRAMP_VALIAS);
> +#endif
>    return 0;
>  }
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 267d2b79d52d..fe68a48c64cb 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -525,6 +525,29 @@ static int __init parse_rodata(char *arg)
>  }
>  early_param("rodata", parse_rodata);
>  
> +#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
> +static int __init map_entry_trampoline(void)
> +{
> +	extern char __entry_tramp_text_start[];
> +
> +	pgprot_t prot = rodata_enabled ? PAGE_KERNEL_ROX : PAGE_KERNEL_EXEC;
> +	phys_addr_t pa_start = __pa_symbol(__entry_tramp_text_start);
> +
> +	/* The trampoline is always mapped and can therefore be global */
> +	pgprot_val(prot) &= ~PTE_NG;
> +
> +	/* Map only the text into the trampoline page table */
> +	memset(tramp_pg_dir, 0, PGD_SIZE);
> +	__create_pgd_mapping(tramp_pg_dir, pa_start, TRAMP_VALIAS, PAGE_SIZE,
> +			     prot, pgd_pgtable_alloc, 0);
> +
> +	/* ...as well as the kernel page table */
> +	__set_fixmap(FIX_ENTRY_TRAMP_TEXT, pa_start, prot);
> +	return 0;
> +}
> +core_initcall(map_entry_trampoline);
> +#endif
> +
>  /*
>   * Create fine-grained mappings for the kernel.
>   */
> -- 
> 2.1.4
> 
