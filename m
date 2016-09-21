From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 21 Sep 2016 18:04:04 +0100
Subject: [PATCH 5/5] arm64: Add uprobe support
In-Reply-To: <20160921110047.GA29470@localhost.localdomain>
References: <cover.1470114993.git.panand@redhat.com>
 <abaac6ebaa5dd63889803ec568663bc8c8c65b02.1470114993.git.panand@redhat.com>
 <20160920165946.GA19353@e104818-lin.cambridge.arm.com>
 <20160921110047.GA29470@localhost.localdomain>
Message-ID: <20160921170403.GE12180@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 21, 2016 at 04:30:47PM +0530, Pratyush Anand wrote:
> On 20/09/2016:05:59:46 PM, Catalin Marinas wrote:
> > On Tue, Aug 02, 2016 at 11:00:09AM +0530, Pratyush Anand wrote:
> > > --- a/arch/arm64/include/asm/thread_info.h
> > > +++ b/arch/arm64/include/asm/thread_info.h
> > > @@ -109,6 +109,7 @@ static inline struct thread_info *current_thread_info(void)
> > >  #define TIF_NEED_RESCHED	1
> > >  #define TIF_NOTIFY_RESUME	2	/* callback before returning to user */
> > >  #define TIF_FOREIGN_FPSTATE	3	/* CPU's FP state is not current's */
> > > +#define TIF_UPROBE		5	/* uprobe breakpoint or singlestep */
> > 
> > Nitpick: you can just use 4 until we cover this gap.
> 
> Hummm..as stated in commit log, Shi Yang suggested to define TIF_UPROBE as 5 in
> stead of 4, since 4 has already been used in -rt kernel. May be, I can put a
> comment in code as well.
> Or, keep it 4 and -rt kernel will change their definitions. I am OK with both.
> let me know.

I forgot about the -rt kernel. I guess the -rt guys need to rebase the
patches anyway on top of mainline, so it's just a matter of sorting out
a minor conflict (as I already said, these bits are internal to the
kernel, so no ABI affected). For now, just use 4 so that we avoid
additional asm changes.

> > > --- a/arch/arm64/kernel/entry.S
> > > +++ b/arch/arm64/kernel/entry.S
> > > @@ -688,7 +688,8 @@ ret_fast_syscall:
> > >  	ldr	x1, [tsk, #TI_FLAGS]		// re-check for syscall tracing
> > >  	and	x2, x1, #_TIF_SYSCALL_WORK
> > >  	cbnz	x2, ret_fast_syscall_trace
> > > -	and	x2, x1, #_TIF_WORK_MASK
> > > +	mov     x2, #_TIF_WORK_MASK
> > > +	and     x2, x1, x2
> > 
> > Is this needed because _TIF_WORK_MASK cannot work as an immediate value
> > to 'and'? We could reorder the TIF bits, they are not exposed to user to
> > have ABI implications.
> 
> _TIF_WORK_MASK is defined as follows:
> 
> #define _TIF_WORK_MASK          (_TIF_NEED_RESCHED | _TIF_SIGPENDING | \
>                                   _TIF_NOTIFY_RESUME | _TIF_FOREIGN_FPSTATE | \
>                                   _TIF_UPROBE)
> Re-ordering will not help, because 0-3 have already been used by previous
> definitions. Only way to use immediate value could be if, TIF_UPROBE is defined
> as 4. 

Yes, see above.

> > > +unsigned long uprobe_get_swbp_addr(struct pt_regs *regs)
> > > +{
> > > +	return instruction_pointer(regs);
> > > +}
> > > +
> > > +int arch_uprobe_analyze_insn(struct arch_uprobe *auprobe, struct mm_struct *mm,
> > > +		unsigned long addr)
> > > +{
> > > +	probe_opcode_t insn;
> > > +
> > > +	/* TODO: Currently we do not support AARCH32 instruction probing */
> > 
> > Is there a way to check (not necessarily in this file) that we don't
> > probe 32-bit tasks?
> 
> - Well, I do not have complete idea about it that, how it can be done. I think
>   we can not check that just by looking a single bit in an instruction.
>   My understanding is that, we can only know about it when we are executing the
>   instruction, by reading pstate, but that would not be useful for uprobe
>   instruction analysis.
>   
>   I hope, instruction encoding for aarch32 and aarch64 are different, and by
>   analyzing for all types of aarch32 instructions, we will be able to decide
>   that whether instruction is 32 bit trace-able or not.  Accordingly, we can use
>   either BRK or BKPT instruction for breakpoint generation.

We may have some unrelated instruction encoding overlapping but I
haven't checked. I was more thinking about whether we know which task is
being probed and check is_compat_task() or maybe using
compat_user_mode(regs).

-- 
Catalin
