From: panand@redhat.com (Pratyush Anand)
Date: Thu, 08 Jan 2015 22:58:37 +0530
Subject: Query: ARM64: Behavior of el1_dbg exception while executing
 el0_dbg
In-Reply-To: <20150108162312.GO11583@arm.com>
References: <54AE830E.1090000@redhat.com> <20150108162312.GO11583@arm.com>
Message-ID: <54AEBE45.9080203@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Thursday 08 January 2015 09:53 PM, Will Deacon wrote:
> On Thu, Jan 08, 2015 at 01:15:58PM +0000, Pratyush Anand wrote:
>> Hi All,
>>
>> I am trying to test following scenario, which seems valid to me. But I
>> am very new to ARM64 as well as to debugging tools, so seeking expert's
>> comment here.
>>
>> -- I have inserted a kprobe to the function uprobe_breakpoint_handler
>> which is called from elo_dbg
>> (el0_dbg->do_debug_exception->brk_handler->call_break_hook->uprobe_breakpoint_handler)
>>
>> -- kprobe is enabled.
>>
>> -- an uprobe is inserted into a test application and enabled.
>>
>> So, when uprobe is enabled and test code execution reaches to probe
>> instruction, it executes uprobe breakpoint instruction and el0_dbg
>> exception is raised.
>>
>> When control reaches to start of uprobe_breakpoint_handler and it
>> executes first instruction (which has been replaced with a kprobe
>> breakpoint instruction), el1_dbg exception is raised.
>
> Hmm, debug exceptions should be masked at this point so I don't see why
> you're taking the second debug exception.
>

So, you mean to say that when an exception which has been taken from 
lower exception level (EL0) is being executed, then we keep masked also 
the exception from current exception level (EL1)...

If, so then how to handle it. One way is that I assign a __kprobe 
qualifier to uprobe_breakpoint_handler and uprobe_single_step_handler, 
so that an user can not insert a kprobe there. But, that does not seem 
to be a good idea, because it will only prevent these two functions to 
be probed. What about the functions which is being called by these 
functions like uprobe_pre_sstep_notifier & uprobe_post_sstep_notifier 
which lie in generic kernel code. So, may be we need something in 
debug-monitor, which handles this situation, no?

~Pratyush

> Will
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
