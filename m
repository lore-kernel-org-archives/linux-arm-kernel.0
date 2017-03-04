From: rabin@rab.in (Rabin Vincent)
Date: Sat, 4 Mar 2017 14:02:17 +0100
Subject: [PATCHv5] arm: ftrace: Adds support for
 CONFIG_DYNAMIC_FTRACE_WITH_REGS
In-Reply-To: <1488588672-21865-1-git-send-email-abelvesa@linux.com>
References: <1488588672-21865-1-git-send-email-abelvesa@linux.com>
Message-ID: <20170304130216.uz6chruwmyb2u4yv@debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 04, 2017 at 12:51:12AM +0000, Abel Vesa wrote:
> diff --git a/arch/arm/kernel/entry-ftrace.S b/arch/arm/kernel/entry-ftrace.S
> index c73c403..93f9abb 100644
> --- a/arch/arm/kernel/entry-ftrace.S
> +++ b/arch/arm/kernel/entry-ftrace.S
> @@ -92,12 +92,78 @@
>  2:	mcount_exit
>  .endm
>  
> +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
> +
> +.macro __ftrace_regs_caller
> +
> +	sub	sp, sp, #8	@ space for CPSR and OLD_R0 (not used)
> +
> +	add 	ip, sp, #12	@ move in IP the value of SP as it was
> +				@ before the push {lr} of the mcount mechanism
> +	stmdb	sp!, {ip,lr,pc}

This doesn't build with CONFIG_THUMB2_KERNEL:

entry-ftrace.S:285: Error: PC not allowed in register list -- `stmdb sp!,{ip,lr,pc}'

Saving PC in STMDB is prohibited in Thumb and deprecated in ARM.

> +	stmdb	sp!, {r0-r11,lr}
> +
> +	ldr	r0, [sp, #S_LR]			@ replace PC with LR
> +	str	r0, [sp, #S_PC]			@ into pt_regs
> +
> +	ldr	r1, [sp, #PT_REGS_SIZE] 	@ replace new LR with
> +	str	r1, [sp, #S_LR]			@ previous LR into pt_regs
> +
> +	@ stack content at this point:
> +	@ 0  4          48   52       56            60   64    68       72
> +	@ R0 | R1 | ... | LR | SP + 4 | previous LR | LR | PSR | OLD_R0 | previous LR |

So this code only adjust the SP by 72 bytes.  Since the stack is not
aligned to 8 bytes at entry to mcount, this code calls into C functions
with a misaligned stack.  This is a violation of the procedure call
standard.

Also, I believe this should have unwind annotations to indicate where it
saved the registers.  See mcount_enter for an example.

> +
> +	mov r3, sp				@ struct pt_regs*
> +	ldr r2, =function_trace_op
> +	ldr r2, [r2]				@ pointer to the current
> +						@ function tracing op
> +	ldr	r1, [sp, #PT_REGS_SIZE]		@ lr of instrumented func
> +	mcount_adjust_addr	r0, lr		@ instrumented function
> +
> +	.globl ftrace_regs_call
> +ftrace_regs_call:
> +	bl	ftrace_stub
> +
> +#ifdef CONFIG_FUNCTION_GRAPH_TRACER
> +	.globl ftrace_graph_regs_call
> +ftrace_graph_regs_call:
> +	mov	r0, r0
> +#endif
> +	@ pop saved regs
> +	ldmia   sp, {r0-r15}

This doesn't build either:

entry-ftrace.S:285: Error: LR and PC should not both be in register list -- `ldmia sp,{r0-r15}'

Restoring LR and PC together is prohibited in Thumb and deprecated in
ARM.  It's the same case with SP.

> +.endm
> +
> +#ifdef CONFIG_FUNCTION_GRAPH_TRACER
> +.macro __ftrace_graph_regs_caller
> +
> +	sub	r0, fp, #4		@ lr of instrumented routine (parent)
> +
> +	@ called from __ftrace_regs_caller
> +	ldr     r1, [sp, #S_PC]		@ instrumented routine (func)
> +	mcount_adjust_addr	r1, r1
> +
> +	mov	r2, fp			@ frame pointer
> +	bl	prepare_ftrace_return
> +
> +	@ pop registers saved in ftrace_regs_caller
> +	ldmia   sp, {r0-r15}

This doesn't get built on CONFIG_THUMB2_KERNEL since there's no suppport
for CONFIG_FUNCTION_GRAPH_TRACER there, but this is also using
deprecated operands.

> +.endm
> +#endif
> +#endif
...
> diff --git a/arch/arm/kernel/ftrace.c b/arch/arm/kernel/ftrace.c
> index 3f17594..f165265 100644
> --- a/arch/arm/kernel/ftrace.c
> +++ b/arch/arm/kernel/ftrace.c
> @@ -29,11 +29,6 @@
>  #endif
>  
>  #ifdef CONFIG_DYNAMIC_FTRACE
> -#ifdef CONFIG_OLD_MCOUNT
> -#define OLD_MCOUNT_ADDR	((unsigned long) mcount)
> -#define OLD_FTRACE_ADDR ((unsigned long) ftrace_caller_old)
> -
> -#define	OLD_NOP		0xe1a00000	/* mov r0, r0 */
>  
>  static int __ftrace_modify_code(void *data)
>  {
> @@ -51,6 +46,12 @@ void arch_ftrace_update_code(int command)
>  	stop_machine(__ftrace_modify_code, &command, NULL);
>  }
>  
> +#ifdef CONFIG_OLD_MCOUNT
> +#define OLD_MCOUNT_ADDR	((unsigned long) mcount)
> +#define OLD_FTRACE_ADDR ((unsigned long) ftrace_caller_old)
> +
> +#define	OLD_NOP		0xe1a00000	/* mov r0, r0 */
> +
>  static unsigned long ftrace_nop_replace(struct dyn_ftrace *rec)

This chunk above fixes the problem which Nicolai pointed out earlier.  Since
it's a bug fix for the current dynamic ftrace code, it should really be
submitted as a separate patch.  Feel free to use some variant of this
commit message which I wrote when I ran into this yesterday:

 ARM: ftrace: fix dynamic ftrace with DEBUG_RODATA and !FRAME_POINTER
 
 The support for dynamic ftrace with CONFIG_DEBUG_RODATA involves
 overriding the weak arch_ftrace_update_code() with a variant which makes
 the kernel text writable around the patching.
 
 This override was however added under the CONFIG_OLD_MCOUNT ifdef, and
 CONFIG_OLD_MCOUNT is only enabled if frame pointers are enabled.
 
 This leads to non-functional dynamic ftrace (ftrace triggers a
 WARN_ON()) when CONFIG_DEBUG_RODATA is enabled and CONFIG_FRAME_POINTER
 is not.
 
 Move the override out of that ifdef and into the CONFIG_DYNAMIC_FTRACE
 ifdef where it belongs.

 Fixes: 80d6b0c2eed2a ("ARM: mm: allow text and rodata sections to be read-only")

>  {
>  	return rec->arch.old_mcount ? OLD_NOP : NOP;
> @@ -139,6 +140,15 @@ int ftrace_update_ftrace_func(ftrace_func_t func)
>  
>  	ret = ftrace_modify_code(pc, 0, new, false);
>  
> +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS

This code (and the rest of your additions to this file below), are already
under CONFIG_DYNAMIC_FTRACE and afaics CONFIG_DYNAMIC_FTRACE_WITH_REGS is
always enabled when the former is enabled, so could you please drop
these ifdefs?

The code in entry-ftrace.S under CONFIG_DYNAMIC_FTRACE_WITH_REGS would
also benefit from just using CONFIG_DYNAMIC_FTRACE everywhere instead.
