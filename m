From: gdavis@mvista.com (George G. Davis)
Date: Thu, 13 Oct 2011 21:46:26 -0400
Subject: [RFC/PATCH 5/7] ARM: Move get_thread_info macro definition to
	<asm/assembler.h>
In-Reply-To: <20111013145344.GE21648@n2100.arm.linux.org.uk>
References: <1317877714-11355-1-git-send-email-gdavis@mvista.com>
	<1317955121-28047-1-git-send-email-gdavis@mvista.com>
	<1317955121-28047-6-git-send-email-gdavis@mvista.com>
	<20111011095639.GB23848@arm.com> <20111012060433.GE188@mvista.com>
	<20111013143420.GB21648@n2100.arm.linux.org.uk>
	<20111013144923.GE6300@arm.com>
	<20111013145344.GE21648@n2100.arm.linux.org.uk>
Message-ID: <D592A2E5-6FDA-4F0F-832C-B6D5050B75D9@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Oct 13, 2011, at 10:53 AM, Russell King - ARM Linux wrote:

> On Thu, Oct 13, 2011 at 03:49:23PM +0100, Catalin Marinas wrote:
>> On Thu, Oct 13, 2011 at 03:34:20PM +0100, Russell King - ARM Linux wrote:
>>> On Wed, Oct 12, 2011 at 02:04:33AM -0400, gdavis at mvista.com wrote:
>>>> diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
>>>> index 78397d0..eaf4939 100644
>>>> --- a/arch/arm/include/asm/assembler.h
>>>> +++ b/arch/arm/include/asm/assembler.h
>>>> @@ -36,6 +36,20 @@
>>>> 	.endm
>>>> #endif  /* !CONFIG_THUMB2_KERNEL */
>>>> 
>>>> +	.macro	preempt_disable, tsk, cnt
>>>> +	get_thread_info \tsk
>>>> +	ldr	\cnt, [\tsk, #TI_PREEMPT]
>>>> +	add	\cnt, \cnt, #1
>>>> +	str	\cnt, [\tsk, #TI_PREEMPT]
>>>> +	.endm
>>>> +
>>>> +	.macro	preempt_enable, tsk, cnt
>>>> +	get_thread_info \tsk
>>>> +	ldr	\cnt, [\tsk, #TI_PREEMPT]
>>>> +	sub	\cnt, \cnt, #1
>>>> +	str	\cnt, [\tsk, #TI_PREEMPT]
>>>> +	.endm
>>>> +
>>>> /*
>>>>  * Endian independent macros for shifting bytes within registers.
>>>>  */
>>>> 
>>>> 
>>>> Not as efficient as it could be but I imagine the macros could
>>>> be written to support optional load of \tsk and/or optional \tmp
>>>> parameters to cover other common cases.
>>> 
>>> It's actually not that simple either: if you disable preemption, then you
>>> need to check for a preempt event after re-enabling preemption.
>> 
>> That's not easily possible in assembly as calling a function would
>> corrupt some registers. Is there any disadvantage with just doing the
>> equivalent of preempt_enable_no_resched() for a few asm cases where this
>> is needed?
> 
> It means you drop preemption reschedule events, which means that you can
> no longer do hard-RT in any shape or form (because you're dropping the
> reschedule for an indefinite amount of time.)

I ignored that due to laziness in this series.  I figured it was a small window
and another interrupt will come along soon enough but yes, it does impact
preempt latency.

> preempt_enable_no_resched() is fine if you're going to also put an
> explicit check a bit later in the code path when it is convenient to
> do so.

I implemented it for all cases here and will submit an update.

Thanks!

--
Regards,
George
