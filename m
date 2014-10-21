From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 21 Oct 2014 14:24:54 -0700
Subject: [PATCH 7/8] arm: perf: dynamically allocate cpu hardware data
In-Reply-To: <1413897084-19715-8-git-send-email-mark.rutland@arm.com>
References: <1413897084-19715-1-git-send-email-mark.rutland@arm.com>
 <1413897084-19715-8-git-send-email-mark.rutland@arm.com>
Message-ID: <5446CF26.8010102@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/21/2014 06:11 AM, Mark Rutland wrote:
> @@ -162,16 +160,22 @@ static int cpu_pmu_request_irq(struct arm_pmu *cpu_pmu, irq_handler_t handler)
>  	return 0;
>  }
>  
> -static void cpu_pmu_init(struct arm_pmu *cpu_pmu)
> +static int cpu_pmu_init(struct arm_pmu *cpu_pmu)
>  {
>  	int cpu;
> +	struct pmu_hw_events __percpu *cpu_hw_events;
> +
> +	cpu_hw_events = alloc_percpu(struct pmu_hw_events);

Shouldn't we free this somewhere?

> +	if (!cpu_hw_events)
> +		return -ENOMEM;
> +
>  	for_each_possible_cpu(cpu) {
> -		struct pmu_hw_events *events = &per_cpu(cpu_hw_events, cpu);
> +		struct pmu_hw_events *events = per_cpu_ptr(cpu_hw_events, cpu);
>  		raw_spin_lock_init(&events->pmu_lock);
>  		events->percpu_pmu = cpu_pmu;
>  	}
>  
> -	cpu_pmu->hw_events	= &cpu_hw_events;
> +	cpu_pmu->hw_events	= cpu_hw_events;
>  	cpu_pmu->request_irq	= cpu_pmu_request_irq;
>  	cpu_pmu->free_irq	= cpu_pmu_free_irq;
>  
> @@ -303,7 +309,10 @@ static int cpu_pmu_device_probe(struct platform_device *pdev)
>  		goto out_free;
>  	}
>  
> -	cpu_pmu_init(cpu_pmu);
> +	ret = cpu_pmu_init(cpu_pmu);
> +	if (ret)
> +		goto out_free;
> +
>  	ret = armpmu_register(cpu_pmu, -1);
>  
>  	if (!ret)

Especially if this fails?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
