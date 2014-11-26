From: dietmar.eggemann@arm.com (Dietmar Eggemann)
Date: Wed, 26 Nov 2014 16:05:13 +0000
Subject: [PATCH v9 04/10] sched: Make sched entity usage tracking
 scale-invariant
In-Reply-To: <20141121123544.GE23177@e105550-lin.cambridge.arm.com>
References: <1415033687-23294-1-git-send-email-vincent.guittot@linaro.org>
 <1415033687-23294-5-git-send-email-vincent.guittot@linaro.org>
 <20141121123544.GE23177@e105550-lin.cambridge.arm.com>
Message-ID: <5475FA39.6090801@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/11/14 12:35, Morten Rasmussen wrote:
> On Mon, Nov 03, 2014 at 04:54:41PM +0000, Vincent Guittot wrote:
>> From: Morten Rasmussen <morten.rasmussen@arm.com>
>>

Could we rename this patch to 'sched: Make usage tracking frequency
scale-invariant'?

The reason is, since we scale sched_avg::running_avg_sum according to
the cpu frequency, not only sched_entity but also rq is affected (both
contain sched_avg) and cfs_rq too since cfs_rq::utilization_load_avg is
\sum (sched_entity::sched_avg::utilization_avg_contrib)

And so far we're only considering frequency scale-invariance and not cpu
(or uArch) scale-invariance for the utilization/usage related per-entity
load tracking bits.

>> Apply frequency scale-invariance correction factor to usage tracking.
> 
> s/usage/utilization/
> 
>> Each segment of the running_load_avg geometric series is now scaled by the
>> current frequency so the utilization_avg_contrib of each entity will be
> 
> s/entity/sched_entity/
> 
>> invariant with frequency scaling. As a result, utilization_load_avg which is
>> the sum of utilization_avg_contrib, becomes invariant too. So the usage level
> 
> s/sum of utilization_avg_contrib/sum of sched_entity
> utilization_avg_contribs/
> 
> s/usage/utilization/
> 
>> that is returned by get_cpu_usage, stays relative to the max frequency as the
>> cpu_capacity which is is compared against.
> 
> The last bit doesn't parse right. '... Maybe it is better to drop
> the reference to get_cpu_usage which hasn't been defined yet and rewrite
> the thing to:
> 
> Apply frequency scale-invariance correction factor to utilization
> tracking. Each segment of the running_load_avg geometric series is now

s/running_load_avg/running_avg_sum

Couldn't find running_load_avg in the current code.

What about using sched_avg::running_avg_sum instead of running_avg_sum?
At least for me it is very complicated to distinguish the different
per-entity load tracking data elements on the various scheduler data
structures (like rq, se, cfs_rq) when I read per-entity load tracking
related patch header.

> scaled by the current frequency so the utilization_avg_contrib of each
> entity will be invariant with frequency scaling. As a result,
> utilization_load_avg which is the sum of sched_entity
> utilization_avg_contribs becomes invariant too and is now relative to
> the max utilization at the max frequency (=cpu_capacity).

max frequency of _the_ cpu. It does not have to be the max frequency of
the system though.
The difference between the max. frequencies between the cpus of the
system is part of the cpu invariant scaling ('cpu' equal to 'uarch' plus
'max frequency in the system'). See 'clock-frequency' dtb property of
node cpu in arch/arm/kernel/topology.c. Frequency scale invariance is
about DVFS and this is per cpu.

> 
> I think we should add:
> 
> arch_scale_freq_capacity() is reintroduced to provide the frequency
> compensation scaling factor.
> 
>> Then, we want the keep the load tracking values in a 32bits type, which implies
> 
> s/Then, we/We/
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
