From: panand@redhat.com (Pratyush Anand)
Date: Wed, 30 Aug 2017 18:29:45 +0530
Subject: [PATCH] arm64: fix unwind_frame() for filtered out fn via
 set_graph_notrace
In-Reply-To: <59A59E62.7060009@arm.com>
References: <4a92b0bf5ee602de6463057e5d98d20b4d4f2bcd.1503924827.git.panand@redhat.com>
 <59A59E62.7060009@arm.com>
Message-ID: <86213136-9ace-c686-7ed4-62e19bfb50f1@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Tuesday 29 August 2017 10:33 PM, James Morse wrote:
> Hi Pratyush,
> 
> (Nit: get_maintainer.pl will give you the list of people to CC, you're reliant
> on the maintainers being eagle-eyed to spot this!)

I noticed it after sending. I do use it, but there was a bug in my cccmd 
script. I have fixed it. I hope, it won't miss from next time.

> 
> On 28/08/17 13:53, Pratyush Anand wrote:
>> Testcase:
>> cd /sys/kernel/debug/tracing/
>> echo schedule > set_graph_notrace
>> echo 1 > options/display-graph
>> echo wakeup > current_tracer
>> ps -ef | grep -i agent
>>
>> Above commands result in
>> PANIC: "Unable to handle kernel paging request at virtual address
>> ffff801bcbde7000"
> 
> This didn't panic for me, it just killed the running task. (I guess you have
> panic-on-oops set)
> 

yes..

> 
>> vmcore analysis:
>> 1)
>> crash> bt
>> PID: 1561   TASK: ffff8003cb7e4000  CPU: 0   COMMAND: "ps"
>>   #0 [ffff8003c4ff77b0] crash_kexec at ffff00000816b9b8
>>   #1 [ffff8003c4ff77e0] die at ffff000008088b34
>>   #2 [ffff8003c4ff7820] __do_kernel_fault at ffff00000809b830
>>   #3 [ffff8003c4ff7850] do_bad_area at ffff000008098b90
>>   #4 [ffff8003c4ff7880] do_translation_fault at ffff0000087c6cdc
>>   #5 [ffff8003c4ff78b0] do_mem_abort at ffff000008081334
>>   #6 [ffff8003c4ff7ab0] el1_ia at ffff000008082cc0
>>       PC: ffff00000808811c  [unwind_frame+300]
>>       LR: ffff0000080858a8  [get_wchan+212]
>>       SP: ffff8003c4ff7ab0  PSTATE: 60000145
>>      X29: ffff8003c4ff7ab0  X28: 0000000000000001  X27: 0000000000000000
>>      X26: 0000000000000000  X25: 0000000000000000  X24: 0000000000000000
>>      X23: ffff8003c1c20000  X22: ffff000008c73000  X21: ffff8003c1c1c000
>>      X20: 000000000000000f  X19: ffff8003c1bc7000  X18: 0000000000000010
>>      X17: 0000000000000000  X16: 0000000000000001  X15: ffffffffffffffed
>>      X14: 0000000000000010  X13: ffffffffffffffff  X12: 0000000000000004
>>      X11: 0000000000000000  X10: 0000000002dd14c0   X9: 1999999999999999
>>       X8: 000000000000003f   X7: 00008003f71b0000   X6: 0000000000000018
>>       X5: 0000000000000000   X4: ffff8003c1c1fd20   X3: ffff8003c1c1fd10
>>       X2: 00000017ffe80000   X1: ffff8003c4ff7af8   X0: ffff8003cbf67000
>>   #7 [ffff8003c4ff7b20] do_task_stat at ffff000008304f0c
>>   #8 [ffff8003c4ff7c60] proc_tgid_stat at ffff000008305b48
>>   #9 [ffff8003c4ff7ca0] proc_single_show at ffff0000082fdd10
>>   #10 [ffff8003c4ff7ce0] seq_read at ffff0000082b27bc
>>   #11 [ffff8003c4ff7d70] __vfs_read at ffff000008289e54
>>   #12 [ffff8003c4ff7e30] vfs_read at ffff00000828b14c
>>   #13 [ffff8003c4ff7e70] sys_read at ffff00000828c2d0
>>   #14 [ffff8003c4ff7ed0] __sys_trace at ffff00000808349c
>>       PC: 00000006  LR: 00000000  SP: ffffffffffffffed  PSTATE: 0000003f
>>      X12: 00000010 X11: ffffffffffffffff X10: 00000004  X9: ffff7febe8d0
>>       X8: 00000000  X7: 1999999999999999  X6: 0000003f  X5: 0000000c
>>       X4: ffff7fce9c78  X3: 0000000c  X2: 00000000  X1: 00000000
>>       X0: 00000400
>>
>> (2) Instruction at ffff00000808811c caused IA/DA.
>>
>> crash> dis -l ffff000008088108 6
>> /usr/src/debug/xxxxxxxxxxxx/xxxxxxxxxx/arch/arm64/kernel/stacktrace.c:
>> 84
>> 0xffff000008088108 <unwind_frame+280>:  ldr     w2, [x1,#24]
>> 0xffff00000808810c <unwind_frame+284>:  sub     w6, w2, #0x1
>> 0xffff000008088110 <unwind_frame+288>:  str     w6, [x1,#24]
>> 0xffff000008088114 <unwind_frame+292>:  mov     w6, #0x18 // #24
>> 0xffff000008088118 <unwind_frame+296>:  umull   x2, w2, w6
>> 0xffff00000808811c <unwind_frame+300>:  ldr     x0, [x0,x2]
>>
>> Corresponding c statement is
>> frame->pc = tsk->ret_stack[frame->graph--].ret;
>>
>> (3) So, it caused data abort while executing
>> 0xffff00000808811c <unwind_frame+300>:  ldr     x0, [x0,x2]
>>
>> x0 + x2 = ffff8003cbf67000 + 00000017ffe80000 = ffff801bcbde7000
>> Access of ffff801bcbde7000 resulted in "Unable to handle kernel paging
>> request"
>>
>> from above data: frame->graph = task->curr_ret_stack which  should be,
>> x2 / 0x18 = FFFF0000, which is -FTRACE_NOTRACE_DEPTH.
> 
> (0x18 is the size of struct ftrace_ret_stack for your config?)

yes.

> 
> 
>> OK, so problem is here:
>> do_task_stat() calls get_wchan(). Here p->curr_ret_stack  is
>> -FTRACE_NOTRACE_DEPTH in the failed case.
> 
>> It means, when do_task_stat()
>> has been called for task A (ps in this case) on CPUm,task A was in mid
>> of execution on CPUn,
> 
> get_wchan() on a running processes can't work: the stack may be modified while
> we walk it.
>  From arch/arm64/kernel/process.c::get_wchan():
>> 	if (!p || p == current || p->state == TASK_RUNNING)
>> 		return 0;
> 
> As far as I can see, if task A is running on CPU-N then CPU-Ms attempt to
> get_wchan() it will return 0.

You seems right.

> 
> 
>> and was in the mid of mcount() execution where
>> curr_ret_stack had been decremented in ftrace_push_return_trace() for
>> hitting schedule() function, but it was yet to be incremented in
>> ftrace_return_to_handler().
> 
> So if the function-graph-tracer has hooked the return values on a stack and hit
> a filtered function, (schedule() in your example), we can't unwind it as
> ftrace_push_return_trace() has biased the index with a 'huge negative' offset to
> flag it as 'this should be filtered out'.
> 
> The arm64 stack walker isn't aware of this and interprets it as an unsigned
> index. Nasty!
> 

Hummm...frame.graph always takes tsk->curr_ret_stack which is int. It has been 
assigned as -1 in arch/arm64/kernel/time.c. frame.graph should be defined as int.


> 
>> Similar problem we can have with calling of walk_stackframe() from
>> save_stack_trace_tsk() or dump_backtrace().
>>
>> This patch fixes unwind_frame() to not to manipulate frame->pc for
> 
> Nit: strictly this is is 'restore frame->pc from ftrace's ret_stack', but I
> think we still need to do this restore...
> 
> 
>> function graph tracer if the function has been marked in
>> set_graph_notrace.
> 
> Nit: ftrace describes these as 'filtered out', set_graph_notrace is the debugfs
> interface.
> 
> 
>> This patch fixes: 20380bb390a4 (arm64: ftrace: fix a stack tracer's
>> output under function graph tracer)
> 
>> Signed-off-by: Pratyush Anand <panand@redhat.com>
> 
> 
>> diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
>> index 09d37d66b630..e79035d673b3 100644
>> --- a/arch/arm64/kernel/stacktrace.c
>> +++ b/arch/arm64/kernel/stacktrace.c
>> @@ -74,7 +74,8 @@ int notrace unwind_frame(struct task_struct *tsk, struct
> stackframe *frame)
>>
>>   #ifdef CONFIG_FUNCTION_GRAPH_TRACER
>>   	if (tsk->ret_stack &&
>> -			(frame->pc == (unsigned long)return_to_handler)) {
>> +			(frame->pc == (unsigned long)return_to_handler) &&
> 
>> +			(frame->graph > -1)) {
> 
> This should give you a compiler warning: its declared as an unsigned int in
> struct stackframe.

I did not get this warning :(
# gcc --version
gcc (GCC) 4.8.5 20150623

> 
> 
> ... but with this patch /proc/<pid>/wchan now reports:
>> cat /proc/1/wchan
>> return_to_handler
> 
> So it looks like 'filtered out' doesn't mean 'not hooked'. I think a more
> complete fix is to test if frame->graph is negative and add FTRACE_NOTRACE_DEPTH
> back to it:
> 

Yep, it should allow to read correct /proc/.../wchan.


>  From kernel/trace/ftrace_functions_graph.c::trace_pop_return_trace():
>> 	index = current->curr_ret_stack;
>>
>> 	/*
>> 	 * A negative index here means that it's just returned from a
>> 	 * notrace'd function.  Recover index to get an original
>> 	 * return address.  See ftrace_push_return_trace().
>> 	 *
>> 	 * TODO: Need to check whether the stack gets corrupted.
>> 	 */
>> 	if (index < 0)
>> 		index += FTRACE_NOTRACE_DEPTH;
> 
> (looks like this is the only magic offset)
> 
> 
> I don't think we need to preserve the vmcore debugging in the kernel log, could
> you cut the commit message down to describe the negative curr_ret_stack being
> interpreted as a signed value instead of skipped by unwind_frame(), then have
> the reproducer and a chunk of the splat.
> 
> 
> Thanks for getting to the bottom of this, it looks like this was a mammoth
> debugging session!
> 

Certainly few hours :-).

Thanks for your review.

-- 
Regards
Pratyush
