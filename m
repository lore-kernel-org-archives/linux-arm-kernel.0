From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 23 Sep 2016 14:05:28 +0100
Subject: [PATCH 5/5] arm64: Add uprobe support
In-Reply-To: <20160923041230.GC29470@localhost.localdomain>
References: <cover.1470114993.git.panand@redhat.com>
 <abaac6ebaa5dd63889803ec568663bc8c8c65b02.1470114993.git.panand@redhat.com>
 <20160920165946.GA19353@e104818-lin.cambridge.arm.com>
 <20160921110047.GA29470@localhost.localdomain>
 <20160921170403.GE12180@e104818-lin.cambridge.arm.com>
 <20160922032328.GB29470@localhost.localdomain>
 <20160922165030.GA27704@e104818-lin.cambridge.arm.com>
 <20160923041230.GC29470@localhost.localdomain>
Message-ID: <20160923130528.GE2161@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 23, 2016 at 09:42:30AM +0530, Pratyush Anand wrote:
> On 22/09/2016:05:50:30 PM, Catalin Marinas wrote:
> > On Thu, Sep 22, 2016 at 08:53:28AM +0530, Pratyush Anand wrote:
> > > On 21/09/2016:06:04:04 PM, Catalin Marinas wrote:
> > > > On Wed, Sep 21, 2016 at 04:30:47PM +0530, Pratyush Anand wrote:
> > > > > On 20/09/2016:05:59:46 PM, Catalin Marinas wrote:
> > > > > > > +int arch_uprobe_analyze_insn(struct arch_uprobe *auprobe, struct mm_struct *mm,
> > > > > > > +		unsigned long addr)
> > > > > > > +{
> > > > > > > +	probe_opcode_t insn;
> > > > > > > +
> > > > > > > +	/* TODO: Currently we do not support AARCH32 instruction probing */
> > > > > > 
> > > > > > Is there a way to check (not necessarily in this file) that we don't
> > > > > > probe 32-bit tasks?
> > > > > 
> > > > > - Well, I do not have complete idea about it that, how it can be done. I think
> > > > >   we can not check that just by looking a single bit in an instruction.
> > > > >   My understanding is that, we can only know about it when we are executing the
> > > > >   instruction, by reading pstate, but that would not be useful for uprobe
> > > > >   instruction analysis.
> > > > >   
> > > > >   I hope, instruction encoding for aarch32 and aarch64 are different, and by
> > > > >   analyzing for all types of aarch32 instructions, we will be able to decide
> > > > >   that whether instruction is 32 bit trace-able or not.  Accordingly, we can use
> > > > >   either BRK or BKPT instruction for breakpoint generation.
> > > > 
> > > > We may have some unrelated instruction encoding overlapping but I
> > > > haven't checked. I was more thinking about whether we know which task is
> > > > being probed and check is_compat_task() or maybe using
> > > > compat_user_mode(regs).
> > > 
> > > I had thought of this, but problem is that we might not have task in existence
> > > when we enable uprobes.  For example: Lets say we are inserting a trace probe at
> > > offset 0x690 in a executable binary.
> > > 
> > > echo "p test:0x690" > /sys/kernel/debug/tracing/uprobe_events
> > > echo 1 > /sys/kernel/debug/tracing/events/uprobes/enable
> > > 
> > > In the 'enable' step, it is decided that whether instruction is traceable or
> > > not. 
> > > 
> > > (1) But at this point 'test' executable might not be running.
> 
> Let me correct myself first here. When executable is not running, then,
> arch_uprobe_analyze_insn() is not called while uprobes enabling (ie writing '1'
> to 'enable'). In that case, it is called when binary is executed and task is
> created.

I kind of figured this out. This function needs to read the actual
instruction from memory, so that won't be possible until at least the
executable file has an address_space in the kernel. What's not clear to
me is how early this is done, do we have the mm_struct fully populated?

> > > (2) Even if it is running, is_compat_task() or compat_user_mode() might not be
> > > usable, as they work with 'current' task.
> > 
> > What I find strange is that uprobes allows you to insert a breakpoint
> > instruction that's not even compatible with the task (so it would
> > SIGILL rather than generate a debug exception).
> > 
> > > What I was thinking that, let it go with 'TODO' as of now. 
> > 
> > Only that I don't have any guarantee that someone is going to fix it ;).
> > 
> > As a quick workaround you could check mm->task_size > TASK_SIZE_32 in
> > the arch_uprobe_analyze_insn() function.
> 
> It would be doable. TASK_SIZE_32 is defined only for COMPAT. So, may be I can
> return -EINVAL when mm->task_size < TASK_SIZE_64.

That's just a temporary workaround. If we ever merge ILP32, this test
would no longer be enough (as the ISA is AArch64 but with TASK_SIZE_32).

Looking@prepare_uprobe(), we have a weak is_trap_insn() function.
This check is meaningless without knowing which instruction set we
target. A false positive here, however, is not that bad as we wouldn't
end up inserting the wrong breakpoint in the executable. But it looks to
me like the core uprobe code needs to pass some additional information
like the type of task or ELF format to the arch code to make a useful
choice of breakpoint type.

-- 
Catalin
