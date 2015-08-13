From: dave.long@linaro.org (David Long)
Date: Wed, 12 Aug 2015 23:50:40 -0400
Subject: [PATCH v8 1/7] arm64: Add HAVE_REGS_AND_STACK_ACCESS_API feature
In-Reply-To: <20150811173121.GC29880@arm.com>
References: <1439254364-15362-1-git-send-email-dave.long@linaro.org>
 <1439254364-15362-2-git-send-email-dave.long@linaro.org>
 <20150811173121.GC29880@arm.com>
Message-ID: <55CC1410.1090900@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/11/15 13:31, Will Deacon wrote:
> Hi David,
>
> On Tue, Aug 11, 2015 at 01:52:38AM +0100, David Long wrote:
>> From: "David A. Long" <dave.long@linaro.org>
>>
>> Add HAVE_REGS_AND_STACK_ACCESS_API feature for arm64.
>>
>> Signed-off-by: David A. Long <dave.long@linaro.org>
>> ---
>>   arch/arm64/Kconfig              |  1 +
>>   arch/arm64/include/asm/ptrace.h | 25 +++++++++++++
>>   arch/arm64/kernel/ptrace.c      | 77 +++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 103 insertions(+)
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 318175f..ef5d726 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -70,6 +70,7 @@ config ARM64
>>   	select HAVE_PERF_EVENTS
>>   	select HAVE_PERF_REGS
>>   	select HAVE_PERF_USER_STACK_DUMP
>> +	select HAVE_REGS_AND_STACK_ACCESS_API
>>   	select HAVE_RCU_TABLE_FREE
>>   	select HAVE_SYSCALL_TRACEPOINTS
>>   	select IRQ_DOMAIN
>> diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
>> index d6dd9fd..8f440e9 100644
>> --- a/arch/arm64/include/asm/ptrace.h
>> +++ b/arch/arm64/include/asm/ptrace.h
>> @@ -118,6 +118,8 @@ struct pt_regs {
>>   	u64 syscallno;
>>   };
>>
>> +#define MAX_REG_OFFSET (sizeof(struct user_pt_regs) - sizeof(u64))
>
> Can you not use offset_of(struct user_pt_regs, pstate) here?

Yes, "offsetof" actually though.  I've just made that change.

>> +
>>   #define arch_has_single_step()	(1)
>>
>>   #ifdef CONFIG_COMPAT
>> @@ -146,6 +148,29 @@ struct pt_regs {
>>   #define user_stack_pointer(regs) \
>>   	(!compat_user_mode(regs) ? (regs)->sp : (regs)->compat_sp)
>>
>> +/**
>> + * regs_get_register() - get register value from its offset
>> + * @regs:	   pt_regs from which register value is gotten
>> + * @offset:    offset number of the register.
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
>> +}
>
> Is this guaranteed only to be called on kernel-mode regs, or do we need
> to deal with compat tasks too?

If I understand the question I think it's fine that it only deals with 
kernel-mode registers.  The implemenation is functionally similar to the 
other five architectures that implement it.

>> +
>> +/* Valid only for Kernel mode traps. */
>> +static inline unsigned long kernel_stack_pointer(struct pt_regs *regs)
>> +{
>> +	return regs->sp;
>> +}
>> +
>>   static inline unsigned long regs_return_value(struct pt_regs *regs)
>>   {
>>   	return regs->regs[0];
>> diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
>> index d882b83..f6199a5 100644
>> --- a/arch/arm64/kernel/ptrace.c
>> +++ b/arch/arm64/kernel/ptrace.c
>> @@ -48,6 +48,83 @@
>>   #define CREATE_TRACE_POINTS
>>   #include <trace/events/syscalls.h>
>>
>> +#define ARM_pstate	pstate
>> +#define ARM_pc		pc
>> +#define ARM_sp		sp
>> +#define ARM_x30		regs[30]
>> +#define ARM_x29		regs[29]
>> +#define ARM_x28		regs[28]
>> +#define ARM_x27		regs[27]
>> +#define ARM_x26		regs[26]
>> +#define ARM_x25		regs[25]
>> +#define ARM_x24		regs[24]
>> +#define ARM_x23		regs[23]
>> +#define ARM_x22		regs[22]
>> +#define ARM_x21		regs[21]
>> +#define ARM_x20		regs[20]
>> +#define ARM_x19		regs[19]
>> +#define ARM_x18		regs[18]
>> +#define ARM_x17		regs[17]
>> +#define ARM_x16		regs[16]
>> +#define ARM_x15		regs[15]
>> +#define ARM_x14		regs[14]
>> +#define ARM_x13		regs[13]
>> +#define ARM_x12		regs[12]
>> +#define ARM_x11		regs[11]
>> +#define ARM_x10		regs[10]
>> +#define ARM_x9		regs[9]
>> +#define ARM_x8		regs[8]
>> +#define ARM_x7		regs[7]
>> +#define ARM_x6		regs[6]
>> +#define ARM_x5		regs[5]
>> +#define ARM_x4		regs[4]
>> +#define ARM_x3		regs[3]
>> +#define ARM_x2		regs[2]
>> +#define ARM_x1		regs[1]
>> +#define ARM_x0		regs[0]
>
> I've said it before, but I really don't like these macros. I'd rather
> rework the following REG_OFFSET_NAME to be GPR_OFFSET_NAME which could
> prefix the "x" in the name field.

OK, I've ripped that out and replaced REG_OFFSET_NAME with 
GPR_OFFSET_NAME, for the numbered registers.  I'm using REGS_OFFSET_NAME 
(defined for all architectures in my earlier cleanup patch) for the 
non-numbered registers.

>
>> +
>> +#define REG_OFFSET_NAME(r) \
>> +	{.name = #r, .offset = offsetof(struct pt_regs, ARM_##r)}
>> +#define REG_OFFSET_END {.name = NULL, .offset = 0}
>> +
>> +const struct pt_regs_offset regs_offset_table[] = {
>> +	REG_OFFSET_NAME(x0),
>> +	REG_OFFSET_NAME(x1),
>> +	REG_OFFSET_NAME(x2),
>> +	REG_OFFSET_NAME(x3),
>> +	REG_OFFSET_NAME(x4),
>> +	REG_OFFSET_NAME(x5),
>> +	REG_OFFSET_NAME(x6),
>> +	REG_OFFSET_NAME(x7),
>> +	REG_OFFSET_NAME(x8),
>> +	REG_OFFSET_NAME(x9),
>> +	REG_OFFSET_NAME(x10),
>> +	REG_OFFSET_NAME(x11),
>> +	REG_OFFSET_NAME(x12),
>> +	REG_OFFSET_NAME(x13),
>> +	REG_OFFSET_NAME(x14),
>> +	REG_OFFSET_NAME(x15),
>> +	REG_OFFSET_NAME(x16),
>> +	REG_OFFSET_NAME(x17),
>> +	REG_OFFSET_NAME(x18),
>> +	REG_OFFSET_NAME(x19),
>> +	REG_OFFSET_NAME(x20),
>> +	REG_OFFSET_NAME(x21),
>> +	REG_OFFSET_NAME(x22),
>> +	REG_OFFSET_NAME(x23),
>> +	REG_OFFSET_NAME(x24),
>> +	REG_OFFSET_NAME(x25),
>> +	REG_OFFSET_NAME(x26),
>> +	REG_OFFSET_NAME(x27),
>> +	REG_OFFSET_NAME(x28),
>> +	REG_OFFSET_NAME(x29),
>> +	REG_OFFSET_NAME(x30),
>
> Does this interact badly with perf tools, which expect to pass "lr" for
> x30? (see tools/perf/arch/arm64/include/perf_regs.h).
>

Possibly, I can test that when I'm back from my short vacation this 
week.  The lr/x30 thing seems to be a recurring issue.  Perhaps it is 
best simply to add a reundant entry for x30 as "lr".  It's simple enough 
to do, although just slightly ugly looking as it would have to be done 
without a macro.  Would one ever use "x31" in place of "sp"?

Conversions in the other direction would have to use one or the other of 
course.

> Will
>

-dl
