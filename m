From: punit.agrawal@arm.com (Punit Agrawal)
Date: Mon, 20 Jun 2016 17:40:52 +0100
Subject: [PATCH 5/8] arm: arm64: pmu: Assign platform PMU CPU affinity
In-Reply-To: <1465511013-10742-6-git-send-email-jeremy.linton@arm.com> (Jeremy
 Linton's message of "Thu, 9 Jun 2016 17:23:30 -0500")
References: <1465511013-10742-1-git-send-email-jeremy.linton@arm.com>
 <1465511013-10742-6-git-send-email-jeremy.linton@arm.com>
Message-ID: <87fus76cff.fsf@e105922-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jeremy Linton <jeremy.linton@arm.com> writes:

> On systems with multiple PMU types the PMU to CPU affinity
> needs to be detected and set. The CPU to interrupt affinity
> should also be set.
>

One comment below.

> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  drivers/perf/arm_pmu.c | 52 ++++++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 42 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
> index fee4be0e8..865a9db 100644
> --- a/drivers/perf/arm_pmu.c
> +++ b/drivers/perf/arm_pmu.c

[...]

> @@ -872,25 +874,56 @@ static void cpu_pmu_destroy(struct arm_pmu *cpu_pmu)
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
> +	struct platform_device *pdev = pmu->plat_device;
> +	int irq = platform_get_irq(pdev, 0);
>  
> -	pr_info("probing PMU on CPU %d\n", cpu);
> +	if (irq >= 0 && !irq_is_percpu(irq)) {
> +		pmu->irq_affinity = kcalloc(pdev->num_resources, sizeof(int),
> +					    GFP_KERNEL);
> +		if (!pmu->irq_affinity)
> +			return -ENOMEM;
> +	}
> +
> +	for_each_possible_cpu(cpu) {
> +		unsigned int cpuid = read_specific_cpuid(cpu);
> +
> +		if (cpuid == pmuid) {
> +			cpumask_set_cpu(cpu, &pmu->supported_cpus);
> +			pr_devel("enable pmu on cpu %d\n", cpu);
> +			if (pmu->irq_affinity) {

The check for irq_affinity can be dropped as you already do that earlier.

> +				pmu->irq_affinity[aff_ctr] = cpu;
> +				aff_ctr++;
> +			}
> +		}
> +	}
>  
> +	pr_debug("probing PMU %X\n", pmuid);
> +	/* find the type of PMU given the CPU */
>  	for (; info->init != NULL; info++) {
> -		if ((cpuid & info->mask) != info->cpuid)
> +		if ((pmuid & info->mask) != info->cpuid)
>  			continue;
> +		pr_devel("Found PMU\n");
>  		ret = info->init(pmu);
> +		if (!info->cpuid) {
> +			pmu->name = kasprintf(GFP_KERNEL, "%s_0x%x",
> +					    pmu->name, ARM_PARTNUM(pmuid));
> +			if (!pmu->name)
> +				return -ENOMEM;
> +		}
>  		break;
>  	}
>  
> -	put_cpu();
>  	return ret;
>  }
>  

[...]
