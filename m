From: Dave.Martin@arm.com (Dave Martin)
Date: Mon, 18 Nov 2013 13:39:48 +0000
Subject: [PATCH] ARM: signal: fix armv7-m build issue in sigreturn_codes.S
In-Reply-To: <1384157427-31613-2-git-send-email-victor.kamensky@linaro.org>
References: <1384157427-31613-1-git-send-email-victor.kamensky@linaro.org>
 <1384157427-31613-2-git-send-email-victor.kamensky@linaro.org>
Message-ID: <20131118132844.GA2308@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 11, 2013 at 12:10:27AM -0800, Victor Kamensky wrote:
> In case of armv7-m architecture arm instructions are not allowed.
> For this architecture CONFIG_CPU_THUMBONLY is set. Use this macro
> to emit conditionally arm instructions or nops in thumb mode.
> 
> Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
> ---
>  arch/arm/kernel/sigreturn_codes.S | 25 ++++++++++++++++++-------
>  1 file changed, 18 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/kernel/sigreturn_codes.S b/arch/arm/kernel/sigreturn_codes.S
> index 3c5d0f2..899fb86 100644
> --- a/arch/arm/kernel/sigreturn_codes.S
> +++ b/arch/arm/kernel/sigreturn_codes.S
> @@ -41,17 +41,29 @@
>  	.arch armv4t
>  #endif
>  
> +/*
> + * In CPU_THUMBONLY kernel case arm opcodes are not allowed
> + */
> +#ifndef CONFIG_CPU_THUMBONLY
> +#define ARM_INSTR(code...) .arm ; \
> +			   code
> +#else
> +#define ARM_INSTR(code...) .thumb ; \
> +			   nop ;    \
> +			   nop ;
> +#endif
> +

Maybe use .org to force the layout, instead of nop-padding,
and don't emit the ARM instructions at all in the THUMBONLY
case.

So, this becomes something like:

sigreturn_codes:

#ifndef CONFIG_CPU_THUMBONLY
	.arm
	mov	r7, #(__NR_sigreturn - __NR_SYSCALL_BASE)
	swi	#(__NR_sigreturn)|(__NR_OABI_SYSCALL_BASE)
#endif
	.org	sigreturn_codes + 8 + 12 * 0
	.thumb
        movs	r7, #(__NR_sigreturn - __NR_SYSCALL_BASE)
        swi	#0

#ifndef CONFIG_CPU_THUMBONLY
	.arm
	mov	r7, #(__NR_rt_sigreturn - __NR_SYSCALL_BASE)
	swi	#(__NR_rt_sigreturn)|(__NR_OABI_SYSCALL_BASE)
#endif
	.org	sigreturn_codes + 8 + 12 * 1
	.thumb
	movs	r7, #(__NR_rt_sigreturn - __NR_SYSCALL_BASE)
	swi	#0

...etc.

This will just leave gaps in the right places without needing
to worry about what to fill them with (which shouldn't matter).

Ideally the ifdefs can be hidden with macros to make things
look a bit less ugly.  You could keep ARM_INSTR() unmodified,
and define separate macros that spit out the .org and related
stuff, like:

.macro arm_slot n
		.org	sigreturn_codes + 12 * (\n)
 ARM_INSTR(	.arm	)
.endm

.macro thumb_slot n
		.org	sigreturn_codes + 12 * (\n) + 8
		.thumb
.endm


Then you get

sigreturn_codes:

arm_slot 0
 ARM_INSTR(	mov	r7, #(__NR_sigreturn - __NR_SYSCALL_BASE)	)
 ARM_INSTR(	mov	r7, #(__NR_sigreturn - __NR_SYSCALL_BASE)	)
thumb_slot 0
	        movs	r7, #(__NR_sigreturn - __NR_SYSCALL_BASE)
	        swi	#0

arm_slot 1
 ARM_INSTR(	mov	r7, #(__NR_rt_sigreturn - __NR_SYSCALL_BASE)	)
 ARM_INSTR(	swi	#(__NR_rt_sigreturn)|(__NR_OABI_SYSCALL_BASE)	)
thumb_slot 1
		movs	r7, #(__NR_rt_sigreturn - __NR_SYSCALL_BASE)
		swi	#0

Still not ideal, but it might work.

Cheers
---Dave

>  	.section .rodata
>  	.global sigreturn_codes
>  	.type	sigreturn_codes, #object
>  
> -	.arm
> +	.align
>  
>  sigreturn_codes:
>  
>  	/* ARM sigreturn syscall code snippet */
> -	mov	r7, #(__NR_sigreturn - __NR_SYSCALL_BASE)
> -	swi	#(__NR_sigreturn)|(__NR_OABI_SYSCALL_BASE)
> +ARM_INSTR(mov	r7, #(__NR_sigreturn - __NR_SYSCALL_BASE))
> +ARM_INSTR(swi	#(__NR_sigreturn)|(__NR_OABI_SYSCALL_BASE))
>  
>  	/* Thumb sigreturn syscall code snippet */
>  	.thumb
> @@ -59,9 +71,8 @@ sigreturn_codes:
>  	swi	#0
>  
>  	/* ARM sigreturn_rt syscall code snippet */
> -	.arm
> -	mov	r7, #(__NR_rt_sigreturn - __NR_SYSCALL_BASE)
> -	swi	#(__NR_rt_sigreturn)|(__NR_OABI_SYSCALL_BASE)
> +ARM_INSTR(mov	r7, #(__NR_rt_sigreturn - __NR_SYSCALL_BASE))
> +ARM_INSTR(swi	#(__NR_rt_sigreturn)|(__NR_OABI_SYSCALL_BASE))
>  
>  	/* Thumb sigreturn_rt syscall code snippet */
>  	.thumb
> @@ -74,7 +85,7 @@ sigreturn_codes:
>  	 * it is thumb case or not, so we need additional
>  	 * word after real last entry.
>  	 */
> -	.arm
> +	.align
>  	.space	4
>  
>  	.size	sigreturn_codes, . - sigreturn_codes
> -- 
> 1.8.1.4
> 
> 
> _______________________________________________
> linaro-kernel mailing list
> linaro-kernel at lists.linaro.org
> http://lists.linaro.org/mailman/listinfo/linaro-kernel
