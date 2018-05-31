From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 31 May 2018 16:55:43 +0100
Subject: [PATCH 3/3] ARM: spectre-v1: fix syscall entry
In-Reply-To: <E1fONfn-00070N-9W@rmk-PC.armlinux.org.uk>
References: <20180531133047.GS17671@n2100.armlinux.org.uk>
 <E1fONfn-00070N-9W@rmk-PC.armlinux.org.uk>
Message-ID: <20180531155543.t6b3feckgmq6ebwa@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 31, 2018 at 02:31:23PM +0100, Russell King wrote:
> Prevent speculation at the syscall table decoding by clamping the index
> used to zero on invalid system call numbers, and using the csdb
> speculative barrier.
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> ---
>  arch/arm/kernel/entry-common.S | 14 +++-----------
>  arch/arm/kernel/entry-header.S | 25 +++++++++++++++++++++++++
>  2 files changed, 28 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
> index 3c4f88701f22..78b9f20dd6a3 100644
> --- a/arch/arm/kernel/entry-common.S
> +++ b/arch/arm/kernel/entry-common.S
> @@ -242,9 +242,7 @@ ENTRY(vector_swi)
>  	tst	r10, #_TIF_SYSCALL_WORK		@ are we tracing syscalls?
>  	bne	__sys_trace
>  
> -	cmp	scno, #NR_syscalls		@ check upper syscall limit
> -	badr	lr, ret_fast_syscall		@ return address
> -	ldrcc	pc, [tbl, scno, lsl #2]		@ call sys_* routine
> +	invoke_syscall tbl, scno, r10, ret_fast_syscall
>  
>  	add	r1, sp, #S_OFF
>  2:	cmp	scno, #(__ARM_NR_BASE - __NR_SYSCALL_BASE)
> @@ -278,14 +276,8 @@ ENDPROC(vector_swi)
>  	mov	r1, scno
>  	add	r0, sp, #S_OFF
>  	bl	syscall_trace_enter
> -
> -	badr	lr, __sys_trace_return		@ return address
> -	mov	scno, r0			@ syscall number (possibly new)
> -	add	r1, sp, #S_R0 + S_OFF		@ pointer to regs
> -	cmp	scno, #NR_syscalls		@ check upper syscall limit
> -	ldmccia	r1, {r0 - r6}			@ have to reload r0 - r6
> -	stmccia	sp, {r4, r5}			@ and update the stack args
> -	ldrcc	pc, [tbl, scno, lsl #2]		@ call sys_* routine
> +	mov	scno, r0
> +	invoke_syscall tbl, scno, r10, __sys_trace_return, reload=1
>  	cmp	scno, #-1			@ skip the syscall?
>  	bne	2b
>  	add	sp, sp, #S_OFF			@ restore stack

I *think* you might also need to adjust sys_syscall.

> diff --git a/arch/arm/kernel/entry-header.S b/arch/arm/kernel/entry-header.S
> index 0f07579af472..773424843d6e 100644
> --- a/arch/arm/kernel/entry-header.S
> +++ b/arch/arm/kernel/entry-header.S
> @@ -378,6 +378,31 @@
>  #endif
>  	.endm
>  
> +	.macro	invoke_syscall, table, nr, tmp, ret, reload=0
> +#ifdef CONFIG_CPU_SPECTRE
> +	mov	\tmp, \nr
> +	cmp	\tmp, #NR_syscalls		@ check upper syscall limit
> +	movcs	\tmp, #0
> +	csdb

To the best of my understanding, this sequence is sufficient.

> +	badr	lr, \ret			@ return address
> +	.if	\reload
> +	add	r1, sp, #S_R0 + S_OFF		@ pointer to regs
> +	ldmccia	r1, {r0 - r6}			@ reload r0-r6
> +	stmccia	sp, {r4, r5}			@ update stack arguments
> +	.endif
> +	ldrcc	pc, [\table, \tmp, lsl #2]	@ call sys_* routine
> +#else
> +	cmp	\nr, #NR_syscalls		@ check upper syscall limit
> +	badr	lr, \ret			@ return address
> +	.if	\reload
> +	add	r1, sp, #S_R0 + S_OFF		@ pointer to regs
> +	ldmccia	r1, {r0 - r6}			@ reload r0-r6
> +	stmccia	sp, {r4, r5}			@ update stack arguments
> +	.endif
> +	ldrcc	pc, [\table, \nr, lsl #2]	@ call sys_* routine
> +#endif
> +	.endm

I couldn't find a nice way to avoid dupliacting the body without more
ifdeffery, given the nr parameter can't be clobbered.

So modulo sys_syscall, this looks good to me.

Mark.
