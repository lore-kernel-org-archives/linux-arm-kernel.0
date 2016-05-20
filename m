From: dave.long@linaro.org (David Long)
Date: Fri, 20 May 2016 01:28:19 -0400
Subject: [PATCH v12 06/10] arm64: Treat all entry code as non-kprobe-able
In-Reply-To: <573497FA.5030309@arm.com>
References: <1461783185-9056-1-git-send-email-dave.long@linaro.org>
 <1461783185-9056-7-git-send-email-dave.long@linaro.org>
 <573497FA.5030309@arm.com>
Message-ID: <573EA073.5090409@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/12/2016 10:49 AM, James Morse wrote:
> Hi David, Pratyush
>
> On 27/04/16 19:53, David Long wrote:
>> From: Pratyush Anand <panand@redhat.com>
>>
>> Entry symbols are not kprobe safe. So blacklist them for kprobing.
>>
>> Signed-off-by: Pratyush Anand <panand@redhat.com>
>
>> diff --git a/arch/arm64/kernel/kprobes.c b/arch/arm64/kernel/kprobes.c
>> index dfa1b1f..6a1292b 100644
>> --- a/arch/arm64/kernel/kprobes.c
>> +++ b/arch/arm64/kernel/kprobes.c
>> @@ -29,6 +29,7 @@
>>   #include <asm/system_misc.h>
>>   #include <asm/insn.h>
>>   #include <asm/uaccess.h>
>> +#include <asm-generic/sections.h>
>>
>>   #include "kprobes-arm64.h"
>>
>> @@ -514,6 +515,15 @@ int __kprobes longjmp_break_handler(struct kprobe *p, struct pt_regs *regs)
>>   	return 1;
>>   }
>>
>> +bool arch_within_kprobe_blacklist(unsigned long addr)
>> +{
>> +	return  (addr >= (unsigned long)__kprobes_text_start &&
>> +		 addr < (unsigned long)__kprobes_text_end) ||
>> +		(addr >= (unsigned long)__entry_text_start &&
>> +		 addr < (unsigned long)__entry_text_end) ||
>> +		 !!search_exception_tables(addr);
>> +}
>> +
>
> Looking at __kvm_hyp_vector, we don't have support for handling breakpoints at
> EL2, so we should forbid kprobing these address ranges too:
> __hyp_text_start -> __hyp_text_end
> __hyp_idmap_text_start -> __hyp_idmap_text_end
>
> These can probably be guarded with is_kernel_in_hyp_mode(), if this is true then
> we are running with VHE where this code runs at the same exception level as the
> rest of the kernel, so we can probe them. (In this case you may want to add
> 'eret' to aarch64_insn_is_branch() in patch 2)
>

OK.

>
> Probing things in the kernel idmap sounds dangerous! Lets blacklist that too:
> __idmap_text_start -> __idmap_text_end
>

OK.

>
>
> Thanks,
>
> James
>
