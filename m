From: steve.capper@linaro.org (Steve Capper)
Date: Thu, 13 Aug 2015 12:42:50 +0100
Subject: [PATCH v8 3/7] arm64: Kprobes with single stepping support
In-Reply-To: <1439254364-15362-4-git-send-email-dave.long@linaro.org>
References: <1439254364-15362-1-git-send-email-dave.long@linaro.org>
 <1439254364-15362-4-git-send-email-dave.long@linaro.org>
Message-ID: <CAPvkgC2qXiVUYjvUCQvmb6FFoAqCi-aP1eGay8_uWpM2C9XfFA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

On 11 August 2015 at 01:52, David Long <dave.long@linaro.org> wrote:
> From: Sandeepa Prabhu <sandeepa.s.prabhu@gmail.com>
>
> Add support for basic kernel probes(kprobes) and jump probes
> (jprobes) for ARM64.
>
> Kprobes utilizes software breakpoint and single step debug
> exceptions supported on ARM v8.
>
> A software breakpoint is placed at the probe address to trap the
> kernel execution into the kprobe handler.
>
> ARM v8 supports enabling single stepping before the break exception
> return (ERET), with next PC in exception return address (ELR_EL1). The
> kprobe handler prepares an executable memory slot for out-of-line
> execution with a copy of the original instruction being probed, and
> enables single stepping. The PC is set to the out-of-line slot address
> before the ERET. With this scheme, the instruction is executed with the
> exact same register context except for the PC (and DAIF) registers.
>
> Debug mask (PSTATE.D) is enabled only when single stepping a recursive
> kprobe, e.g.: during kprobes reenter so that probed instruction can be
> single stepped within the kprobe handler -exception- context.
> The recursion depth of kprobe is always 2, i.e. upon probe re-entry,
> any further re-entry is prevented by not calling handlers and the case
> counted as a missed kprobe).
>
> Single stepping from the x-o-l slot has a drawback for PC-relative accesses
> like branching and symbolic literals access as the offset from the new PC
> (slot address) may not be ensured to fit in the immediate value of
> the opcode. Such instructions need simulation, so reject
> probing them.
>
> Instructions generating exceptions or cpu mode change are rejected
> for probing.
>
> Instructions using Exclusive Monitor are rejected too.
>
> System instructions are mostly enabled for stepping, except MSR/MRS
> accesses to "DAIF" flags in PSTATE, which are not safe for
> probing.
>
> Thanks to Steve Capper and Pratyush Anand for several suggested
> Changes.
>
> Signed-off-by: Sandeepa Prabhu <sandeepa.s.prabhu@gmail.com>
> Signed-off-by: Steve Capper <steve.capper@linaro.org>

Please remove my SoB, we can replace it with a Reviewed-by hopefully soon :-).


> Signed-off-by: David A. Long <dave.long@linaro.org>
> ---
>  arch/arm64/Kconfig                      |   1 +
>  arch/arm64/include/asm/debug-monitors.h |   5 +
>  arch/arm64/include/asm/kprobes.h        |  62 ++++
>  arch/arm64/include/asm/probes.h         |  50 +++
>  arch/arm64/include/asm/ptrace.h         |   3 +-
>  arch/arm64/kernel/Makefile              |   1 +
>  arch/arm64/kernel/debug-monitors.c      |  35 ++-
>  arch/arm64/kernel/kprobes-arm64.c       |  68 ++++
>  arch/arm64/kernel/kprobes-arm64.h       |  28 ++
>  arch/arm64/kernel/kprobes.c             | 537 ++++++++++++++++++++++++++++++++
>  arch/arm64/kernel/kprobes.h             |  24 ++
>  arch/arm64/kernel/vmlinux.lds.S         |   1 +
>  arch/arm64/mm/fault.c                   |  25 ++
>  13 files changed, 829 insertions(+), 11 deletions(-)
>  create mode 100644 arch/arm64/include/asm/kprobes.h
>  create mode 100644 arch/arm64/include/asm/probes.h
>  create mode 100644 arch/arm64/kernel/kprobes-arm64.c
>  create mode 100644 arch/arm64/kernel/kprobes-arm64.h
>  create mode 100644 arch/arm64/kernel/kprobes.c
>  create mode 100644 arch/arm64/kernel/kprobes.h
>

[...]

> +
> +void __kprobes kprobe_handler(struct pt_regs *regs)
> +{
> +       struct kprobe *p, *cur;
> +       struct kprobe_ctlblk *kcb;
> +       unsigned long addr = instruction_pointer(regs);
> +
> +       kcb = get_kprobe_ctlblk();
> +       cur = kprobe_running();
> +
> +       p = get_kprobe((kprobe_opcode_t *) addr);
> +
> +       if (p) {
> +               if (cur) {
> +                       if (reenter_kprobe(p, regs, kcb))
> +                               return;
> +               } else if (!p->ainsn.check_condn ||
> +                          p->ainsn.check_condn(p, regs)) {
> +                       /* Probe hit and conditional execution check ok. */
> +                       set_current_kprobe(p);
> +                       kcb->kprobe_status = KPROBE_HIT_ACTIVE;
> +
> +                       /*
> +                        * If we have no pre-handler or it returned 0, we
> +                        * continue with normal processing.  If we have a
> +                        * pre-handler and it returned non-zero, it prepped
> +                        * for calling the break_handler below on re-entry,
> +                        * so get out doing nothing more here.
> +                        *
> +                        * pre_handler can hit a breakpoint and can step thru
> +                        * before return, keep PSTATE D-flag enabled until
> +                        * pre_handler return back.
> +                        */
> +                       if (!p->pre_handler || !p->pre_handler(p, regs)) {
> +                               kcb->kprobe_status = KPROBE_HIT_SS;
> +                               setup_singlestep(p, regs, kcb, 0);
> +                               return;
> +                       }
> +               } else {
> +                       /*
> +                        * Breakpoint hit but conditional check failed,
> +                        * so just skip the instruction (NOP behaviour)
> +                        */
> +                       skip_singlestep_missed(kcb, regs);
> +                       return;

Sorry, I'm still unconvinced by this. :-(

I had a play with kprobes on my x86 box and my arm64 devboard running
this series.

On x86, I had the following two consecutive instructions from do_fork:

ffffffff810a0972:       f7 c7 00 00 80 00       test   $0x800000,%edi
ffffffff810a0978:       75 42                   jne
ffffffff810a09bc <do_fork+0x7c>

I had the kprobes set up as follows:
# cat kprobe_events
p:kprobes/probe1 0xffffffff810a0972
p:kprobes/probe2 0xffffffff810a0978

Now on my arm64 devboard in do_fork, I was interested in the following
two consecutive instructions:
ffffffc0000bbf54:       f9402ba1        ldr     x1, [x29,#80]
ffffffc0000bbf58:       37b80215        tbnz    w21, #23,
ffffffc0000bbf98 <_do_fork+0x80>

Which had kprobes set up thusly:
# cat kprobe_events
p:kprobes/armprobe1 0xffffffc0000bbf54
p:kprobes/armprobe2 0xffffffc0000bbf58

The last instruction in each pair corresponds to the same line of C
code in _do_fork:
"        if (!(clone_flags & CLONE_UNTRACED)) {"
So I would expect them to behave very similarly on both systems.

Now on x86, if I take a look at kprobe_profile:
# cat kprobe_profile
  probe1                                                    72               0
  probe2                                                    72               0

And for arm64:
# cat kprobe_profile
  armprobe1                                                 40               0
  armprobe2                                                  0               0

For both systems I would expect the counts of the two probes to be
identical as both instructions are "hit".
On x86 this appears to be the case, but not for arm64.

I know arm and arm64 are the same; but I do think their behaviour
should match x86 in this regard.
(i.e. I believe arm should be changed too).

Cheers,
--
Steve
