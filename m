From: will.deacon@arm.com (Will Deacon)
Date: Tue, 29 Nov 2016 10:52:55 +0000
Subject: [PATCH V10 4/6] arm: arm64: pmu: Assign platform PMU CPU affinity
In-Reply-To: <1478734793-6341-5-git-send-email-jeremy.linton@arm.com>
References: <1478734793-6341-1-git-send-email-jeremy.linton@arm.com>
 <1478734793-6341-5-git-send-email-jeremy.linton@arm.com>
Message-ID: <20161129105255.GD30283@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 09, 2016 at 05:39:51PM -0600, Jeremy Linton wrote:
> On systems with multiple PMU types the PMU to CPU affinity
> needs to be detected and set. The CPU to interrupt affinity
> should also be set.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  drivers/perf/arm_pmu.c | 63 ++++++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 53 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
> index b37b572..6008be9 100644
> --- a/drivers/perf/arm_pmu.c
> +++ b/drivers/perf/arm_pmu.c
> @@ -11,6 +11,7 @@
>   */
>  #define pr_fmt(fmt) "hw perfevents: " fmt
>  
> +#include <linux/acpi.h>
>  #include <linux/bitmap.h>
>  #include <linux/cpumask.h>
>  #include <linux/cpu_pm.h>
> @@ -24,6 +25,7 @@
>  #include <linux/irq.h>
>  #include <linux/irqdesc.h>
>  
> +#include <asm/cpu.h>
>  #include <asm/cputype.h>
>  #include <asm/irq_regs.h>
>  
> @@ -889,25 +891,67 @@ static void cpu_pmu_destroy(struct arm_pmu *cpu_pmu)
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
>  
> -	pr_info("probing PMU on CPU %d\n", cpu);
> +	if (irq >= 0 && !irq_is_percpu(irq)) {
> +		pmu->irq_affinity = kcalloc(pdev->num_resources, sizeof(int),
> +					    GFP_KERNEL);
> +		if (!pmu->irq_affinity)
> +			return -ENOMEM;
> +	}
>  
> +	for_each_possible_cpu(cpu) {
> +		unsigned int cpuid = read_specific_cpuid(cpu);
> +
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
> +		/*
> +		 * if this pmu declaration is unspecified and we have
> +		 * previously found a PMU on this platform then append
> +		 * a PMU number to the pmu name. This avoids changing
> +		 * the names of PMUs that are specific to a class of CPUs.
> +		 * The assumption is that if we match a specific PMU in the
> +		 * provided pmu_probe_info then it's unique, and another PMU
> +		 * in the system will match a different entry rather than
> +		 * needing the _number to assure its unique.
> +		 */
> +		if ((!info->cpuid) && (duplicate_pmus)) {

This is a bit grim: if you had a PMU with a non-zero info->cpuid, then you
later found a PMU with a zeroed info->cpuid, the latter would get a
redundant suffix. This doesn't happen in reality, because the ACPI case
always has info->cpuid == 0, but if somebody extends armv8_pmu_probe_table
then we'd get this and probably not realise.

I think the duplicate_pmus counter needs to be tied explicitly to the
"default type" (i.e. when info->cpuid == 0, but see my next comment).

> +			pmu->name = kasprintf(GFP_KERNEL, "%s_%d",
> +					    pmu->name, duplicate_pmus);
> +			if (!pmu->name) {
> +				kfree(pmu->irq_affinity);
> +				ret = -ENOMEM;
> +			}
> +		}

This code doesn't run for the device-tree probing case, but I think it would
be useful to do the same numbering trick for e.g. systems with multiple PMUs
that all end up matching on armv8_pmuv3.

Will
