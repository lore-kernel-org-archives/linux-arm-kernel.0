From: wxt@rock-chips.com (Caesar Wang)
Date: Fri, 01 Jul 2016 23:00:39 +0800
Subject: [PATCH] drivers/perf: arm-pmu: Handle per-interrupt affinity mask
In-Reply-To: <1467379291-18413-1-git-send-email-marc.zyngier@arm.com>
References: <1467379291-18413-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <57768597.2070606@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On 2016?07?01? 21:21, Marc Zyngier wrote:
> On a big-little system, PMUs can be wired to CPUs using per CPU
> interrups (PPI). In this case, it is important to make sure that
> the enable/disable do happen on the right set of CPUs.
>
> So instead of relying on the interrupt-affinity property, we can
> use the actual percpu affinity that DT exposes as part of the
> interrupt specifier. The DT binding is also updated to reflect
> the fact that the interrupt-affinity property shouldn't be used
> in that case.
>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Tested-by: Caesar Wang <wxt@rock-chips.com>

I pick this up on my local branch.
8bc671a FROMLIST: drivers/perf: arm-pmu: Handle per-interrupt affinity mask
3d723f4 FROMLIST: arm64: dts: rockchip: support the pmu node for rk3399
1359b92 FIXUP: FROMLIST: arm64: dts: rockchip: change all interrupts 
cells for 4 on rk3399 SoCs
...

Tested on rk3399 board.
localhost / # perf list

List of pre-defined events (to be used in -e):
cpu-cycles OR cycles [Hardware event]
instructions [Hardware event]
cache-references [Hardware event]
cache-misses [Hardware event]
branch-instructions OR branches [Hardware event]
branch-misses [Hardware event]
bus-cycles [Hardware event]
...

perf stat --cpu 0/1/2/3..... to minitor
e.g. cpu0;

localhost / # perf stat --cpu 0
^C
Performance counter stats for 'CPU(s) 0':

3374.917571 task-clock (msec) # 1.001 CPUs utilized [100.00%]
20 context-switches # 0.006 K/sec [100.00%]
2 cpu-migrations # 0.001 K/sec [100.00%]
55 page-faults # 0.016 K/sec
7151843 cycles # 0.002 GHz [100.00%]
<not supported> stalled-cycles-frontend
<not supported> stalled-cycles-backend
4272536 instructions # 0.60 insns per cycle [100.00%]
568406 branches # 0.168 M/sec [100.00%]
65652 branch-misses # 11.55% of all branches

Also, 'perf top' to monitor the PMU interrupts from cpus
---



> ---
>   Documentation/devicetree/bindings/arm/pmu.txt |  4 +++-
>   drivers/perf/arm_pmu.c                        | 22 +++++++++++++++++-----
>   2 files changed, 20 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/arm/pmu.txt b/Documentation/devicetree/bindings/arm/pmu.txt
> index 74d5417..61c8b46 100644
> --- a/Documentation/devicetree/bindings/arm/pmu.txt
> +++ b/Documentation/devicetree/bindings/arm/pmu.txt
> @@ -39,7 +39,9 @@ Optional properties:
>                          When using a PPI, specifies a list of phandles to CPU
>   		       nodes corresponding to the set of CPUs which have
>   		       a PMU of this type signalling the PPI listed in the
> -		       interrupts property.
> +		       interrupts property, unless this is already specified
> +		       by the PPI interrupt specifier itself (in which case
> +		       the interrupt-affinity property shouldn't be present).
>   
>                          This property should be present when there is more than
>   		       a single SPI.
> diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
> index 140436a..065ccec 100644
> --- a/drivers/perf/arm_pmu.c
> +++ b/drivers/perf/arm_pmu.c
> @@ -603,7 +603,8 @@ static void cpu_pmu_free_irq(struct arm_pmu *cpu_pmu)
>   
>   	irq = platform_get_irq(pmu_device, 0);
>   	if (irq >= 0 && irq_is_percpu(irq)) {
> -		on_each_cpu(cpu_pmu_disable_percpu_irq, &irq, 1);
> +		on_each_cpu_mask(&cpu_pmu->supported_cpus,
> +				 cpu_pmu_disable_percpu_irq, &irq, 1);
>   		free_percpu_irq(irq, &hw_events->percpu_pmu);
>   	} else {
>   		for (i = 0; i < irqs; ++i) {
> @@ -645,7 +646,9 @@ static int cpu_pmu_request_irq(struct arm_pmu *cpu_pmu, irq_handler_t handler)
>   				irq);
>   			return err;
>   		}
> -		on_each_cpu(cpu_pmu_enable_percpu_irq, &irq, 1);
> +
> +		on_each_cpu_mask(&cpu_pmu->supported_cpus,
> +				 cpu_pmu_enable_percpu_irq, &irq, 1);
>   	} else {
>   		for (i = 0; i < irqs; ++i) {
>   			int cpu = i;
> @@ -961,9 +964,18 @@ static int of_pmu_irq_cfg(struct arm_pmu *pmu)
>   		i++;
>   	} while (1);
>   
> -	/* If we didn't manage to parse anything, claim to support all CPUs */
> -	if (cpumask_weight(&pmu->supported_cpus) == 0)
> -		cpumask_setall(&pmu->supported_cpus);
> +	/* If we didn't manage to parse anything, try the interrupt affinity */
> +	if (cpumask_weight(&pmu->supported_cpus) == 0) {
> +		if (!using_spi) {
> +			/* If using PPIs, check the affinity of the partition */
> +			int irq = platform_get_irq(pdev, 0);
> +			irq_get_percpu_devid_partition(irq,
> +						       &pmu->supported_cpus);
> +		} else {
> +			/* Otherwise default to all CPUs */
> +			cpumask_setall(&pmu->supported_cpus);
> +		}
> +	}
>   
>   	/* If we matched up the IRQ affinities, use them to route the SPIs */
>   	if (using_spi && i == pdev->num_resources)

-- 
caesar wang | software engineer | wxt at rock-chip.com
