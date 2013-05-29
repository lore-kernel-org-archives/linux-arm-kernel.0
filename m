From: will.deacon@arm.com (Will Deacon)
Date: Wed, 29 May 2013 12:16:33 +0100
Subject: [PATCH 2/3] ARM PJ4B: Add support for errata 6124
In-Reply-To: <1369822618-26797-3-git-send-email-gregory.clement@free-electrons.com>
References: <1369822618-26797-1-git-send-email-gregory.clement@free-electrons.com>
 <1369822618-26797-3-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20130529111633.GF13095@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 29, 2013 at 11:16:57AM +0100, Gregory CLEMENT wrote:
> From: Lior Amsalem <alior@marvell.com>
> 
> A rare timing scenario exists where a clean operation occurs, followed
> by an additional store operation. If a matching snoop also occurs, it
> is possible for the write-back from the original clean operation and
> the intervention from the snoop to race, which could result in data
> corruption.
> Replacing all clean cache maintenance operations with Clean &
> Invalidate operation to avoid the issue

Curious: do you not have a chicken bit for this? Upgrading clean to clean &
invalidate is a pretty common thing to do and is even architected with the
virtualisation extensions.

> [gregory.clement at free-electrons.com:add errata description in changelog]
> [gregory.clement at free-electrons.com: make this errata depend on Aramda
> XP]
> Signed-off-by: Lior Amsalem <alior@marvell.com>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  arch/arm/Kconfig                | 13 +++++++++++++
>  arch/arm/include/asm/tlbflush.h |  8 ++++++++
>  arch/arm/mm/cache-v7.S          |  8 ++++++++
>  arch/arm/mm/proc-v7-2level.S    |  4 ++++
>  arch/arm/mm/proc-v7-3level.S    |  4 ++++
>  arch/arm/mm/proc-v7.S           |  4 ++++
>  6 files changed, 41 insertions(+)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 745781f..48cdbea 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1099,6 +1099,19 @@ config PJ4B_ERRATA_4742
>  	  The software must insert either a Data Synchronization Barrier (DSB)
>  	  or Data Memory Barrier (DMB) command immediately after the WFI/WFE instruction
>  
> +config PJ4B_ERRATA_6124
> +        bool "PJ4B Errata 6124: Multiple writebacks can be issued in a rare timing scenario associated with a clean operation and an incoming snoop"
> +        depends on CPU_PJ4B && MACH_ARMADA_XP
> +        help
> +	  A rare timing scenario exists where a clean operation occurs, followed
> +	  by an additional store operation. If a matching snoop also occurs, it
> +	  is possible for the write-back from the original clean operation and
> +	  the intervention from the snoop to race, which could result in data
> +	  corruption.
> +	  Workaround:
> +	  Replacing all clean cache maintenance operations with
> +	  Clean & Invalidate operation will avoid the issue
> +
>  config ARM_ERRATA_326103
>  	bool "ARM errata: FSR write bit incorrect on a SWP to read-only memory"
>  	depends on CPU_V6
> diff --git a/arch/arm/include/asm/tlbflush.h b/arch/arm/include/asm/tlbflush.h
> index a3625d1..e3a8064 100644
> --- a/arch/arm/include/asm/tlbflush.h
> +++ b/arch/arm/include/asm/tlbflush.h
> @@ -475,7 +475,11 @@ static inline void flush_pmd_entry(void *pmd)
>  {
>  	const unsigned int __tlb_flag = __cpu_tlb_flags;
>  
> +#ifdef CONFIG_PJ4B_ERRATA_6124
> +	tlb_op(TLB_DCLEAN, "c7, c14, 1	@ flush_pmd", pmd);

Can you elaborate on the comment please?

> +#else
>  	tlb_op(TLB_DCLEAN, "c7, c10, 1	@ flush_pmd", pmd);
> +#endif
>  	tlb_l2_op(TLB_L2CLEAN_FR, "c15, c9, 1  @ L2 flush_pmd", pmd);
>  
>  	if (tlb_flag(TLB_WB))
> @@ -486,7 +490,11 @@ static inline void clean_pmd_entry(void *pmd)
>  {
>  	const unsigned int __tlb_flag = __cpu_tlb_flags;
>  
> +#ifdef CONFIG_PJ4B_ERRATA_6124
> +	tlb_op(TLB_DCLEAN, "c7, c14, 1	@ flush_pmd", pmd);

and here.

> +#else
>  	tlb_op(TLB_DCLEAN, "c7, c10, 1	@ flush_pmd", pmd);
> +#endif
>  	tlb_l2_op(TLB_L2CLEAN_FR, "c15, c9, 1  @ L2 flush_pmd", pmd);
>  }
>  
> diff --git a/arch/arm/mm/cache-v7.S b/arch/arm/mm/cache-v7.S
> index 15451ee..d353649 100644
> --- a/arch/arm/mm/cache-v7.S
> +++ b/arch/arm/mm/cache-v7.S
> @@ -270,7 +270,11 @@ ENTRY(v7_coherent_user_range)
>  	ALT_UP(W(nop))
>  #endif
>  1:
> +#ifdef CONFIG_PJ4B_ERRATA_6124
> + USER(	mcr	p15, 0, r12, c7, c14, 1	)	@ clean & invalidate D line to the point of unification

This flushes to the point of coherency (there is no PoU clean & inv).

> +#else
>   USER(	mcr	p15, 0, r12, c7, c11, 1	)	@ clean D line to the point of unification
> +#endif
>  	add	r12, r12, r2
>  	cmp	r12, r1
>  	blo	1b
> @@ -378,7 +382,11 @@ v7_dma_clean_range:
>  	ALT_UP(W(nop))
>  #endif
>  1:
> +#ifdef CONFIG_PJ4B_ERRATA_6124
> +	mcr	p15, 0, r0, c7, c14, 1		@ clean & invalidate D line to the point of unification

Similarly, although I don't understand why you care about the erratum for
dma_clean_range. There should be no pending stores to the buffer, otherwise
you risk corruption anyway (from the device's point of view).

> +#else
>  	mcr	p15, 0, r0, c7, c10, 1		@ clean D / U line
> +#endif
>  	add	r0, r0, r2
>  	cmp	r0, r1
>  	blo	1b
> diff --git a/arch/arm/mm/proc-v7-2level.S b/arch/arm/mm/proc-v7-2level.S
> index 9704097..0999fd3 100644
> --- a/arch/arm/mm/proc-v7-2level.S
> +++ b/arch/arm/mm/proc-v7-2level.S
> @@ -111,8 +111,12 @@ ENTRY(cpu_v7_set_pte_ext)
>   THUMB(	add	r0, r0, #2048 )
>   THUMB(	str	r3, [r0] )
>  	ALT_SMP(mov	pc,lr)
> +#ifdef CONFIG_PJ4B_ERRATA_6124
> +	ALT_UP (mcr	p15, 0, r0, c7, c14, 1)		@ flush_pte by clean & invalidate D entry

The use of `by' is a bit confusing, since you can also do maintenance by
set/way.

> +#else
>  	ALT_UP (mcr	p15, 0, r0, c7, c10, 1)		@ flush_pte
>  #endif
> +#endif
>  	mov	pc, lr
>  ENDPROC(cpu_v7_set_pte_ext)
>  
> diff --git a/arch/arm/mm/proc-v7-3level.S b/arch/arm/mm/proc-v7-3level.S
> index 363027e..7a917ff 100644
> --- a/arch/arm/mm/proc-v7-3level.S
> +++ b/arch/arm/mm/proc-v7-3level.S
> @@ -74,8 +74,12 @@ ENTRY(cpu_v7_set_pte_ext)
>  	orreq	r2, #L_PTE_RDONLY
>  1:	strd	r2, r3, [r0]
>  	ALT_SMP(mov	pc, lr)
> +#ifdef CONFIG_PJ4B_ERRATA_6124
> +	ALT_UP (mcr	p15, 0, r0, c7, c14, 1)		@ flush_pte by clean & invalidate D entry
> +#else
>  	ALT_UP (mcr	p15, 0, r0, c7, c10, 1)		@ flush_pte
>  #endif
> +#endif
>  	mov	pc, lr
>  ENDPROC(cpu_v7_set_pte_ext)
>  
> diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
> index f872432..b86d688 100644
> --- a/arch/arm/mm/proc-v7.S
> +++ b/arch/arm/mm/proc-v7.S
> @@ -81,7 +81,11 @@ ENTRY(cpu_v7_dcache_clean_area)
>  	ALT_SMP(mov	pc, lr)			@ MP extensions imply L1 PTW
>  	ALT_UP(W(nop))
>  	dcache_line_size r2, r3

You could move the 1: label here.

> +#ifdef CONFIG_PJ4B_ERRATA_6124
> +1:	mcr	p15, 0, r0, c7, c14, 1		@ clean & invalidate D entry
> +#else
>  1:	mcr	p15, 0, r0, c7, c10, 1		@ clean D entry
> +#endif

Will
