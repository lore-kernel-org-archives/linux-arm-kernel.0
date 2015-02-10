From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 10 Feb 2015 12:48:18 -0800
Subject: [PATCH v2] ARM: Don't use complete() during __cpu_die
In-Reply-To: <20150210151416.GD9432@leverpostej>
References: <1423131270-24047-1-git-send-email-k.kozlowski@samsung.com>
 <20150205105035.GL8656@n2100.arm.linux.org.uk>
 <20150205142918.GA10634@linux.vnet.ibm.com>
 <20150205161100.GQ8656@n2100.arm.linux.org.uk>
 <54D95DB8.9010308@codeaurora.org> <20150210151416.GD9432@leverpostej>
Message-ID: <54DA6E92.3090109@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/10/15 07:14, Mark Rutland wrote:
> On Tue, Feb 10, 2015 at 01:24:08AM +0000, Stephen Boyd wrote:
>> On 02/05/15 08:11, Russell King - ARM Linux wrote:
>>> On Thu, Feb 05, 2015 at 06:29:18AM -0800, Paul E. McKenney wrote:
>>>> Works for me, assuming no hidden uses of RCU in the IPI code.  ;-)
>>> Sigh... I kind'a new it wouldn't be this simple.  The gic code which
>>> actually raises the IPI takes a raw spinlock, so it's not going to be
>>> this simple - there's a small theoretical window where we have taken
>>> this lock, written the register to send the IPI, and then dropped the
>>> lock - the update to the lock to release it could get lost if the
>>> CPU power is quickly cut at that point.
>> Hm.. at first glance it would seem like a similar problem exists with
>> the completion variable. But it seems that we rely on the call to
>> complete() fom the dying CPU to synchronize with wait_for_completion()
>> on the killing CPU via the completion's wait.lock.
>>
>> void complete(struct completion *x)
>> {
>>         unsigned long flags;
>>
>>         spin_lock_irqsave(&x->wait.lock, flags);
>>         x->done++;
>>         __wake_up_locked(&x->wait, TASK_NORMAL, 1);
>>         spin_unlock_irqrestore(&x->wait.lock, flags);
>> }
>>
>> and
>>
>> static inline long __sched
>> do_wait_for_common(struct completion *x,
>>                   long (*action)(long), long timeout, int state)
>>                         ...
>> 			spin_unlock_irq(&x->wait.lock);
>> 			timeout = action(timeout);
>> 			spin_lock_irq(&x->wait.lock);
>>
>>
>> so the power can't really be cut until the killing CPU sees the lock
>> released either explicitly via the second cache flush in cpu_die() or
>> implicitly via hardware.
> That sounds about right, though surely cache flush is irrelevant w.r.t.
> publishing of the unlock? The dsb(ishst) in the unlock path will ensure
> that the write is visibile prior to the second flush_cache_louis().

Ah right. I was incorrectly thinking that the CPU had already disabled
coherency at this point.

>
> That said, we _do_ need to flush the cache prior to the CPU being
> killed, or we can lose any (shared) dirty cache lines the CPU owns. In
> the presence of dirty cacheline migration we need to be sure the CPU to
> be killed doesn't acquire any lines prior to being killed (i.e. its
> caches need to be off and flushed). Given that I don't think it's
> feasible to perform an IPI.

The IPI/completion sounds nice because it allows the killing CPU to
schedule and do other work until the dying CPU notifies that it's almost
dead.

>
> I think we need to move the synchronisation down into the
> cpu_ops::{cpu_die,cpu_kill} implementations, so that we can have the
> dying CPU signal readiness after it has disabled and flushed its caches.
>
> If the CPU can kill itself and we can query the state of the CPU, then
> the dying CPU needs to do nothing, and cpu_kill can just poll until it
> is dead. If the CPU needs to be killed from another CPU, it can update a
> (cacheline-padded) percpu variable that cpu_kill can poll (cleaning
> before each read).

How about a hybrid approach where we send the IPI from generic cpu_die()
and then do the cacheline-padded bit poll + invalidate and bit set? That
way we get the benefit of not doing that poll until we really need to
and if we need to do it at all.

cpu_kill | cpu_die | IPI | bit poll 
---------+---------+-----+----------
    Y    |    Y    |  Y  |   N
    N    |    Y    |  Y  |   Y
    Y    |    N    |  ?  |   ?    <-- Is this a valid configuration?
    N    |    N    |  N  |   N    <-- Hotplug should be disabled


If the hardware doesn't have a synchronization method in row 1 we can
expose the bit polling functionality to the ops so that they can set and
poll the bit. It looks like rockchip would need this because we just
pull the power in cpu_kill without any synchronization. Unfortunately
this is starting to sound like a fairly large patch to backport.

Aside: For that last row we really should be setting cpu->hotpluggable
in struct cpu based on what cpu_ops::cpu_disable returns (from what I
can tell we use that op to indicate if a CPU can be hotplugged).

Double Aside: It seems that exynos has a bug with coherency.
exynos_cpu_die() calls v7_exit_coherency_flush() and then calls
exynos_cpu_power_down() which may call of_machine_is_compatible() and
that function will grab and release a kref which uses ldrex/strex for
atomics after we've disabled coherency in v7_exit_coherency_flush().

>> Maybe we can do the same thing here by using a
>> spinlock for synchronization between the IPI handler and the dying CPU?
>> So lock/unlock around the IPI sending from the dying CPU and then do a
>> lock/unlock on the killing CPU before continuing.
>>
>> It would be nice if we didn't have to do anything at all though so
>> perhaps we can make it a nop on configs where there isn't a big little
>> switcher. Yeah it's some ugly coupling between these two pieces of code,
>> but I'm not sure how we can do better.
> I'm missing something here. What does the switcher have to do with this?

The switcher is the reason we have a spinlock in gic_raise_softirq().
That's the problem that Russell was mentioning.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
