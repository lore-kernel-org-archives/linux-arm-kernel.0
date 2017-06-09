From: john.garry@huawei.com (John Garry)
Date: Fri, 9 Jun 2017 17:09:25 +0100
Subject: [PATCH v8 6/9] drivers: perf: hisi: Add support for Hisilicon
 Djtag driver
In-Reply-To: <20170609154425.GH10665@leverpostej>
References: <1495457312-237127-1-git-send-email-zhangshaokun@hisilicon.com>
 <20170608163519.GA19643@leverpostej>
 <8666a0fa-126d-e4a3-ac4b-7962f5d79942@huawei.com>
 <20170609154425.GH10665@leverpostej>
Message-ID: <e120463d-2936-90ec-8aad-f0f7be558054@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

> What happens if the lock is already held by an agent in that case?
>
> Does the FW block until the lock is released?

The FW must also honour the contract - it must also block until the lock 
is available.

This may sound bad, but, in reality, probablity of simultaneous perf and 
hotplug access is very low.

>
> Can you elaborate on CPU hotplug? Which CPU is performing the
> maintenance in this scenario, and when? Can this block other CPUs until
> the lock is released?
>
> What happens if another agent pokes the djtag (without acquiring the
> lock) while FW is doing this? Can this result in issues on the secure
> side?
>

I need to check on this.

> [...]
>
>>> Can you explain how the locking scheme works? e.g. is this an
>>> advisory software-only policy, or does the hardware prohibit accesses
>> >from other agents somehow?
>>
>> The locking scheme is a software solution to spinlock. It's uses
>> djtag module select register as the spinlock flag, to avoid using
>> some shared memory.
>>
>> The tricky part is that there is no test-and-set hardware support,
>> so we use this algorithm:
>> - precondition: flag initially set unlocked
>>
>> a. agent reads flag
>>     - if not unlocked, continues to poll
>>     - otherwise, writes agent's unique lock value to flag
>> b. agent waits defined amount of time *uninterrupted* and then
>> checks the flag
>>     - if it is unchanged, it has the lock -> continue
>>     - if it is changed, it means other agent is trying to access the
>> lock and got it, so it goes back to a.
>> c. has lock, so safe to access djtag
>> d. to unlock, release by writing "unlock" value to flag
>
> This does not sound safe to me. There's always the potential for a race,
> no matter how long an agent waits.
>
>>> What happens if the kernel takes the lock, but doesn't release it?
>>
>> This should not happen. We use spinlock_irqsave() when locking.
>> However I have noted that we can BUG if djtag access timeout, so we
>> need to release the lock at this point. I don't think the code
>> handles this properly now.
>
> I was worried aobut BUG() and friends, and also preempt kernels.
>
> It doesn't sound like it's possible to make this robust.
>
>>> What happens if UEFI takes the lock, but doesn't release it?
>>
>> Again, we would not expect this to happen; but, if it does, Kernel
>> access should timeout.
>
> ... which they do not, in this patch series, as far as I can tell.
>

I noticed this also.

> This doesn't sound safe at all. :/

Right, we need to consider if this will fly at all.

At this point, we would rather concentrate on our new chipset, which is 
based on same perf HW architecture (so much code reuse), but uses 
directly mapped registers and *no djtag* - in this, most of the upstream 
effort from all parties is not wasted.

Please advise.

Much appreciated,
John

>
> Thanks,
> Mark.
>
> .
>
