From: dave.martin@linaro.org (Dave Martin)
Date: Tue, 22 Mar 2011 12:52:17 +0000
Subject: [PATCH] ARM: kernel/sleep.S: fix Thumb2 compilation issues
In-Reply-To: <alpine.LFD.2.00.1103182256330.26889@xanadu.home>
References: <alpine.LFD.2.00.1103182256330.26889@xanadu.home>
Message-ID: <20110322125216.GA4190@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 18, 2011 at 11:00:02PM -0400, Nicolas Pitre wrote:
> 
> Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> 
> diff --git a/arch/arm/kernel/sleep.S b/arch/arm/kernel/sleep.S
> index bfad698..6398ead 100644
> --- a/arch/arm/kernel/sleep.S
> +++ b/arch/arm/kernel/sleep.S
> @@ -119,11 +119,19 @@ ENTRY(cpu_resume)
>  #else
>  	ldr	r0, sleep_save_sp	@ stack phys addr
>  #endif
> -	msr	cpsr_c, #PSR_I_BIT | PSR_F_BIT | SVC_MODE @ set SVC, irqs off
> +	setmode	PSR_I_BIT | PSR_F_BIT | SVC_MODE, r1  @ set SVC, irqs off
>  #ifdef MULTI_CPU
> -	ldmia	r0!, {r1, sp, lr, pc}	@ load v:p, stack, return fn, resume fn
> +	@ load v:p, stack, return fn, resume fn
> +  ARM(	ldmia	r0!, {r1, sp, lr, pc}	)
> +THUMB(	ldmia	r0!, {r1, r2, r3, r4}	)
> +THUMB(	mov	sp, r2			)
> +THUMB(	mov	lr, r3			)
> +THUMB(	bx	r4			)
>  #else
> -	ldmia	r0!, {r1, sp, lr}	@ load v:p, stack, return fn
> +	@ load v:p, stack, return fn
> +  ARM(	ldmia	r0!, {r1, sp, lr}	)
> +THUMB(	ldmia	r0!, {r1, r2, lr}	)
> +THUMB(	mov	sp, r2			)
>  	b	cpu_do_resume
>  #endif
>  ENDPROC(cpu_resume)

As far as I can determine from the context, r1-r4 are not live at
this point, so the suggested change looks sound.

Reviewed-by: Dave Martin <dave.martin@linaro.org>

I haven't watched the generic suspend/resume discussion too
closely; how would I go about testing this?

Cheers
---Dave
