From: wcohen@redhat.com (William Cohen)
Date: Tue, 05 May 2015 17:02:41 -0400
Subject: [PATCH v6 0/6] arm64: Add kernel probes (kprobes) support
In-Reply-To: <20150505154830.GI1550@arm.com>
References: <1429561187-3661-1-git-send-email-dave.long@linaro.org>
 <55363791.4070706@hitachi.com> <553AB222.50609@redhat.com>
 <553EF74D.8020706@redhat.com> <20150429102346.GK8236@arm.com>
 <55442BFA.50101@redhat.com> <554851CB.2010909@linaro.org>
 <20150505154830.GI1550@arm.com>
Message-ID: <55492FF1.6040907@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/05/2015 11:48 AM, Will Deacon wrote:
> On Tue, May 05, 2015 at 06:14:51AM +0100, David Long wrote:
>> On 05/01/15 21:44, William Cohen wrote:
>>> Dave Long and I did some additional experimentation to better
>>> understand what is condition causes the kernel to sometimes spew:
>>>
>>> Unexpected kernel single-step exception at EL1
>>>
>>> The functioncallcount.stp test instruments the entry and return of
>>> every function in the mm files, including kfree.  In most cases the
>>> arm64 trampoline_probe_handler just determines which return probe
>>> instance matches the current conditions, runs the associated handler,
>>> and recycles the return probe instance for another use by placing it
>>> on a hlist.  However, it is possible that a return probe instance has
>>> been set up on function entry and the return probe is unregistered
>>> before the return probe instance fires.  In this case kfree is called
>>> by the trampoline handler to remove the return probe instances related
>>> to the unregistered kretprobe.  This case where the the kprobed kfree
>>> is called within the arm64 trampoline_probe_handler function trigger
>>> the problem.
>>>
>>> The kprobe breakpoint for the kfree call from within the
>>> trampoline_probe_handler is encountered and started, but things go
>>> wrong when attempting the single step on the instruction.
>>>
>>> It took a while to trigger this problem with the sytemtap testsuite.
>>> Dave Long came up with steps that reproduce this more quickly with a
>>> probed function that is always called within the trampoline handler.
>>> Trying the same on x86_64 doesn't trigger the problem.  It appears
>>> that the x86_64 code can handle a single step from within the
>>> trampoline_handler.
>>>
>>
>> I'm assuming there are no plans for supporting software breakpoint debug 
>> exceptions during processing of single-step exceptions, any time soon on 
>> arm64.  Given that the only solution that I can come with for this is 
>> instead of making this orphaned kretprobe instance list exist only 
>> temporarily (in the scope of the kretprobe trampoline handler), make it 
>> always exist and kfree any items found on it as part of a periodic 
>> cleanup running outside of the handler context.  I think these changes 
>> would still all be in archiecture-specific code.  This doesn't feel to 
>> me like a bad solution.  Does anyone think there is a simpler way out of 
>> this?
> 
> Just to clarify, is the problem here the software breakpoint exception,
> or trying to step the faulting instruction whilst we were already handling
> a step?
> 
> I think I'd be inclined to keep the code run in debug context to a minimum.
> We already can't block there, and the more code we add the more black spots
> we end up with in the kernel itself. The alternative would be to make your
> kprobes code re-entrant, but that sounds like a nightmare.
> 
> You say this works on x86. How do they handle it? Is the nested probe
> on kfree ignored or handled?
> 
> Will
> 

Hi Dave and Will,

The attached patch attempts to eliminate the need for the breakpoint in the trampoline.  It is modeled after the x86_64 code and just saves the register state, calls the trampoline handler, and then fixes the return address.  The code compiles, but I have NOT verified that it works. It looks feasible to do things this way.  In addition to avoiding the possible issue with a kretprobe on kfree it would also make the kretprobes faster because it would avoid the breakpoint exception and the associated kprobe handling in the trampoline.

-Will
-------------- next part --------------
A non-text attachment was scrubbed...
Name: avoid_bkpt_trampoline.diff
Type: text/x-patch
Size: 4465 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150505/1ebbc086/attachment-0001.bin>
