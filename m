From: panand@redhat.com (Pratyush Anand)
Date: Thu, 08 Jan 2015 22:49:24 +0530
Subject: Query: ARM64: Behavior of el1_dbg exception while executing
 el0_dbg
In-Reply-To: <54AEA718.20502@redhat.com>
References: <54AE830E.1090000@redhat.com> <54AEA718.20502@redhat.com>
Message-ID: <54AEBC1C.8060409@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Thursday 08 January 2015 09:19 PM, William Cohen wrote:
> On 01/08/2015 08:15 AM, Pratyush Anand wrote:
>> Hi All,
>>
>> I am trying to test following scenario, which seems valid to me. But I am very new to ARM64 as well as to debugging tools, so seeking expert's comment here.
>>
>> -- I have inserted a kprobe to the function uprobe_breakpoint_handler which is called from elo_dbg (el0_dbg->do_debug_exception->brk_handler->call_break_hook->uprobe_breakpoint_handler)
>>
>> -- kprobe is enabled.
>>
>> -- an uprobe is inserted into a test application and enabled.
>>
>> So, when uprobe is enabled and test code execution reaches to probe instruction, it executes uprobe breakpoint instruction and el0_dbg exception is raised.
>>
>> When control reaches to start of uprobe_breakpoint_handler and it executes first instruction (which has been replaced with a kprobe breakpoint instruction), el1_dbg exception is raised.
>>
>> Further Call sequence goes like, el1_dbg->do_debug_exception->brk_handler->call_break_hook->kprobe_breakpoint_handler, and kprobe breakpoint handler does everything what it should have done.
>>
>> After return from above (first) el1_dbg, second el1_dbg is raised for single steping of kprobe instruction, and instruction pointer does not matches with the kcb->ss_ctx.match_addr and so, kprobe_ss_hit fails, which is strange.
>>
>> To debug it further, I examined ELR_EL1 value in el1_dbg after execution of first el1_dbg, and it was fffffdfffc000004.
>>
>> So, my question is how can instruction pointer has a value fffffe0000092470(which is actually el1_inv + 0x4) when second el1_dbg is received?
>>
>> Am I missing something or trying something which is not supported by ARM64?
>>
>>
>> I have put some printk in the code. You can have a detailed view of debug code and print log here:
>>
>> https://github.com/pratyushanand/linux.git
>>
>> branch: ml_arm64_uprobe_devel_debug_kprobe_insertion_at_uprobe_breakpoint_handler
>>
>>
>> ~Pratyush
>
> Hi Pratyush,
>
> Could the problem be that uprobe handling is already handling the breakpoint exception, so when the kprobe fires in the uprobes code it is like nested kprobes? When this happen some state information is getting clobbered and process never gets out of the nested kprobe/uprobe.  I wonder if similar failures can be trigger with kprobes in the kernel code that user-space gdb uses the handle breakpoints or hardware watchpoints/breakpoints.

Yes, if kprobes are inserted in the kernel code that user-space gdb uses 
or hardware watchpoints/breakpoints handling code, I believe you will 
land into similar situation.

~Pratyush

>
> -Will
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
