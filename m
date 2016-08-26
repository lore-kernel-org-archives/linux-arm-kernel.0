From: punit.agrawal@arm.com (Punit Agrawal)
Date: Fri, 26 Aug 2016 15:54:04 +0100
Subject: [PATCH v7 7/9] arm: arm64: pmu: Assign platform PMU CPU affinity
References: <1471985280-2243-1-git-send-email-jeremy.linton@arm.com>
 <1471985280-2243-8-git-send-email-jeremy.linton@arm.com>
Message-ID: <87bn0foa2b.fsf@e105922-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Jeremy Linton <jeremy.linton@arm.com> writes:

> On systems with multiple PMU types the PMU to CPU affinity
> needs to be detected and set. The CPU to interrupt affinity
> should also be set.
>
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  drivers/perf/arm_pmu.c | 53 ++++++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 43 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
> index f1aee26..ee9e301 100644
> --- a/drivers/perf/arm_pmu.c
> +++ b/drivers/perf/arm_pmu.c

[...]

> @@ -876,25 +878,57 @@ static void cpu_pmu_destroy(struct arm_pmu *cpu_pmu)
>  }
>  
>  /*
> - * CPU PMU identification and probing.
> + * CPU PMU identification and probing. Its possible to have
> + * multiple CPU types in an ARM machine. Assure that we are
> + * picking the right PMU types based on the CPU in question
>   */
> -static int probe_current_pmu(struct arm_pmu *pmu,
> -			     const struct pmu_probe_info *info)
> +static int probe_plat_pmu(struct arm_pmu *pmu,
> +			     const struct pmu_probe_info *info,
> +			     unsigned int pmuid)
>  {
> -	int cpu = get_cpu();
> -	unsigned int cpuid = read_cpuid_id();
>  	int ret = -ENODEV;
> +	int cpu;
> +	int aff_ctr = 0;
> +	static int duplicate_pmus;
> +	struct platform_device *pdev = pmu->plat_device;
> +	int irq = platform_get_irq(pdev, 0);
> +
> +	if (irq >= 0 && !irq_is_percpu(irq)) {
> +		pmu->irq_affinity = kcalloc(pdev->num_resources, sizeof(int),
> +					    GFP_KERNEL);
> +		if (!pmu->irq_affinity)
> +			return -ENOMEM;
> +	}
>  
> -	pr_info("probing PMU on CPU %d\n", cpu);
> +	for_each_possible_cpu(cpu) {
> +		unsigned int cpuid = read_specific_cpuid(cpu);
>  
> +		if (cpuid == pmuid) {
> +			cpumask_set_cpu(cpu, &pmu->supported_cpus);
> +			if (pmu->irq_affinity) {
> +				pmu->irq_affinity[aff_ctr] = cpu;
> +				aff_ctr++;
> +			}
> +		}
> +	}
> +
> +	/* find the type of PMU given the CPU */
>  	for (; info->init != NULL; info++) {
> -		if ((cpuid & info->mask) != info->cpuid)
> +		if ((pmuid & info->mask) != info->cpuid)
>  			continue;
>  		ret = info->init(pmu);
> +		if ((!info->cpuid) && (duplicate_pmus)) {

It's not obvious what the condition "!info->cpuid" implies. Please add a
comment explaining the rationale.

Also, the parenthesis around the two parts of the logical operation can
be dropped.

> +			pmu->name = kasprintf(GFP_KERNEL, "%s_%d",
> +					    pmu->name, duplicate_pmus);
> +			if (!pmu->name) {
> +				kfree(pmu->irq_affinity);
> +				ret = -ENOMEM;
> +			}
> +		}
> +		duplicate_pmus++;
>  		break;
>  	}
>  
> -	put_cpu();
>  	return ret;
>  }
>  

[...]
