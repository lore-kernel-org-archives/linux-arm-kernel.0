From: mhiramat@kernel.org (Masami Hiramatsu)
Date: Tue, 28 Jun 2016 16:25:22 +0900
Subject: [PATCH v14 04/10] arm64: Kprobes with single stepping support
In-Reply-To: <57713301.2020706@linaro.org>
References: <1466996813-23295-1-git-send-email-dave.long@linaro.org>
 <1466996813-23295-5-git-send-email-dave.long@linaro.org>
 <20160627065749.GB29870@dhcppc9> <57713301.2020706@linaro.org>
Message-ID: <20160628162522.ee8ec57e686d8dc80c265211@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 27 Jun 2016 10:06:57 -0400
David Long <dave.long@linaro.org> wrote:

> On 06/27/2016 02:57 AM, Pratyush Anand wrote:
> > Hi David,
> >
> > On 26/06/2016:11:06:47 PM, David Long wrote:
> >> From: Sandeepa Prabhu <sandeepa.s.prabhu@gmail.com>
> >>
> >> Add support for basic kernel probes(kprobes) and jump probes
> >> (jprobes) for ARM64.
> >>
> >> Kprobes utilizes software breakpoint and single step debug
> >> exceptions supported on ARM v8.
> >>
> >> A software breakpoint is placed at the probe address to trap the
> >> kernel execution into the kprobe handler.
> >>
> >> ARM v8 supports enabling single stepping before the break exception
> >> return (ERET), with next PC in exception return address (ELR_EL1). The
> >> kprobe handler prepares an executable memory slot for out-of-line
> >> execution with a copy of the original instruction being probed, and
> >> enables single stepping. The PC is set to the out-of-line slot address
> >> before the ERET. With this scheme, the instruction is executed with the
> >> exact same register context except for the PC (and DAIF) registers.
> >>
> >> Debug mask (PSTATE.D) is enabled only when single stepping a recursive
> >> kprobe, e.g.: during kprobes reenter so that probed instruction can be
> >> single stepped within the kprobe handler -exception- context.
> >> The recursion depth of kprobe is always 2, i.e. upon probe re-entry,
> >> any further re-entry is prevented by not calling handlers and the case
> >> counted as a missed kprobe).
> >>
> >> Single stepping from the x-o-l slot has a drawback for PC-relative accesses
> >> like branching and symbolic literals access as the offset from the new PC
> >> (slot address) may not be ensured to fit in the immediate value of
> >> the opcode. Such instructions need simulation, so reject
> >> probing them.
> >>
> >> Instructions generating exceptions or cpu mode change are rejected
> >> for probing.
> >>
> >> Exclusive load/store instructions are rejected too.  Additionally, the
> >> code is checked to see if it is inside an exclusive load/store sequence
> >> (code from Pratyush).
> >>
> >> System instructions are mostly enabled for stepping, except MSR/MRS
> >> accesses to "DAIF" flags in PSTATE, which are not safe for
> >> probing.
> >>
> >> Thanks to Steve Capper and Pratyush Anand for several suggested
> >> Changes.
> >>
> >> Signed-off-by: Sandeepa Prabhu <sandeepa.s.prabhu@gmail.com>
> >> Signed-off-by: David A. Long <dave.long@linaro.org>
> >> Signed-off-by: Pratyush Anand <panand@redhat.com>
> >> ---
> >>   arch/arm64/Kconfig                      |   1 +
> >>   arch/arm64/include/asm/debug-monitors.h |   5 +
> >>   arch/arm64/include/asm/insn.h           |   2 +
> >>   arch/arm64/include/asm/kprobes.h        |  60 ++++
> >>   arch/arm64/include/asm/probes.h         |  34 +++
> >>   arch/arm64/include/asm/ptrace.h         |   1 +
> >>   arch/arm64/kernel/Makefile              |   2 +-
> >>   arch/arm64/kernel/debug-monitors.c      |  16 +-
> >>   arch/arm64/kernel/kprobes/Makefile      |   1 +
> >>   arch/arm64/kernel/kprobes/decode-insn.c | 143 +++++++++
> >>   arch/arm64/kernel/kprobes/decode-insn.h |  34 +++
> >>   arch/arm64/kernel/kprobes/kprobes.c     | 525 ++++++++++++++++++++++++++++++++
> >>   arch/arm64/kernel/vmlinux.lds.S         |   1 +
> >>   arch/arm64/mm/fault.c                   |  26 ++
> >>   14 files changed, 848 insertions(+), 3 deletions(-)
> >>   create mode 100644 arch/arm64/include/asm/kprobes.h
> >>   create mode 100644 arch/arm64/include/asm/probes.h
> >>   create mode 100644 arch/arm64/kernel/kprobes/Makefile
> >>   create mode 100644 arch/arm64/kernel/kprobes/decode-insn.c
> >>   create mode 100644 arch/arm64/kernel/kprobes/decode-insn.h
> >
> > Can we rename kernel/kprobes as kernel/probes? uprobes code will use
> > decode-insn.c and further simulate-insn.c as well. So, I would like to place my
> > uprobes.c in same directory.
> 
> I had some reservations about making it a "kprobes" subdir for that 
> reason but the advice I got was to simply go with Masami Hiramatsu's 
> specific feedback and have a subsequent uprobes patch move these files 
> to a replacement "probes" subdir.  If there ends up being yet another 
> revision of this patch maybe he will consider allowing it to be called 
> "probes" from the start.

Yeah, if you've already been sure it will be done,
I'm OK to rename it "probe" :) I just didn't know your work.


> 
> >
> >>   create mode 100644 arch/arm64/kernel/kprobes/kprobes.c
> >>
> >
> > [...]
> >
> >> diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
> >> index 6c0c7d3..c7bbeed 100644
> >> --- a/arch/arm64/include/asm/ptrace.h
> >> +++ b/arch/arm64/include/asm/ptrace.h
> >> @@ -209,6 +209,7 @@ struct task_struct;
> >>   int valid_user_regs(struct user_pt_regs *regs, struct task_struct *task);
> >>
> >>   #define instruction_pointer(regs)	((unsigned long)(regs)->pc)
> >> +#define instruction_pointer_set(regs, value)	((regs)->pc = ((u64) (value)))
> >
> > IIRC, Will Daecon had asked to include asm-generic/ptrace.h into asm/ptrace.h when
> > I had done similar changes for uprobe needs. May be you can pick patch from
> > my uprobe tree.

Ah, right. we have something similar routines in asm-generic/ptrace.h.

Feel free to include it.

Thanks,

> >
> > https://github.com/pratyushanand/linux/commit/bb3e114797c2888ed8ad528cca20e569dd2d818e
> 
> I will look at this.
> 
> >
> > ~Pratyush
> >
> 
> Thanks,
> -dl
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
