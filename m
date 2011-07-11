From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 11 Jul 2011 14:07:05 -0400 (EDT)
Subject: [PATCH 01/51] ARM: Thumb-2: Fix exception return sequence to
	restore stack correctly
In-Reply-To: <1310209058-20980-2-git-send-email-tixy@yxit.co.uk>
References: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
	<1310209058-20980-2-git-send-email-tixy@yxit.co.uk>
Message-ID: <alpine.LFD.2.00.1107111406240.14596@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 9 Jul 2011, Tixy wrote:

> From: Jon Medhurst <tixy@yxit.co.uk>
> 
> The implementation of svc_exit didn't take into account any stack hole
> created by svc_entry; as happens with the undef handler when kprobes are
> configured. The fix is to read the saved value of SP rather than trying
> to calculate it.
> 
> Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>

Reviewed-by: Nicolas Pitre <nicolas.pitre@linaro.org>


> ---
>  arch/arm/kernel/entry-header.S |   12 +++++-------
>  1 files changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/kernel/entry-header.S b/arch/arm/kernel/entry-header.S
> index 051166c..83e29ad 100644
> --- a/arch/arm/kernel/entry-header.S
> +++ b/arch/arm/kernel/entry-header.S
> @@ -121,15 +121,13 @@
>  	.endm
>  #else	/* CONFIG_THUMB2_KERNEL */
>  	.macro	svc_exit, rpsr
> +	ldr	lr, [sp, #S_SP]			@ top of the stack
> +	ldrd	r0, r1, [sp, #S_LR]		@ calling lr and pc
>  	clrex					@ clear the exclusive monitor
> -	ldr	r0, [sp, #S_SP]			@ top of the stack
> -	ldr	r1, [sp, #S_PC]			@ return address
> -	tst	r0, #4				@ orig stack 8-byte aligned?
> -	stmdb	r0, {r1, \rpsr}			@ rfe context
> +	stmdb	lr!, {r0, r1, \rpsr}		@ calling lr and rfe context
>  	ldmia	sp, {r0 - r12}
> -	ldr	lr, [sp, #S_LR]
> -	addeq	sp, sp, #S_FRAME_SIZE - 8	@ aligned
> -	addne	sp, sp, #S_FRAME_SIZE - 4	@ not aligned
> +	mov	sp, lr
> +	ldr	lr, [sp], #4
>  	rfeia	sp!
>  	.endm
>  
> -- 
> 1.7.2.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
