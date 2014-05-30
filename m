From: dietmar.eggemann@arm.com (Dietmar Eggemann)
Date: Fri, 30 May 2014 15:04:32 +0100
Subject: [PATCH v2 04/11] sched: Allow all archs to set the power_orig
In-Reply-To: <1400860385-14555-5-git-send-email-vincent.guittot@linaro.org>
References: <1400860385-14555-1-git-send-email-vincent.guittot@linaro.org>
 <1400860385-14555-5-git-send-email-vincent.guittot@linaro.org>
Message-ID: <53888FF0.4020403@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/05/14 16:52, Vincent Guittot wrote:
> power_orig is only changed for system with a SMT sched_domain level in order to
> reflect the lower capacity of CPUs. Heterogenous system also have to reflect an
> original capacity that is different from the default value.
> 
> Create a more generic function arch_scale_cpu_power that can be also used by
> non SMT platform to set power_orig.
> 
> The weak behavior of arch_scale_cpu_power is the previous SMT one in order to
> keep backward compatibility in the use of power_orig.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

As you know, besides uarch scaled cpu power for HMP, freq scaled cpu
power is important for energy-aware scheduling to achieve freq scale
invariance for task load.

I know that your patch-set is not about introducing freq scaled cpu
power, but we were discussing how this can be achieved w/ your patch-set
in place, so maybe you can share your opinion regarding the easiest way
to achieve freq scale invariance with us?

(1) We assume that the current way (update_cpu_power() calls
arch_scale_freq_power() to get the avg power(freq) over the time period
since the last call to arch_scale_freq_power()) is suitable
for us. Do you have another opinion here?

(2) Is the current layout of update_cpu_power() adequate for this, where
we scale power_orig related to freq and then related to rt/(irq):

  power_orig = scale_cpu(SCHED_POWER_SCALE)
  power = scale_rt(scale_freq(power_orig))

or do we need an extra power_freq data member on the rq and do:

  power_orig = scale_cpu(SCHED_POWER_SCALE)
  power_freq = scale_freq(power_orig))
  power = scale_rt(power_orig))

In other words, do we consider rt/(irq) pressure when calculating freq
scale invariant task load or not?

Thanks,

-- Dietmar
[...]
