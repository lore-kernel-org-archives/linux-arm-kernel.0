From: venki@google.com (Venkatesh Pallipadi)
Date: Thu, 9 Dec 2010 15:35:11 -0800
Subject: [BUG] 2.6.37-rc3 massive interactivity regression on ARM
In-Reply-To: <1291936593.13513.3.camel@laptop>
References: <20101208142814.GE9777@n2100.arm.linux.org.uk>
	<1291851079-27061-1-git-send-email-venki@google.com>
	<1291899120.29292.7.camel@twins>
	<AANLkTikd3X4pLs5De-LO6=XD+JqUz3-Ku7YM8+0-oK8t@mail.gmail.com>
	<1291917330.6803.7.camel@twins>
	<AANLkTin+eO_jPceSOHL4e7vqd+tf0ZCMHJ-USoz8aZL1@mail.gmail.com>
	<1291920939.6803.38.camel@twins>
	<AANLkTim+v21RpWobdw6exEbazDJwm4JjemPVB2+3PuRJ@mail.gmail.com>
	<1291936593.13513.3.camel@laptop>
Message-ID: <AANLkTi=_qf8NAgj2HHMP0qG-ibnH-726NzoXbxd-bS1N@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 9, 2010 at 3:16 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Thu, 2010-12-09 at 14:21 -0800, Venkatesh Pallipadi wrote:
>> This should mostly work. There would be a small window there on
>> rq->clock=sched_clock_cpu() and system_vtime doing sched_clock_cpu()
>> and also the overhead of doing this everytime when this going
>> backwards may happen rarely.
>
> Right, so something like the below removes that tiny race by re-using
> rq->clock as now. It also removes some overhead by removing the IRQ
> fudging (we already know IRQs are disabled).
>
> It does have a few extra branches (2 afaict) than your monotonicity path
> had, but it seems to me this approach is slightly more accurate.
>

Looks fine.

Just to make sure, update_rq_clock() always gets called on current
CPU. Right? The pending patches I have optimizes
account_system_vtime() to use this_cpu_write and friends. Want to make
sure this change will still keep that optimization relevant.


> ---
> Index: linux-2.6/kernel/sched.c
> ===================================================================
> --- linux-2.6.orig/kernel/sched.c
> +++ linux-2.6/kernel/sched.c
> @@ -1813,19 +1813,10 @@ void disable_sched_clock_irqtime(void)
> ? ? ? ?sched_clock_irqtime = 0;
> ?}
>
> -void account_system_vtime(struct task_struct *curr)
> +static void __account_system_vtime(int cpu, u64 now)
> ?{
> - ? ? ? unsigned long flags;
> - ? ? ? int cpu;
> - ? ? ? u64 now, delta;
> + ? ? ? s64 delta;
>
> - ? ? ? if (!sched_clock_irqtime)
> - ? ? ? ? ? ? ? return;
> -
> - ? ? ? local_irq_save(flags);
> -
> - ? ? ? cpu = smp_processor_id();
> - ? ? ? now = sched_clock_cpu(cpu);
> ? ? ? ?delta = now - per_cpu(irq_start_time, cpu);
> ? ? ? ?per_cpu(irq_start_time, cpu) = now;
> ? ? ? ?/*
> @@ -1836,16 +1827,36 @@ void account_system_vtime(struct task_st
> ? ? ? ? */
> ? ? ? ?if (hardirq_count())
> ? ? ? ? ? ? ? ?per_cpu(cpu_hardirq_time, cpu) += delta;
> - ? ? ? else if (in_serving_softirq() && !(curr->flags & PF_KSOFTIRQD))
> + ? ? ? else if (in_serving_softirq() && !(current->flags & PF_KSOFTIRQD))
> ? ? ? ? ? ? ? ?per_cpu(cpu_softirq_time, cpu) += delta;
> +}
> +
> +void account_system_vtime(struct task_struct *curr)
> +{
> + ? ? ? unsigned long flags;
> + ? ? ? u64 now;
> + ? ? ? int cpu;
> +
> + ? ? ? if (!sched_clock_irqtime)
> + ? ? ? ? ? ? ? return;
> +
> + ? ? ? local_irq_save(flags);
> +
> + ? ? ? cpu = smp_processor_id();
> + ? ? ? now = sched_clock_cpu(cpu);
> + ? ? ? __account_system_vtime(cpu, now);
>
> ? ? ? ?local_irq_restore(flags);
> ?}
> ?EXPORT_SYMBOL_GPL(account_system_vtime);
>
> -static u64 irq_time_cpu(int cpu)
> +static u64 irq_time_cpu(struct rq *rq)
> ?{
> - ? ? ? account_system_vtime(current);
> + ? ? ? int cpu = cpu_of(rq);
> +
> + ? ? ? if (sched_clock_irqtime)
> + ? ? ? ? ? ? ? __account_system_vtime(cpu, rq->clock);
> +
> ? ? ? ?return per_cpu(cpu_softirq_time, cpu) + per_cpu(cpu_hardirq_time, cpu);
> ?}
>
> @@ -1853,7 +1864,7 @@ static void update_rq_clock_task(struct
> ?{
> ? ? ? ?s64 irq_delta;
>
> - ? ? ? irq_delta = irq_time_cpu(cpu_of(rq)) - rq->prev_irq_time;
> + ? ? ? irq_delta = irq_time_cpu(rq) - rq->prev_irq_time;
> ? ? ? ?rq->prev_irq_time += irq_delta;
>
> ? ? ? ?delta -= irq_delta;
>
>
