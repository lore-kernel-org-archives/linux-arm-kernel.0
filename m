From: raghavendra.kt@linux.vnet.ibm.com (Raghavendra K T)
Date: Mon, 29 Jul 2013 13:05:48 +0530
Subject: [PATCH 3/4] arm64: KVM: let other tasks run when hitting WFE
In-Reply-To: <20130728205525.GA14863@cbox>
References: <1374242035-13199-1-git-send-email-marc.zyngier@arm.com>
 <1374242035-13199-4-git-send-email-marc.zyngier@arm.com>
 <CAC4Lta17bmNjBck6LzziBeU0Xc36F1Jms2tQPv6+GaXvik6Wyg@mail.gmail.com>
 <CAMJs5B8Sg1MPHPsRV75mmagnYxkhzA0MKWVkwW2y0WdDVWTSxQ@mail.gmail.com>
 <51ED3A66.4050407@linux.vnet.ibm.com> <20130728205525.GA14863@cbox>
Message-ID: <51F61B54.9030207@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/29/2013 02:25 AM, Christoffer Dall wrote:
> On Mon, Jul 22, 2013 at 07:27:58PM +0530, Raghavendra K T wrote:
>> On 07/22/2013 06:21 PM, Christoffer Dall wrote:
>>> On 22 July 2013 10:53, Raghavendra KT <raghavendra.kt.linux@gmail.com> wrote:
>>>> On Fri, Jul 19, 2013 at 7:23 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>>>>> So far, when a guest executes WFE (like when waiting for a spinlock
>>>>> to become unlocked), we don't do a thing and let it run uninterrupted.
>>>>>
>>>>> Another option is to trap a blocking WFE and offer the opportunity
>>>>> to the scheduler to switch to another task, potentially giving the
>>>>> vcpu holding the spinlock a chance to run sooner.
>>>>>
>>>>
>>>> Idea looks to be correct from my experiments on x86. It does bring some
>>>> percentage of benefits in overcommitted guests. Infact,
>>>>
>>>> https://lkml.org/lkml/2013/7/22/41 tries to do the same thing for x86.
>>>> (this results in using ple handler heuristics in vcpu_block pach).
>>>
>>> What about the adverse effect in the non-overcommitted case?
>>>
>>
>> Ideally is should fail to schedule any other task and comeback to halt
>> loop. This should not hurt AFAICS. But I agree that, numbers needed to
>> support this argument.
>
> So if two VCPUs are scheduled on two PCPUs and the waiting VCPU would
> normally wait, say, 1000 cycles to grab the lock, the latency for
> grabbing the lock will now be (at least) a couple of thousand cycles
> even for a tight switch back into the host and back into the guest (on
> currently available hardware).
>

I agree that unnecessary vmexits increase the latency.

>>
>> For x86, I had seen no side effects with the experiments.
>>
>
> I suspect some workloads on x86 would indeed show some side effects, but
> much smaller on ARM, since x86 has a much more hardware-optimized VMEXIT
> cycle time on relatively recent CPUs.
>

I think I should have clearly explained what was tried in x86. sorry
for confusion.

in x86, what I tried was in the halt handler,
instead of doing simple schedule() do intelligent directed yields, using
already available ple handler.
ple handler does have some undercommit detection logic to return back
also the halt() was triggered by guest only after spinning enough in
pv-spinlocks (which was not normal otherwise).
So there was around 2-3% improvement overall in x86.
But yes, I am not expert to comment on arm ecosystem , though I liked 
the idea. and finally only numbers should prove as always.. :).
