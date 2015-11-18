From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 18 Nov 2015 10:03:01 +0000
Subject: [PATCH] arm64: pgtable: implement pte_accessible()
In-Reply-To: <1447782907-18466-1-git-send-email-will.deacon@arm.com>
References: <1447782907-18466-1-git-send-email-will.deacon@arm.com>
Message-ID: <20151118100300.GC27495@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 17, 2015 at 05:55:07PM +0000, Will Deacon wrote:
> This patch implements the pte_accessible() macro, which can be used to
> test whether or not a given pte is a candidate for allocation in the
> TLB.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/include/asm/pgtable.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index b3f04393e0f1..3850ae460ee7 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -167,6 +167,11 @@ extern struct page *empty_zero_page;
>  	((pte_val(pte) & (PTE_VALID | PTE_USER)) == (PTE_VALID | PTE_USER))
>  #define pte_valid_not_user(pte) \
>  	((pte_val(pte) & (PTE_VALID | PTE_USER)) == PTE_VALID)
> +#define pte_valid_young(pte) \
> +	((pte_val(pte) & (PTE_VALID | PTE_AF)) == (PTE_VALID | PTE_AF))
> +
> +#define pte_accessible(mm, pte)	\
> +	(mm_tlb_flush_pending(mm) ? pte_present(pte) : pte_valid_young(pte))

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

However, it would be nice to add a comment on the need for
mm_tlb_flush_pending() check. We may look at this in the future and
won't remember.

-- 
Catalin
