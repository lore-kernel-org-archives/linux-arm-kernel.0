From: abelvesa@gmail.com (Abel Vesa)
Date: Tue, 28 Feb 2017 00:56:36 +0000
Subject: [PATCHv4] arm: ftrace: Adds support for
 CONFIG_DYNAMIC_FTRACE_WITH_REGS
In-Reply-To: <87r32jiqc9.fsf@d080-213.cis.zmaw.de>
References: <1487977101-29027-1-git-send-email-abelvesa@linux.com>
 <87r32jiqc9.fsf@d080-213.cis.zmaw.de>
Message-ID: <20170228005636.GA23251@nuc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 27, 2017 at 04:52:06PM +0100, Nicolai Stange wrote:
> Hi Abel,
> 
> On Fri, Feb 24 2017, Abel Vesa wrote:
> 
> <snip>
> 
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index fda6a46..877df5b 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -55,6 +55,7 @@ config ARM
> >  	select HAVE_DMA_API_DEBUG
> >  	select HAVE_DMA_CONTIGUOUS if MMU
> >  	select HAVE_DYNAMIC_FTRACE if (!XIP_KERNEL) && !CPU_ENDIAN_BE32 && MMU
> > +	select HAVE_DYNAMIC_FTRACE_WITH_REGS if HAVE_DYNAMIC_FTRACE && OLD_MCOUNT
> 
> 
> AFAICS, your code depends on the __gnu_mcount_nc calling conventions,
> i.e. on gcc pushing the original lr on the stack. In particular, there's
> no implementation of a ftrace_regs_caller_old or so.
> 
> So shouldn't this read as !OLD_MCOUNT instead?
The implementation of __ftrace_modify_code which sets the kernel text to rw
needs OLD_MCOUNT (that is, the arch specific one, not the generic one).
> 
> Also, at least the ldmia ..., {..., sp, ...} insn needs a !THUMB2_KERNEL.
> 
> 
> >  	select HAVE_EFFICIENT_UNALIGNED_ACCESS if (CPU_V6 || CPU_V6K || CPU_V7) && MMU
> >  	select HAVE_EXIT_THREAD
> >  	select HAVE_FTRACE_MCOUNT_RECORD if (!XIP_KERNEL)
> 
> <snip>
> 
> > diff --git a/arch/arm/kernel/entry-ftrace.S b/arch/arm/kernel/entry-ftrace.S
> > index c73c403..3916dd6 100644
> > --- a/arch/arm/kernel/entry-ftrace.S
> > +++ b/arch/arm/kernel/entry-ftrace.S
> > @@ -92,12 +92,78 @@
> >  2:	mcount_exit
> >  .endm
> >  
> > +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
> > +
> > +.macro __ftrace_regs_caller
> > +
> > +	sub	sp, sp, #8	@ space for CPSR and OLD_R0 (not used)
> > +
> > +	add 	ip, sp, #12	@ move in IP the value of SP as it was
> > +				@ before the push {lr} of the mcount mechanism
> > +	stmdb	sp!, {ip,lr,pc}
> > +	stmdb	sp!, {r0-r11,lr}
> > +
> > +	@ stack content at this point:
> > +	@ 0  4          48   52       56   60   64    68       72
> > +	@ R0 | R1 | ... | LR | SP + 4 | LR | PC | PSR | OLD_R0 | previous LR |
> 
> Being a constant, the saved pc is not very useful, I think.
So you're saying skip it ? But you still need to leave space for it. So why not
just save it even if the value is not useful?
> 
> Wouldn't it be better (and more consistent with other archs) to have
> 
>   pt_regs->ARM_lr = original lr
>   pt_refs->ARM_pc = current lr
> 
> instead?
> 
> A (hypothetical) klp_arch_set_pc(struct pt_regs *regs, unsigned long ip)
> would do the more intuitive
> 
>   regs->ARM_pc = ip;
> 
> rather than a
> 
>   regs->ARM_lr = ip
> 
> then.
You are right. There is a subsequent patch I'm currently working on that will 
enable livepatch and will bring an implementation for klp_arch_set_pc as you 
described it. I still don't get what is wrong with the code though?

> 
> In addition, the original lr register would be made available to ftrace
> handlers this way.
> 
> 
> > +	mov r3, sp				@ struct pt_regs*
> > +	ldr r2, =function_trace_op
> > +	ldr r2, [r2]				@ pointer to the current
> > +						@ function tracing op
> > +	ldr	r1, [sp, #PT_REGS_SIZE]		@ lr of instrumented func
> > +	mcount_adjust_addr	r0, lr		@ instrumented function
> > +
> > +	.globl ftrace_regs_call
> > +ftrace_regs_call:
> > +	bl	ftrace_stub
> > +
> > +#ifdef CONFIG_FUNCTION_GRAPH_TRACER
> > +	.globl ftrace_graph_regs_call
> > +ftrace_graph_regs_call:
> > +	mov	r0, r0
> > +#endif
> > +	@ pop saved regs
> > +	@ first, get the previous LR value from stack
> > +	ldr	lr, [sp, #PT_REGS_SIZE]
> > +	@ now pop the rest of the saved registers INCLUDING stack pointer
> > +	ldmia   sp, {r0-r11, ip, sp, pc}
> > +.endm
> > +
> 
> 
> > +#ifdef CONFIG_FUNCTION_GRAPH_TRACER
> > +.macro __ftrace_graph_regs_caller
> > +
> > +	sub	r0, fp, #4		@ lr of instrumented routine (parent)
> > +
> > +	@ called from __ftrace_regs_caller
> > +	ldr     r1, [sp, #S_LR]		@ instrumented routine (func)
> > +	mcount_adjust_addr	r1, r1
> > +
> > +	sub	r2, r0, #4		@ frame pointer
> 
> Given that r2 is prepare_ftrace_return()'s frame_pointer argument, is
> 
>   r2 = fp - 4 - 4 = fp - 8
> 
> really correct / what is wanted here?
> 
You are right. 
-	sub     r2, r0, #4              @ frame pointer
+	mov     r2, fp                  @ frame pointer

> > +	bl	prepare_ftrace_return
> > +
> > +	@ pop registers saved in ftrace_regs_caller
> > +	@ first, get the previous LR value from stack
> > +	ldr	lr, [sp, #PT_REGS_SIZE]
> > +	@ now pop the rest of the saved registers INCLUDING stack pointer
> > +	ldmia   sp, {r0-r11, ip, sp, pc}
> > +.endm
> > +#endif
> > +#endif
> > +
> 
> <snip>
> 
> 
> Thanks,
> 
> Nicolai

Thanks
