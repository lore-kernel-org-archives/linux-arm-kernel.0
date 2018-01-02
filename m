From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 2 Jan 2018 18:19:10 +0000
Subject: [PATCH] arm64: dirty memory check, enable soft dirty for arm64
In-Reply-To: <1512029649-61312-1-git-send-email-bin.lu@arm.com>
References: <1512029649-61312-1-git-send-email-bin.lu@arm.com>
Message-ID: <20180102181910.gxiqaehznpw2hc6u@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bin,

On Thu, Nov 30, 2017 at 12:14:09AM -0800, Bin Lu wrote:
>     pmd_dirty and pmd_mkclean for THP page MADV_FREE also were
>     supported in this patch.
[...]
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -306,6 +306,28 @@ static inline pgprot_t mk_sect_prot(pgprot_t prot)
>  	return __pgprot(pgprot_val(prot) & ~PTE_TABLE_BIT);
>  }
>  
> +#ifdef CONFIG_HAVE_ARCH_SOFT_DIRTY
> +static inline bool pte_soft_dirty(pte_t pte)
> +{
> +        return pte_sw_dirty(pte);
> +}
> +
> +static inline pte_t pte_mksoft_dirty(pte_t pte)
> +{
> +        return pte_mkdirty(pte);
> +}
> +
> +static inline pte_t pte_clear_soft_dirty(pte_t pte)
> +{
> +        return pte_mkclean(pte);
> +}
> +
> +#define pmd_soft_dirty(pmd)    pte_soft_dirty(pmd_pte(pmd))
> +#define pmd_mksoft_dirty(pmd)  pte_pmd(pte_mksoft_dirty(pmd_pte(pmd)))
> +#define pmd_clear_soft_dirty(pmd) pte_pmd(pte_clear_soft_dirty(pmd_pte(pmd)))

IIUC, a pmd_mkclean() would result in a pte_soft_dirty() == false. Is
this the expected behaviour with MADV_FREE? The x86 code sets both
_PAGE_DIRTY and _PAGE_SOFT_DIRTY in pmd_mkdirty() but only clears
_PAGE_DIRTY in pmd_mkclean().

-- 
Catalin
