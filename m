From: panand@redhat.com (Pratyush Anand)
Date: Tue, 13 Jan 2015 12:16:36 +0530
Subject: Query: ARM64: Behavior of el1_dbg exception while executing
 el0_dbg
In-Reply-To: <20150112173005.GK13360@arm.com>
References: <54AE830E.1090000@redhat.com> <20150108162312.GO11583@arm.com>
 <54AEBE45.9080203@redhat.com> <20150109154635.GG11258@arm.com>
 <54B00C39.1070809@redhat.com> <20150112173005.GK13360@arm.com>
Message-ID: <54B4BF4C.2030009@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Monday 12 January 2015 11:00 PM, Will Deacon wrote:
> On Fri, Jan 09, 2015 at 05:13:29PM +0000, Pratyush Anand wrote:
>>
>>
>> On Friday 09 January 2015 09:16 PM, Will Deacon wrote:
>>> On Thu, Jan 08, 2015 at 05:28:37PM +0000, Pratyush Anand wrote:
>>>> On Thursday 08 January 2015 09:53 PM, Will Deacon wrote:
>>>>> On Thu, Jan 08, 2015 at 01:15:58PM +0000, Pratyush Anand wrote:
>>>>>> I am trying to test following scenario, which seems valid to me. But I
>>>>>> am very new to ARM64 as well as to debugging tools, so seeking expert's
>>>>>> comment here.
>>>>>>
>>>>>> -- I have inserted a kprobe to the function uprobe_breakpoint_handler
>>>>>> which is called from elo_dbg
>>>>>> (el0_dbg->do_debug_exception->brk_handler->call_break_hook->uprobe_breakpoint_handler)
>>>>>>
>>>>>> -- kprobe is enabled.
>>>>>>
>>>>>> -- an uprobe is inserted into a test application and enabled.
>>>>>>
>>>>>> So, when uprobe is enabled and test code execution reaches to probe
>>>>>> instruction, it executes uprobe breakpoint instruction and el0_dbg
>>>>>> exception is raised.
>>>>>>
>>>>>> When control reaches to start of uprobe_breakpoint_handler and it
>>>>>> executes first instruction (which has been replaced with a kprobe
>>>>>> breakpoint instruction), el1_dbg exception is raised.
>>>>>
>>>>> Hmm, debug exceptions should be masked at this point so I don't see why
>>>>> you're taking the second debug exception.
>>>>>
>>>>
>>>> So, you mean to say that when an exception which has been taken from
>>>> lower exception level (EL0) is being executed, then we keep masked also
>>>> the exception from current exception level (EL1)...
>>>
>>> Yeah, if you look at entry.S then you'll see that neither el0_dbg or el1_dbg
>>> re-enable debug exceptions (masked automatically by the CPU after taking the
>>> exception) until *after* the handling has completed. This is to prevent
>>> recursive debug exceptions, which I don't see how we can reasonable handle.
>>
>> May be I am missing something, but my observation on silicon is
>> different. Please have a look at git log of HEAD of following branch,
>> which says that el1_dbg exception has been raised while el0_dbg was
>> executing. Do not know what I am missing..
>>
>> https://github.com/pratyushanand/linux/tree/ml_arm64_uprobe_devel_debug_kprobe_insertion_at_uprobe_breakpoint_handler
>
> That page just says "Failed to load latest commit information." for me.

may be you can fetch https://github.com/pratyushanand/linux.git and can 
see git log of HEAD of 
ml_arm64_uprobe_devel_debug_kprobe_insertion_at_uprobe_breakpoint_handler.

Or, you can apply attached patches on top of v3.18 kernel.

>
> Regardless, I think you need to debug further and found out if PSTATE.D is
> getting cleared and, if so, who is responsible for that. Somebody could be
> enabling IRQs, for example, which will then unmask debug exceptions in
> el1_irq.
>


This is what I see for pstate, When el0_dbg exception is raised (ie an 
exception raised with ESR = ESR_EL1_EC_BRK64 after executing instruction 
BRK64_OPCODE_UPROBES = 0xD4200100 in EL0, user mode), spsr_el1 value is 
0x80000000. Which means, all exceptions are unmasked. Is it expected?


~Pratyush
-------------- next part --------------
A non-text attachment was scrubbed...
Name: uprobe_kprobe_patches_over_v3.18.tar.bz2
Type: application/x-bzip
Size: 26669 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150113/4cbfc661/attachment-0001.bin>
