From: panand@redhat.com (Pratyush Anand)
Date: Wed, 13 Sep 2017 10:29:19 +0530
Subject: [PATCH v2] arm64: fix unwind_frame() for filtered out fn for
 function graph tracing
In-Reply-To: <20170913024218.GB12411@arm.com>
References: <3c175a7a1f7c2e08098f6d5e84dc247ce94846d2.1504244801.git.panand@redhat.com>
 <59B7AED4.1070106@arm.com> <20170913024218.GB12411@arm.com>
Message-ID: <71e650af-4141-1bc1-3ced-6f109f3e7bbe@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Wednesday 13 September 2017 08:12 AM, Will Deacon wrote:
> On Tue, Sep 12, 2017 at 10:54:28AM +0100, James Morse wrote:
>> Hi Pratyush,
>>
>> On 01/09/17 06:48, Pratyush Anand wrote:
>>> do_task_stat() calls get_wchan(), which further does unbind_frame().
>>> unbind_frame() restores frame->pc to original value in case function
>>> graph tracer has modified a return address (LR) in a stack frame to hook
>>> a function return. However, if function graph tracer has hit a filtered
>>> function, then we can't unwind it as ftrace_push_return_trace() has
>>> biased the index(frame->graph) with a 'huge negative'
>>> offset(-FTRACE_NOTRACE_DEPTH).
>>>
>>> Moreover, arm64 stack walker defines index(frame->graph) as unsigned
>>> int, which can not compare a -ve number.
>>>
>>> Similar problem we can have with calling of walk_stackframe() from
>>> save_stack_trace_tsk() or dump_backtrace().
>>>
>>> This patch fixes unwind_frame() to test the index for -ve value and
>>> restore index accordingly before we can restore frame->pc.
>>
>> I've just spotted arm64's profile_pc, which does this:
>>  From arch/arm64/kernel/time.c:profile_pc():
>>> #ifdef CONFIG_FUNCTION_GRAPH_TRACER
>>> 	frame.graph = -1; /* no task info */
>>> #endif
>>
>> Is this another elaborate way of hitting this problem?
>>
>> I guess the options are skip any return-address restore in the unwinder if
>> frame.graph is -1. (and profile_pc may have a bug here). Or, put
>> current->curr_ret_stack in there.

I think we should go with latter, ie assign frame.graph = 
current->curr_ret_stack in profile_pc().

>>
>> profile_pc() always passes tsk=NULL, so the unwinder assumes its current...
>> kernel/profile.c pulls the pt_regs from a per-cpu irq_regs variable, that is
>> updated by handle_IPI ... so it looks like this should always be current...
> 
> Hmmm... is profile_pc the *only* case where frame->graph isn't equal to
> tsk->curr_ret_stack in unwind_frame? If so, maybe unwind_frame should just

Yes, it is the only place.

> use that, and we could kill the graph member of struct stackframe completely?
> 

Humm, not sure, we initialize frame->graph out of the while loop in 
unwind_frame()'s caller and then keep in decrementing it in looped function.

-- 
Regards
Pratyush
