From: dave.long@linaro.org (David Long)
Date: Wed, 15 Jan 2014 11:43:05 -0500
Subject: [PATCH v4 02/16] ARM: move shared uprobe/kprobe definitions into
 new include file
In-Reply-To: <1387543568.3404.36.camel@linaro1.home>
References: <1387166930-13182-1-git-send-email-dave.long@linaro.org>
 <1387166930-13182-3-git-send-email-dave.long@linaro.org>
 <1387543568.3404.36.camel@linaro1.home>
Message-ID: <52D6BA99.6020409@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/20/13 07:46, Jon Medhurst (Tixy) wrote:
> On Sun, 2013-12-15 at 23:08 -0500, David Long wrote:
>> From: "David A. Long" <dave.long@linaro.org>
>>
>> Separate the kprobe-only definitions from the definitions needed by
>> both kprobes and uprobes.
>>
>> Signed-off-by: David A. Long <dave.long@linaro.org>
>> ---
>>   arch/arm/include/asm/kprobes.h | 15 +--------------
>>   arch/arm/include/asm/probes.h  | 18 ++++++++++++++++++
>>   2 files changed, 19 insertions(+), 14 deletions(-)
>>   create mode 100644 arch/arm/include/asm/probes.h
>>
>> diff --git a/arch/arm/include/asm/kprobes.h b/arch/arm/include/asm/kprobes.h
>> index f82ec22..30fc11b 100644
>> --- a/arch/arm/include/asm/kprobes.h
>> +++ b/arch/arm/include/asm/kprobes.h
>> @@ -28,21 +28,8 @@
>>   #define kretprobe_blacklist_size	0
>>
>>   typedef u32 kprobe_opcode_t;
>> -
>>   struct kprobe;
>> -typedef void (kprobe_insn_handler_t)(struct kprobe *, struct pt_regs *);
>> -typedef unsigned long (kprobe_check_cc)(unsigned long);
>> -typedef void (kprobe_insn_singlestep_t)(struct kprobe *, struct pt_regs *);
>> -typedef void (kprobe_insn_fn_t)(void);
>> -
>> -/* Architecture specific copy of original instruction. */
>> -struct arch_specific_insn {
>> -	kprobe_opcode_t			*insn;
>> -	kprobe_insn_handler_t		*insn_handler;
>> -	kprobe_check_cc			*insn_check_cc;
>> -	kprobe_insn_singlestep_t	*insn_singlestep;
>> -	kprobe_insn_fn_t		*insn_fn;
>> -};
>> +#include <asm/probes.h>
>>
>>   struct prev_kprobe {
>>   	struct kprobe *kp;
>> diff --git a/arch/arm/include/asm/probes.h b/arch/arm/include/asm/probes.h
>> new file mode 100644
>> index 0000000..21da148
>> --- /dev/null
>> +++ b/arch/arm/include/asm/probes.h
>> @@ -0,0 +1,18 @@
>
> This new file doesn't have any copyright/license notice, I suggest you
> copy the one from kprobes.h and include a note to say this new files
> contents were copied, e.g. start it like...
>
> /*
>   * arch/arm/include/asm/probes.h
>   *
>   * Original contents copied from arch/arm/include/asm/kprobes.h
>   * which contains the following notice...
>   *
>   * Copyright (C) 2006, 2007 Motorola Inc.
>   *
>   * This program is free software; you can redistribute it and/or modify
> [...]
>

Fixed.

>> +#ifndef _ASM_PROBES_H
>> +#define _ASM_PROBES_H
>> +
>> +typedef void (kprobe_insn_handler_t)(struct kprobe *, struct pt_regs *);
>> +typedef unsigned long (kprobe_check_cc)(unsigned long);
>> +typedef void (kprobe_insn_singlestep_t)(struct kprobe *, struct pt_regs *);
>> +typedef void (kprobe_insn_fn_t)(void);
>> +
>> +/* Architecture specific copy of original instruction. */
>> +struct arch_specific_insn {
>> +	kprobe_opcode_t			*insn;
>> +	kprobe_insn_handler_t		*insn_handler;
>> +	kprobe_check_cc			*insn_check_cc;
>> +	kprobe_insn_singlestep_t	*insn_singlestep;
>> +	kprobe_insn_fn_t		*insn_fn;
>> +};
>> +
>> +#endif
>

-dl
