From: dave.long@linaro.org (David Long)
Date: Fri, 22 May 2015 13:05:10 -0400
Subject: [PATCH v6 1/6] arm64: Add HAVE_REGS_AND_STACK_ACCESS_API feature
In-Reply-To: <20150521175546.GP29424@e104818-lin.cambridge.arm.com>
References: <1429561187-3661-1-git-send-email-dave.long@linaro.org>
 <1429561187-3661-2-git-send-email-dave.long@linaro.org>
 <20150520133944.GA29424@e104818-lin.cambridge.arm.com>
 <555D5114.9010701@linaro.org>
 <20150521175546.GP29424@e104818-lin.cambridge.arm.com>
Message-ID: <555F61C6.5020601@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/21/15 13:55, Catalin Marinas wrote:
> On Wed, May 20, 2015 at 11:29:24PM -0400, David Long wrote:
>> On 05/20/15 09:39, Catalin Marinas wrote:
>>> On Mon, Apr 20, 2015 at 04:19:42PM -0400, David Long wrote:
>>>> diff --git a/arch/arm64/include/uapi/asm/ptrace.h b/arch/arm64/include/uapi/asm/ptrace.h
>>>> index 6913643..58c0223 100644
>>>> --- a/arch/arm64/include/uapi/asm/ptrace.h
>>>> +++ b/arch/arm64/include/uapi/asm/ptrace.h
>>>> @@ -61,6 +61,42 @@
>>>>
>>>>   #ifndef __ASSEMBLY__
>>>>
>>>> +#define ARM_pstate	pstate
>>>> +#define ARM_pc		pc
>>>> +#define ARM_sp		sp
>>>> +#define ARM_lr		regs[30]
>>>> +#define ARM_fp		regs[29]
>>>> +#define ARM_x28		regs[28]
>>>> +#define ARM_x27		regs[27]
>>>> +#define ARM_x26		regs[26]
>>>> +#define ARM_x25		regs[25]
>>>> +#define ARM_x24		regs[24]
>>>> +#define ARM_x23		regs[23]
>>>> +#define ARM_x22		regs[22]
>>>> +#define ARM_x21		regs[21]
>>>> +#define ARM_x20		regs[20]
>>>> +#define ARM_x19		regs[19]
>>>> +#define ARM_x18		regs[18]
>>>> +#define ARM_ip1		regs[17]
>>>> +#define ARM_ip0		regs[16]
>>>> +#define ARM_x15		regs[15]
>>>> +#define ARM_x14		regs[14]
>>>> +#define ARM_x13		regs[13]
>>>> +#define ARM_x12		regs[12]
>>>> +#define ARM_x11		regs[11]
>>>> +#define ARM_x10		regs[10]
>>>> +#define ARM_x9		regs[9]
>>>> +#define ARM_x8		regs[8]
>>>> +#define ARM_x7		regs[7]
>>>> +#define ARM_x6		regs[6]
>>>> +#define ARM_x5		regs[5]
>>>> +#define ARM_x4		regs[4]
>>>> +#define ARM_x3		regs[3]
>>>> +#define ARM_x2		regs[2]
>>>> +#define ARM_x1		regs[1]
>>>> +#define ARM_x0		regs[0]
>>>> +#define ARM_ORIG_x0	orig_x0
>>>
>>> I replied some time ago on this part. I don't see the point these
>>> macros.
>>
>> I replied belatedly on April 20 saying what I did matches (more or less) how
>> it's done on various other platforms, including arm and powerpc.
>> It looks like this comes from the pt_regs structure defining the
>> registers as an array instead of a list of structure fields. It looks
>> to me like that design choice is pretty widely depended upon now and
>> would be quite disruptive to change.  It also seems to me a relatively
>> clean way to do it on systems with a uniform register set.
>
> I see why we need to cope with the regs[] array but why do we need these
> definitions in a uapi file?
>

I expect Sandeepa did it that way because it's the way it's done in 
other architectures.  I see your point though, these definitions are 
only referenced in a macro that's defined and used only in ptrace.c.  I 
can easily move them there.

>>>> +
>>>>   /*
>>>>    * User structures for general purpose, floating point and debug registers.
>>>>    */
>>>> diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
>>>> index d882b83..a889f79 100644
>>>> --- a/arch/arm64/kernel/ptrace.c
>>>> +++ b/arch/arm64/kernel/ptrace.c
>>>> @@ -48,6 +48,122 @@
>>>>   #define CREATE_TRACE_POINTS
>>>>   #include <trace/events/syscalls.h>
>>>>
>>>> +struct pt_regs_offset {
>>>> +	const char *name;
>>>> +	int offset;
>>>> +};
>>>> +
>>>> +#define REG_OFFSET_NAME(r) \
>>>> +	{.name = #r, .offset = offsetof(struct pt_regs, ARM_##r)}
>>
>>> Can you not just use "offsetof(struct pt_regs, r)" here? That would be
>>> the same as x86, powerpc.
>>
>> The registers (except for pc, pstate, and sp) are not separate structure
>> fields, they are slots in a single array. To reference them the symbolic
>> name has to be converted to an index (integer register number) somehow.
>
> Can we not keep them local to this file, say __reg_x0 etc. (something to
> make it clear they are for internal use)?
>

As above we can make it local to the file.  Given that I don't think 
there's a need to chance ARM_x* to __reg_x* though, is there?  Either 
way, no problem.

-dl
