From: dave.long@linaro.org (David Long)
Date: Tue, 8 Dec 2015 01:05:06 -0500
Subject: [PATCH v8 3/7] arm64: Kprobes with single stepping support
In-Reply-To: <20150812133716.GA23540@arm.com>
References: <1439254364-15362-1-git-send-email-dave.long@linaro.org>
 <1439254364-15362-4-git-send-email-dave.long@linaro.org>
 <20150812133716.GA23540@arm.com>
Message-ID: <56667312.7040400@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/12/15 09:37, Will Deacon wrote:
> Hi David,
>
> Thanks for the patch. Took me a while to get through it and I suspect
> I missed things, but comments inline all the same.
>

Sorry for the big delay in responding.  You did have a fair few 
questions though.  I'm still chasing down a couple answers.

> On Tue, Aug 11, 2015 at 01:52:40AM +0100, David Long wrote:
>> From: Sandeepa Prabhu <sandeepa.s.prabhu@gmail.com>
>>
>> Add support for basic kernel probes(kprobes) and jump probes
>> (jprobes) for ARM64.
>>
>> Kprobes utilizes software breakpoint and single step debug
>> exceptions supported on ARM v8.
>>
>> A software breakpoint is placed at the probe address to trap the
>> kernel execution into the kprobe handler.
>>
>> ARM v8 supports enabling single stepping before the break exception
>> return (ERET), with next PC in exception return address (ELR_EL1). The
>> kprobe handler prepares an executable memory slot for out-of-line
>> execution with a copy of the original instruction being probed, and
>> enables single stepping. The PC is set to the out-of-line slot address
>> before the ERET. With this scheme, the instruction is executed with the
>> exact same register context except for the PC (and DAIF) registers.
>>
>> Debug mask (PSTATE.D) is enabled only when single stepping a recursive
>> kprobe, e.g.: during kprobes reenter so that probed instruction can be
>> single stepped within the kprobe handler -exception- context.
>> The recursion depth of kprobe is always 2, i.e. upon probe re-entry,
>> any further re-entry is prevented by not calling handlers and the case
>> counted as a missed kprobe).
>>
>> Single stepping from the x-o-l slot has a drawback for PC-relative accesses
>> like branching and symbolic literals access as the offset from the new PC
>> (slot address) may not be ensured to fit in the immediate value of
>> the opcode. Such instructions need simulation, so reject
>> probing them.
>>
>> Instructions generating exceptions or cpu mode change are rejected
>> for probing.
>>
>> Instructions using Exclusive Monitor are rejected too.
>>
>> System instructions are mostly enabled for stepping, except MSR/MRS
>> accesses to "DAIF" flags in PSTATE, which are not safe for
>> probing.
>
> I can imagine other MSR instructions that aren't safe for probing too
> For example, disabling the MMU. Maybe we should just blanket-ban these
> guys for now?
>

Yeah, done.

>> diff --git a/arch/arm64/include/asm/debug-monitors.h b/arch/arm64/include/asm/debug-monitors.h
>> index 40ec68a..92d7cea 100644
>> --- a/arch/arm64/include/asm/debug-monitors.h
>> +++ b/arch/arm64/include/asm/debug-monitors.h
>> @@ -90,6 +90,11 @@
>>
>>   #define CACHE_FLUSH_IS_SAFE            1
>>
>> +/* kprobes BRK opcodes with ESR encoding  */
>> +#define BRK64_ESR_MASK         0xFFFF
>> +#define BRK64_ESR_KPROBES      0x0004
>> +#define BRK64_OPCODE_KPROBES   (AARCH64_BREAK_MON | (BRK64_ESR_KPROBES << 5))
>
> These are probably due some slight renaming with the BRK clean-up we've
> got queued for 4.3.

I've made a minor change that I think addresses this.

>
>>   /* AArch32 */
>>   #define DBG_ESR_EVT_BKPT       0x4
>>   #define DBG_ESR_EVT_VECC       0x5
>> diff --git a/arch/arm64/include/asm/kprobes.h b/arch/arm64/include/asm/kprobes.h
>> new file mode 100644
>> index 0000000..af31c4d
>> --- /dev/null
>> +++ b/arch/arm64/include/asm/kprobes.h
>> @@ -0,0 +1,62 @@
>> +/*
>> + * arch/arm64/include/asm/kprobes.h
>> + *
>> + * Copyright (C) 2013 Linaro Limited
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>> + * General Public License for more details.
>> + */
>> +
>> +#ifndef _ARM_KPROBES_H
>> +#define _ARM_KPROBES_H
>> +
>> +#include <linux/types.h>
>> +#include <linux/ptrace.h>
>> +#include <linux/percpu.h>
>> +
>> +#define __ARCH_WANT_KPROBES_INSN_SLOT
>> +#define MAX_INSN_SIZE                  1
>> +#define MAX_STACK_SIZE                 128
>> +
>> +#define flush_insn_slot(p)             do { } while (0)
>> +#define kretprobe_blacklist_size       0
>> +
>> +#include <asm/probes.h>
>> +
>> +struct prev_kprobe {
>> +       struct kprobe *kp;
>> +       unsigned int status;
>> +};
>> +
>> +/* Single step context for kprobe */
>> +struct kprobe_step_ctx {
>> +#define KPROBES_STEP_NONE      0x0
>> +#define KPROBES_STEP_PENDING   0x1
>> +       unsigned long ss_status;
>
> Why not bool ss_pending?
>

Presumably this was to allow for other possible states, which turned out 
to be uneeded.  I've changed it to a bool.

>> +       unsigned long match_addr;
>> +};
>> +
>> +/* per-cpu kprobe control block */
>> +struct kprobe_ctlblk {
>> +       unsigned int kprobe_status;
>> +       unsigned long saved_irqflag;
>> +       struct prev_kprobe prev_kprobe;
>> +       struct kprobe_step_ctx ss_ctx;
>> +       struct pt_regs jprobe_saved_regs;
>> +       char jprobes_stack[MAX_STACK_SIZE];
>> +};
>> +
>> +void arch_remove_kprobe(struct kprobe *);
>> +int kprobe_fault_handler(struct pt_regs *regs, unsigned int fsr);
>> +int kprobe_exceptions_notify(struct notifier_block *self,
>> +                            unsigned long val, void *data);
>> +int kprobe_breakpoint_handler(struct pt_regs *regs, unsigned int esr);
>> +int kprobe_single_step_handler(struct pt_regs *regs, unsigned int esr);
>> +
>> +#endif /* _ARM_KPROBES_H */
>> diff --git a/arch/arm64/include/asm/probes.h b/arch/arm64/include/asm/probes.h
>> new file mode 100644
>> index 0000000..7f5a27f
>> --- /dev/null
>> +++ b/arch/arm64/include/asm/probes.h
>> @@ -0,0 +1,50 @@
>> +/*
>> + * arch/arm64/include/asm/probes.h
>> + *
>> + * Copyright (C) 2013 Linaro Limited
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>> + * General Public License for more details.
>> + */
>> +#ifndef _ARM_PROBES_H
>> +#define _ARM_PROBES_H
>> +
>> +struct kprobe;
>> +struct arch_specific_insn;
>> +
>> +typedef u32 kprobe_opcode_t;
>> +typedef unsigned long (kprobes_pstate_check_t)(unsigned long);
>> +typedef unsigned long
>> +(probes_condition_check_t)(struct kprobe *p, struct pt_regs *);
>> +typedef void
>> +(probes_prepare_t)(struct kprobe *, struct arch_specific_insn *);
>> +typedef void (kprobes_handler_t) (u32 opcode, long addr, struct pt_regs *);
>> +
>> +enum pc_restore_type {
>> +       NO_RESTORE,
>> +       RESTORE_PC,
>> +};
>> +
>> +struct kprobe_pc_restore {
>> +       enum pc_restore_type type;
>> +       unsigned long addr;
>> +};
>> +
>> +/* architecture specific copy of original instruction */
>> +struct arch_specific_insn {
>> +       kprobe_opcode_t *insn;
>> +       kprobes_pstate_check_t *pstate_cc;
>> +       probes_condition_check_t *check_condn;
>> +       probes_prepare_t *prepare;
>> +       kprobes_handler_t *handler;
>> +       /* restore address after step xol */
>> +       struct kprobe_pc_restore restore;
>> +};
>> +
>> +#endif
>> diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
>> index 8f440e9..aadf61a 100644
>> --- a/arch/arm64/include/asm/ptrace.h
>> +++ b/arch/arm64/include/asm/ptrace.h
>> @@ -206,7 +206,8 @@ static inline int valid_user_regs(struct user_pt_regs *regs)
>>          return 0;
>>   }
>>
>> -#define instruction_pointer(regs)      ((unsigned long)(regs)->pc)
>> +#define instruction_pointer(regs)      ((regs)->pc)
>> +#define stack_pointer(regs)            ((regs)->sp)
>
> We already have kernel_stack_pointer (I think you added it in patch 1),
> so can't you just use that?
>

Yup, done.

>>   #ifdef CONFIG_SMP
>>   extern unsigned long profile_pc(struct pt_regs *regs);
>> diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
>> index 426d076..1319872 100644
>> --- a/arch/arm64/kernel/Makefile
>> +++ b/arch/arm64/kernel/Makefile
>> @@ -32,6 +32,7 @@ arm64-obj-$(CONFIG_CPU_PM)            += sleep.o suspend.o
>>   arm64-obj-$(CONFIG_CPU_IDLE)           += cpuidle.o
>>   arm64-obj-$(CONFIG_JUMP_LABEL)         += jump_label.o
>>   arm64-obj-$(CONFIG_KGDB)               += kgdb.o
>> +arm64-obj-$(CONFIG_KPROBES)            += kprobes.o kprobes-arm64.o
>>   arm64-obj-$(CONFIG_EFI)                        += efi.o efi-stub.o efi-entry.o
>>   arm64-obj-$(CONFIG_PCI)                        += pci.o
>>   arm64-obj-$(CONFIG_ARMV8_DEPRECATED)   += armv8_deprecated.o
>> diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
>> index b056369..486ee94 100644
>> --- a/arch/arm64/kernel/debug-monitors.c
>> +++ b/arch/arm64/kernel/debug-monitors.c
>> @@ -23,6 +23,7 @@
>>   #include <linux/hardirq.h>
>>   #include <linux/init.h>
>>   #include <linux/ptrace.h>
>> +#include <linux/kprobes.h>
>>   #include <linux/stat.h>
>>   #include <linux/uaccess.h>
>>
>> @@ -228,6 +229,7 @@ static int single_step_handler(unsigned long addr, unsigned int esr,
>>                                 struct pt_regs *regs)
>>   {
>>          siginfo_t info;
>> +       bool handler_found = false;
>>
>>          /*
>>           * If we are stepping a pending breakpoint, call the hw_breakpoint
>> @@ -251,15 +253,21 @@ static int single_step_handler(unsigned long addr, unsigned int esr,
>>                   */
>>                  user_rewind_single_step(current);
>>          } else {
>> +#ifdef CONFIG_KPROBES
>> +               if (kprobe_single_step_handler(regs, esr) == DBG_HOOK_HANDLED)
>> +                       handler_found = true;
>> +#endif
>>                  if (call_step_hook(regs, esr) == DBG_HOOK_HANDLED)
>
> Is this because you need to called first? If so, maybe we could extend the
> step hook to take an optional priority and reject duplicate entries with
> the same value?
>

This is because I had a comment from Masami Hiramatsu (on Feb. 18) on 
the v5 version of the patches, explicitly recommending against using the 
general hook mechanism in that version of the patch.  It was stated that 
it could add a lot of unexpected dependencies, which might be probed 
code.  Locking code was of particular concern.

> Even then, it's not clear that you do always want to be called first. For
> example, if the instruction you're single-stepping in the x-o-l buffer
> triggers a hardware watchpoint, then you probably want to handle the
> watchpoint single-step exception before the kprobe.
>
>> -                       return 0;
>> -
>> -               pr_warning("Unexpected kernel single-step exception at EL1\n");
>> -               /*
>> -                * Re-enable stepping since we know that we will be
>> -                * returning to regs.
>> -                */
>> -               set_regs_spsr_ss(regs);
>> +                       handler_found = true;
>> +
>> +               if (!handler_found) {
>> +                       pr_warn("Unexpected kernel single-step exception at EL1\n");
>> +                       /*
>> +                        * Re-enable stepping since we know that we will be
>> +                        * returning to regs.
>> +                        */
>> +                       set_regs_spsr_ss(regs);
>> +               }
>>          }
>>
>>          return 0;
>> @@ -315,8 +323,15 @@ static int brk_handler(unsigned long addr, unsigned int esr,
>>                  };
>>
>>                  force_sig_info(SIGTRAP, &info, current);
>> -       } else if (call_break_hook(regs, esr) != DBG_HOOK_HANDLED) {
>> -               pr_warning("Unexpected kernel BRK exception at EL1\n");
>> +       }
>> +#ifdef CONFIG_KPROBES
>> +       else if ((esr & BRK64_ESR_MASK) == BRK64_ESR_KPROBES) {
>> +               if (kprobe_breakpoint_handler(regs, esr) != DBG_HOOK_HANDLED)
>> +                       return -EFAULT;
>> +       }
>> +#endif
>> +       else if (call_break_hook(regs, esr) != DBG_HOOK_HANDLED) {
>> +               pr_warn("Unexpected kernel BRK exception at EL1\n");
>
> Same here.
>

[ see above response ]

> Also, we now use BRK to implement BUG(), but I *think* that's ok because
> you reject kprobes on exception generating instructions.
>

Noted and agreed.

>>                  return -EFAULT;
>>          }
>>
>> diff --git a/arch/arm64/kernel/kprobes-arm64.c b/arch/arm64/kernel/kprobes-arm64.c
>> new file mode 100644
>> index 0000000..f958c52
>> --- /dev/null
>> +++ b/arch/arm64/kernel/kprobes-arm64.c
>> @@ -0,0 +1,68 @@
>> +/*
>> + * arch/arm64/kernel/kprobes-arm64.c
>> + *
>> + * Copyright (C) 2013 Linaro Limited.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>> + * General Public License for more details.
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/kprobes.h>
>> +#include <linux/module.h>
>> +#include <asm/kprobes.h>
>> +#include <asm/insn.h>
>> +
>> +#include "kprobes-arm64.h"
>> +
>> +static bool __kprobes aarch64_insn_is_steppable(u32 insn)
>> +{
>> +       if (aarch64_get_insn_class(insn) == AARCH64_INSN_CLS_BR_SYS) {
>> +               if (aarch64_insn_is_branch(insn))
>> +                       return false;
>> +
>> +               /* modification of daif creates issues */
>> +               if (aarch64_insn_is_daif_access(insn))
>> +                       return false;
>> +
>> +               if (aarch64_insn_is_exception(insn))
>> +                       return false;
>> +
>> +               if (aarch64_insn_is_hint(insn))
>> +                       return aarch64_insn_is_nop(insn);
>> +
>> +               return true;
>> +       }
>> +
>> +       if (aarch64_insn_uses_literal(insn))
>> +               return false;
>> +
>> +       if (aarch64_insn_is_exclusive(insn))
>> +               return false;
>> +
>> +       return true;
>> +}
>> +
>> +/* Return:
>> + *   INSN_REJECTED     If instruction is one not allowed to kprobe,
>> + *   INSN_GOOD         If instruction is supported and uses instruction slot,
>> + *   INSN_GOOD_NO_SLOT If instruction is supported but doesn't use its slot.
>> + */
>> +enum kprobe_insn __kprobes
>> +arm_kprobe_decode_insn(kprobe_opcode_t insn, struct arch_specific_insn *asi)
>> +{
>> +       /*
>> +        * Instructions reading or modifying the PC won't work from the XOL
>> +        * slot.
>> +        */
>> +       if (aarch64_insn_is_steppable(insn))
>> +               return INSN_GOOD;
>> +       else
>> +               return INSN_REJECTED;
>> +}
>> diff --git a/arch/arm64/kernel/kprobes-arm64.h b/arch/arm64/kernel/kprobes-arm64.h
>> new file mode 100644
>> index 0000000..87e7891
>> --- /dev/null
>> +++ b/arch/arm64/kernel/kprobes-arm64.h
>> @@ -0,0 +1,28 @@
>> +/*
>> + * arch/arm64/kernel/kprobes-arm64.h
>> + *
>> + * Copyright (C) 2013 Linaro Limited.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>> + * General Public License for more details.
>> + */
>> +
>> +#ifndef _ARM_KERNEL_KPROBES_ARM64_H
>> +#define _ARM_KERNEL_KPROBES_ARM64_H
>> +
>> +enum kprobe_insn {
>> +       INSN_REJECTED,
>> +       INSN_GOOD_NO_SLOT,
>> +       INSN_GOOD,
>> +};
>> +
>> +enum kprobe_insn __kprobes
>> +arm_kprobe_decode_insn(kprobe_opcode_t insn, struct arch_specific_insn *asi);
>> +
>> +#endif /* _ARM_KERNEL_KPROBES_ARM64_H */
>> diff --git a/arch/arm64/kernel/kprobes.c b/arch/arm64/kernel/kprobes.c
>> new file mode 100644
>> index 0000000..601d2c6
>> --- /dev/null
>> +++ b/arch/arm64/kernel/kprobes.c
>> @@ -0,0 +1,537 @@
>> +/*
>> + * arch/arm64/kernel/kprobes.c
>> + *
>> + * Kprobes support for ARM64
>> + *
>> + * Copyright (C) 2013 Linaro Limited.
>> + * Author: Sandeepa Prabhu <sandeepa.prabhu@linaro.org>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>> + * General Public License for more details.
>> + *
>> + */
>> +#include <linux/kernel.h>
>> +#include <linux/kprobes.h>
>> +#include <linux/module.h>
>> +#include <linux/slab.h>
>> +#include <linux/stop_machine.h>
>> +#include <linux/stringify.h>
>> +#include <asm/traps.h>
>> +#include <asm/ptrace.h>
>> +#include <asm/cacheflush.h>
>> +#include <asm/debug-monitors.h>
>> +#include <asm/system_misc.h>
>> +#include <asm/insn.h>
>> +
>> +#include "kprobes.h"
>> +#include "kprobes-arm64.h"
>> +
>> +#define MIN_STACK_SIZE(addr)   min((unsigned long)MAX_STACK_SIZE,      \
>> +       (unsigned long)current_thread_info() + THREAD_START_SP - (addr))
>
> You can avoid the cast by using task_stack_page(current).
>

That looks like it returns a pointer to a struct instead of the needed 
integer value.

> That said, I don't fully understand what this is for. Given that we don't
> probe the exception text, we should always have at least MAX_STACK_SIZE
> pushed on the stack thanks to the pt_regs structure, so when does this
> condition ever evaluate to something less?
>

Looks like this is borrowed from the x86 code. The end purpose is to 
save the saved stack while running a jprobe handler, so the real 
jprobe'd function then gets uncorrupted data (e.g.: from callee-owned 
parameters passed on the stack).  I think the goal of the define is to 
ensure we don't memcpy more of the relevant stack than actually exists 
at this point.

>> +DEFINE_PER_CPU(struct kprobe *, current_kprobe) = NULL;
>> +DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
>> +
>> +static void __kprobes arch_prepare_ss_slot(struct kprobe *p)
>> +{
>> +       /* prepare insn slot */
>> +       p->ainsn.insn[0] = p->opcode;
>> +
>> +       flush_icache_range((uintptr_t) (p->ainsn.insn),
>> +                          (uintptr_t) (p->ainsn.insn) + MAX_INSN_SIZE);
>
> Hmm, is this right? MAX_INSN_SIZE is 1, so I don't think you're flushing
> enough (but in reality you'll flush a whole cacheline and get away with
> it).
>

Yes, fixed.

>> +
>> +       /*
>> +        * Needs restoring of return address after stepping xol.
>> +        */
>> +       p->ainsn.restore.addr = (unsigned long) p->addr +
>> +         sizeof(kprobe_opcode_t);
>> +       p->ainsn.restore.type = RESTORE_PC;
>> +}
>> +
>> +int __kprobes arch_prepare_kprobe(struct kprobe *p)
>> +{
>> +       kprobe_opcode_t insn;
>> +       unsigned long probe_addr = (unsigned long)p->addr;
>
> x86 has some complications to deal with multiple kprobes on the same
> address afaict. Do we care about that at all?
>

I think basic kprobes handles that all in architecture-independent code. 
Are you referring to the kretprobe trampoline handler's searching of the 
list of recursive kretprobes to find the real return address?  That code 
lives in trampoline_probe_handler() in patch #6 of this series.

>> +       /* copy instruction */
>> +       insn = *p->addr;
>
> Instructions are always little-endian, so I think you need an le32_to_cpu
> here to work on a big-endian kernel. I suspect you may have a few other
> endianness bugs lurking, so it would be worth testing this in big-endian
> (you can run a big-endian kvm guest easily enough under kvmtool).
>

OK.  I found a couple more cases.  I have been getting some help testing 
this on real hardware (although more help would be good).

>> +       p->opcode = insn;
>> +
>> +       if (in_exception_text(probe_addr))
>> +               return -EINVAL;
>> +
>> +       /* decode instruction */
>> +       switch (arm_kprobe_decode_insn(insn, &p->ainsn)) {
>> +       case INSN_REJECTED:     /* insn not supported */
>> +               return -EINVAL;
>> +
>> +       case INSN_GOOD_NO_SLOT: /* insn need simulation */
>> +               return -EINVAL;
>> +
>> +       case INSN_GOOD: /* instruction uses slot */
>> +               p->ainsn.insn = get_insn_slot();
>> +               if (!p->ainsn.insn)
>> +                       return -ENOMEM;
>> +               break;
>> +       };
>> +
>> +       /* prepare the instruction */
>> +       arch_prepare_ss_slot(p);
>> +
>> +       return 0;
>> +}
>> +
>> +static int __kprobes patch_text(kprobe_opcode_t *addr, u32 opcode)
>> +{
>> +       void *addrs[1];
>> +       u32 insns[1];
>> +
>> +       addrs[0] = (void *)addr;
>> +       insns[0] = (u32)opcode;
>> +
>> +       return aarch64_insn_patch_text_sync(addrs, insns, 1);
>
> Any reason not to use aarch64_insn_patch_text here?
>

If I understand this correctly then, no.  I've made the change.

>> +}
>> +
>> +/* arm kprobe: install breakpoint in text */
>> +void __kprobes arch_arm_kprobe(struct kprobe *p)
>> +{
>> +       patch_text(p->addr, BRK64_OPCODE_KPROBES);
>> +}
>> +
>> +/* disarm kprobe: remove breakpoint from text */
>> +void __kprobes arch_disarm_kprobe(struct kprobe *p)
>> +{
>> +       patch_text(p->addr, p->opcode);
>> +}
>> +
>> +void __kprobes arch_remove_kprobe(struct kprobe *p)
>> +{
>> +       if (p->ainsn.insn) {
>> +               free_insn_slot(p->ainsn.insn, 0);
>> +               p->ainsn.insn = NULL;
>> +       }
>> +}
>> +
>> +static void __kprobes save_previous_kprobe(struct kprobe_ctlblk *kcb)
>> +{
>> +       kcb->prev_kprobe.kp = kprobe_running();
>> +       kcb->prev_kprobe.status = kcb->kprobe_status;
>> +}
>> +
>> +static void __kprobes restore_previous_kprobe(struct kprobe_ctlblk *kcb)
>> +{
>> +       __this_cpu_write(current_kprobe, kcb->prev_kprobe.kp);
>> +       kcb->kprobe_status = kcb->prev_kprobe.status;
>> +}
>> +
>> +static void __kprobes set_current_kprobe(struct kprobe *p)
>> +{
>> +       __this_cpu_write(current_kprobe, p);
>> +}
>> +
>> +/*
>> + * The D-flag (Debug mask) is set (masked) upon exception entry.
>
> To avoid confusing the casual reader, can we specify that we're talking
> about *debug* exception entry, please?
>

OK

>> + * Kprobes needs to clear (unmask) D-flag -ONLY- in case of recursive
>> + * probe i.e. when probe hit from kprobe handler context upon
>> + * executing the pre/post handlers. In this case we return with
>> + * D-flag clear so that single-stepping can be carried-out.
>> + *
>> + * Leave D-flag set in all other cases.
>> + */
>> +static void __kprobes
>> +spsr_set_debug_flag(struct pt_regs *regs, int mask)
>> +{
>> +       unsigned long spsr = regs->pstate;
>> +
>> +       if (mask)
>> +               spsr |= PSR_D_BIT;
>> +       else
>> +               spsr &= ~PSR_D_BIT;
>> +
>> +       regs->pstate = spsr;
>> +}
>
> This continues to melt my brain, but I think it's the right thing to do
> as long as the krpobes recursion is bound (as you stated in the commit
> log).
>

It always takes me a while to get the whole exception/interrupt 
processing scenario straight in my head when I return to thinking about 
it.  Glad I'm not the only one.  Many thanks again to William Cohen for 
his contributions to this.

>> +
>> +/*
>> + * Interrupts need to be disabled before single-step mode is set, and not
>> + * reenabled until after single-step mode ends.
>> + * Without disabling interrupt on local CPU, there is a chance of
>> + * interrupt occurrence in the period of exception return and  start of
>> + * out-of-line single-step, that result in wrongly single stepping
>> + * the interrupt handler.
>
> *into* the interrupt handler.
>

Fixed.

> Curious: what happens if the instruction aborts for some other reason?
> I assume we forbid probing copy_from_user etc?
>

I will test this.

>> + */
>> +static void __kprobes kprobes_save_local_irqflag(struct pt_regs *regs)
>> +{
>> +       struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
>> +
>> +       kcb->saved_irqflag = regs->pstate;
>> +       regs->pstate |= PSR_I_BIT;
>> +}
>> +
>> +static void __kprobes kprobes_restore_local_irqflag(struct pt_regs *regs)
>> +{
>> +       struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
>> +
>> +       if (kcb->saved_irqflag & PSR_I_BIT)
>> +               regs->pstate |= PSR_I_BIT;
>> +       else
>> +               regs->pstate &= ~PSR_I_BIT;
>> +}
>> +
>> +static void __kprobes
>> +set_ss_context(struct kprobe_ctlblk *kcb, unsigned long addr)
>> +{
>> +       kcb->ss_ctx.ss_status = KPROBES_STEP_PENDING;
>> +       kcb->ss_ctx.match_addr = addr + sizeof(kprobe_opcode_t);
>> +}
>> +
>> +static void __kprobes clear_ss_context(struct kprobe_ctlblk *kcb)
>> +{
>> +       kcb->ss_ctx.ss_status = KPROBES_STEP_NONE;
>> +       kcb->ss_ctx.match_addr = 0;
>> +}
>> +
>> +static void __kprobes
>> +skip_singlestep_missed(struct kprobe_ctlblk *kcb, struct pt_regs *regs)
>> +{
>> +       /* set return addr to next pc to continue */
>> +       instruction_pointer(regs) += sizeof(kprobe_opcode_t);
>> +}
>> +
>> +static void __kprobes setup_singlestep(struct kprobe *p,
>> +                                      struct pt_regs *regs,
>> +                                      struct kprobe_ctlblk *kcb, int reenter)
>> +{
>> +       unsigned long slot;
>> +
>> +       if (reenter) {
>> +               save_previous_kprobe(kcb);
>> +               set_current_kprobe(p);
>> +               kcb->kprobe_status = KPROBE_REENTER;
>> +       } else {
>> +               kcb->kprobe_status = KPROBE_HIT_SS;
>> +       }
>> +
>> +       if (p->ainsn.insn) {
>> +               /* prepare for single stepping */
>> +               slot = (unsigned long)p->ainsn.insn;
>> +
>> +               set_ss_context(kcb, slot);      /* mark pending ss */
>> +
>> +               if (kcb->kprobe_status == KPROBE_REENTER)
>> +                       spsr_set_debug_flag(regs, 0);
>> +
>> +               /* IRQs and single stepping do not mix well. */
>> +               kprobes_save_local_irqflag(regs);
>> +               kernel_enable_single_step(regs);
>> +               instruction_pointer(regs) = slot;
>
> Have you tried this with CONFIG_DEBUG_RODATA=y? I'm not sure that the
> buffer will be executable in that case.
>

I tested this on 4.3-rc2 and setting DEBUG_RODATA did not change 
anything. Kprobe's are processed correctly.

>> +       } else  {
>> +               BUG();
>> +       }
>> +}
>> +
>> +static int __kprobes reenter_kprobe(struct kprobe *p,
>> +                                   struct pt_regs *regs,
>> +                                   struct kprobe_ctlblk *kcb)
>> +{
>> +       switch (kcb->kprobe_status) {
>> +       case KPROBE_HIT_SSDONE:
>> +       case KPROBE_HIT_ACTIVE:
>> +               if (!p->ainsn.check_condn || p->ainsn.check_condn(p, regs)) {
>> +                       kprobes_inc_nmissed_count(p);
>> +                       setup_singlestep(p, regs, kcb, 1);
>> +               } else  {
>> +                       /* condition check failed, skip stepping */
>> +                       skip_singlestep_missed(kcb, regs);
>> +               }
>> +               break;
>> +       case KPROBE_HIT_SS:
>> +       case KPROBE_REENTER:
>> +               pr_warn("Unrecoverable kprobe detected at %p.\n", p->addr);
>> +               dump_kprobe(p);
>> +               BUG();
>> +               break;
>> +       default:
>> +               WARN_ON(1);
>> +               return 0;
>> +       }
>> +
>> +       return 1;
>> +}
>> +
>> +static void __kprobes
>> +post_kprobe_handler(struct kprobe_ctlblk *kcb, struct pt_regs *regs)
>> +{
>> +       struct kprobe *cur = kprobe_running();
>> +
>> +       if (!cur)
>> +               return;
>> +
>> +       /* return addr restore if non-branching insn */
>> +       if (cur->ainsn.restore.type == RESTORE_PC) {
>> +               instruction_pointer(regs) = cur->ainsn.restore.addr;
>> +               if (!instruction_pointer(regs))
>> +                       BUG();
>> +       }
>> +
>> +       /* restore back original saved kprobe variables and continue */
>> +       if (kcb->kprobe_status == KPROBE_REENTER) {
>> +               restore_previous_kprobe(kcb);
>> +               return;
>> +       }
>> +       /* call post handler */
>> +       kcb->kprobe_status = KPROBE_HIT_SSDONE;
>> +       if (cur->post_handler)  {
>> +               /* post_handler can hit breakpoint and single step
>> +                * again, so we enable D-flag for recursive exception.
>> +                */
>> +               cur->post_handler(cur, regs, 0);
>> +       }
>> +
>> +       reset_current_kprobe();
>> +}
>> +
>> +int __kprobes kprobe_fault_handler(struct pt_regs *regs, unsigned int fsr)
>> +{
>> +       struct kprobe *cur = kprobe_running();
>> +       struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
>> +
>> +       switch (kcb->kprobe_status) {
>> +       case KPROBE_HIT_SS:
>> +       case KPROBE_REENTER:
>> +               /*
>> +                * We are here because the instruction being single
>> +                * stepped caused a page fault. We reset the current
>> +                * kprobe and the ip points back to the probe address
>> +                * and allow the page fault handler to continue as a
>> +                * normal page fault.
>> +                */
>> +               instruction_pointer(regs) = (unsigned long)cur->addr;
>> +               if (!instruction_pointer(regs))
>> +                       BUG();
>> +               if (kcb->kprobe_status == KPROBE_REENTER)
>> +                       restore_previous_kprobe(kcb);
>> +               else
>> +                       reset_current_kprobe();
>> +
>> +               break;
>> +       case KPROBE_HIT_ACTIVE:
>> +       case KPROBE_HIT_SSDONE:
>> +               /*
>> +                * We increment the nmissed count for accounting,
>> +                * we can also use npre/npostfault count for accounting
>> +                * these specific fault cases.
>> +                */
>> +               kprobes_inc_nmissed_count(cur);
>> +
>> +               /*
>> +                * We come here because instructions in the pre/post
>> +                * handler caused the page_fault, this could happen
>> +                * if handler tries to access user space by
>> +                * copy_from_user(), get_user() etc. Let the
>> +                * user-specified handler try to fix it first.
>> +                */
>> +               if (cur->fault_handler && cur->fault_handler(cur, regs, fsr))
>> +                       return 1;
>> +
>> +               /*
>> +                * In case the user-specified fault handler returned
>> +                * zero, try to fix up.
>> +                */
>> +               if (fixup_exception(regs))
>> +                       return 1;
>
> Won't this get dealt with in do_page_fault if we just return 1? (i.e.
> __do_kernel_fault would get called, which would then call fixup_exception).
>

I will experiment with this.

>> +
>> +               break;
>> +       }
>> +       return 0;
>> +}
>> +
>> +int __kprobes kprobe_exceptions_notify(struct notifier_block *self,
>> +                                      unsigned long val, void *data)
>> +{
>> +       return NOTIFY_DONE;
>> +}
>> +
>> +void __kprobes kprobe_handler(struct pt_regs *regs)
>
> static? (or inline into kprobe_breakpoint_handler)
>

I made it static.

>> +{
>> +       struct kprobe *p, *cur;
>> +       struct kprobe_ctlblk *kcb;
>> +       unsigned long addr = instruction_pointer(regs);
>> +
>> +       kcb = get_kprobe_ctlblk();
>> +       cur = kprobe_running();
>
> I keep getting this confused with current. Can you give it a better name
> please?
>

I changed it to cur_kprobe.  Hopefully that's less confusing.

>> +
>> +       p = get_kprobe((kprobe_opcode_t *) addr);
>> +
>> +       if (p) {
>> +               if (cur) {
>> +                       if (reenter_kprobe(p, regs, kcb))
>> +                               return;
>> +               } else if (!p->ainsn.check_condn ||
>> +                          p->ainsn.check_condn(p, regs)) {
>> +                       /* Probe hit and conditional execution check ok. */
>> +                       set_current_kprobe(p);
>> +                       kcb->kprobe_status = KPROBE_HIT_ACTIVE;
>> +
>> +                       /*
>> +                        * If we have no pre-handler or it returned 0, we
>> +                        * continue with normal processing.  If we have a
>> +                        * pre-handler and it returned non-zero, it prepped
>> +                        * for calling the break_handler below on re-entry,
>> +                        * so get out doing nothing more here.
>> +                        *
>> +                        * pre_handler can hit a breakpoint and can step thru
>> +                        * before return, keep PSTATE D-flag enabled until
>> +                        * pre_handler return back.
>> +                        */
>> +                       if (!p->pre_handler || !p->pre_handler(p, regs)) {
>> +                               kcb->kprobe_status = KPROBE_HIT_SS;
>> +                               setup_singlestep(p, regs, kcb, 0);
>> +                               return;
>> +                       }
>> +               } else {
>> +                       /*
>> +                        * Breakpoint hit but conditional check failed,
>> +                        * so just skip the instruction (NOP behaviour)
>> +                        */
>> +                       skip_singlestep_missed(kcb, regs);
>
> Why is this necessary? (i.e. why doesn't the condition get honoured
> during the single-step?).
>

I believe this was primarily to prevent recording of an event when the 
instruction is not executed due to the CC.  There is some recent debate, 
though, as to whether that is the desired behavior.  It matches the 
32-bit ARM behavior, so the issue ultimately could involve changing the 
behavior of existing 32-bit ARM code.

>> +                       return;
>> +               }
>> +       } else if (*(kprobe_opcode_t *) addr != BRK64_OPCODE_KPROBES) {
>> +               /*
>> +                * The breakpoint instruction was removed right
>> +                * after we hit it.  Another cpu has removed
>> +                * either a probepoint or a debugger breakpoint
>> +                * at this address.  In either case, no further
>> +                * handling of this interrupt is appropriate.
>> +                * Return back to original instruction, and continue.
>> +                */
>> +               return;
>> +       } else if (cur) {
>> +               /* We probably hit a jprobe.  Call its break handler. */
>> +               if (cur->break_handler && cur->break_handler(cur, regs)) {
>> +                       kcb->kprobe_status = KPROBE_HIT_SS;
>> +                       setup_singlestep(cur, regs, kcb, 0);
>> +                       return;
>> +               }
>> +       } else {
>> +               /* breakpoint is removed, now in a race
>> +                * Return back to original instruction & continue.
>> +                */
>
> Can you tidy this up by combining the "do nothing" case with the
> "*(kprobe_opcode_t *) addr != BRK64_OPCODE_KPROBES" case?
>

Done.

>> +       }
>> +}
>> +
>> +static int __kprobes
>> +kprobe_ss_hit(struct kprobe_ctlblk *kcb, unsigned long addr)
>> +{
>> +       if ((kcb->ss_ctx.ss_status == KPROBES_STEP_PENDING)
>> +           && (kcb->ss_ctx.match_addr == addr)) {
>> +               clear_ss_context(kcb);  /* clear pending ss */
>> +               return DBG_HOOK_HANDLED;
>> +       }
>> +       /* not ours, kprobes should ignore it */
>> +       return DBG_HOOK_ERROR;
>> +}
>> +
>> +int __kprobes
>> +kprobe_single_step_handler(struct pt_regs *regs, unsigned int esr)
>> +{
>> +       struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
>> +       int retval;
>> +
>> +       /* return error if this is not our step */
>> +       retval = kprobe_ss_hit(kcb, instruction_pointer(regs));
>> +
>> +       if (retval == DBG_HOOK_HANDLED) {
>> +               kprobes_restore_local_irqflag(regs);
>> +               kernel_disable_single_step();
>> +
>> +               if (kcb->kprobe_status == KPROBE_REENTER)
>> +                       spsr_set_debug_flag(regs, 1);
>> +
>> +               post_kprobe_handler(kcb, regs);
>> +       }
>> +
>> +       return retval;
>> +}
>> +
>> +int __kprobes
>> +kprobe_breakpoint_handler(struct pt_regs *regs, unsigned int esr)
>> +{
>> +       kprobe_handler(regs);
>> +       return DBG_HOOK_HANDLED;
>> +}
>> +
>> +int __kprobes setjmp_pre_handler(struct kprobe *p, struct pt_regs *regs)
>> +{
>> +       struct jprobe *jp = container_of(p, struct jprobe, kp);
>> +       struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
>> +       long stack_ptr = stack_pointer(regs);
>> +
>> +       kcb->jprobe_saved_regs = *regs;
>> +       memcpy(kcb->jprobes_stack, (void *)stack_ptr,
>> +              MIN_STACK_SIZE(stack_ptr));
>> +
>> +       instruction_pointer(regs) = (long)jp->entry;
>> +       preempt_disable();
>> +       return 1;
>> +}
>> +
>> +void __kprobes jprobe_return(void)
>> +{
>> +       struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
>> +
>> +       /*
>> +        * Jprobe handler return by entering break exception,
>> +        * encoded same as kprobe, but with following conditions
>> +        * -a magic number in x0 to identify from rest of other kprobes.
>> +        * -restore stack addr to original saved pt_regs
>> +        */
>> +       asm volatile ("ldr x0, [%0]\n\t"
>> +                     "mov sp, x0\n\t"
>> +                     "ldr x0, =" __stringify(JPROBES_MAGIC_NUM) "\n\t"
>
> This feels flakey to me and I worry that we could end up invoking the
> jprobe_return handler thanks to a kprobe with the right "magic" value in
> x0 and a race with the kprobe getting removed.
>
> Why can't we do what x86 does and check the originating PC falls inside
> the return code?

I've changed the code to test for the saved pc being equal to the 
location of the "brk" instruction in jprobe_return(), and ripped out 
JPROBES_MAGIC_NUM.

>
>> +                     "BRK %1\n\t"
>> +                     "NOP\n\t"
>
> No need to capitalise these two instructions. Also, what's the nop for?
>

OK.  The nop is probably leftover from concerns about prefetching 
causing issues.  I removed nop's from the original kprobes xol code 
after feedback (from you I think). Not sure now if that was for arm or 
arm64.  At any rate, I've removed this nop.

>> +                     :
>> +                     : "r"(&kcb->jprobe_saved_regs.sp),
>
> Why do you need to do this indirectly? (as opposed to just moving straight
> to sp).

I don't see how you can load the sp directly, it's not a valid target of 
a ldr instruction.

>
>> +                     "I"(BRK64_ESR_KPROBES)
>> +                     : "memory");
>
> unreachable()?
>

Not sure what the complaint is here.  I don't think there's any code 
after the break, except probably an unreachable return the compiler 
adds.  Am I missing something?

>> +}
>> +
>> +int __kprobes longjmp_break_handler(struct kprobe *p, struct pt_regs *regs)
>> +{
>> +       struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
>> +       long stack_addr = kcb->jprobe_saved_regs.sp;
>> +       long orig_sp = stack_pointer(regs);
>> +       struct jprobe *jp = container_of(p, struct jprobe, kp);
>> +
>> +       if (regs->regs[0] == JPROBES_MAGIC_NUM) {
>
> Change the polarity with early return and lose a level of indentation below.
>

Done.

>> +               if (orig_sp != stack_addr) {
>> +                       struct pt_regs *saved_regs =
>> +                           (struct pt_regs *)kcb->jprobe_saved_regs.sp;
>> +                       pr_err("current sp %lx does not match saved sp %lx\n",
>> +                              orig_sp, stack_addr);
>> +                       pr_err("Saved registers for jprobe %p\n", jp);
>> +                       show_regs(saved_regs);
>> +                       pr_err("Current registers\n");
>> +                       show_regs(regs);
>> +                       BUG();
>> +               }
>> +               *regs = kcb->jprobe_saved_regs;
>> +               memcpy((void *)stack_addr, kcb->jprobes_stack,
>> +                      MIN_STACK_SIZE(stack_addr));
>> +               preempt_enable_no_resched();
>> +               return 1;
>> +       }
>> +       return 0;
>> +}
>> +
>> +int __init arch_init_kprobes(void)
>> +{
>> +       return 0;
>> +}
>> diff --git a/arch/arm64/kernel/kprobes.h b/arch/arm64/kernel/kprobes.h
>> new file mode 100644
>> index 0000000..e98ad60
>> --- /dev/null
>> +++ b/arch/arm64/kernel/kprobes.h
>> @@ -0,0 +1,24 @@
>> +/*
>> + * arch/arm64/kernel/kprobes.h
>> + *
>> + * Copyright (C) 2013 Linaro Limited.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>> + * General Public License for more details.
>> + */
>> +
>> +#ifndef _ARM_KERNEL_KPROBES_H
>> +#define _ARM_KERNEL_KPROBES_H
>> +
>> +#define JPROBES_MAGIC_NUM      0xa5a5a5a5a5a5a5a5
>> +
>> +/* Move this out to appropriate header file */
>> +int fixup_exception(struct pt_regs *regs);
>> +
>> +#endif /* _ARM_KERNEL_KPROBES_H */
>
> I don't think this warrants an extra header. Use uaccess.h and stick
> the magic number somewhere else if you still need it.

I've moved the define to kprobes-arm64.h and removed the new include 
file. I added an explicit #include of asm/uaccess.h to get it to 
successfully compile again.

>
>> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
>> index 9807333..1fa6adc 100644
>> --- a/arch/arm64/kernel/vmlinux.lds.S
>> +++ b/arch/arm64/kernel/vmlinux.lds.S
>> @@ -100,6 +100,7 @@ SECTIONS
>>                          TEXT_TEXT
>>                          SCHED_TEXT
>>                          LOCK_TEXT
>> +                       KPROBES_TEXT
>>                          HYPERVISOR_TEXT
>>                          IDMAP_TEXT
>>                          *(.fixup)
>> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
>> index 94d98cd..01bf525 100644
>> --- a/arch/arm64/mm/fault.c
>> +++ b/arch/arm64/mm/fault.c
>> @@ -39,6 +39,28 @@
>>
>>   static const char *fault_name(unsigned int esr);
>>
>> +#ifdef CONFIG_KPROBES
>> +static inline int notify_page_fault(struct pt_regs *regs, unsigned int esr)
>> +{
>
> The function name isn't very descriptive. Why not follow x86 with
> "kprobes_fault"?

I'm guessing the original author followed other exmaples.  7 of 8 
architectures name it notify_page_fault, x86 is the only one that uses 
kprobes_fault.  Do we still feel it's better to follow the x86 example, 
or is it better to stick with the majority example?

>
>> +       int ret = 0;
>> +
>> +       /* kprobe_running() needs smp_processor_id() */
>
> But we could already be running on a different core from the one that
> triggered the fault, so isn't this racy?
>

This code looks the same on x86, arm, and probably other platforms. 
Wouldn't one of those have shown a problem if this was an issue?

>> +       if (!user_mode(regs)) {
>> +               preempt_disable();
>> +               if (kprobe_running() && kprobe_fault_handler(regs, esr))
>> +                       ret = 1;
>> +               preempt_enable();
>> +       }
>> +
>> +       return ret;
>> +}
>
> Will
>

-dl
