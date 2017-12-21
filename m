From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Thu, 21 Dec 2017 11:15:21 +0000
Subject: [PATCH 09/10] arm64: allow ID map to be extended to 52 bits
In-Reply-To: <1513184845-8711-10-git-send-email-kristina.martsenko@arm.com>
References: <1513184845-8711-1-git-send-email-kristina.martsenko@arm.com>
 <1513184845-8711-10-git-send-email-kristina.martsenko@arm.com>
Message-ID: <4d2eeb19-472a-6df7-0e0e-d1b475649b30@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/12/17 17:07, Kristina Martsenko wrote:
> Currently, when using VA_BITS < 48, if the ID map text happens to be
> placed in physical memory above VA_BITS, we increase the VA size (up to
> 48) and create a new table level, in order to map in the ID map text.
> This is okay because the system always supports 48 bits of VA.
> 
> This patch extends the code such that if the system supports 52 bits of
> VA, and the ID map text is placed that high up, then we increase the VA
> size accordingly, up to 52.
> 
> One difference from the current implementation is that so far the
> condition of VA_BITS < 48 has meant that the top level table is always
> "full", with the maximum number of entries, and an extra table level is
> always needed. Now, when VA_BITS = 48 (and using 64k pages), the top
> level table is not full, and we simply need to increase the number of
> entries in it, instead of creating a new table level.
> 
> Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>
> ---
>   arch/arm/include/asm/kvm_mmu.h       |  5 +++
>   arch/arm64/include/asm/assembler.h   |  2 -
>   arch/arm64/include/asm/kvm_mmu.h     |  7 +++-
>   arch/arm64/include/asm/mmu_context.h | 14 ++++++-
>   arch/arm64/kernel/head.S             | 76 +++++++++++++++++++++---------------
>   arch/arm64/kvm/hyp-init.S            | 17 ++++----
>   arch/arm64/mm/mmu.c                  |  1 +
>   virt/kvm/arm/mmu.c                   | 12 +++---
>   8 files changed, 83 insertions(+), 51 deletions(-)
> 
> diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
> index 8dbec683638b..8c5643e2eea4 100644
> --- a/arch/arm/include/asm/kvm_mmu.h
> +++ b/arch/arm/include/asm/kvm_mmu.h
> @@ -211,6 +211,11 @@ static inline bool __kvm_cpu_uses_extended_idmap(void)
>   	return false;
>   }
>   
> +static inline unsigned long __kvm_idmap_ptrs_per_pgd(void)
> +{
> +	return PTRS_PER_PGD;
> +}
> +
>   static inline void __kvm_extend_hypmap(pgd_t *boot_hyp_pgd,
>   				       pgd_t *hyp_pgd,
>   				       pgd_t *merged_hyp_pgd,
> diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
> index 2058fd864bfb..11719b11f4a7 100644
> --- a/arch/arm64/include/asm/assembler.h
> +++ b/arch/arm64/include/asm/assembler.h
> @@ -344,10 +344,8 @@ alternative_endif
>    * tcr_set_idmap_t0sz - update TCR.T0SZ so that we can load the ID map
>    */
>   	.macro	tcr_set_idmap_t0sz, valreg, tmpreg
> -#ifndef CONFIG_ARM64_VA_BITS_48
>   	ldr_l	\tmpreg, idmap_t0sz
>   	bfi	\valreg, \tmpreg, #TCR_T0SZ_OFFSET, #TCR_TxSZ_WIDTH
> -#endif
>   	.endm
>   
>   /*
> diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
> index b3f7b68b042d..8d663ca0d50c 100644
> --- a/arch/arm64/include/asm/kvm_mmu.h
> +++ b/arch/arm64/include/asm/kvm_mmu.h
> @@ -273,7 +273,12 @@ void kvm_toggle_cache(struct kvm_vcpu *vcpu, bool was_enabled);
>   
>   static inline bool __kvm_cpu_uses_extended_idmap(void)
>   {
> -	return __cpu_uses_extended_idmap();
> +	return __cpu_uses_extended_idmap_table();
> +}
> +
> +static inline unsigned long __kvm_idmap_ptrs_per_pgd(void)
> +{
> +	return idmap_ptrs_per_pgd;
>   }
>   
>   /*
> diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
> index accc2ff32a0e..043eed856b55 100644
> --- a/arch/arm64/include/asm/mmu_context.h
> +++ b/arch/arm64/include/asm/mmu_context.h
> @@ -63,11 +63,21 @@ static inline void cpu_set_reserved_ttbr0(void)
>    * physical memory, in which case it will be smaller.
>    */
>   extern u64 idmap_t0sz;
> +extern u64 idmap_ptrs_per_pgd;
>   
>   static inline bool __cpu_uses_extended_idmap(void)
>   {
> -	return (!IS_ENABLED(CONFIG_ARM64_VA_BITS_48) &&
> -		unlikely(idmap_t0sz != TCR_T0SZ(VA_BITS)));
> +	return unlikely(idmap_t0sz != TCR_T0SZ(VA_BITS));
> +}
> +
> +/*
> + * True if the extended ID map requires an extra level of translation table
> + * to be configured.
> + */
> +static inline bool __cpu_uses_extended_idmap_table(void)
> +{
> +	return __cpu_uses_extended_idmap() &&
> +		(idmap_ptrs_per_pgd == PTRS_PER_PGD);
>   }
>   

Kristina,

I feel this is a bit confusing, as we use idmap_ptrs_per_pgd value to convey two
different information.

1) Whether we use an extended level of table
2) Number of ptrs in the host VA PGD level for idmap

I think we are able to figure out if the idmap uses an extended table using the idmap_t0sz alone :

static inline bool __cpu_uses_extended_idmap_level(void)
{
	return ARM64_HW_PGTABLE_LEVELS((64 - idmap_t0sz)) > CONFIG_PGTABLE_LEVELS;
}

Also, the name could be changed to __cpu_uses_extended_idmap_level() to imply we are talking
about an additional level of table, rather than extending the table, which could either mean
extending the table to include more pgd ptrs or an additional level.


Rest looks good to me.

Suzuki
