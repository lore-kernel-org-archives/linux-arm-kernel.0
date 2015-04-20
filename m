From: dave.long@linaro.org (David Long)
Date: Mon, 20 Apr 2015 03:15:06 -0400
Subject: [PATCH v5 1/6] arm64: Add HAVE_REGS_AND_STACK_ACCESS_API feature
In-Reply-To: <20150325134410.GA26903@localhost>
References: <1424214701-4899-1-git-send-email-dave.long@linaro.org>
 <1424214701-4899-2-git-send-email-dave.long@linaro.org>
 <20150325134410.GA26903@localhost>
Message-ID: <5534A77A.8040509@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/25/15 09:44, Catalin Marinas wrote:
> On Tue, Feb 17, 2015 at 06:11:36PM -0500, David Long wrote:
>> diff --git a/arch/arm64/include/uapi/asm/ptrace.h b/arch/arm64/include/uapi/asm/ptrace.h
>> index 6913643..700d28b 100644
>> --- a/arch/arm64/include/uapi/asm/ptrace.h
>> +++ b/arch/arm64/include/uapi/asm/ptrace.h
>> @@ -61,6 +61,42 @@
>>
>>   #ifndef __ASSEMBLY__
>>
>> +#define ARM_cpsr	pstate
>
> There is no CPSR on AArch64, it's just called PSTATE. But more
> importantly, what's the point of all these macros?
>
>> diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
>> index d882b83..adc1f39 100644
>> --- a/arch/arm64/kernel/ptrace.c
>> +++ b/arch/arm64/kernel/ptrace.c
>> @@ -48,6 +48,122 @@
>>   #define CREATE_TRACE_POINTS
>>   #include <trace/events/syscalls.h>
>>
>> +struct pt_regs_offset {
>> +	const char *name;
>> +	int offset;
>> +};
>> +
>> +#define REG_OFFSET_NAME(r) \
>> +	{.name = #r, .offset = offsetof(struct pt_regs, ARM_##r)}
>> +#define REG_OFFSET_END {.name = NULL, .offset = 0}
>> +
>> +static const struct pt_regs_offset regoffset_table[] = {
>> +	REG_OFFSET_NAME(x0),
>
> If it is just for defining a name, just change the REG_OFFSET_NAME macro
> to take a string argument and remove all the ARM_ macros.
>
> I'm also not sure why we need the ARM_ prefix. Do you see them used
> outside the arm64 context?
>

Sorry Catalin, I don't have a record of having replied to this yet so 
this is a quite late reply.

The macros were taken from the 32-bit ARM implementation, which in turn 
looks to be taken from x86/sh/powerpc for 
HAVE_REGS_AND_STACK_ACCESS_API.  I've replaced the hacky define of cpsr 
with pstate. The macros create symbolic names that can be looked up by, 
for example, event tracing strings entered through debugfs.  This is 
consistent across multiple platforms.

-dl
