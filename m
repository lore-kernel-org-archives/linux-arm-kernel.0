From: jungseoklee85@gmail.com (Jungseok Lee)
Date: Fri, 17 Jul 2015 23:38:28 +0900
Subject: [RFC 2/3] arm64: refactor save_stack_trace()
In-Reply-To: <55A862C0.4040101@linaro.org>
References: <1436765375-7119-1-git-send-email-takahiro.akashi@linaro.org>	<1436765375-7119-3-git-send-email-takahiro.akashi@linaro.org>	<DAAB1BC4-B36E-436D-8EAD-548641E58490@gmail.com>	<20150714093154.4d73e551@gandalf.local.home>	<55A5A75A.1060401@linaro.org>	<20150714225105.6c1e4f15@gandalf.local.home>	<55A646EE.6030402@linaro.org>	<20150715105536.42949ea9@gandalf.local.home>
 <20150715121337.3b31aa84@gandalf.local.home> <55A6FA82.9000901@linaro.org>
 <55A703F3.8050203@linaro.org>
 <A601CC3C-4B09-4D8B-8564-558349D45815@gmail.com>
 <55A862C0.4040101@linaro.org>
Message-ID: <10104998-CA54-4150-9228-2ED8C327911D@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Jul 17, 2015, at 11:04 AM, AKASHI Takahiro wrote:
> Jungseok,
> 
> Thank you for your testing and reviews.

You're welcome.

> On 07/16/2015 10:29 PM, Jungseok Lee wrote:
>> On Jul 16, 2015, at 10:08 AM, AKASHI Takahiro wrote:
>> 
>> Hi, AKASHI
>> 
>>> On 07/16/2015 09:27 AM, AKASHI Takahiro wrote:
>>>> On 07/16/2015 01:13 AM, Steven Rostedt wrote:
>>>>> On Wed, 15 Jul 2015 10:55:36 -0400
>>>>> Steven Rostedt <rostedt@goodmis.org> wrote:
>>>>> 
>>>>> 
>>>>>> I'll take a look at it and try to clean up the code.
>>>>> 
>>>>> Does the  following patch make sense for you?
>>>> 
>>>> Looks nice. The patch greatly simplifies changes on arm64 side.
>>> 
>>> As follows:
>>> 
>>> - Takahiro AKASHI
>>> 
>>> diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
>>> index c5534fa..868d6f1 100644
>>> --- a/arch/arm64/include/asm/ftrace.h
>>> +++ b/arch/arm64/include/asm/ftrace.h
>>> @@ -15,6 +15,7 @@
>>> 
>>> #define MCOUNT_ADDR		((unsigned long)_mcount)
>>> #define MCOUNT_INSN_SIZE	AARCH64_INSN_SIZE
>>> +#define FTRACE_STACK_FRAME_OFFSET 4 /* sync it up with stacktrace.c */
> 
> Well,
>  #define FTRACE_STACK_FRAME_OFFSET AARCH64_INSN_SIZE
> might be better.

Agree.

> 
>> How about binding it to -4 in unwind_frame function?
> 
> Do you mean like this?
> In unwind_frame(),
>  frame->pc = *(unsigned long*)(fp + 8) - AARCH64_INSN_SIZE;

Exactly.

> 
>> IMHO, it would help other developers trying to change stack trace code
>> be aware of this stack tracer feature.
>> 
>>> #ifndef __ASSEMBLY__
>>> #include <linux/compat.h>
>>> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
>>> index 1da6029..2c1bf7d 100644
>>> --- a/include/linux/ftrace.h
>>> +++ b/include/linux/ftrace.h
>>> @@ -260,6 +260,13 @@ static inline void ftrace_kill(void) { }
>>> #endif /* CONFIG_FUNCTION_TRACER */
>>> 
>>> #ifdef CONFIG_STACK_TRACER
>>> +/*
>>> + * the offset value to add to return address from save_stack_trace()
>>> + */
>>> +#ifndef FTRACE_STACK_FRAME_OFFSET
>>> +#define FTRACE_STACK_FRAME_OFFSET 0
>>> +#endif
>>> +
>>> extern int stack_tracer_enabled;
>>> int
>>> stack_trace_sysctl(struct ctl_table *table, int write,
>>> diff --git a/kernel/trace/trace_stack.c b/kernel/trace/trace_stack.c
>>> index 9384647..c5b9748 100644
>>> --- a/kernel/trace/trace_stack.c
>>> +++ b/kernel/trace/trace_stack.c
>>> @@ -105,7 +105,7 @@ check_stack(unsigned long ip, unsigned long *stack)
>>> 
>>> 	/* Skip over the overhead of the stack tracer itself */
>>> 	for (i = 0; i < max_stack_trace.nr_entries; i++) {
>>> -		if (stack_dump_trace[i] == ip)
>>> +		if ((stack_dump_trace[i] + FTRACE_STACK_FRAME_OFFSET) == ip)
>>> 			break;
>>> 	}
>>> 
>>> @@ -131,7 +131,8 @@ check_stack(unsigned long ip, unsigned long *stack)
>>> 		p = start;
>>> 
>>> 		for (; p < top && i < max_stack_trace.nr_entries; p++) {
>>> -			if (*p == stack_dump_trace[i]) {
>>> +			if (*p == (stack_dump_trace[i]
>>> +					+ FTRACE_STACK_FRAME_OFFSET)) {
>>> 				stack_dump_trace[x] = stack_dump_trace[i++];
>>> 				this_size = stack_dump_index[x++] =
>>> 					(top - p) * sizeof(unsigned long);
>>> --
>> 
>> I've prepared a kernel with the following patches and reviewed them.
>> 
>> 1) Steve's clean up patch
>> 2) This patch
>> 3) [RFC 2/3]
>> 
>> AFAIU, [RFC 3/3] is not needed any more thanks to Steve's patch.
> 
> We don't need [2/3].

Okay. So, I've played a kernel including Steve's latest patch and only [1/3].

Best Regards
Jungseok Lee
