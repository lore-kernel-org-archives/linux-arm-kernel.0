From: will.deacon@arm.com (Will Deacon)
Date: Wed, 29 May 2013 12:03:59 +0100
Subject: [PATCH 1/3] ARM PJ4B: Add support for errata 4742
In-Reply-To: <1369822618-26797-2-git-send-email-gregory.clement@free-electrons.com>
References: <1369822618-26797-1-git-send-email-gregory.clement@free-electrons.com>
 <1369822618-26797-2-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20130529110359.GE13095@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gregory,

On Wed, May 29, 2013 at 11:16:56AM +0100, Gregory CLEMENT wrote:
> From: Lior Amsalem <alior@marvell.com>
> 
> This commit fix the regression on Armada 370 (the kernal hang during
> boot) introduced by the commit: "ARM: 7691/1: mm: kill unused
> TLB_CAN_READ_FROM_L1_CACHE and use ALT_SMP instead".
> 
> When coming out of either a Wait for Interrupt (WFI) or a Wait for
> Event (WFE) IDLE states, a specific timing sensitivity exists between
> the retiring WFI/WFE instructions and the newly issued subsequent
> instructions. This sensitivity can result in a CPU hang scenario.  The
> workaround is to insert either a Data Synchronization Barrier (DSB) or
> Data Memory Barrier (DMB) command immediately after the WFI/WFE
> instruction

Thanks for chasing this up! I have no idea why the patch you mentioned
triggered this though.

> diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
> index 2c73a73..f872432 100644
> --- a/arch/arm/mm/proc-v7.S
> +++ b/arch/arm/mm/proc-v7.S
> @@ -71,6 +71,9 @@ ENDPROC(cpu_v7_reset)
>  ENTRY(cpu_v7_do_idle)
>  	dsb					@ WFI may enter a low-power mode
>  	wfi
> +#ifdef CONFIG_PJ4B_ERRATA_4742
> +        mcr     p15, 0, r0, c7, c10, 4          @barrier
> +#endif

Is the cp15 encoding required here, or can you just use `dsb'?

Will
