From: gdavis@mvista.com (George G. Davis)
Date: Thu, 13 Oct 2011 21:44:06 -0400
Subject: [RFC/PATCH 5/7] ARM: Move get_thread_info macro definition to
	<asm/assembler.h>
In-Reply-To: <20111013144923.GE6300@arm.com>
References: <1317877714-11355-1-git-send-email-gdavis@mvista.com>
	<1317955121-28047-1-git-send-email-gdavis@mvista.com>
	<1317955121-28047-6-git-send-email-gdavis@mvista.com>
	<20111011095639.GB23848@arm.com> <20111012060433.GE188@mvista.com>
	<20111013143420.GB21648@n2100.arm.linux.org.uk>
	<20111013144923.GE6300@arm.com>
Message-ID: <1818CFB2-C965-45CD-A94E-5D33CF7BB761@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Oct 13, 2011, at 10:49 AM, Catalin Marinas wrote:

> On Thu, Oct 13, 2011 at 03:34:20PM +0100, Russell King - ARM Linux wrote:
>> On Wed, Oct 12, 2011 at 02:04:33AM -0400, gdavis at mvista.com wrote:
>>> diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
>>> index 78397d0..eaf4939 100644
>>> --- a/arch/arm/include/asm/assembler.h
>>> +++ b/arch/arm/include/asm/assembler.h
>>> @@ -36,6 +36,20 @@
>>> 	.endm
>>> #endif  /* !CONFIG_THUMB2_KERNEL */
>>> 
>>> +	.macro	preempt_disable, tsk, cnt
>>> +	get_thread_info \tsk
>>> +	ldr	\cnt, [\tsk, #TI_PREEMPT]
>>> +	add	\cnt, \cnt, #1
>>> +	str	\cnt, [\tsk, #TI_PREEMPT]
>>> +	.endm
>>> +
>>> +	.macro	preempt_enable, tsk, cnt
>>> +	get_thread_info \tsk
>>> +	ldr	\cnt, [\tsk, #TI_PREEMPT]
>>> +	sub	\cnt, \cnt, #1
>>> +	str	\cnt, [\tsk, #TI_PREEMPT]
>>> +	.endm
>>> +
>>> /*
>>>  * Endian independent macros for shifting bytes within registers.
>>>  */
>>> 
>>> 
>>> Not as efficient as it could be but I imagine the macros could
>>> be written to support optional load of \tsk and/or optional \tmp
>>> parameters to cover other common cases.
>> 
>> It's actually not that simple either: if you disable preemption, then you
>> need to check for a preempt event after re-enabling preemption.
> 
> That's not easily possible in assembly as calling a function would
> corrupt some registers.

Since the preempt_enable is done at the end of all current v6 funcs
in this series, it was easy to implement.  I'll include those changes
in an update.


Thanks!

--
Regards,
George

> Is there any disadvantage with just doing the
> equivalent of preempt_enable_no_resched() for a few asm cases where this
> is needed?
> 
> -- 
> Catalin
