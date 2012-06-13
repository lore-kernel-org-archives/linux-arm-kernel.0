From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 13 Jun 2012 10:32:18 +0100
Subject: [RFC/PATCH v5 5/7] ARM: ARM11 MPCore: cpu_v6_dcache_clean_area
 needs RFO
In-Reply-To: <1339533618-15969-6-git-send-email-gdavis@mvista.com>
References: <1318945654-548-1-git-send-email-gdavis@mvista.com>
 <1339533618-15969-1-git-send-email-gdavis@mvista.com>
 <1339533618-15969-6-git-send-email-gdavis@mvista.com>
Message-ID: <20120613093218.GC29492@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 12, 2012 at 09:40:16PM +0100, gdavis at mvista.com wrote:
> From: George G. Davis <gdavis@mvista.com>
> 
> Implement Request-For-Ownership in cpu_v6_dcache_clean_area and
> disable preemption in same to insure that memory is consistent
> in cases of preemption and subsequent task migration just before
> and during calls to this function.  This is an alternative
> implementation to other workarounds which disable preemption
> in callers of this function while updating PTEs.
> 
> This change depends on "ARM: Move get_thread_info macro definition
> to <asm/assembler.h>".
> 
> Signed-off-by: George G. Davis <gdavis@mvista.com>
> ---
>  arch/arm/mm/proc-v6.S |   22 +++++++++++++++++++++-
>  1 files changed, 21 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mm/proc-v6.S b/arch/arm/mm/proc-v6.S
> index 5900cd5..de8b3a6 100644
> --- a/arch/arm/mm/proc-v6.S
> +++ b/arch/arm/mm/proc-v6.S
> @@ -81,10 +81,30 @@ ENTRY(cpu_v6_do_idle)
>  
>  ENTRY(cpu_v6_dcache_clean_area)
>  #ifndef TLB_CAN_READ_FROM_L1_CACHE
> -1:	mcr	p15, 0, r0, c7, c10, 1		@ clean D entry
> +#if	defined(CONFIG_SMP) && defined(CONFIG_PREEMPT)
> +	get_thread_info ip
> +	ldr	r3, [ip, #TI_PREEMPT]		@ get preempt count
> +	add	r2, r3, #1			@ increment it
> +	str	r2, [ip, #TI_PREEMPT]		@ disable preemption
> +#endif
> +1:
> +#ifdef CONFIG_SMP
> +	/* no cache maintenance broadcasting on ARM11MPCore */
> +	ldr	r2, [r0]			@ read for ownership
> +#endif
> +	mcr	p15, 0, r0, c7, c10, 1		@ clean D entry
>  	add	r0, r0, #D_CACHE_LINE_SIZE
>  	subs	r1, r1, #D_CACHE_LINE_SIZE
>  	bhi	1b
> +#if	defined(CONFIG_SMP) && defined(CONFIG_PREEMPT)
> +	teq	r3, #0				@ preempt count == 0?
> +	str	r3, [ip, #TI_PREEMPT]		@ restore preempt count
> +	bne	99f				@ done if non-zero
> +	ldr	r3, [ip, #TI_FLAGS]		@ else check flags
> +	tst	r3, #_TIF_NEED_RESCHED		@ need resched?
> +	bne	preempt_schedule		@ yes, do preempt_schedule

Maybe we should get some asm macros for preempt disable/enable as they
are used in more than one place.

Alternatively, we could disable the interrupts around RFO and D-cache
cleaning (inside the loop), though I think the preempt disabling is
faster.

-- 
Catalin
