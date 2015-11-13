From: jungseoklee85@gmail.com (Jungseok Lee)
Date: Sat, 14 Nov 2015 00:01:55 +0900
Subject: [PATCH v5 2/6] arm64: ftrace: fix a stack tracer's output under
 function graph tracer
In-Reply-To: <56415997.1040207@linaro.org>
References: <1446792285-1154-1-git-send-email-takahiro.akashi@linaro.org>
 <1446792285-1154-3-git-send-email-takahiro.akashi@linaro.org>
 <3F63B5BC-C21A-4ECA-9800-374B924DB98D@gmail.com>
 <56415997.1040207@linaro.org>
Message-ID: <01313E85-ED3B-4E3A-A193-033A393A93F8@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(+ Li Bin in CC)

On Nov 10, 2015, at 11:42 AM, AKASHI Takahiro wrote:
> On 11/09/2015 11:04 PM, Jungseok Lee wrote:
>> On Nov 6, 2015, at 3:44 PM, AKASHI Takahiro wrote:
>> 
>> Hi Akashi,
>> 
>>> Function graph tracer modifies a return address (LR) in a stack frame
>>> to hook a function return. This will result in many useless entries
>>> (return_to_handler) showing up in a stack tracer's output.
>>> 
>>> This patch replaces such entries with originals values preserved in
>>> current->ret_stack[].
>>> 
>>> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
>>> ---
>>> arch/arm64/include/asm/ftrace.h |    2 ++
>>> arch/arm64/kernel/stacktrace.c  |   21 +++++++++++++++++++++
>>> 2 files changed, 23 insertions(+)
>>> 
>>> diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
>>> index c5534fa..3c60f37 100644
>>> --- a/arch/arm64/include/asm/ftrace.h
>>> +++ b/arch/arm64/include/asm/ftrace.h
>>> @@ -28,6 +28,8 @@ struct dyn_arch_ftrace {
>>> 
>>> extern unsigned long ftrace_graph_call;
>>> 
>>> +extern void return_to_handler(void);
>>> +
>>> static inline unsigned long ftrace_call_adjust(unsigned long addr)
>>> {
>>> 	/*
>>> diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
>>> index ccb6078..5fd3477 100644
>>> --- a/arch/arm64/kernel/stacktrace.c
>>> +++ b/arch/arm64/kernel/stacktrace.c
>>> @@ -17,6 +17,7 @@
>>>  */
>>> #include <linux/kernel.h>
>>> #include <linux/export.h>
>>> +#include <linux/ftrace.h>
>>> #include <linux/sched.h>
>>> #include <linux/stacktrace.h>
>>> 
>>> @@ -73,6 +74,9 @@ struct stack_trace_data {
>>> 	struct stack_trace *trace;
>>> 	unsigned int no_sched_functions;
>>> 	unsigned int skip;
>>> +#ifdef CONFIG_FUNCTION_GRAPH_TRACER
>>> +	unsigned int ret_stack_index;
>>> +#endif
>>> };
>>> 
>>> static int save_trace(struct stackframe *frame, void *d)
>>> @@ -81,6 +85,20 @@ static int save_trace(struct stackframe *frame, void *d)
>>> 	struct stack_trace *trace = data->trace;
>>> 	unsigned long addr = frame->pc;
>>> 
>>> +#ifdef CONFIG_FUNCTION_GRAPH_TRACER
>>> +	if (addr == (unsigned long)return_to_handler - AARCH64_INSN_SIZE) {
>> 
>> not if (adds == (unsigned long)return_to_handler)?
>> 
>>> +		/*
>>> +		 * This is a case where function graph tracer has
>>> +		 * modified a return address (LR) in a stack frame
>>> +		 * to hook a function return.
>>> +		 * So replace it to an original value.
>>> +		 */
>>> +		frame->pc = addr =
>>> +			current->ret_stack[data->ret_stack_index--].ret
>>> +							- AARCH64_INSN_SIZE;
>> 
>> Ditto. not without AARCH64_INSN_SIZE?
>> 
>> I've observed many return_to_handler without the changes.
>> Am I missing something?
> 
> You're right!
> I thought I had tested the patches, but...
> 
>>> +	}
>>> +#endif /* CONFIG_FUNCTION_GRAPH_TRACER */
>>> +
>>> 	if (data->no_sched_functions && in_sched_functions(addr))
>>> 		return 0;
>>> 	if (data->skip) {
>>> @@ -100,6 +118,9 @@ void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
>>> 
>>> 	data.trace = trace;
>>> 	data.skip = trace->skip;
>>> +#ifdef CONFIG_FUNCTION_GRAPH_TRACER
>>> +	data.ret_stack_index = current->curr_ret_stack;
>> 
>> Can I get an idea on why current->curr_ret_stack is used instead of
>> tsk->curr_ret_stack?
> 
> Thanks for pointing this out.
> Will fix it although it works without a change since save_stack_trace_sp() is
> called only in a 'current task' context.
> 
> -Takahiro AKASHI

As reading function_graph related codes in arm64, I've realized that this issue
can be observed from three different sources.

 (A) stack tracer of ftrace
 (B) perf call trace (perf record with '-g' option)
 (C) dump_backtrace

The issue is orthogonal to the commit, e306dfd06f, and its revert. It seems that
Steve's approach, 7ee991fbc6, would be valid on arm64 and cover all three cases.
It does in case of x86. Li Bin posted a patch [1] to solve the issue from case(C)
in Steve's way. This hunk deals with case(A) with its own implementation. But,
case(B) is not covered yet. It can be reproduced easily with the following steps.

 # echo function_graph > /sys/kernel/debug/tracing/current_tracer
 # perf record -g sleep 2
 # perf report --call-graph

So, how about considering Steve's approach on arm64 and then covering all three
cases with it? It would be good in code consolidation perspective. Note that the
idea is applied to arch/sh.

Best Regards
Jungseok Lee

[1] https://lkml.org/lkml/2015/10/15/368
