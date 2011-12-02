From: dave.martin@linaro.org (Dave Martin)
Date: Fri, 2 Dec 2011 12:44:17 +0000
Subject: [PATCH] ARM: ftrace: clear zero bit in reported IPs for Thumb-2
In-Reply-To: <1322762765-22776-1-git-send-email-rabin@rab.in>
References: <1322762765-22776-1-git-send-email-rabin@rab.in>
Message-ID: <20111202124417.GA2892@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 01, 2011 at 11:36:05PM +0530, Rabin Vincent wrote:
> The dynamic ftrace ops startup test currently fails on Thumb-2 kernels:
> 
>  Testing tracer function: PASSED
>  Testing dynamic ftrace: PASSED
>  Testing dynamic ftrace ops #1: (0 0 0 0 0) FAILED!
> 
> This is because while the addresses in the mcount records do not have
> the zero bit set, the IP reported by the mcount call does have it set
> (because it is copied from the LR).  This mismatch causes the ops
> filtering in ftrace_ops_list_func() to not call the relevant tracers.
> 
> Fix this by clearing the zero bit while adjusting the LR for the mcount
> instruction size.  Also, combine the mov+sub into a single sub
> instruction.
> 
> Signed-off-by: Rabin Vincent <rabin@rab.in>
> ---
>  arch/arm/kernel/entry-common.S |   16 ++++++++++------
>  1 files changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
> index b2a27b6..9d7ce81 100644
> --- a/arch/arm/kernel/entry-common.S
> +++ b/arch/arm/kernel/entry-common.S
> @@ -149,6 +149,12 @@ ENDPROC(ret_from_fork)
>  #endif
>  #endif
>  
> +.macro mcount_size_adjust rd, rn
> +	ARM(	sub	\rd, \rn, #MCOUNT_INSN_SIZE	)
> +	/* The zero bit is set on Thumb LRs; clear it. */
> +	THUMB(	sub	\rd, \rn, #MCOUNT_INSN_SIZE + 1	)
> +.endm
> +

You're conflating two different things here:

1) convert the branch pointer in lr into the corresponding instruction
address in memory

2) subtract MCOUNT_INSN_SIZE


(1) Is an ARM architectural thing and not secific to ftrace in any way,
so I suggest we make that generic and factor it out.

For example, kprobes.c has:


121:void __kprobes arch_arm_kprobe(struct kprobe *p)
122:{
123:	uintptr_t addr = (uintptr_t)p->addr & ~1; /* Remove any Thumb flag */

166:int __kprobes __arch_disarm_kprobe(void *p)
167:{
[...]
169-#ifdef CONFIG_THUMB2_KERNEL
170:	u16 *addr = (u16 *)((uintptr_t)kp->addr & ~1);


Whether is makes sense to make that all generic for assembler or not,
you can avoid the conditionality by writing:

.macro mcount_size_adjust rd, rn
	bic	\rd , \rn , #1			@ clear the Thumb bit if present
	sub	\rd , \rd , #MCOUNT_INSN_SIZE
.endm

This adjustment will be correct regardless of the instruction set.


Otherwise, this looks sensible.

Cheers
---Dave

>  .macro __mcount suffix
>  	mcount_enter
>  	ldr	r0, =ftrace_trace_function
> @@ -173,8 +179,7 @@ ENDPROC(ret_from_fork)
>  	mcount_exit
>  
>  1: 	mcount_get_lr	r1			@ lr of instrumented func
> -	mov	r0, lr				@ instrumented function
> -	sub	r0, r0, #MCOUNT_INSN_SIZE
> +	mcount_size_adjust r0, lr		@ instrumented function
>  	adr	lr, BSYM(2f)
>  	mov	pc, r2
>  2:	mcount_exit
> @@ -184,8 +189,7 @@ ENDPROC(ret_from_fork)
>  	mcount_enter
>  
>  	mcount_get_lr	r1			@ lr of instrumented func
> -	mov	r0, lr				@ instrumented function
> -	sub	r0, r0, #MCOUNT_INSN_SIZE
> +	mcount_size_adjust	r0, lr		@ instrumented function
>  
>  	.globl ftrace_call\suffix
>  ftrace_call\suffix:
> @@ -205,11 +209,11 @@ ftrace_graph_call\suffix:
>  #ifdef CONFIG_DYNAMIC_FTRACE
>  	@ called from __ftrace_caller, saved in mcount_enter
>  	ldr	r1, [sp, #16]		@ instrumented routine (func)
> +	mcount_size_adjust r1, r1
>  #else
>  	@ called from __mcount, untouched in lr
> -	mov	r1, lr			@ instrumented routine (func)
> +	mcount_size_adjust r1, lr	@ instrumented routine (func)
>  #endif
> -	sub	r1, r1, #MCOUNT_INSN_SIZE
>  	mov	r2, fp			@ frame pointer
>  	bl	prepare_ftrace_return
>  	mcount_exit
> -- 
> 1.7.7.3
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
