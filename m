From: dave.long@linaro.org (David Long)
Date: Tue, 05 May 2015 01:14:51 -0400
Subject: [PATCH v6 0/6] arm64: Add kernel probes (kprobes) support
In-Reply-To: <55442BFA.50101@redhat.com>
References: <1429561187-3661-1-git-send-email-dave.long@linaro.org>
 <55363791.4070706@hitachi.com> <553AB222.50609@redhat.com>
 <553EF74D.8020706@redhat.com> <20150429102346.GK8236@arm.com>
 <55442BFA.50101@redhat.com>
Message-ID: <554851CB.2010909@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/01/15 21:44, William Cohen wrote:
> On 04/29/2015 06:23 AM, Will Deacon wrote:
>> On Tue, Apr 28, 2015 at 03:58:21AM +0100, William Cohen wrote:
>>> Hi All,
>>
>> Hi Will,
>>
>>> I have been experimenting with the patches for arm64 kprobes support.
>>> On occasion the kernel gets stuck in a loop printing output:
>>>
>>>   Unexpected kernel single-step exception at EL1
>>>
>>> This message by itself is not that enlighten.  I added the attached
>>> patch to get some additional information about register state when the
>>> warning is printed out.  Below is an example output:
>>
>> Given that we've got the pt_regs in our hands at that point, I'm happy to
>> print something more useful if you like (e.g. the PC?).
>>
>>> [14613.263536] Unexpected kernel single-step exception at EL1
>>> [14613.269001] kcb->ss_ctx.ss_status = 1
>>> [14613.272643] kcb->ss_ctx.match_addr = fffffdfffc001250 0xfffffdfffc001250
>>> [14613.279324] instruction_pointer(regs) = fffffe0000093358 el1_da+0x8/0x70
>>> [14613.286003]
>>> [14613.287487] CPU: 3 PID: 621 Comm: irqbalance Tainted: G           OE   4.0.0u4+ #6
>>> [14613.295019] Hardware name: AppliedMicro Mustang/Mustang, BIOS 1.1.0-rh-0.15 Mar 13 2015
>>> [14613.302982] task: fffffe01d6806780 ti: fffffe01d68ac000 task.ti: fffffe01d68ac000
>>> [14613.310430] PC is at el1_da+0x8/0x70
>>> [14613.313990] LR is at trampoline_probe_handler+0x188/0x1ec
>>
>>> The really odd thing is the address of the PC it is in el1_da the code
>>> to handle data aborts.  it looks like it is getting the unexpected
>>> single_step exception right after the enable_debug in el1_da.  I think
>>> what might be happening is:
>>>
>>> -an instruction is instrumented with kprobe
>>> -the instruction is copied to a buffer
>>> -a breakpoint replaces the instruction
>>> -the kprobe fires when the breakpoint is encountered
>>> -the instruction in the buffer is set to single step
>>> -a single step of the instruction is attempted
>>> -a data abort exception is raised
>>> -el1_da is called
>>
>> So that's the bit that I find weird. Can you take a look at what we're doing
>> in trampoline_probe_handler, please? It could be that we're doing something
>> like get_user and aborting on a faulting userspace address, but I think
>> kprobes should handle that rather than us trying to get the generic
>> single-step code to deal with it.
>>
>>> It looks like commit 1059c6bf8534acda249e7e65c81e7696fb074dc1 from Mon
>>> Sep 22   "arm64: debug: don't re-enable debug exceptions on return from el1_dbg"
>>> was trying to address a similar problem for the el1_dbg
>>> function.  Should el1_da and other el1_* functions have the enable_dbg
>>> removed?
>>
>> I don't think so. The current behaviour of the low-level debug handler is to
>> step into traps, which is more flexible than trying to step over them (which
>> could lead to us stepping over interrupts, or preemption points). It should
>> be up to the higher-level debugger (e.g. kprobes, kgdb) to distinguish
>> between the traps it does and does not care about.
>>
>> An equivalent userspace example would be GDB stepping into single handlers,
>> I suppose.
>>
>> Will
>>
>
> Dave Long and I did some additional experimentation to better
> understand what is condition causes the kernel to sometimes spew:
>
> Unexpected kernel single-step exception at EL1
>
> The functioncallcount.stp test instruments the entry and return of
> every function in the mm files, including kfree.  In most cases the
> arm64 trampoline_probe_handler just determines which return probe
> instance matches the current conditions, runs the associated handler,
> and recycles the return probe instance for another use by placing it
> on a hlist.  However, it is possible that a return probe instance has
> been set up on function entry and the return probe is unregistered
> before the return probe instance fires.  In this case kfree is called
> by the trampoline handler to remove the return probe instances related
> to the unregistered kretprobe.  This case where the the kprobed kfree
> is called within the arm64 trampoline_probe_handler function trigger
> the problem.
>
> The kprobe breakpoint for the kfree call from within the
> trampoline_probe_handler is encountered and started, but things go
> wrong when attempting the single step on the instruction.
>
> It took a while to trigger this problem with the sytemtap testsuite.
> Dave Long came up with steps that reproduce this more quickly with a
> probed function that is always called within the trampoline handler.
> Trying the same on x86_64 doesn't trigger the problem.  It appears
> that the x86_64 code can handle a single step from within the
> trampoline_handler.
>
> -Will Cohen
>
>
>

I'm assuming there are no plans for supporting software breakpoint debug 
exceptions during processing of single-step exceptions, any time soon on 
arm64.  Given that the only solution that I can come with for this is 
instead of making this orphaned kretprobe instance list exist only 
temporarily (in the scope of the kretprobe trampoline handler), make it 
always exist and kfree any items found on it as part of a periodic 
cleanup running outside of the handler context.  I think these changes 
would still all be in archiecture-specific code.  This doesn't feel to 
me like a bad solution.  Does anyone think there is a simpler way out of 
this?

-Dave Long
