From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 6 Oct 2015 12:10:04 +0100
Subject: [PATCH 2/7] arm64: PTE/PMD contiguous bit definition
In-Reply-To: <1443818865-19846-3-git-send-email-jeremy.linton@arm.com>
References: <1443818865-19846-1-git-send-email-jeremy.linton@arm.com>
 <1443818865-19846-3-git-send-email-jeremy.linton@arm.com>
Message-ID: <20151006111003.GB3069@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 02, 2015 at 03:47:40PM -0500, Jeremy Linton wrote:
> Define the bit positions in the PTE and PMD for the
> contiguous bit.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  arch/arm64/include/asm/pgtable-hwdef.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
> index 24154b0..361352d 100644
> --- a/arch/arm64/include/asm/pgtable-hwdef.h
> +++ b/arch/arm64/include/asm/pgtable-hwdef.h
> @@ -55,6 +55,13 @@
>  #define SECTION_MASK		(~(SECTION_SIZE-1))
>  
>  /*
> + * Contiguous page definitions.
> + */
> +#define CONT_RANGE		(_AC(1, UL) << CONT_SHIFT)
> +#define CONT_RANGE_MASK		((CONT_RANGE-1) << PAGE_SHIFT)
> +#define CONT_RANGE_OFFSET(addr) (((addr)>>PAGE_SHIFT)&(CONT_RANGE-1))

This still looks confusing to me: CONT_RANGE refers to the number of
contiguous ptes while CONT_RANGE_MASK refers to actual addresses. I'd
rather have CONT_PTES (since we only use this for ptes currently) and
CONT_MASK used instead of CONT_RANGE_MASK. This is for consistency with
SECTION_MASK which we already use.

-- 
Catalin
