From: abelvesa@gmail.com (Abel Vesa)
Date: Fri, 12 May 2017 22:05:29 +0100
Subject: [PATCH] arm: ftrace: Adds support for
 CONFIG_DYNAMIC_FTRACE_WITH_REGS
In-Reply-To: <1494621518-8489-1-git-send-email-abelvesa@gmail.com>
References: <1494621518-8489-1-git-send-email-abelvesa@gmail.com>
Message-ID: <20170512210529.GA29693@nuc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 12, 2017 at 09:38:37PM +0100, abelvesa at gmail.com wrote:
> From: Abel Vesa <abelvesa@gmail.com>
To be ignored, wrong git config. Will send another one without the From line.
> 
> The DYNAMIC_FTRACE_WITH_REGS configuration makes it possible for a ftrace
> operation to specify if registers need to saved/restored by the ftrace handler.
> This is needed by kgraft and possibly other ftrace-based tools, and the ARM
> architecture is currently lacking this feature. It would also be the first step
> to support the "Kprobes-on-ftrace" optimization on ARM.
> 
> This patch introduces a new ftrace handler that stores the registers on the
> stack before calling the next stage. The registers are restored from the stack
> before going back to the instrumented function.
> 
> A side-effect of this patch is to activate the support for ftrace_modify_call()
> as it defines ARCH_SUPPORTS_FTRACE_OPS for the ARM architecture.
> 
> Signed-off-by: Abel Vesa <abelvesa@gmail.com>
> ---
>  arch/arm/Kconfig               |   1 +
>  arch/arm/include/asm/ftrace.h  |   4 ++
>  arch/arm/kernel/entry-ftrace.S | 100 +++++++++++++++++++++++++++++++++++++++++
>  arch/arm/kernel/ftrace.c       |  37 +++++++++++++++
>  4 files changed, 142 insertions(+)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 4c1a35f..730d456 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -56,6 +56,7 @@ config ARM
>  	select HAVE_DMA_API_DEBUG
>  	select HAVE_DMA_CONTIGUOUS if MMU
>  	select HAVE_DYNAMIC_FTRACE if (!XIP_KERNEL) && !CPU_ENDIAN_BE32 && MMU
> +	select HAVE_DYNAMIC_FTRACE_WITH_REGS if HAVE_DYNAMIC_FTRACE
>  	select HAVE_EFFICIENT_UNALIGNED_ACCESS if (CPU_V6 || CPU_V6K || CPU_V7) && MMU
>  	select HAVE_EXIT_THREAD
>  	select HAVE_FTRACE_MCOUNT_RECORD if (!XIP_KERNEL)
> diff --git a/arch/arm/include/asm/ftrace.h b/arch/arm/include/asm/ftrace.h
> index 22b7311..f379881 100644
> --- a/arch/arm/include/asm/ftrace.h
> +++ b/arch/arm/include/asm/ftrace.h
> @@ -1,6 +1,10 @@
>  #ifndef _ASM_ARM_FTRACE
>  #define _ASM_ARM_FTRACE
>  
> +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
> +#define ARCH_SUPPORTS_FTRACE_OPS 1
> +#endif
> +
>  #ifdef CONFIG_FUNCTION_TRACER
>  #define MCOUNT_ADDR		((unsigned long)(__gnu_mcount_nc))
>  #define MCOUNT_INSN_SIZE	4 /* sizeof mcount call */
> diff --git a/arch/arm/kernel/entry-ftrace.S b/arch/arm/kernel/entry-ftrace.S
> index c73c403..efcd9f2 100644
> --- a/arch/arm/kernel/entry-ftrace.S
> +++ b/arch/arm/kernel/entry-ftrace.S
> @@ -92,12 +92,95 @@
>  2:	mcount_exit
>  .endm
>  
> +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
> +
> +.macro __ftrace_regs_caller
> +
> +	sub	sp, sp, #8	@ space for PC and CPSR OLD_R0,
> +				@ OLD_R0 will overwrite previous LR
> +
> +	add 	ip, sp, #12	@ move in IP the value of SP as it was
> +				@ before the push {lr} of the mcount mechanism
> +
> +	str     lr, [sp, #0]    @ store LR instead of PC
> +
> +	ldr     lr, [sp, #8]    @ get previous LR
> +
> +	str	r0, [sp, #8]	@ write r0 as OLD_R0 over previous LR
> +
> +	stmdb   sp!, {ip, lr}
> +	stmdb   sp!, {r0-r11, lr}
> +
> +	@ stack content at this point:
> +	@ 0  4          48   52       56            60   64    68       72
> +	@ R0 | R1 | ... | LR | SP + 4 | previous LR | LR | PSR | OLD_R0 |
> +
> +	mov r3, sp				@ struct pt_regs*
> +
> +	ldr r2, =function_trace_op
> +	ldr r2, [r2]				@ pointer to the current
> +						@ function tracing op
> +
> +	ldr	r1, [sp, #S_LR]			@ lr of instrumented func
> +
> +	ldr	lr, [sp, #S_PC]			@ get LR
> +
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
> +
> +	@ pop saved regs
> +	ldmia   sp!, {r0-r12}			@ restore r0 through r12
> +	ldr	ip, [sp, #8]			@ restore PC
> +	ldr	lr, [sp, #4]			@ restore LR
> +	ldr	sp, [sp, #0]			@ restore SP
> +	mov	pc, ip				@ return
> +.endm
> +
> +#ifdef CONFIG_FUNCTION_GRAPH_TRACER
> +.macro __ftrace_graph_regs_caller
> +
> +	sub     r0, fp, #4              @ lr of instrumented routine (parent)
> +
> +	@ called from __ftrace_regs_caller
> +	ldr     r1, [sp, #S_PC]		@ instrumented routine (func)
> +	mcount_adjust_addr	r1, r1
> +
> +	mov	r2, fp			@ frame pointer
> +	bl	prepare_ftrace_return
> +
> +	@ pop registers saved in ftrace_regs_caller
> +	ldmia   sp!, {r0-r12}			@ restore r0 through r12
> +	ldr	ip, [sp, #8]			@ restore PC
> +	ldr	lr, [sp, #4]			@ restore LR
> +	ldr	sp, [sp, #0]			@ restore SP
> +	mov	pc, ip				@ return
> +
> +.endm
> +#endif
> +#endif
> +
>  .macro __ftrace_caller suffix
>  	mcount_enter
>  
>  	mcount_get_lr	r1			@ lr of instrumented func
>  	mcount_adjust_addr	r0, lr		@ instrumented function
>  
> +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
> +	ldr r2, =function_trace_op
> +	ldr r2, [r2]				@ pointer to the current
> +						@ function tracing op
> +	mov r3, #0				@ regs is NULL
> +#endif
> +
>  	.globl ftrace_call\suffix
>  ftrace_call\suffix:
>  	bl	ftrace_stub
> @@ -212,6 +295,15 @@ UNWIND(.fnstart)
>  	__ftrace_caller
>  UNWIND(.fnend)
>  ENDPROC(ftrace_caller)
> +
> +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
> +ENTRY(ftrace_regs_caller)
> +UNWIND(.fnstart)
> +	__ftrace_regs_caller
> +UNWIND(.fnend)
> +ENDPROC(ftrace_regs_caller)
> +#endif
> +
>  #endif
>  
>  #ifdef CONFIG_FUNCTION_GRAPH_TRACER
> @@ -220,6 +312,14 @@ UNWIND(.fnstart)
>  	__ftrace_graph_caller
>  UNWIND(.fnend)
>  ENDPROC(ftrace_graph_caller)
> +
> +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
> +ENTRY(ftrace_graph_regs_caller)
> +UNWIND(.fnstart)
> +	__ftrace_graph_regs_caller
> +UNWIND(.fnend)
> +ENDPROC(ftrace_graph_regs_caller)
> +#endif
>  #endif
>  
>  .purgem mcount_enter
> diff --git a/arch/arm/kernel/ftrace.c b/arch/arm/kernel/ftrace.c
> index 833c991..5617932 100644
> --- a/arch/arm/kernel/ftrace.c
> +++ b/arch/arm/kernel/ftrace.c
> @@ -141,6 +141,15 @@ int ftrace_update_ftrace_func(ftrace_func_t func)
>  
>  	ret = ftrace_modify_code(pc, 0, new, false);
>  
> +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
> +	if (!ret) {
> +		pc = (unsigned long)&ftrace_regs_call;
> +		new = ftrace_call_replace(pc, (unsigned long)func);
> +
> +		ret = ftrace_modify_code(pc, 0, new, false);
> +	}
> +#endif
> +
>  #ifdef CONFIG_OLD_MCOUNT
>  	if (!ret) {
>  		pc = (unsigned long)&ftrace_call_old;
> @@ -159,11 +168,29 @@ int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
>  	unsigned long ip = rec->ip;
>  
>  	old = ftrace_nop_replace(rec);
> +
> +	new = ftrace_call_replace(ip, adjust_address(rec, addr));
> +
> +	return ftrace_modify_code(rec->ip, old, new, true);
> +}
> +
> +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
> +
> +int ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_addr,
> +				unsigned long addr)
> +{
> +	unsigned long new, old;
> +	unsigned long ip = rec->ip;
> +
> +	old = ftrace_call_replace(ip, adjust_address(rec, old_addr));
> +
>  	new = ftrace_call_replace(ip, adjust_address(rec, addr));
>  
>  	return ftrace_modify_code(rec->ip, old, new, true);
>  }
>  
> +#endif
> +
>  int ftrace_make_nop(struct module *mod,
>  		    struct dyn_ftrace *rec, unsigned long addr)
>  {
> @@ -231,6 +258,8 @@ void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr,
>  extern unsigned long ftrace_graph_call;
>  extern unsigned long ftrace_graph_call_old;
>  extern void ftrace_graph_caller_old(void);
> +extern unsigned long ftrace_graph_regs_call;
> +extern void ftrace_graph_regs_caller(void);
>  
>  static int __ftrace_modify_caller(unsigned long *callsite,
>  				  void (*func) (void), bool enable)
> @@ -253,6 +282,14 @@ static int ftrace_modify_graph_caller(bool enable)
>  				     ftrace_graph_caller,
>  				     enable);
>  
> +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
> +	if (!ret)
> +		ret = __ftrace_modify_caller(&ftrace_graph_regs_call,
> +				     ftrace_graph_regs_caller,
> +				     enable);
> +#endif
> +
> +
>  #ifdef CONFIG_OLD_MCOUNT
>  	if (!ret)
>  		ret = __ftrace_modify_caller(&ftrace_graph_call_old,
> -- 
> 2.7.4
> 
