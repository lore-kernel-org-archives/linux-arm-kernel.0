From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 09 Oct 2013 15:18:15 +0100
Subject: [PATCH 1/2] ARM: KVM: Yield CPU when vcpu executes a WFE
In-Reply-To: <20131009132611.GL3574@redhat.com>
References: <1381160430-11790-1-git-send-email-marc.zyngier@arm.com>
 <1381160430-11790-2-git-send-email-marc.zyngier@arm.com>
 <52F72A87-9CC3-4B38-ACDA-F5EA66FA7375@suse.de> <5252DE5E.6060700@arm.com>
 <1BCAA4EA-CD0A-4E2A-9D22-5B9BD98F2ECD@suse.de>
 <20131007165352.GC9127@redhat.com>
 <169A6E7C-B188-4A4C-B5B7-D2DC94ED70EB@suse.de>
 <20131009132611.GL3574@redhat.com>
Message-ID: <525565A7.1080602@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/10/13 14:26, Gleb Natapov wrote:
> On Wed, Oct 09, 2013 at 03:09:54PM +0200, Alexander Graf wrote:
>>
>> On 07.10.2013, at 18:53, Gleb Natapov <gleb@redhat.com> wrote:
>>
>>> On Mon, Oct 07, 2013 at 06:30:04PM +0200, Alexander Graf wrote:
>>>>
>>>> On 07.10.2013, at 18:16, Marc Zyngier <marc.zyngier@arm.com> wrote:
>>>>
>>>>> On 07/10/13 17:04, Alexander Graf wrote:
>>>>>>
>>>>>> On 07.10.2013, at 17:40, Marc Zyngier <marc.zyngier@arm.com> wrote:
>>>>>>
>>>>>>> On an (even slightly) oversubscribed system, spinlocks are quickly 
>>>>>>> becoming a bottleneck, as some vcpus are spinning, waiting for a 
>>>>>>> lock to be released, while the vcpu holding the lock may not be 
>>>>>>> running at all.
>>>>>>>
>>>>>>> This creates contention, and the observed slowdown is 40x for 
>>>>>>> hackbench. No, this isn't a typo.
>>>>>>>
>>>>>>> The solution is to trap blocking WFEs and tell KVM that we're now
>>>>>>> spinning. This ensures that other vpus will get a scheduling boost,
>>>>>>> allowing the lock to be released more quickly.
>>>>>>>
>>>>>>>> From a performance point of view: hackbench 1 process 1000
>>>>>>>
>>>>>>> 2xA15 host (baseline):	1.843s
>>>>>>>
>>>>>>> 2xA15 guest w/o patch:	2.083s 4xA15 guest w/o patch:	80.212s
>>>>>>>
>>>>>>> 2xA15 guest w/ patch:	2.072s 4xA15 guest w/ patch:	3.202s
>>>>>>
>>>>>> I'm confused. You got from 2.083s when not exiting on spin locks to
>>>>>> 2.072 when exiting on _every_ spin lock that didn't immediately
>>>>>> succeed. I would've expected to second number to be worse rather than
>>>>>> better. I assume it's within jitter, I'm still puzzled why you don't
>>>>>> see any significant drop in performance.
>>>>>
>>>>> The key is in the ARM ARM:
>>>>>
>>>>> B1.14.9: "When HCR.TWE is set to 1, and the processor is in a Non-secure
>>>>> mode other than Hyp mode, execution of a WFE instruction generates a Hyp
>>>>> Trap exception if, ignoring the value of the HCR.TWE bit, conditions
>>>>> permit the processor to suspend execution."
>>>>>
>>>>> So, on a non-overcommitted system, you rarely hit a blocking spinlock,
>>>>> hence not trapping. Otherwise, performance would go down the drain very
>>>>> quickly.
>>>>
>>>> Well, it's the same as pause/loop exiting on x86, but there we have special hardware features to only ever exit after n number of turnarounds. I wonder why we have those when we could just as easily exit on every blocking path.
>>>>
>>> It will hurt performance if vcpu that holds the lock is running.
>>
>> Apparently not so on ARM. At least that's what Marc's numbers are showing. I'm not sure what exactly that means. Basically his logic is "if we spin, the holder must have been preempted". And it seems to work out surprisingly well.

Yes. I basically assume that contention should be rare, and that ending
up in a *blocking* WFE is a sign that we're in thrashing mode already
(no event is pending).

>>
> For not contended locks it make sense. We need to recheck if x86
> assumption is still true there, but x86 lock is ticketing which
> has not only lock holder preemption, but also lock waiter
> preemption problem which make overcommit problem even worse.

Locks are ticketing on ARM as well. But there is one key difference here
with x86 (or at least what I understand of it, which is very close to
none): We only trap if we would have blocked anyway. In our case, it is
almost always better to give up the CPU to someone else rather than
waiting for some event to take the CPU out of sleep.

	M.
-- 
Jazz is not dead. It just smells funny...
