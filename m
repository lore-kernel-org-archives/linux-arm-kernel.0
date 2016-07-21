From: dave.long@linaro.org (David Long)
Date: Thu, 21 Jul 2016 12:33:36 -0400
Subject: [PATCH v15 04/10] arm64: Kprobes with single stepping support
In-Reply-To: <578FA238.3050206@arm.com>
References: <1467995754-32508-1-git-send-email-dave.long@linaro.org>
 <1467995754-32508-5-git-send-email-dave.long@linaro.org>
 <578FA238.3050206@arm.com>
Message-ID: <5790F960.5050007@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/20/2016 12:09 PM, Marc Zyngier wrote:
> On 08/07/16 17:35, David Long wrote:
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
>> Exclusive load/store instructions are rejected too.  Additionally, the
>> code is checked to see if it is inside an exclusive load/store sequence
>> (code from Pratyush).
>>
>> System instructions are mostly enabled for stepping, except MSR/MRS
>> accesses to "DAIF" flags in PSTATE, which are not safe for
>> probing.
>>
>> This also changes arch/arm64/include/asm/ptrace.h to use
>> include/asm-generic/ptrace.h.
>>
>> Thanks to Steve Capper and Pratyush Anand for several suggested
>> Changes.
>>
>> Signed-off-by: Sandeepa Prabhu <sandeepa.s.prabhu@gmail.com>
>> Signed-off-by: David A. Long <dave.long@linaro.org>
>> Signed-off-by: Pratyush Anand <panand@redhat.com>
>> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
>> ---
>>   arch/arm64/Kconfig                      |   1 +
>>   arch/arm64/include/asm/debug-monitors.h |   5 +
>>   arch/arm64/include/asm/insn.h           |   2 +
>>   arch/arm64/include/asm/kprobes.h        |  60 ++++
>>   arch/arm64/include/asm/probes.h         |  34 +++
>>   arch/arm64/include/asm/ptrace.h         |  14 +-
>>   arch/arm64/kernel/Makefile              |   2 +-
>>   arch/arm64/kernel/debug-monitors.c      |  16 +-
>>   arch/arm64/kernel/probes/Makefile       |   1 +
>>   arch/arm64/kernel/probes/decode-insn.c  | 143 +++++++++
>>   arch/arm64/kernel/probes/decode-insn.h  |  34 +++
>>   arch/arm64/kernel/probes/kprobes.c      | 525 ++++++++++++++++++++++++++++++++
>>   arch/arm64/kernel/vmlinux.lds.S         |   1 +
>>   arch/arm64/mm/fault.c                   |  26 ++
>>   14 files changed, 859 insertions(+), 5 deletions(-)
>>   create mode 100644 arch/arm64/include/asm/kprobes.h
>>   create mode 100644 arch/arm64/include/asm/probes.h
>>   create mode 100644 arch/arm64/kernel/probes/Makefile
>>   create mode 100644 arch/arm64/kernel/probes/decode-insn.c
>>   create mode 100644 arch/arm64/kernel/probes/decode-insn.h
>>   create mode 100644 arch/arm64/kernel/probes/kprobes.c
>>
>
> [...]
>
>> diff --git a/arch/arm64/include/asm/kprobes.h b/arch/arm64/include/asm/kprobes.h
>> new file mode 100644
>> index 0000000..79c9511
>> --- /dev/null
>> +++ b/arch/arm64/include/asm/kprobes.h
>> @@ -0,0 +1,60 @@
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
>> +#define MAX_INSN_SIZE			1
>> +#define MAX_STACK_SIZE			128
>
> Where is that value coming from? Because even on my 6502, I have a 256
> byte stack.
>

Although I don't claim to know the original author's thoughts I would 
guess it is based on the seven other existing implementations for 
kprobes on various architectures, all of which appear to use either 64 
or 128 for MAX_STACK_SIZE.  The code is not trying to duplicate the 
whole stack.

>> +
>> +#define flush_insn_slot(p)		do { } while (0)
>> +#define kretprobe_blacklist_size	0
>> +
>> +#include <asm/probes.h>
>> +
>> +struct prev_kprobe {
>> +	struct kprobe *kp;
>> +	unsigned int status;
>> +};
>> +
>> +/* Single step context for kprobe */
>> +struct kprobe_step_ctx {
>> +	unsigned long ss_pending;
>> +	unsigned long match_addr;
>> +};
>> +
>> +/* per-cpu kprobe control block */
>> +struct kprobe_ctlblk {
>> +	unsigned int kprobe_status;
>> +	unsigned long saved_irqflag;
>> +	struct prev_kprobe prev_kprobe;
>> +	struct kprobe_step_ctx ss_ctx;
>> +	struct pt_regs jprobe_saved_regs;
>> +	char jprobes_stack[MAX_STACK_SIZE];
>
> Yeah, right. Let's keep this array in mind for a second.
>
>> +};
>> +
>> +void arch_remove_kprobe(struct kprobe *);
>> +int kprobe_fault_handler(struct pt_regs *regs, unsigned int fsr);
>> +int kprobe_exceptions_notify(struct notifier_block *self,
>> +			     unsigned long val, void *data);
>> +int kprobe_breakpoint_handler(struct pt_regs *regs, unsigned int esr);
>> +int kprobe_single_step_handler(struct pt_regs *regs, unsigned int esr);
>> +
>> +#endif /* _ARM_KPROBES_H */
>> diff --git a/arch/arm64/include/asm/probes.h b/arch/arm64/include/asm/probes.h
>> new file mode 100644
>> index 0000000..1e8a21a
>
> [...]
>
>> diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
>> new file mode 100644
>> index 0000000..4496801
>> --- /dev/null
>> +++ b/arch/arm64/kernel/probes/kprobes.c
>> @@ -0,0 +1,525 @@
>> +/*
>> + * arch/arm64/kernel/probes/kprobes.c
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
>> +#include <asm/uaccess.h>
>> +#include <asm/irq.h>
>> +
>> +#include "decode-insn.h"
>> +
>> +#define MIN_STACK_SIZE(addr)	(on_irq_stack(addr, raw_smp_processor_id()) ? \
>> +	min((unsigned long)IRQ_STACK_SIZE,	\
>> +	IRQ_STACK_PTR(raw_smp_processor_id()) - (addr)) : \
>> +	min((unsigned long)MAX_STACK_SIZE,	\
>> +	(unsigned long)current_thread_info() + THREAD_START_SP - (addr)))
>
> This macro makes me want to throw things at people, because there is no
> way it can be reasonable parsed. So I've converted it to:
>
> diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
> index 823cf92..5ee9c54 100644
> --- a/arch/arm64/kernel/probes/kprobes.c
> +++ b/arch/arm64/kernel/probes/kprobes.c
> @@ -34,11 +34,23 @@
>
>   #include "decode-insn.h"
>
> -#define MIN_STACK_SIZE(addr)	(on_irq_stack(addr, raw_smp_processor_id()) ? \
> -	min((unsigned long)IRQ_STACK_SIZE,	\
> -	IRQ_STACK_PTR(raw_smp_processor_id()) - (addr)) : \
> -	min((unsigned long)MAX_STACK_SIZE,	\
> -	(unsigned long)current_thread_info() + THREAD_START_SP - (addr)))
> +static unsigned long min_stack_size(unsigned long addr)
> +{
> +	unsigned long max_size;
> +	unsigned long size;
> +
> +	if (on_irq_stack(addr, raw_smp_processor_id())) {
> +		max_size = IRQ_STACK_SIZE;
> +		size = IRQ_STACK_PTR(raw_smp_processor_id()) - addr;
> +	} else {
> +		max_size = MAX_STACK_SIZE;
> +		size = (unsigned long)current_thread_info() + THREAD_START_SP - addr;
> +	}
> +
> +	return min(size, max_size);
> +}
> +
> +#define MIN_STACK_SIZE(addr)	min_stack_size(addr)
>
>   void jprobe_return_break(void);
>
> And then you can instrument it. If you add a simple printk to dump how
> much you're going to copy, you get:
>
> root at 10:/# nc -l -p 8080
> size = 1248
> size = 1248
> Bad mode in Synchronous Abort handler detected on CPU0, code 0x86000006 -- IABT (current EL)
> CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.7.0-rc7-next-20160719-00068-g80315b6-dirty #6265
> Hardware name: linux,dummy-virt (DT)
> task: ffff000009020280 task.stack: ffff000009010000
> PC is at 0x4000
> LR is at enqueue_task_fair+0x8d8/0x1568
> pc : [<0000000000004000>] lr : [<ffff000008101c78>] pstate: 200001c5
> sp : ffff8000fffad7d0
>
> Yes, 1248 bytes. How is that supposed to work?
>
> So I've rewritten it like this:
>
> diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
> index 823cf92..194a679 100644
> --- a/arch/arm64/kernel/probes/kprobes.c
> +++ b/arch/arm64/kernel/probes/kprobes.c
> @@ -34,11 +34,20 @@
>
>   #include "decode-insn.h"
>
> -#define MIN_STACK_SIZE(addr)	(on_irq_stack(addr, raw_smp_processor_id()) ? \
> -	min((unsigned long)IRQ_STACK_SIZE,	\
> -	IRQ_STACK_PTR(raw_smp_processor_id()) - (addr)) : \
> -	min((unsigned long)MAX_STACK_SIZE,	\
> -	(unsigned long)current_thread_info() + THREAD_START_SP - (addr)))
> +static inline unsigned long min_stack_size(unsigned long addr)
> +{
> +	unsigned long size;
> +	struct kprobe_ctlblk *ctl;
> +
> +	if (on_irq_stack(addr, raw_smp_processor_id()))
> +		size = IRQ_STACK_PTR(raw_smp_processor_id()) - addr;
> +	else
> +		size = (unsigned long)current_thread_info() + THREAD_START_SP - addr;
> +
> +	return min(size, sizeof(ctl->jprobes_stack));
> +}
> +
> +#define MIN_STACK_SIZE(addr)	min_stack_size(addr)
>
>   void jprobe_return_break(void);
>
>
> I'm not sure if these 128 bytes are the right size for this thing,
> but at least it won't blindly take the kernel down.
>
> Thanks,
>
> 	M.
>

Thanks for finding and fixing this bug.

-dl
