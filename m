From: will.deacon@arm.com (Will Deacon)
Date: Wed, 2 Oct 2013 11:18:46 +0100
Subject: [PATCH v2 2/3] AArch64: KGDB: Add Basic KGDB support
In-Reply-To: <CALicx6vpX6nm=zdBZTY57EgPRphcjMzwFxug6CAa_U21u4_4Cw@mail.gmail.com>
References: <1380534251-4464-1-git-send-email-vijay.kilari@gmail.com>
 <1380534251-4464-3-git-send-email-vijay.kilari@gmail.com>
 <20130930163654.GJ26036@mudshark.cambridge.arm.com>
 <CALicx6vpX6nm=zdBZTY57EgPRphcjMzwFxug6CAa_U21u4_4Cw@mail.gmail.com>
Message-ID: <20131002101846.GC28311@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 01, 2013 at 11:53:01AM +0100, Vijay Kilari wrote:
> On Mon, Sep 30, 2013 at 10:06 PM, Will Deacon <will.deacon@arm.com> wrote:
> > On Mon, Sep 30, 2013 at 10:44:10AM +0100, vijay.kilari at gmail.com wrote:
> >> +static inline void arch_kgdb_breakpoint(void)
> >> +{
> >> +       asm ("brk %0" :: "I" (KGDB_ARM64_COMPILE_BRK_IMM));
> >> +}
> >
> > Hmm, I need to find me a compiler guy, but I don't have much faith in this
> > function in the face of inlining. Sure a breakpoint needs to happen at a
> > specific point in the program? If so, why can't GCC re-order this asm block
> > as it likes?
> >
> > Or is there a restricted use-case for compiled breakpoints in kgdb?
> >
> As per Andrew,
> arch_kgdb_breakpoint is declared as static inline for the x86, arm, tile
> and powerpc.  Since the inline-asm does not have any output constraints
> it is considered volatile just like if you declare the inline-asm as volatile.
> The compiler might reorder some stuff around it due to all uses being explicit
> just like any other volatile inline-asm.
> 
> In fact, the arch_kgdb_breakpoint is called from only one place from
> kernel/debug/debug_core.c and there is no way for the compiler to
> reorder the block
> as it has two write barriers around it:
>         wmb(); /* Sync point before breakpoint */
>         arch_kgdb_breakpoint();
>         wmb(); /* Sync point after breakpoint */

A write barrier just looks like a memory clobber to the compiler, which
isn't enough to stop this being reordered wrt breakpoints. In fact, I don't
think is actually solvable with GCC since there is no way to emit a full
scheduling barrier using asm constraints (we'd need an intrinsic I think).

You could try clobbering every register, but that's filthy, and will likely
cause reload to generate some dreadful spills.

> >> +void
> >> +sleeping_thread_to_gdb_regs(unsigned long *gdb_regs, struct task_struct *task)
> >> +{
> >> +       struct pt_regs *thread_regs;
> >> +       int regno;
> >> +       int i;
> >> +
> >> +       /* Just making sure... */
> >> +       if (task == NULL)
> >> +               return;
> >
> > Erm... that comment just raises more questions. I appreciate ARM has the
> > same check, but why doesn't x86? Can task *actually* be NULL?
> >
> generally, the task will not be NULL. The check made because the
> caller (gdbstub.c)
> fetches task information from gdb global structure and calls this function.
> This helps in case the caller fails to pass task info. I think should not be
> problem with this check. In fact this is legacy code

Generally or always? Afaict, either other architectures have a bug here or
we have a redundant check. Regardless, it should be made consistent.

> >> +/*
> >> + * ARM instructions are always in LE.
> >> + * Break instruction is encoded in LE format
> >> + */
> >> +struct kgdb_arch arch_kgdb_ops = {
> >> +       .gdb_bpt_instr          = {0x00, 0x00, 0x20, 0xd4}
> >
> > Again, you should probably try and encode the dynamic breakpoint immediate
> > in here (which is sadly offset by 5 bits in the instruction encoding).
> >
> Yes, I propose to change like this
> 
> #define  KGDB_DYN_BRK_INS_BYTE0  ((KGDB_DYN_DGB_BRK_IMM & 0x7) << 5)
> #define  KGDB_DYN_BRK_INS_BYTE1  ((KGDB_DYN_DGB_BRK_IMM & 0x7f8) >> 3)
> #define  KGDB_DYN_BRK_INS_BYTE2  (0x20 | \
>                                  ((KGDB_DYN_DGB_BRK_IMM & 0xf800) >> 11))
> #define  KGDB_DYN_BRK_INS_BYTE3  0xd4

This would be cleaner if you #defined the complete instruction encoding:

#define AARCH64_BREAK_MON	0xd4200000

#define KGDB_DYN_BRK_BYTE(x)	\
	(((AARCH64_BREAK_MON | KGDB_DYN_DGB_BRK_IMM) >> (x * 8)) & 0xff)

Will
