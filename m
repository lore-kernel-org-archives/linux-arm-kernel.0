From: dave.long@linaro.org (David Long)
Date: Fri, 13 May 2016 15:07:41 -0400
Subject: [PATCH v12 01/10] arm64: Add HAVE_REGS_AND_STACK_ACCESS_API
 feature
In-Reply-To: <57223593.1000503@arm.com>
References: <1461783185-9056-1-git-send-email-dave.long@linaro.org>
 <1461783185-9056-2-git-send-email-dave.long@linaro.org>
 <57223593.1000503@arm.com>
Message-ID: <573625FD.4020004@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/28/2016 12:08 PM, Marc Zyngier wrote:
> On 27/04/16 19:52, David Long wrote:
>> From: "David A. Long" <dave.long@linaro.org>
>>
>> Add HAVE_REGS_AND_STACK_ACCESS_API feature for arm64.
>
> And clearly a lot more.
>
>>
>> Signed-off-by: David A. Long <dave.long@linaro.org>
>> ---
>>   arch/arm64/Kconfig              |   1 +
>>   arch/arm64/include/asm/ptrace.h |  33 ++++++++++-
>>   arch/arm64/kernel/ptrace.c      | 118 ++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 151 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 4f43622..8f662fd 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -80,6 +80,7 @@ config ARM64
>>   	select HAVE_PERF_EVENTS
>>   	select HAVE_PERF_REGS
>>   	select HAVE_PERF_USER_STACK_DUMP
>> +	select HAVE_REGS_AND_STACK_ACCESS_API
>>   	select HAVE_RCU_TABLE_FREE
>>   	select HAVE_SYSCALL_TRACEPOINTS
>>   	select IOMMU_DMA if IOMMU_SUPPORT
>> diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
>> index a307eb6..ee02637 100644
>> --- a/arch/arm64/include/asm/ptrace.h
>> +++ b/arch/arm64/include/asm/ptrace.h
>> @@ -119,6 +119,8 @@ struct pt_regs {
>>   	u64 syscallno;
>>   };
>>
>> +#define MAX_REG_OFFSET offsetof(struct pt_regs, pstate)
>> +
>>   #define arch_has_single_step()	(1)
>>
>>   #ifdef CONFIG_COMPAT
>> @@ -147,6 +149,35 @@ struct pt_regs {
>>   #define user_stack_pointer(regs) \
>>   	(!compat_user_mode(regs) ? (regs)->sp : (regs)->compat_sp)
>>
>> +extern int regs_query_register_offset(const char *name);
>> +extern const char *regs_query_register_name(unsigned int offset);
>> +extern bool regs_within_kernel_stack(struct pt_regs *regs, unsigned long addr);
>> +extern unsigned long regs_get_kernel_stack_nth(struct pt_regs *regs,
>> +					       unsigned int n);
>> +
>> +/**
>> + * regs_get_register() - get register value from its offset
>> + * @regs:	   pt_regs from which register value is gotten
>> + * @offset:    offset number of the register.
>
> Is it the offset? or the number?
>

I've removed "number" from the description.

>> + *
>> + * regs_get_register returns the value of a register whose offset from @regs.
>> + * The @offset is the offset of the register in struct pt_regs.
>> + * If @offset is bigger than MAX_REG_OFFSET, this returns 0.
>> + */
>> +static inline u64 regs_get_register(struct pt_regs *regs,
>> +					      unsigned int offset)
>> +{
>> +	if (unlikely(offset > MAX_REG_OFFSET))
>> +		return 0;
>> +	return *(u64 *)((u64)regs + offset);
>
> So clearly it is the offset. But is 3 a valid value? I don't think so.
> How about something slightly more type safe:
>
> 	u64 val = 0;
>
> 	WARN_ON(offset & 7);
>
> 	offset >>= 3;
> 	switch (offset) {
> 	case	0 ... 30:
> 		val = regs->reg[offset];
> 		break;
> 	case	31:
> 		val = regs->sp;
> 		break;
> 	case	32:
> 		val = regs->pc;
> 		break;
> 	case	33:
>   		val = regs->pstate;
> 		break;
> 	}
>
> 	return val;
>
> I'm pretty sure you could replace 31/32/33 with macros using offsetof().
> The compiler may even optimize this to something similar to what you
> already have.
>
> Thanks,
>
> 	M.
>

I'm not sure this makes sense to me since my best understanding of this 
suite of functions makes the "offset" argument effectively an opaque 
type with a value returned from looking up the register by name in a 
compiled in table that reliably determines the offset within the pt_regs 
structure (i.e.:  regs_query_register_offset() and 
regs_query_register_name()).  Now this change introduces the assumption 
that the gp registers start at the beginning of the structure, 
presumably for the future use of someone hardcoding their own number for 
"offset".

Nonetheless in the interest of moving forward I currently have this 
change sitting in my next patch set.

Thanks,
-dl
