From: panand@redhat.com (Pratyush Anand)
Date: Thu, 22 Sep 2016 08:53:28 +0530
Subject: [PATCH 5/5] arm64: Add uprobe support
In-Reply-To: <20160921170403.GE12180@e104818-lin.cambridge.arm.com>
References: <cover.1470114993.git.panand@redhat.com>
 <abaac6ebaa5dd63889803ec568663bc8c8c65b02.1470114993.git.panand@redhat.com>
 <20160920165946.GA19353@e104818-lin.cambridge.arm.com>
 <20160921110047.GA29470@localhost.localdomain>
 <20160921170403.GE12180@e104818-lin.cambridge.arm.com>
Message-ID: <20160922032328.GB29470@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/09/2016:06:04:04 PM, Catalin Marinas wrote:
> On Wed, Sep 21, 2016 at 04:30:47PM +0530, Pratyush Anand wrote:
> > On 20/09/2016:05:59:46 PM, Catalin Marinas wrote:
> > > > +int arch_uprobe_analyze_insn(struct arch_uprobe *auprobe, struct mm_struct *mm,
> > > > +		unsigned long addr)
> > > > +{
> > > > +	probe_opcode_t insn;
> > > > +
> > > > +	/* TODO: Currently we do not support AARCH32 instruction probing */
> > > 
> > > Is there a way to check (not necessarily in this file) that we don't
> > > probe 32-bit tasks?
> > 
> > - Well, I do not have complete idea about it that, how it can be done. I think
> >   we can not check that just by looking a single bit in an instruction.
> >   My understanding is that, we can only know about it when we are executing the
> >   instruction, by reading pstate, but that would not be useful for uprobe
> >   instruction analysis.
> >   
> >   I hope, instruction encoding for aarch32 and aarch64 are different, and by
> >   analyzing for all types of aarch32 instructions, we will be able to decide
> >   that whether instruction is 32 bit trace-able or not.  Accordingly, we can use
> >   either BRK or BKPT instruction for breakpoint generation.
> 
> We may have some unrelated instruction encoding overlapping but I
> haven't checked. I was more thinking about whether we know which task is
> being probed and check is_compat_task() or maybe using
> compat_user_mode(regs).

I had thought of this, but problem is that we might not have task in existence
when we enable uprobes.  For example: Lets say we are inserting a trace probe at
offset 0x690 in a executable binary.

echo "p test:0x690" > /sys/kernel/debug/tracing/uprobe_events
echo 1 > /sys/kernel/debug/tracing/events/uprobes/enable

In the 'enable' step, it is decided that whether instruction is traceable or
not. 

(1) But at this point 'test' executable might not be running.
(2) Even if it is running, is_compat_task() or compat_user_mode() might not be
usable, as they work with 'current' task.

What I was thinking that, let it go with 'TODO' as of now. 
Later on, we propose some changes in core layer, so that we can read the elf
headers of executable binary. ELFCLASS will be able to tell us, whether its a 32
bit or 64 bit executable. I think, moving "struct uprobe" from
kernel/events/uprobes.c to a include/linux header file will do the job.  "struct
arch_uprobe" is part of "struct uprobe". "struct arch_uprobe" is passed in
arch_uprobe_analyze_insn(). So, we can access struct uprobe's "inode" element
with this change. 

~Pratyush
