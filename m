From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 11 Jan 2013 12:05:44 +0100
Subject: [PATCH v7 3/3] Cortex-M3: Add support for exception handling
In-Reply-To: <1350462872-16805-4-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1350462872-16805-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1350462872-16805-4-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20130111110544.GG14860@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, Oct 17, 2012 at 10:34:32AM +0200, Uwe Kleine-K?nig wrote:
> +/*
> + * Register switch for ARMv7-M processors.
> + * r0 = previous task_struct, r1 = previous thread_info, r2 = next thread_info
> + * previous and next are guaranteed not to be the same.
> + */
> +ENTRY(__switch_to)
> +	.fnstart
> +	.cantunwind
> +	add	ip, r1, #TI_CPU_SAVE
> +	stmia	ip!, {r4 - r11}		@ Store most regs on stack
> +	str	sp, [ip], #4
> +	str	lr, [ip], #4
> +	mov	r5, r0
> +	add	r4, r2, #TI_CPU_SAVE
> +	ldr	r0, =thread_notify_head
> +	mov	r1, #THREAD_NOTIFY_SWITCH
> +	bl	atomic_notifier_call_chain
> +	mov	ip, r4
> +	mov	r0, r5
> +	ldmia	ip!, {r4 - r11}		@ Load all regs saved previously
> +	ldr	sp, [ip], #4
> +	ldr	pc, [ip]
> +	.fnend
> +ENDPROC(__switch_to)
this code triggers a warning

	This instruction may be unpredictable if executed on M-profile
	cores with interrupts enabled.

with newer toolchains (seen with gcc 4.7.2) because of errata 752419
(Interrupted loads to SP can cause erroneous behaviour) which badly
affects the following instructions:

	ldr	sp,[Rn],#imm
	ldr	sp,[Rn,#imm]!

I think it's not a problem here as irqs are off during task switching,
but when changing

	ldr	sp, [ip], #4
	ldr	pc, [ip]

to

	ldr	sp, [ip]
	ldr	pc, [ip, #4]!

the result is equivalent and gcc is happy.

I fixed that accordingly in my for-next branch.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
