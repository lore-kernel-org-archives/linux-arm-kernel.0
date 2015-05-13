From: masami.hiramatsu.pt@hitachi.com (Masami Hiramatsu)
Date: Wed, 13 May 2015 18:22:48 +0900
Subject: [PATCH v6 0/6] arm64: Add kernel probes (kprobes) support
In-Reply-To: <5551F693.8050100@redhat.com>
References: <1429561187-3661-1-git-send-email-dave.long@linaro.org>
 <55363791.4070706@hitachi.com> <553AB222.50609@redhat.com>
 <553EF74D.8020706@redhat.com> <20150429102346.GK8236@arm.com>
 <55442BFA.50101@redhat.com> <554851CB.2010909@linaro.org>
 <20150505154830.GI1550@arm.com> <55519583.9020507@linaro.org>
 <5551F693.8050100@redhat.com>
Message-ID: <555317E8.2000502@hitachi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/05/12 21:48, William Cohen wrote:
> On 05/12/2015 01:54 AM, David Long wrote:
>> On 05/05/15 11:48, Will Deacon wrote:
>>> On Tue, May 05, 2015 at 06:14:51AM +0100, David Long wrote:
>>>> On 05/01/15 21:44, William Cohen wrote:
>>>>> Dave Long and I did some additional experimentation to better
>>>>> understand what is condition causes the kernel to sometimes spew:
>>>>>
>>>>> Unexpected kernel single-step exception at EL1
>>>>>
>>>>> The functioncallcount.stp test instruments the entry and return of
>>>>> every function in the mm files, including kfree.  In most cases the
>>>>> arm64 trampoline_probe_handler just determines which return probe
>>>>> instance matches the current conditions, runs the associated handler,
>>>>> and recycles the return probe instance for another use by placing it
>>>>> on a hlist.  However, it is possible that a return probe instance has
>>>>> been set up on function entry and the return probe is unregistered
>>>>> before the return probe instance fires.  In this case kfree is called
>>>>> by the trampoline handler to remove the return probe instances related
>>>>> to the unregistered kretprobe.  This case where the the kprobed kfree
>>>>> is called within the arm64 trampoline_probe_handler function trigger
>>>>> the problem.
>>>>>
>>>>> The kprobe breakpoint for the kfree call from within the
>>>>> trampoline_probe_handler is encountered and started, but things go
>>>>> wrong when attempting the single step on the instruction.
>>>>>
>>>>> It took a while to trigger this problem with the sytemtap testsuite.
>>>>> Dave Long came up with steps that reproduce this more quickly with a
>>>>> probed function that is always called within the trampoline handler.
>>>>> Trying the same on x86_64 doesn't trigger the problem.  It appears
>>>>> that the x86_64 code can handle a single step from within the
>>>>> trampoline_handler.
>>>>>
>>>>
>>>> I'm assuming there are no plans for supporting software breakpoint debug
>>>> exceptions during processing of single-step exceptions, any time soon on
>>>> arm64.  Given that the only solution that I can come with for this is
>>>> instead of making this orphaned kretprobe instance list exist only
>>>> temporarily (in the scope of the kretprobe trampoline handler), make it
>>>> always exist and kfree any items found on it as part of a periodic
>>>> cleanup running outside of the handler context.  I think these changes
>>>> would still all be in archiecture-specific code.  This doesn't feel to
>>>> me like a bad solution.  Does anyone think there is a simpler way out of
>>>> this?
>>>
>>> Just to clarify, is the problem here the software breakpoint exception,
>>> or trying to step the faulting instruction whilst we were already handling
>>> a step?
>>>
>>
>> Sorry for the delay, I got tripped up with some global optimizations that happened when I made more testing changes.  When the kprobes software breakpoint handler for kretprobes is reentered it sets up the single-step and that ends up hitting inside entry.S, apparently in el1_undef.
>>
>>> I think I'd be inclined to keep the code run in debug context to a minimum.
>>> We already can't block there, and the more code we add the more black spots
>>> we end up with in the kernel itself. The alternative would be to make your
>>> kprobes code re-entrant, but that sounds like a nightmare.
>>>
>>> You say this works on x86. How do they handle it? Is the nested probe
>>> on kfree ignored or handled?
>>>
>>
>> Will Cohen's email pointing out x86 does not use a breakpoint for the trampoline handler explains a lot.  I'm experimenting starting with his proposed new trampoline code.  I can't see a reason this can't be made to work and so given everything it doesn't seem interesting to try and understand the failure in reentering the kprobe break handler in any more detail.
>>
>> -dave long
>>
>>
> 
> Hi Dave,
> 
> In some of the previous diagnostic output it looked like things would go wrong
> in the entry.S when the D bit was cleared and the debug interrupts were 
> unmasksed.  I wonder if some of the issue might be due to the starting the 
> kprobe for the trampoline, but leaving things in an odd state when another
> set of krpobe/kretporbes are hit when the trampoline is running.

Hmm, does this mean we have a trouble if a user kprobe handler calls the
function which is probed by other kprobe? Or, is this just a problem
only for kretprobes?

>  As Dave
> mentioned the proposed trampoline patch avoids using a kprobe in the
> trampoline and directly calls the trampoline handler.  Attached is the
> current version of the patch which was able to run the systemtap testsuite.
>  Systemtap does exercise the kprobe/kretprobe infrastructure, but it would
> be good to have additional raw kprobe tests to check that kprobe reentry
> works as expected.

Actually, Will's patch looks like the same thing what I did on x86,
as the kretprobe-booster. So I'm OK for that. But if the above problem
is not solved, we need to fix that, since kprobes can be used from
different sources.

Thank you,

-- 
Masami HIRAMATSU
Linux Technology Research Center, System Productivity Research Dept.
Center for Technology Innovation - Systems Engineering
Hitachi, Ltd., Research & Development Group
E-mail: masami.hiramatsu.pt at hitachi.com
