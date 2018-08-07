From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 7 Aug 2018 13:12:03 +0100
Subject: [PATCH] arm64: Trap WFI executed in userspace
In-Reply-To: <20180807103054.GB9097@e103592.cambridge.arm.com>
References: <20180807093326.5090-1-marc.zyngier@arm.com>
 <20180807100437.GA9097@e103592.cambridge.arm.com>
 <9af8bb9a-7c6c-2560-5965-118dfadf8141@arm.com>
 <20180807103054.GB9097@e103592.cambridge.arm.com>
Message-ID: <da5d1650-fcd8-83ec-bd4c-02f236163776@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/08/18 11:30, Dave Martin wrote:
> On Tue, Aug 07, 2018 at 11:24:34AM +0100, Marc Zyngier wrote:
>> On 07/08/18 11:05, Dave Martin wrote:
>>> On Tue, Aug 07, 2018 at 10:33:26AM +0100, Marc Zyngier wrote:
>>>> It recently came to light that userspace can execute WFI, and that
>>>> the arm64 kernel doesn trap this event. This sounds rather benign,
>>>> but the kernel should decide when it wants to wait for an interrupt,
>>>> and not userspace.
>>>>
>>>> Let's trap WFI and treat it as a way to yield the CPU to another
>>>> process.
>>>
>>> This doesn't amount to a justification.
>>>
>>> If the power controller is unexpectedly left in a bad state so that
>>> WFI will do something nasty to a cpu that may enter userspace, then we
>>> probably have bigger problems.
>>>
>>> So, maybe it really is pretty harmless to let userspace execute this.
>>
>> Or not. It is also a very good way for userspace to find out when an
>> interrupt gets delivered and start doing all kind of probing on the
>> kernel. The least the userspace knows about that, the better I feel.
> 
> Possibly.  I suspect there are other ways to guess pretty accurately
> when an interrupt occurs, but WFI allows greater precision.

...unless you're running in a VM and it traps to KVM anyway ;)

>>> I can't think of a legitimate reason for userspace to execute WFI
>>> however.  Userspace doesn't have interrupts under Linux, so it makes
>>> no sense to wait for one.
>>>
>>> Have we seen anybody using WFI in userspace?  It may be cleaner to
>>> map this to SIGILL rather than be permissive and regret it later.
>>
>> I couldn't find any user, and I'm happy to just send userspace to hell
>> in that case. But it could also been said that since it was never
>> prevented, it is a de-facto ABI.
> 
> Agreed.  I wonder whether it's sufficient to have this mapping to SIGILL
> in -next for a while and see whether anybody complains.

I think we'd have to avoid that for compat, though, since v7 code would 
have the expectation that WFI can't be trapped by the kernel at all. 
Personally I'm in favour of this patch as-is, since the architectural 
intent of the instruction is essentially "I've got nothing better to do 
right now than wait for something to happen", so treating it as a poor 
man's sched_vield() stays close to that while mitigating the potential 
nefarious and/or minor DoS implications of letting it architecturally 
execute.

Robin.
