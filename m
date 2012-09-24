From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 24 Sep 2012 15:45:31 +0100
Subject: [PATCH v3 RESEND 13/17] ARM: LPAE: factor out T1SZ and TTBR1
 computations
In-Reply-To: <1348242975-19184-14-git-send-email-cyril@ti.com>
References: <1348242975-19184-1-git-send-email-cyril@ti.com>
 <1348242975-19184-14-git-send-email-cyril@ti.com>
Message-ID: <20120924144531.GI23298@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 21, 2012 at 04:56:11PM +0100, Cyril Chemparathy wrote:
> This patch moves the TTBR1 offset calculation and the T1SZ calculation out
> of the TTB setup assembly code.  This should not affect functionality in
> any way, but improves code readability as well as readability of subsequent
> patches in this series.
> 
> Signed-off-by: Cyril Chemparathy <cyril@ti.com>
> Signed-off-by: Vitaly Andrianov <vitalya@ti.com>
> Acked-by: Nicolas Pitre <nico@linaro.org>
> ---
>  arch/arm/include/asm/pgtable-3level-hwdef.h |   10 ++++++++++
>  arch/arm/mm/proc-v7-3level.S                |   16 ++++------------
>  2 files changed, 14 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm/include/asm/pgtable-3level-hwdef.h b/arch/arm/include/asm/pgtable-3level-hwdef.h
> index d795282..b501650 100644
> --- a/arch/arm/include/asm/pgtable-3level-hwdef.h
> +++ b/arch/arm/include/asm/pgtable-3level-hwdef.h
> @@ -74,4 +74,14 @@
>  #define PHYS_MASK_SHIFT		(40)
>  #define PHYS_MASK		((1ULL << PHYS_MASK_SHIFT) - 1)
>  
> +#if defined CONFIG_VMSPLIT_2G
> +#define TTBR1_OFFSET	(1 << 4)		/* skip two L1 entries */

I know that was my code but I'm wondering why the (1<<4) rather than
just a plain 16.

> +#elif defined CONFIG_VMSPLIT_3G
> +#define TTBR1_OFFSET	(4096 * (1 + 3))	/* only L2, skip pgd + 3*pmd */
> +#else
> +#define TTBR1_OFFSET	0
> +#endif
> +
> +#define TTBR1_SIZE	(((PAGE_OFFSET >> 30) - 1) << 16)

You could also move the comment about TxSZ in proc-v7-3level.S, it makes
it easier to figure out why TTBR1_SIZE is defined this way.

> --- a/arch/arm/mm/proc-v7-3level.S
> +++ b/arch/arm/mm/proc-v7-3level.S
> @@ -128,18 +128,10 @@ ENDPROC(cpu_v7_set_pte_ext)
>  	 * booting secondary CPUs would end up using TTBR1 for the identity
>  	 * mapping set up in TTBR0.
>  	 */

Higher up in this file there is a cmp with a "branch below" comment. You
should remove that as well since the 9001 branch was removed.

-- 
Catalin
