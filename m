From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 8 Sep 2014 11:49:39 -0400 (EDT)
Subject: [PATCH v3 3/5] arm: fiq: Replace default FIQ handler
In-Reply-To: <1410190115-32604-4-git-send-email-daniel.thompson@linaro.org>
References: <1409931198-22600-1-git-send-email-daniel.thompson@linaro.org>
 <1410190115-32604-1-git-send-email-daniel.thompson@linaro.org>
 <1410190115-32604-4-git-send-email-daniel.thompson@linaro.org>
Message-ID: <alpine.LFD.2.11.1409081140360.16533@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 8 Sep 2014, Daniel Thompson wrote:

> +@
> +@ Taking a FIQ in abort mode is similar to taking a FIQ in SVC mode
> +@ and reuses the same macros. However in abort mode we must also
> +@ save/restore lr_abt and spsr_abt to make nested aborts safe.
> +@
> +	.align 5
> +__fiq_abt:
> +	svc_entry 0, 0
> +
> + ARM(	msr	cpsr_c, #ABT_MODE | PSR_I_BIT | PSR_F_BIT )
> + THUMB( mov	r0, #ABT_MODE | PSR_I_BIT | PSR_F_BIT )
> + THUMB( msr	cpsr_c, r0 )
> +	mov	r1, lr		@ Save lr_abt
> +	mrs	r2, spsr	@ Save spsr_abt, abort is now safe
> + ARM(	msr	cpsr_c, #SVC_MODE | PSR_I_BIT | PSR_F_BIT )
> + THUMB( mov	r0, #SVC_MODE | PSR_I_BIT | PSR_F_BIT )
> + THUMB( msr	cpsr_c, r0 )
> +	push	{r1 - r2}

	stmfd sp!, {r1 - r2}

> +
> +	sub	r0, sp, #8			@ struct pt_regs *regs
> +	bl	handle_fiq_as_nmi
> +
> +	pop	{r1 - r2}

	ldmfd sp!, {r1 - r2}

... so that old binutils we still accept to compile the kernel (in ARM 
mode) are happy.

Otherwise...

Acked-by: Nicolas Pitre <nico@linaro.org>


Nicolas
