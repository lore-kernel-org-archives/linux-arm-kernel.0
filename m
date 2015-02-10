From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 10 Feb 2015 13:04:30 -0800
Subject: [PATCH v2] ARM: Don't use complete() during __cpu_die
In-Reply-To: <54DA6E92.3090109@codeaurora.org>
References: <1423131270-24047-1-git-send-email-k.kozlowski@samsung.com>
 <20150205105035.GL8656@n2100.arm.linux.org.uk>
 <20150205142918.GA10634@linux.vnet.ibm.com>
 <20150205161100.GQ8656@n2100.arm.linux.org.uk>
 <54D95DB8.9010308@codeaurora.org> <20150210151416.GD9432@leverpostej>
 <54DA6E92.3090109@codeaurora.org>
Message-ID: <54DA725E.6080305@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/10/15 12:48, Stephen Boyd wrote:
> On 02/10/15 07:14, Mark Rutland wrote:
>> On Tue, Feb 10, 2015 at 01:24:08AM +0000, Stephen Boyd wrote:
>>> On 02/05/15 08:11, Russell King - ARM Linux wrote:
>>>> On Thu, Feb 05, 2015 at 06:29:18AM -0800, Paul E. McKenney wrote:
>>>>> Works for me, assuming no hidden uses of RCU in the IPI code.  ;-)
>>>> Sigh... I kind'a new it wouldn't be this simple.  The gic code which
>>>> actually raises the IPI takes a raw spinlock, so it's not going to be
>>>> this simple - there's a small theoretical window where we have taken
>>>> this lock, written the register to send the IPI, and then dropped the
>>>> lock - the update to the lock to release it could get lost if the
>>>> CPU power is quickly cut at that point.
>>> Hm.. at first glance it would seem like a similar problem exists with
>>> the completion variable. But it seems that we rely on the call to
>>> complete() fom the dying CPU to synchronize with wait_for_completion()
>>> on the killing CPU via the completion's wait.lock.
>>>
>>> void complete(struct completion *x)
>>> {
>>>         unsigned long flags;
>>>
>>>         spin_lock_irqsave(&x->wait.lock, flags);
>>>         x->done++;
>>>         __wake_up_locked(&x->wait, TASK_NORMAL, 1);
>>>         spin_unlock_irqrestore(&x->wait.lock, flags);
>>> }
>>>
>>> and
>>>
>>> static inline long __sched
>>> do_wait_for_common(struct completion *x,
>>>                   long (*action)(long), long timeout, int state)
>>>                         ...
>>> 			spin_unlock_irq(&x->wait.lock);
>>> 			timeout = action(timeout);
>>> 			spin_lock_irq(&x->wait.lock);
>>>
>>>
>>> so the power can't really be cut until the killing CPU sees the lock
>>> released either explicitly via the second cache flush in cpu_die() or
>>> implicitly via hardware.
>> That sounds about right, though surely cache flush is irrelevant w.r.t.
>> publishing of the unlock? The dsb(ishst) in the unlock path will ensure
>> that the write is visibile prior to the second flush_cache_louis().
> Ah right. I was incorrectly thinking that the CPU had already disabled
> coherency at this point.
>
>> That said, we _do_ need to flush the cache prior to the CPU being
>> killed, or we can lose any (shared) dirty cache lines the CPU owns. In
>> the presence of dirty cacheline migration we need to be sure the CPU to
>> be killed doesn't acquire any lines prior to being killed (i.e. its
>> caches need to be off and flushed). Given that I don't think it's
>> feasible to perform an IPI.
> The IPI/completion sounds nice because it allows the killing CPU to
> schedule and do other work until the dying CPU notifies that it's almost
> dead.
>
>> I think we need to move the synchronisation down into the
>> cpu_ops::{cpu_die,cpu_kill} implementations, so that we can have the
>> dying CPU signal readiness after it has disabled and flushed its caches.
>>
>> If the CPU can kill itself and we can query the state of the CPU, then
>> the dying CPU needs to do nothing, and cpu_kill can just poll until it
>> is dead. If the CPU needs to be killed from another CPU, it can update a
>> (cacheline-padded) percpu variable that cpu_kill can poll (cleaning
>> before each read).
> How about a hybrid approach where we send the IPI from generic cpu_die()
> and then do the cacheline-padded bit poll + invalidate and bit set? That
> way we get the benefit of not doing that poll until we really need to
> and if we need to do it at all.
>
> cpu_kill | cpu_die | IPI | bit poll 
> ---------+---------+-----+----------
>     Y    |    Y    |  Y  |   N
>     N    |    Y    |  Y  |   Y
>     Y    |    N    |  ?  |   ?    <-- Is this a valid configuration?
>     N    |    N    |  N  |   N    <-- Hotplug should be disabled
>
>
> If the hardware doesn't have a synchronization method in row 1 we can
> expose the bit polling functionality to the ops so that they can set and
> poll the bit. It looks like rockchip would need this because we just
> pull the power in cpu_kill without any synchronization. Unfortunately
> this is starting to sound like a fairly large patch to backport.
>
> Aside: For that last row we really should be setting cpu->hotpluggable
> in struct cpu based on what cpu_ops::cpu_disable returns (from what I
> can tell we use that op to indicate if a CPU can be hotplugged).
>

There's a patch for that (tm).

----8<----

From: Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH] ARM: smp: Only expose /sys/.../cpuX/online if hotpluggable

Writes to /sys/.../cpuX/online fail if we determine the platform
doesn't support hotplug for that CPU. Let's figure this out
befoer we make the sysfs nodes so that the online file doesn't
even exist if it's not possible to hotplug the CPU.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/include/asm/smp.h |  6 ++++++
 arch/arm/kernel/setup.c    |  2 +-
 arch/arm/kernel/smp.c      | 11 ++++-------
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/arm/include/asm/smp.h b/arch/arm/include/asm/smp.h
index 18f5a554134f..9f82430efd59 100644
--- a/arch/arm/include/asm/smp.h
+++ b/arch/arm/include/asm/smp.h
@@ -123,4 +123,10 @@ struct of_cpu_method {
  */
 extern void smp_set_ops(struct smp_operations *);
 
+#ifdef CONFIG_HOTPLUG_CPU
+extern int platform_can_hotplug_cpu(unsigned int cpu);
+#else
+static inline int platform_can_hotplug_cpu(unsigned int cpu) { return 0; }
+#endif
+
 #endif /* ifndef __ASM_ARM_SMP_H */
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 715ae19bc7c8..c61c09defc78 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -974,7 +974,7 @@ static int __init topology_init(void)
 
 	for_each_possible_cpu(cpu) {
 		struct cpuinfo_arm *cpuinfo = &per_cpu(cpu_data, cpu);
-		cpuinfo->cpu.hotpluggable = 1;
+		cpuinfo->cpu.hotpluggable = platform_can_hotplug_cpu(cpu);
 		register_cpu(&cpuinfo->cpu, cpu);
 	}
 
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index fe0386c751b2..4d213b24db60 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -174,18 +174,19 @@ static int platform_cpu_kill(unsigned int cpu)
 	return 1;
 }
 
-static int platform_cpu_disable(unsigned int cpu)
+int platform_can_hotplug_cpu(unsigned int cpu)
 {
 	if (smp_ops.cpu_disable)
-		return smp_ops.cpu_disable(cpu);
+		return smp_ops.cpu_disable(cpu) ? 0 : 1;
 
 	/*
 	 * By default, allow disabling all CPUs except the first one,
 	 * since this is special on a lot of platforms, e.g. because
 	 * of clock tick interrupts.
 	 */
-	return cpu == 0 ? -EPERM : 0;
+	return cpu == 0 ? 0 : 1;
 }
+
 /*
  * __cpu_disable runs on the processor to be shutdown.
  */
@@ -194,10 +195,6 @@ int __cpu_disable(void)
 	unsigned int cpu = smp_processor_id();
 	int ret;
 
-	ret = platform_cpu_disable(cpu);
-	if (ret)
-		return ret;
-
 	/*
 	 * Take this CPU offline.  Once we clear this, we can't return,
 	 * and we must not schedule until we're ready to give up the cpu.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
