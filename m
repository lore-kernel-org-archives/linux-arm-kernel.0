From: will.deacon@arm.com (Will Deacon)
Date: Thu, 6 Jun 2013 11:30:39 +0100
Subject: [PATCH v3 2/2] ARM PJ4B: Add support for errata 4611
In-Reply-To: <1370511044-31900-3-git-send-email-gregory.clement@free-electrons.com>
References: <1370511044-31900-1-git-send-email-gregory.clement@free-electrons.com>
 <1370511044-31900-3-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20130606103039.GN15208@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 06, 2013 at 10:30:44AM +0100, Gregory CLEMENT wrote:
> From: Lior Amsalem <alior@marvell.com>
> 
> A CP15 clean operation can result in a dead lock state if it is hit by
> an incoming snoop event. The fix to this issue is the following:
> before any CP15 clean type operation in Cache Coherency mode, issue a
> Data Memory Barrier (DMB) or a Data Synchronization Barrier (DSB)
> instruction.
> 
> [gregory.clement at free-electrons.com:use save/restore IRQ macros]
> [gregory.clement at free-electrons.com:add errata description in changelog]
> [gregory.clement at free-electrons.com:make this errata depend on Armada 370]
> Signed-off-by: Lior Amsalem <alior@marvell.com>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  arch/arm/Kconfig                |  9 +++++++++
>  arch/arm/include/asm/tlbflush.h | 22 ++++++++++++++++++++++
>  arch/arm/mm/proc-macros.S       | 11 +++++++++++
>  3 files changed, 42 insertions(+)

[...]

> diff --git a/arch/arm/mm/proc-macros.S b/arch/arm/mm/proc-macros.S
> index f9a0aa7..2eba2b7 100644
> --- a/arch/arm/mm/proc-macros.S
> +++ b/arch/arm/mm/proc-macros.S
> @@ -178,7 +178,18 @@
>  #endif
>  
>  	str	r3, [r0]
> +
> +#ifdef CONFIG_PJ4B_ERRATA_4611
> +        save_and_disable_irqs_notrace r2	@ Disable interrupts
> +	dmb					@ ensure ordering with previous memory accesses
> +#endif
> +
>  	mcr	p15, 0, r0, c7, c10, 1		@ flush_pte
> +
> +#ifdef CONFIG_PJ4B_ERRATA_4611
> +	restore_irqs_notrace r2			@ Restore interrupts
> +	dsb					@ drain write buffer
> +#endif

Wait: isn't this in armv6_set_pte_ext? Shouldn't you be looking at
proc-v7-{2,3}-level.S for the UP flushing?

Will
