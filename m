From: eric.dumazet@gmail.com (Eric Dumazet)
Date: Fri, 10 Dec 2010 18:18:20 +0100
Subject: [BUG] 2.6.37-rc3 massive interactivity regression on ARM
In-Reply-To: <1291988866.6803.171.camel@twins>
References: <20101208142814.GE9777@n2100.arm.linux.org.uk>
	<1291851079-27061-1-git-send-email-venki@google.com>
	<1291899120.29292.7.camel@twins>
	<AANLkTikd3X4pLs5De-LO6=XD+JqUz3-Ku7YM8+0-oK8t@mail.gmail.com>
	<1291917330.6803.7.camel@twins>
	<AANLkTin+eO_jPceSOHL4e7vqd+tf0ZCMHJ-USoz8aZL1@mail.gmail.com>
	<1291920939.6803.38.camel@twins>
	<AANLkTim+v21RpWobdw6exEbazDJwm4JjemPVB2+3PuRJ@mail.gmail.com>
	<1291936593.13513.3.camel@laptop>
	<AANLkTi=_qf8NAgj2HHMP0qG-ibnH-726NzoXbxd-bS1N@mail.gmail.com>
	<1291975704.6803.59.camel@twins>  <1291987065.6803.151.camel@twins>
	<1291987635.6803.161.camel@twins>  <1291988866.6803.171.camel@twins>
Message-ID: <1292001500.3580.268.camel@edumazet-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le vendredi 10 d?cembre 2010 ? 14:47 +0100, Peter Zijlstra a ?crit :
> Full patch..

> unt_system_vtime(struct task_struct *curr)
>  {
>  	unsigned long flags;
> +	s64 delta;
>  	int cpu;
> -	u64 now, delta;
>  
>  	if (!sched_clock_irqtime)
>  		return;
>  
>  	local_irq_save(flags);
> -
>  	cpu = smp_processor_id();
> -	now = sched_clock_cpu(cpu);
> -	delta = now - per_cpu(irq_start_time, cpu);
> -	per_cpu(irq_start_time, cpu) = now;
> -	/*
> -	 * We do not account for softirq time from ksoftirqd here.
> -	 * We want to continue accounting softirq time to ksoftirqd thread
> -	 * in that case, so as not to confuse scheduler with a special task
> -	 * that do not consume any time, but still wants to run.
> -	 */
> +	delta = sched_clock_cpu(cpu) - per_cpu(irq_start_time, cpu);
> +	per_cpu(irq_start_time, cpu) += delta;

We should add some checkpatch warning to any new per_cpu() use.


	delta = sched_clock_cpu(cpu) - __this_cpu_read(irq_start_time);
	__this_cpu_add(irq_start_time, delta);



Also irq_time_write_begin() and irq_time_write_end() could be faster
(called for current cpu)

static inline void irq_time_write_begin(void)
{
	__this_cpu_inc(irq_time_seq.sequence);
	smp_wmb();
}
 
static inline void irq_time_write_end(void)
{
	smp_wmb();
	__this_cpu_inc(irq_time_seq.sequence);
}
 
