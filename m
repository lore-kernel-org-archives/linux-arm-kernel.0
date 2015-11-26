From: jungseoklee85@gmail.com (Jungseok Lee)
Date: Thu, 26 Nov 2015 23:05:02 +0900
Subject: [PATCH v6 3/6] arm64: ftrace: fix a stack tracer's output under
 function graph tracer
In-Reply-To: <56567702.5000305@linaro.org>
References: <1447828989-4980-1-git-send-email-takahiro.akashi@linaro.org>
 <1447828989-4980-4-git-send-email-takahiro.akashi@linaro.org>
 <0FD87840-2C67-4267-9FF5-AAE929348755@gmail.com>
 <56554740.4070904@linaro.org>
 <803D05EA-BAA3-41E6-AF67-236D6D3B5789@gmail.com>
 <56567702.5000305@linaro.org>
Message-ID: <D2BFFD9E-46A5-4B4D-9A79-0ECA193ED716@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Nov 26, 2015, at 12:05 PM, AKASHI Takahiro wrote:
> Jungseok,

Hi Akashi,

> On 11/25/2015 08:48 PM, Jungseok Lee wrote:
>> On Nov 25, 2015, at 2:29 PM, AKASHI Takahiro wrote:
>>> On 11/24/2015 10:37 PM, Jungseok Lee wrote:
>>>> On Nov 18, 2015, at 3:43 PM, AKASHI Takahiro wrote:
>>>> 
>>>> Hi Akashi,
>>>> 
>>>>> Function graph tracer modifies a return address (LR) in a stack frame
>>>>> to hook a function return. This will result in many useless entries
>>>>> (return_to_handler) showing up in
>>>>> a) a stack tracer's output
>>>>> b) perf call graph (with perf record -g)
>>>>> c) dump_backtrace (at panic et al.)
>>>>> 
>>>>> For example, in case of a),
>>>>>  $ echo function_graph > /sys/kernel/debug/tracing/current_tracer
>>>>>  $ echo 1 > /proc/sys/kernel/stack_trace_enabled
>>>>>  $ cat /sys/kernel/debug/tracing/stack_trace
>>>>>        Depth    Size   Location    (54 entries)
>>>>>        -----    ----   --------
>>>>>  0)     4504      16   gic_raise_softirq+0x28/0x150
>>>>>  1)     4488      80   smp_cross_call+0x38/0xb8
>>>>>  2)     4408      48   return_to_handler+0x0/0x40
>>>>>  3)     4360      32   return_to_handler+0x0/0x40
>>>>>  ...
>>>>> 
>>>>> In case of b),
>>>>>  $ echo function_graph > /sys/kernel/debug/tracing/current_tracer
>>>>>  $ perf record -e mem:XXX:x -ag -- sleep 10
>>>>>  $ perf report
>>>>>                  ...
>>>>>                  |          |          |--0.22%-- 0x550f8
>>>>>                  |          |          |          0x10888
>>>>>                  |          |          |          el0_svc_naked
>>>>>                  |          |          |          sys_openat
>>>>>                  |          |          |          return_to_handler
>>>>>                  |          |          |          return_to_handler
>>>>>                  ...
>>>>> 
>>>>> In case of c),
>>>>>  $ echo function_graph > /sys/kernel/debug/tracing/current_tracer
>>>>>  $ echo c > /proc/sysrq-trigger
>>>>>  ...
>>>>>  Call trace:
>>>>>  [<ffffffc00044d3ac>] sysrq_handle_crash+0x24/0x30
>>>>>  [<ffffffc000092250>] return_to_handler+0x0/0x40
>>>>>  [<ffffffc000092250>] return_to_handler+0x0/0x40
>>>>>  ...
>>>>> 
>>>>> This patch replaces such entries with real addresses preserved in
>>>>> current->ret_stack[] at unwind_frame(). This way, we can cover all
>>>>> the cases.
>>>> 
>>>> I've observed a strange behavior when playing with case c). Call trace
>>>> is as follows when function_graph is not used.
>>>> 
>>>> Call trace:
>>>>  [<fffffe00003dc738>] sysrq_handle_crash+0x24/0x30          <- (1)
>>>>  [<fffffe00003dd2ac>] __handle_sysrq+0x128/0x19c            <- (2)
>>>>  [<fffffe00003dd730>] write_sysrq_trigger+0x60/0x74
>>>>  [<fffffe0000249fc4>] proc_reg_write+0x84/0xc0
>>>>  [<fffffe00001f2638>] __vfs_write+0x44/0x104                <- (3)
>>>>  [<fffffe00001f2e60>] vfs_write+0x98/0x1a8
>>>>  [<fffffe00001f3730>] SyS_write+0x50/0xb0
>>>>  [<fffffe00000939ec>] el0_svc_naked+0x20/0x28               <- (4)
>>>> 
>>>> When function_graph is set, some entries, such as do_mem_abort, are added
>>>> between (1) and (2). In addition, entries from (3) to (4) are not printed
>>>> out. As tracking down elements of ret_stack[], I realize dump_backtrace()
>>>> has been terminated before reaching to ret_stack[0]. Have you seen this
>>>> kind of behavior? I believe push & pop operations work correctly.
>>>> 
>>>> Please correct me if I'm wrong.
>>> 
>>> Oops, I mis-interpreted the result output.
>>> You are right.
>>> This can happen because the original dump_backtrace() wants to trace a stack
>>> from a function where an exception has taken place, sysrq_handle_crash(), while
>>> ret_stack[curr_ret_stack] doesn't point to that function, but the very top of
>>> traced functions in callchains, that is, __do_kernel_fault in your case, probably.
>> 
>> Yes, __do_kernel_fault.
>> 
>>> So it results in replacing entries of return_to_handler to wrong function addresses.
>>> 
>>> A fixup! patch attached below (informative only) fixes this issue by once tracing
>>> all the functions on a stack, but preventing a top few ones from being printed.
>>> But there is a tricky thing here: we have to use 'regs->pc' instead of frame.pc
>>> as a trapped function because, as I've already mentioned before, we always miss
>>> the function when walking through a stack from an exception handler to functions
>>> in a thread context.
>>> (Please note that we will introduce a dummy stack frame at interrupt, but not
>>> at exception.)
>> 
>> Thanks for clear explanation!
>> 
>> Since I'm not the only person to experience the above case, I report one more and
>> the last observation ;)
>> 
>> PC and LR information is printed out when function_graph is set.
>> 
>>  PC is at sysrq_handle_crash+0x24/0x30
>>  LR is at sysrq_handle_crash+0x10/0x30
>> 
>> The logs are as follows when function_graph turns off.
>> 
>>  PC is at sysrq_handle_crash+0x24/0x30
>>  LR is at __handle_sysrq+0x128/0x19c
>> 
>> I think __show_regs() might have a similar problem when retrieving LR according to
>> the below informative patch. Thoughts?
> 
> Well, I believe that it is normal.
> Sysrq_handle_crash() is basically a leaf function, but once function or function graph
> tracer is turned on, ftrace_caller() is called before its function body and so LR has
> been modified when panic/show_regs().

Got it. All aspects of this patch is clear now. Thanks!

Best Regards
Jungseok Lee
