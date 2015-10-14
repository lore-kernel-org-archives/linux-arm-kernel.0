From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Wed, 14 Oct 2015 14:09:25 +0900
Subject: [PATCH v3 1/7] arm64: ftrace: adjust callsite addresses examined
 by stack tracer
In-Reply-To: <20151013113750.0fdecd33@gandalf.local.home>
References: <1444298504-10392-1-git-send-email-takahiro.akashi@linaro.org>
 <1444298504-10392-2-git-send-email-takahiro.akashi@linaro.org>
 <20151013113750.0fdecd33@gandalf.local.home>
Message-ID: <561DE385.1040005@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/14/2015 12:37 AM, Steven Rostedt wrote:
> On Thu,  8 Oct 2015 19:01:38 +0900
> AKASHI Takahiro <takahiro.akashi@linaro.org> wrote:
>
>>   extern int stack_tracer_enabled;
>>   int
>>   stack_trace_sysctl(struct ctl_table *table, int write,
>> diff --git a/kernel/trace/trace_stack.c b/kernel/trace/trace_stack.c
>> index b746399..30521ea 100644
>> --- a/kernel/trace/trace_stack.c
>> +++ b/kernel/trace/trace_stack.c
>> @@ -105,7 +105,7 @@ check_stack(unsigned long ip, unsigned long *stack)
>>
>>   	/* Skip over the overhead of the stack tracer itself */
>>   	for (i = 0; i < max_stack_trace.nr_entries; i++) {
>> -		if (stack_dump_trace[i] == ip)
>> +		if ((stack_dump_trace[i] + FTRACE_STACK_FRAME_OFFSET) == ip)
>>   			break;
>>   	}
>>
>> @@ -133,7 +133,8 @@ check_stack(unsigned long ip, unsigned long *stack)
>>   		for (; p < top && i < max_stack_trace.nr_entries; p++) {
>>   			if (stack_dump_trace[i] == ULONG_MAX)
>>   				break;
>> -			if (*p == stack_dump_trace[i]) {
>> +			if (*p == (stack_dump_trace[i]
>> +					+ FTRACE_STACK_FRAME_OFFSET)) {
>
> I'm fine with the patch, but this is one of those cases that I think
> the 80 column max limit produces uglier code than just going a little
> over.
>
> Or, we can add a helper variable in both locations:
>
> 	addr = stack_dump_trace[i] + FTRACE_STACK_FRAME_OFFSET;
> 	if (*p == addr) {
>
> gcc should be smart enough to optimize out the addr variable.

Thanks, I will take this.
(please note that this patch won't be necessary if my patch5,6 and 7 are
accepted.)

-Takahiro AKASHI

> -- Steve
>
>>   				stack_dump_trace[x] = stack_dump_trace[i++];
>>   				this_size = stack_dump_index[x++] =
>>   					(top - p) * sizeof(unsigned long);
>
