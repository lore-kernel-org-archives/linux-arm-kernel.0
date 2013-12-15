From: liuj97@gmail.com (Jiang Liu)
Date: Sun, 15 Dec 2013 19:07:50 +0800
Subject: [PATCH v6 6/7] arm64,
 jump label: optimize jump label implementation
In-Reply-To: <20131213154104.GG19177@mudshark.cambridge.arm.com>
References: <1386691433-6827-1-git-send-email-liuj97@gmail.com>
 <1386691433-6827-7-git-send-email-liuj97@gmail.com>
 <20131213154104.GG19177@mudshark.cambridge.arm.com>
Message-ID: <52AD8D86.1060706@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,
	Thanks for review.
On 12/13/2013 11:41 PM, Will Deacon wrote:
> Hi Jiang Liu,
> 
> Thanks for the updated patches! I still have some small comments, but I
> don't think they will cause you much work. See inline.
> 
> On Tue, Dec 10, 2013 at 04:03:52PM +0000, Jiang Liu wrote:
>> Optimize jump label implementation for ARM64 by dynamically patching
>> kernel text.
>>
>> Signed-off-by: Jiang Liu <liuj97@gmail.com>
...
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>> + */
>> +#ifndef _ASM_ARM64_JUMP_LABEL_H
>> +#define _ASM_ARM64_JUMP_LABEL_H
> 
> Just use __ASM_JUMP_LABEL_H to keep consistent with out other headers.
Sure, will make this change.

> 
>> +#include <linux/types.h>
>> +
>> +#ifdef __KERNEL__
>> +
>> +#define JUMP_LABEL_NOP_SIZE 4
> 
> This is the same as AARCH64_INSN_SIZE; just use the latter.
Yes, it's the same as AARCH64_INSN_SIZE but JUMP_LABEL_NOP_SIZE is
needed by the jump label core. So I directly define JUMP_LABEL_NOP_SIZE
as 4 instead of AARCH64_INSN_SIZE to avoid pulling asm/insn.h into
asm/jump_label.h.

Thanks!
Gerry

> 
>> +
>> +static __always_inline bool arch_static_branch(struct static_key *key)
>> +{
>> +	asm goto("1: nop\n\t"
>> +		 ".pushsection __jump_table,  \"aw\"\n\t"
>> +		 ".align 3\n\t"
>> +		 ".quad 1b, %l[l_yes], %c0\n\t"
>> +		 ".popsection\n\t"
>> +		 :  :  "i"(key) :  : l_yes);
>> +
>> +	return false;
>> +l_yes:
>> +	return true;
>> +}
>> +
>> +#endif /* __KERNEL__ */
>> +
>> +typedef u64 jump_label_t;
>> +
>> +struct jump_entry {
>> +	jump_label_t code;
>> +	jump_label_t target;
>> +	jump_label_t key;
>> +};
>> +
>> +#endif	/* _ASM_ARM64_JUMP_LABEL_H */
>> diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
>> index cd95a25..e155d56 100644
>> --- a/arch/arm64/kernel/Makefile
>> +++ b/arch/arm64/kernel/Makefile
>> @@ -18,6 +18,7 @@ arm64-obj-$(CONFIG_SMP)			+= smp.o smp_spin_table.o
>>  arm64-obj-$(CONFIG_HW_PERF_EVENTS)	+= perf_event.o
>>  arm64-obj-$(CONFIG_HAVE_HW_BREAKPOINT)+= hw_breakpoint.o
>>  arm64-obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
>> +arm64-obj-$(CONFIG_JUMP_LABEL)		+= jump_label.o
>>  
>>  obj-y					+= $(arm64-obj-y) vdso/
>>  obj-m					+= $(arm64-obj-m)
>> diff --git a/arch/arm64/kernel/jump_label.c b/arch/arm64/kernel/jump_label.c
>> new file mode 100644
>> index 0000000..b13ef62
>> --- /dev/null
>> +++ b/arch/arm64/kernel/jump_label.c
>> @@ -0,0 +1,59 @@
>> +/*
>> + * Copyright (C) 2013 Huawei Ltd.
>> + * Author: Jiang Liu <liuj97@gmail.com>
>> + *
>> + * Based on arch/arm/kernel/jump_label.c
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>> + */
>> +#include <linux/kernel.h>
>> +#include <linux/jump_label.h>
>> +#include <asm/jump_label.h>
>> +#include <asm/insn.h>
>> +
>> +#ifdef HAVE_JUMP_LABEL
> 
> Slightly worrying... this should be CONFIG_HAVE_JUMP_LABEL, right? How did
> you manage to test this code?
> 
> Will
> 
