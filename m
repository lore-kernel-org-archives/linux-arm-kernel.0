From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 21 Jul 2016 18:23:52 +0100
Subject: [PATCH v15 04/10] arm64: Kprobes with single stepping support
In-Reply-To: <5790F960.5050007@linaro.org>
References: <1467995754-32508-1-git-send-email-dave.long@linaro.org>
 <1467995754-32508-5-git-send-email-dave.long@linaro.org>
 <578FA238.3050206@arm.com> <5790F960.5050007@linaro.org>
Message-ID: <57910528.7070902@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/07/16 17:33, David Long wrote:
> On 07/20/2016 12:09 PM, Marc Zyngier wrote:
>> On 08/07/16 17:35, David Long wrote:
>>> From: Sandeepa Prabhu <sandeepa.s.prabhu@gmail.com>
>>>
>>> Add support for basic kernel probes(kprobes) and jump probes
>>> (jprobes) for ARM64.
>>>
>>> Kprobes utilizes software breakpoint and single step debug
>>> exceptions supported on ARM v8.
>>>
>>> A software breakpoint is placed at the probe address to trap the
>>> kernel execution into the kprobe handler.
>>>
>>> ARM v8 supports enabling single stepping before the break exception
>>> return (ERET), with next PC in exception return address (ELR_EL1). The
>>> kprobe handler prepares an executable memory slot for out-of-line
>>> execution with a copy of the original instruction being probed, and
>>> enables single stepping. The PC is set to the out-of-line slot address
>>> before the ERET. With this scheme, the instruction is executed with the
>>> exact same register context except for the PC (and DAIF) registers.
>>>
>>> Debug mask (PSTATE.D) is enabled only when single stepping a recursive
>>> kprobe, e.g.: during kprobes reenter so that probed instruction can be
>>> single stepped within the kprobe handler -exception- context.
>>> The recursion depth of kprobe is always 2, i.e. upon probe re-entry,
>>> any further re-entry is prevented by not calling handlers and the case
>>> counted as a missed kprobe).
>>>
>>> Single stepping from the x-o-l slot has a drawback for PC-relative accesses
>>> like branching and symbolic literals access as the offset from the new PC
>>> (slot address) may not be ensured to fit in the immediate value of
>>> the opcode. Such instructions need simulation, so reject
>>> probing them.
>>>
>>> Instructions generating exceptions or cpu mode change are rejected
>>> for probing.
>>>
>>> Exclusive load/store instructions are rejected too.  Additionally, the
>>> code is checked to see if it is inside an exclusive load/store sequence
>>> (code from Pratyush).
>>>
>>> System instructions are mostly enabled for stepping, except MSR/MRS
>>> accesses to "DAIF" flags in PSTATE, which are not safe for
>>> probing.
>>>
>>> This also changes arch/arm64/include/asm/ptrace.h to use
>>> include/asm-generic/ptrace.h.
>>>
>>> Thanks to Steve Capper and Pratyush Anand for several suggested
>>> Changes.
>>>
>>> Signed-off-by: Sandeepa Prabhu <sandeepa.s.prabhu@gmail.com>
>>> Signed-off-by: David A. Long <dave.long@linaro.org>
>>> Signed-off-by: Pratyush Anand <panand@redhat.com>
>>> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
>>> ---
>>>   arch/arm64/Kconfig                      |   1 +
>>>   arch/arm64/include/asm/debug-monitors.h |   5 +
>>>   arch/arm64/include/asm/insn.h           |   2 +
>>>   arch/arm64/include/asm/kprobes.h        |  60 ++++
>>>   arch/arm64/include/asm/probes.h         |  34 +++
>>>   arch/arm64/include/asm/ptrace.h         |  14 +-
>>>   arch/arm64/kernel/Makefile              |   2 +-
>>>   arch/arm64/kernel/debug-monitors.c      |  16 +-
>>>   arch/arm64/kernel/probes/Makefile       |   1 +
>>>   arch/arm64/kernel/probes/decode-insn.c  | 143 +++++++++
>>>   arch/arm64/kernel/probes/decode-insn.h  |  34 +++
>>>   arch/arm64/kernel/probes/kprobes.c      | 525 ++++++++++++++++++++++++++++++++
>>>   arch/arm64/kernel/vmlinux.lds.S         |   1 +
>>>   arch/arm64/mm/fault.c                   |  26 ++
>>>   14 files changed, 859 insertions(+), 5 deletions(-)
>>>   create mode 100644 arch/arm64/include/asm/kprobes.h
>>>   create mode 100644 arch/arm64/include/asm/probes.h
>>>   create mode 100644 arch/arm64/kernel/probes/Makefile
>>>   create mode 100644 arch/arm64/kernel/probes/decode-insn.c
>>>   create mode 100644 arch/arm64/kernel/probes/decode-insn.h
>>>   create mode 100644 arch/arm64/kernel/probes/kprobes.c
>>>
>>
>> [...]
>>
>>> diff --git a/arch/arm64/include/asm/kprobes.h b/arch/arm64/include/asm/kprobes.h
>>> new file mode 100644
>>> index 0000000..79c9511
>>> --- /dev/null
>>> +++ b/arch/arm64/include/asm/kprobes.h
>>> @@ -0,0 +1,60 @@
>>> +/*
>>> + * arch/arm64/include/asm/kprobes.h
>>> + *
>>> + * Copyright (C) 2013 Linaro Limited
>>> + *
>>> + * This program is free software; you can redistribute it and/or modify
>>> + * it under the terms of the GNU General Public License version 2 as
>>> + * published by the Free Software Foundation.
>>> + *
>>> + * This program is distributed in the hope that it will be useful,
>>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>>> + * General Public License for more details.
>>> + */
>>> +
>>> +#ifndef _ARM_KPROBES_H
>>> +#define _ARM_KPROBES_H
>>> +
>>> +#include <linux/types.h>
>>> +#include <linux/ptrace.h>
>>> +#include <linux/percpu.h>
>>> +
>>> +#define __ARCH_WANT_KPROBES_INSN_SLOT
>>> +#define MAX_INSN_SIZE			1
>>> +#define MAX_STACK_SIZE			128
>>
>> Where is that value coming from? Because even on my 6502, I have a 256
>> byte stack.
>>
> 
> Although I don't claim to know the original author's thoughts I would 
> guess it is based on the seven other existing implementations for 
> kprobes on various architectures, all of which appear to use either 64 
> or 128 for MAX_STACK_SIZE.  The code is not trying to duplicate the 
> whole stack.

I get that (this was supposed to be a humorous comment, but I guess
after spending too much time tracking this thing, my own sense of humour
was becoming limited).

My main worry is that whatever value you pick, it is always going to be
wrong. This is used to preserve arguments that are passed on the stack,
as opposed to passed by registers). We have no idea of what is getting
passed there so saving nothing, 128 bytes or 2kB is about the same. It
is always wrong.

A much better solution would be to check the frame pointer, and copy the
delta between FP and SP, assuming it fits inside the allocated buffer.
If it doesn't, or if FP is invalid, we just skip the hook, because we
can't reliably execute it.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
