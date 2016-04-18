From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 18 Apr 2016 18:20:17 +0100
Subject: [PATCH v7 08/16] arm64: kernel: Rework finisher callback out of
 __cpu_suspend_enter().
In-Reply-To: <1459529620-22150-9-git-send-email-james.morse@arm.com>
References: <1459529620-22150-1-git-send-email-james.morse@arm.com>
 <1459529620-22150-9-git-send-email-james.morse@arm.com>
Message-ID: <20160418172017.GG18257@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 01, 2016 at 05:53:32PM +0100, James Morse wrote:
> +/*
> + * Memory to save the cpu state is allocated on the stack by
> + * __cpu_suspend_enter()'s caller, and populated by __cpu_suspend_enter().
> + * This data must survive until cpu_resume() is called.
> + *
> + * This struct desribes the size and the layout of the saved cpu state.

s/desribes/describes/

> @@ -93,34 +86,11 @@ ENTRY(__cpu_suspend_enter)
>  	ldp	w5, w6, [x9, #(MPIDR_HASH_SHIFTS + 8)]
>  	compute_mpidr_hash x8, x3, x4, x5, x6, x7, x10
>  	add	x1, x1, x8, lsl #3
> +
> +	push	x29, lr
>  	bl	__cpu_suspend_save
> -	/*
> -	 * Grab suspend finisher in x20 and its argument in x19
> -	 */
> -	mov	x0, x19
> -	mov	x1, x20
> -	/*
> -	 * We are ready for power down, fire off the suspend finisher
> -	 * in x1, with argument in x0
> -	 */
> -	blr	x1
> -        /*
> -	 * Never gets here, unless suspend finisher fails.
> -	 * Successful cpu_suspend should return from cpu_resume, returning
> -	 * through this code path is considered an error
> -	 * If the return value is set to 0 force x0 = -EOPNOTSUPP
> -	 * to make sure a proper error condition is propagated
> -	 */
> -	cmp	x0, #0
> -	mov	x3, #-EOPNOTSUPP
> -	csel	x0, x3, x0, eq
> -	add	sp, sp, #CPU_SUSPEND_SZ	// rewind stack pointer
> -	ldp	x19, x20, [sp, #16]
> -	ldp	x21, x22, [sp, #32]
> -	ldp	x23, x24, [sp, #48]
> -	ldp	x25, x26, [sp, #64]
> -	ldp	x27, x28, [sp, #80]
> -	ldp	x29, lr, [sp], #96
> +	pop	x29, lr
> +	mov	x0, #1

Please do not use the push/pop macros. I was planning to remove them but
there was still some KVM code using them. Now it seems that the code is
gone, so feel free to remove them from assembler.h (maybe as part of the
second patch moving proc-macros.S into assembler.h).

-- 
Catalin
