From: morten.rasmussen@arm.com (Morten Rasmussen)
Date: Fri, 21 Nov 2014 12:35:44 +0000
Subject: [PATCH v9 04/10] sched: Make sched entity usage tracking
 scale-invariant
In-Reply-To: <1415033687-23294-5-git-send-email-vincent.guittot@linaro.org>
References: <1415033687-23294-1-git-send-email-vincent.guittot@linaro.org>
 <1415033687-23294-5-git-send-email-vincent.guittot@linaro.org>
Message-ID: <20141121123544.GE23177@e105550-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 03, 2014 at 04:54:41PM +0000, Vincent Guittot wrote:
> From: Morten Rasmussen <morten.rasmussen@arm.com>
> 
> Apply frequency scale-invariance correction factor to usage tracking.

s/usage/utilization/

> Each segment of the running_load_avg geometric series is now scaled by the
> current frequency so the utilization_avg_contrib of each entity will be

s/entity/sched_entity/

> invariant with frequency scaling. As a result, utilization_load_avg which is
> the sum of utilization_avg_contrib, becomes invariant too. So the usage level

s/sum of utilization_avg_contrib/sum of sched_entity
utilization_avg_contribs/

s/usage/utilization/

> that is returned by get_cpu_usage, stays relative to the max frequency as the
> cpu_capacity which is is compared against.

The last bit doesn't parse right. '... Maybe it is better to drop
the reference to get_cpu_usage which hasn't been defined yet and rewrite
the thing to:

Apply frequency scale-invariance correction factor to utilization
tracking. Each segment of the running_load_avg geometric series is now
scaled by the current frequency so the utilization_avg_contrib of each
entity will be invariant with frequency scaling. As a result,
utilization_load_avg which is the sum of sched_entity
utilization_avg_contribs becomes invariant too and is now relative to
the max utilization at the max frequency (=cpu_capacity).

I think we should add:

arch_scale_freq_capacity() is reintroduced to provide the frequency
compensation scaling factor.

> Then, we want the keep the load tracking values in a 32bits type, which implies

s/Then, we/We/
