From: will.deacon@arm.com (Will Deacon)
Date: Tue, 4 Jun 2013 16:41:29 +0100
Subject: [PATCH v2 2/2] ARM PJ4B: Add support for errata 4611
In-Reply-To: <1370354598-12920-3-git-send-email-gregory.clement@free-electrons.com>
References: <1370354598-12920-1-git-send-email-gregory.clement@free-electrons.com>
 <1370354598-12920-3-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20130604154129.GT27516@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 04, 2013 at 03:03:18PM +0100, Gregory CLEMENT wrote:
> From: Lior Amsalem <alior@marvell.com>
> 
> A CP15 clean operation can result in a dead lock state if it is hit by
> an incoming snoop event. The fix to this issue is the following:
> before any CP15 clean type operation in Cache Coherency mode, issue a
> Data Memory Barrier (DMB) or a Data Synchronization Barrier (DSB)
> instruction.
> 
> [gregory.clement at free-electrons.com:add errata description in changelog]
> [gregory.clement at free-electrons.com:make this errata depend on Armada 370]
> Signed-off-by: Lior Amsalem <alior@marvell.com>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

[...]

> diff --git a/arch/arm/mm/proc-macros.S b/arch/arm/mm/proc-macros.S
> index f9a0aa7..9930e14 100644
> --- a/arch/arm/mm/proc-macros.S
> +++ b/arch/arm/mm/proc-macros.S
> @@ -178,7 +178,20 @@
>  #endif
>  
>  	str	r3, [r0]
> +
> +#ifdef CONFIG_PJ4B_ERRATA_4611
> +	mrs     r2, cpsr
> +	orr     r3, r2, #PSR_F_BIT | PSR_I_BIT
> +	msr     cpsr_c, r3			@ Disable interrupts
> +	dmb					@ ensure ordering with previous memory accesses
> +#endif
> +
>  	mcr	p15, 0, r0, c7, c10, 1		@ flush_pte
> +
> +#ifdef CONFIG_PJ4B_ERRATA_4611
> +	msr     cpsr_c, r2			@ Restore interrupts
> +	dsb					@ drain write buffer
> +#endif
>  	.endm
> 

There are save/restore IRQ macros in assembler.h, so you can use those here
instead of open-coding the cpsr manipulation. Sorry for missing this before.

Will
