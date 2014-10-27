From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 27 Oct 2014 13:37:24 -0700
Subject: [PATCHv2 9/9] arm: perf: fold hotplug notifier into arm_pmu
In-Reply-To: <1414411599-1938-10-git-send-email-mark.rutland@arm.com>
References: <1414411599-1938-1-git-send-email-mark.rutland@arm.com>
 <1414411599-1938-10-git-send-email-mark.rutland@arm.com>
Message-ID: <544EAD04.8040703@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/27/2014 05:06 AM, Mark Rutland wrote:
> Handling multiple PMUs using a single hotplug notifier requires a list
> of PMUs to be maintained, with synchronisation in the probe, remove, and
> notify paths. This is error-prone and makes the code much harder to
> maintain.
>
> Instead of using a single notifier, we can dynamically allocate a
> notifier block per-PMU. The end result is the same, but the list of PMUs
> is implicit in the hotplug notifier list rather than within a perf-local
> data structure, which makes the code far easier to handle.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

One nit below.

> @@ -169,6 +192,11 @@ static int cpu_pmu_init(struct arm_pmu *cpu_pmu)
>  	if (!cpu_hw_events)
>  		return -ENOMEM;
>  
> +	cpu_pmu->hotplug_nb.notifier_call = cpu_pmu_notify;
> +	err = register_cpu_notifier(&cpu_pmu->hotplug_nb);
> +	if (err)
> +		goto out_hw_events;
> +
>  	for_each_possible_cpu(cpu) {
>  		struct pmu_hw_events *events = per_cpu_ptr(cpu_hw_events, cpu);
>  		raw_spin_lock_init(&events->pmu_lock);
> @@ -188,38 +216,19 @@ static int cpu_pmu_init(struct arm_pmu *cpu_pmu)
>  		cpu_pmu->pmu.capabilities |= PERF_PMU_CAP_NO_INTERRUPT;
>  
>  	return 0;
> +
> +out_hw_events:
> +	free_percpu(cpu_hw_events);
> +	return err;
>  }
>  
>  static void cpu_pmu_destroy(struct arm_pmu *cpu_pmu)
>  {
>  	free_percpu(cpu_pmu->hw_events);
> +	unregister_cpu_notifier(&cpu_pmu->hotplug_nb);
>  }
>

I would expect the order to be the other way, but it probably doesn't
matter all that much on the registration error path.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
