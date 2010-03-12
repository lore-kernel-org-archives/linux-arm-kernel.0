From: grfstrm@users.sourceforge.net (=?ISO-8859-1?Q?Anders_Grafstr=F6m?=)
Date: Fri, 12 Mar 2010 18:30:36 +0100
Subject: [PATCH 03/11] Thumb-2: Implementation of the unified start-up
	and	exceptions code
In-Reply-To: <20090602130549.12732.15147.stgit@pc1117.cambridge.arm.com>
References: <20090602130549.12732.15147.stgit@pc1117.cambridge.arm.com>
Message-ID: <4B9A7A3C.9000304@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Catalin Marinas wrote:
> diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
> index b55cb03..9341b38 100644
> --- a/arch/arm/kernel/entry-common.S
> +++ b/arch/arm/kernel/entry-common.S
> @@ -33,14 +33,7 @@ ret_fast_syscall:
>  	/* perform architecture specific actions before user return */
>  	arch_ret_to_user r1, lr
>  
> -	@ fast_restore_user_regs
> -	ldr	r1, [sp, #S_OFF + S_PSR]	@ get calling cpsr
> -	ldr	lr, [sp, #S_OFF + S_PC]!	@ get pc
> -	msr	spsr_cxsf, r1			@ save in spsr_svc
> -	ldmdb	sp, {r1 - lr}^			@ get calling r1 - lr
> -	mov	r0, r0
> -	add	sp, sp, #S_FRAME_SIZE - S_PC
> -	movs	pc, lr				@ return & move spsr_svc into cpsr
> +	restore_user_regs fast = 1, offset = S_OFF
>   UNWIND(.fnend		)
>  
>  /*
> @@ -73,14 +66,7 @@ no_work_pending:
>  	/* perform architecture specific actions before user return */
>  	arch_ret_to_user r1, lr
>  
> -	@ slow_restore_user_regs
> -	ldr	r1, [sp, #S_PSR]		@ get calling cpsr
> -	ldr	lr, [sp, #S_PC]!		@ get pc
> -	msr	spsr_cxsf, r1			@ save in spsr_svc
> -	ldmdb	sp, {r0 - lr}^			@ get calling r0 - lr
> -	mov	r0, r0
> -	add	sp, sp, #S_FRAME_SIZE - S_PC
> -	movs	pc, lr				@ return & move spsr_svc into cpsr
> +	restore_user_regs fast = 0, offset = 0
>  ENDPROC(ret_to_user)
>  
>  /*

> diff --git a/arch/arm/kernel/entry-header.S b/arch/arm/kernel/entry-header.S
> +
> +	.macro	restore_user_regs, fast = 0, offset = 0
> +	ldr	r1, [sp, #\offset + S_PSR]	@ get calling cpsr
> +	ldr	lr, [sp, #\offset + S_PC]!	@ get pc
> +	msr	spsr_cxsf, r1			@ save in spsr_svc
> +	.if	\fast
> +	ldmdb	sp, {r1 - lr}^			@ get calling r1 - lr
> +	.else
> +	ldmdb	sp, {r0 - lr}^			@ get calling r0 - lr
> +	.endif
> +	add	sp, sp, #S_FRAME_SIZE - S_PC
> +	movs	pc, lr				@ return & move spsr_svc into cpsr
> +	.endm

This commit seems to have broken things for ARM720T and it looks like
the removal of the "mov r0, r0" instruction in restore_user_regs is what caused it.

The patch below makes it work again but why?

diff --git a/arch/arm/kernel/entry-header.S b/arch/arm/kernel/entry-header.S
index 7e9ed1e..516d14e 100644
--- a/arch/arm/kernel/entry-header.S
+++ b/arch/arm/kernel/entry-header.S
@@ -102,6 +102,7 @@
 	.else
 	ldmdb	sp, {r0 - lr}^			@ get calling r0 - lr
 	.endif
+	mov	r0, r0
 	add	sp, sp, #S_FRAME_SIZE - S_PC
 	movs	pc, lr				@ return & move spsr_svc into cpsr
 	.endm
