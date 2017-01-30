From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 30 Jan 2017 15:51:55 +0000
Subject: [PATCHv2] arm: ftrace: Adds support for
 CONFIG_DYNAMIC_FTRACE_WITH_REGS
In-Reply-To: <1485300291-29722-1-git-send-email-abelvesa@linux.com>
References: <1485300291-29722-1-git-send-email-abelvesa@linux.com>
Message-ID: <20170130155155.GC27312@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 24, 2017 at 11:24:51PM +0000, Abel Vesa wrote:
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
> Signed-off-by: Abel Vesa <abelvesa@linux.com>
> ---
>  arch/arm/Kconfig               |  1 +
>  arch/arm/include/asm/ftrace.h  |  4 +++
>  arch/arm/kernel/entry-ftrace.S | 79 ++++++++++++++++++++++++++++++++++++++++++
>  arch/arm/kernel/ftrace.c       | 33 ++++++++++++++++++
>  4 files changed, 117 insertions(+)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 186c4c2..db40973 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -50,6 +50,7 @@ config ARM
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
> index c73c403..fcdcc3a 100644
> --- a/arch/arm/kernel/entry-ftrace.S
> +++ b/arch/arm/kernel/entry-ftrace.S
> @@ -92,12 +92,74 @@
>  2:	mcount_exit
>  .endm
>  
> +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
> +
> +.macro __ftrace_regs_caller
> +
> +	add 	ip, sp, #4	@ move in IP the value of SP as it was
> +				@ before the push {lr} of the mcount mechanism
> +	stmdb	sp!, {ip,lr,pc}
> +	stmdb	sp!, {r0-r11,lr}
> +
> +	@ stack content at this point:
> +	@ 0  4          44    48   52       56   60   64
> +	@ RO | R1 | ... | R11 | LR | SP + 4 | LR | PC | previous LR |

ITYM "R0" not "RO".

> +
> +	mov r3, sp				@ struct pt_regs*
> +	ldr r2, =function_trace_op
> +	ldr r2, [r2]				@ pointer to the current
> +						@ function tracing op
> +	ldr	r1, [sp, #64]			@ lr of instrumented func
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
> +	ldr	lr, [sp, #64]		@ get the previous LR value from stack
> +	ldmia	sp, {r0-r11, ip, sp}	@ pop the saved registers INCLUDING
> +					@ the stack pointer
> +	ret	ip

Are you really sure you want to return using the address that was poked
into register 12 in the pt_regs struct?  Surely using the value from
register 14 would be saner, which can be done in one instruction:

	ldmia	sp, {r0-r11, ip, sp, pc}

> +#ifdef CONFIG_FUNCTION_GRAPH_TRACER
> +.macro __ftrace_graph_regs_caller
> +
> +	sub	r0, fp, #4		@ lr of instrumented routine (parent)
> +
> +	@ called from __ftrace_regs_caller
> +	ldr     r1, [sp, #56]		@ instrumented routine (func)
> +	mcount_adjust_addr	r1, r1
> +
> +	sub	r2, r0, #4		@ frame pointer
> +	bl	prepare_ftrace_return
> +
> +	ldr	lr, [sp, #64]		@ restore lr from the stack
> +	ldmia	sp, {r0-r11, ip, sp}	@ restore r0 through sp

This looks weird - and if it's intentional, it needs a comment explaining
where these were stacked.

Thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
