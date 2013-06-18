From: steve.capper@linaro.org (Steve Capper)
Date: Tue, 18 Jun 2013 10:37:37 +0100
Subject: [PATCH] arm64: Define PTE_TYPE_HUGEPAGE
In-Reply-To: <1371519455-64998-1-git-send-email-christoffer.dall@linaro.org>
References: <1371519455-64998-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <20130618093736.GB28428@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 17, 2013 at 06:37:35PM -0700, Christoffer Dall wrote:
> PTE_TYPE_HUGEPAGE is referenced by pte_huge, but because nobody uses
> this macro it doesn't fail yet.  KVM will be using this when 32-bit
> support for huge pages is added so add it.
> 
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> ---
>  arch/arm64/include/asm/pgtable-hwdef.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
> index 66367c6..0219523 100644
> --- a/arch/arm64/include/asm/pgtable-hwdef.h
> +++ b/arch/arm64/include/asm/pgtable-hwdef.h
> @@ -54,6 +54,7 @@
>  #define PTE_TYPE_MASK		(_AT(pteval_t, 3) << 0)
>  #define PTE_TYPE_FAULT		(_AT(pteval_t, 0) << 0)
>  #define PTE_TYPE_PAGE		(_AT(pteval_t, 3) << 0)
> +#define PTE_TYPE_HUGEPAGE	(_AT(pteval_t, 1) << 0)
>  #define PTE_USER		(_AT(pteval_t, 1) << 6)		/* AP[1] */
>  #define PTE_RDONLY		(_AT(pteval_t, 1) << 7)		/* AP[2] */
>  #define PTE_SHARED		(_AT(pteval_t, 3) << 8)		/* SH[1:0], inner shareable */
> -- 
> 1.8.1.2
> 

Hi Christoffer,
We can have PROT_NONE protected huge pages in ARM64 and the descriptors for
these will end in 00b. They are faulting descriptors, so any reads or writes by
user or kernel space will fault.

I have the following in my huge page patches:
#define pte_huge(pte)          (!(pte_val(pte) & PTE_TABLE_BIT))

i.e. check for bit 1 clear.

Please let me know if I've missed a PTE_TYPE_HUGEPAGE somewhere and I'll fix
it.

Thanks,
-- 
Steve
