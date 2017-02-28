From: abelvesa@gmail.com (Abel Vesa)
Date: Tue, 28 Feb 2017 11:22:27 +0000
Subject: [PATCHv4] arm: ftrace: Adds support for
 CONFIG_DYNAMIC_FTRACE_WITH_REGS
In-Reply-To: <87h93eoa3a.fsf@gmail.com>
References: <1487977101-29027-1-git-send-email-abelvesa@linux.com>
 <87r32jiqc9.fsf@d080-213.cis.zmaw.de> <20170228005636.GA23251@nuc>
 <87h93eoa3a.fsf@gmail.com>
Message-ID: <20170228112227.GB23251@nuc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 28, 2017 at 11:58:49AM +0100, Nicolai Stange wrote:
> Hi Abel,
> 
> On Tue, Feb 28 2017, Abel Vesa wrote:
> 
> > On Mon, Feb 27, 2017 at 04:52:06PM +0100, Nicolai Stange wrote:
> >> On Fri, Feb 24 2017, Abel Vesa wrote:
> >> 
> >> <snip>
> >> 
> >> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> >> > index fda6a46..877df5b 100644
> >> > --- a/arch/arm/Kconfig
> >> > +++ b/arch/arm/Kconfig
> >> > @@ -55,6 +55,7 @@ config ARM
> >> >  	select HAVE_DMA_API_DEBUG
> >> >  	select HAVE_DMA_CONTIGUOUS if MMU
> >> >  	select HAVE_DYNAMIC_FTRACE if (!XIP_KERNEL) && !CPU_ENDIAN_BE32 && MMU
> >> > +	select HAVE_DYNAMIC_FTRACE_WITH_REGS if HAVE_DYNAMIC_FTRACE && OLD_MCOUNT
> >> 
> >> 
> >> AFAICS, your code depends on the __gnu_mcount_nc calling conventions,
> >> i.e. on gcc pushing the original lr on the stack. In particular, there's
> >> no implementation of a ftrace_regs_caller_old or so.
> >> 
> >> So shouldn't this read as !OLD_MCOUNT instead?
> > The implementation of __ftrace_modify_code which sets the kernel text to rw
> > needs OLD_MCOUNT (that is, the arch specific one, not the generic one).
> 
> You're right that ARM's implementation of __ftrace_modify_code() is hidden
> within an #ifdef CONFIG_OLD_MCOUNT.
> 
> But,
>  - its implementation doesn't "need" or depend on OLD_MCOUNT
>  - and it's true in general that the kernel text must be made writable
>    before ftrace_modify_all_code() attempts to write to it.
> 
> So, I bet that the set_kernel_text_rw()-calling ARM implementations of
> arch_ftrace_update_code() and __ftrace_modify_code() resp. have been
> inserted under that CONFIG_OLD_MCOUNT #ifdef by mistake with commit
> 80d6b0c2eed2 ("ARM: mm: allow text and rodata sections to be
> read-only").
> 
> In conclusion, I claim that DYNAMIC_FTRACE w/o OLD_MCOUNT had been
> broken before your patch already. I didn't explicitly test that though.
>
That is correct. The DYNAMIC_FTRACE w/o OLD_MCOUNT doesn't work. 
> I think that should be fixed rather than your DYNAMIC_FTRACE_WITH_REGS
> pulling in OLD_MCOUNT in order to repair DYNAMIC_FTRACE.
> 
> Especially since your implementation seems to require !OLD_MCOUNT...
> 
So making arch specific __ftrace_modify_code to be OLD_MCOUNT independent might fix 
DYNAMIC_FTRACE w/o OLD_MCOUNT and implicitly make DYNAMIC_FTRACE_WITH_REGS not dependent on
OLD_MCOUNT.

I will investigate this further today. Probably the whole dependancy between FUNCTION_TRACER
and OLD_MCOUNT will need to be changed/updated.
> >> Also, at least the ldmia ..., {..., sp, ...} insn needs a !THUMB2_KERNEL.
> >> 
> >> 
> >> >  	select HAVE_EFFICIENT_UNALIGNED_ACCESS if (CPU_V6 || CPU_V6K || CPU_V7) && MMU
> >> >  	select HAVE_EXIT_THREAD
> >> >  	select HAVE_FTRACE_MCOUNT_RECORD if (!XIP_KERNEL)
> >> 
> >> <snip>
> >> 
> >> > diff --git a/arch/arm/kernel/entry-ftrace.S b/arch/arm/kernel/entry-ftrace.S
> >> > index c73c403..3916dd6 100644
> >> > --- a/arch/arm/kernel/entry-ftrace.S
> >> > +++ b/arch/arm/kernel/entry-ftrace.S
> >> > @@ -92,12 +92,78 @@
> >> >  2:	mcount_exit
> >> >  .endm
> >> >  
> >> > +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
> >> > +
> >> > +.macro __ftrace_regs_caller
> >> > +
> >> > +	sub	sp, sp, #8	@ space for CPSR and OLD_R0 (not used)
> >> > +
> >> > +	add 	ip, sp, #12	@ move in IP the value of SP as it was
> >> > +				@ before the push {lr} of the mcount mechanism
> >> > +	stmdb	sp!, {ip,lr,pc}
> >> > +	stmdb	sp!, {r0-r11,lr}
> >> > +
> >> > +	@ stack content at this point:
> >> > +	@ 0  4          48   52       56   60   64    68       72
> >> > +	@ R0 | R1 | ... | LR | SP + 4 | LR | PC | PSR | OLD_R0 | previous LR |
> >> 
> >> Being a constant, the saved pc is not very useful, I think.
> > So you're saying skip it ? But you still need to leave space for it. So why not
> > just save it even if the value is not useful?
> 
> No, no, I don't want to skip it. I'd just prefer to have the pt_regs'
> ->ARM_lr and ->ARM_pc slots filled with different, perhaps more useful
> values:
> 
> >> 
> >> Wouldn't it be better (and more consistent with other archs) to have
> >> 
> >>   pt_regs->ARM_lr = original lr
> >>   pt_refs->ARM_pc = current lr
> >> 
> >> instead?
> 
> The stack would look like this then
> 
> @ ...           | ARM_ip | ARM_sp | ARM_lr      | ARM_pc      | ...          |
> @ 0  4          48       52       56            60            64    68       72
> @ R0 | R1 | ... | LR     | SP + 4 | original LR | original PC | PSR | OLD_R0 | original LR |
> 
> I.e. the pt_regs would capture almost the full context of the
> instrumented function (except for ip).
> 
So basicly what you are saying is:
- instead of current LR save original LR (previous one saved in instrumented function epilog)
- instead of current PC save original PC (previous one saved in instrumented function epilog)

I still don't see the point of saving the actual value of PC since nobody will ever
restore it. In case of livepatch it will get overwritten anyway. As for LR, I agree,
it could be the original one in pt_regs.

I'll look into this sometime today or tomorrow and get back with updates.
> Thanks,
> 
> Nicolai

Thanks
